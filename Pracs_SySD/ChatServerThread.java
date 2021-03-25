
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.net.Socket;
public class ChatServerThread implements Runnable {
	private Socket socket;
	private SimpleChatServer server;
	private int index=0;
	private PrintWriter out;
	
	
	public static int id=0;
	public ChatServerThread(Socket s, SimpleChatServer server) {
	 this.socket=s;
	 id++;
	 this.server=server;
	}
	public void setIndex(int i) {
		this.index=i;
	}
	public void sendComment(String comment) {
		out.println(comment);
	}
	@Override
	public void run() {
		// TODO Auto-generated method stub
		try {

			System.out.println(

					"Connection accepted: "+ socket+" by Thread id="+id);

			BufferedReader in =

				new BufferedReader(

						new InputStreamReader(

								socket.getInputStream()));

			// Output is automatically flushed

			// by PrintWriter:

			 out =

				new PrintWriter(

						new BufferedWriter(

								new OutputStreamWriter(

										socket.getOutputStream())),true);

			while (true) { 

				String str = in.readLine();

				if (str.equals("quit")) break;

				//System.out.println("Echoing: " + str);

				server.newComment(str, index);

			}

		} catch (Exception e) {
			
			throw new RuntimeException(e);
		} finally {

			System.out.println("closing...");
			server.removeChatServerThread(this);
			try {
				socket.close();
			} catch (Exception e) {
				
				throw new RuntimeException(e);
			}

		}
	}

}
