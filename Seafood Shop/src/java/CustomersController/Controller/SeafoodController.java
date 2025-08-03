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
import java.util.ArrayList;
import static java.util.Collections.list;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Lê Quốc Việt
 */

@WebServlet(name = "SeafoodController", urlPatterns = {"/SeafoodController"})
public class SeafoodController extends HttpServlet {
  
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        String action = request.getParameter("action");
        String keyword = request.getParameter("keyword");
        if (keyword == null) {
            keyword = "";
        }

        ProductDAO dao = new ProductDAO();

        if (action == null || action.equals("list")) {
            int page = 1;
            int recordsPerPage = 12; // Hiển thị 12 sản phẩm/trang

            if (request.getParameter("page") != null) {
                page = Integer.parseInt(request.getParameter("page"));
            }

            int startIndex = (page - 1) * recordsPerPage;

            // Lấy danh sách sản phẩm từ database
            List<ProductDTO> productList = dao.getProductsByPage(startIndex, recordsPerPage);

            // Tính tổng số trang
            int totalPages = dao.getTotalPages(recordsPerPage);

            // Gửi dữ liệu sang JSP
            request.setAttribute("productlist", productList);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("keyword", keyword);

            request.getRequestDispatcher("home.jsp").forward(request, response);
            return;
        }else if (action.equals("search")) {
               List<ProductDTO> productList = dao.search(keyword);
            
            request.setAttribute("productlist", productList);
            request.getRequestDispatcher("home.jsp").forward(request, response);
        }

        else if (action.equals("details")) {
            String id = request.getParameter("id");

            ProductDTO product = null;
            if (id != null) {
                product = dao.loadId(id);
            }
            request.setAttribute("seafoodDetails", product);
            request.getRequestDispatcher("seafoodDetails.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    } 

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Seafood Shop Controller";
    }
}
