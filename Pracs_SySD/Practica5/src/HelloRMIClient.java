import java.net.*;
import java.rmi.*;
import java.util.Scanner;
public class HelloRMIClient {
	public static void main (String args[]) throws RemoteException, MalformedURLException, NotBoundException{
		Scanner teclado = new Scanner(System.in);
		System.out.println("Introduce la IP del servidor: ");
		String IP = teclado.nextLine();
		teclado.close();
		HelloRMI t = (HelloRMI)Naming.lookup("rmi://"+IP+"/HelloRMI");
		//System.out.println("Hola server... = "+ t.sayHello("Pepe"));
		//System.out.println(t.sumar(5, 9));
		//System.out.println(t.getTime());
		Matriz a = new Matriz(5,5);
		Matriz b = new Matriz(5,5);
		Matriz res = t.sumaMatrices(a, b);
		res.ImprimeMat();
	}
	
}
