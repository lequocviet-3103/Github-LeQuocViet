package AdminController.Controller;


import AdminController.Product.ProductDAO;
import AdminController.Product.ProductDTO;
import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.List;

public class ProductController extends HttpServlet {

    private static final String PRODUCT_PAGE = "productList.jsp";
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");

        String action = request.getParameter("action");
        String search = request.getParameter("search");
        ProductDAO dao = new ProductDAO();
        HttpSession session = request.getSession(false);
        
        if (session == null || session.getAttribute("adminsession") == null) {
            response.sendRedirect("loginAdmin.jsp");
            return;
        }

        try {
            if ("productList".equals(action) || action == null || action.isEmpty()) {
                List<ProductDTO> list = dao.list(search);
                request.setAttribute("productList", list);
                request.getRequestDispatcher(PRODUCT_PAGE).forward(request, response);
            } 
            else if ("details".equals(action)) {
                String productID = request.getParameter("id");
                ProductDTO product = dao.load(productID);
                request.setAttribute("object", product);
                request.getRequestDispatcher("productDetail.jsp").forward(request, response);
            } else if("search".equals(action)){
                List<ProductDTO> list = dao.list(search);
                request.setAttribute("productList",list);
                request.getRequestDispatcher("productList.jsp").forward(request, response);
            }
            else if ("edit".equals(action)) {
                String productID = request.getParameter("id");
                
                ProductDTO product = null;
                if(productID != null){
                    product = dao.load(productID);
                }
                        
                request.setAttribute("object", product);
                request.setAttribute("nextaction", "update");
                request.getRequestDispatcher("productEdit.jsp").forward(request, response);
            } 
            else if ("update".equals(action)) {
                String id = request.getParameter("id");
                String name = request.getParameter("name");
                String priceStr = request.getParameter("price");
                String description = request.getParameter("description");
                String imageURL = request.getParameter("imageURL");

                if (name == null || name.trim().isEmpty() || priceStr == null || priceStr.trim().isEmpty()) {
                    request.setAttribute("errorMessage", "All fields are required!");
                    request.getRequestDispatcher("productEdit.jsp").forward(request, response);
                    return;
                }

                double price = Double.parseDouble(priceStr);
                
                
                ProductDTO product = null;
                if(id != null){
                    product = dao.load(id);
                }
                if (product != null) {
                    product.setName(name);
                    product.setPrice(price);
                    product.setDescription(description);
                    product.setImageURL(imageURL);
                    dao.update(product);
                } else {
                    request.setAttribute("errorMessage", "Product not found!");
                    request.getRequestDispatcher("productEdit.jsp").forward(request, response);
                    return;
                }
                    request.setAttribute("object", product);
                    request.getRequestDispatcher("productDetail.jsp").forward(request, response);
            } 
            else if ("create".equals(action)) {
                request.setAttribute("nextaction", "insert");
                request.getRequestDispatcher("productEdit.jsp").forward(request, response);
            } 
            else if ("insert".equals(action)) {
                String id = request.getParameter("id");
                String name = request.getParameter("name");
                String priceStr = request.getParameter("price");
                String description = request.getParameter("description");
                String imageURL = request.getParameter("imageURL");

                if (id == null || id.trim().isEmpty() || name == null || name.trim().isEmpty() || priceStr == null || priceStr.trim().isEmpty()) {
                    request.setAttribute("errorMessage", "All fields are required!");
                    request.getRequestDispatcher("productEdit.jsp").forward(request, response);
                    return;
                }

                double price = Double.parseDouble(priceStr);
                ProductDTO product = new ProductDTO();
                product.setId(id);
                product.setName(name);
                product.setPrice(price);
                product.setDescription(description);
                product.setImageURL(imageURL);

                dao.insert(product);
                request.setAttribute("object", product);
                request.getRequestDispatcher("productDetail.jsp").forward(request, response);
            } 
            else if ("delete".equals(action)) {
                String id = request.getParameter("id");
                dao.delete(id);
                List<ProductDTO> list = dao.list(search);
                request.setAttribute("productList", list);
                request.getRequestDispatcher(PRODUCT_PAGE).forward(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("errorMessage", "An error occurred: " + e.getMessage());
            request.getRequestDispatcher(PRODUCT_PAGE).forward(request, response);
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
        return "Product Controller";
    }
}
