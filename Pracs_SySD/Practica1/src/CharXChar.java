import java.io.*;

public class CharXChar {
	FileReader inputStream = null;
	FileWriter outputStream = null;
	
	public CharXChar() throws IOException{
		try {
			inputStream = new FileReader("entrada.txt");
			outputStream = new FileWriter("salida.txt");
			int n_chars = 0;
			int c;
			while((c = inputStream.read()) != -1) {
				outputStream.write(c);
				System.out.println((char)c);
				n_chars++;
			}
			System.out.println("\n\nNumero total de caracteres: " + n_chars);
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
