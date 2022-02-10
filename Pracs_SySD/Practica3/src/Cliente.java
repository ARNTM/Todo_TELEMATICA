import java.io.*;
import java.net.*;
import java.util.*;

public class Cliente {
	
	
	
	public Cliente() throws IOException{
		Socket s = new Socket("localhost",5525);
		System.out.println("Inicio cliente: " + s);
		String str;
		try {	
				Scanner teclado = new Scanner(System.in);
				PrintWriter out = new PrintWriter(new OutputStreamWriter(s.getOutputStream()));
				BufferedReader in = new BufferedReader(new InputStreamReader(s.getInputStream()));
				String entrada = null;
				while(true) {
				str = teclado.nextLine();
				//teclado.close();
				out.println(str);
				out.flush();
				entrada = in.readLine();
					if(str != null) {
						System.out.println("Echo: " + entrada);
					}
				}
		}
		finally {
			System.out.println("Cerrando cliente: " + s);
			s.close();
			}
	}
}
