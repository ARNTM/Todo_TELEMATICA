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
				BufferedReader in = new BufferedReader(new InputStreamReader(socket.getInputStream()));
					while(true) {
						String str = in.readLine();
						if (str.equals("quit")) break;
						for(Socket s : ids) {	
							if(!s.equals(socket)) {
								//System.out.println(s.toString());
								PrintWriter out = new PrintWriter(new OutputStreamWriter((s.getOutputStream())), true);
								System.out.println("Echo: " + str);
								out.println(str);
							}
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
