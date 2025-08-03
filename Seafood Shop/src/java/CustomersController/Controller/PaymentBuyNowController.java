/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package CustomersController.Controller;

import CustomersController.Customers.CustomerDAO;
import CustomersController.Customers.CustomerDTO;
import CustomersController.Orderdetais.OrderDetailDAO;
import CustomersController.Orders.OrderDAO;
import CustomersController.Orders.OrderDTO;
import CustomersController.Payments.PaymentDAO;
import CustomersController.Product.ProductDAO;
import CustomersController.Product.ProductDTO;
import utils.DBUtils;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
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
@WebServlet(name="PaymentBuyNowController", urlPatterns={"/paymentBuynow"})
public class PaymentBuyNowController extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
            HttpSession session = request.getSession();
        String action = request.getParameter("action");
        String customerId = (String) session.getAttribute("customerId");
        String productId = request.getParameter("productId");
        String customerName = request.getParameter("customerName");
        String customerAddress = request.getParameter("customerAddress");
        String productName = request.getParameter("productName");
        String priceStr = request.getParameter("price");
        String weightStr = request.getParameter("weight");
        String image = request.getParameter("image");
        String paymentMethod = request.getParameter("paymentMethod");

        List<ProductDTO> payPro = (List<ProductDTO>) session.getAttribute("buynow");
        if (payPro == null) {
            payPro = new ArrayList<>();
        }

        double price = Double.parseDouble(priceStr);
        double weight = Double.parseDouble(weightStr);

        OrderDAO orderDAO = new OrderDAO();
        OrderDTO order = new OrderDTO();
        String orderId = orderDAO.createOrder(customerId, price * weight, customerAddress);

        OrderDetailDAO orderDetailsDAO = new OrderDetailDAO();
        orderDetailsDAO.insertOrderDetails(productId, orderId, weight, price);

        PaymentDAO paymentDAO = new PaymentDAO();
        paymentDAO.createPayment(paymentMethod, orderId);

        ProductDTO product = new ProductDTO();
        product.setProductId(productId);
        product.setProductName(productName);
        product.setStockWeight(weight);
        product.setPrice(price);
        product.setImage(image);
        payPro.add(product);
        request.setAttribute("selectedProducts", payPro);

        CustomerDAO customerDAO = new CustomerDAO();
        CustomerDTO customer
                = customerDAO.loadCusId(customerId);

        session.setAttribute("customer", customer);
        session.removeAttribute("buyPro");
        request.getRequestDispatcher("payment.jsp").forward(request, response);

    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
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
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
