package shop.entities;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import lombok.*;
import lombok.experimental.FieldDefaults;
import shop.DAO.CustomerDAO;
import shop.DAO.OrderDetailDAO;
import shop.DAO.PaymentMethodDAO;
import shop.DAO.TransactionDAO;
import shop.anotation.*;

/**
 *
 * @author admin
 */
@Table(name = "orders")
@AllArgsConstructor
@NoArgsConstructor
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
@Getter
@Setter
public class Order {

    @Id
    @Column(name = "order_id")
    Integer id;

    @Column(name = "customer_id")
    Integer customerId;

    @Column(name = "order_date")
    Date orderDate;

    @Column(name = "total_amount")
    BigDecimal totalAmount;

    @Column(name = "shipping_address")
    String shippingAddress;

    @Column(name = "shipping_fee")
    BigDecimal shippingFee;

    @Column(name = "status")
    @Enumerated
    String status; // 'pending', 'shipping', 'completed', 'cancelled'

    @Column(name = "payment_method_id")
    Integer paymentMethodId;

    @Column(name = "shipper_id")
    Integer shipperId;

    Customer customer;

    List<OrderDetail> orderDetails;

    PaymentMethod paymentMethod;

    boolean paid;

    public void setCustomerFunc() {
        try {
            this.customer = new CustomerDAO().getById(this.customerId);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void setorderDetailsFunc() {
        try {
            this.orderDetails = new OrderDetailDAO().getByOrderId(this.id);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void setPaymentMethodFunc() {
        try {
            this.paymentMethod = new PaymentMethodDAO().getById(this.paymentMethodId);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void setPaidFunc() {
        try {
            TransactionDAO transactionDAO = new TransactionDAO();
            Transaction tran = transactionDAO.getByOrderId(id);
            if (tran != null) {
                this.paid = tran.isPaid();
                return;
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        this.paid = this.status.toLowerCase().equals("completed");
    }
}
