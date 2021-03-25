/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package game;

import common.FileUtilities;
import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.Dimension;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.KeyEvent;
import java.awt.event.KeyListener;
import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.concurrent.ConcurrentLinkedQueue;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.BorderFactory;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.SwingConstants;
import javax.swing.Timer;
import javax.swing.border.EtchedBorder;

/**
 *
 * @author juanangel
 */
public class AGame extends JFrame implements KeyListener, ActionListener {

    // KeyBoard
    public static final int UP_KEY    = 38;
    public static final int DOWN_KEY  = 40;
    public static final int RIGTH_KEY = 39;
    public static final int LEFT_KEY  = 37;
    public static final int SPACE_KEY = 32;
    int lastKey = DOWN_KEY;
    
    // Game Panel and 
    public static final int CANVAS_WIDTH = 480;    
    int boxSize = 40;
    int row, col;
    GameCanvas canvas;
    JPanel canvasFrame;    
    JLabel dataLabel;
    
    // Timer
    Timer timer;
    int tick = 200;
    
    // Game Variables
    ConcurrentLinkedQueue<IGameObject> gObjs = new ConcurrentLinkedQueue<IGameObject>();
    ArrayList<GameFrame> frames = new ArrayList<GameFrame>();
    
    Caperucita ridingHood = new Caperucita(new Position(0,0), 1, 1, gObjs);
    int screenCounter = 0;
    int gameCounter = 1;
    int frameCounter = 0;
    String path = "src/main/resources/games";

    
    public AGame() throws Exception{

       super("Game_1");
       
       // Game Initializations.
       gObjs.add(ridingHood);
       loadNewBoard(0);
            
       // Window initializations.
       dataLabel = new JLabel(ridingHood.toString());
       dataLabel.setBorder(BorderFactory.createEtchedBorder(EtchedBorder.LOWERED)); 
       dataLabel.setPreferredSize(new Dimension(120,40));
       dataLabel.setHorizontalAlignment(SwingConstants.CENTER);
      
       canvas = new GameCanvas(CANVAS_WIDTH, boxSize);
       canvas.setPreferredSize(new Dimension(CANVAS_WIDTH, CANVAS_WIDTH));
       canvas.setBorder(BorderFactory.createLineBorder(Color.blue));
       
       canvasFrame = new JPanel();
       canvasFrame.setPreferredSize(new Dimension(CANVAS_WIDTH + 40, CANVAS_WIDTH + 40));
       canvasFrame.add(canvas);
       getContentPane().add(canvasFrame);
       getContentPane().add(dataLabel, BorderLayout.SOUTH);
       
       setSize (CANVAS_WIDTH + 40, CANVAS_WIDTH + 80);
       setResizable(false);
       setVisible(true);         
       setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);    
       
