 /*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package async;

import game.GameFrame;
import game.IGameObject;
import java.awt.Color;
import java.awt.Graphics;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.ArrayList;
import java.util.TimerTask;
import java.util.concurrent.ConcurrentLinkedQueue;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;
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
public class ClientCanvasScheduled extends JPanel{
      
    IViewFactory viewFactory = new BoxesFactory();
    
    int editCol, editRow;
    int canvasEdge = 400;
    int squareEdge = 20;
    boolean squareOn = true;
    int xOffset, yOffset;
    int y=0;
    boolean enMarcha = false;
    ConcurrentLinkedQueue<ArrayList<IGameObject>> frames = new ConcurrentLinkedQueue<ArrayList<IGameObject>>();
    
    private final ScheduledExecutorService time = Executors.newSingleThreadScheduledExecutor();
    
    public ClientCanvasScheduled(){}    
    public ClientCanvasScheduled(int canvasEdge, int squareEdge){
        this.squareEdge = squareEdge;
        this.canvasEdge = canvasEdge;
        time.scheduleAtFixedRate(r , 0, 200, TimeUnit.MILLISECONDS);
      
    }    
    public void playMovie(ArrayList<GameFrame> movie){
    	enMarcha = true;
        if (movie != null){
            for (GameFrame f: movie){
                frames.add(f.getObjects());
            }
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
    Runnable r = new Runnable() {
	    public void run() {
	        repaint();
	        if(frames.isEmpty() && enMarcha){
	            System.out.println("Fin de la pelicula");
	            enMarcha = false;
	        }
      
    }};
    

    }
    
    

