import java.io.*;

public class crear_directorio {
	public crear_directorio(String ruta, String nombre) throws IOException{
		File dir = new File(ruta + nombre);
		dir.mkdir();
	}
}
