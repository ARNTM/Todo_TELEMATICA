import java.io.*;

public class BinaryCount {
	DataOutputStream doutstream = null;
	
	public BinaryCount() throws IOException {
		try {
			doutstream = new DataOutputStream(new FileOutputStream("salida.txt"));
			int n = 1;
			while (n<=100) {
				System.out.println("Binary: " + Integer.toBinaryString(n) + " Integer: " + n);
				doutstream.writeBytes(Integer.toBinaryString(n) + "\n");
				n++;
			}
		}
		finally {
			if (doutstream != null) {
				doutstream.close();
			}
		}
		
	}
}
