/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package CustomersController.Payments;

/**
 *
 * @author Lê Quốc Việt
 */
public class PaymentDTO {
    public String paymentId, paymentMethod, orderId;

    public PaymentDTO() {
    }

    public PaymentDTO(String paymentId, String paymentMethod, String orderId) {
        this.paymentId = paymentId;
        this.paymentMethod = paymentMethod;
        this.orderId = orderId;
    }

    public String getPaymentId() {
        return paymentId;
    }

    public void setPaymentId(String paymentId) {
        this.paymentId = paymentId;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public String getOrderId() {
        return orderId;
    }

    public void setOrderId(String orderId) {
        this.orderId = orderId;
    }

    
    
}
