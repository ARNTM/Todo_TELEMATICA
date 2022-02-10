import java.net.InetAddress;
import java.rmi.*;
import java.rmi.server.*;

public class HelloRMIServidor extends UnicastRemoteObject implements HelloRMI{
	protected HelloRMIServidor() throws RemoteException {
		super();
		// TODO Auto-generated constructor stub
	}
	@Override
	public String sayHello(String name) throws RemoteException{
		return ("Hola "+ name);
	}
	
	public int sumar(int a, int b) throws RemoteException{
		return (a+b);
	}
	
	public long getTime() throws RemoteException{
		return System.currentTimeMillis();
	}

	public static void main (String args[]) throws Exception{
		HelloRMIServidor pt = new HelloRMIServidor();
		InetAddress ip = InetAddress.getLocalHost();
		Naming.rebind("rmi://"+ip.getHostAddress()+"/HelloRMI", pt);
		System.out.println("La IP del registro es " + ip.getHostAddress());
	}

	public Matriz sumaMatrices(Matriz a, Matriz b) throws RemoteException {
		int cola=a.getCol();
		int rowa=a.getRow();
		Matriz resultado = new Matriz(cola,rowa);
		
		for(int i = 0 ; i<rowa ; i++) {
			for(int j = 0 ; j<cola ; j++) {
				resultado.setValorPos(i, j, a.getValorPos(i, j)+b.getValorPos(i, j));
			}
		}
		
		return resultado;
	}
}
