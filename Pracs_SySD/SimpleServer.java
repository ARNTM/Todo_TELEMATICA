
import java.io.*;

import java.net.*;

public class SimpleServer {

	/**
	 * @param args
	 */



	// Choose a port outside of the range 1-1024:

	public static final int PORT = 8080;

	public static void main(String[] args)

	throws IOException {

		ServerSocket s = new ServerSocket(PORT);

		System.out.println("Started: " + s);

		try {

			// Blocks until a connection occurs:

			Socket socket = s.accept();

			try {

				System.out.println(

						"Connection accepted: "+ socket);

				BufferedReader in =

					new BufferedReader(

							new InputStreamReader(

									socket.getInputStream()));

				// Output is automatically flushed

				// by PrintWriter:

				PrintWriter out =

					new PrintWriter(

							new BufferedWriter(

									new OutputStreamWriter(

											socket.getOutputStream())),true);

				while (true) { 

					String str = in.readLine();

					if (str.equals("quit")) break;

					System.out.println("Echoing: " + str);

					out.println(str);

				}

				// Always close the two sockets...

			} finally {

				System.out.println("closing...");

				socket.close();

			}

		} finally {

			s.close();

		}

	}

} ///:~




