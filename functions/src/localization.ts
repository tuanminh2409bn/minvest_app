//localization.ts

import { v2 as translate } from '@google-cloud/translate';

// Khởi tạo Google Translate client một lần duy nhất
const translateClient = new translate.Translate();

// Định nghĩa các loại thông báo mà chúng ta sẽ dịch
type NotificationType = 'new_signal' | 'signal_matched' | 'tp1_hit' | 'tp2_hit' | 'tp3_hit' | 'sl_hit';

// Định nghĩa cấu trúc cho các mẫu câu
interface Template {
    title: string;
    body: string;
}

// Chứa tất cả các mẫu câu gốc bằng tiếng Việt
// Các số trong ngoặc nhọn {0}, {1},... là các tham số sẽ được thay thế sau này
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
 * đã được dịch sang các ngôn ngữ được hỗ trợ (vi, en).
 * @param type Loại thông báo (ví dụ: 'new_signal').
 * @param args Danh sách các giá trị động để điền vào mẫu câu (ví dụ: 'BUY', 'XAU/USD', 1234.5).
 * @returns Một Promise chứa đối tượng payload đã được bản địa hóa.
 */
export async function getLocalizedPayload(type: NotificationType, ...args: (string | number)[]) {
    const template = templates[type];

    // 1. Tạo nội dung tiếng Việt từ mẫu câu
    const titleVi = template.title.replace(/{(\d+)}/g, (match, index) => String(args[Number(index)] ?? ''));
    const bodyVi = template.body.replace(/{(\d+)}/g, (match, index) => String(args[Number(index)] ?? ''));

    try {
        // 2. Dịch đồng thời cả title và body sang tiếng Anh để tối ưu thời gian
        const [translations] = await translateClient.translate([titleVi, bodyVi], 'en');
        const [titleEn, bodyEn] = translations;

        // 3. Trả về đối tượng chứa cả 2 ngôn ngữ
        return {
            title_loc: { vi: titleVi, en: titleEn },
            body_loc: { vi: bodyVi, en: bodyEn },
        };
    } catch (error) {
        console.error(`Lỗi dịch thuật cho thông báo loại '${type}':`, error);
        // Trong trường hợp dịch lỗi, sử dụng tiếng Việt làm ngôn ngữ dự phòng cho tiếng Anh
        // để không làm gián đoạn luồng gửi thông báo.
        return {
            title_loc: { vi: titleVi, en: titleVi }, // Dự phòng
            body_loc: { vi: bodyVi, en: bodyVi },   // Dự phòng
        };
    }
}