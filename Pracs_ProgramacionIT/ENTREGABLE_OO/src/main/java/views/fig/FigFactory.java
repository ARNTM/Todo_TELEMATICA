/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package views.fig;

import game.Bee;
import game.Bee;
import game.Blossom;
import game.Fly;
import game.IGameObject;
import game.RidingHood;
import game.Spider;
import game.Stone;
import views.IAWTGameView;
import views.IViewFactory;

/**
 *
 * @author aruznieto
 */
public class FigFactory implements IViewFactory {
    
    public IAWTGameView getView(IGameObject gObj, int length) throws Exception {
        
                IAWTGameView view = null;
        
        
        if (gObj instanceof Fly){
           view = new VFigFly(gObj, length); 
        }
        else if (gObj instanceof Bee){
           view = new VFigBee(gObj, length); 
        }  
        else if (gObj instanceof RidingHood){
           view = new VFigHood(gObj, length); 
        } 
        else if (gObj instanceof Spider){
           view = new VFigSpider(gObj, length); 
        } 
        else if (gObj instanceof Stone){
            view = new VFigStone(gObj, length); 
         } 
        else if (gObj instanceof Blossom){
           if (gObj.getValue() < 10){
                view = new VFigDandelion(gObj, length); 
           }
           else {
                view = new VFigClover(gObj,  length); 
           }
        }
            
        return view;
    }
    
}
