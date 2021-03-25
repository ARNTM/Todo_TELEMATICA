/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package game;

import java.util.ArrayList;
import java.util.concurrent.ConcurrentLinkedQueue;

import org.json.JSONObject;

/**
 *
 * @author aruznieto
 */
public class Spider extends AbstractGameObject{
    
    ConcurrentLinkedQueue<IGameObject> gObjs = new ConcurrentLinkedQueue<IGameObject>();
    
    Spider(Position position) {
        super(position);    
    }
    
    Spider(Position position, int value, int life ) {
        super(position, value, life);    
    }
    
    Spider(Position position, int value, int life, ConcurrentLinkedQueue<IGameObject> gObjs) {
        super(position, value, life);    
        this.gObjs = gObjs;
    }
    
    Spider(JSONObject jObj) {
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
    
    public Position moveToNextPosition(){
        
        ArrayList<RidingHood> blossoms = getBlossoms();
        IGameObject target = AbstractGameObject.getClosest(this, blossoms);
        approachTo(target.getPosition());
       
        return position;       
    }  
    
    private ArrayList<RidingHood> getBlossoms(){
        ArrayList<RidingHood> blossoms = new ArrayList<RidingHood>();
        for (IGameObject obj: gObjs){
            if (obj instanceof RidingHood){
                blossoms.add((RidingHood) obj);
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
    
    public void printSpider(){
        System.out.println(this.toJSONObject());
    }
           
}

