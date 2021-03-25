 /*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package game;

import java.awt.Color;
import java.awt.Graphics;
import java.util.concurrent.ConcurrentLinkedQueue;
import javax.swing.JPanel;
import views.AbstractGameView;
import views.IAWTGameView;
import views.IViewFactory;
import views.boxes.BoxesFactory;
import views.fig.FigFactory;
import views.icons.IconsFactory;

/**
 *
 * @author aruznieto
 */
public class GameCanvas extends JPanel {
	
    public int vistas = 1;
    
    static IViewFactory viewFactory = new BoxesFactory();
    
    // Seleccionar las vistas
    public static void setVistas(int vistas) {
    	switch(vistas) {
    	case 1: 
    		viewFactory = new BoxesFactory();
    		break;
    	case 2: 
    		viewFactory = new IconsFactory();
    		break;
    	case 3: 
    		viewFactory = new FigFactory();
    		break;
    	default: viewFactory = new BoxesFactory();
    	}
	}
    
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
        
        drawGrid(g);
        for (IGameObject gObj: gObjects){
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

