/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package AdminController.Product;

/**
 *
 * @author LE BA LOC
 */
import utils.DBUtils;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO {

    //Function 1: Danh sách sản phẩm
    public List<ProductDTO> list(String search) {
        List<ProductDTO> list = new ArrayList<>();
        String sql = "SELECT ProductId, ProductName, Price, Description, ImageURL FROM Product";

        if (search != null && !search.isEmpty()) {
            sql += " WHERE ProductName LIKE ?";
        }

        try (Connection con = DBUtils.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {

            if (search != null && !search.isEmpty()) {
                ps.setString(1, "%" + search + "%");
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    ProductDTO product = new ProductDTO();
                    product.setId(rs.getString("ProductId"));
                    product.setName(rs.getString("ProductName"));
                    product.setPrice(rs.getDouble("Price"));
                    product.setDescription(rs.getString("Description"));
                    product.setImageURL(rs.getString("ImageURL"));
                    list.add(product);
                }
            }
        } catch (SQLException | ClassNotFoundException ex) {
            System.err.println("Error in MessageDAO.list(): " + ex.getMessage());
            ex.printStackTrace();
        }

        return list;
    }

    //Function 2: Load lại danh sách dựa trên id
    public ProductDTO load(String id) {
        String sql = "SELECT ProductId, ProductName, Price, Description, ImageURL FROM Product WHERE ProductId = ?";
        try (Connection con = DBUtils.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, id);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    ProductDTO product = new ProductDTO();
                    product.setId(rs.getString("ProductId"));
                    product.setName(rs.getString("ProductName"));
                    product.setPrice(rs.getDouble("Price"));
                    product.setDescription(rs.getString("Description"));
                    product.setImageURL(rs.getString("ImageURL"));
                    return product;
                }
            }
        } catch (SQLException | ClassNotFoundException ex) {
            System.err.println("Error in MessageDAO.load(): " + ex.getMessage());
            ex.printStackTrace();
        }

        return null;
    }

    //FUNCTION 3: UPDATE
    public boolean update(ProductDTO product) {
        String sql = "UPDATE Product SET ProductName = ?, Price = ?, Description = ?, ImageURL = ? WHERE ProductId = ?";
        try (Connection con = DBUtils.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, product.getName());
            ps.setDouble(2, product.getPrice());
            ps.setString(3, product.getDescription());
            ps.setString(4, product.getImageURL());
            ps.setString(5, product.getId());

            ps.executeUpdate();
            return true;

        } catch (Exception ex) {
            System.out.println("Error in update: " + ex.getMessage());
            ex.printStackTrace();
        }
        return false;
    }

    //FUNCTION 4: DELETE
    public boolean delete(String id) {
        String sql = "DELETE Product WHERE ProductId = ? ";
        try {
            Connection con = DBUtils.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, id);
            ps.executeUpdate();
            con.close();

        } catch (Exception ex) {
            System.out.println("Delete in servlet. Update:" + ex.getMessage());
            ex.printStackTrace();
        }
        return false;
    }

    //Function 5: INSERT
    public String insert(ProductDTO product) {
        String sql = "INSERT INTO Product (ProductId, ProductName, Price, Description, ImageURL) VALUES (?,?,?,?,?)";
        try (Connection con = DBUtils.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, product.getId());
            ps.setString(2, product.getName());
            ps.setDouble(3, product.getPrice());
            ps.setString(4, product.getDescription());
            ps.setString(5, product.getImageURL());

            ps.executeUpdate();
            return product.getId();

        } catch (Exception ex) {
            System.out.println("Insert Product error!" + ex.getMessage());
            ex.printStackTrace();
        }
        return null;
    }
}
