/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package logica;

import java.util.Properties;

import javax.mail.*;

import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.swing.JOptionPane;



public class EnvioCorreo {

    public static boolean enviarCorreo(String asunto, String contenido, String to) {
        // Recipient's email ID needs to be mentioned.
        // Sender's email ID needs to be mentioned
        
        final String from = "calzadofloridablanca1@gmail.com";
        final String password = "dvsfmfvhdtwnuhle";

        // Assuming you are sending email through relay.jangosmtp.net
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.socketFactory.port", "465");
        props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.port", "465");
        
//        properties.put("mail.smtp.host", "mail.gmail.com");
//	properties.put("mail.smtp.starttls.enable", "true");
//	properties.put("mail.smtp.port",25);
//	properties.put("mail.smtp.mail.sender", emisor);
//	properties.put("mail.smtp.user", "usuario");
//	properties.put("mail.smtp.auth", "true");

        // Get the Session object.
        Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(from, password);
            }
        });

        try {
            System.out.println("Entró");
            // Create a default MimeMessage object.
            Message message = new MimeMessage(session);

            // Set From: header field of the header.
            message.setFrom(new InternetAddress(from));

            // Set To: header field of the header.
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));

            // Set Subject: header field
            message.setSubject(asunto);

            // Create the message part
            BodyPart messageBodyPart = new MimeBodyPart();

            // Now set the actual message
            messageBodyPart.setText(contenido);

            // Create a multipar message
            Multipart multipart = new MimeMultipart();

            // Set text message part
            multipart.addBodyPart(messageBodyPart);

            // Send the complete message parts
            message.setContent(multipart);
            
            System.out.println(message);

            // Send message
            Transport.send(message);

            System.out.println("Sent message successfully...");
            JOptionPane.showMessageDialog(null, "correo enviado con éxito");
            return true;

        } catch (MessagingException e) {
            e.printStackTrace();
            return false;
        }
    }
}
