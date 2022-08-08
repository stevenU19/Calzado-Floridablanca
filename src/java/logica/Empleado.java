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
    private String apellido;
    private String correo;
    private int salario;
    private String fechaNacimiento;
    private Empleado empleado;

    public Empleado(int cedula) {
        this.cedula = cedula;
    }   
  
    public Empleado(int cedula, String nombre, String apellido, String correo, int salario, String fechaNacimiento) {
        this.cedula = cedula;
        this.nombre = nombre;
        this.apellido = apellido;
        this.correo = correo;
        this.salario = salario;
        this.fechaNacimiento = fechaNacimiento;
    }

    public Empleado() {
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

    public String getApellido() {
        return apellido;
    }

    public void setApellido(String apellido) {
        this.apellido = apellido;
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

    @Override
    public String toString() {
        return "Empleado{" + "cedula=" + cedula + ", nombre=" + nombre + ", apellido=" + apellido + ", correo=" + correo + ", salario=" + salario + ", fechaNacimiento=" + fechaNacimiento + '}';
    }

    @Override
    public boolean crearEmpleado() {
        boolean exito = false;
        ConexionBD conexion = new ConexionBD();
        String SQL = "INSERT INTO empleados\n"
                + "( cedula, nombre, apellido, correo, salario, fechaNacimiento)\n"
                + "VALUES( '" + this.cedula + "', '" + this.nombre + "', '" + this.apellido + "', '" + this.correo
                + "', '" + this.salario + "', '" + this.fechaNacimiento + "');";

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
        String SQL = "DELETE FROM autores\n"
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
        String SQL = "UPDATE autores\n"
                + "SET nombre='" + this.nombre + "', apellido='" + this.apellido + "', correo='" + this.correo
                + "', salario='" + this.salario + "', fechaNacimiento='" + this.fechaNacimiento + "'\n"
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
        List<Empleado> autores = new ArrayList<>();
        String SQL = "SELECT * FROM autores";
        ConexionBD conexion = new ConexionBD();
        ResultSet rs = conexion.consultarBD(SQL);
        try {
            Empleado e;
            while (rs.next()) {
                e = new Empleado();
                e.setCedula(rs.getInt("cedula"));
                e.setNombre(rs.getString("nombre"));
                e.setApellido(rs.getString("apellido"));
                e.setCorreo(rs.getString("correo"));
                e.setSalario(rs.getInt("salario"));
                e.setFechaNacimiento(rs.getString("fechaNacimiento"));

                autores.add(e);
            }
        } catch (SQLException ex) {
            Logger.getLogger(Empleado.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            conexion.cerrarConexion();
        }
        return autores;
    }

    @Override
    public Empleado getEmpleado() {
        List<Empleado> empleados = new ArrayList<>();
        String SQL = "SELECT * FROM autores WHERE cedula = '"+this.cedula+"'";
        ConexionBD conexion = new ConexionBD();
        ResultSet rs = conexion.consultarBD(SQL);
        try {
            Empleado e;
            if (rs.next()) {
                this.cedula = rs.getInt("cedula");
                this.apellido = rs.getString("apellido");
                this.nombre = rs.getString("nombre");
                this.correo = rs.getString("correo");
                this.salario = rs.getInt("salario");
                this.fechaNacimiento = rs.getString("fechaNacimiento");
            }
        } catch (SQLException ex) {
            Logger.getLogger(Empleado.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            conexion.cerrarConexion();
        }
        return this;
    }
      
}
