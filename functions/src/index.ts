// function/src/index.ts

import * as functions from "firebase-functions/v2";
import * as admin from "firebase-admin";
import { onDocumentCreated, onDocumentUpdated } from "firebase-functions/v2/firestore";
import { ImageAnnotatorClient } from "@google-cloud/vision";
import { onObjectFinalized } from "firebase-functions/v2/storage";
import { onSchedule } from "firebase-functions/v2/scheduler";
import axios from "axios";
import { GoogleAuth } from "google-auth-library";
import { Response } from "express";
import { onCall, HttpsError } from "firebase-functions/v2/https";
import { getLocalizedPayload } from "./localization";
import * as jose from "node-jose";

// =================================================================
// === KHỞI TẠO CÁC DỊCH VỤ CƠ BẢN ===
// =================================================================
admin.initializeApp();
const firestore = admin.firestore();

const PRODUCT_PRICES: { [key: string]: number } = {
  'gold_1_month': 78,
  'gold_12_months': 460,
  'forex_1_month': 78,
  'forex_12_months': 460,
  'crypto_1_month': 78,
  'crypto_12_months': 460,
  'gold.1.month': 78,
  'gold.12.months': 460,
  'forex.1.month': 78,
  'forex.12.months': 460,
  'crypto.1.month': 78,
  'crypto.12.months': 460,
};

const APPLE_VERIFY_RECEIPT_URL_PRODUCTION = "https://buy.itunes.apple.com/verifyReceipt";
const APPLE_VERIFY_RECEIPT_URL_SANDBOX = "https://sandbox.itunes.apple.com/verifyReceipt";

// =================================================================
// === FUNCTION XỬ LÝ ẢNH XÁC THỰC EXNESS ===
// =================================================================
export const processVerificationImage = onObjectFinalized(
  { region: "asia-southeast1", cpu: 2, memory: "1GiB" },
  async (event) => {
    // ... (Toàn bộ logic xử lý ảnh không thay đổi)
    const visionClient = new ImageAnnotatorClient();
    const fileBucket = event.data.bucket;
    const filePath = event.data.name;
    const contentType = event.data.contentType;

    if (!filePath || !filePath.startsWith("verification_images/")) {
      functions.logger.log(`Bỏ qua file không liên quan: ${filePath}`);
      return null;
    }
    if (!contentType || !contentType.startsWith("image/")) {
      functions.logger.log(`Bỏ qua file không phải ảnh: ${contentType}`);
      return null;
    }

    const userId = filePath.split("/")[1].split(".")[0];
    functions.logger.log(`Bắt đầu xử lý ảnh cho user: ${userId}`);

    const userRef = firestore.collection("users").doc(userId);

    try {
      await userRef.update({
        verificationStatus: admin.firestore.FieldValue.delete(),
        verificationError: admin.firestore.FieldValue.delete(),
      });

      const [result] = await visionClient.textDetection(
        `gs://${fileBucket}/${filePath}`
      );
      const fullText = result.fullTextAnnotation?.text;

      if (!fullText) {
        throw new Error("Không đọc được văn bản nào từ ảnh.");
      }
      functions.logger.log("Văn bản đọc được:", fullText);

      const balanceRegex = /(\d{1,3}(?:[.,]\d{3})*[.,]\d{2})(?:\s*USD)?/;
      const idRegex = /#\s*(\d{7,})/; // Regex for Exness ID

      const balanceMatch = fullText.match(balanceRegex);
      const idMatch = fullText.match(idRegex);

      if (!balanceMatch || !idMatch) {
        throw new Error("Không tìm thấy đủ thông tin Số dư và ID trong ảnh.");
      }
      let balanceString = balanceMatch[1];
      const isCommaDecimal = balanceString.lastIndexOf(',') > balanceString.lastIndexOf('.');

      if (isCommaDecimal) {
        balanceString = balanceString.replace(/\./g, "").replace(',', '.');
      } else {
        balanceString = balanceString.replace(/,/g, "");
      }

      const balance = parseFloat(balanceString);

      const exnessId = idMatch[1];
      functions.logger.log(`Tìm thấy - Số dư: ${balance}, ID Exness: ${exnessId}`);

      const idDoc = await firestore
        .collection("verifiedExnessIds")
        .doc(exnessId).get();

      if (idDoc.exists) {
        throw new Error(`ID Exness ${exnessId} đã được sử dụng.`);
      }

      let tier = "demo";
      if (balance >= 500) {
        tier = "elite";
      } else if (balance >= 200) {
        tier = "vip";
      }
      functions.logger.log(`Phân quyền cho user ${userId}: ${tier}`);

      const idRef = firestore.collection("verifiedExnessIds").doc(exnessId);
      const updateData = {
        subscriptionTier: tier,
        verificationStatus: "success",
        exnessClientAccount: exnessId,
        exnessBalance: balance,
        verifiedAt: admin.firestore.FieldValue.serverTimestamp(),
        notificationCount: 0,
      };

      await Promise.all([
        userRef.set(updateData, { merge: true }),
        idRef.set({ userId: userId, processedAt: admin.firestore.FieldValue.serverTimestamp() }),
      ]);

      functions.logger.log("Hoàn tất phân quyền và lưu dữ liệu Exness thành công!");
      return null;
    } catch (error) {
      const errorMessage = (error as Error).message;
      functions.logger.error(`Xử lý ảnh thất bại cho user ${userId}:`, errorMessage);

      await userRef.set(
        { verificationStatus: "failed", verificationError: errorMessage },
        { merge: true }
      );
      return null;
    }
  });

// =================================================================
// === FUNCTION WEBHOOK CHO TELEGRAM BOT ===
// =================================================================
const TELEGRAM_CHAT_ID = "-1002785712406";
const TELEGRAM_BITCOIN_CHAT_ID = "-1003419694521";

export const telegramWebhook = functions.https.onRequest(
  { region: "asia-southeast1", timeoutSeconds: 30, memory: "512MiB" },
  async (req: functions.https.Request, res: Response) => {
    // ... (Toàn bộ logic Telegram không thay đổi)
    if (req.method !== "POST") {
      res.status(403).send("Forbidden!");
      return;
    }
    const update = req.body;
    const message = update.message || update.channel_post;
    if (!message || (message.chat.id.toString() !== TELEGRAM_CHAT_ID && message.chat.id.toString() !== TELEGRAM_BITCOIN_CHAT_ID)) {
      functions.logger.log(`Bỏ qua tin nhắn từ chat ID không xác định: ${message?.chat.id}`);
      res.status(200).send("OK");
      return;
    }
    try {
      if (message.reply_to_message && message.text) {
        const originalMessageId = message.reply_to_message.message_id;
        const updateText = message.text.toLowerCase();
        const signalQuery = await firestore.collection("signals").where("telegramMessageId", "==", originalMessageId).limit(1).get();
        if (signalQuery.empty) {
          res.status(200).send("OK. No original signal found.");
          return;
        }
        const signalDoc = signalQuery.docs[0];
        const signalRef = signalDoc.ref;
        let updatePayload: any = {};
        let logMessage = "";

        // Logic parse giá đóng lệnh và pips từ tin nhắn reply
        // Hỗ trợ các mẫu English mới & Vietnamese cũ:
        // 1. "Price: 5264.0 (+50.0p)"
        // 2. "Exit at price 4960.46 (+19.6p)"
        // 3. "This signal has hit entry at price 5262.23"
        // 4. "Giá: 1234.5 (+20p)" (Old VI)
        const priceRegex = /(?:Price:|Exit at price|entry at price|Giá|Close tại giá).*?\s*([\d.,]+)(?:\s*\(([+-]?[\d.,]+)p\))?/i;
        const priceMatch = updateText.match(priceRegex);

        if (priceMatch) {
            const parsedPrice = parseFloat(priceMatch[1].replace(/,/g, '')); // Loại bỏ dấu phẩy nếu có
            if (priceMatch[2]) {
                const parsedPips = parseFloat(priceMatch[2].replace(/,/g, ''));
                updatePayload.closedPrice = parsedPrice;
                updatePayload.closedPips = parsedPips;
                updatePayload.pips = parsedPips; // Cập nhật trường pips chính để tính toán thống kê
            }
        }

        if (updateText.includes("hit entry at price") || updateText.includes("đã khớp entry tại giá")) {
          updatePayload = { ...updatePayload, isMatched: true, result: "Matched", matchedAt: admin.firestore.FieldValue.serverTimestamp() };
          logMessage = `Tín hiệu ${signalDoc.id} đã KHỚP LỆNH (MATCHED).`;
        } else if (updateText.includes("tp1 hit")) {
            updatePayload = { ...updatePayload, result: "TP1 Hit", hitTps: admin.firestore.FieldValue.arrayUnion(1) };
            logMessage = `Tín hiệu ${signalDoc.id} đã TP1 Hit.`;
        } else if (updateText.includes("tp2 hit")) {
            updatePayload = { ...updatePayload, result: "TP2 Hit", hitTps: admin.firestore.FieldValue.arrayUnion(1, 2) };
            logMessage = `Tín hiệu ${signalDoc.id} đã TP2 Hit.`;
        } else if (updateText.includes("sl hit")) {
            updatePayload = { ...updatePayload, status: "closed", result: "SL Hit", closedAt: admin.firestore.FieldValue.serverTimestamp() };
            logMessage = `Tín hiệu ${signalDoc.id} đã SL Hit.`;
        } else if (updateText.includes("tp3 hit")) {
            updatePayload = { ...updatePayload, status: "closed", result: "TP3 Hit", hitTps: admin.firestore.FieldValue.arrayUnion(1, 2, 3), closedAt: admin.firestore.FieldValue.serverTimestamp() };
            logMessage = `Tín hiệu ${signalDoc.id} đã TP3 Hit.`;
        } else if (updateText.includes("exit at price") || updateText.includes("exit lệnh") || updateText.includes("exit tại giá")) {
            updatePayload = { ...updatePayload, status: "closed", result: "Exited by Admin", closedAt: admin.firestore.FieldValue.serverTimestamp() };
            logMessage = `Tín hiệu ${signalDoc.id} đã được đóng bởi admin.`;
        } else if (updateText.includes("cancel:") || updateText.includes("bỏ tín hiệu") || updateText.includes("canceled")) {
            updatePayload = { ...updatePayload, status: "closed", result: "Cancelled", closedAt: admin.firestore.FieldValue.serverTimestamp() };
            logMessage = `Tín hiệu ${signalDoc.id} đã bị hủy.`;
        }

        // Logic xử lý tin nhắn Giải thích (Reply)
        const reasonRegex = /===\s*(?:GIẢI\s*THÍCH|EXPLANATION)\s*===/i;
        const reasonMatch = message.text.match(reasonRegex); // Dùng message.text gốc để giữ format
        if (reasonMatch && reasonMatch.index !== undefined) {
            const reasonContent = message.text.substring(reasonMatch.index + reasonMatch[0].length).trim();
            if (reasonContent) {
                // Mặc định tất cả các ngôn ngữ là nội dung gốc (Tiếng Anh)
                updatePayload.reason = {
                    vi: reasonContent,
                    en: reasonContent
                };
                logMessage = logMessage ? `${logMessage} & Đã cập nhật Lý do.` : `Tín hiệu ${signalDoc.id} đã cập nhật Lý do.`;
            }
        }

        if (Object.keys(updatePayload).length > 0) {
          await signalRef.update(updatePayload);
          functions.logger.log(logMessage);
        }
      } else if (message.text) {
        const signalData = parseSignalMessage(message.text);
        if (signalData) {
          if (signalData.reason) {
            // Mặc định tất cả các ngôn ngữ là nội dung gốc (Tiếng Anh)
            signalData.reason = {
              vi: signalData.reason,
              en: signalData.reason,
            };
          }

          const batch = firestore.batch();
          // Chỉ đóng các lệnh "Running" + "Not Matched" CÙNG CẶP TIỀN
          const unmatchedQuery = await firestore.collection("signals")
            .where("status", "==", "running")
            .where("isMatched", "==", false)
            .where("symbol", "==", signalData.symbol)
            .get();
            
          unmatchedQuery.forEach(doc => batch.update(doc.ref, { status: "closed", result: "Cancelled (new signal)" }));

          const oppositeType = signalData.type === 'buy' ? 'sell' : 'buy';
          // Chỉ đóng các lệnh "Running" + "TP Hit" ngược chiều CÙNG CẶP TIỀN
          const runningTpQuery = await firestore.collection("signals")
            .where("status", "==", "running")
            .where("type", "==", oppositeType)
            .where("result", "in", ["TP1 Hit", "TP2 Hit"])
            .where("symbol", "==", signalData.symbol)
            .get();
            
          runningTpQuery.forEach(doc => batch.update(doc.ref, { status: "closed", result: "Exited (new signal)" }));

          const newSignalRef = firestore.collection("signals").doc();
          batch.set(newSignalRef, {
            ...signalData,
            telegramMessageId: message.message_id,
            createdAt: admin.firestore.Timestamp.fromMillis(message.date * 1000),
            status: "running",
            isMatched: false,
            result: "Not Matched",
            hitTps: [],
          });
          await batch.commit();
        }
      }
      res.status(200).send("OK");
    } catch (error) {
      functions.logger.error("Lỗi nghiêm trọng khi xử lý tin nhắn Telegram:", error);
      res.status(500).send("Internal Server Error");
    }
  }
);

