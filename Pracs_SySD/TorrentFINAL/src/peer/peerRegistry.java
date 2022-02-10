package peer;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.rmi.Remote;
import java.rmi.RemoteException;
import java.util.BitSet;

import peer.funciones.datos;

public interface peerRegistry  extends Remote{
	BitSet saludarPeer(String peerName, String IP, boolean SoP, BitSet bitSet) throws RemoteException;
	void despedirPeer(String peerName, boolean SoP) throws RemoteException;

	datos descargaChunk(String i, int chunk) throws RemoteException, FileNotFoundException, IOException;
	
	void nuevoChunk(String i, int chunk, boolean SoP) throws RemoteException;
}
