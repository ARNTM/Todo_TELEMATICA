/**
 *
 * @author aruznieto
 */

package views.icons;

import game.IGameObject;
import game.Position;
import java.awt.Color;
import java.awt.Graphics;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;

import javax.imageio.ImageIO;
import views.AbstractGameView;


public class VIcon extends AbstractGameView {
	
    private BufferedImage image;
    
    public VIcon(IGameObject mObject, String imgFile, int l) throws Exception {
       super(mObject, l);       
       image = ImageIO.read(new File(imgFile));
    }

    
    public void draw(Graphics g) {       
        Position coord = gObj.getPosition();
	g.drawImage(image, length * coord.getX(), length * coord.getY(), length, length, null);		
    }
}
