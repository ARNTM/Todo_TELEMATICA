
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.net.Socket;


//Puesto que la tarea la ejecutara un thread, tiene que implementar Runnable
public class ServerThread implements Runnable {

	private Socket socket;
	public static int id=0;
	public ServerThread(Socket s) {
	 this.socket=s;
	 id++;
	}

	//La interfaz Runnable obliga a implementar este metodo. 
	//Este es el metodo que invocara el thread para ejecutar la
	//tarea. Es equivalente al metodo main, es el punto de entrada
	//de la tarea del thread
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

		} catch (Exception e) {
			
			throw new RuntimeException(e);
		} finally {

			System.out.println("closing...");
			try {
				socket.close();
			} catch (Exception e) {
				
				throw new RuntimeException(e);
			}

		}
	}

}
