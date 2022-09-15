
<%@page import="logica.Zapato"%>

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
        "ListarPorID",
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
            int zapatoID = Integer.parseInt(request.getParameter("zapatoID"));
            int talla = Integer.parseInt(request.getParameter("talla"));
            String tipoZapato = request.getParameter("tipoZapato");
            String material = request.getParameter("material");
            int proveedorID = Integer.parseInt(request.getParameter("proveedorID"));
            int cedulaEmpleado = Integer.parseInt(request.getParameter("cedulaEmpleado"));            

            Zapato z = new Zapato(zapatoID, tipoZapato, talla, material, proveedorID, cedulaEmpleado);

            if (z.crearZapato()) {
                respuesta += "\"" + proceso + "\": true";
            } else {
                respuesta += "\"" + proceso + "\": false";
            }

        } else if (proceso.equals("eliminar")) {
            //Solicitud de parámetros enviados desde el frontned
            //, uso de request.getParameter("nombre parametro")
            //creación de objeto y llamado a método eliminar
            int zapatoID = Integer.parseInt(request.getParameter("zapatoID"));
            Zapato z = new Zapato(zapatoID);
            z.setZapatoID(zapatoID);
            if (z.eliminarZapato()) {
                respuesta += "\"" + proceso + "\": true";
            } else {
                respuesta += "\"" + proceso + "\": false";
            }

        } else if (proceso.equals("listar")) {
            //Solicitud de parámetros enviados desde el frontned
            //, uso de request.getParameter("nombre parametro")
            //creación de objeto y llamado al metodo listar
            try {
                Zapato z = new Zapato();
                List<Zapato> lista = z.listarZapatos();
                respuesta += "\"" + proceso + "\": true,\"Zapatos\":" + new Gson().toJson(lista); //IMPORTANTE: Recordar el nombre 
            } catch (Exception ex) {
                respuesta += "\"" + proceso + "\": true,\"Zapatos\":[]";
                Logger.getLogger(Zapato.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else if (proceso.equals("actualizar")) {
            //creación de objeto y llamado al metodo actualizar
            int zapatoID = Integer.parseInt(request.getParameter("zapatoID"));
            String tipoZapato = request.getParameter("tipoZapato");
            int talla = Integer.parseInt(request.getParameter("talla"));
            String material = request.getParameter("material");
            int proveedorID = Integer.parseInt(request.getParameter("proveedorID"));
            int cedulaEmpleado = Integer.parseInt(request.getParameter("cedulaEmpleado"));

            Zapato z = new Zapato(zapatoID, tipoZapato, talla, material, proveedorID, cedulaEmpleado);

            if (z.actualizarZapato()) {
                respuesta += "\"" + proceso + "\": true";
            } else {
                respuesta += "\"" + proceso + "\": false";
            }
        } else if (proceso.equals("ListarPorID")) {
            int zapatoID = Integer.parseInt(request.getParameter("zapatoID"));
            Zapato z = null;
            try {
                z = new Zapato(zapatoID).getZapato();
                respuesta += "\"" + proceso + "\": true,\"Zapato\":" + new Gson().toJson(z);
            } catch (Exception ex) {
               respuesta += "\"" + proceso + "\": false,\"Zapato\":" + new Gson().toJson(z);
                Logger.getLogger(Zapato.class.getName()).log(Level.SEVERE, null, ex);
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

