package peer;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.rmi.Remote;
import java.rmi.RemoteException;
import java.util.ArrayList;

public interface peerRegistry  extends Remote{
	void saludarPeer(String peerName, String IP, int SoP) throws RemoteException;
	void despedirPeer(String peerName) throws RemoteException;
	ArrayList<Integer> bloquesDisponibles() throws RemoteException;
	byte[] getB(String ID, int i) throws RemoteException, FileNotFoundException, IOException;
}
