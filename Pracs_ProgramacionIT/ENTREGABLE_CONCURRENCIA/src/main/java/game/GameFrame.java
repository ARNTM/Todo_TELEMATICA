/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package game;

import common.IToJsonObject;
import java.util.ArrayList;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

/**
 *
 * @author juanangel
 */
public class GameFrame implements IToJsonObject {
    
    int frameNumber = 0;
    ArrayList<IGameObject> items = new ArrayList<IGameObject>();
    
    public GameFrame(int fn, ArrayList<IGameObject> gObjs){
        this.frameNumber = fn;
        this.items = gObjs;
    }
    
    public GameFrame(JSONObject jObj){
        String type = jObj.getString(IToJsonObject.TypeLabel);
        if (type.compareTo(getClass().getSimpleName()) != 0){
            throw new JSONException("Incompatible argument");
        } 
        
        frameNumber = jObj.getInt("frameNumber");
        
        JSONArray jarr = jObj.getJSONArray("items");
	for (int i = 0; i < jarr.length(); i++){
            items.add(GameObjectsFactory.getGameObject(jarr.getJSONObject(i)));  
	}        
    }
    
    public ArrayList<IGameObject> getObjects(){
        return items;
    }

   
    public JSONObject toJSONObject() {
        JSONObject jObj = new JSONObject();
        jObj.put(IToJsonObject.TypeLabel, this.getClass().getSimpleName());        
        
        jObj.put("frameNumber", frameNumber);
        
        JSONArray jArr = new JSONArray();
        int i = 0;
	for (IGameObject gObj : items){
            if (gObj != null){
                jArr.put(i, ((IToJsonObject)gObj).toJSONObject());
                i++;
            }
	}
	jObj.put("items", jArr);
        return jObj;
    }
    
}
