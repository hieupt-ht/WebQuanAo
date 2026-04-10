import java.sql.*;

public class CheckDB {
    public static void main(String[] args) {
        String url = "jdbc:sqlserver://localhost:1433;databaseName=shopquanao;encrypt=false;trustServerCertificate=true;characterEncoding=UTF-8";
        String user = "sa";
        String pass = "Hieu1234@";
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            try (Connection conn = DriverManager.getConnection(url, user, pass)) {
                System.out.println("Kết nối tới DB thành công!");
                
                String[] tables = {"users", "categories", "products"};
                for (String table : tables) {
                    try (Statement stmt = conn.createStatement();
                         ResultSet rs = stmt.executeQuery("SELECT COUNT(*) FROM " + table)) {
                        if (rs.next()) {
                            System.out.println("Số lượng bản ghi trong " + table + ": " + rs.getInt(1));
                        }
                    } catch (SQLException e) {
                        System.out.println("Lỗi khi truy vấn bảng " + table + ": " + e.getMessage());
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