function parseSignalMessage(text: string): any | null {
    const signal: any = { takeProfits: [] };
    
    // Sử dụng Regex để tìm phần giải thích (không phân biệt hoa thường, hỗ trợ cả Tiếng Việt và Anh)
    const reasonRegex = /===\s*(?:GIẢI\s*THÍCH|EXPLANATION)\s*===/i;
    const match = text.match(reasonRegex);
    
    const signalPart = match ? text.split(match[0])[0] : text;
    if (!signalPart) return null;
    
    const lines = signalPart.split("\n");
    // Tìm dòng tiêu đề (Hỗ trợ "Tín hiệu:" hoặc "Signal:")
    const titleLine = lines.find((line) => line.includes("Tín hiệu:") || line.includes("Signal:"));
    if (!titleLine) return null;
    
    // 1. Parse Type
    if (titleLine.toUpperCase().includes("BUY")) signal.type = "buy";
    else if (titleLine.toUpperCase().includes("SELL")) signal.type = "sell";
    else return null;

    // 2. Parse Symbol (Improved for Crypto)
    const symbolRegex = /\b([A-Z]{3}\/[A-Z]{3}|XAU\/USD)\b/i;
    const symbolMatch = titleLine.match(symbolRegex);
    
    if (symbolMatch) {
        signal.symbol = symbolMatch[0].toUpperCase();
    } else {
        const words = titleLine.trim().split(/\s+/);
        if (words.length > 0) {
            const lastWord = words[words.length - 1].toUpperCase();
            const keywords = ["BUY", "SELL", "LIMIT", "STOP", "NOW", "TÍN", "HIỆU", ":", "SIGNAL"];
            if (!keywords.includes(lastWord.toUpperCase()) && lastWord.length >= 3) {
                 signal.symbol = lastWord.toUpperCase();
            }
        }
        if (!signal.symbol) signal.symbol = "XAU/USD";
    }

    if (signal.symbol && !signal.symbol.includes('/')) {
        if (signal.symbol.endsWith('USDT')) {
            signal.symbol = signal.symbol.replace('USDT', '/USDT');
        } else if (signal.symbol.endsWith('USD') && signal.symbol !== 'XAUUSD') {
             signal.symbol = signal.symbol.replace('USD', '/USD');
        } else if (signal.symbol === 'XAUUSD') {
             signal.symbol = 'XAU/USD';
        }
    }

    // 4. Parse Entry, SL, TP
    for (const line of lines) {
        const entryRegex = /Entry:.*?([\d.]+)/;
        const entryMatch = line.match(entryRegex);
        if (entryMatch) signal.entryPrice = parseFloat(entryMatch[1]);
        
        const slRegex = /SL:.*?([\d.]+)/;
        const slMatch = line.match(slRegex);
        if (slMatch) signal.stopLoss = parseFloat(slMatch[1]);
        
        const tpRegex = /TP\d*:.*?([\d.]+)/g;
        let tpMatch;
        while ((tpMatch = tpRegex.exec(line)) !== null) {
            signal.takeProfits.push(parseFloat(tpMatch[1]));
        }

        const leverageRegex = /(?:Đòn bẩy|Leverage):\s*(x\d+)/i;
        const leverageMatch = line.match(leverageRegex);
        if (leverageMatch) {
            signal.leverage = leverageMatch[1];
        }
    }

    // Lấy phần nội dung giải thích nếu có
    if (match && match.index !== undefined) {
        const reasonPart = text.substring(match.index + match[0].length);
        if (reasonPart && reasonPart.trim().length > 0) {
            signal.reason = reasonPart.trim();
        }
    }
    
    if (signal.type && signal.symbol && signal.entryPrice && signal.stopLoss && signal.takeProfits.length > 0) {
        return signal;
    }
    return null;
}

