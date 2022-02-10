import java.io.*;
import java.util.*;

public class listado {
	public listado() throws IOException{
		File dir = new File("C:\\Users\\andre\\Desktop\\SOFTWARE_AKAI");
		String[] myfiles = dir.list();
		if (myfiles == null) {
			System.out.println("Directorio vacio");
		}
		else {
			for (int i=0 ; i<myfiles.length ; i++) {
				System.out.println(myfiles[i]);
			}
		}
	}	
}
