/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package game;

import org.json.JSONObject;


/**
 *
 * @author juanangel
 */
public class Fly extends AbstractGameObject{
    
    public Fly(){}
    
    public Fly(Position position) {
        super(position);    
    }
    
    public Fly(Fly f) {
        super(f);    
    }
      
    public Fly(Position position, int value){
        super(position, value, 1);
    }
    
    public Fly(Position position, int value, int life){
        super(position, value, life);
    }
    
    public Fly(JSONObject obj){
        super(obj);
    }   
    
    public void printFly(){
        System.out.println(this.toJSONObject());
    }
}
