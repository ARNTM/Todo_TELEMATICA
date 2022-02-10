package peer.funciones;

import java.io.*;
import java.security.*;
import java.util.*;

public class torrent implements Serializable{
	
	static final long serialVersionUID = 1;
		
	public ArrayList<byte[]> hashes = new ArrayList<byte[]>();
	public long tamanioArchivo = 0;
	String nombreOriginal;
	
	public torrent(String ruta) throws Exception{
		try {
			InputStream file = new FileInputStream(ruta);
			File archivo = new File (ruta);
			
			tamanioArchivo = archivo.length();
			nombreOriginal = archivo.getName();
			byte[] buffer = new byte[1024*512];
			MessageDigest hash = MessageDigest.getInstance("MD5");
			int numeroLectura;
			
			do {
				numeroLectura = file.read(buffer);
				if (numeroLectura > 0) {
					hash.update(buffer,0,numeroLectura);
					hashes.add(hash.digest());
				}
			} while (numeroLectura != -1);
			
			file.close();
			//teclado.close();
		} 
		catch (java.io.FileNotFoundException fnfe) {System.out.println("Archivo no encontrado o ruta no especificada. Vuelve a arrancar el programa");}
		finally {}
	}

	public ArrayList<byte[]> getHashes() {
		return hashes;
	}
	
	public long getTArchivo() {
		return tamanioArchivo;
	}
	
	public String getNombreOriginal() {
		return nombreOriginal;
	}
	
}