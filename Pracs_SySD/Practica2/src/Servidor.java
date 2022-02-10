import java.io.*;
import java.net.*;

public class Servidor {
	public Servidor() throws IOException{
		ServerSocket ss = new ServerSocket(5525);
		System.out.println("Inicio server: " + ss);
		try {
			Socket s = ss.accept();
			try {
				System.out.println("Conexion aceptada server: " + s);
				BufferedReader in = new BufferedReader(new InputStreamReader(s.getInputStream()));
				PrintWriter out = new PrintWriter(new OutputStreamWriter(s.getOutputStream()));
				String str = null;
				while(true) {
					str = in.readLine();
					if(str != null) {
						if(!str.contains("exit")) {
							out.println(str);
							out.flush();
						}
						else {break;}
					}
				}
				s.close();
			} finally {
				System.out.println("Socket cerrado server");
				s.close();
				}
		} finally {
			System.out.println("ServerSocket cerrado server"); 
			ss.close();
			}
	}
}
