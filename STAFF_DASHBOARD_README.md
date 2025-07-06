# Staff Dashboard với Token Management

## Tổng quan

Staff Dashboard được tạo để cho phép các user có role "staff" đăng nhập và quản lý hệ thống với token-based authentication. Dashboard này tương tự như Admin Dashboard nhưng được thiết kế riêng cho staff với các quyền hạn phù hợp.

## Tính năng chính

### 1. Token Management
- **JWT Authentication**: Sử dụng JWT (JSON Web Token) để xác thực
- **Access Token**: Token ngắn hạn (15 phút) cho các hoạt động thường xuyên
- **Refresh Token**: Token dài hạn (7 ngày) để làm mới access token
- **Auto Refresh**: Tự động làm mới token khi hết hạn

### 2. Role-based Access Control
- Chỉ cho phép user có role "staff" truy cập
- Kiểm tra token role để đảm bảo quyền truy cập
- Redirect về trang login nếu không có quyền

### 3. UI/UX Features
- Responsive design với Bootstrap 5
- Staff-specific styling với màu xanh lá
- Token status indicator
- Real-time token validation

## Cấu trúc Files

### JSP Files
- `web/staffDashboard.jsp` - Main dashboard page
- `web/staffSidebar.jsp` - Navigation sidebar cho staff
- `web/staffHome.jsp` - Home page content
- `web/staffDashboardTest.jsp` - Test page để kiểm tra token

### Java Files
- `src/java/controller/AuthApiServlet.java` - API endpoints cho authentication
- `src/java/util/JwtUtil.java` - JWT utility functions
- `src/java/filter/JwtAuthenticationFilter.java` - JWT filter cho API protection

## Cách sử dụng

### 1. Đăng nhập với Staff Account
```bash
# Truy cập trang login
http://localhost:8080/Project_G2/login

# Đăng nhập với tài khoản có role "staff"
```

### 2. Truy cập Staff Dashboard
```bash
# Truy cập trực tiếp
http://localhost:8080/Project_G2/staffDashboard.jsp

# Hoặc qua test page
http://localhost:8080/Project_G2/staffDashboardTest.jsp
```

### 3. API Endpoints

#### Check Token
```http
POST /api/auth/check-token
Authorization: Bearer <access_token>
Content-Type: application/json
```

#### Refresh Token
```http
POST /api/auth/refresh
Content-Type: application/json

{
  "refreshToken": "<refresh_token>"
}
```

#### Logout
```http
POST /api/auth/logout
Authorization: Bearer <access_token>
```

## Token Flow

### 1. Login Process
1. User đăng nhập với email/password
2. Server validate credentials
3. Generate access token và refresh token
4. Store tokens trong session
5. Redirect đến staff dashboard

### 2. Token Validation
1. Mỗi request kiểm tra access token
2. Nếu token hết hạn, sử dụng refresh token
3. Generate new access token
4. Update session với token mới

### 3. Auto Refresh
- JavaScript check token mỗi 5 phút
- Tự động refresh nếu cần thiết
- Redirect to login nếu cả hai token đều invalid

## Security Features

### 1. Token Security
- HMAC-SHA256 signature
- Expiration time validation
- Role-based validation
- Secure token storage

### 2. Access Control
- Role verification
- Session management
- Automatic logout on invalid token

### 3. API Protection
- JWT filter cho tất cả API endpoints
- CORS handling
- Error handling

## Customization

### 1. Styling
- Modify CSS trong `staffDashboard.jsp`
- Change color scheme (currently green theme)
- Update sidebar styling

### 2. Permissions
- Edit role checks trong JSP files
- Modify sidebar menu items
- Update access control logic

### 3. Token Configuration
- Change token expiration times trong `JwtUtil.java`
- Update secret key
- Modify token payload structure

## Troubleshooting

### 1. Token Issues
- Check browser console cho JavaScript errors
- Verify token trong session
- Test API endpoints

### 2. Access Denied
- Verify user role là "staff"
- Check token validity
- Ensure proper login flow

### 3. API Errors
- Check server logs
- Verify endpoint URLs
- Test with Postman/curl

## Testing

### 1. Manual Testing
1. Login với staff account
2. Access staff dashboard
3. Test token refresh
4. Verify role restrictions

### 2. Automated Testing
- Use `staffDashboardTest.jsp` để test token
- Check API responses
- Verify UI functionality

## Dependencies

### Required Libraries
- `gson-2.10.1.jar` - JSON processing
- `jjwt-api-0.12.3.jar` - JWT handling
- `jakarta.servlet-api-4.0.4.jar` - Servlet API
- `spring-security-crypto-5.8.5.jar` - Password encryption

### Web Dependencies
- Bootstrap 5.3.0
- Font Awesome 6.0.0
- jQuery (if needed)

## Notes

- Staff dashboard chỉ hiển thị các chức năng phù hợp với role staff
- Token được lưu trong session, không phải localStorage
- Auto-refresh chỉ hoạt động khi user active trên trang
- Logout sẽ clear tất cả tokens và session data 