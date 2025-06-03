/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package shop.entities;
import java.util.Date;
import lombok.*;
import lombok.experimental.FieldDefaults;
import shop.anotation.*;

/**
 *
 * @author admin
 */
@Table(name = "feedback")
@AllArgsConstructor
@NoArgsConstructor
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
@Getter
@Setter
public class Feedback {
    @Id
    @Column(name = "id")
    Integer id;
    
    @Column(name = "product_id")
    Integer productId;
    
    @Column(name = "user_id")
    Integer userId;
    
    @Column(name = "rating")
    Integer rating;
    
    @Column(name = "content")
    String content;
    
    @Column(name = "created_at")
    Date createdAt;
}