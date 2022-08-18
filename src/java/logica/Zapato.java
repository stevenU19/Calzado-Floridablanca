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
 * @author Wilmer Farfán
 */
public class Zapato implements InterfaceZapatos {

    private int zapatoID;
    private String tipoZapato;
    private int talla;
    private String material;
    private int proveedorID;
    private int cedulaEmpleado;

    private Proveedor proveedor;
    private Empleado cedula;

    public Zapato(int zapatoID) {
        this.zapatoID = zapatoID;
    }

    public Zapato(int zapatoID, String tipoZapato, int talla, String material, int proveedorID, int cedulaEmpleado) {
        this.zapatoID = zapatoID;
        this.tipoZapato = tipoZapato;
        this.talla = talla;
        this.material = material;
        this.proveedorID = proveedorID;
        this.cedulaEmpleado = cedulaEmpleado;
    }

    public Zapato(String tipoZapato, int talla, String material) {
        this.tipoZapato = tipoZapato;
        this.talla = talla;
        this.material = material;
    }

    public Zapato() {

    }

    // ----------- Métodos Getter -----------  
    public int getZapatoID() {
        return zapatoID;
    }

    public String getTipoZapato() {
        return tipoZapato;
    }

    public int getTalla() {
        return talla;
    }

    public String getMaterial() {
        return material;
    }

    public int getProveedorID() {
        return proveedorID;
    }

    public int getCedulaEmpleado() {
        return cedulaEmpleado;
    }

    // ----------- Métodos Setter -----------
    public void setZapatoID(int zapatoID) {
        this.zapatoID = zapatoID;
    }

    public void setTipoZapato(String tipoZapato) {
        this.tipoZapato = tipoZapato;
    }

    public void setTalla(int talla) {
        this.talla = talla;
    }

    public void setMaterial(String material) {
        this.material = material;
    }

    public void setProveedorID(int proveedorID) {
        this.proveedorID = proveedorID;
    }

    public void setCedulaEmpleado(int cedulaEmpleado) {
        this.cedulaEmpleado = cedulaEmpleado;
    }

    @Override
    public boolean crearZapato() {
        boolean exito = false;
        ConexionBD conexion = new ConexionBD();
        String SQL = "INSERT INTO zapatos\n"
                + "(tipoZapato, talla, material)\n"
                + "VALUES( '" + this.tipoZapato + "', '" + this.talla + "', '"
                + this.material + "');";// "', '" + this.proveedorID + "', '" + this.cedulaEmpleado + "');";

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
    public List<Zapato> listarZapatos() {        
        String SQL = "SELECT * FROM zapatos";
        ConexionBD conexion = new ConexionBD();
        List<Zapato> listaZapatos = new ArrayList<>();
        
        try {
            ResultSet rs = conexion.consultarBD(SQL);
            Zapato z;
            while (rs.next()) {
                z = new Zapato();
                z.setZapatoID(rs.getInt("zapatoID"));
                z.setTipoZapato(rs.getString("tipoZapato"));
                z.setTalla(rs.getInt("talla"));
                z.setMaterial(rs.getString("material"));

                Empleado e = new Empleado(z.getCedulaEmpleado());
                z.setCedulaEmpleado(e.getCedula());
                
                Proveedor p = new Proveedor(z.getProveedorID());
                z.setProveedorID(p.getProveedorID());
                
                listaZapatos.add(z);
                
            }
        } catch (SQLException ex) {
            Logger.getLogger(Zapato.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            conexion.cerrarConexion();
        }
        return listaZapatos;

    }

    @Override
    public String toString() {
        return "Zapato{" + "zapatoID=" + zapatoID + ", tipoZapato=" + tipoZapato + ", talla=" + talla + ", material=" + material + ", proveedorID=" + proveedorID + ", cedulaEmpleado=" + cedulaEmpleado + '}';
    }

    @Override
    public boolean eliminarZapato() {
        boolean exito = false;
        String SQL = "DELETE FROM zapatos\n"
                + "WHERE zapatoID='" + this.zapatoID + "';";
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
    public boolean actualizarZapato() {
        boolean exito = false;
        String SQL = "UPDATE zapatos\n"
                + "SET tipoZapato='" + this.tipoZapato + "', talla='" + this.talla + ", material='" + this.material + "\n"
                + "WHERE zapatoID='" + this.zapatoID + "';";
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
    public Zapato getZapato() {
        ConexionBD conexion = new ConexionBD();
        String sql = "SELECT * FROM zapatos WHERE zapatoID='" + zapatoID + "';";
        try {
            ResultSet rs = conexion.consultarBD(sql);
            if (rs.next()) {
                tipoZapato = rs.getString("tipoZapato");
                talla = rs.getInt("talla");
                material = rs.getString("material");

                Proveedor p = new Proveedor(proveedorID);
                proveedor = p.getProveedor();
                Empleado e = new Empleado(cedulaEmpleado);
                cedula = e.getEmpleado();
            }
        } catch (Exception ex) {
            Logger.getLogger(Zapato.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            conexion.cerrarConexion();
        }
        return this;
    }

}
