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
public class Fly extends AbstractGameObject{
	
	int mov, dX, dY;
    
    ConcurrentLinkedQueue<IGameObject> gObjs = new ConcurrentLinkedQueue<IGameObject>();
    
    Fly(Position position) {
        super(position);    
    }
    
    Fly(Position position, int value, int life ) {
        super(position, value, life);    
    }
    
    Fly(Position position, int value, int life, ConcurrentLinkedQueue<IGameObject> gObjs) {
        super(position, value, life);    
        this.gObjs = gObjs;
    }
    
    Fly(JSONObject jObj) {
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
    
    // Generamos un número aleatorio del 1 al 4 para seleccionar la direccion del siguiente movimiento
    public Position moveToNextPosition(){
    	Position position = new Position();
    	mov = (int)(Math.random()*4+1);
    	
    	switch(mov) {
    	case 1:
    		position= this.getPosition();
    		position.setY(this.getPosition().y-1);
    		break;
    	case 2:
    		position= this.getPosition();
    		position.setY(this.getPosition().y+1);   
    		break;
    	case 3:
    		position= this.getPosition();
    		position.setX(this.getPosition().x-1);
    		break;
    	case 4:
    		position= this.getPosition();
    		position.setX(this.getPosition().x+1); 
    		break;
    	}
       
        return position;       
    }  
    
    public void printFly(){
        System.out.println(this.toJSONObject());
    }
 
}
