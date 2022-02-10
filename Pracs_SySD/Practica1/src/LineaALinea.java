import java.io.*;

public class LineaALinea {
	BufferedReader inputStream = null;
	PrintWriter outputStream = null;
	
	public LineaALinea() throws IOException{
		try {
			inputStream = new BufferedReader(new FileReader("entrada.txt"));
			outputStream = new PrintWriter(new FileWriter("salida.txt"));
			
			String l;
			int n_lines = 0;
			while ((l = inputStream.readLine()) != null) {
				outputStream.println(l);
				System.out.println("\n" + l);
				n_lines++;
			}
			System.out.println("\n\nNumero total de lineas: " + n_lines);
		}
		
		finally {
			if(inputStream != null) {
				inputStream.close();
			}
			if(outputStream != null) {
				outputStream.close();
			}
		}
	}
}
