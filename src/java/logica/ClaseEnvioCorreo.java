/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package logica;

import java.util.Properties;
import javax.activation.*;
import javax.mail.*;
import javax.mail.internet.*;


/**
 *
 * @author Wilmer Farfán
 */
public class ClaseEnvioCorreo {
    
    public static void transfer_to_email(String correo) {    
        
//        MailMessage message = new MailMessage();
//
//        // Establezca el asunto del mensaje, el cuerpo y la información del remitente
//        message.setSubject("New message created by Aspose.Email for .NET");
//        message.setBody("This is the body of the email.");
//        message.setFrom(new MailAddress("from@domain.com", "Sender Name", false));
//
//        // Agregar a destinatarios y destinatarios de CC
//        message.getTo().addItem(new MailAddress("to1@domain.com", "Recipient 1", false));
//        message.getCC().addItem(new MailAddress("cc1@domain.com", "Recipient 3", false));
//
//        // Agregar archivos adjuntos
//        message.getAttachments().addItem(new Attachment("word.docx"));
//
//        // Guarde el mensaje en formatos EML, EMLX, MSG y MHTML
//        message.save("EmailMessage.eml", SaveOptions.getDefaultEml());
//        message.save("EmailMessage.emlx", SaveOptions.createSaveOptions(MailMessageSaveType.getEmlxFormat()));
//        message.save("EmailMessage.msg", SaveOptions.getDefaultMsgUnicode());
//        message.save("EmailMessage.mhtml", SaveOptions.getDefaultMhtml());

        
        
        /*
        String correoEnvia = "calzadofloridablanca1@gmail.com";
        String contrasena = "dwpahhtbkrqiipkf";
        String mensaje = "Prueba correo";
        
        Properties objetoPEC = new Properties();
        
        objetoPEC.put("mail.smtp.host", "smtp.gmail.com");
        objetoPEC.setProperty("mail.smtp.starttls.enable", "true");
        objetoPEC.put("mail.smtp.port", "587");
        objetoPEC.put("mail.smtp.user", correoEnvia);
        objetoPEC.setProperty("mail.smtp.auth", "true");
        
        Session sesion = Session.getDefaultInstance(objetoPEC);
        MimeMessage mail = new MimeMessage(sesion);
        
        try {
            mail.setFrom(new InternetAddress (correoEnvia));
            mail.addRecipient(Message.RecipientType.TO, new InternetAddress (correo));
            mail.setSubject("Prueba de envio de correo 2");
            mail.setText(mensaje);
            
            Transport transporte = sesion.getTransport("smtp");
            transporte.connect(correoEnvia, contrasena);
            transporte.sendMessage(mail, mail.getRecipients(Message.RecipientType.TO));
            transporte.close();
            
            System.out.println("El correo se envio correctamente");
            
            
            
        }catch(Exception ex) {
            System.out.println("Error en el envio del correo");
            ex.printStackTrace();
            
        }*/
        
    }
    
}
