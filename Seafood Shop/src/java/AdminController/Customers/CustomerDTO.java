
package AdminController.Customers;


public class CustomerDTO {
    private String cusID;
    private String fullName;
    private String userName;
    private String phone;
    private String address;

    public CustomerDTO() {
    }

    
    public CustomerDTO(String cusID, String fullName, String userName, String phone, String address) {
        this.cusID = cusID;
        this.fullName = fullName;
        this.userName = userName;
        this.phone = phone;
        this.address = address;
    }

    public String getCusID() {
        return cusID;
    }

    public void setCusID(String cusID) {
        this.cusID = cusID;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }
    
    
}
