package torrent;

import java.io.*;
import java.security.*;
import java.util.*;

public class CreaHashMD5 {
		
	ArrayList<byte[]> hashes = new ArrayList<byte[]>();
	
	public CreaHashMD5(String archivo) throws Exception{
		try {
			InputStream file = new FileInputStream(archivo);
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
		
		} 
		finally {}
	}

	public ArrayList<byte[]> getHashes() {
		return hashes;
	}
}