
<%@page import="logica.Proveedor"%>

<%-- 
    MODO DEPURACIÓN: Se va actualizando automáticamente-
    Sin embargo no funciona para cambios muy grandes.
    Algunos archivos quedan en la memoria caché.
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
        "guardar",
        "eliminar",
        "actualizar",
        "listar"
	
    });

    String proceso = "" + request.getParameter("proceso");

    // Validación de parámetros utilizados en todos los procesos.
    if (tareas.contains(proceso)) {
        respuesta += "\"ok\": true,";
        // ------------------------------------------------------------------------------------- //
        // -----------------------------------INICIO PROCESOS----------------------------------- //
        // ------------------------------------------------------------------------------------- //
        if (proceso.equals("crear")) {

            //Solicitud de parámetros enviados desde el frontned
            //, uso de request.getParameter("nombre parametro")
            // creación de objeto y llamado a método guardar   
            
            int proveedorID = Integer.parseInt(request.getParameter("proveedorID"));            
            String nombre = request.getParameter("nombre");
            String ciudad = request.getParameter("ciudad");
            int telefono = Integer.parseInt(request.getParameter("telefono"));
            
            Proveedor p  = new Proveedor(proveedorID, nombre, ciudad, telefono);        
           
  
            if (p.crearProveedores()) { 
                respuesta += "\"" + proceso + "\": true";
            } else {
                respuesta += "\"" + proceso + "\": false";
            }

        } else if (proceso.equals("eliminar")) {
        //Solicitud de parámetros enviados desde el frontned
            //, uso de request.getParameter("nombre parametro")
            //creación de objeto y llamado a método eliminar
            int proveedorID = Integer.parseInt(request.getParameter("proveedorID"));
            Proveedor p = new Proveedor(proveedorID);
            if (p.eliminarProveedores()) {
                respuesta += "\"" + proceso + "\": true";
            } else {
                respuesta += "\"" + proceso + "\": false";
            }

        } else if (proceso.equals("listar")) {
        //Solicitud de parámetros enviados desde el frontned
            //, uso de request.getParameter("nombre parametro")
           //creación de objeto y llamado al metodo listar
            try {
                Proveedor p = new Proveedor();
                List<Proveedor> lista = p.listarProveedores();
                respuesta += "\"" + proceso + "\": true,\"Proveedores\":" + new Gson().toJson(lista); //IMPORTANTE: Recordar el nombre autores
            } catch (Exception ex) {
                respuesta += "\"" + proceso + "\": true,\"Proveedores\":[]";
                Logger.getLogger(Proveedor.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else if (proceso.equals("actualizar")) {
            //creación de objeto y llamado al metodo actualizar
            int proveedorID = Integer.parseInt(request.getParameter("proveedorID")); 
            Proveedor p = new Proveedor(proveedorID);
            if (p.actualizarProveedores()) {                     
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
                + " son inválidos. Corrijalos y vuelva a intentar por favor.\"";
    }    
    // Responder como objeto JSON codificación ISO 8859-1.
    respuesta += "}";
    response.setContentType("application/json;charset=iso-8859-1");
    out.print(respuesta);
%>

