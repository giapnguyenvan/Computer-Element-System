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
@Table(name = "blogs")
@AllArgsConstructor
@NoArgsConstructor
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
@Getter
@Setter
public class Blog {
    @Id
    @Column(name = "id")
    Integer id;
    
    @Column(name = "title")
    String title;
    
    @Column(name = "content")
    String content;
    
    @Column(name = "user_id")
    Integer userId;
    
    @Column(name = "created_at")
    Date createdAt;
    
    @Column(name = "updated_at")
    Date updatedAt;
}