package tracker;

import java.net.MalformedURLException;
import java.rmi.Remote;
import java.rmi.RemoteException;
import java.rmi.UnknownHostException;
import java.util.HashMap;
import peer.funciones.*;

public interface trackerRegistry extends Remote{
	
	
	datos registrarSeed (String seedName, torrent t, String IP) throws RemoteException, UnknownHostException, MalformedURLException;
	datos registrarPeer (String peerName, String IP) throws RemoteException, UnknownHostException, MalformedURLException;

	HashMap<String,String> todosSeed() throws RemoteException;
	HashMap<String,String> todosPeer() throws RemoteException;
	
	void borrarPeer(String nombre) throws RemoteException;
	
	int numSeed() throws RemoteException;
	
	void darAltaSeed(String nombre) throws RemoteException;
	
}