// =================================================================
// === FUNCTION XÁC THỰC GIAO DỊCH IN-APP PURCHASE ===
// =================================================================
export const verifyPurchase = onCall(
    { region: "asia-southeast1", secrets: ["APPLE_SHARED_SECRET"] },
    async (request) => {
        const { productId, transactionData, platform } = request.data;
        const userId = request.auth?.uid;

        if (!userId) throw new HttpsError("unauthenticated", "Người dùng chưa đăng nhập.");
        if (!productId || !transactionData || !platform) throw new HttpsError("invalid-argument", "Thiếu thông tin cần thiết.");

        try {
            let isValid = false;
            let expiryDate: Date | null = null;
            let transactionId: string | null = null;
            let verifiedProductId = productId;

            if (platform === 'ios') {
                const receipt = transactionData.receiptData;
                if (receipt.startsWith("ey")) {
                    const jwsResult = await verifyAppleJwsReceipt(receipt);
                    isValid = jwsResult.isValid;
                    expiryDate = jwsResult.expiryDate;
                    transactionId = jwsResult.transactionId;
                    verifiedProductId = jwsResult.productId;
                } else {
                    const sharedSecret = process.env.APPLE_SHARED_SECRET;
                    if (!sharedSecret) throw new HttpsError("internal", "Lỗi cấu hình phía server.");
                    const appleResponse = await verifyAppleLegacyReceipt(receipt, sharedSecret);
                    if (appleResponse.status !== 0) throw new Error(`Xác thực biên lai thất bại với mã trạng thái: ${appleResponse.status}`);
                    const latestReceipt = appleResponse.latest_receipt_info?.sort((a: any, b: any) => Number(b.purchase_date_ms) - Number(a.purchase_date_ms))[0];
                    if (latestReceipt && latestReceipt.product_id === productId) {
                        isValid = true;
                        expiryDate = new Date(Number(latestReceipt.expires_date_ms));
                        transactionId = latestReceipt.transaction_id;
                    }
                }
            } else if (platform === 'android') {
                const { purchaseToken } = transactionData;
                const packageName = "com.minvest.aisignals";
                const auth = new GoogleAuth({ scopes: "https://www.googleapis.com/auth/androidpublisher" });
                const authClient = await auth.getClient();
                const url = `https://androidpublisher.googleapis.com/androidpublisher/v3/applications/${packageName}/purchases/products/${productId}/tokens/${purchaseToken}`;
                const res = await authClient.request({ url });
                const purchase = res.data as any;
                if (purchase && purchase.purchaseState === 0) {
                    isValid = true;
                    expiryDate = new Date(Number(purchase.expiryTimeMillis));
                    transactionId = purchase.orderId;
                }
            }

            if (isValid && expiryDate && transactionId) {
                const userRef = firestore.collection("users").doc(userId);
                const processedTxRef = firestore.collection("processedTransactions").doc(transactionId);

                await firestore.runTransaction(async (transaction) => {
                    const processedDoc = await transaction.get(processedTxRef);
                    if (processedDoc.exists) {
                        functions.logger.warn(`Giao dịch ${transactionId} đã được xử lý trong một transaction khác. Bỏ qua.`);
                        return;
                    }
                    const amountPaid = PRODUCT_PRICES[verifiedProductId] ?? 0;
                    const userTransactionRef = userRef.collection("transactions").doc(transactionId!);
                    
                    // 1. Lấy dữ liệu user để kiểm tra affiliate
                    const userDoc = await transaction.get(userRef);
                    const userData = userDoc.data();
                    const affiliateId = userData?.referred_by_affiliate_id;

                    // Xác định loại gói dựa trên productId
                    let packageType: string | null = null;
                    if (verifiedProductId.includes('gold')) packageType = 'gold';
                    else if (verifiedProductId.includes('forex')) packageType = 'forex';
                    else if (verifiedProductId.includes('crypto')) packageType = 'crypto';

                    const updateData: any = {
                        totalPaidAmount: admin.firestore.FieldValue.increment(amountPaid),
                    };

                    if (packageType) {
                        // Thêm vào mảng activeSubscriptions
                        updateData.activeSubscriptions = admin.firestore.FieldValue.arrayUnion(packageType);
                        // Cập nhật ngày hết hạn cho gói cụ thể
                        updateData[`subscriptionsExpiry.${packageType}`] = admin.firestore.Timestamp.fromDate(expiryDate!);
                        updateData[`subscriptionsStart.${packageType}`] = admin.firestore.FieldValue.serverTimestamp();
                    }

                    transaction.set(userRef, updateData, { merge: true });
                    
                    // 2. Xử lý hoa hồng nếu có Affiliate
                    if (affiliateId && amountPaid > 0) {
                        const affiliateRef = firestore.collection("affiliates").doc(affiliateId);
                        const affiliateDoc = await transaction.get(affiliateRef);
                        
                        if (affiliateDoc.exists) {
                            const affData = affiliateDoc.data();
                            const rate = affData?.commissionRate || 40;
                            const commissionAmount = Math.round(amountPaid * (rate / 100) * 100) / 100;

                            // Tạo bản ghi hoa hồng
                            const commissionRef = firestore.collection("commissions").doc();
                            transaction.set(commissionRef, {
                                affiliateId: affiliateId,
                                affiliateCode: affData?.code || '---',
                                userId: userId,
                                userEmail: userData?.email || '---',
                                productId: verifiedProductId,
                                invoiceAmount: amountPaid,
                                commissionRate: rate,
                                commissionAmount: commissionAmount,
                                status: 'pending',
                                createdAt: admin.firestore.FieldValue.serverTimestamp(),
                                transactionId: transactionId
                            });

                            // Cập nhật thu nhập cho đối tác (chưa cộng vào totalEarnings cho đến khi paid, hoặc cộng ngay tùy business model)
                            // Ở đây ta cộng vào totalEarnings để đối tác thấy con số tăng lên
                            transaction.update(affiliateRef, {
                                totalEarnings: admin.firestore.FieldValue.increment(commissionAmount),
                                updatedAt: admin.firestore.FieldValue.serverTimestamp()
                            });
                        }
                    }

                    transaction.set(userTransactionRef, {
                        amount: amountPaid,
                        productId: verifiedProductId,
                        paymentMethod: `in_app_purchase_${platform}`,
                        transactionDate: admin.firestore.FieldValue.serverTimestamp(),
                    });
                    transaction.set(processedTxRef, {
                        userId,
                        processedAt: admin.firestore.FieldValue.serverTimestamp()
                    });

                    // ▼▼▼ THÊM THÔNG BÁO THÀNH CÔNG ▼▼▼
                    const notifRef = userRef.collection("notifications").doc();
                    const notifData = {
                        type: "subscription_success",
                        title_loc: {
                            en: "Subscription Successful",
                            vi: "Subscription Successful",
                        },
                        body_loc: {
                            en: "You have successfully upgraded your account.",
                            vi: "You have successfully upgraded your account.",
                        },
                        timestamp: admin.firestore.FieldValue.serverTimestamp(),
                        isRead: false,
                    };
                    transaction.set(notifRef, notifData);
                    // ▲▲▲ KẾT THÚC THÊM ▼▼▼
                });
                functions.logger.log(`Giao dịch ${transactionId} đã được xử lý thành công.`);
                return { success: true, message: "Tài khoản đã được nâng cấp thành công." };
            } else {
                throw new HttpsError("aborted", "Giao dịch không hợp lệ hoặc đã bị hủy.");
            }
        } catch (error: any) {
            functions.logger.error("Lỗi nghiêm trọng khi xác thực giao dịch:", error);
            if (error instanceof HttpsError) throw error;
            throw new HttpsError("internal", "Đã xảy ra lỗi trong quá trình xác thực.", error.message);
        }
    }
);

async function verifyAppleJwsReceipt(jwsRepresentation: string) {
    functions.logger.log("🍎 JWS: Bắt đầu xác thực biên lai kiểu mới...");
    try {
        // 1. Giải mã header để lấy chuỗi chứng thực (x5c)
        const header = JSON.parse(Buffer.from(jwsRepresentation.split('.')[0], 'base64').toString('utf8'));
        const x5c = header.x5c;
        if (!x5c || x5c.length === 0) {
            throw new Error("Không tìm thấy chuỗi chứng thực (x5c) trong header của JWS.");
        }

        // --- THAY ĐỔI QUAN TRỌNG: THÊM TẤT CẢ CHỨNG THỰC VÀO KEYSTORE ---
        const keystore = jose.JWK.createKeyStore();
        for (const certStr of x5c) {
            const cert = `-----BEGIN CERTIFICATE-----\n${certStr}\n-----END CERTIFICATE-----`;
            const key = await jose.JWK.asKey(cert, 'pem');
            await keystore.add(key);
        }
        // --- KẾT THÚC THAY ĐỔI ---

        // 3. Xác thực chữ ký của JWS bằng keystore đã chứa đầy đủ chứng thực
        const verificationResult = await jose.JWS.createVerify(keystore).verify(jwsRepresentation);

        // 4. Lấy payload sau khi đã xác thực thành công
        const verifiedPayload = JSON.parse(Buffer.from(verificationResult.payload).toString());
        functions.logger.log("   JWS: Payload đã xác thực:", verifiedPayload);

        // 5. Kiểm tra các thông tin quan trọng trong payload
        const bundleId = "com.minvest.aisignals"; // !!! QUAN TRỌNG: Đảm bảo đây là Bundle ID chính xác của bạn
        if (verifiedPayload.bundleId !== bundleId) {
            throw new Error(`Bundle ID không khớp. Mong muốn: ${bundleId}, Thực tế: ${verifiedPayload.bundleId}`);
        }

        functions.logger.log("   JWS: Xác thực chữ ký và Bundle ID thành công!");

        // Trả về thông tin cần thiết để xử lý
        return {
            isValid: true,
            productId: verifiedPayload.productId,
            transactionId: verifiedPayload.transactionId,
            expiryDate: new Date(verifiedPayload.expiresDate),
        };
    } catch (error) {
        functions.logger.error("🔥 JWS: Lỗi nghiêm trọng khi xác thực JWS:", error);
        throw new Error("Xác thực biên lai JWS thất bại.");
    }
}

async function verifyAppleLegacyReceipt(receiptData: string, sharedSecret: string): Promise<any> {
    functions.logger.log("Legacy: Bắt đầu xác thực biên lai kiểu cũ...");
    // Nội dung hàm này giữ nguyên từ file gốc của bạn, chỉ đổi tên
    const body = { "receipt-data": receiptData, "password": sharedSecret, "exclude-old-transactions": true };
    try {
        const response = await axios.post(APPLE_VERIFY_RECEIPT_URL_PRODUCTION, body);
        const data = response.data;
        if (data.status === 21007) {
            const sandboxResponse = await axios.post(APPLE_VERIFY_RECEIPT_URL_SANDBOX, body);
            return sandboxResponse.data;
        }
        return data;
    } catch (error) {
        functions.logger.error("Legacy: Lỗi khi gọi API xác thực của Apple:", error);
        throw new HttpsError("internal", "Không thể kết nối đến server của Apple.");
    }
}

// =================================================================
// === HỆ THỐNG GỬI THÔNG BÁO ===
// =================================================================
function isGoldenHour(): boolean {
  const now = new Date();
  const vietnamTime = new Date(now.toLocaleString("en-US", { timeZone: "Asia/Ho_Chi_Minh" }));
  const hour = vietnamTime.getHours();
  return hour >= 8 && hour < 17;
}

const sendAndStoreNotifications = async (
    usersData: { id: string; token?: string; lang: string }[],
    payload: any
) => {
    functions.logger.log(`[sendAndStoreNotifications] Chuẩn bị gửi đến ${usersData.length} người dùng.`);
    if (usersData.length === 0) return;

    // Logic lưu thông báo vào subcollection (giữ nguyên)
    const batchStore = firestore.batch();
    const notificationData = { ...payload, timestamp: admin.firestore.FieldValue.serverTimestamp(), isRead: false };
    usersData.forEach((user) => {
        const notificationRef = firestore.collection("users").doc(user.id).collection("notifications").doc();
        batchStore.set(notificationRef, notificationData);
    });

    // ▼▼▼ PHẦN THAY ĐỔI BẮT ĐẦU TỪ ĐÂY ▼▼▼

    const messages: admin.messaging.Message[] = [];
    usersData.forEach((user) => {
        if (user.token) {
            const lang = user.lang;
            // Lấy nội dung theo ngôn ngữ của user, fallback về EN rồi về VI nếu thiếu
            const title = payload.title_loc[lang] || payload.title_loc['en'] || payload.title_loc['vi'];
            const body = payload.body_loc[lang] || payload.body_loc['en'] || payload.body_loc['vi'];

            const dataPayload: { [key: string]: string } = {
                type: payload.type,
                signalId: payload.signalId,
                // Không cần gửi title/body trong data nữa vì nó đã có trong notification
            };

            messages.push({
                token: user.token,
                // 1. Gói tin cho hệ điều hành hiển thị
                notification: {
                    title: title,
                    body: body,
                },
                // 2. Dữ liệu bổ sung cho ứng dụng xử lý khi người dùng nhấn vào
                data: dataPayload,
                android: {
                    priority: "high",
                    notification: {
                      channelId: "minvest_channel_id", // Thêm channelId cho Android
                    }
                },
                apns: {
                    headers: {
                        "apns-priority": "10",
                    },
                    payload: {
                        aps: {
                            sound: "default", // Thêm âm thanh cho iOS
                            badge: 1,         // Cập nhật biểu tượng số trên icon app
                        },
                    },
                },
            });
        }
    });

    // ▼▼▼ KẾT THÚC PHẦN THAY ĐỔI ▼▼▼

    if (messages.length > 0) {
        functions.logger.log(`[sendAndStoreNotifications] Đang gửi ${messages.length} tin nhắn...`);
        const response = await admin.messaging().sendEach(messages);
        functions.logger.log(`[sendAndStoreNotifications] Gửi hoàn tất! Thành công: ${response.successCount}, Thất bại: ${response.failureCount}`);

        if (response.failureCount > 0) {
            response.responses.forEach((resp, idx) => {
                if (!resp.success) {
                    functions.logger.error(`[sendAndStoreNotifications] Lỗi gửi đến user ${usersData[idx].id}:`, resp.error);
                }
            });
        }
    }

    await batchStore.commit();
    functions.logger.log(`[sendAndStoreNotifications] Đã lưu ${usersData.length} thông báo vào Firestore.`);
};

