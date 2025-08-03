/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package CustomersController.Payments;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import utils.DBUtils;

/**
 *
 * @author Lê Quốc Việt
 */
public class PaymentDAO {
    
        public String createPayment(String paymentMethod, String OrderId){
            String sql = "INSERT INTO Payments (PaymentId, PaymentMethod, OrderId) VALUES  (?,?,?)";
            String paymentId = generateId();
            try {
                Connection conn = DBUtils.getConnection();
                PreparedStatement st = conn.prepareStatement(sql);
                st.setString(1, paymentId);
                st.setString(2, paymentMethod);
                st.setString(3, OrderId);
                st.executeUpdate();
                st.close();
                conn.close(); 
            } catch (Exception e) {
            }
        
            return paymentId;
        }
    
    
     public String generateId() {
    String newId = "PM01"; 
    String sql = "SELECT MAX(PaymentId) AS maxId FROM Payments";
    try {
        Connection conn = DBUtils.getConnection();
        PreparedStatement st = conn.prepareStatement(sql);
        ResultSet rs = st.executeQuery();
        if (rs.next() && rs.getString("maxId") != null) {
            String maxId = rs.getString("maxId");
            int num = Integer.parseInt(maxId.substring(2)); 
            newId = "PM" + String.format("%02d", num + 1); 
        }
        rs.close();
        st.close();
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
    return newId;
}

     
    
}
