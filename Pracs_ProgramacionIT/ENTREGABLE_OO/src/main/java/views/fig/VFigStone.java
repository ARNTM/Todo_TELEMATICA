/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package views.fig;


import game.IGameObject;
import game.Position;
import java.awt.BasicStroke;
import java.awt.Color;
import java.awt.Graphics;
import java.awt.Graphics2D;
import views.AbstractGameView;

/**
 *
 * @author aruznieto
 */
public class VFigStone extends AbstractGameView {

    Color myColor = Color.gray;
        
    public VFigStone(IGameObject mObject, int l) throws Exception{
        super(mObject, l);
    }
        
    
    public void draw(Graphics g) {
        
        Graphics2D g2 = (Graphics2D) g;
        
        Position coord = gObj.getPosition();
        
        
        Color c = g2.getColor();
        g2.setColor(myColor);    
        g2.setStroke(new BasicStroke(2));
                
        g2.fillOval(
                length * coord.getX() + (int)((1/4.0) * length),
                length * coord.getY() + (int)((1/4.0) * length),      
                (int) ((1/2.0) * length),
                (int) ((1/2.0) * length)
        );
        g2.drawOval(
                length * coord.getX(), length * coord.getY(),      
                (int) ((1/2.0) * length),
                (int) ((1/2.0) * length)
        );
        g2.drawOval(
                length * coord.getX() + (int) ((1/2.0) * length), length * coord.getY(),      
                (int) ((1/2.0) * length),
                (int) ((1/2.0) * length));
        g2.drawOval(
                length * coord.getX(), length * coord.getY() + (int) ((1/2.0) * length),      
                (int) ((1/2.0) * length),
                (int) ((1/2.0) * length)
        );
        g2.drawOval(
                length * coord.getX() + (int) ((1/2.0) * length), 
                length * coord.getY() + (int) ((1/2.0) * length),      
                (int) ((1/2.0) * length),
                (int) ((1/2.0) * length)
        );
                
        g2.setColor(c);
    }
    
}
