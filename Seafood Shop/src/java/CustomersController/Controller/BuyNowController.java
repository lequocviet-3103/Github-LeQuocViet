/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package CustomersController.Controller;

import CustomersController.Customers.CustomerDAO;
import CustomersController.Customers.CustomerDTO;
import CustomersController.Product.ProductDAO;
import CustomersController.Product.ProductDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Lê Quốc Việt
 */
@WebServlet(name = "BuyNowController", urlPatterns = {"/buynow"})
public class BuyNowController extends HttpServlet {

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
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            HttpSession session = request.getSession();

            String customerId = (String) session.getAttribute("customerId");
            String action = request.getParameter("action");
            List<ProductDTO> buyPro = (List<ProductDTO>) session.getAttribute("buynow");
            if (buyPro == null) {
                buyPro = new ArrayList<>();
            }
            if (action.equals("buy")) {

                if (customerId == null) {
                    response.sendRedirect("login.jsp");
                    return;
                }

                String id = request.getParameter("productId");
                double price = Double.parseDouble(request.getParameter("price"));

                String productName = request.getParameter("productName");
                String image = request.getParameter("image");
                String weightStr = request.getParameter("weight");
                double weight = 1.0;

                if (weightStr != null && !weightStr.trim().isEmpty()) {
                    try {
                        weight = Double.parseDouble(weightStr);
                    } catch (NumberFormatException e) {
                        weight = 1.0;
                    }
                }

                ProductDTO buynow = new ProductDTO();
                buynow.setProductId(id);
                buynow.setPrice(price);
                buynow.setStockWeight(weight);
                buynow.setProductName(productName);
                buynow.setImage(image);

                buyPro.add(buynow);
                session.setAttribute("buyPro", buyPro);
                CustomerDAO dao = new CustomerDAO();

                CustomerDTO customer
                        = dao.loadCusId(customerId);

                session.setAttribute("customer", customer);

                request.getRequestDispatcher("checkout.jsp").forward(request, response);
            }

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
