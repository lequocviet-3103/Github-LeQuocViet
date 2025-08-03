package AdminController.Orders;

import java.sql.Date;

/**
 *
 * @author Admins
 */
public class OrderDTO {
    private String orderID;
    private String orderName;
    private String customerName;
    private String customerPhone;
    private double total;
    private String status;
    private Date orderDate;

    public OrderDTO(String orderID, String orderName, String customerName, String customerPhone, double total, String status, Date orderDate) {
        this.orderID = orderID;
        this.orderName = orderName;
        this.customerName = customerName;
        this.customerPhone = customerPhone;
        this.total = total;
        this.status = status;
        this.orderDate = orderDate;
    }

    public OrderDTO() {
    }

    public String getOrderID() {
        return orderID;
    }

    public void setOrderID(String orderID) {
        this.orderID = orderID;
    }

    public String getOrderName() {
        return orderName;
    }

    public void setOrderName(String orderName) {
        this.orderName = orderName;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getCustomerPhone() {
        return customerPhone;
    }

    public void setCustomerPhone(String customerPhone) {
        this.customerPhone = customerPhone;
    }

    public double getTotal() {
        return total;
    }

    public void setTotal(double total) {
        this.total = total;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Date getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }
}
