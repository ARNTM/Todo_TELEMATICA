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
public class VFigSpider extends AbstractGameView {
    
   

    public VFigSpider(IGameObject mObject, int length) throws Exception{
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
        g2.fillRect(x0+3*delta, y0+7*delta, 6*delta, 4*delta);
        g2.setColor(Color.red);   
        g2.fillRect(x0+5*delta, y0+11*delta, delta, delta);
        g2.fillRect(x0+6*delta, y0+11*delta, delta, delta);
        g2.setColor(Color.cyan); 
        g2.fillRect(x0+3*delta, y0+9*delta, delta, delta);
        g2.fillRect(x0+4*delta, y0+8*delta, delta, delta);
        g2.fillRect(x0+7*delta, y0+8*delta, delta, delta);
        g2.fillRect(x0+8*delta, y0+9*delta, delta, delta);
        
        // Body
        g2.setColor(Color.BLACK);    
        g2.fillRect(x0+2*delta, y0, 8*delta, 6*delta);
        
        // Legs
        for (int i = 0; i < 4; i++){
            g2.fillRect(x0, y0+2*i*delta, 2*delta, delta);
            g2.fillRect(x0+10*delta, y0+2*i*delta, 2*delta, delta);
        }
        g2.fillRect(x0, y0+7*delta, delta, 2*delta);
        g2.fillRect(x0+11*delta, y0+7*delta, delta, 2*delta);
       
        g2.setColor(c);
    }
}

