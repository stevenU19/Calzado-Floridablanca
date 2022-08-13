/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package logica;

import java.util.List;

/**
 *
 * @author Wilmer Farfán
 */
public interface InterfaceZapatos {
    
    public boolean crearZapato();
    public boolean eliminarZapato();
    public boolean actualizarZapato();
    public List <Zapato> listarZapatos();
    
    public Zapato getZapato();
    
}
