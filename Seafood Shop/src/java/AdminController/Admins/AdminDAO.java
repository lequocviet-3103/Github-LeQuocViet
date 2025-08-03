/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package AdminController.Admins;

import utils.DBUtils;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author Admins
 */
public class AdminDAO {

    public AdminDTO checkLogin(String username, String password) {
        AdminDTO admin = null;
        String sql = "SELECT FullName, UserName, PhoneNumber, Address FROM Admin WHERE Username = ? AND Password = ?";

        try (Connection con = DBUtils.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, username);
            ps.setString(2, password);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    admin = new AdminDTO();
                    admin.setFullName(rs.getString("FullName"));
                    admin.setUserName(rs.getString("Username"));
                    admin.setPhone(rs.getString("PhoneNumber"));
                    admin.setAddress(rs.getString("Address"));
                }
            }
        } catch (SQLException | ClassNotFoundException ex) {
            ex.printStackTrace();
        }
        return admin;
    }
    

    public boolean registerAdmin(String fullname, String username, String password, String phone, String address) {
        String adminId = generateAdminId(); // Tạo AdminId mới
        String sql = "INSERT INTO Admin (AdminId, FullName, UserName, Password, PhoneNumber, Address) VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection con = DBUtils.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, adminId);
            ps.setString(2, fullname);
            ps.setString(3, username);
            ps.setString(4, password);
            ps.setString(5, phone);
            ps.setString(6, address);

            return ps.executeUpdate() > 0;
        } catch (SQLException | ClassNotFoundException ex) {
            ex.printStackTrace();
        }
        return false;
    }
    

    public String generateAdminId() {
    String sql = "SELECT MAX(CAST(SUBSTRING(AdminId, 2, LEN(AdminId)) AS INT)) FROM Admin";
    String prefix = "A";
    int nextId = 1; 

    try (Connection con = DBUtils.getConnection();
         PreparedStatement ps = con.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {
        if (rs.next() && rs.getObject(1) != null) { // Kiểm tra nếu có giá trị
            nextId = rs.getInt(1) + 1;
        }
    } catch (SQLException | ClassNotFoundException ex) {
        ex.printStackTrace();
    }

    return prefix + String.format("%02d", nextId);
}

    
}
