/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package logica;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import persistencia.ConexionBD;

/**
 *
 * @author CENTIC
 */
public class Proveedor implements InterfaceProveedor {

    private int proveedorID;
    private String nombre;
    private String ciudad;
    private int telefono;

    public Proveedor(int proveedorID) {
        this.proveedorID = proveedorID;
    }
    
    public Proveedor() {
        System.out.println("Proveedor Creado");
    }

    public Proveedor(int proveedorID, String nombre, String ciudad, int telefono) {
        this.proveedorID = proveedorID;
        this.nombre = nombre;
        this.ciudad = ciudad;
        this.telefono = telefono;
    }

    public int getProveedorID() {
        return proveedorID;
    }

    public void setProveedorID(int proveedorID) {
        this.proveedorID = proveedorID;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getCiudad() {
        return ciudad;
    }

    public void setCiudad(String ciudad) {
        this.ciudad = ciudad;
    }

    public int getTelefono() {
        return telefono;
    }

    public void setTelefono(int telefono) {
        this.telefono = telefono;
    }
    
    

    @Override
    public boolean crearProveedores() {
        boolean exito = false;
        ConexionBD conexion = new ConexionBD();
        String SQL = "INSERT INTO calzadofloridablanca.proveedor\n" +
                              "(proveedorID, nombre, ciudad, telefono)\n" +
                              "VALUES(" + this.proveedorID + ", '" + this.nombre + "', '" + this.ciudad + "', " + this.telefono +");";
 
        if (conexion.setAutoCommitBD(false)) {
            if (conexion.insertarBD(SQL)) {
                conexion.commitBD();
                conexion.cerrarConexion();
                exito = true;
            } else {
                conexion.cerrarConexion();
            }

        } else {
            conexion.cerrarConexion();
        }

        return exito;
    }

    @Override
    public boolean eliminarProveedores() {
        boolean exito = false;
        String SQL = "DELETE FROM proveedor\n"
                + "WHERE proveedorID='" + this.proveedorID + "';";
        ConexionBD conexion = new ConexionBD();
        if (conexion.setAutoCommitBD(false)) {
            if (conexion.actualizarBD(SQL)) {
                conexion.commitBD();
                exito = true;
            } else {
                conexion.rollbackBD();
                conexion.cerrarConexion();
            }
        } else {
            conexion.cerrarConexion();
        }
        return exito;
    }

    @Override
    public boolean actualizarProveedores() {
        boolean exito = false;
        String SQL = "UPDATE proveedor\n"
                + "SET nombre='" + this.nombre + "', ciudad='" + this.ciudad + "', telefono='" + this.telefono + "'\n"
                + "WHERE proveedorID='" + this.proveedorID + "';";
        ConexionBD conexion = new ConexionBD();
        if (conexion.setAutoCommitBD(false)) {
            if (conexion.actualizarBD(SQL)) {
                conexion.commitBD();
                exito = true;
            } else {
                conexion.rollbackBD();
                conexion.cerrarConexion();
            }
        } else {
            conexion.cerrarConexion();
        }
        return exito;
    }

    @Override
    public List<Proveedor> listarProveedores() {
        List<Proveedor> proveedores = new ArrayList<>();
        String SQL = "SELECT * FROM proveedor";
        ConexionBD conexion = new ConexionBD();        
        Proveedor p = null;        
        try {            
            ResultSet rs = conexion.consultarBD(SQL);
            while (rs.next()) {
                p = new Proveedor();
                p.setProveedorID(rs.getInt("proveedorID"));
                p.setNombre(rs.getString("nombre"));
                p.setCiudad(rs.getString("ciudad"));
                p.setTelefono(rs.getInt("telefono"));

                proveedores.add(p);
                System.out.println("Estos son los datos de proveedor "+p);
            }
        } catch (SQLException ex) {
            Logger.getLogger(Proveedor.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            conexion.cerrarConexion();
        }
        return proveedores;
    }

    @Override
    public Proveedor getProveedor() {
        String SQL = "SELECT * FROM proveedor WHERE proveedorID=" + this.proveedorID + ";";                
        ConexionBD conexion = new ConexionBD();        
        Proveedor p = null;
        ResultSet rs = conexion.consultarBD(SQL);
        try {            
            if (rs.next()) {
                this.proveedorID = rs.getInt("proveedorID");
                this.nombre = rs.getString("nombre");
                this.ciudad = rs.getString("ciudad");
                this.telefono = rs.getInt("telefono");
                System.out.println("Editar: "+rs.getInt("proveedorID")+" "+rs.getString("nombre")+" "+rs.getString("ciudad")+" "+rs.getInt("telefono"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(Proveedor.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            conexion.cerrarConexion();
        }
        return this;
    }

}
