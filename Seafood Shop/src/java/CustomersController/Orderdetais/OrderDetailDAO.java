/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package CustomersController.Orderdetais;

import java.sql.Connection;
import java.sql.PreparedStatement;
import utils.DBUtils;

/**
 *
 * @author Lê Quốc Việt
 */
public class OrderDetailDAO {
    
    public String insertOrderDetails (String productId, String orderId, double weight, double price ){
        String sql = "INSERT INTO OrderDetails (ProductId, OrderId, Weight, Price) values (?,?,?,?)";
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement st = conn.prepareStatement(sql);
            st.setString(1, productId);
            st.setString(2, orderId);
            st.setDouble(3, price);
            st.setDouble(4, weight);
            st.executeUpdate();
            st.close();
            
        } catch (Exception e) {
        }
        return orderId;
        
    }
    
    
    
    
    
}
