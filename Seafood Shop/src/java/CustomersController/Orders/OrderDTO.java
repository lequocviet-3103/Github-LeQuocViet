/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package CustomersController.Orders;


/**
 *
 * @author Lê Quốc Việt
 */
public class OrderDTO {
    private String orderId, CustomerId;
    private double totalAmount;
    private String shippingAddress;

    public OrderDTO() {
    }

    public OrderDTO(String orderId, String CustomerId, double totalAmount, String shippingAddress) {
        this.orderId = orderId;
        this.CustomerId = CustomerId;
        this.totalAmount = totalAmount;
        this.shippingAddress = shippingAddress;
    }

    public String getOrderId() {
        return orderId;
    }

    public void setOrderId(String orderId) {
        this.orderId = orderId;
    }

    public String getCustomerId() {
        return CustomerId;
    }

    public void setCustomerId(String CustomerId) {
        this.CustomerId = CustomerId;
    }

    public double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }

    public String getShippingAddress() {
        return shippingAddress;
    }

    public void setShippingAddress(String shippingAddress) {
        this.shippingAddress = shippingAddress;
    }
    
}
