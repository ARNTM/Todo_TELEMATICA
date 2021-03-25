/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package game;


import common.FileUtilities;
import java.io.FileNotFoundException;
import java.util.ArrayList;
import org.json.JSONObject;

/**
 *
 * @author juanangel
 */
public class GameLoader {
    
    protected String fileName;
    public static final String WORKING_PATH = "src/main/resources/games";

    /**
     * Crea un nuevo cargador de ficheros.
     * Asume que el directorio de trabajo es "src/main/resources/games"
     * @param fileName Nombre del fichero, asumiendo que el directorio de trabajo es 
     * "src/main/resources/games"
     */
    public GameLoader(String fileName){
        this.fileName = fileName;
    }
    
    /**
     * Obtiene una lista de frames del juego leyéndolos del fichero que se le
     * pasa en el constructor
     * @return lista de frames.
     * @throws FileNotFoundException 
     */
    public ArrayList<GameFrame> loadFramesFromFile() throws FileNotFoundException{
        ArrayList<String> sFrames = FileUtilities.readFile(WORKING_PATH + "/" + fileName);
        ArrayList<GameFrame> gFrames = new ArrayList<GameFrame>();
        for (String s : sFrames){
            GameFrame fr = new GameFrame(new JSONObject(s));
            gFrames.add(fr);
        }
        return gFrames;
    }
    
}
