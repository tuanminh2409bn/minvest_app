//localization.ts

import { v2 as translate } from '@google-cloud/translate';

// Khởi tạo Google Translate client một lần duy nhất
const translateClient = new translate.Translate();

// Định nghĩa các loại thông báo mà chúng ta sẽ dịch
type NotificationType = 'new_signal' | 'signal_matched' | 'tp1_hit' | 'tp2_hit' | 'tp3_hit' | 'sl_hit';

// Các ngôn ngữ mục tiêu (ngoài tiếng Việt là gốc)
// zh: Tiếng Trung (Giản thể - Google dùng 'zh' hoặc 'zh-CN')
// fr: Tiếng Pháp
// ja: Tiếng Nhật
// ko: Tiếng Hàn
const TARGET_LANGUAGES = ['en', 'zh', 'fr', 'ja', 'ko'];

// Định nghĩa cấu trúc cho các mẫu câu
interface Template {
    title: string;
    body: string;
}

// Chứa tất cả các mẫu câu gốc bằng tiếng Việt
const templates: Record<NotificationType, Template> = {
    new_signal: {
        title: "⚡️ Tín hiệu mới: {0} {1}", // {0}: loại lệnh (MUA/BÁN), {1}: cặp tiền
        body: "Entry: {2} | SL: {3}",     // {2}: giá entry, {3}: giá SL
    },
    signal_matched: {
        title: "✅ {0} {1} Đã khớp lệnh!", // {0}: loại lệnh, {1}: cặp tiền
        body: "Tín hiệu đã khớp entry tại giá {2}.", // {2}: giá entry
    },
    tp1_hit: {
        title: "🎯 {0} {1} đã đạt TP1!",
        body: "Chúc mừng! Tín hiệu đã chốt lời ở mức TP1.",
    },
    tp2_hit: {
        title: "🎯🎯 {0} {1} đã đạt TP2!",
        body: "Xuất sắc! Tín hiệu tiếp tục chốt lời ở mức TP2.",
    },
    tp3_hit: {
        title: "🏆 {0} {1} đã đạt TP3!",
        body: "Mục tiêu cuối cùng đã hoàn thành!",
    },
    sl_hit: {
        title: "❌ {0} {1} đã chạm Stop Loss.",
        body: "Rất tiếc, tín hiệu đã chạm điểm dừng lỗ.",
    },
};

/**
 * Hàm này nhận loại thông báo và dữ liệu, trả về một đối tượng chứa title và body
 * đã được dịch sang TẤT CẢ các ngôn ngữ được hỗ trợ.
 */
export async function getLocalizedPayload(type: NotificationType, ...args: (string | number)[]) {
    const template = templates[type];

    // 1. Tạo nội dung tiếng Việt từ mẫu câu
    const titleVi = template.title.replace(/{(\d+)}/g, (match, index) => String(args[Number(index)] ?? ''));
    const bodyVi = template.body.replace(/{(\d+)}/g, (match, index) => String(args[Number(index)] ?? ''));

    // Khởi tạo object kết quả với tiếng Việt trước
    const titleLoc: Record<string, string> = { vi: titleVi };
    const bodyLoc: Record<string, string> = { vi: bodyVi };

    try {
        // 2. Dịch đồng thời sang tất cả các ngôn ngữ mục tiêu
        const translationPromises = TARGET_LANGUAGES.map(async (lang) => {
            try {
                // translateClient.translate trả về [string, metadata]
                const [titleTranslated] = await translateClient.translate(titleVi, lang);
                const [bodyTranslated] = await translateClient.translate(bodyVi, lang);
                return { lang, title: titleTranslated, body: bodyTranslated };
            } catch (err) {
                console.error(`Lỗi dịch sang ngôn ngữ '${lang}':`, err);
                // Nếu lỗi, fallback về tiếng Anh (nếu có) hoặc tiếng Việt
                return { lang, title: titleVi, body: bodyVi }; 
            }
        });

        const results = await Promise.all(translationPromises);

        // 3. Gán kết quả vào object
        results.forEach((res) => {
            titleLoc[res.lang] = res.title;
            bodyLoc[res.lang] = res.body;
        });

        return {
            title_loc: titleLoc,
            body_loc: bodyLoc,
        };
    } catch (error) {
        console.error(`Lỗi tổng quan khi dịch thuật cho loại '${type}':`, error);
        // Fallback an toàn: tất cả ngôn ngữ dùng tiếng Việt
        TARGET_LANGUAGES.forEach(lang => {
            titleLoc[lang] = titleVi;
            bodyLoc[lang] = bodyVi;
        });
        
        return {
            title_loc: titleLoc,
            body_loc: bodyLoc,
        };
    }
}