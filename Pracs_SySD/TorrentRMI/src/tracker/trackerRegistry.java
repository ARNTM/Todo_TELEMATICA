package tracker;

import java.rmi.Remote;
import java.rmi.RemoteException;
import java.util.ArrayList;
import java.util.HashMap;
import peer.funciones.*;

public interface trackerRegistry extends Remote{
	void almacenarTorrent(torrent a) throws RemoteException; //Registrar en el TRACKER el torrent
	HashMap<String,String> registrarPeer(String n, String IP, int SoP) throws RemoteException;
	HashMap<String,String> todosPeer() throws RemoteException;
	HashMap<String,String> devolverSeed() throws RemoteException;
	//torrent mostrarTorrent() throws RemoteException; //Muestra todos los TORRENT disponibles
	torrent resumenTorrent() throws RemoteException;
	//List peersArchivo(torrent t) throws RemoteException;
	String borrarPeer(String nombre) throws RemoteException;
	void SeedOPeer(String nombre, int estado) throws RemoteException;
	
}
