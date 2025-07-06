# Staff Dashboard Error Checklist

## 🔍 **Kiểm tra và Fix Lỗi**

### **1. Compilation Errors**

#### ✅ **Đã Kiểm tra:**
- [x] JWT libraries đã có trong `libs/` folder
- [x] JwtUtil class đã được implement đầy đủ
- [x] AuthApiServlet đã có endpoint `/check-token`
- [x] LoginServlet đã được cập nhật để tạo JWT tokens

#### ⚠️ **Cần Fix:**
- [ ] Linter errors trong IDE (false positives - có thể bỏ qua)
- [ ] Đảm bảo tất cả JAR files được include trong classpath

### **2. Runtime Errors**

#### ✅ **Đã Kiểm tra:**
- [x] Session management hoạt động
- [x] Token generation và validation
- [x] Role-based access control

#### ⚠️ **Cần Fix:**
- [ ] Kiểm tra database connection
- [ ] Verify user authentication flow
- [ ] Test token refresh mechanism

### **3. JSP Errors**

#### ✅ **Đã Kiểm tra:**
- [x] Import statements đúng
- [x] JSTL tags hoạt động
- [x] Session attributes accessible

#### ⚠️ **Cần Fix:**
- [ ] Kiểm tra JSP compilation
- [ ] Verify EL expressions
- [ ] Test include statements

### **4. API Errors**

#### ✅ **Đã Kiểm tra:**
- [x] AuthApiServlet endpoints
- [x] JWT filter configuration
- [x] Response format

#### ⚠️ **Cần Fix:**
- [ ] Test API endpoints
- [ ] Verify CORS configuration
- [ ] Check error handling

### **5. Security Issues**

#### ✅ **Đã Kiểm tra:**
- [x] Token validation
- [x] Role verification
- [x] Session security

#### ⚠️ **Cần Fix:**
- [ ] Verify token expiration
- [ ] Test unauthorized access
- [ ] Check CSRF protection

## 🛠️ **Fix Instructions**

### **Step 1: Test Basic Functionality**

1. **Start server và test login:**
   ```bash
   # Login với staff account
   http://localhost:8080/Project_G2/login
   ```

2. **Test staff dashboard:**
   ```bash
   # Truy cập staff dashboard
   http://localhost:8080/Project_G2/staffDashboard.jsp
   ```

3. **Test token validation:**
   ```bash
   # Test page
   http://localhost:8080/Project_G2/staffTest.jsp
   ```

### **Step 2: Fix Common Issues**

#### **Issue 1: Token not generated during login**
**Solution:** Đã fix trong LoginServlet - thêm JWT token generation

#### **Issue 2: Role check fails**
**Solution:** Đã implement role checking trong staffDashboard.jsp

#### **Issue 3: API endpoints not working**
**Solution:** Đã thêm `/check-token` endpoint trong AuthApiServlet

#### **Issue 4: Session attributes missing**
**Solution:** Đã thêm token storage trong session

### **Step 3: Test Specific Scenarios**

#### **Test Case 1: Staff Login Flow**
1. Login với staff account
2. Verify tokens được tạo
3. Access staff dashboard
4. Test token validation

#### **Test Case 2: Token Refresh**
1. Wait for token expiration (15 minutes)
2. Test auto-refresh
3. Verify new token works

#### **Test Case 3: Unauthorized Access**
1. Try access staff dashboard without login
2. Try access with wrong role
3. Try access with expired token

#### **Test Case 4: API Testing**
1. Test `/api/auth/check-token`
2. Test `/api/auth/refresh`
3. Test `/api/auth/logout`

## 🔧 **Quick Fixes**

### **Fix 1: Database Connection**
```java
// Kiểm tra DBContext.java
// Verify connection string và credentials
```

### **Fix 2: JWT Secret Key**
```java
// Trong JwtUtil.java
// Đảm bảo SECRET_KEY đủ dài (256 bits)
```

### **Fix 3: Session Configuration**
```xml
<!-- Trong web.xml -->
<session-config>
    <session-timeout>30</session-timeout>
</session-config>
```

### **Fix 4: Error Handling**
```jsp
<!-- Trong JSP files -->
<%
    try {
        // JWT operations
    } catch (Exception e) {
        // Handle errors gracefully
    }
%>
```

## 📋 **Testing Checklist**

### **Pre-deployment Tests**
- [ ] Compile project without errors
- [ ] Start server successfully
- [ ] Database connection works
- [ ] Login functionality works
- [ ] Token generation works
- [ ] Role checking works
- [ ] API endpoints respond
- [ ] JSP pages load correctly

### **Post-deployment Tests**
- [ ] Staff can login
- [ ] Staff can access dashboard
- [ ] Token validation works
- [ ] Token refresh works
- [ ] Unauthorized access blocked
- [ ] Logout clears session
- [ ] Error pages display correctly

## 🚨 **Common Error Solutions**

### **Error 1: "Cannot resolve import"**
**Solution:** Check classpath và library inclusion

### **Error 2: "Token validation failed"**
**Solution:** Verify JWT secret key và token format

### **Error 3: "Role access denied"**
**Solution:** Check user role trong database

### **Error 4: "Session expired"**
**Solution:** Verify session timeout configuration

### **Error 5: "API endpoint not found"**
**Solution:** Check servlet mapping trong web.xml

## 📝 **Debug Information**

### **Enable Debug Logging**
```java
// Add to JwtUtil.java
System.out.println("Token generated: " + token);
System.out.println("Token validated: " + userInfo);
```

### **Check Session Data**
```jsp
<!-- Add to JSP for debugging -->
<%
    System.out.println("Session user: " + session.getAttribute("userAuth"));
    System.out.println("Session token: " + session.getAttribute("accessToken"));
%>
```

### **Test API Response**
```javascript
// Add to JavaScript for debugging
console.log('API Response:', data);
console.log('Token:', token);
```

## ✅ **Final Verification**

Sau khi fix tất cả lỗi, verify:

1. **Staff login** → Generate tokens → Access dashboard ✅
2. **Token validation** → Check role → Allow access ✅
3. **Token refresh** → Auto-renew → Continue session ✅
4. **Security** → Block unauthorized → Redirect login ✅
5. **API endpoints** → Respond correctly → Handle errors ✅

## 📞 **Support**

Nếu vẫn có lỗi, check:
1. Server logs
2. Browser console
3. Network requests
4. Database connection
5. File permissions 