package util;

import jakarta.mail.*;
import jakarta.mail.internet.*;
import java.util.Properties;
import java.io.UnsupportedEncodingException;

public class EmailUtil {
    /**
     * Gửi email xác thực với mã 6 số
     * @param toEmail Email người nhận
     * @param verificationCode Mã xác thực 6 số
     * @throws MessagingException Nếu gửi thất bại
     */
    public static void sendVerificationEmail(String toEmail, String verificationCode) throws MessagingException {
        final String fromEmail = "giapnvhe181687@fpt.edu.vn"; // TODO: Thay bằng email thật
        final String password = "eysn jgur qxmz hvqj"; // TODO: Thay bằng App Password

        // Cấu hình SMTP Gmail
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        // Xác thực tài khoản gửi
        Authenticator auth = new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(fromEmail, password);
            }
        };

        // Tạo session gửi mail
        Session session = Session.getInstance(props, auth);

        // Tạo nội dung email
        Message message = new MimeMessage(session);
        try {
            message.setFrom(new InternetAddress(fromEmail, "CES Shop"));
        } catch (UnsupportedEncodingException e) {
            message.setFrom(new InternetAddress(fromEmail));
        }

        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
        message.setSubject("Your Verification Code");

        // Nội dung email với mã xác thực 6 số
        message.setText("Your verification code is: " + verificationCode);

        // Gửi email
        Transport.send(message);
    }
}
