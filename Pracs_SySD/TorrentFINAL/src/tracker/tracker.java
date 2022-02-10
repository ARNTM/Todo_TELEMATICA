package tracker;

import java.net.InetAddress;
import java.net.MalformedURLException;
import java.rmi.Naming;
import java.rmi.RemoteException;
import java.rmi.UnknownHostException;
import java.rmi.server.UnicastRemoteObject;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Iterator;

import peer.peerRegistry;
import peer.funciones.*;

public class tracker extends UnicastRemoteObject implements trackerRegistry{
	
	static final long serialVersionUID = 2;
	
	HashMap<String,String> pAIP = new HashMap<String,String>();
	HashMap<String,String> sAIP = new HashMap<String,String>();
	
	HashMap<String,Integer> estadoPeer = new HashMap<String,Integer>();
	torrent t;
	
	public tracker() throws RemoteException {
		super();
	}
	
	@Override
	public datos registrarSeed(String seedName, torrent t, String IP) throws RemoteException, UnknownHostException, MalformedURLException {
		sAIP.put(seedName, IP);
		this.t=t;
		System.out.println("------------------------------------------------------------");
		System.out.println("Seed registrado, activos: ");
		sAIP.forEach((k,v) -> System.out.println("Nombre: " + k + " | IP: " + v));
		System.out.println("------------------------------------------------------------");
		return new datos(t, pAIP, sAIP);
	}

	@Override
	public datos registrarPeer(String peerName, String IP) throws RemoteException, UnknownHostException, MalformedURLException {
		pAIP.put(peerName, IP);
		System.out.println("------------------------------------------------------------");
		System.out.println("Peer registrado, activos: ");
		pAIP.forEach((k,v) -> System.out.println("Nombre: " + k + " | IP: " + v));
		System.out.println("------------------------------------------------------------");
		return new datos(t, pAIP, sAIP);
	}


	@Override
	public HashMap<String, String> todosSeed() throws RemoteException {
		return sAIP;
	}

	@Override
	public HashMap<String, String> todosPeer() throws RemoteException {
		return pAIP;
	}

	@Override
	public void borrarPeer(String nombre) throws RemoteException {
		pAIP.remove(nombre);
	}

	@Override
	public int numSeed() throws RemoteException {
		return sAIP.size();
	}

	@Override
	public void darAltaSeed(String nombre) throws RemoteException {
		String IP = pAIP.get(nombre);
		pAIP.remove(nombre);
		sAIP.put(nombre, IP);
	}
	

	public static void main (String args[]) throws Exception{
		tracker trackerServer = new tracker();
		String ip = InetAddress.getLocalHost().getHostAddress();
		Naming.rebind("rmi://"+ip+"/trackerRegistry", trackerServer);
		System.out.println("La IP del registro es " + ip);
	}
}