async function triggerNotifications(payload: any) {
  functions.logger.log("[triggerNotifications] Bắt đầu trigger với payload:", payload);
  const isGolden = isGoldenHour();
  const allEligibleUsersDocs: admin.firestore.DocumentSnapshot[] = [];

  const eliteQuery = firestore.collection("users").where("subscriptionTier", "==", "elite").get();
  const timeRestrictedPromises: Promise<admin.firestore.QuerySnapshot>[] = [];

  if (isGolden) {
      functions.logger.log("[triggerNotifications] Đang trong giờ vàng, lấy thêm user VIP và DEMO.");
      const vipQuery = firestore.collection("users").where("subscriptionTier", "==", "vip").get();
      const demoQuery = firestore.collection("users").where("subscriptionTier", "==", "demo").where("notificationCount", "<", 8).get();
      timeRestrictedPromises.push(vipQuery, demoQuery);
  }

  const [eliteSnapshot, ...timeRestrictedSnapshots] = await Promise.all([eliteQuery, ...timeRestrictedPromises]);
  eliteSnapshot.forEach((doc) => allEligibleUsersDocs.push(doc));
  timeRestrictedSnapshots.forEach((snapshot) => snapshot.forEach((doc) => allEligibleUsersDocs.push(doc)));

  if (allEligibleUsersDocs.length === 0) {
      functions.logger.warn("[triggerNotifications] Không có người dùng nào đủ điều kiện nhận thông báo.");
      return;
  }

  type UserNotificationData = { id: string; tokens: string[]; lang: string; tier: string; };

  const usersData = allEligibleUsersDocs
      .map((doc): UserNotificationData | null => {
          const data = doc.data();
          if (!data) return null;
          
          let langCode = (data.languageCode || 'en').toLowerCase();
          const supportedLangs = ['vi', 'en', 'zh', 'fr', 'ja', 'ko'];
          if (!supportedLangs.includes(langCode)) {
              langCode = 'en';
          }

          const tokens: string[] = [];
          if (data.activeSessionWeb?.fcmToken) tokens.push(data.activeSessionWeb.fcmToken);
          if (data.activeSessionMobile?.fcmToken) tokens.push(data.activeSessionMobile.fcmToken);
          // Fallback cho activeSession cũ
          if (tokens.length === 0 && data.activeSession?.fcmToken) tokens.push(data.activeSession.fcmToken);

          if (tokens.length === 0) return null;

          return {
              id: doc.id,
              tokens: tokens,
              lang: langCode,
              tier: data.subscriptionTier,
          };
      })
      .filter((user): user is UserNotificationData => user !== null);

  // Flatten usersData to send notifications per token
  const notificationEntries: { id: string; token: string; lang: string }[] = [];
  usersData.forEach(user => {
    user.tokens.forEach(token => {
      notificationEntries.push({ id: user.id, token, lang: user.lang });
    });
  });

  await sendAndStoreNotifications(notificationEntries, payload);

  const demoUsersToUpdate = usersData
      .filter((user) => user.tier === "demo")
      .map((user) => user.id);

  if (demoUsersToUpdate.length > 0) {
      const batchUpdate = firestore.batch();
      demoUsersToUpdate.forEach((userId) => {
          const userRef = firestore.collection("users").doc(userId);
          batchUpdate.update(userRef, { notificationCount: admin.firestore.FieldValue.increment(1) });
      });
      await batchUpdate.commit();
      functions.logger.log(`[triggerNotifications] Đã cập nhật notificationCount cho ${demoUsersToUpdate.length} user DEMO.`);
  }
}

// --- HÀM TRIGGER CHÍNH (ĐÃ BỌC TRY-CATCH) ---
export const onNewSignalCreated = onDocumentCreated({ document: "signals/{signalId}", region: "asia-southeast1", memory: "256MiB" }, async (event) => {
    functions.logger.log(`🔥🔥🔥 onNewSignalCreated triggered cho signalId: ${event.params.signalId}`);
    try {
        const signalData = event.data?.data();
        if (!signalData) {
            functions.logger.warn("Không có dữ liệu tín hiệu, kết thúc.");
            return;
        }

        const localizedPayload = await getLocalizedPayload(
            "new_signal",
            signalData.type.toUpperCase(),
            signalData.symbol,
            signalData.entryPrice,
            signalData.stopLoss
        );

        const finalPayload = {
          type: "new_signal",
          signalId: event.params.signalId,
          ...localizedPayload,
        };

        await triggerNotifications(finalPayload);
    } catch (error) {
        functions.logger.error("🚨🚨🚨 Lỗi nghiêm trọng trong onNewSignalCreated:", error);
    }
});

export const onSignalUpdated = onDocumentUpdated({ document: "signals/{signalId}", region: "asia-southeast1", memory: "256MiB" }, async (event) => {
    functions.logger.log(`🔥🔥🔥 onSignalUpdated triggered cho signalId: ${event.params.signalId}`);
    try {
        const beforeData = event.data?.before.data();
        const afterData = event.data?.after.data();
        if (!beforeData || !afterData) {
            functions.logger.warn("Không có dữ liệu before/after, kết thúc.");
            return;
        }

        let notificationType: string | null = null;
        let payloadArgs: (string | number)[] = [];
        const { symbol, type, entryPrice } = afterData;

        if (beforeData.isMatched === false && afterData.isMatched === true) {
            notificationType = "signal_matched";
            payloadArgs = [type.toUpperCase(), symbol, entryPrice];
        } else if (beforeData.result !== afterData.result) {
            switch(afterData.result) {
                case "TP1 Hit": notificationType = "tp1_hit"; payloadArgs = [type.toUpperCase(), symbol]; break;
                case "TP2 Hit": notificationType = "tp2_hit"; payloadArgs = [type.toUpperCase(), symbol]; break;
                case "TP3 Hit": notificationType = "tp3_hit"; payloadArgs = [type.toUpperCase(), symbol]; break;
                case "SL Hit": notificationType = "sl_hit"; payloadArgs = [type.toUpperCase(), symbol]; break;
            }
        }

        if (notificationType) {
            const localizedPayload = await getLocalizedPayload(notificationType as any, ...payloadArgs);
            const finalPayload = {
                type: notificationType,
                signalId: event.params.signalId,
                ...localizedPayload
            };
            await triggerNotifications(finalPayload);
        } else {
            functions.logger.log("Không có thay đổi trạng thái cần gửi thông báo.");
        }
    } catch (error) {
        functions.logger.error("🚨🚨🚨 Lỗi nghiêm trọng trong onSignalUpdated:", error);
    }
});

// =================================================================
// === FUNCTION GỬI THÔNG BÁO CHO LIVE CHAT ===
// =================================================================
export const onNewChatMessage = onDocumentCreated(
  { document: "chat_rooms/{userId}/messages/{messageId}", region: "asia-southeast1", memory: "256MiB" },
  async (event) => {
    const messageData = event.data?.data();
    if (!messageData) {
      functions.logger.warn("Không có dữ liệu tin nhắn, kết thúc.");
      return null;
    }

    const userId = event.params.userId;
    const senderId = messageData.senderId;
    const senderName = messageData.senderName || "Một ai đó";
    const messageText = messageData.text || "Đã gửi một tin nhắn.";

    // --- Trường hợp 1: Người dùng gửi tin nhắn cho Support ---
    if (senderId === userId) {
      functions.logger.log(`Người dùng ${userId} đã gửi tin nhắn. Báo cho các tài khoản support.`);

      const supportUsersSnapshot = await firestore
        .collection("users")
        .where("role", "==", "support")
        .get();

      if (supportUsersSnapshot.empty) {
        functions.logger.warn("Không tìm thấy tài khoản support nào để gửi thông báo.");
        return null;
      }

      const tokens: string[] = [];
      supportUsersSnapshot.forEach(doc => {
        const token = doc.data().activeSession?.fcmToken;
        if (token) {
          tokens.push(token);
        }
      });

      if (tokens.length === 0) {
        functions.logger.warn("Không có tài khoản support nào có token để nhận thông báo.");
        return null;
      }

      // ▼▼▼ THAY ĐỔI 1: SỬA LỖI - DÙNG `sendEachForMulticast` THAY CHO `sendToDevice` ▼▼▼
      const messagePayload = {
        notification: {
          title: `Tin nhắn mới từ ${senderName}`,
          body: messageText,
        },
        data: {
          type: "new_chat_message",
          chatRoomId: userId,
        },
      };

      await admin.messaging().sendEachForMulticast({tokens, ...messagePayload});
    }
    // --- Trường hợp 2: Support trả lời người dùng ---
    else {
      functions.logger.log(`Support ${senderId} đã trả lời người dùng ${userId}.`);

      const userDoc = await firestore.collection("users").doc(userId).get();
      const userToken = userDoc.data()?.activeSession?.fcmToken;

      if (!userToken) {
        functions.logger.warn(`Người dùng ${userId} không có token để nhận thông báo trả lời.`);
        return null;
      }

      // ▼▼▼ THAY ĐỔI 2: SỬA LỖI - DÙNG `send` THAY CHO `sendToDevice` CHO HIỆU QUẢ HƠN ▼▼▼
      const message: admin.messaging.Message = {
        token: userToken,
        notification: {
          title: `Phản hồi từ ${senderName}`,
          body: messageText,
        },
        data: {
          type: "new_chat_message",
          chatRoomId: userId,
        },
      };

      await admin.messaging().send(message);
    }
    return null;
  }
);

