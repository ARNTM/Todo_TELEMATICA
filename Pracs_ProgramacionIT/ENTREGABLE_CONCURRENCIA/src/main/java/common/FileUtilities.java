/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package common;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author juanangel
 */
public class FileUtilities {
    

    
    public static void writeToFile(String s[], String fichero) throws FileNotFoundException {

        if (s == null || fichero == null){
            return;
        }

        PrintWriter streamWriter;

        try {
            streamWriter = new PrintWriter(new FileOutputStream (fichero));
            for (String jObj: s){                
                streamWriter.println(jObj);
            }
            streamWriter.close();
        } catch (FileNotFoundException e) {
            System.out.println("escribirEnFichero: FileNotFoundException");
            throw e;
        }
    }
    
    public static ArrayList<String> readFile(String fileName) throws FileNotFoundException {
        
        ArrayList<String> frames = new ArrayList<String>();
        
        String line;
        BufferedReader fileReader;
        
        try{
            System.out.print("FileUtilities.readFile ");
            fileReader = new BufferedReader(new FileReader(fileName));
            while((line = fileReader.readLine()) != null){
                frames.add(line);
                Thread.sleep(100);
                System.out.print(".");
            }
            System.out.println();
            fileReader.close();            
        } catch(IOException ioe){
            ioe.printStackTrace();
            frames = null;
        } catch (InterruptedException ex) {     
            Logger.getLogger(FileUtilities.class.getName()).log(Level.SEVERE, null, ex);
        }
        System.out.print("FileUtilities.readFile. END ");
        return frames;
    }
    
    public static void main(String [] args){
        
        String dirGames = "src/main/resources/games";
        
        ArrayList<String> s = null;
        try {
            s = FileUtilities.readFile(dirGames + "/tframes");
        } catch (FileNotFoundException ex) {
            Logger.getLogger(FileUtilities.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        for (String line : s){
            System.out.println(line);
        } 
    }
}
