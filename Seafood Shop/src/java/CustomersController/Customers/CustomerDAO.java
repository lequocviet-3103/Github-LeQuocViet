/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package CustomersController.Customers;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import utils.DBUtils;

/**
 *
 * @author Lê Quốc Việt
 */
public class CustomerDAO {
    public CustomerDTO login (String username, String password) throws ClassNotFoundException{
        CustomerDTO customer = null;
        try {
            Connection conn = DBUtils.getConnection();
            String sql = "select CustomerId, Username, FullName from Customers where Username = ? and Password = ? ";
            PreparedStatement st = conn.prepareStatement(sql);
            st.setString(1, username);
            st.setString(2, password);
            ResultSet rs = st.executeQuery();
            if(rs!=null) {
                if(rs.next()) {
                    customer = new CustomerDTO();
                    customer.setCustomerId(rs.getString("CustomerId"));
                    customer.setUsername(rs.getString("Username"));
                    customer.setFullname(rs.getString("FullName"));
                    
                }
            }
            conn.close();
        } catch (SQLException ex) {                
                System.out.println("Error in servlet. Details:" + ex.getMessage());
                ex.printStackTrace();
                
            }
        return customer;
    }
    
    public void insert (String fullname, String username, String password, String phone, String address) throws ClassNotFoundException, SQLException{
        String customerId = generateCustomerId();
        String sql = "INSERT INTO Customers (CustomerId, FullName, Username, Password,PhoneNumber ,address)\n" +
            "VALUES (?,?,?,?,?,?)";
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement st = conn.prepareStatement(sql);
            st.setString(1, customerId);
            st.setString(2, fullname);
            st.setString(3, username);
            st.setString(4, password);
            st.setString(5, phone);
            st.setString(6, address);
            st.executeUpdate();
            st.close();
            
        } catch (SQLException ex) {
            System.out.println("Insert Playlists error!" + ex.getMessage());
            ex.printStackTrace();
        }
        
    }

    
    public String generateCustomerId() throws SQLException, ClassNotFoundException {
    String newId = "C01"; // Giá trị mặc định nếu bảng rỗng
    Connection conn = DBUtils.getConnection();
    
    if (conn != null) {
        String sql = "SELECT MAX(CustomerId) AS maxId FROM Customers";
        PreparedStatement stmt = conn.prepareStatement(sql);
        ResultSet rs = stmt.executeQuery();
        
        if (rs.next() && rs.getString("maxId") != null) {
            String maxId = rs.getString("maxId"); // Ví dụ: "C09"
            int num = Integer.parseInt(maxId.substring(1)); // Lấy phần số: 9
            newId = "C" + String.format("%02d", num + 1); // Tăng lên: "C10"
        }
        
        rs.close();
        stmt.close();
        conn.close();
    }
    return newId;
}
    public boolean checkUserPhone(String username, String phone){
        String sql = "select count(*) from admin where USERname = ? and PhoneNumber =? ";
        
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement st = conn.prepareStatement(sql);
            st.setString(1, username);
            st.setString(2, phone);
            ResultSet rs = st.executeQuery();
            if(rs.next()){
               return rs.getInt(1) > 0;
            }
            
        } catch (Exception e) {
        }
        
        return false;
        
    }
    
    public CustomerDTO loadCusId(String id){
        String sql = "select CustomerId, FullName, Username, PhoneNumber, Address from Customers where CustomerId = ? ";
        try {
            Connection conn  = DBUtils.getConnection();
            PreparedStatement st = conn.prepareStatement(sql);
            st.setString(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()){
                String customerId = rs.getString("CustomerId");
                String fullname = rs.getString("FullName");
                String username = rs.getString("Username");
                String phone = rs.getString("PhoneNumber");
                String address = rs.getString("Address");
                CustomerDTO customer = new CustomerDTO();
                customer.setCustomerId(customerId);
                customer.setFullname(fullname);
                customer.setUsername(username);
                customer.setPhone(phone);
                customer.setAddress(address);
                return customer;
            }
            
        } catch (Exception e) {
        }
        return null;
    }
    

 /*   
    public static void main(String[] args) throws ClassNotFoundException, SQLException {
//        System.out.println("input u and p");
        CustomerDAO dao = new CustomerDAO();
       CustomerDTO cus =  dao.loadCusId("C02");
      System.out.println("name" +cus.getFullname());
       }      */
          
           
   
}
