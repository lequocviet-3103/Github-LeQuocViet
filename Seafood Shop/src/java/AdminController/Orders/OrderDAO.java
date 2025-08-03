package AdminController.Orders;

import AdminController.Product.ProductDTO;
import utils.DBUtils;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Admins
 */
public class OrderDAO {

    public List<OrderDTO> getAllOrders() {
        List<OrderDTO> list = new ArrayList<>();
        String sql = "SELECT Orders.OrderId, "
                + "Customers.FullName, Customers.PhoneNumber, "
                + "Orders.TotalAmount, Orders.Status, Orders.OrderDate, "+ "STUFF((SELECT ', ' + Product.ProductName "
                + "       FROM OrderDetails "
                + "       INNER JOIN Product ON OrderDetails.ProductId = Product.ProductId "
                + "       WHERE OrderDetails.OrderId = Orders.OrderId "
                + "       FOR XML PATH(''), TYPE).value('.', 'NVARCHAR(MAX)'), 1, 2, '') "
                + "AS OrderName "
                + "FROM Orders "
                + "INNER JOIN Customers ON Orders.CustomerId = Customers.CustomerId "
                + "GROUP BY Orders.OrderId, Customers.FullName, Customers.PhoneNumber, "
                + "Orders.TotalAmount, Orders.Status, Orders.OrderDate;";

        try (Connection con = DBUtils.getConnection();
                PreparedStatement ps = con.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                OrderDTO order = new OrderDTO();
                order.setOrderID(rs.getString("OrderId"));
                order.setOrderName(rs.getString("OrderName"));
                order.setCustomerName(rs.getString("FullName"));
                order.setCustomerPhone(rs.getString("PhoneNumber"));
                order.setTotal(rs.getDouble("TotalAmount"));
                order.setStatus(rs.getString("Status"));
                order.setOrderDate(rs.getDate("OrderDate"));
                list.add(order);
            }
        } catch (SQLException | ClassNotFoundException ex) {
            ex.printStackTrace();
        }
        return list;
    }

    public boolean updateOrderStatus(String orderId, String newStatus) {
        String sql = "UPDATE Orders SET Status = ? WHERE OrderId = ?";
        try (Connection con = DBUtils.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, newStatus);
            ps.setString(2, orderId);

            int rowsUpdated = ps.executeUpdate();
            return rowsUpdated > 0;

        } catch (SQLException | ClassNotFoundException ex) {
            System.err.println("Error updating order status: " + ex.getMessage());
            ex.printStackTrace();
        }
        return false;
    }

}