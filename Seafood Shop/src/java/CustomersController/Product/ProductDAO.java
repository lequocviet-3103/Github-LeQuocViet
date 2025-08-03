package CustomersController.Product;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import utils.DBUtils;

public class ProductDAO {

    // Lấy danh sách sản phẩm theo trang (12 sản phẩm mỗi trang)
    public List<ProductDTO> getProductsByPage(int startIndex, int recordsPerPage) {
        List<ProductDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM Product ORDER BY ProductId OFFSET ? ROWS FETCH NEXT ? ROWS ONLY;";
        try (Connection conn = DBUtils.getConnection();
                PreparedStatement st = conn.prepareStatement(sql)) {
            st.setInt(1, startIndex);
            st.setInt(2, recordsPerPage); // Giới hạn số lượng sản phẩm trên mỗi trang
            // Vị trí bắt đầu lấy sản phẩm

            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                list.add(new ProductDTO(
                        rs.getString("ProductId"),
                        rs.getString("ProductName"),
                        rs.getDouble("Price"),
                        rs.getDouble("StockWeight"),
                        rs.getString("Description"),
                        rs.getString("ImageURL")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Tính tổng số sản phẩm trong database
    public int getTotalProducts() {
        int total = 0;
        String sql = "SELECT COUNT(*) FROM Product";

        try (Connection conn = DBUtils.getConnection();
                PreparedStatement st = conn.prepareStatement(sql);
                ResultSet rs = st.executeQuery()) {

            if (rs.next()) {
                total = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return total;
    }

    // Tính tổng số trang dựa trên số sản phẩm
    public int getTotalPages(int recordsPerPage) {
        int totalProducts = getTotalProducts();
        return (int) Math.ceil((double) totalProducts / recordsPerPage);
    }

    // Lấy sản phẩm theo ID
    public ProductDTO loadId(String id) {
        ProductDTO product = null;
        String sql = "SELECT * FROM Product WHERE ProductId = ?";

        try (Connection conn = DBUtils.getConnection();
                PreparedStatement st = conn.prepareStatement(sql)) {

            st.setString(1, id);
            ResultSet rs = st.executeQuery();

            if (rs.next()) {
                product = new ProductDTO(
                        rs.getString("ProductId"),
                        rs.getString("ProductName"),
                        rs.getDouble("Price"),
                        rs.getDouble("StockWeight"),
                        rs.getString("Description"),
                        rs.getString("ImageURL")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return product;
    }
     public List<ProductDTO> search(String keyword) {
        List<ProductDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM Product where ProductName like ? ";
        try (Connection conn = DBUtils.getConnection();
                PreparedStatement st = conn.prepareStatement(sql)) {
                st.setString(1, "%" + keyword + "%");

            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                list.add(new ProductDTO(
                        rs.getString("ProductId"),
                        rs.getString("ProductName"),
                        rs.getDouble("Price"),
                        rs.getDouble("StockWeight"),
                        rs.getString("Description"),
                        rs.getString("ImageURL")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
   
    

}

   

//    public int getTotalProducts(String keyword) {
//    String sql = "SELECT COUNT(*) FROM Product";
//
//    if (keyword != null && !keyword.isEmpty()) {
//        sql += " WHERE ProductName LIKE ?";
//    }
//
//    try (Connection conn = DBUtils.getConnection();
//         PreparedStatement ps = conn.prepareStatement(sql)) {
//        
//        if (keyword != null && !keyword.isEmpty()) {
//            ps.setString(1, "%" + keyword + "%");
//        }
//        
//        ResultSet rs = ps.executeQuery();
//        
//        if (rs.next()) {
//            return rs.getInt(1);
//        }
//    } catch (Exception e) {
//        e.printStackTrace();
//    }
//    
//    return 0;
//}
//
//public List<ProductDTO> listByPage(int start, int recordsPerPage, String keyword) {
//    List<ProductDTO> list = new ArrayList<>();
//    String sql = "SELECT ProductId, ProductName, Price, Description, ImageURL FROM Product";
//
//    if (keyword != null && !keyword.isEmpty()) {
//        sql += " WHERE ProductName LIKE ?";
//    }
//
//    sql +="ORDER BY ProductId \n" +
//          "OFFSET ?  ROWS FETCH NEXT ? ROWS ONLY;"; // Phân trang
//
//    try (Connection conn = DBUtils.getConnection();
//         PreparedStatement ps = conn.prepareStatement(sql)) {
//        
//        int paramHome = 1;
//        
//        if (keyword != null && !keyword.isEmpty()) {
//            ps.setString(paramHome++, "%" + keyword + "%");
//        }
//        
//     ps.setInt(paramHome++, start);
//ps.setInt(paramHome++, recordsPerPage);
//
//        ResultSet rs = ps.executeQuery();
//        
//        while (rs.next()) {
//            ProductDTO product = new ProductDTO();
//            product.setProductId(rs.getString("ProductId"));
//            product.setProductName(rs.getString("ProductName"));
//            product.setPrice(rs.getDouble("Price"));
//            product.setDescription(rs.getString("Description"));
//            product.setImage(rs.getString("ImageURL"));
//            
//            list.add(product);
//        }
//    } catch (Exception e) {
//        e.printStackTrace();
//    }
//    
//    return list;
//}
//
//
//