       addKeyListener(this);
       this.setFocusable(true);
       timer = new Timer(tick, this);       
    }
    
    private GameFrame getCurrentFrame(){
        ArrayList<IGameObject> frame = new ArrayList<IGameObject>();
        for (IGameObject gObj : gObjs){
            frame.add(GameObjectsFactory.getCopy(gObj));
        }
        GameFrame f = new GameFrame(frameCounter, frame);
        frameCounter++;
        return f;
    }
    
    private GameFrame getClosingFrame(){
        return new GameFrame(-1, new ArrayList<IGameObject>());
    }


    public void keyTyped(KeyEvent ke) {
    }


    public void keyPressed(KeyEvent ke) {
        lastKey = ke.getKeyCode(); 
        if (lastKey == SPACE_KEY){
            if (timer.isRunning()){
                timer.stop();
                frames.add(this.getClosingFrame());
                String s [] = new String[frames.size()];
                for (int i = 0; i < s.length; i++){
                    s[i] = frames.get(i).toJSONObject().toString();
                }
                try {
                    FileUtilities.writeToFile(s, path + "/g_" + gameCounter);
                    gameCounter++;
                } catch (FileNotFoundException ex) {
                    Logger.getLogger(AGame.class.getName()).log(Level.SEVERE, null, ex);
                }                    
            }
            else{
                timer.start();
                frames.clear();
            }
        }
    }


    public void keyReleased(KeyEvent ke) {
    }

    /**
     * Se invoca en cada tick de reloj
     * @param ae 
     */    

    public void actionPerformed(ActionEvent ae) {
        ridingHood.moveToNextPosition();
        setInLimits();
        if (processCell() == 1){
            screenCounter++;
            ridingHood.incLifes(1);
            loadNewBoard(screenCounter);
        }
        dataLabel.setText(ridingHood.toString());
        frames.add(this.getCurrentFrame());
        canvas.drawObjects(gObjs);
    }
    
    /*
    Procesa la celda en la que se encuentra caperucita.
    Si Caperucita está sobre un blossom añade su valor al de Caperucita
    y lo elimina del tablero.
    Devuelve el número de blossoms que hay en el tablero.
    */
    private int processCell(){
        Position rhPos = ridingHood.getPosition();
        for (IGameObject gObj: gObjs){
            if(gObj != ridingHood && rhPos.isEqual(gObj.getPosition())){
                int v = ridingHood.getValue() + gObj.getValue();
                ridingHood.setValue(v);
                gObjs.remove(gObj);
            }
        }
        return gObjs.size();
    }
    
    /*
    Comprueba que Caperucita no se sale del tablero.
    En caso contrario corrige su posición
    */
    private void setInLimits(){
        
        int lastBox = (CANVAS_WIDTH/boxSize) - 1;
        
        if (ridingHood.getPosition().getX() < 0){
            ridingHood.position.x = 0;
        }
        else if ( ridingHood.getPosition().getX() > lastBox ){
            ridingHood.position.x = lastBox;
        }
        
        if (ridingHood.getPosition().getY() < 0){
            ridingHood.position.y = 0;
        }
        else if (ridingHood.getPosition().getY() > lastBox){
            ridingHood.position.y = lastBox;
        } 
    }
    
    /*
    Carga un nuevo tablero
    */
    private void loadNewBoard(int counter){
        switch(counter){
            case 0: 
              gObjs.add(new Blossom(new Position(2,2), 10, 10));
              gObjs.add(new Blossom(new Position(2,8), 4, 10));
              gObjs.add(new Blossom(new Position(8,8), 10, 10));
              gObjs.add(new Blossom(new Position(8,2), 4, 10));
              break;
            case 1:
              gObjs.add(new Blossom(new Position(1,8), 10, 10));
              gObjs.add(new Blossom(new Position(2,7), 4, 10));
              gObjs.add(new Blossom(new Position(3,6), 10, 10));
              gObjs.add(new Blossom(new Position(4,5), 4, 10));
              gObjs.add(new Blossom(new Position(5,4), 10, 10));
              gObjs.add(new Blossom(new Position(6,3), 4, 10));
              gObjs.add(new Blossom(new Position(7,2), 10, 10));
              gObjs.add(new Blossom(new Position(8,1), 4, 10));
            default:
              gObjs.add(new Blossom(getRandomPosition(10,10), 10, 10));
              gObjs.add(new Blossom(getRandomPosition(10,10), 4, 10));
              gObjs.add(new Blossom(getRandomPosition(10,10), 10, 10));
              gObjs.add(new Blossom(getRandomPosition(10,10), 4, 10));  
        }        
    }
    
    /*
    Devuelve una posición en aleatoria [0..mX, 0..mY]
    */
    public Position getRandomPosition(int mX, int mY){
        int x = (int)(mX * Math.random());
        int y = (int)(mY * Math.random());
        return new Position(x, y);
    }
        
    public static void main(String [] args) throws Exception{
       AGame gui = new AGame();
    }
}
