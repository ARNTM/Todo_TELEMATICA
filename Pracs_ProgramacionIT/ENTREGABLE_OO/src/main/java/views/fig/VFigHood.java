/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package views.fig;

import game.IGameObject;
import game.Position;
import views.AbstractGameView;

import java.awt.BasicStroke;
import java.awt.Color;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.Polygon;

/**
 *
 * @author aruznieto
 */
public class VFigHood extends AbstractGameView {
    
   

    public VFigHood(IGameObject mObject, int length) throws Exception{
        super(mObject, length);       
    }
    
    public void draw(Graphics g) {
        
        Graphics2D g2 = (Graphics2D) g;
        
        Position coord = gObj.getPosition();
        
        int x0 = coord.getX() * length;
        int y0 = coord.getY() * length;
        int delta = length/12;
        
        Color c = g2.getColor();
        g2.setStroke(new BasicStroke(1));
        
        // Head
        g2.setColor(Color.BLACK);    
        g2.drawRect(x0+7*delta, y0, 2*delta, 4*delta);
        g2.setColor(Color.red);   
        g2.fillRect(x0+4*delta, y0, 3*delta, 4*delta);
        
        // Body
        g2.fillRect(x0+3*delta, y0+5*delta, 5*delta, 5*delta);
        
        // Basket
        g2.setColor(Color.ORANGE);   
        g2.fillRect(x0+4*delta, y0+7*delta, 5*delta, 2*delta);
        g2.fillRect(x0+4*delta, y0+5*delta, delta, 2*delta);
        g2.fillRect(x0+8*delta, y0+5*delta, delta, 2*delta);
               
        // Feet
        g2.fillRect(x0+3*delta, y0+11*delta, 2*delta, delta);
        g2.fillRect(x0+7*delta, y0+11*delta, 2*delta, delta);
       
        g2.setColor(c);
    }
}

