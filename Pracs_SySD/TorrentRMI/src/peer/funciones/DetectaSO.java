package peer.funciones;

import java.io.*;

public class DetectaSO {
	
	private static String SO = System.getProperty("os.name").toLowerCase();
	
	public DetectaSO() throws IOException{
		
		if(SO.indexOf("win")>= 0) {
			System.out.println("w");
		}
		else if (SO.indexOf("nix") >= 0 || SO.indexOf("nux") >= 0 || SO.indexOf("aix") > 0) {
			System.out.println("l");
		}
		else if(SO.indexOf("mac") >= 0) {
			System.out.println("m");
		}
		else {
			System.out.println("SO no soportado");
		}
			
	}
}
