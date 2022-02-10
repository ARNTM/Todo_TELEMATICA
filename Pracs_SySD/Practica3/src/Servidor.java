import java.io.*;
import java.net.*;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

public class Servidor {
	public Servidor() throws IOException{
		ServerSocket ss = new ServerSocket(5525);
		ExecutorService es = Executors.newFixedThreadPool(5);
		try {
			while(true) {
				Socket s = ss.accept();
				es.execute(new ServerThread(s));
			}
		}
		finally {
			es.shutdown();
			ss.close();
		}
	}
}
