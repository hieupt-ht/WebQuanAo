package test;

import com.shop.dao.ProductDAO;
import com.shop.entity.Product;
import java.util.List;

public class TestDAO {
    public static void main(String[] args) {
        try {
            ProductDAO dao = new ProductDAO();
            List<Product> list = dao.findAll();
            System.out.println("FindAll returned: " + list.size());
            
            List<Product> list2 = dao.findWithPagination(0, 5);
            System.out.println("findWithPagination returned: " + list2.size());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
