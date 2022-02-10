package tracker;

import java.net.InetAddress;
import java.rmi.Naming;
import java.rmi.RemoteException;
import java.rmi.server.UnicastRemoteObject;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Iterator;

import peer.funciones.*;

public class tracker extends UnicastRemoteObject implements trackerRegistry{
	
	static final long serialVersionUID = 2;
	
	HashMap<String,String> peerNames = new HashMap<String,String>();
	HashMap<String,String> seedNames = new HashMap<String,String>();
	HashMap<String,Integer> estadoPeer = new HashMap<String,Integer>();
	torrent t;
	
	public tracker() throws RemoteException {
		super();
	}
	

	@Override
	public void almacenarTorrent(torrent t) throws RemoteException {
		this.t=t;
		System.out.println("------------------------------------------------------------");
		System.out.println("Torrent recibido: ");
		System.out.println(Arrays.deepToString(t.hashes.toArray()));
		System.out.println("------------------------------------------------------------");

	}
	
	@Override
	public torrent resumenTorrent() throws RemoteException {
		return t;
	}
	
	@Override
	public HashMap<String,String> registrarPeer(String n, String IP, int SoP) throws RemoteException {
		if (SoP == 1) {peerNames.put(n, IP);}
		else seedNames.put(n, IP);
		
		System.out.println("------------------------------------------------------------");
		System.out.println("Peer registrado, activos: ");
		peerNames.forEach((k,v) -> System.out.println("Nombre: " + k + " | IP: " + v));
		System.out.println("------------------------------------------------------------");
		return peerNames;
	}
	
	public HashMap<String,String> devolverSeed() throws RemoteException {
		return seedNames;
	}
	
	@Override
	public String borrarPeer(String nombre) throws RemoteException {
		peerNames.remove(nombre);
		System.out.println("Peer borrado, activos: ");
		peerNames.forEach((k,v) -> System.out.println("Nombre: " + k + " | IP: " + v));
		System.out.println("------------------------------------------------------------");
		return "Te acabas de borrar del tracker.";
	}
	
	@Override
	public void SeedOPeer(String nombre, int estado) throws RemoteException {
		estadoPeer.put(nombre, estado);
	}
	
	@Override
	public HashMap<String,String> todosPeer() throws RemoteException {
		return peerNames;
	}


	
	
	public static void main (String args[]) throws Exception{
		tracker trackerServer = new tracker();
		String ip = InetAddress.getLocalHost().getHostAddress();
		Naming.rebind("rmi://"+ip+"/trackerRegistry", trackerServer);
		System.out.println("La IP del registro es " + ip);
	}

}
