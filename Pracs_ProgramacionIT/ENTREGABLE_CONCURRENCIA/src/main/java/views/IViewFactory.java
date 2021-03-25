/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package views;

import game.IGameObject;

/**
 *
 * @author juanangel
 */
public interface IViewFactory {
   IAWTGameView getView(IGameObject gObj, int length) throws Exception; 
}
