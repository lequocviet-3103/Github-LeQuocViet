# SWP391-BE
https://docs.google.com/document/d/1T3EYg2VZFC7tm7bPtop-myZqG6gd1xtwCkkbvFYU6Tw/edit?tab=t.0


📄 DANH SÁCH API DỰ ÁN


✅ 1. Guest (Không cần đăng nhập)
GET /blogs – Xem danh sách bài viết, tin tức

POST /auth/register – Đăng ký tài khoản

POST /auth/login – Đăng nhập

POST /auth/forgot – Quên mật khẩu

✅ 2. Customer (Bệnh nhân, cần đăng nhập)
GET /user/profile – Lấy thông tin cá nhân

PUT /user/profile – Cập nhật thông tin cá nhân

GET /appointments – Xem lịch hẹn

POST /appointments – Đặt lịch khám hoặc tư vấn

GET /appointments/{id} – Chi tiết lịch hẹn

PUT /appointments/{id}/status – Hủy hoặc xác nhận lịch hẹn

GET /patients/{id}/appointments – Xem lịch của bệnh nhân

GET /patients/{id}/medical-records – Xem hồ sơ y tế cá nhân

GET /patients/{id}/treatments – Xem thông tin điều trị

GET /medical-records/{id} – Chi tiết hồ sơ

GET /treatments – Danh sách điều trị

GET /treatments/{id} – Chi tiết điều trị

GET /prescriptions – Danh sách đơn thuốc

GET /prescriptions/{id} – Chi tiết đơn thuốc


✅ 3. Staff (Nhân viên y tế)
GET /patients – Danh sách bệnh nhân

GET /patients/{id} – Chi tiết bệnh nhân

GET /appointments – Lịch hẹn

GET /appointments/{id} – Chi tiết

PUT /appointments/{id}/status – Cập nhật trạng thái

GET /medical-records – Danh sách hồ sơ

GET /medical-records/{id} – Chi tiết

✅ 4. Doctor (Bác sĩ)
Tất cả quyền như Staff, cộng thêm:

GET /doctors – Danh sách bác sĩ (để chọn tư vấn)

POST /treatments – Tạo mới điều trị

PUT /treatments/{id} – Cập nhật điều trị

DELETE /treatments/{id} – Xóa điều trị

PUT /prescriptions/{id} – Cập nhật đơn thuốc

DELETE /prescriptions/{id} – Xóa đơn thuốc

✅ 5. Manager (Quản lý)
Tất cả quyền của Doctor & Staff, cộng thêm:

GET /dashboard/stats – Thống kê hệ thống

GET /user/list – Danh sách user (admin/manager/staff/doctor/patient)

GET /user/roles – Lấy danh sách vai trò người dùng

✅ 6. Admin
Toàn quyền tạo, sửa, xóa tài khoản mọi vai trò (thường thực hiện qua POST/PUT/DELETE với /user/*, có thể được bổ sung thêm nếu cần)
