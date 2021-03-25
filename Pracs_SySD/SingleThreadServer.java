
import java.io.*;

import java.net.*;

import java.util.concurrent.*;

public class SingleThreadServer {

	/**
	 * @param args
	 */
	public static final int PORT = 8080;


	public static void main(String[] args) throws IOException {

		ServerSocket s = new ServerSocket(PORT);

		System.out.println("Started: " + s);
		ExecutorService exec = Executors.newSingleThreadExecutor();
		try {

			// Blocks until a connection occurs:
			while(true) {
			Socket socket = s.accept();
			exec.execute(new ServerThread(socket));
			
			}

		} finally {
			exec.shutdown();
			s.close();

		}

	}

}


