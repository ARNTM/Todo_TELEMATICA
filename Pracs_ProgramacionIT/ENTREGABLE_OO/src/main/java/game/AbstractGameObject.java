/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package game;

import common.IToJsonObject;
import java.util.ArrayList;
import org.json.JSONException;
import org.json.JSONObject;

/**
 *
 * @author aruznieto
 */
public abstract class AbstractGameObject implements IGameObject, IToJsonObject{
    
    protected Position position;  
    int value;
    int lifes = 1;    
    int mode = 0;
        
    public AbstractGameObject(){
        position = new Position();
    }
    
    public AbstractGameObject(Position position){
        this.position = position;
    }
    
    public AbstractGameObject(Position position, int value, int life){
        this(position);
        this.value = value;
        this.lifes = life;
    }
    
    public AbstractGameObject(JSONObject obj){
        String type = obj.getString(IToJsonObject.TypeLabel);
        if (type.compareTo(getClass().getSimpleName()) != 0){
            throw new JSONException("Incompatible argument");
        }
        
        value = obj.getInt("value");
        lifes = obj.getInt("lifes");
        mode = obj.getInt("mode");
        
        position = new Position (obj.getJSONObject("position"));        
    }
    
    
    
    public String toString(){
        return this.getClass().getSimpleName() + ", " + 
               position + 
               ", value: " + value + ", lifes: " + lifes + ", mode: " + mode;
    }
    
    
    public JSONObject toJSONObject() {
        JSONObject jObj = new JSONObject();
        jObj.put(IToJsonObject.TypeLabel, this.getClass().getSimpleName());
        jObj.put("value", this.value);
        jObj.put("lifes", this.lifes);
        jObj.put("mode", this.mode);
        jObj.put("position", this.position.toJSONObject());
        return jObj;     
    }

    
    public Position getPosition() {
        return position;
    }

    
    public void setPosition(Position position) {
        this.position = position;       
    }
    
     
    public Position moveToNextPosition(){
        return position;       
    }  

    
    public int getValue() {
        return value;
    }
    
    public void setLifes(int lifes) {
        this.lifes = lifes;       
    }

    
    public void setValue(int value) {
        this.value = value;
    }

    
    public int getLifes() {
        return lifes;
    }

    
    public void incLifes(int value) {
        lifes += value;
    }
    
    
    public void setGameMode(int mode){
        this.mode = mode;
    }
   
    public static double distance(Position p1, Position p2){
        
        if (p1 == null || p2 == null){
            return 0;
        }    
        int dx = p1.x - p2.x;
        int dy = p1.y - p2.y;
        return Math.sqrt(dx*dx + dy*dy);        
    }
     
    public static double getDistance(IGameObject jObj1, IGameObject jObj2){
        return distance(jObj1.getPosition(), jObj2.getPosition());        
    }
    
    public static <T extends IGameObject> IGameObject getClosest(Position p, ArrayList<T> jObjs){

        if (jObjs == null || jObjs.isEmpty()){
            return null;
        }
                
        IGameObject closest = jObjs.get(0);
        double minD = distance(p, closest.getPosition());
        
        for(IGameObject b: jObjs){
            double d = distance(p, b.getPosition());
            if (d < minD){
                closest = b;
                minD = d;
            }
        }        
        return closest;        
    }       
    
    public static <T extends IGameObject> IGameObject getClosest(IGameObject jObj, ArrayList<T> jObjs){
        return getClosest(jObj.getPosition(), jObjs);
    }
}