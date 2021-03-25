/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package game;

import common.FileUtilities;
import java.util.ArrayList;
import java.util.concurrent.ConcurrentLinkedQueue;

import org.json.JSONArray;
import org.json.JSONObject;

/**
 *
 * @author aruznieto
 */
public class RidingHood extends AbstractGameObject {
    
    int dX, dY;
    int direccion = 1;
    ConcurrentLinkedQueue<IGameObject> gObjs = new ConcurrentLinkedQueue<IGameObject>();

    RidingHood(Position position) {
        super(position);    
    }
    
    RidingHood(Position position, int value, int life ) {
        super(position, value, life);    
    }
    
    RidingHood(Position position, int value, int life, ConcurrentLinkedQueue<IGameObject> gObjs) {
        super(position, value, life);    
        this.gObjs = gObjs;
    }
    
    RidingHood(JSONObject jObj) {
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
    @Override
    public Position moveToNextPosition(){
        this.position.x += dX;
        this.position.y += dY;       
        return position;       
    }  
    
    public void moveRigth(){
        dY = 0; dX = 1;
        direccion = 1;
    }
    
    public void moveLeft(){
        dY = 0; dX = -1;
        direccion = 2;
    }
    
    public void moveUp(){
        dY = -1; dX = 0;
        direccion = 3;
    }
    
    public void moveDown(){
        dY = 1; dX = 0;
        direccion = 4;
    }
    
public Position moveToNextPositionAuto(){
        
        ArrayList<Blossom> blossoms = getBlossoms();
        IGameObject target = AbstractGameObject.getClosest(this, blossoms);
        approachTo(target.getPosition());
       
        return position;       
    }  
    
    private ArrayList<Blossom> getBlossoms(){
        ArrayList<Blossom> blossoms = new ArrayList<Blossom>();
        for (IGameObject obj: gObjs){
            if (obj instanceof Blossom){
                blossoms.add((Blossom) obj);
            }
        }
        return blossoms;
    }
    
    private void approachTo(Position p){
        if (position.x != p.x){
            position.x = position.x > p.x? position.x-1:position.x+1;
        }
        if (position.y != p.y){
            position.y = position.y > p.y? position.y-1:position.y+1;
        }
    } 
    
    public int getDireccion() {
    	return direccion;
    }
     
}
