/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package game;

import common.IToJsonObject;
import java.text.DecimalFormat;
import org.json.JSONException;
import org.json.JSONObject;

/**
 *
 * @author juanangel
 */
public class Position implements IToJsonObject {

    int x, y;
    
    static DecimalFormat form = new DecimalFormat();
    static {
       form.setMaximumFractionDigits(2); 
    }
    
    public Position(){}
    
    public Position(int x, int y) {
        this.x = x;
        this.y = y;
    }
    
    public Position(Position c) {
        this();
        if (c != null){
            this.x = c.x;
            this.y = c.y;
        }
    }
    
    public Position(JSONObject jObj){
       String type = jObj.getString(IToJsonObject.TypeLabel);
        if (type.compareTo(getClass().getSimpleName()) != 0){
            throw new JSONException("Incompatible argument");
        }
        x = jObj.getInt("x");
        y = jObj.getInt("y"); 
    }

    public void setX(int x) {
        this.x = x;
    }

    public void setY(int y) {
        this.y = y;
    }
    

    public int getX() {
        return x;
    }

    public int getY() {
        return y;
    }
    
    public boolean isEqual(Position p){
        if (p == null) {
            return false;
        }
        else{
            return (x == p.x && y == p.y);
        }
    }

    public JSONObject toJSONObject() {
        JSONObject jObj = new JSONObject();
        jObj.put(IToJsonObject.TypeLabel, this.getClass().getSimpleName());
        jObj.put("x", this.x);
        jObj.put("y", this.y);
        return jObj;    
    }
    
    public String toString(){
        return "[" + form.format(x) + ", " + form.format(y) + "]";
    }
    
}
