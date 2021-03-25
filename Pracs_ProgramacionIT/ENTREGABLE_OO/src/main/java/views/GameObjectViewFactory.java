/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package views;

import game.Bee;
import game.Blossom;
import game.Fly;
import game.IGameObject;
import game.RidingHood;
import game.Spider;
import views.boxes.VNumberedBox;
import views.boxes.VNumberedCircle;
import views.icons.VIcon;

import java.awt.Color;

/**
 *
 * @author aruznieto
 */
public class GameObjectViewFactory {
    

    public static final String BOXES_VIEWS = "BoxesViews"; 
    public static final String ROUNDED_VIEWS = "RoundedViews"; 
    public static final String SQUARE_VIEWS = "SquareViews"; 
    public static final String ICONS_VIEWS = "IconsViews"; 
    
    /**
     * Creates a view for a game object of a given family with a given size
     * @param gObj game object the view is created for.
     * @param family view family selected
     * @param length view's size 
     * @return the view
     * @throws Exception if gObj is null
     */
    public static IAWTGameView getView(IGameObject gObj, String family, int length) throws Exception{
        
        if (family.compareTo(BOXES_VIEWS) == 0){
            getSquareView(gObj, length);
        }
        else if (family.compareTo(ROUNDED_VIEWS) == 0){
            return getRoundedShape(gObj, length);
        }
        else if (family.compareTo(BOXES_VIEWS) == 0){
            return getSquareView(gObj, length);
        }
        else if (family.compareTo(ICONS_VIEWS) == 0){
            return getIconView(gObj, length);
        }
        
        return getBoxView(gObj, length);
        
    }
    
    /**
     * Views factory for box views family
     * @param gObj
     * @param length
     * @return
     * @throws Exception 
     */
    public static IAWTGameView getBoxView(IGameObject gObj, int length) throws Exception{    
        
        IAWTGameView view = null;
        
        if (gObj instanceof Fly){
           view = new VNumberedCircle(gObj, length, Color.gray, "Fly"); 
        }
        else if (gObj instanceof Bee){
           view = new VNumberedCircle(gObj, length, Color.orange, "Bee");
        } 
        else if (gObj instanceof Spider){
           view = new VNumberedCircle(gObj, length, Color.black, "Spider"); 
        } 
        else if (gObj instanceof Blossom){
           if (gObj.getValue() < 10){
                view = new VNumberedBox(gObj, length, Color.pink, "DLion");  
           }
           else {
                view = new VNumberedBox(gObj, length, Color.GREEN, "Clover"); 
           }
        }
        else if (gObj instanceof RidingHood){
           view = new VNumberedCircle(gObj, length, Color.red, "Hood"); 
        }  
        return view;        
    }
    
    /**
     * Views factory for icon views family
     * @param gObj
     * @param length
     * @return
     * @throws Exception 
     */
    public static IAWTGameView getIconView(IGameObject gObj, int length) throws Exception{
        
        IAWTGameView view = null;
        
        
        if (gObj instanceof Fly){
           view = new VIcon(gObj, "src/main/resources/views/fly.jpg", length); 
        }
        else if (gObj instanceof Bee){
           view = new VIcon(gObj, "src/main/resources/views/bee.jpg", length); 
        }  
        else if (gObj instanceof RidingHood){
           view = new VIcon(gObj, "src/main/resources/views/caperucita.jpg", length); 
        } 
        else if (gObj instanceof Spider){
           view = new VIcon(gObj, "src/main/resources/views/spider.jpg", length); 
        } 
        else if (gObj instanceof Blossom){
           if (gObj.getValue() < 10){
                view = new VIcon(gObj, "src/main/resources/views/dandelion2.jpg", length); 
           }
           else {
                view = new VIcon(gObj, "src/main/resources/views/clover.jpg",  length); 
           }
        }
            
        return view;
    }
    
    public static IAWTGameView getSquareView(IGameObject gObj, int length) throws Exception{        
        return getBoxView(gObj, length); 
    }
    
    public static IAWTGameView getRoundedShape(IGameObject gObj, int length) throws Exception{
        return getIconView(gObj, length);
    }
           
}
