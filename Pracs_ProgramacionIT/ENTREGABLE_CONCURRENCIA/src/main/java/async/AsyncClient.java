/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package async;

import java.awt.GridLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.File;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.swing.JFileChooser;
import javax.swing.JFrame;
import javax.swing.JMenu;
import javax.swing.JMenuBar;
import javax.swing.JMenuItem;

import org.json.JSONObject;

import common.FileUtilities;
import common.IToJsonObject;
import game.IGameObject;

public class AsyncClient extends JFrame {
    
    public static final int CANVAS_WIDTH = 240;
    public static final int BOX_SIZE = 20;
    
    static int fcounter = 0;    
    int row, col;
    
    AsyncClientPanel client[] = new AsyncClientPanel[4];
    
    ExecutorService fileLoader = Executors.newSingleThreadExecutor();
    
    JMenuBar barraMenu;
    JMenu mSeleccionEjecutor;
    JMenu mFixedPool;
    JMenuItem itThreeThreads, itFiveThreads;
    JMenuItem itFlexiblePool, itSingleThreaded;
    
    
    public AsyncClient() throws Exception{

        super("Cliente | Andres Ruz Nieto");
                
        getContentPane().setLayout(new GridLayout(1,4));
        
        mSeleccionEjecutor = new JMenu("Load File Executor");
        barraMenu = new JMenuBar();
        mFixedPool = new JMenu("Fixed Pool");
        itThreeThreads = new JMenuItem("Three Threads");
        itFiveThreads = new JMenuItem("Five Threads");
        itSingleThreaded = new  JMenuItem("Single Thread");
        itFlexiblePool  = new  JMenuItem("Resizable Pool");
        
        barraMenu.add(mSeleccionEjecutor);
        mSeleccionEjecutor.add(itSingleThreaded);
        mSeleccionEjecutor.add(mFixedPool);
        mSeleccionEjecutor.add(itFlexiblePool);
        mFixedPool.add(itThreeThreads);
        mFixedPool.add(itFiveThreads);
        
        setJMenuBar(barraMenu);

        itThreeThreads.addActionListener(
				new ActionListener(){       
					public void actionPerformed(ActionEvent ae){
						fileLoader = Executors.newFixedThreadPool(3);
						for(AsyncClientPanel acp : client) {
							try {
								acp.setLoader(fileLoader);
							} catch (InterruptedException ex) {
								Logger.getLogger(AsyncClient.class.getName()).log(Level.SEVERE, null, ex);
							}
						}
	                }
				}
			);
        itFiveThreads.addActionListener(
				new ActionListener(){       
					public void actionPerformed(ActionEvent ae){
						fileLoader = Executors.newFixedThreadPool(5);
						for(AsyncClientPanel acp : client) {
							try {
								acp.setLoader(fileLoader);
							} catch (InterruptedException ex) {
								Logger.getLogger(AsyncClient.class.getName()).log(Level.SEVERE, null, ex);
							}
						}
	                }
				}
			);
        
        itSingleThreaded.addActionListener(
				new ActionListener(){       
					public void actionPerformed(ActionEvent ae){
						fileLoader = Executors.newSingleThreadExecutor();
						for(AsyncClientPanel acp : client) {
							try {
								acp.setLoader(fileLoader);
							} catch (InterruptedException ex) {
								Logger.getLogger(AsyncClient.class.getName()).log(Level.SEVERE, null, ex);
							}
						}
	                }
				}
			);
        
        itFlexiblePool.addActionListener(
				new ActionListener(){       
					public void actionPerformed(ActionEvent ae){
						fileLoader = Executors.newCachedThreadPool();
						for(AsyncClientPanel acp : client) {
							try {
								acp.setLoader(fileLoader);
							} catch (InterruptedException ex) {
								Logger.getLogger(AsyncClient.class.getName()).log(Level.SEVERE, null, ex);
							}
						}
	                }
				}
			);
        
        for (int i = 0; i < client.length; i++){
            client[i] = new AsyncClientPanel(i, CANVAS_WIDTH, BOX_SIZE);       
            getContentPane().add(client[i]);
        }
        setSize (4*(CANVAS_WIDTH + 20), 2 * (CANVAS_WIDTH + 40));
        setVisible(true);         
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);    
       
        System.out.println(this.getFocusableWindowState());
        this.setFocusable(true);
        
        // Set default loader for panels.
        for (AsyncClientPanel panel : client){
            try {
                panel.setLoader(fileLoader);
            } catch (InterruptedException ex) {
                Logger.getLogger(AsyncClient.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        
    }
    

    
    public static void main(String [] args) throws Exception{
       AsyncClient gui = new AsyncClient();
    } 
}    
    
    
