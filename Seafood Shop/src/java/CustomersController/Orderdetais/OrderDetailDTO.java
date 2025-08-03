/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package CustomersController.Orderdetais;

/**
 *
 * @author Lê Quốc Việt
 */
public class OrderDetailDTO {
    private String orderId, productId;
    private double price, weight;

    public OrderDetailDTO() {
    }

    public OrderDetailDTO(String orderId, String productId, double price, double weight) {
        this.orderId = orderId;
        this.productId = productId;
        this.price = price;
        this.weight = weight;
    }

    public String getOrderId() {
        return orderId;
    }

    public void setOrderId(String orderId) {
        this.orderId = orderId;
    }

    public String getProductId() {
        return productId;
    }

    public void setProductId(String productId) {
        this.productId = productId;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public double getWeight() {
        return weight;
    }

    public void setWeight(double weight) {
        this.weight = weight;
    }
    
}
