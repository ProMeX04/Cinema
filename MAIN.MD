Sau đây là checklist các lỗi thường gặp cho phần "Analysis - for system part and module class diagram" dưới dạng bảng câu hỏi, được chia thành các danh mục để dễ theo dõi và kiểm tra.

### **Checklist Lỗi Thường Gặp Trong Sơ Đồ Lớp Giai Đoạn Phân Tích**

#### **I. Sơ Đồ Lớp Toàn Hệ Thống (System-level Class Diagram)**

| Mô tả (Dạng câu hỏi) | Phân loại (Category) |
| --- | --- |
| Sơ đồ lớp đã thể hiện được đầy đủ các khái niệm (concepts) chính trong miền vấn đề chưa? | Mức độ hoàn thiện |
| Có lớp nào bị bỏ sót dù đã được mô tả trong tài liệu yêu cầu không? | Mức độ hoàn thiện |
| Tên của các lớp đã thể hiện đúng bản chất và trách nhiệm của nó trong hệ thống chưa? | Quy ước đặt tên |
| Có tồn tại các lớp có tên gọi chung chung, mơ hồ (ví dụ: "Manager", "Data", "Info") gây khó hiểu không? | Quy ước đặt tên |
| Các mối quan hệ (association, aggregation, composition, inheritance) giữa các lớp đã được xác định và thể hiện đúng bản chất chưa? | Mối quan hệ |
| Có mối quan hệ nào bị thừa hoặc thiếu so với mô tả nghiệp vụ không? | Mối quan hệ |
| Đã xác định đúng bản số (multiplicity) cho các mối quan hệ chưa (ví dụ: một-một, một-nhiều, nhiều-nhiều)? | Mối quan hệ |
| Có sự nhầm lẫn giữa quan hệ tập hợp (Aggregation) và quan hệ hợp thành (Composition) không? | Mối quan hệ |
| Quan hệ kế thừa (Inheritance) có được sử dụng đúng logic "is-a" (là một loại của) không? | Mối quan hệ |
| Sơ đồ có quá phức tạp và nhiều chi tiết không cần thiết, gây khó đọc và khó hiểu không? | Tính rõ ràng |
| Các lớp đã được nhóm lại thành các gói (package) một cách logic để dễ quản lý và theo dõi chưa? | Cấu trúc tổng thể |

#### **II. Sơ Đồ Lớp Cho Từng Module (Module-level Class Diagram)**

| Mô tả (Dạng câu hỏi) | Phân loại (Category) |
| --- | --- |
| Sơ đồ lớp của module có bao quát hết các chức năng được yêu cầu của module đó không? | Mức độ hoàn thiện |
| Các lớp trong module có thực sự liên quan chặt chẽ đến chức năng của module hay không (tính gắn kết cao - high cohesion)? | Thiết kế module |
| Có thuộc tính (attribute) quan trọng nào của lớp bị bỏ sót không? | Thuộc tính |
| Các thuộc tính có được đặt trong đúng lớp của nó không? | Thuộc tính |
| Có thuộc tính nào có thể được suy ra từ các thuộc tính khác (thuộc tính dẫn xuất) nhưng vẫn được định nghĩa tường minh không? | Thuộc tính |
| Tên thuộc tính đã mô tả rõ ràng ý nghĩa của nó chưa? | Quy ước đặt tên |
| Đã xác định được các phương thức (method) chính mà lớp cần có để thực hiện trách nhiệm của nó chưa? | Phương thức |
| Tên phương thức có thể hiện rõ hành động mà nó thực hiện không (thường bắt đầu bằng động từ)? | Quy ước đặt tên |
| Có phương thức nào được đặt sai lớp, không đúng với trách nhiệm của lớp đó không? | Phương thức |
| Các mối quan hệ giữa các lớp trong module đã chính xác và phù hợp với luồng xử lý của module chưa? | Mối quan hệ |
| Có tồn tại các mối quan hệ không cần thiết hoặc các đường liên kết gây rối trong sơ đồ không? | Mối quan hệ |
| Sơ đồ lớp của module có nhất quán với sơ đồ lớp của toàn hệ thống và các module khác không? | Tính nhất quán |
| Có lớp hoặc thuộc tính nào có tên gọi khác nhau ở các sơ đồ khác nhau nhưng lại cùng chỉ một đối tượng không? | Tính nhất quán |