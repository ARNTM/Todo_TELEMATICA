/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package views;

import game.Blossom;
import game.IGameObject;

/**
 *
 * @author aruznieto
 */
public abstract class AbstractGameView implements IAWTGameView{
    
    protected IGameObject gObj;
    protected int length = 20;
    
    public AbstractGameView(IGameObject obj, int length) throws Exception {
        
        if (obj != null){
            gObj = obj;
        }
        else {
            throw new Exception();
        }
        this.length = length;
    }
    
    public static IAWTGameView getView(IGameObject gObj, int length, IViewFactory factory) throws Exception{        
        return factory.getView(gObj, length);        
    }
    
}
