 /*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package game;

import java.awt.Color;
import java.awt.Graphics;
import java.util.ArrayList;
import java.util.concurrent.ConcurrentLinkedQueue;
import javax.swing.JPanel;
import views.AbstractGameView;
import views.IAWTGameView;
import views.IViewFactory;
import views.boxes.BoxesFactory;

/**
 *
 * @author juanangel
 */
public class GameCanvas extends JPanel {
      
    IViewFactory viewFactory = new BoxesFactory();
    
    int editCol, editRow;
    int canvasEdge = 400;
    int squareEdge = 20;
    boolean squareOn = true;
    
    ConcurrentLinkedQueue<IGameObject> gObjects = new ConcurrentLinkedQueue<IGameObject>();
    
    public GameCanvas(){}
    
    public GameCanvas(int canvasEdge, int squareEdge){
        this.squareEdge = squareEdge;
        this.canvasEdge = canvasEdge;
    }
    
    public void setSquareEdge(int squareEdge){
        this.squareEdge = squareEdge;
        repaint();
    }
    
    
    public void drawObjects(ConcurrentLinkedQueue<IGameObject> gObjects){
        if (gObjects != null){
            this.gObjects = gObjects;
        }
        repaint();
    }
    
    public void drawObjects(ArrayList<IGameObject> lista){
        
        System.out.println("drawObjects ..... RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR");
        if (lista != null){
            this.gObjects.clear();
            for (IGameObject item : lista){
                System.out.println("----> " + item);
                this.gObjects.add(item);
            }
        }
        else{
            System.out.println("NULLLLLLLLLLL");
        }
        repaint();
    }
    
    public void refresh(){
        repaint();
    }
    
    public void setViewsFamily(IViewFactory viewFactory){       
        if (viewFactory != null) {
            this.viewFactory = viewFactory;
        }
         repaint();
    }
    

    
    private void drawGrid(Graphics g){
        Color c = g.getColor();
        g.setColor(Color.lightGray);
        int nLines = canvasEdge/squareEdge;

        for (int i = 1; i < nLines; i++){
            g.drawLine(i*squareEdge, 0, i*squareEdge, canvasEdge);
            g.drawLine(0, i*squareEdge, canvasEdge, i*squareEdge);
        }   
        g.setColor(c);
    }  
    
    public void paintComponent(Graphics g){
        super.paintComponent(g);
        //System.out.println("PPPPPPPPPPPPPPPPPPPPPPPPPP");
        System.out.println(gObjects.size());

        
        drawGrid(g);
        for (IGameObject gObj: gObjects){
            //System.out.println("XXX");
            if (gObj != null){
                IAWTGameView v;
                try {
                    v = AbstractGameView.getView(gObj, squareEdge, viewFactory);
                    v.draw(g);
                } catch (Exception ex) {}                
            }
        }
    }  
}

