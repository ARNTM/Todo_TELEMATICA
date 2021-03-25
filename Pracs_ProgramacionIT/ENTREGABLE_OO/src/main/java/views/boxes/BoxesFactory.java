/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package views.boxes;

import game.Bee;
import game.Blossom;
import game.Fly;
import game.IGameObject;
import game.RidingHood;
import game.Spider;
import game.Stone;

import java.awt.Color;
import views.IAWTGameView;
import views.IViewFactory;

/**
 *
 * @author aruznieto
 */
public class BoxesFactory implements IViewFactory {
    
    public IAWTGameView getView(IGameObject gObj, int length) throws Exception {
        
        IAWTGameView view = new VNumberedBox(gObj, length);
                
        if (gObj instanceof Fly){
           view = new VNumberedBox(gObj, length, Color.gray, "Fly"); ; 
        }
        else if (gObj instanceof Bee){
           view = new VNumberedBox(gObj, length, Color.YELLOW, "Bee"); 
        }
        else if (gObj instanceof Spider){
           view = new VNumberedBox(gObj, length, Color.black, "Spider");
        }
        else if (gObj instanceof RidingHood){
           view = new VNumberedBox(gObj, length, Color.red, "Hood");
        } 
        else if (gObj instanceof Stone){
            view = new VNumberedBox(gObj, length, Color.darkGray, "Stone");
         } 
        else if (gObj instanceof Blossom){
            if (gObj.getValue() < 10){
                view = new VNumberedBox(gObj, length, Color.pink, "DLion");
            }
            else {
                view = new VNumberedBox(gObj, length, Color.GREEN, "Clover");
            }
        }
        return view; 
    }
    
}
