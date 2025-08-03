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

@WebServlet(name = "PaymentController", urlPatterns = {"/payment"})
public class PaymentController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException, ClassNotFoundException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        String action = request.getParameter("action");
        String customerId = (String) session.getAttribute("customerId");
        String paymentMethod = request.getParameter("paymentMethod");

        List<ProductDTO> cart = (List<ProductDTO>) session.getAttribute("cart");
        String[] selectedItems = request.getParameterValues("selectedItems");

        if (selectedItems == null || cart == null) {
            request.setAttribute("message", "No items selected for payment.");
            request.getRequestDispatcher("cart.jsp").forward(request, response);
            return;
        }

        List<ProductDTO> selectedProducts = new ArrayList<>();
        double totalAmount = 0;
        double totalWeight = 0;

        for (String proId : selectedItems) {
            for (ProductDTO item : cart) {
                if (item.getProductId().equals(proId)) {
                    selectedProducts.add(item);
                    totalAmount += item.getPrice() * item.getStockWeight();
                    totalWeight += item.getStockWeight();
                }
            }
        }

        OrderDAO orderDAO = new OrderDAO();
        String orderId = orderDAO.createOrder(customerId, totalAmount, "Shipping Address");

        OrderDetailDAO orderDetailsDAO = new OrderDetailDAO();
        for (ProductDTO item : selectedProducts) {
            orderDetailsDAO.insertOrderDetails(item.getProductId(), orderId, item.getStockWeight(), item.getPrice());
        }

        PaymentDAO paymentDAO = new PaymentDAO();
        paymentDAO.createPayment(paymentMethod, orderId);

        cart.removeAll(selectedProducts);

        CustomerDAO customerDAO = new CustomerDAO();
        CustomerDTO customer = customerDAO.loadCusId(customerId);

        session.setAttribute("customer", customer);
        session.setAttribute("cart", cart);
        request.setAttribute("selectedProducts", selectedProducts);
        request.setAttribute("totalAmount", totalAmount);
        request.setAttribute("totalWeight", totalWeight);
        request.getRequestDispatcher("payment.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException | ClassNotFoundException ex) {
            Logger.getLogger(PaymentController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}