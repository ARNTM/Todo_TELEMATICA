/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package game;

import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.Dimension;
import java.awt.GridLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.File;
import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.BorderFactory;
import javax.swing.JComboBox;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTextArea;

/**
 *
 * @author juanangel
 */
public class ClientPanel extends JPanel implements ActionListener {
        
    // Identificador del panel y etiqueta de identificación.
     int id = 0;
     JLabel lbId;    
    
    // Superficie de dibujo.    
    ClientCanvas canvas = new ClientCanvas(320, 16);
   
    // Mensajes y trazas.    
    JTextArea txMessages;

        // Selección de ficheros a cargar.
    JComboBox cbFilesToUpload;
    JLabel lbFilesToUpload;
    
    // Selección de juego a eproducir.
    JComboBox cbReadyToPlay;
    JLabel lbReadyToPlay;
   
    // Paneles auxiliares.
    JPanel pnControls;
    JPanel pnBoard;
    
    // Tabla de juegos cargados en memoria.    
    HashMap<String, ArrayList<GameFrame>> downloadedGamesTable = new HashMap<String, ArrayList<GameFrame>>();
    
    // Directorio de trabajo asumido en la práctica.
    public static final String WORKING_PATH = "src/main/resources/games";
    File file;


    public ClientPanel(int id, int width, int squareEdge){
        
        this.id = id;
        lbId = new JLabel("Cliente " + id);
        
        file = new File(WORKING_PATH);
        String filesList [] = file.list();
        cbFilesToUpload = new JComboBox(filesList);
        cbReadyToPlay = new JComboBox();
        lbFilesToUpload = new JLabel("Load File");
        lbReadyToPlay = new JLabel("See Game");
        
        canvas = new ClientCanvas(width, squareEdge);
        canvas.setBorder(BorderFactory.createLineBorder(Color.darkGray));

        setLayout(new BorderLayout());

        pnControls = new JPanel();
        txMessages = new JTextArea(10,5);
        JScrollPane scMessages = new JScrollPane(txMessages);
        scMessages.setPreferredSize(new Dimension(width,2*width/3));
        
        pnControls.setLayout(new GridLayout(2,2));
        pnControls.add(lbFilesToUpload); 
        pnControls.add(cbFilesToUpload); 
        pnControls.add(lbReadyToPlay);
        pnControls.add(cbReadyToPlay);    
        pnBoard = new JPanel();
        pnBoard.setLayout(new BorderLayout());
        pnBoard.add(pnControls, BorderLayout.NORTH); 
        pnBoard.add(scMessages);
        
        JScrollPane scCanvas = new JScrollPane(canvas);
        scCanvas.setPreferredSize(new Dimension(width + 8, width + 8));
        add(scCanvas);
        add(pnBoard, BorderLayout.SOUTH);
        add(lbId, BorderLayout.NORTH);
        
        setBorder(BorderFactory.createEtchedBorder());
        
        cbFilesToUpload.addActionListener(this); 
        cbReadyToPlay.addActionListener(this);           
    }
    
   
    public void actionPerformed(ActionEvent ae){
        if (ae.getSource() == cbFilesToUpload){
            String sFile = (String) cbFilesToUpload.getSelectedItem();
            try {
                if (!downloadedGamesTable.containsKey(sFile)){   
                    System.out.println("Loading " + sFile + "  ");                       
                    txMessages.append("Loading ... " +  sFile + "\n");
                    
                    // Cargamos los datos del fichero.
                    ArrayList<GameFrame> gFrames = new GameLoader(sFile).loadFramesFromFile();                        
                    
                    // Los guardamos en la tabla de juegos
                    downloadedGamesTable.put(sFile, gFrames); 
                    
                    // Creamos una nueva entrada en cbReadyToPlay
                    cbReadyToPlay.insertItemAt(sFile, 0);
                            
                    System.out.println(sFile + " has been loaded");   
                    txMessages.append(sFile + " has been loaded\n");
                }
                else{
                    System.out.println(sFile + " is already loaded");   
                    txMessages.append(sFile + " is already loaded\n");
                }
            } catch (FileNotFoundException ex) {
                Logger.getLogger(ClientPanel.class.getName()).log(Level.SEVERE, null, ex);
            }            
        }
        else if (ae.getSource() == cbReadyToPlay){
            String sFile = (String) cbFilesToUpload.getSelectedItem();
            System.out.println("Reproducing game ---> " + sFile);
            txMessages.append("Reproducing game ---> " + sFile + "\n");

            // Obyención del juego seleccionado.
            ArrayList<GameFrame> movie = downloadedGamesTable.get(sFile);  
            
            // Envío al canvas para su reproducción.
            canvas.playMovie(movie);

            System.out.println(sFile + " is being reproduced");
            txMessages.append(sFile + " is being reproduced\n");                    
        }
        requestFocusInWindow();                   
    }
}