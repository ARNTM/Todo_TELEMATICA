/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package async;

import game.GameFrame;
import game.GameLoader;
import java.util.ArrayList;
import java.util.concurrent.Callable;

import org.json.JSONObject;

import common.FileUtilities;

/**
 *
 * @author juanangel
 */
public class GameLoadTask extends GameLoader implements Callable<ArrayList<GameFrame>> {
    

    IAsyncLoaderObserver client;

    /**
     * Crea una petición de servicio (carga de un fichero del juego) 
     * que puede ser envida (submit) a un ejecutor.
     * @param client cliente que solicita el servicio.
     * @param fileName nombre del fichero a descargar. Se asume que está en "src/main/resources/games"
     */
    public GameLoadTask(IAsyncLoaderObserver client, String fileName){
        super(fileName);
        this.client = client;
    }

    /**
     * Carga el fichero solicitado e invoca el método loadComplete del cliente
     * antes de retornar.
     * @return
     * @throws Exception 
     */
    public ArrayList<GameFrame> call() throws Exception {
    	
        // 1.- Carga los frames de fichero.
    	ArrayList<GameFrame> gFrames = super.loadFramesFromFile();
        // 2.- Invoca método loadComplete del cliente.
    	client.loadComplete(fileName);
        System.out.println("Llamando a " + fileName);
        return gFrames;
    }     
}
