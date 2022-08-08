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

    public Zapato(int zapatoID) {
        this.zapatoID = zapatoID;
    }
       

    public Zapato(String tipoZapato, int talla, String material, int cedulaEmpleado) {
        this.zapatoID = zapatoID;
        this.tipoZapato = tipoZapato;
        this.talla = talla;
        this.material = material;
        //this.proveedorID = proveedorID;
        //this.cedulaEmpleado = cedulaEmpleado;
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
        List<Zapato> zapatos = new ArrayList<>();
        String SQL = "SELECT * FROM zapatos";
        ConexionBD conexion = new ConexionBD();
        ResultSet rs = conexion.consultarBD(SQL);
        try {
            Zapato z;
            while (rs.next()) {
                z = new Zapato();
                z.setZapatoID(rs.getInt("zapatoID"));
                z.setTipoZapato(rs.getString("tipoZapato"));
                //z.setProveedorID(rs.getInt("proveedorID"));
                z.setMaterial(rs.getString("material"));
                z.setTalla(rs.getInt("material"));
                //z.setCedulaEmpleado(rs.getInt("cedulaEmpleado"));

                zapatos.add(z);
            }
        } catch (SQLException ex) {
            Logger.getLogger(Zapato.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            conexion.cerrarConexion();
        }
        return zapatos;

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

}
