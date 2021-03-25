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
public class Spider extends AbstractGameObject{
    
    public Spider(){}
    
    public Spider(Position position) {
        super(position);    
    }
    
    public Spider(Spider sp) {
        super(sp);    
    }
      
    public Spider(Position position, int value){
        super(position, value, 1);
    }
    
    public Spider(Position position, int value, int life){
        super(position, value, life);
    }
    
    public Spider(JSONObject obj){
        super(obj);
    }   
    
    public void printSpider(){
        System.out.println(this.toJSONObject());
    }
           
}

