/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package AdminController.Controller;


import AdminController.Customers.CustomerDAO;
import AdminController.Customers.CustomerDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Admins
 */
@WebServlet(name = "CustomersController", urlPatterns = {"/CustomersController"})
public class CustomersController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String action = request.getParameter("action");
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("adminsession") == null) {
            response.sendRedirect("loginAdmin.jsp");
            return;
        }

        CustomerDAO dao = new CustomerDAO();
        if ("customerList".equals(action)) {
            String search = request.getParameter("search");
            List<CustomerDTO> list = dao.list(null);
            request.setAttribute("customerList", list);
            request.getRequestDispatcher("customerList.jsp").forward(request, response);
        } else if ("search".equals(action)) {
            String search = request.getParameter("search");
            List<CustomerDTO> list = dao.list(search);
            request.setAttribute("customerList", list);
            request.getRequestDispatcher("customerList.jsp").forward(request, response);
        } else if ("details".equals(action)) {
            String customerID = null;
            try {
                customerID = request.getParameter("id");
            } catch (NumberFormatException ex) {
                log("Parameter id was wrong format !");
            }
            CustomerDTO customer = null;
            if (customerID != null) {
                customer = dao.load(customerID);
            }
            request.setAttribute("object", customer);
            request.getRequestDispatcher("customerDetail.jsp").forward(request, response);
        } //Edit
        else if ("edit".equals(action)) {

            String customerID = null;
            try {
                customerID = request.getParameter("id");
            } catch (NumberFormatException ex) {
                log("Parameter id has wrong format.");
            }

            CustomerDTO customer = null;
            if (customerID != null) {
                customer = dao.load(customerID);
            }

            request.setAttribute("object", customer);
            request.setAttribute("nextaction", "update");
            RequestDispatcher rd = request.getRequestDispatcher("customerEdit.jsp");
            rd.forward(request, response);
        } //Update
        else if ("update".equals(action)) {
            String id = null;
            try {
                id = request.getParameter("id");
            } catch (NumberFormatException ex) {
                log("Parameter id has wrong format.");
            }

            String name = request.getParameter("name");
            String phone = request.getParameter("phone");
            String address = request.getParameter("address");

            if (name == null || name.trim().isEmpty() || phone == null || phone.trim().isEmpty() || address == null || address.trim().isEmpty()) {
                request.setAttribute("errorMessage", "All fields are required!");
                request.setAttribute("object", dao.load(id));
                request.getRequestDispatcher("customerEdit.jsp").forward(request, response);
                return;
            }

            CustomerDTO customer = null;
            if (id != null) {
                customer = dao.load(id);
            }

            if (customer != null) {
                customer.setFullName(name);
                customer.setPhone(phone);
                customer.setAddress(address);
                dao.update(customer);
            } else {
                request.setAttribute("errorMessage", "You cannot change MessageID!");
                request.getRequestDispatcher("customerEdit.jsp").forward(request, response);
                return;
            }

            request.setAttribute("object", customer);
            RequestDispatcher rd = request.getRequestDispatcher("customerDetail.jsp");
            rd.forward(request, response);
        } //Create
        else if ("create".equals(action)) {

            CustomerDTO customer = new CustomerDTO();
            request.setAttribute("object", customer);
            request.setAttribute("nextaction", "insert");
            RequestDispatcher rd = request.getRequestDispatcher("customerEdit.jsp");
            rd.forward(request, response);
        } //Insert
        else if ("insert".equals(action)) {
            String id = null;
            try {
                id = request.getParameter("id");
            } catch (NumberFormatException ex) {
                log("Parameter id has wrong format.");
            }

            String name = request.getParameter("name");
            String phone = request.getParameter("phone");
            String address = request.getParameter("address");

            if (name == null || name.trim().isEmpty() || phone == null || phone.trim().isEmpty() || address == null || address.trim().isEmpty()) {
                request.setAttribute("errorMessage", "All fields are required!");
                request.setAttribute("object", dao.load(id));
                request.getRequestDispatcher("customerEdit.jsp").forward(request, response);
                return;
            }

            CustomerDTO customer = new CustomerDTO();
            customer.setCusID(id);
            customer.setFullName(name);
            customer.setPhone(phone);
            customer.setAddress(address);
            dao.insert(customer);
            request.setAttribute("object", customer);
            RequestDispatcher rd = request.getRequestDispatcher("customerDetail.jsp");
            rd.forward(request, response);
        } //delete
        else if ("delete".equals(action)) {
            String id = null;
            try {
                id = request.getParameter("id");
            } catch (NumberFormatException ex) {
                log("Parameter id has wrong format.");
            }

            if (id != null) {
                dao.delete(id);
            }
            String search = request.getParameter("search");
            List<CustomerDTO> list = dao.list(search);
            request.setAttribute("customerList", list);
            RequestDispatcher rd = request.getRequestDispatcher("customerList.jsp");
            rd.forward(request, response);
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
