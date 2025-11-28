# AGENTS – Hướng dẫn cho Codex khi làm việc trong dự án Flutter + Firebase

## 1. Phong cách giao tiếp
- Luôn giao tiếp với tôi bằng **tiếng Việt**, ngắn gọn – rõ ràng – dễ hiểu.
- Code (tên biến, hàm, class) luôn dùng **tiếng Anh chuẩn Flutter/Firebase**.
- Thêm **comment tiếng Việt** khi logic phức tạp hoặc khi tôi yêu cầu.
- Trước khi thực hiện bất kỳ thay đổi nào trong code, hãy **giải thích ý tưởng** và xin xác nhận.

---

## 2. Kiến trúc & Công nghệ dự án
Dự án này sử dụng:

### Frontend
- Flutter (Dart)
- State management: giữ nguyên state management của project (Provider / Riverpod / Bloc / GetX / MVC)  
  → Hãy tự phát hiện khi đọc project.
- Cấu trúc chuẩn:
  - `lib/screens/` → UI screens
  - `lib/widgets/` → UI components
  - `lib/services/` → logic tương tác Firebase / backend
  - `lib/models/` → models, converters, DTO
  - `lib/utils/` → tiện ích, helpers

### Backend
- Firebase:
  - Authentication
  - Cloud Firestore
  - Cloud Functions (Node.js hoặc TypeScript)
  - Cloud Storage
  - Firestore Security Rules
  - Firebase Hosting (tùy project)

---

## 3. Quy tắc chỉnh sửa mã nguồn
Khi thực hiện thay đổi:

1. **Phân tích và đề xuất**
   - Đưa ra các bước dự định thực hiện.
   - Tóm tắt tác động (file nào sẽ bị thay đổi).
   - Chỉ thực sự chỉnh sửa sau khi tôi xác nhận.

2. **Chỉnh sửa file**
   - Thực hiện thay đổi rõ ràng, sạch.
   - Xử lý đúng cấu trúc project.
   - Giữ nguyên style coding có sẵn.
   - Không thay đổi những phần không liên quan.

3. **Tạo file mới**
   - Với UI: tạo file vào đúng thư mục `lib/screens` hoặc `lib/widgets`.
   - Với backend Firebase: tạo file trong `functions/src`.
   - Sử dụng import rõ ràng, tránh import thừa.

4. **Comment & documentation**
   - Chỉ thêm comment tiếng Việt khi cần giải thích logic.
   - Không comment những đoạn quá đơn giản.

---

## 4. Quy tắc xây UI Flutter
- Luôn ưu tiên **Widget tách nhỏ**, clean code, tránh build tree quá sâu.
- Tuân thủ các nguyên tắc:
  - Sử dụng `const` khi có thể.
  - Giảm bớt duplicated code.
  - UI phải phản hồi tốt (responsive): dùng LayoutBuilder / MediaQuery hoặc package có sẵn trong project.
- Khi dựa trên ảnh mockup:
  - Đọc ảnh trong project (assets) nếu tôi yêu cầu.
  - Tạo UI giống ảnh nhất có thể.
  - Tách widget hợp lý và đặt tên rõ ràng.

---

## 5. Làm việc với Firebase
### Firestore
- Ưu tiên viết:
  - Model class
  - `fromJson`, `toJson`
  - Converter  
- Viết query tối ưu, tránh đọc toàn bộ collection.
- Tuân thủ rule:
  - User chỉ được đọc/ghi tài liệu của chính họ, nếu tôi không yêu cầu khác.

### Cloud Functions
- Nguyên tắc:
  - Code TypeScript nếu project đã dùng TS; nếu không hãy đề xuất chuyển sang TS.
  - Cấu trúc rõ ràng: chia nhỏ functions khi cần.
  - Viết log hợp lý (`console.log`).
  - Xử lý lỗi đầy đủ (`try/catch`).

### Security Rules
- Khi chỉnh rules:
  - Giải thích logic bằng tiếng Việt.
  - Đảm bảo tối thiểu:
    - auth.uid == resource.id trong `users/{uid}`
    - Validate schema khi cần thiết

---

## 6. Testing
- Với Flutter:
  - Tạo widget test hoặc unit test khi cần.
  - Test đặt trong `test/`.
  - Chỉ generate test khi tôi yêu cầu.

- Với Firebase Functions:
  - Viết test TypeScript nếu project đang có setup jest.
  - Nếu không có, đề xuất setup nhưng chờ tôi xác nhận.

---

## 7. Khi chạy lệnh terminal
- Khi bạn cần chạy lệnh:
  - Hãy nói rõ lệnh bạn định chạy.
  - Chỉ chạy khi tôi xác nhận.
- Ưu tiên:
  - `flutter pub get`
  - `flutter run`
  - `firebase deploy` (chỉ khi tôi đồng ý)
  - `npm install` / `npm run build` cho functions

---

## 8. Làm việc với hình ảnh trong project
- Codex có thể đọc & phân tích ảnh **nếu ảnh nằm trong project**.
- Khi tôi yêu cầu phân tích ảnh:
  - Hãy mở đúng file ảnh trong thư mục assets.
  - Mô tả rõ cấu trúc UI.
  - Generate code Flutter tương ứng.

---

## 9. Hạn chế & cảnh báo khi chỉnh sửa
- Không xóa file nếu tôi không yêu cầu.
- Không thay đổi cấu trúc project trừ khi được phép.
- Không tự ý đổi thư viện hoặc state management.
- Khi thay đổi nhiều file:
  - Hãy tóm tắt diff.
  - Giải thích rõ công việc.

---

## 10. Nguyên tắc chung khi hỗ trợ phát triển tính năng
Khi tôi yêu cầu một tính năng mới:

1. Hiểu yêu cầu bằng tiếng Việt.
2. Đề xuất kiến trúc hoặc flow.
3. Xác nhận.
4. Tạo code:
   - UI + logic + model + Firebase (nếu cần).
5. Hướng dẫn tôi cách sử dụng hoặc test tính năng.
6. Đảm bảo mọi thứ hoạt động trong project Flutter.

---

## 11. Mục tiêu quan trọng nhất
- Giúp tôi phát triển **nhanh – chính xác – sạch sẽ**.
- Hợp tác như một “senior Flutter + Firebase engineer”.
- Giải thích đủ nhưng không lan man.
- Luôn ưu tiên chất lượng code.

