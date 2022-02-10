import java.io.*;
import java.net.*;
import java.util.*;

public class Cliente {

	
	public Cliente() throws IOException{
		userMessage um = new userMessage(1,"pepe",12);
		Socket s = new Socket("localhost",5525);
		System.out.println("Inicio cliente: " + s);
		try {	
				ObjectOutputStream OS = new ObjectOutputStream(s.getOutputStream());
				OS.writeObject(um.pack());
		}
		finally {
			System.out.println("Cerrando cliente: " + s);
			s.close();
			}
	}
}
