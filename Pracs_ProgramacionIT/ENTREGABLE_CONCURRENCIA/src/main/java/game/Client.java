/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package game;

import java.awt.GridLayout;
import javax.swing.JFrame;

public class Client extends JFrame {
    
    public static final int CANVAS_WIDTH = 240;
    public static final int BOX_SIZE = 20;
    
    static int fcounter = 0;
    
    int row, col;
    
    ClientPanel client[] = new ClientPanel[4];
    
    public Client() throws Exception{

        super("Cliente v2");
        
        getContentPane().setLayout(new GridLayout(1,4));
        
        for (int i = 0; i < client.length; i++){
            client[i] = new ClientPanel(i, CANVAS_WIDTH, BOX_SIZE);       
            getContentPane().add(client[i]);
        }
        setSize (4*(CANVAS_WIDTH + 20), 2 * (CANVAS_WIDTH + 20));
        setVisible(true);         
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);    
       
        System.out.println(this.getFocusableWindowState());
        this.setFocusable(true);
    }
    
    public static void main(String [] args) throws Exception{
       Client gui = new Client();
    } 
}    
    
    
