/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package game;

import static common.IToJsonObject.TypeLabel;
import org.json.JSONObject;

/**
 *
 * @author juanangel
 */
public class GameObjectsFactory {
    
    public static IGameObject getGameObject(JSONObject jObj) {
        
        IGameObject gObj = null;
        
        String typeLabel = jObj.getString(TypeLabel);
        
        if (typeLabel.equals("Blossom")){
            gObj = new Blossom(jObj);
        }
        else if (typeLabel.equals("Spider")){
            gObj = new Spider(jObj);
        }
        else if (typeLabel.equals("Bee")){
            gObj = new Bee(jObj);
        }
        else if (typeLabel.equals("Fly")){
            gObj = new Fly(jObj);
        }
        else if (typeLabel.equals("Caperucita")){
            gObj = new Caperucita(jObj);
        }        
        return gObj;
    }
    
    public static IGameObject getCopy(IGameObject obj) {
        
        IGameObject gObj = null;
        
        if (obj == null) return null;
        
        if (obj instanceof Blossom){
            gObj = new Blossom((Blossom)obj);
        }
        else if (obj instanceof Spider){
            gObj = new Spider((Spider)obj);
        }
        else if (obj instanceof Bee){
            gObj = new Bee((Bee)obj);
        } 
        else if (obj instanceof Fly){
            gObj = new Fly((Fly)obj);
        } 
        else if (obj instanceof Caperucita){
            gObj = new Caperucita((Caperucita)obj);
        }       
        return gObj;
    }

}
