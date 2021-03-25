
import java.io.*;

public class BufferedOutputFile {

	/**
	 * @param args
	 */
	static String file = "BasicFileOutput.out";
	public static void main(String[] args) throws IOException {
		// TODO Auto-generated method stub
		System.out.println(new File(".").getCanonicalPath());
		BufferedReader in = new BufferedReader(
				new StringReader(
				BufferedInputFile.read("text.txt")));
				PrintWriter out = new PrintWriter(
				new BufferedWriter(
						new FileWriter(file)));
				int lineCount = 1;
				String s;
				while((s = in.readLine()) != null )
				out.println(lineCount++ + ": " + s);
				out.close();
				// Show the stored file:
				System.out.println(BufferedInputFile.read(file));
				
	}

}
