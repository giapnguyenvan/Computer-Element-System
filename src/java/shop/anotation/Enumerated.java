package shop.anotation;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * Annotation để đánh dấu field là ENUM trong database
 */
@Target(ElementType.FIELD)
@Retention(RetentionPolicy.RUNTIME)
public @interface Enumerated {
    EnumType value() default EnumType.STRING;
    
    public enum EnumType {
        STRING,  // ENUM được lưu dưới dạng string
        ORDINAL  // ENUM được lưu dưới dạng số thứ tự
    }
}