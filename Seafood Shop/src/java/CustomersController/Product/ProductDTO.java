/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package CustomersController.Product;

/**
 *
 * @author Lê Quốc Việt
 */
public class ProductDTO {
    private String productId, productName;
    private double price, stockWeight;
    private String description, image;

    public ProductDTO() {
    }

    public ProductDTO(String productId, String productName, double price, double stockWeight, String description, String image) {
        this.productId = productId;
        this.productName = productName;
        this.price = price;
        this.stockWeight = stockWeight;
        this.description = description;
        this.image = image;
    }

    public double getStockWeight() {
        return stockWeight;
    }

    public void setStockWeight(double stockWeight) {
        this.stockWeight = stockWeight;
    }

    

    public String getProductId() {
        return productId;
    }

    public void setProductId(String productId) {
        this.productId = productId;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }
    
    
    
}
