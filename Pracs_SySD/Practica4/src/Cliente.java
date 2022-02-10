import java.io.*;
import java.net.*;
import java.util.*;

public class Cliente {

	
	public Cliente() throws IOException{
		String nombre = "pepe";
		int DNI = 12;
		userMessage um = new userMessage(nombre.length()+4,nombre,DNI);
		byte[] mensaje = um.pack();
		Socket s = new Socket("localhost",5525);
		System.out.println("Inicio cliente: " + s);
		try {	
				DataOutputStream OS = new DataOutputStream(s.getOutputStream());
				OS.write(mensaje);
		}
		finally {
			System.out.println("Cerrando cliente: " + s);
			s.close();
			}
	}
}