// =================================================================
// === FUNCTION QUẢN LÝ TIỆN ÍCH KHÁC ===
// =================================================================
export const manageUserSession = onCall({ region: "asia-southeast1" }, async (request) => {
  if (!request.auth) {
    throw new functions.https.HttpsError("unauthenticated", "The function must be called while authenticated.");
  }

  const uid = request.auth.uid;
  const newDeviceId = request.data.deviceId;
  const newFcmToken = request.data.fcmToken;
  const platform = request.data.platform || "mobile"; // "web" or "mobile"

  if (!newDeviceId) {
    throw new functions.https.HttpsError("invalid-argument", "The function must be called with a 'deviceId' argument.");
  }

  const userDocRef = firestore.collection("users").doc(uid);

  try {
    await firestore.runTransaction(async (transaction) => {
      const userDoc = await transaction.get(userDocRef);

      if (!userDoc.exists) {
        functions.logger.error(`manageUserSession được gọi cho user ${uid} nhưng document không tồn tại.`);
        return;
      }

      const userData = userDoc.data();
      // Determine which session field to use
      const sessionField = platform === "web" ? "activeSessionWeb" : "activeSessionMobile";
      const logoutTargetField = platform === "web" ? "logoutTargetDeviceIdWeb" : "logoutTargetDeviceIdMobile";
      
      const currentSession = userData?.[sessionField];
      let updateData: { [key: string]: any } = {};

      // Tạo session mới cho thiết bị đang đăng nhập
      const newSessionData = {
        deviceId: newDeviceId,
        fcmToken: newFcmToken,
        loginAt: admin.firestore.FieldValue.serverTimestamp(),
        platform: platform,
      };
      updateData[sessionField] = newSessionData;
      
      // Để tương thích ngược với các hàm gửi thông báo cũ dùng activeSession
      // Chúng ta sẽ cập nhật activeSession là phiên mới nhất bất kể platform
      updateData.activeSession = newSessionData;

      // Nếu có session cũ trên cùng platform và deviceId khác với session mới
      if (currentSession && currentSession.deviceId && currentSession.deviceId !== newDeviceId) {
        functions.logger.log(`Phát hiện đăng nhập mới trên ${platform}. Thiết bị cũ ${currentSession.deviceId} sẽ bị đăng xuất.`);
        updateData[logoutTargetField] = currentSession.deviceId;
      } else {
        updateData[logoutTargetField] = admin.firestore.FieldValue.delete();
      }

      transaction.update(userDocRef, updateData);
    });

    return { status: "success", message: "Session managed successfully." };

  } catch (error) {
    functions.logger.error("Error in manageUserSession transaction:", error);
    throw new functions.https.HttpsError("internal", "An error occurred while managing the user session.");
  }
});

export const updateUserSubscriptionTier = onCall({ region: "asia-southeast1" }, async (request) => {
    // 1. Xác thực quyền admin (giữ nguyên)
    const adminUid = request.auth?.uid;
    if (!adminUid) {
        throw new HttpsError("unauthenticated", "Bạn phải đăng nhập để thực hiện hành động này.");
    }
    const adminUserDoc = await firestore.collection("users").doc(adminUid).get();
    if (adminUserDoc.data()?.role !== "admin") {
        throw new HttpsError("permission-denied", "Bạn không có quyền thực hiện hành động này.");
    }

    // 2. Lấy và kiểm tra các tham số đầu vào (giữ nguyên)
    const { userIds, tier, reason } = request.data;
    if (!userIds || !Array.isArray(userIds) || userIds.length === 0) {
        throw new HttpsError("invalid-argument", "Dữ liệu 'userIds' gửi lên không hợp lệ.");
    }
    const validTiers = ['free', 'elite', 'affiliate'];
    if (!tier || typeof tier !== 'string' || !validTiers.includes(tier)) {
        throw new HttpsError("invalid-argument", `Gói '${tier}' không hợp lệ. Các gói hợp lệ là: ${validTiers.join(', ')}.`);
    }
    if (!reason || typeof reason !== 'string' || reason.trim().length === 0) {
        throw new HttpsError("invalid-argument", "Lý do thay đổi không được để trống.");
    }

    // 3. Chuẩn bị nội dung thông báo cho người dùng
    const reasonForNotification = {
        vi: `Tài khoản của bạn đã được cập nhật thành gói ${tier.toUpperCase()}. Vui lòng đăng nhập lại.`,
        en: `Your account has been updated to the ${tier.toUpperCase()} plan. Please log in again.`,
    };

    const batch = firestore.batch();
    const usersToNotify: { token: string; lang: string }[] = [];

    // 4. Lặp qua danh sách user và cập nhật dữ liệu
    for (const userId of userIds) {
        if (userId === adminUid) continue;

        const userRef = firestore.collection("users").doc(userId);

        // Chuẩn bị dữ liệu cập nhật cơ bản
        const updateData: any = {
            requiresSessionReset: true,
            // Xóa các trường cũ không còn dùng
            updateReason: admin.firestore.FieldValue.delete(),
            requiresDowngradeAcknowledgement: admin.firestore.FieldValue.delete(),
            downgradeReason: admin.firestore.FieldValue.delete(),
        };

        if (tier === 'affiliate') {
            // Nếu chọn affiliate: Chỉ cập nhật role, giữ nguyên gói cước (free/elite)
            updateData.role = 'affiliate';
            updateData.sessionResetReason = "Tài khoản của bạn đã được cấp quyền Đối tác (Affiliate).";
        } else {
            // Nếu chọn free hoặc elite: Cập nhật gói cước, và trả role về user
            updateData.subscriptionTier = tier;
            updateData.role = 'user';
            updateData.sessionResetReason = `Gói cước của bạn đã được cập nhật thành ${tier.toUpperCase()}.`;
        }

        batch.update(userRef, updateData);

        // ▼▼▼ THÊM LOGIC TÍNH HOA HỒNG AFFILIATE (KHI ADMIN NÂNG GÓI THỦ CÔNG) ▼▼▼
        if (tier === 'elite') {
            const userDoc = await userRef.get();
            const userData = userDoc.data();
            const affiliateId = userData?.referred_by_affiliate_id;

            if (affiliateId) {
                const affiliateRef = firestore.collection("affiliates").doc(affiliateId);
                const affiliateDoc = await affiliateRef.get();

                if (affiliateDoc.exists) {
                    const affData = affiliateDoc.data();
                    const rate = affData?.commissionRate || 40;
                    const amountPaid = 78; // Mức giá mặc định cho gói Elite nạp thủ công
                    const commissionAmount = Math.round(amountPaid * (rate / 100) * 100) / 100;

                    // 1. Tạo bản ghi hoa hồng (Trạng thái approved vì admin đã xác nhận tiền)
                    const commissionRef = firestore.collection("commissions").doc();
                    batch.set(commissionRef, {
                        affiliateId: affiliateId,
                        affiliateCode: affData?.code || '---',
                        userId: userId,
                        userEmail: userData?.email || '---',
                        productId: 'manual_upgrade_elite',
                        invoiceAmount: amountPaid,
                        commissionRate: rate,
                        commissionAmount: commissionAmount,
                        status: 'approved',
                        createdAt: admin.firestore.FieldValue.serverTimestamp(),
                        transactionId: `manual_${Date.now()}_${userId.substring(0, 5)}`
                    });

                    // 2. Cập nhật thu nhập tổng cộng cho đối tác
                    batch.update(affiliateRef, {
                        totalEarnings: admin.firestore.FieldValue.increment(commissionAmount),
                        updatedAt: admin.firestore.FieldValue.serverTimestamp()
                    });
                }
            }
        }
        // ▲▲▲ KẾT THÚC THÊM ▼▼▼

        // ▼▼▼ THÊM THÔNG BÁO CẬP NHẬT GÓI (ADMIN) ▼▼▼
        const notifRef = userRef.collection("notifications").doc();
        batch.set(notifRef, {
            type: "subscription_success",
            title_loc: {
                en: "Plan Updated",
                vi: "Plan Updated",
            },
            body_loc: {
                en: `Your plan has been updated to ${tier.toUpperCase()}.`,
                vi: `Your plan has been updated to ${tier.toUpperCase()}.`,
            },
            timestamp: admin.firestore.FieldValue.serverTimestamp(),
            isRead: false,
        });
        // ▲▲▲ KẾT THÚC THÊM ▼▼▼

        const userDoc = await userRef.get();
        const userData = userDoc.data();
        const fcmToken = userData?.activeSession?.fcmToken;
        if (fcmToken) {
            usersToNotify.push({
                token: fcmToken,
                lang: userData?.languageCode === 'en' ? 'en' : 'vi'
            });
        }
    }

    // 5. Commit các thay đổi vào Firestore (giữ nguyên)
    await batch.commit();

    // 6. Gửi thông báo đẩy đến các thiết bị của người dùng (giữ nguyên)
    if (usersToNotify.length > 0) {
        const promises = usersToNotify.map(user => {
            const message = {
                token: user.token,
                data: {
                    action: "FORCE_LOGOUT",
                    reason: user.lang === 'en' ? reasonForNotification.en : reasonForNotification.vi
                },
                apns: { headers: { "apns-priority": "10" }, payload: { aps: { "content-available": 1 } } },
                android: { priority: "high" as const },
            };
            return admin.messaging().send(message).catch(err => {
                functions.logger.error(`Lỗi gửi thông báo cập nhật gói tới ${user.token}`, err);
            });
        });
        await Promise.all(promises);
    }

    // 7. Trả về kết quả thành công (giữ nguyên)
    return { status: "success", message: `Đã cập nhật thành công ${userIds.length} tài khoản thành gói ${tier.toUpperCase()}.` };
});

