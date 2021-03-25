/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package views.icons;

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
public class IconsFactory implements IViewFactory {
    
    public IAWTGameView getView(IGameObject gObj, int length) throws Exception {
        
                IAWTGameView view = null;
        
        
        if (gObj instanceof Fly){
           view = new VIcon(gObj, "src/main/resources/images/fly.png", length); 
        }
        else if (gObj instanceof Bee){
           view = new VIcon(gObj, "src/main/resources/images/bee.png", length); 
        }  
        else if (gObj instanceof RidingHood){
        	switch(((RidingHood)gObj).getDireccion()) {
        	case 1:
        		view = new VIcon(gObj, "src/main/resources/images/caperucita_der.png", length);
        		break;
        	case 2:
        		view = new VIcon(gObj, "src/main/resources/images/caperucita_izq.png", length);
        		break;
        	case 3:
        		view = new VIcon(gObj, "src/main/resources/images/caperucita_arriba.png", length);
        		break;
        	case 4:
        		view = new VIcon(gObj, "src/main/resources/images/caperucita_abajo.png", length);
        		break;
        	}
        } 
        else if (gObj instanceof Spider){
           view = new VIcon(gObj, "src/main/resources/images/spider.png", length); 
        } 
        else if (gObj instanceof Stone){
            view = new VIcon(gObj, "src/main/resources/images/stone.png", length); 
         } 
        else if (gObj instanceof Blossom){
           if (gObj.getValue() < 10){
                view = new VIcon(gObj, "src/main/resources/images/dandelion2.png", length); 
           }
           else {
                view = new VIcon(gObj, "src/main/resources/images/clover.png",  length); 
           }
        }
            
        return view;
    }
    
}
