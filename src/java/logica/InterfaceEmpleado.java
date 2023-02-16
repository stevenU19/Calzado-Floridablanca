/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package logica;

import java.util.List;

/**
 *
 * @author CENTIC
 */
public interface InterfaceEmpleado {
    
    public boolean crearEmpleado();
    public boolean eliminarEmpleado();
    public boolean actualizarEmpleado();
    public List <Empleado> listarEmpleado();
    
    // ----- Obtener un empleado -----
    public Empleado getEmpleado();
    
}
