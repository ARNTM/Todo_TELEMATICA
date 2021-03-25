/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package game;

import common.IToJsonObject;
import java.text.DecimalFormat;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

/**
 *
 * @author aruznieto
 */
public class Polyline implements IToJsonObject {
    
    private String name = "I'm a polyline";
    private Position q[];
    
    public static final DecimalFormat FORM;
    static {
       FORM = new DecimalFormat();
       FORM.setMaximumFractionDigits(2); 
    }
    
    /**
     * 
     */
    public Polyline(){
        q = new Position[1];
        q[0] = new Position();
    }
    
    /**
     * 
     * @param p 
     */
    public Polyline (Position p[]){
        this();
        if (p != null && p.length != 0){
            int counter = 0;
            //for (int i = 0; i < p.length; i++){
            for (Position pos : p){    
                if (pos != null){
                    counter++;
                }
            }  
            if (counter != 0){
                q = new Position[counter];
                counter = 0;
                for (Position p1 : p) {
                    if (p1 != null) {
                        q[counter] = new Position(p1);
                        counter++;
                    }
                }                
            }
        }
    }
    
    public Polyline(JSONObject jObj){
        String type = jObj.getString(IToJsonObject.TypeLabel);
        if (type.compareTo(getClass().getSimpleName()) != 0){
            throw new JSONException("Incompatible argument");
        } 
        
        name = jObj.getString("name");
        
        JSONArray jarr = jObj.getJSONArray("points");
        q = new Position[jarr.length()];
	for (int i = 0; i < jarr.length(); i++){
            q[i] = new Position(jarr.getJSONObject(i));
	} 
    }

    
    public JSONObject toJSONObject() {
        JSONObject jObj = new JSONObject();
        jObj.put(IToJsonObject.TypeLabel, this.getClass().getSimpleName());        
        
        jObj.put("name", name);
        
        JSONArray jArr = new JSONArray();
	for (int i = 0; i < q.length; i++){
            jArr.put(i, q[i].toJSONObject());
	}
	jObj.put("points", jArr);
        return jObj;
    }  
    
    
    public static void main(String [] args) {
        
        Position p[] = {new Position(), new Position(1,2)};
        Polyline pl = new Polyline(p);
        JSONObject jObj = pl.toJSONObject();
        System.out.println(jObj.toString());
        Polyline p2 = new Polyline(jObj);
        System.out.println(p2.toJSONObject().toString());       
        
        int x[] = {3,6,9};
        
        for (int i : x){
            System.out.println(i);
            i *= 2;        
        }
        for (int j : x){
            System.out.println(j);
            j *= 2;        
        }
    }
    
}
