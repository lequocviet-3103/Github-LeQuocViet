/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package AdminController.Controller;

import AdminController.Admins.AdminDAO;
import AdminController.Admins.AdminDTO;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Admins
 */
public class LoginAdminController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String action = request.getParameter("action");
        if ("Login".equals(action)) {
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            AdminDAO dao = new AdminDAO();
            AdminDTO admin = dao.checkLogin(username, password);
            if (admin != null) {
                HttpSession session = request.getSession(true);
                session.setAttribute("adminsession", admin);
                response.sendRedirect("./HomeController");
                return;
            } else {
                request.setAttribute("error", "Username or Password is incorrect !!!");
                request.getRequestDispatcher("loginAdmin.jsp").forward(request, response);
            }
        } else if ("Logout".equals(action)) {
            HttpSession session = request.getSession(false);
            if (session != null) {
                session.invalidate();
                request.setAttribute("error", "Logout successfully !!!");
                request.getRequestDispatcher("loginAdmin.jsp").forward(request, response);
            }
        } else if ("register".equals(action)) {
            String fullName = request.getParameter("fullName");
            String userName = request.getParameter("userName");
            String phone = request.getParameter("phone");
            String address = request.getParameter("address");
            String password = request.getParameter("password");
            System.out.println(fullName);
            System.out.println(userName);
            System.out.println(phone);
            System.out.println(address);
            System.out.println(password);
            AdminDAO dao = new AdminDAO();
            

            boolean success = dao.registerAdmin(fullName, userName, password, phone, address);

            if (success) {
                request.setAttribute("message", "Đăng ký thành công!");
            } else {
                request.setAttribute("message", "Đăng ký thất bại!");
            }
            request.getRequestDispatcher("loginAdmin.jsp").forward(request, response);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
