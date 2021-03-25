
import java.io.IOException;
import java.net.*;

import java.util.concurrent.*;
import java.util.*;


public class SimpleChatServer {

	/**
	 * @param args
	 */
	//Guaradaremos en un array todos los threads activos
	private ArrayList<ChatServerThread> threads;
	
	public static final int PORT = 8080;
	
	
	//reenviamos el comentario a todos los clientes
	public void newComment(String comment, int index) {
		for (int i=0; i<threads.size(); i++) {
			if (i!=index) {
				threads.get(i).sendComment(comment);
			}
		}
	}
	//Registramos un nuevo thread en nuestra lista 
	//de clientes activos
	public int setChatThread(ChatServerThread chat) {
		threads.add(chat);
		return (threads.size()-1);
	}
	//Eliminamos un cliente
	public void removeChatServerThread(ChatServerThread chat) {
		threads.remove(chat);
	}
	//Constructor
	public SimpleChatServer() {
		threads = new ArrayList<ChatServerThread>();
	}
	public static void main(String[] args) throws IOException {
		// TODO Auto-generated method stub
		ServerSocket s = new ServerSocket(PORT);

		System.out.println("Started: " + s);
		SimpleChatServer server= new SimpleChatServer();
		ExecutorService exec = Executors.newCachedThreadPool();
		try {

			while(true) {
			Socket socket = s.accept();
			ChatServerThread t=new  ChatServerThread(socket, server);
			t.setIndex(server.setChatThread(t));
			exec.execute(t);
			
			}

		} finally {
			exec.shutdown();
			s.close();

		}
	}

}
