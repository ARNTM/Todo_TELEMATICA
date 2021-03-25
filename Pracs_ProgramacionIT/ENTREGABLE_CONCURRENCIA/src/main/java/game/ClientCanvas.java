 /*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package game;

import java.awt.Color;
import java.awt.Graphics;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.ArrayList;
import java.util.concurrent.ConcurrentLinkedQueue;
import javax.swing.JPanel;
import javax.swing.Timer;
import views.AbstractGameView;
import views.IAWTGameView;
import views.IViewFactory;
import views.boxes.BoxesFactory;

/**
 *
 * @author juanangel
 */
public class ClientCanvas extends JPanel implements ActionListener {
      
    IViewFactory viewFactory = new BoxesFactory();
    
    int editCol, editRow;
    int canvasEdge = 400;
    int squareEdge = 20;
    boolean squareOn = true;
    int xOffset, yOffset;
    
    ConcurrentLinkedQueue<ArrayList<IGameObject>> frames = new ConcurrentLinkedQueue<ArrayList<IGameObject>>();
    
    Timer timer = new Timer(200, this);
    
    
    public ClientCanvas(){}
    
    public ClientCanvas(int canvasEdge, int squareEdge){
        this.squareEdge = squareEdge;
        this.canvasEdge = canvasEdge;
        timer.start();
    }
    
    public void playMovie(ArrayList<GameFrame> movie){
        if (movie != null && !timer.isRunning()){
            for (GameFrame f: movie){
                frames.add(f.getObjects());
            }
            timer.restart();
        }
    }
        
    private void drawGrid(Graphics g){
        Color c = g.getColor();
        g.setColor(Color.lightGray);
        int nLines = canvasEdge/squareEdge;

        for (int i = 0; i <= nLines; i++){
            g.drawLine(i*squareEdge, 0, i*squareEdge, canvasEdge);
            g.drawLine(0, i*squareEdge, canvasEdge, i*squareEdge);
        }   
        g.setColor(c);
    }  
    
    public void paintComponent(Graphics g){
        super.paintComponent(g);
        drawGrid(g);
        ArrayList<IGameObject> frame = frames.poll();
        if (frame == null){
            return;
        }
        for (IGameObject gObj: frame){
            if (gObj != null){
                IAWTGameView v;
                try {
                    v = AbstractGameView.getView(gObj, squareEdge, viewFactory);
                    v.draw(g);
                } catch (Exception ex) {}                
            }
        }
    }  

   
    public void actionPerformed(ActionEvent ae) {
        repaint();
        if (frames.isEmpty() && timer.isRunning()){
            timer.stop();
            System.out.println("ClientCanvas. End of Movie");
        }
    }
}

