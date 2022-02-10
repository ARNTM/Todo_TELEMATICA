import java.io.*;
import java.net.*;
import java.util.*;

public class ServerThread implements Runnable{
	private static List<Socket> ids = new ArrayList<Socket>();
	private Socket socket;
	public static int id = 0;
	public ServerThread(Socket s) {
		this.socket = s;
		ids.add(s);
		id++;
	}
	
	@Override
	public void run() {
			try {
				System.out.println("Conexion aceptada server: " + socket + "con ID: " + id);
				ObjectInputStream os = new ObjectInputStream(socket.getInputStream());
					while(true) {
							byte[] buf = null;
							os.readFully(buf);
							Header h = null;
							h.unpack(buf);
							switch(h.TYPE) {
							case 1 : 
								System.out.println("Mensaje de tipo 1");
								userMessage um = (userMessage)h;
								System.out.println("NOMBRE: " + um.NAME);
								System.out.println("DNI: " + um.DNI);
								break;
							case 2 :
								System.out.println("Mensaje de tipo 2");
								break;
							default : 
								System.out.println("No se que tipo de mensaje es");
							
							}
						}	
					
				}

			
			catch(Exception e) {throw new RuntimeException(e);}
			finally {
				System.out.println("Cerrando...");
				try {
				
				}
				catch(Exception e) {throw new RuntimeException(e);}
			}
	}
}
