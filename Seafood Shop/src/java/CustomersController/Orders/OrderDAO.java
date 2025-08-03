/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package CustomersController.Orders;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import utils.DBUtils;

/**
 *
 * @author Lê Quốc Việt
 */
public class OrderDAO {
    public String createOrder(String customerId, double totalAmount, String shippingAddress){
        String sql = "INSERT INTO Orders (OrderId, CustomerId, TotalAmount, ShippingAddress) values (?,?,?,?) ";
        String orderId= generateId();
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement st = conn.prepareStatement(sql);
            st.setString(1, orderId);
            st.setString(2, customerId);
            st.setDouble(3, totalAmount);
            st.setString(4, shippingAddress);
            st.executeUpdate();
        } catch (Exception e) {
        }
        
        return orderId;
        
        
    }
    
    public String generateId( ){
        String newId = "O01";
        String sql = "select max(OrderId) as maxId from Orders ";
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement st = conn.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            if(rs.next() && rs.getString("maxId") !=null){
                String maxId = rs.getString("maxId");
                int num = Integer.parseInt(maxId.substring(1));
                newId= "O" + String.format("%02d", num+1);
                
            }
            conn.close();
        } catch (Exception e) {
        }
        return newId;
        
    }
    
  
}
