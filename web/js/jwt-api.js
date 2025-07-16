// JWT API Client for testing
// Lớp JwtApiClient dùng để giao tiếp với API xác thực JWT (login, refresh, logout, check token)
class JwtApiClient {
    constructor(baseUrl = '') {
        this.baseUrl = baseUrl;
        this.accessToken = localStorage.getItem('accessToken');
        this.refreshToken = localStorage.getItem('refreshToken');
    }
    
    // Store tokens
    setTokens(accessToken, refreshToken) {
        this.accessToken = accessToken;
        this.refreshToken = refreshToken;
        localStorage.setItem('accessToken', accessToken);
        localStorage.setItem('refreshToken', refreshToken);
    }
    
    // Clear tokens
    clearTokens() {
        this.accessToken = null;
        this.refreshToken = null;
        localStorage.removeItem('accessToken');
        localStorage.removeItem('refreshToken');
    }
    
    // Get headers with authorization
    getHeaders() {
        const headers = {
            'Content-Type': 'application/x-www-form-urlencoded'
        };
        
        if (this.accessToken) {
            headers['Authorization'] = `Bearer ${this.accessToken}`;
        }
        
        return headers;
    }
    
    // Login
    /**
     * Gửi yêu cầu đăng nhập đến API, nhận về accessToken và refreshToken nếu thành công
     * @param email Email đăng nhập
     * @param password Mật khẩu
     * @returns Thông tin user và token nếu thành công, throw error nếu thất bại
     */
    async login(email, password) {
        try {
            const formData = new URLSearchParams();
            formData.append('email', email);
            formData.append('password', password);
            
            // Gửi request POST đến endpoint /api/auth/login
            const response = await fetch(`${this.baseUrl}/api/auth/login`, {
                method: 'POST',
                headers: this.getHeaders(),
                body: formData
            });
            
            const data = await response.json();
            
            // Nếu đăng nhập thành công, lưu token vào localStorage
            if (data.success !== false && data.accessToken) {
                this.setTokens(data.accessToken, data.refreshToken);
                return data;
            } else {
                throw new Error(data.error || 'Login failed');
            }
        } catch (error) {
            console.error('Login error:', error);
            throw error;
        }
    }
    
    // Refresh token
    async refreshToken() {
        try {
            if (!this.refreshToken) {
                throw new Error('No refresh token available');
            }
            
            const formData = new URLSearchParams();
            formData.append('refreshToken', this.refreshToken);
            
            const response = await fetch(`${this.baseUrl}/api/auth/refresh`, {
                method: 'POST',
                headers: this.getHeaders(),
                body: formData
            });
            
            const data = await response.json();
            
            if (data.accessToken) {
                this.accessToken = data.accessToken;
                localStorage.setItem('accessToken', data.accessToken);
                return data;
            } else {
                throw new Error(data.error || 'Token refresh failed');
            }
        } catch (error) {
            console.error('Token refresh error:', error);
            this.clearTokens();
            throw error;
        }
    }
    
    // Logout
    async logout() {
        try {
            const response = await fetch(`${this.baseUrl}/api/auth/logout`, {
                method: 'POST',
                headers: this.getHeaders()
            });
            
            this.clearTokens();
            return await response.json();
        } catch (error) {
            console.error('Logout error:', error);
            this.clearTokens();
            throw error;
        }
    }
    
    // Make authenticated request with automatic token refresh
    async authenticatedRequest(url, options = {}) {
        try {
            // Add authorization header
            options.headers = {
                ...this.getHeaders(),
                ...options.headers
            };
            
            let response = await fetch(url, options);
            
            // If unauthorized, try to refresh token
            if (response.status === 401 && this.refreshToken) {
                try {
                    await this.refreshToken();
                    
                    // Retry request with new token
                    options.headers['Authorization'] = `Bearer ${this.accessToken}`;
                    response = await fetch(url, options);
                } catch (refreshError) {
                    // Refresh failed, redirect to login
                    this.clearTokens();
                    window.location.href = '/login.jsp';
                    throw refreshError;
                }
            }
            
            return response;
        } catch (error) {
            console.error('Authenticated request error:', error);
            throw error;
        }
    }
}

// Test functions
async function testJwtLogin() {
    const client = new JwtApiClient();
    
    try {
        console.log('Testing JWT Login...');
        
        // Test login
        const loginResult = await client.login('test@example.com', 'password123');
        console.log('Login successful:', loginResult);
        
        // Test authenticated request
        const response = await client.authenticatedRequest('/api/user/info');
        const userInfo = await response.json();
        console.log('User info:', userInfo);
        
        // Test logout
        const logoutResult = await client.logout();
        console.log('Logout successful:', logoutResult);
        
    } catch (error) {
        console.error('Test failed:', error);
    }
}

// Export for use in other scripts
if (typeof module !== 'undefined' && module.exports) {
    module.exports = JwtApiClient;
} 