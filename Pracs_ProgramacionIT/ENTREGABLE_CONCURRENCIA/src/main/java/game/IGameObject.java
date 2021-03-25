/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package game;


/**
 * Describes a common interface for all the game elements
 * @author japf
 */
public interface IGameObject {
        
    // Position.
    // public String getId();
    
    // Position.
    public Position getPosition();
    public void setPosition(Position position);  
    
    // Motion: updates object position according to an inner algorithm.
    public Position moveToNextPosition();

    // Value
    public int getValue();
    public void setValue(int value);
    
    // Life
    public int getLifes();
    public void incLifes(int value);
    
    // Mode: allows object to change its behaviour according to
    // game conditions
    public void setGameMode(int mode);
}
