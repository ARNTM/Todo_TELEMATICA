import java.io.*;

public class Caracter {
	PrintWriter pwriter = null;
	
	public Caracter() throws IOException{
		try {
			pwriter = new PrintWriter(new File("salida.txt"));
			int n = 1;
				while (n<=100) {
					System.out.println("Caracter: " + n);
					pwriter.println(n);
					n++;
				} 
			}
		finally {
			if(pwriter != null) {
				pwriter.close();
			}	
		}	
	}
}
