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
public interface InterfaceProveedor {
    
    public boolean crearProveedores();
    public boolean eliminarProveedores();
    public boolean actualizarProveedores();
    public List <Proveedor> listarProveedores();
    
    public Proveedor getProveedor();
    
}
