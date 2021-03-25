/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package game;

import common.FileUtilities;
import java.util.ArrayList;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

/**
 *
 * @author aruznieto
 */
public class Stone extends AbstractGameObject {
    
    int dX, dY;

    Stone(Position position) {
        super(position);    
    }
    
    Stone(Position position, int value, int life ) {
        super(position, value, life);    
    }
    
    Stone(JSONObject jObj) throws JSONException {
        super(jObj);    
    } 
    
    /**
     * Cada vez que se invoca se dirige hacia el siguiente blossom, 
     * moviéndose una posición en x y otra en y.
     * Cuando ha pasado por todos los blossoms avanza en diagonal 
     * hacia abajo a las derecha.
     * @return posición en la que se encuentra después de ejecutarse el
     * método.
     */
    
    public void printStone(){
        System.out.println(this.toJSONObject());
    }
    
   
}
