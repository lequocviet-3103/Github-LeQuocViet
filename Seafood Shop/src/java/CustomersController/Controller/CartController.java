/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package CustomersController.Controller;

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
@WebServlet(name = "CartController", urlPatterns = {"/cart"})
public class CartController extends HttpServlet {

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
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        String customerId = (String) session.getAttribute("customerId");

        if (customerId == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        List<ProductDTO> cart = (List<ProductDTO>) session.getAttribute("cart");
        if (cart == null) {
            cart = new ArrayList<>();
        }
        if ("removeCart".equals(action)) {
            String productId = request.getParameter("id"); 
            cart.removeIf(p -> p.getProductId().equals(productId));
            session.setAttribute("cart", cart);
            response.sendRedirect("cart.jsp");
            return;
        }
        
        String productId = request.getParameter("productId");
        String productName = request.getParameter("productName");
        double price = Double.parseDouble(request.getParameter("price"));
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

        boolean found = false;
        for (ProductDTO p : cart) {
            if (p.getProductId().equals(productId)) {
                p.setStockWeight(p.getStockWeight() + weight); 
                found = true;
                break;
            }
        }

        if (!found) {
            ProductDTO newProduct = new ProductDTO();
            newProduct.setProductId(productId);
            newProduct.setProductName(productName);
            newProduct.setPrice(price);
            newProduct.setImage(image);
            newProduct.setStockWeight(weight);
            cart.add(newProduct);
        }

        session.setAttribute("cart", cart);
        response.sendRedirect("cart.jsp");

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
