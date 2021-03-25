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

/**
 *
 * @author aruznieto
 */
public class VFigFly extends AbstractGameView {
    
    private boolean odd;
   
    public VFigFly(IGameObject mObject, int length) throws Exception{
        super(mObject, length);       
    }
    
    public void draw(Graphics g) {
        
        Graphics2D g2 = (Graphics2D) g;
        
        Position coord = gObj.getPosition();
        
        int x0 = coord.getX() * length;
        int y0 = coord.getY() * length;
        int delta = length/10;
        
        Color c = g2.getColor();
        g2.setColor(Color.BLACK);    
        g2.setStroke(new BasicStroke(1));
        
        // Head
        g2.drawRect(x0+3*delta, y0+7*delta, 2*delta, 3*delta);
        g2.drawRect(x0+5*delta, y0+7*delta, 2*delta, 3*delta);
        g2.setColor(Color.RED);    
        g2.fillRect(x0+3*delta+1, y0+7*delta+1, 2*delta-2, 3*delta-2);
        g2.fillRect(x0+5*delta+1, y0+7*delta+1, 2*delta-2, 3*delta-2);
        
        // Body
        g2.setColor(Color.darkGray);    
        g2.fillRect(x0+3*delta, y0, 4*delta, 6*delta);
        
        // Wings
        if (odd){
            g2.setColor(Color.blue);  
        }
        else{
            g2.setColor(Color.darkGray);              
        }
        g2.drawRect(x0, y0+2*delta, 6*delta, 4*delta);
        if (!odd){
            g2.setColor(Color.blue);  
        }
        else{
            g2.setColor(Color.darkGray);              
        }
        g2.drawRect(x0+4*delta, y0+2*delta, 6*delta, 4*delta);
        odd = !odd;
        g2.setColor(c);
    }
}

