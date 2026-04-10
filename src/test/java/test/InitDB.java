package test;

import java.io.BufferedReader;
import java.io.FileReader;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;

public class InitDB {
    public static void main(String[] args) {
        String url = "jdbc:sqlserver://localhost:1433;databaseName=master;encrypt=false;trustServerCertificate=true;characterEncoding=UTF-8";
        String user = "sa";
        String pass = "Hieu1234@";
        
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            try (Connection conn = DriverManager.getConnection(url, user, pass);
                 Statement stmt = conn.createStatement()) {
                
                System.out.println("Kết nối tới SQL Server thành công!");
                
                // Read and execute the SQL file manually
                try (BufferedReader br = new BufferedReader(new FileReader("database.sql"))) {
                    StringBuilder batch = new StringBuilder();
                    String line;
                    while ((line = br.readLine()) != null) {
                        if (line.trim().equalsIgnoreCase("GO")) {
                            if (batch.length() > 0) {
                                try {
                                    stmt.execute(batch.toString());
                                    System.out.println("Thực thi thành công khối SQL...");
                                } catch (Exception e) {
                                    System.out.println("Lỗi thực thi khối SQL: " + e.getMessage());
                                    // System.out.println("Khối SQL lỗi: " + batch.toString());
                                }
                                batch = new StringBuilder();
                            }
                        } else {
                            batch.append(line).append("\n");
                        }
                    }
                    if (batch.length() > 0) {
                        try {
                            stmt.execute(batch.toString());
                            System.out.println("Thực thi thành công khối SQL cuối...");
                        } catch (Exception e) {
                            System.out.println("Lỗi thực thi khối SQL cuối: " + e.getMessage());
                        }
                    }
                }
                
                System.out.println("Hoàn tất nạp dữ liệu!");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
