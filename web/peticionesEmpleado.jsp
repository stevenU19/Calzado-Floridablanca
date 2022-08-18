
<%@page import="logica.Empleado"%>

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
        if (proceso.equals("guardar")) {

            //Solicitud de parámetros enviados desde el frontned
            //, uso de request.getParameter("nombre parametro")
            // creación de objeto y llamado a método guardar  
            
            int cedula = Integer.parseInt(request.getParameter("cedula"));            
            String nombre = request.getParameter("nombre");
            String apellido = request.getParameter("apellido");
            String correo = request.getParameter("correo");
            int salario = Integer.parseInt(request.getParameter("salario"));
            String fechaNacimiento = request.getParameter("fechaNacimiento");
            
            Empleado e  = new Empleado(cedula, nombre, apellido, correo, salario, fechaNacimiento);        
           
  
            if (e.crearEmpleado()) { 
                respuesta += "\"" + proceso + "\": true";
            } else {
                respuesta += "\"" + proceso + "\": false";
            }

        } else if (proceso.equals("eliminar")) {
        //Solicitud de parámetros enviados desde el frontned
            //, uso de request.getParameter("nombre parametro")
            //creación de objeto y llamado a método eliminar
            int cedula = Integer.parseInt(request.getParameter("cedula")); 
            Empleado e = new Empleado(cedula);
            if (e.eliminarEmpleado()) {
                respuesta += "\"" + proceso + "\": true";
            } else {
                respuesta += "\"" + proceso + "\": false";
            }

        } else if (proceso.equals("listar")) {
        //Solicitud de parámetros enviados desde el frontned
            //, uso de request.getParameter("nombre parametro")
           //creación de objeto y llamado al metodo listar
            try {
                Empleado e = new Empleado();
                List<Empleado> lista = e.listarEmpleado();
                respuesta += "\"" + proceso + "\": true,\"Empleados\":" + new Gson().toJson(lista); //IMPORTANTE: Recordar el nombre autores
            } catch (Exception ex) {
                respuesta += "\"" + proceso + "\": true,\"Empleados\":[]";
                Logger.getLogger(Empleado.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else if (proceso.equals("actualizar")) {
            //creación de objeto y llamado al metodo actualizar
            int cedula = Integer.parseInt(request.getParameter("cedula")); 
            Empleado e = new Empleado(cedula);
            if (e.actualizarEmpleado()) {                     
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

