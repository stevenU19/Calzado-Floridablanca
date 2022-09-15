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
public class Empleado implements InterfaceEmpleado {

    private int cedula;
    private String nombre;
    private String correo;
    private int salario;
    private String fechaNacimiento;
    private String numero;

    public Empleado(int cedula) {
        this.cedula = cedula;
    }

    public Empleado(int cedula, String nombre, String correo, int salario, String fechaNacimiento, String numero) {
        this.cedula = cedula;
        this.nombre = nombre;
        this.correo = correo;
        this.salario = salario;
        this.fechaNacimiento = fechaNacimiento;
        this.numero = numero;
    }

    public Empleado() {
        System.out.println("Empleado Creado");
    }

    public int getCedula() {
        return cedula;
    }

    public void setCedula(int cedula) {
        this.cedula = cedula;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getCorreo() {
        return correo;
    }

    public void setCorreo(String correo) {
        this.correo = correo;
    }

    public int getSalario() {
        return salario;
    }

    public void setSalario(int salario) {
        this.salario = salario;
    }

    public String getFechaNacimiento() {
        return fechaNacimiento;
    }

    public void setFechaNacimiento(String fechaNacimiento) {
        this.fechaNacimiento = fechaNacimiento;
    }

    public String getNumero() {
        return numero;
    }

    public void setNumero(String numero) {
        this.numero = numero;
    }

    @Override
    public String toString() {
        return "Empleado{" + "cedula=" + cedula + ", nombre=" + nombre + ", correo=" + correo + ", salario=" + salario + ", fechaNacimiento=" + fechaNacimiento + "numero= " + numero + '}';
    }

    @Override
    public boolean crearEmpleado() {
        boolean exito = false;
        ConexionBD conexion = new ConexionBD();
        String SQL = "INSERT INTO empleado\n"
                + "( cedula, nombre, correo, salario, fechaNacimiento, numero)\n"
                + "VALUES( '" + this.cedula + "', '" + this.nombre + "', '" + this.correo
                + "', '" + this.salario + "', '" + this.fechaNacimiento + "', '" + this.numero + "');";

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
    public boolean eliminarEmpleado() {
        boolean exito = false;
        String SQL = "DELETE FROM empleado\n"
                + "WHERE cedula='" + this.cedula + "';";
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
    public boolean actualizarEmpleado() {
        boolean exito = false;
        String SQL = "UPDATE empleado\n"
                + "SET nombre='" + this.nombre + "', correo='" + this.correo
                + "', salario='" + this.salario + "', fechaNacimiento='" + this.fechaNacimiento + "', numero='" + this.numero +"' \n"
                + "WHERE cedula='" + this.cedula + "';";
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
    public List<Empleado> listarEmpleado() {
        List<Empleado> empleados = new ArrayList<>();
        String SQL = "SELECT * FROM empleado";
        ConexionBD conexion = new ConexionBD();
        Empleado e;
        ResultSet rs = conexion.consultarBD(SQL);
        try {                        
            while (rs.next()) {
                e = new Empleado();
                e.setCedula(rs.getInt("cedula"));
                e.setNombre(rs.getString("nombre"));
                e.setCorreo(rs.getString("correo"));
                e.setSalario(rs.getInt("salario"));
                e.setFechaNacimiento(rs.getString("fechaNacimiento"));
                e.setNumero(rs.getString("numero"));

                empleados.add(e);
                System.out.println("Estos son los datos de empleado "+e);
            }
        } catch (SQLException ex) {
            Logger.getLogger(Empleado.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            conexion.cerrarConexion();
        }
        return empleados;
    }

    @Override
    public Empleado getEmpleado() {
        String SQL = "SELECT * FROM empleado WHERE cedula=" + this.cedula + ";";
        ConexionBD conexion = new ConexionBD();

        ResultSet rs = conexion.consultarBD(SQL);

        try {
            Empleado e;
            if (rs.next()) {
                this.cedula = rs.getInt("cedula");
                this.nombre = rs.getString("nombre");
                this.correo = rs.getString("correo");
                this.salario = rs.getInt("salario");
                this.fechaNacimiento = rs.getString("fechaNacimiento");
                this.numero = rs.getString("numero");
            }
        } catch (SQLException ex) {
            Logger.getLogger(Empleado.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            conexion.cerrarConexion();
        }
        return this;
    }

}