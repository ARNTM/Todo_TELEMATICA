package torrent;

import java.io.*;
import java.util.*;

public class CompartirArchivo {
	public CompartirArchivo() throws Exception {
		try {
		String ruta;
		Scanner teclado = new Scanner(System.in);
		System.out.println("Introduce la ruta del fichero que quieres compartir: ");
		ruta = teclado.nextLine();
		teclado.close();
		CreaHashMD5 archivo = new CreaHashMD5(ruta);
		for (int i = 1 ; i <= archivo.getHashes().size() ; i++) {
			System.out.println("Bloque " + i + ": " + archivo.getHashes().get(i-1));
		}
		
	}
		catch (java.io.FileNotFoundException fnfe) {System.out.println("Archivo no encontrado o ruta no especificada. Vuelve a arrancar el programa");}
		}
}

