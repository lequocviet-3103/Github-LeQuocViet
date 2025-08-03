/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package AdminController.Customers;


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
public class CustomerDAO {

    public List<CustomerDTO> list(String search) {
        List<CustomerDTO> list = new ArrayList<>();
        String sql = "SELECT CustomerId, FullName, PhoneNumber, Address FROM Customers ";

        if (search != null && !search.isEmpty()) {
            sql += " WHERE Fullname LIKE ? OR PhoneNumber LIKE ?";
        }
        try (Connection con = DBUtils.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {

            if (search != null && !search.isEmpty()) {
                ps.setString(1, "%" + search + "%");
                ps.setString(2, "%" + search + "%");
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    CustomerDTO customer = new CustomerDTO();
                    customer.setCusID(rs.getString("CustomerId"));
                    customer.setFullName(rs.getString("FullName"));
                    customer.setPhone(rs.getString("PhoneNumber"));
                    customer.setAddress(rs.getString("Address"));
                    list.add(customer);
                }
            }
        } catch (SQLException | ClassNotFoundException ex) {
            System.err.println("Error in CustomerDAO.list(): " + ex.getMessage());
            ex.printStackTrace();
        }
        return list;
    }
    //Function 2: Load lại danh sách dựa trên id
    public CustomerDTO load(String id) {
        String sql = "SELECT CustomerId, FullName, PhoneNumber, Address FROM Customers WHERE CustomerId = ?";
        try (Connection con = DBUtils.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, id);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    CustomerDTO customer = new CustomerDTO();
                    customer.setCusID(rs.getString("CustomerId"));
                    customer.setFullName(rs.getString("FullName"));
                    customer.setPhone(rs.getString("PhoneNumber"));
                    customer.setAddress(rs.getString("Address"));
                    return customer;
                }
            }
        } catch (SQLException | ClassNotFoundException ex) {
            System.err.println("Error in MessageDAO.load(): " + ex.getMessage());
            ex.printStackTrace();
        }

        return null;
    }

    //FUNCTION 3: UPDATE
    public boolean update(CustomerDTO customer) {
        String sql = "UPDATE Customers SET FullName = ?, PhoneNumber = ?, Address = ? WHERE CustomerId = ?";
        try {
            Connection con = DBUtils.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            
            ps.setString(1, customer.getFullName());
            ps.setString(2, customer.getPhone());
            ps.setString(3, customer.getAddress());
            ps.setString(4, customer.getCusID());

            ps.executeUpdate();
            con.close();
        } catch (Exception ex) {
            System.out.println("Error in servlet. Update:" + ex.getMessage());
            ex.printStackTrace();
        }
        return false;
    }

    //FUNCTION 4: DELETE
    public boolean delete(String id) {
        String sql = "DELETE Customers WHERE CustomerId = ? ";
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
    public String insert(CustomerDTO customer) {
        String sql = "INSERT INTO Customers (CustomerId, FullName, PhoneNumber, Address) VALUES (?,?,?,?)";
        try {
            Connection con = DBUtils.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, customer.getCusID());
            ps.setString(2, customer.getFullName());
            ps.setString(3, customer.getPhone());
            ps.setString(4, customer.getAddress());
            

            ps.executeUpdate();
            con.close();
            return customer.getCusID();

        } catch (Exception ex) {
            System.out.println("Insert Customer error!" + ex.getMessage());
            ex.printStackTrace();
        }
        return null;
    }

}