// =================================================================
// === TRIGGER TỰ ĐỘNG TÍNH HOA HỒNG KHI ADMIN NÂNG GÓI THỦ CÔNG ===
// =================================================================
export const onUserSubscriptionUpdated = onDocumentUpdated(
    { region: "asia-southeast1", document: "users/{userId}" },
    async (event) => {
        const beforeData = event.data?.before.data();
        const afterData = event.data?.after.data();
        const userId = event.params.userId;

        if (!beforeData || !afterData) return;

        const packages = ["gold", "forex", "crypto"];
        
        for (const pkg of packages) {
            const beforeExpiry = beforeData.subscriptionsExpiry?.[pkg] as admin.firestore.Timestamp | undefined;
            const afterExpiry = afterData.subscriptionsExpiry?.[pkg] as admin.firestore.Timestamp | undefined;

            // Nếu ngày hết hạn được cập nhật và mới hơn ngày cũ
            if (afterExpiry && (!beforeExpiry || afterExpiry.toMillis() > beforeExpiry.toMillis())) {
                const affiliateId = afterData.referred_by_affiliate_id;
                
                // Chỉ xử lý nếu user có người giới thiệu
                if (affiliateId) {
                    // Tính toán khoảng thời gian được cộng thêm (millisecond)
                    const baseDate = beforeExpiry && beforeExpiry.toMillis() > Date.now() 
                        ? beforeExpiry.toMillis() 
                        : Date.now();
                    
                    const diffMs = afterExpiry.toMillis() - baseDate;
                    const diffDays = diffMs / (1000 * 60 * 60 * 24);

                    // Nếu chênh lệch quá nhỏ (ví dụ dưới 1 ngày do lỗi thao tác) thì bỏ qua
                    if (diffDays < 1) continue;

                    // Xác định mức giá dựa trên số ngày
                    // > 31 ngày coi là gói năm ($460), <= 31 ngày coi là gói tháng ($78)
                    const amountPaid = diffDays > 31 ? 460 : 78;
                    const packageDuration = diffDays > 31 ? "12_months" : "1_month";

                    const affiliateRef = firestore.collection("affiliates").doc(affiliateId);
                    const affiliateDoc = await affiliateRef.get();

                    if (affiliateDoc.exists) {
                        const affData = affiliateDoc.data();
                        const rate = affData?.commissionRate || 40;
                        const commissionAmount = Math.round(amountPaid * (rate / 100) * 100) / 100;

                        // Kiểm tra xem giao dịch này đã được ghi nhận chưa (tránh duplicate trong cùng 1 phút)
                        const recentCommQuery = await firestore.collection("commissions")
                            .where("affiliateId", "==", affiliateId)
                            .where("userId", "==", userId)
                            .where("productId", "==", `manual_${pkg}_${packageDuration}`)
                            .orderBy("createdAt", "desc")
                            .limit(1)
                            .get();

                        if (!recentCommQuery.empty) {
                            const lastCommDate = (recentCommQuery.docs[0].data().createdAt as admin.firestore.Timestamp).toMillis();
                            if (Date.now() - lastCommDate < 60000) { // Nếu vừa mới tạo trong vòng 1 phút thì bỏ qua
                                functions.logger.log(`Bỏ qua ghi nhận hoa hồng trùng lặp cho user ${userId} gói ${pkg}`);
                                continue;
                            }
                        }

                        // Tạo bản ghi hoa hồng
                        await firestore.runTransaction(async (transaction) => {
                            const commissionRef = firestore.collection("commissions").doc();
                            transaction.set(commissionRef, {
                                affiliateId: affiliateId,
                                affiliateCode: affData?.code || '---',
                                userId: userId,
                                userEmail: afterData.email || '---',
                                productId: `manual_${pkg}_${packageDuration}`,
                                invoiceAmount: amountPaid,
                                commissionRate: rate,
                                commissionAmount: commissionAmount,
                                status: 'approved',
                                createdAt: admin.firestore.FieldValue.serverTimestamp(),
                                transactionId: `admin_manual_${Date.now()}_${pkg}`
                            });

                            // Cập nhật thu nhập cho đối tác
                            transaction.update(affiliateRef, {
                                totalEarnings: admin.firestore.FieldValue.increment(commissionAmount),
                                updatedAt: admin.firestore.FieldValue.serverTimestamp()
                            });
                        });

                        functions.logger.log(`✅ Đã ghi nhận hoa hồng thủ công cho ${affData?.code}: \$${commissionAmount} (Gói ${pkg} ${packageDuration})`);
                    }
                }
            }
        }
    }
);

export const resetDemoNotificationCounters = onSchedule({ schedule: "1 0 * * *", timeZone: "Asia/Ho_Chi_Minh", region: "asia-southeast1" }, async () => {
    const demoUsersSnapshot = await firestore.collection("users").where("subscriptionTier", "==", "demo").get();
    if (demoUsersSnapshot.empty) return;
    const batch = firestore.batch();
    demoUsersSnapshot.forEach(doc => batch.update(doc.ref, { notificationCount: 0 }));
    await batch.commit();
});

async function deleteCollection(db: admin.firestore.Firestore, collectionPath: string, batchSize: number) {
    const collectionRef = db.collection(collectionPath);
    const query = collectionRef.orderBy('__name__').limit(batchSize);

    return new Promise((resolve, reject) => {
        deleteQueryBatch(db, query, resolve).catch(reject);
    });
}

async function deleteQueryBatch(db: admin.firestore.Firestore, query: admin.firestore.Query, resolve: (value: unknown) => void) {
    const snapshot = await query.get();
    if (snapshot.size === 0) {
        resolve(true);
        return;
    }
    const batch = db.batch();
    snapshot.docs.forEach((doc) => {
        batch.delete(doc.ref);
    });
    await batch.commit();
    process.nextTick(() => {
        deleteQueryBatch(db, query, resolve);
    });
}

export const deleteUserAccount = onCall({ region: "asia-southeast1" }, async (request) => {
    const uid = request.auth?.uid;
    if (!uid) {
        throw new HttpsError("unauthenticated", "Yêu cầu phải được xác thực.");
    }
    functions.logger.log(`Bắt đầu quá trình xóa cho người dùng: ${uid}`);
    try {
        await deleteCollection(firestore, `users/${uid}/notifications`, 50);
        functions.logger.log(`Đã xóa subcollection 'notifications' cho user ${uid}`);

        await deleteCollection(firestore, `users/${uid}/transactions`, 50);
        functions.logger.log(`Đã xóa subcollection 'transactions' cho user ${uid}`);

        await firestore.collection("users").doc(uid).delete();
        functions.logger.log(`Đã xóa document chính của user ${uid}`);

        const exnessIdQuery = await firestore.collection("verifiedExnessIds").where("userId", "==", uid).limit(1).get();
        if (!exnessIdQuery.empty) {
            await exnessIdQuery.docs[0].ref.delete();
            functions.logger.log(`Đã xóa 'verifiedExnessIds' cho user ${uid}`);
        }

        await admin.auth().deleteUser(uid);
        functions.logger.log(`Hoàn tất: Đã xóa người dùng khỏi Firebase Auth: ${uid}`);

        return { success: true, message: "Tài khoản và dữ liệu đã được xóa thành công." };

    } catch (error) {
        functions.logger.error(`Lỗi khi xóa người dùng ${uid}:`, error);
        throw new HttpsError("internal", "Không thể xóa tài khoản, vui lòng thử lại sau.", error);
    }
});

// =================================================================
// === FUNTION GỬI THÔNG TIN LÊN FIRESTORE ===
// =================================================================
export const submitContactMessage = onCall({ region: "asia-southeast1" }, async (request) => {
    const data = request.data || {};
    const firstName = (data.firstName || "").toString().trim();
    const lastName = (data.lastName || "").toString().trim();
    const email = (data.email || "").toString().trim();
    const phone = (data.phone || "").toString().trim();
    const message = (data.message || "").toString().trim();

    if (!firstName || !lastName || !email || !message) {
        throw new HttpsError("invalid-argument", "Vui lòng điền đầy đủ họ tên, email và nội dung.");
    }
    if (!email.includes("@")) {
        throw new HttpsError("invalid-argument", "Địa chỉ email không hợp lệ.");
    }
    if (message.length > 2000) {
        throw new HttpsError("invalid-argument", "Nội dung quá dài. Vui lòng rút gọn dưới 2000 ký tự.");
    }

    try {
        const contactData = {
            firstName,
            lastName,
            email,
            phone,
            message,
        };

        // 1. Lưu vào Firestore
        await firestore.collection("contact_messages").add({
            ...contactData,
            createdAt: admin.firestore.FieldValue.serverTimestamp(),
            uid: request.auth?.uid ?? null,
            source: "landing_contact_form",
        });

        // 2. Gửi sang Google Sheet thông qua Apps Script
        const GOOGLE_SHEET_URL = "https://script.google.com/macros/s/AKfycbzUjKujRLwsVd5mJTDPgRP7AUwjeT9RfziWamxoNYUiDHUXy8rVCn1zl2Z7mUWhmS8/exec";
        try {
            await axios.post(GOOGLE_SHEET_URL, contactData);
            functions.logger.log("Đã gửi thông tin liên hệ sang Google Sheet thành công.");
        } catch (sheetError) {
            // Không throw lỗi ở đây để khách hàng vẫn thấy thông báo thành công dù Google Sheet gặp lỗi
            functions.logger.error("Lỗi khi gửi sang Google Sheet:", sheetError);
        }

        return { status: "success" };
    } catch (error) {
        functions.logger.error("Lỗi lưu contact_messages:", error);
        throw new HttpsError("internal", "Không thể lưu thông tin liên hệ, vui lòng thử lại sau.");
    }
});

// =================================================================
// === HỆ THỐNG AFFILIATE ===
// =================================================================

/**
 * Gán Affiliate cho người dùng khi đăng ký hoặc đăng nhập lần đầu trên Web.
 */
export const affiliateAttach = onCall({ region: "asia-southeast1" }, async (request) => {
    const { uid, ref_code, ref_ts } = request.data;
    
    if (!uid || !ref_code) {
        throw new HttpsError("invalid-argument", "Thiếu uid hoặc ref_code.");
    }

    const upperRefCode = ref_code.toString().trim().toUpperCase();

    try {
        const userRef = firestore.collection("users").doc(uid);
        let userDoc = await userRef.get();

        // Thêm vòng lặp thử lại (retry) để đợi user document được tạo (trong trường hợp đăng ký mới)
        let retries = 0;
        while (!userDoc.exists && retries < 5) {
            functions.logger.log(`User ${uid} chưa tồn tại, đang thử lại lần ${retries + 1}...`);
            await new Promise(resolve => setTimeout(resolve, 1000)); // Đợi 1 giây
            userDoc = await userRef.get();
            retries++;
        }

        if (!userDoc.exists) {
            functions.logger.error(`Không tìm thấy người dùng ${uid} sau 5 lần thử.`);
            throw new HttpsError("not-found", "Không tìm thấy người dùng sau khi thử lại.");
        }

        const userData = userDoc.data();
        
        // Kiểm tra nếu đã bị khóa affiliate (đã thanh toán rồi)
        if (userData?.affiliate_locked_at) {
            functions.logger.log(`User ${uid} đã bị khóa affiliate, không thể ghi đè.`);
            return { status: "ignored", reason: "affiliate_locked" };
        }

        // Tìm affiliate theo mã code
        const affiliateQuery = await firestore.collection("affiliates")
            .where("code", "==", upperRefCode)
            .limit(1)
            .get();

        if (affiliateQuery.empty) {
            functions.logger.warn(`Mã giới thiệu không tồn tại: ${upperRefCode}`);
            return { status: "failed", reason: "invalid_ref_code" };
        }

        const affiliateId = affiliateQuery.docs[0].id;
        const affiliateRef = firestore.collection("affiliates").doc(affiliateId);

        // Sử dụng Transaction để đảm bảo tính nhất quán của dữ liệu
        await firestore.runTransaction(async (transaction) => {
            // 1. Cập nhật người dùng
            transaction.update(userRef, {
                referred_by_affiliate_id: affiliateId,
                affiliate_ref_code: upperRefCode,
                affiliate_ref_ts: ref_ts || admin.firestore.FieldValue.serverTimestamp(),
                updatedAt: admin.firestore.FieldValue.serverTimestamp()
            });

            // 2. Tăng số lượng referral cho đối tác
            transaction.update(affiliateRef, {
                referralCount: admin.firestore.FieldValue.increment(1)
            });
        });

        functions.logger.log(`✅ Đã gán affiliate ${affiliateId} (mã: ${upperRefCode}) cho user ${uid} và tăng referralCount.`);
        return { status: "success" };
    } catch (error) {
        functions.logger.error("Lỗi khi gán affiliate:", error);
        throw new HttpsError("internal", "Lỗi xử lý gán affiliate.");
    }
});

