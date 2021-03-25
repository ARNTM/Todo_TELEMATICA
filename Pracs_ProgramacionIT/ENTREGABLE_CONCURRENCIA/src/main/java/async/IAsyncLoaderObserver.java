/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package async;

import game.GameFrame;
import java.util.ArrayList;

/**
 *
 * @author juanangel
 */
public interface IAsyncLoaderObserver {
    
    /**
     * Invocado por la tarea de carga del fichero cuando ha terminado la carga.
     * Este método se ejecuta en el cliente que solicitó el servicio.
     * La implementación debe retornar lo antes posible y no contener llamadas bloqueantes.
     * En caso contrario puede bloquear a la tarea invocante.
     * @param key permite identificar el servicio solicitado.
     */
    public void loadComplete(String key);
    public String getWorkingPATH();
}
