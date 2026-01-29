//localization.ts

// Định nghĩa các loại thông báo
type NotificationType = 'new_signal' | 'signal_matched' | 'tp1_hit' | 'tp2_hit' | 'tp3_hit' | 'sl_hit';

// Các ngôn ngữ được hệ thống hỗ trợ
// Dù user chọn ngôn ngữ nào, chúng ta cũng sẽ trả về tiếng Anh theo yêu cầu mới.
const ALL_LANGUAGES = ['en', 'vi', 'zh', 'fr', 'ja', 'ko'];

// Định nghĩa cấu trúc cho các mẫu câu
interface Template {
    en: { title: string; body: string };
}

// Chứa tất cả các mẫu câu gốc CHỈ bằng tiếng Anh
const templates: Record<NotificationType, Template> = {
    new_signal: {
        en: {
            title: "⚡️ New Signal: {0} {1}",
            body: "Entry: {2} | SL: {3}",
        }
    },
    signal_matched: {
        en: {
            title: "✅ {0} {1} Entry Matched!",
            body: "Signal has hit entry at price {2}.",
        }
    },
    tp1_hit: {
        en: {
            title: "🎯 {0} {1} TP1 Hit!",
            body: "Congratulations! Signal has hit Take Profit 1.",
        }
    },
    tp2_hit: {
        en: {
            title: "🎯🎯 {0} {1} TP2 Hit!",
            body: "Excellent! Signal has hit Take Profit 2.",
        }
    },
    tp3_hit: {
        en: {
            title: "🏆 {0} {1} TP3 Hit!",
            body: "Final target completed!",
        }
    },
    sl_hit: {
        en: {
            title: "❌ {0} {1} Stop Loss Hit.",
            body: "Sorry, the signal has hit Stop Loss.",
        }
    },
};

/**
 * Hàm này nhận loại thông báo và dữ liệu, trả về một đối tượng chứa title và body
 * TOÀN BỘ LÀ TIẾNG ANH cho tất cả các key ngôn ngữ.
 */
export async function getLocalizedPayload(type: NotificationType, ...args: (string | number)[]) {
    const template = templates[type];

    // Tạo nội dung tiếng Anh
    const titleEn = template.en.title.replace(/{(\d+)}/g, (match, index) => String(args[Number(index)] ?? ''));
    const bodyEn = template.en.body.replace(/{(\d+)}/g, (match, index) => String(args[Number(index)] ?? ''));

    // Khởi tạo object kết quả
    const titleLoc: Record<string, string> = {};
    const bodyLoc: Record<string, string> = {};

    // Gán nội dung tiếng Anh cho TẤT CẢ các mã ngôn ngữ (bao gồm 'vi')
    ALL_LANGUAGES.forEach(lang => {
        titleLoc[lang] = titleEn;
        bodyLoc[lang] = bodyEn;
    });

    return {
        title_loc: titleLoc,
        body_loc: bodyLoc,
    };
}