// =================================================================
// === FUNCTION CỘNG TOKEN HÀNG NGÀY CHO FREE USER ===
// =================================================================
export const grantDailyFreeTokens = onSchedule(
    {
        schedule: "1 0 * * *", // Chạy lúc 00:01 mỗi ngày
        timeZone: "Asia/Ho_Chi_Minh",
        region: "asia-southeast1",
        memory: "512MiB",
        timeoutSeconds: 540 // Tăng timeout lên 9 phút cho xử lý batch lớn
    },
    async (event) => {
        functions.logger.log("⏰ Bắt đầu cộng token hàng ngày cho tài khoản Free...");
        
        const batchSize = 500;
        const usersRef = firestore.collection("users");
        
        // Chỉ lấy những user là 'free' (hoặc có thể bỏ điều kiện này nếu muốn cộng cho tất cả)
        const snapshot = await usersRef.where("subscriptionTier", "==", "free").get();
        
        if (snapshot.empty) {
            functions.logger.log("Không có user Free nào để cộng token.");
            return;
        }

        let batch = firestore.batch();
        let operationCounter = 0;
        let batchCount = 0;

        for (const doc of snapshot.docs) {
            const data = doc.data();
            const currentBalance = typeof data.tokenBalance === 'number' ? data.tokenBalance : 0;
            
            // Giới hạn số dư tối đa là 50 khi cộng tự động.
            // Nếu admin đã set > 50 thì sẽ không bị cộng đè hoặc thay đổi.
            if (currentBalance < 50) {
                // Cộng 1 token vào tokenBalance
                batch.update(doc.ref, {
                    tokenBalance: admin.firestore.FieldValue.increment(1)
                });
                
                operationCounter++;

                // Nếu đạt giới hạn batch (500), commit và tạo batch mới
                if (operationCounter >= batchSize) {
                    await batch.commit();
                    functions.logger.log(`Đã commit batch thứ ${++batchCount} (${operationCounter} users)`);
                    batch = firestore.batch();
                    operationCounter = 0;
                }
            }
        }

        // Commit những user còn lại trong batch cuối cùng
        if (operationCounter > 0) {
            await batch.commit();
            functions.logger.log(`Đã commit batch cuối cùng (${operationCounter} users)`);
        }

        functions.logger.log(`✅ Hoàn tất cộng token cho tổng cộng ${snapshot.size} user.`);
    }
);

// =================================================================
// === FUNCTION KIỂM TRA VÀ HỦY GÓI HẾT HẠN ===
// =================================================================
export const checkExpiredSubscriptions = onSchedule (
    {
        schedule: "0 * * * *", // Chạy mỗi giờ
        timeZone: "Asia/Ho_Chi_Minh",
        region: "asia-southeast1",
        memory: "512MiB",
    },
    async (event) => {
        functions.logger.log("⏰ Bắt đầu kiểm tra các gói đăng ký hết hạn...");
        const now = admin.firestore.Timestamp.now();
        const batch = firestore.batch();
        let operationCount = 0;

        // 1. Kiểm tra gói ELITE hết hạn
        const eliteQuery = await firestore.collection("users")
            .where("subscriptionTier", "==", "elite")
            .where("subscriptionExpiryDate", "<=", now)
            .get();

        eliteQuery.forEach((doc) => {
            functions.logger.log(`User ${doc.id} hết hạn gói ELITE. Hạ cấp về FREE.`);
            batch.update(doc.ref, {
                subscriptionTier: "free",
                subscriptionExpiryDate: admin.firestore.FieldValue.delete(),
                // Reset activeSubscriptions nếu cần, hoặc giữ nguyên nếu họ có mua gói lẻ
                // Ở đây giả sử Elite bao trùm tất cả, khi hết Elite thì về Free và check các gói lẻ sau
            });

            // ▼▼▼ THÊM THÔNG BÁO HẾT HẠN (ELITE) ▼▼▼
            const notifRef = doc.ref.collection("notifications").doc();
            batch.set(notifRef, {
                type: "subscription_expired",
                title_loc: { en: "Elite Plan Expired", vi: "Elite Plan Expired" },
                body_loc: {
                    en: "Your Elite subscription has expired. You are now on the Free plan.",
                    vi: "Your Elite subscription has expired. You are now on the Free plan.",
                },
                timestamp: admin.firestore.FieldValue.serverTimestamp(),
                isRead: false,
            });
            // ▲▲▲ KẾT THÚC THÊM ▼▼▼

            operationCount++;
        });

        // 2. Kiểm tra các gói lẻ (Gold, Forex, Crypto) hết hạn
        // Cần index cho subscriptionsExpiry.gold, .forex, .crypto nếu dữ liệu lớn
        const packages = ['gold', 'forex', 'crypto'];
        
        for (const pkg of packages) {
            // Tìm những user có gói này đang active NHƯNG ngày hết hạn đã qua
            const expiredQuery = await firestore.collection("users")
                .where("activeSubscriptions", "array-contains", pkg)
                // Lưu ý: Query này yêu cầu activeSubscriptions chứa pkg
                // Và ta sẽ lọc client-side hoặc composite query nếu index cho phép.
                // Để đơn giản và chính xác mà không cần quá nhiều index phức tạp ngay lập tức:
                // Ta query field expiry cụ thể < now.
                .where(`subscriptionsExpiry.${pkg}`, "<=", now)
                .get();

            expiredQuery.forEach((doc) => {
                functions.logger.log(`User ${doc.id} hết hạn gói ${pkg.toUpperCase()}. Gỡ bỏ khỏi activeSubscriptions.`);
                batch.update(doc.ref, {
                    activeSubscriptions: admin.firestore.FieldValue.arrayRemove(pkg),
                    [`subscriptionsExpiry.${pkg}`]: admin.firestore.FieldValue.delete(), // Xóa ngày hết hạn để sạch data
                    [`subscriptionsStart.${pkg}`]: admin.firestore.FieldValue.delete(), // Xóa ngày bắt đầu
                });

                // ▼▼▼ THÊM THÔNG BÁO HẾT HẠN (GÓI LẺ) ▼▼▼
                const notifRef = doc.ref.collection("notifications").doc();
                batch.set(notifRef, {
                    type: "subscription_expired",
                    title_loc: { en: `${pkg.toUpperCase()} Plan Expired`, vi: `${pkg.toUpperCase()} Plan Expired` },
                    body_loc: {
                        en: `Your ${pkg.toUpperCase()} subscription has expired.`,
                        vi: `Your ${pkg.toUpperCase()} subscription has expired.`,
                    },
                    timestamp: admin.firestore.FieldValue.serverTimestamp(),
                    isRead: false,
                });
                // ▲▲▲ KẾT THÚC THÊM ▼▼▼

                operationCount++;
            });
        }

        if (operationCount > 0) {
            await batch.commit();
            functions.logger.log(`✅ Đã xử lý ${operationCount} trường hợp hết hạn.`);
        } else {
            functions.logger.log("Không tìm thấy gói nào hết hạn trong đợt quét này.");
        }
    }
);

// =================================================================
// === PASSWORD RESET WITH CODE ===
// =================================================================

export const generateAndSendResetCode = onCall({ region: "asia-southeast1" }, async (request) => {
    const email = request.data.email;
    if (!email || !email.includes("@")) {
        throw new HttpsError("invalid-argument", "Địa chỉ email không hợp lệ.");
    }

    try {
        // 1. Kiểm tra user có tồn tại không
        try {
            await admin.auth().getUserByEmail(email);
        } catch (e) {
            // Để bảo mật, không báo lỗi nếu user không tồn tại, chỉ log
            functions.logger.warn(`Yêu cầu reset pass cho email không tồn tại: ${email}`);
            return { success: true, message: "Nếu email tồn tại, mã xác nhận sẽ được gửi." };
        }

        // 2. Tạo mã 6 số
        const code = Math.floor(100000 + Math.random() * 900000).toString();
        const expiresAt = admin.firestore.Timestamp.fromDate(new Date(Date.now() + 15 * 60000)); // Hết hạn sau 15 phút

        // 3. Lưu vào Firestore
        await firestore.collection("password_reset_codes").doc(email).set({
            code,
            expiresAt,
            createdAt: admin.firestore.FieldValue.serverTimestamp(),
        });

        // 4. Gửi Email
        // Lưu ý: Trong thực tế bạn cần dùng SendGrid hoặc Firebase Email Extension.
        // Ở đây tôi sẽ lưu vào collection 'mail' để Firebase Email Extension tự gửi nếu bạn đã cài đặt.
        await firestore.collection("mail").add({
            to: email,
            message: {
                subject: "Mã xác nhận đặt lại mật khẩu - SignalGPT",
                html: `Mã xác nhận của bạn là: <b>${code}</b>. Mã này có hiệu lực trong 15 phút.`,
            },
        });

        functions.logger.log(`Đã tạo mã reset cho ${email}: ${code}`);
        return { success: true };
    } catch (error) {
        functions.logger.error("Lỗi generateAndSendResetCode:", error);
        throw new HttpsError("internal", "Không thể gửi mã xác nhận.");
    }
});

