package dal;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBContext {
    private static DBContext instance = null;
    private Connection connection;

    public static synchronized DBContext getInstance() {
        if (instance == null) {
            instance = new DBContext();
        }
        return instance;
    }

    public Connection getConnection() throws SQLException {
        try {
            if (connection == null || connection.isClosed()) {
                String user = "root";
                String password = "msqldt154A!";
                String url = "jdbc:mysql://localhost:3306/project_g2?useSSL=false&serverTimezone=UTC&autoReconnect=true&failOverReadOnly=false&maxReconnects=10";

                Class.forName("com.mysql.cj.jdbc.Driver");
                connection = DriverManager.getConnection(url, user, password);
                System.out.println("MySQL connection successful!");
            }
            
            // Kiểm tra connection có hoạt động không
            if (!connection.isValid(5)) {
                System.out.println("Connection is invalid, recreating connection...");
                connection.close();
                connection = null;
                return getConnection();
            }
        } catch (ClassNotFoundException e) {
            System.out.println("MySQL Driver error: " + e.getMessage());
            throw new SQLException("Cannot find MySQL Driver");
        } catch (SQLException e) {
            System.out.println("MySQL connection error: " + e.getMessage());
            // Reset connection nếu có lỗi
            connection = null;
            throw e;
        }
        return connection;
    }

    DBContext() {
        // Private constructor để đảm bảo Singleton
    }

    public void closeConnection() {
        try {
            if (connection != null && !connection.isClosed()) {
                connection.close();
                System.out.println("MySQL connection closed!");
            }
        } catch (SQLException e) {
            System.out.println("Error closing connection: " + e.getMessage());
        }
    }

    public static void testConnection() {
        try {
            Connection conn = DBContext.getInstance().getConnection();
            System.out.println("Database connected successfully!");
            DBContext.getInstance().closeConnection();
        } catch (SQLException e) {
            System.out.println("Cannot connect to database: " + e.getMessage());
        }
    }

    public static void main(String[] args) {
        testConnection();
    }
} 