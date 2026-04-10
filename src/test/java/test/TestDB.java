package test;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class TestDB {
    public static void main(String[] args) {
        String url = "jdbc:sqlserver://localhost:1433;databaseName=shopquanao;encrypt=false;trustServerCertificate=true;characterEncoding=UTF-8";
        String user = "sa";
        String pass = "Hieu1234@";
        
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            try (Connection conn = DriverManager.getConnection(url, user, pass);
                 Statement stmt = conn.createStatement()) {
                
                System.out.println("Kiểm tra database shopquanao:");
                
                String[] tables = {"users", "categories", "products"};
                for (String t : tables) {
                    try (ResultSet rs = stmt.executeQuery("SELECT count(*) FROM " + t)) {
                        if (rs.next()) {
                            System.out.println("Bảng " + t + ": " + rs.getInt(1) + " dòng");
                        }
                    } catch (Exception e) {
                        System.out.println("Lỗi bảng " + t + ": " + e.getMessage());
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