export const resetPasswordWithCode = onCall({ region: "asia-southeast1" }, async (request) => {
    const { email, code, newPassword } = request.data;

    if (!email || !code || !newPassword || newPassword.length < 6) {
        throw new HttpsError("invalid-argument", "Thông tin không hợp lệ hoặc mật khẩu quá ngắn.");
    }

    try {
        const resetDoc = await firestore.collection("password_reset_codes").doc(email).get();
        if (!resetDoc.exists) {
            throw new HttpsError("not-found", "Mã xác nhận không tồn tại hoặc đã hết hạn.");
        }

        const data = resetDoc.data()!;
        const now = admin.firestore.Timestamp.now();

        if (data.code !== code) {
            throw new HttpsError("permission-denied", "Mã xác nhận không đúng.");
        }

        if (now.seconds > data.expiresAt.seconds) {
            await resetDoc.ref.delete();
            throw new HttpsError("deadline-exceeded", "Mã xác nhận đã hết hạn.");
        }

        // 1. Cập nhật mật khẩu trong Firebase Auth
        const user = await admin.auth().getUserByEmail(email);
        await admin.auth().updateUser(user.uid, {
            password: newPassword,
        });

        // 2. Xóa mã sau khi dùng
        await resetDoc.ref.delete();

        functions.logger.log(`Đã reset mật khẩu thành công cho ${email}`);
        return { success: true };
    } catch (error: any) {
        functions.logger.error("Lỗi resetPasswordWithCode:", error);
        if (error instanceof HttpsError) throw error;
        throw new HttpsError("internal", error.message || "Lỗi khi đổi mật khẩu.");
    }
});

export const generateAndSendSignupCode = onCall({ region: "asia-southeast1" }, async (request) => {
    const email = request.data.email;
    if (!email || !email.includes("@")) {
        throw new HttpsError("invalid-argument", "Địa chỉ email không hợp lệ.");
    }

    try {
        // 1. Kiểm tra xem email đã tồn tại chưa
        try {
            await admin.auth().getUserByEmail(email);
            throw new HttpsError("already-exists", "Email này đã được đăng ký.");
        } catch (e: any) {
            if (e.code === 'auth/user-not-found') {
                // Email chưa tồn tại, tiếp tục gửi mã
            } else {
                throw e;
            }
        }

        const code = Math.floor(100000 + Math.random() * 900000).toString();
        const expiresAt = admin.firestore.Timestamp.fromDate(new Date(Date.now() + 15 * 60000));

        await firestore.collection("signup_verification_codes").doc(email).set({
            code,
            expiresAt,
            createdAt: admin.firestore.FieldValue.serverTimestamp(),
        });

        await firestore.collection("mail").add({
            to: email,
            message: {
                subject: "Mã xác minh đăng ký tài khoản - SignalGPT",
                html: `Mã xác minh của bạn là: <b>${code}</b>. Mã này có hiệu lực trong 15 phút.`,
            },
        });

        functions.logger.log(`Đã tạo mã xác minh đăng ký cho ${email}: ${code}`);
        return { success: true };
    } catch (error: any) {
        functions.logger.error("Lỗi generateAndSendSignupCode:", error);
        if (error instanceof HttpsError) throw error;
        throw new HttpsError("internal", error.message || "Không thể gửi mã xác minh.");
    }
});

// =================================================================
// === STATS WEBHOOK CHO TELEGRAM BOT (BÁO CÁO LỢI NHUẬN) ===
// =================================================================
const STATS_CHAT_ID = "-1003103146104";

export const telegramStatsWebhook = functions.https.onRequest(
    { region: "asia-southeast1", timeoutSeconds: 30, memory: "256MiB" },
    async (req: functions.https.Request, res: Response) => {
        // FORCE LOG: Log toàn bộ body để debug
        functions.logger.info("🔥 WEBHOOK TRIGGERED! Body:", JSON.stringify(req.body));

        if (req.method !== "POST") {
            res.status(403).send("Forbidden!");
            return;
        }
        const update = req.body;
        const message = update.message || update.channel_post;
        
        if (!message) {
            functions.logger.warn("⚠️ No message found in update.");
            res.status(200).send("OK");
            return;
        }

        if (message.chat.id.toString() !== STATS_CHAT_ID) {
            functions.logger.info(`ℹ️ Chat ID mismatch. Expected: ${STATS_CHAT_ID}, Got: ${message.chat.id}`);
            res.status(200).send("OK");
            return;
        }

        const text = message.text;
        const messageDate = message.date; // Unix timestamp in seconds
        
        if (!text) {
            res.status(200).send("OK");
            return;
        }

        // DEBUG: Log nội dung tin nhắn nhận được để kiểm tra format
        functions.logger.log("Received Text Raw:", JSON.stringify(text));

        try {
            // 1. Xử lý "Tổng hợp lệnh XAU" (Intraday Update)
            // Mẫu: 📊 Tổng hợp lệnh XAU ngày 06/01/2026: ... 🧮 Tổng lệnh: +398.2 pip
            if (text.includes("Tổng hợp lệnh XAU")) {
                // Regex tinh chỉnh cho format nhiều dòng
                const dateRegex = /ngày\s+(\d{1,2}\/\d{1,2}\/\d{4})/i;
                const pipsRegex = /Tổng lệnh:\s*([+-]?[\d.,]+)\s*pip/i;
                const tpRegex = /TP:\s*(\d+)/i;
                const slRegex = /SL:\s*(\d+)/i;
                const exitRegex = /Exit:?\s*(\d+)/i; // Dấu : có thể có hoặc không tùy icon
                
                const dateMatch = text.match(dateRegex);
                const pipsMatch = text.match(pipsRegex);
                const tpMatch = text.match(tpRegex);
                const slMatch = text.match(slRegex);
                const exitMatch = text.match(exitRegex);

                if (dateMatch && pipsMatch) {
                    const dateStr = dateMatch[1];
                    // Thay thế dấu phẩy thành dấu chấm và loại bỏ khoảng trắng thừa
                    const pipsStr = pipsMatch[1].replace(/,/g, '.').trim();
                    const pips = parseFloat(pipsStr);
                    
                    const tpCount = tpMatch ? parseInt(tpMatch[1]) : 0;
                    const slCount = slMatch ? parseInt(slMatch[1]) : 0;
                    const exitCount = exitMatch ? parseInt(exitMatch[1]) : 0;
                    
                    const [day, month, year] = dateStr.split('/');
                    const docId = `${year}-${month}-${day}`;
                    const dateObj = new Date(parseInt(year), parseInt(month) - 1, parseInt(day));

                    // Tạo snapshot dữ liệu intraday
                    const intradaySnapshot = {
                        pips: pips,
                        tpCount: tpCount,
                        slCount: slCount,
                        exitCount: exitCount,
                        timestamp: admin.firestore.Timestamp.fromMillis(messageDate * 1000)
                    };

                    await firestore.collection("profit_stats").doc(docId).set({
                        date: admin.firestore.Timestamp.fromDate(dateObj),
                        // Thêm vào mảng intraday
                        xau_intraday: admin.firestore.FieldValue.arrayUnion(intradaySnapshot),
                        // Cập nhật giá trị tổng kết mới nhất cho XAU trong ngày
                        xau: {
                            pips: pips,
                            tpCount: tpCount,
                            slCount: slCount,
                            exitCount: exitCount,
                            lastUpdated: intradaySnapshot.timestamp
                        },
                        updatedAt: admin.firestore.FieldValue.serverTimestamp()
                    }, { merge: true });
                    
                    functions.logger.log(`✅ Đã cập nhật XAU [${docId}]: Pips=${pips}, TP=${tpCount}, SL=${slCount}, Exit=${exitCount}`);
                } else {
                     functions.logger.warn("⚠️ Không khớp Regex XAU.", { 
                        hasDate: !!dateMatch, 
                        hasPips: !!pipsMatch, 
                        textSample: text.substring(0, 50) 
                     });
                }
            }

            // 2. Xử lý "Báo cáo tổng hợp toàn bộ lệnh" (End of Day Summary)
            // Mẫu: 📅 Báo cáo tổng hợp toàn bộ lệnh ngày 05/01/2026 ...
            if (text.includes("Báo cáo tổng hợp toàn bộ lệnh")) {
                 const dateRegex = /ngày\s+(\d{1,2}\/\d{1,2}\/\d{4})/; // Regex for date
                 const tpRegex = /Số lệnh TP:\s*(\d+)\s*\(Tổng\s*([+-]?[\d.]+)\s*pip\)/; // Regex for TP count and pips
                 const slRegex = /Số lệnh SL:\s*(\d+)\s*\(Tổng\s*([+-]?[\d.]+)\s*pip\)/; // Regex for SL count and pips
                 const exitRegex = /Số lệnh Exit:\s*(\d+)\s*\(Tổng\s*([+-]?[\d.]+)\s*pip\)/; // Regex for Exit count and pips

                 const dateMatch = text.match(dateRegex);
                 const tpMatch = text.match(tpRegex);
                 const slMatch = text.match(slRegex);
                 const exitMatch = text.match(exitRegex);

                 if (dateMatch) {
                    const dateStr = dateMatch[1];
                    const [day, month, year] = dateStr.split('/');
                    const docId = `${year}-${month}-${day}`;
                    const dateObj = new Date(parseInt(year), parseInt(month) - 1, parseInt(day));

                    let totalPips = 0;
                    let tpCount = 0;
                    let slCount = 0;
                    let exitCount = 0;

                    if (tpMatch) {
                        tpCount = parseInt(tpMatch[1]);
                        totalPips += parseFloat(tpMatch[2]);
                    }
                    if (slMatch) {
                        slCount = parseInt(slMatch[1]);
                        totalPips += parseFloat(slMatch[2]);
                    }
                    if (exitMatch) {
                        exitCount = parseInt(exitMatch[1]);
                        totalPips += parseFloat(exitMatch[2]);
                    }

                    await firestore.collection("profit_stats").doc(docId).set({
                        date: admin.firestore.Timestamp.fromDate(dateObj),
                        all: {
                            pips: totalPips,
                            tpCount: tpCount,
                            slCount: slCount,
                            exitCount: exitCount
                        },
                        updatedAt: admin.firestore.FieldValue.serverTimestamp()
                    }, { merge: true });

                    functions.logger.log(`Đã cập nhật Stats ALL (End of Day) cho ngày ${docId}: ${totalPips} pips`);
                 }
            }

            res.status(200).send("OK");
        } catch (error) {
            functions.logger.error("Lỗi xử lý Stats Webhook:", error);
            res.status(500).send("Error");
        }
    }
);