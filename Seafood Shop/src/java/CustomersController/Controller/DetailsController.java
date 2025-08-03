/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package CustomersController.Controller;

import CustomersController.Product.ProductDAO;
import CustomersController.Product.ProductDTO;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Lê Quốc Việt
 */
@WebServlet(name="DetailsController", urlPatterns={"/details"})
public class DetailsController extends HttpServlet {
   
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
        String id = request.getParameter("id");

        // Kiểm tra nếu không có ID, lấy từ session (để tránh mất dữ liệu)
        if (id == null) {
            id = (String) request.getSession().getAttribute("productId");
        } else {
            request.getSession().setAttribute("productId", id); // Lưu vào session
        }

        
        ProductDAO dao = new ProductDAO();
        ProductDTO product = dao.loadId(id);
        request.setAttribute("seafoodDetails", product);

        int weight = 1; 
        String weightStr = request.getParameter("weight");

        // Nếu người dùng đã nhập số lượng trước đó, lấy lại
        if (weightStr != null && weightStr.matches("\\d+")) {
            weight = Integer.parseInt(weightStr);
        } else if (product != null) {
            weight = (int) product.getStockWeight(); // Lấy số lượng có sẵn trong kho
        }

       
        String action = request.getParameter("action");
        if ("increase".equals(action)) {
            weight++;
        } else if ("decrease".equals(action) && weight > 1) {
            weight--;
        }

       
        request.setAttribute("weight", weight);
        request.getRequestDispatcher("seafoodDetails.jsp").forward(request, response);

        
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
