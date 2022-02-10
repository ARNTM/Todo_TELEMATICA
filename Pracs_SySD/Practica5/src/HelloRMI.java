import java.rmi.*;

public interface HelloRMI extends Remote{
	String sayHello(String name) throws RemoteException;
	int sumar(int a, int b) throws RemoteException;
	long getTime() throws RemoteException;
	Matriz sumaMatrices (Matriz a, Matriz b)  throws RemoteException;
}
