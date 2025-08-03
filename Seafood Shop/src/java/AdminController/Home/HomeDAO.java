package AdminController.Home;

import utils.DBUtils;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class HomeDAO {

    public HomeDTO getInfor() {
        HomeDTO home = null;
        String sql = "SELECT " +
        "(SELECT COUNT(CustomerId) FROM Customers) AS totalCustomers, " +
        "(SELECT COUNT(OrderId) FROM Orders) AS totalOrders, " +
        "(SELECT COUNT(ProductId) FROM Product) AS totalProducts, " +
        "COALESCE((SELECT SUM(TotalAmount) FROM Orders), 0) AS totalRevenue";

        try (Connection con = DBUtils.getConnection();
                PreparedStatement ps = con.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                home = new HomeDTO(
                        rs.getInt("totalCustomers"),
                        rs.getInt("totalProducts"),
                        rs.getInt("totalOrders"),
                        rs.getDouble("totalRevenue")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return home;
    }
}
