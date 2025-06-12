package Dal;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBContext {

    public Connection getConnection() throws ClassNotFoundException, SQLException {
        // Gắn toàn bộ thông tin kết nối vào URL
        String url = "jdbc:sqlserver://localhost:1433;"

                   + "databaseName=SWP;"
                   + "user=sa;"
                   + "password=123;"
                   + "encrypt=true;"
                   + "trustServerCertificate=true";

        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        return DriverManager.getConnection(url);
    }

    public static void main(String[] args) {
        try {
            DBContext db = new DBContext();
            Connection conn = db.getConnection();
            System.out.println("Kết nối thành công ");
            System.out.println("Đang kết nối tới database: " + conn.getCatalog());
        } catch (Exception e) {
            System.out.println("Lỗi kết nối database:");
            e.printStackTrace();
        }
    }
}