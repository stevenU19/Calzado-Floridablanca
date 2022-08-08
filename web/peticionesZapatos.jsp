
<%@page import="logica.Zapato"%>

<%-- 
    MODO DEPURACI�N: Se va actualizando autom�ticamente-
    Sin embargo no funciona para cambios muy grandes.
    Algunos archivos quedan en la memoria cach�.
--%>

<%@page import="java.util.logging.Logger"%>
<%@page import="java.util.logging.Level"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="application/json;charset=iso-8859-1" language="java" pageEncoding="iso-8859-1" session="true"%>

<%    // Iniciando respuesta JSON.
    String respuesta = "{";

    //Lista de procesos o tareas a realizar 
    List<String> tareas = Arrays.asList(new String[]{
        "crear",
        "eliminar",
        "actualizar",
        "listar"
	
    });

    String proceso = "" + request.getParameter("proceso");

    // Validaci�n de par�metros utilizados en todos los procesos.
    if (tareas.contains(proceso)) {
        respuesta += "\"ok\": true,";
        // ------------------------------------------------------------------------------------- //
        // -----------------------------------INICIO PROCESOS----------------------------------- //
        // ------------------------------------------------------------------------------------- //
        if (proceso.equals("crear")) {

            //Solicitud de par�metros enviados desde el frontned
            //, uso de request.getParameter("nombre parametro")
            // creaci�n de objeto y llamado a m�todo guardar              
            
            int talla = Integer.parseInt(request.getParameter("proveedorID"));            
            String tipoZapato = request.getParameter("nombre");
            String material = request.getParameter("ciudad");
            int cedulaEmpleado = Integer.parseInt(request.getParameter("telefono"));            
            
            Zapato z  = new Zapato(tipoZapato, talla, material, cedulaEmpleado);        
           
  
            if (z.crearZapato()) { 
                respuesta += "\"" + proceso + "\": true";
            } else {
                respuesta += "\"" + proceso + "\": false";
            }

        } else if (proceso.equals("eliminar")) {
        //Solicitud de par�metros enviados desde el frontned
            //, uso de request.getParameter("nombre parametro")
            //creaci�n de objeto y llamado a m�todo eliminar
            int zapatoID = Integer.parseInt(request.getParameter("zapatoID"));
            Zapato z = new Zapato(zapatoID);
            if (z.eliminarZapato()) {
                respuesta += "\"" + proceso + "\": true";
            } else {
                respuesta += "\"" + proceso + "\": false";
            }

        } else if (proceso.equals("listar")) {
        //Solicitud de par�metros enviados desde el frontned
            //, uso de request.getParameter("nombre parametro")
           //creaci�n de objeto y llamado al metodo listar
            try {
                Zapato z = new Zapato();
                List<Zapato> lista = z.listarZapatos();
                respuesta += "\"" + proceso + "\": true,\"Zapatos\":" + new Gson().toJson(lista); //IMPORTANTE: Recordar el nombre autores
            } catch (Exception ex) {
                respuesta += "\"" + proceso + "\": true,\"Zapatos\":[]";
                Logger.getLogger(Zapato.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else if (proceso.equals("actualizar")) {
            //creaci�n de objeto y llamado al metodo actualizar
            int zapatoID = Integer.parseInt(request.getParameter("zapatoID")); 
            Zapato z = new Zapato(zapatoID);
            if (z.actualizarZapato()) {                     
                respuesta += "\"" + proceso + "\": true";
            } else {
                respuesta += "\"" + proceso + "\": false";
            }
        }

        // ------------------------------------------------------------------------------------- //
        // -----------------------------------FIN PROCESOS-------------------------------------- //
        // ------------------------------------------------------------------------------------- //
        // Proceso desconocido.
    } else {
        respuesta += "\"ok\": false,";
        respuesta += "\"error\": \"INVALID\",";
        respuesta += "\"errorMsg\": \"Lo sentimos, los datos que ha enviado,"
                + " son inv�lidos. Corrijalos y vuelva a intentar por favor.\"";
    }    
    // Responder como objeto JSON codificaci�n ISO 8859-1.
    respuesta += "}";
    response.setContentType("application/json;charset=iso-8859-1");
    out.print(respuesta);
%>

