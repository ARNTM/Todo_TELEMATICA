package peer;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.RandomAccessFile;
import java.net.InetAddress;
import java.net.MalformedURLException;
import java.net.UnknownHostException;
import java.nio.channels.FileChannel;
import java.nio.file.Files;
import java.nio.file.Path;
import java.rmi.Naming;
import java.rmi.NotBoundException;
import java.rmi.RemoteException;
import java.rmi.server.UnicastRemoteObject;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.BitSet;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Scanner;
import java.util.UUID;
import java.util.concurrent.ConcurrentHashMap;

import peer.funciones.datos;
import peer.funciones.torrent;
import tracker.trackerRegistry;

public class peer  extends UnicastRemoteObject implements peerRegistry{
	
	String peerName = UUID.randomUUID().toString();
	
	HashMap<String,String> pAIP = new HashMap<String,String>(); // Asocia peerNames con IP
	HashMap<String,String> sAIP = new HashMap<String,String>();
	ArrayList<Integer> bloquesEnPeer = new ArrayList<Integer>();
	torrent t;
	datos data;
	boolean reg = false;
	boolean SoP = false; // Seed o Peer?? Si está en false será un peer
	
	int neighbors = 4;
	
	List<String> neighborsAv = new ArrayList<String>();
	
	Map<String, BitSet> bloquesDisponibles = new ConcurrentHashMap<String, BitSet>();

	int bloques = 1;
	File atemp;

	protected peer() throws RemoteException {
		super();
	}
	
	@Override
	public BitSet saludarPeer(String peerName, String IP, boolean SoP, BitSet bitSet) throws RemoteException {
		if(SoP) sAIP.put(peerName, IP);
		else pAIP.put(peerName, IP);
		this.addB(peerName, bitSet);
		sP();
		return bloquesDisponibles.get(this.peerName);
	}

	@Override
	public void despedirPeer(String peerName, boolean SoP) throws RemoteException {
		if(SoP) sAIP.remove(peerName);
		else pAIP.remove(peerName);
		bloquesDisponibles.remove(peerName);
		if(neighborsAv.contains(peerName)) {neighborsAv.remove(peerName); sP();}
	}

	@Override
	public datos descargaChunk(String i, int chunk) throws RemoteException, FileNotFoundException, IOException {
		if(neighborsAv.contains(peerName)) {
			byte[] b;
			RandomAccessFile raf = new RandomAccessFile(atemp, "rw");
			int tam = 512*1024;
			raf.seek(chunk*tam);
			if(chunk == t.hashes.size()-1) {
				int blb = (int) (t.getTArchivo() - ((t.hashes.size()-1) * 512 * 1024)); //Bits Last Block
				b = new byte[blb];
				raf.read(b,0,blb);
			}
			else {
				b = new byte[512];
				raf.read(b, 0, 512);
			}
			raf.close();
			return new datos(true, b);
		}
		else {return new datos(false);}
		
	}

	@Override
	public void nuevoChunk(String nombre, int chunk, boolean SoP) throws RemoteException {
		bloquesDisponibles.get(nombre).set(chunk);
		if(SoP) {darAltaSeed(nombre);}
		sP();
	}
	
	public void darAltaSeed(String nombre) throws RemoteException {
		String IP = pAIP.get(nombre);
		pAIP.remove(nombre);
		sAIP.put(nombre, IP);
	}
	
	public void addB(String peerName, BitSet bitSet) {
		bloquesDisponibles.put(peerName, bitSet);
	}
	
	public void sP() {
		List<String> c = new ArrayList<String>();
		c.addAll(bloquesDisponibles.keySet());
		c.remove(peerName);
		/*for(String S : sAIP.keySet()) {
			c.remove(S);
		}*/

		if(c.size() <= neighbors) {
			neighborsAv = c;
		}
		
		else {
			String minimo = null;
			int bloquesMinimos = 0;
			int cont = 0;
			if(!c.isEmpty()) {
				for (int i = 0 ; i< neighbors ; i++) {
					c.remove(minimo);
					minimo = c.get(0);
					bloquesMinimos = bloquesEnPeer(minimo);
					for(String sC: c) {
						if((cont = bloquesEnPeer(sC)) < bloquesMinimos) {
							bloquesMinimos = cont;
							minimo = sC;
						}
					neighborsAv.add(minimo);	
					}
				}
			}
		
		}
	}
	
	public int sB() {
		int b = 0;
		int nB = t.hashes.size();
		int bH = bloquesEnPeer(peerName);
		List<Integer> c = new ArrayList<Integer>();
		
		for(int i = 0 ; i < nB ; i++) {
			if(!bloquesDisponibles.get(peerName).get(i)) {
				c.add(i);
			}
		}
		
		if (bH < nB) {
			int aleatorio = (int) (Math.random() * c.size());
			b = c.get(aleatorio);
		}
		else {
			b = c.get(0);
			int m = peersConUnBloque(b);
			int cont = 0;
			for (int bl : c) {
				if((cont = peersConUnBloque(bl)) < m) {
					b = bl;
					m = cont;
				}
			}
		}
		return b;
		
	}
	
	public int bloquesEnPeer(String name) {
		int c=0;
		for(int i = 0 ; i < bloquesDisponibles.get(name).size(); i++) {
			if(bloquesDisponibles.get(name).get(i)) {
				c++;
			}
		}
		return c;
	}
	
	public int peersConUnBloque(int i) {
		int c = 0;
		for(String nombre : bloquesDisponibles.keySet()) {
			if(bloquesDisponibles.get(nombre).get(i)) {
				c++;
			}
		}
		return c;
	}
	
	public byte[] getChunk(int chunk) throws NotBoundException, FileNotFoundException, IOException, NoSuchAlgorithmException {
		boolean r = false;
		Map<String, BitSet> bD = bloquesDisponibles;
		datos data = null;
		for (String b : bD.keySet()) {
			if(bD.get(b).get(chunk) && !peerName.contentEquals(b)) {
				peerRegistry otroPeer = (peerRegistry) Naming.lookup("rmi://"+pAIP.get(b)+"/" + b);
				data = otroPeer.descargaChunk(peerName, chunk);
				if(data.getC()) {
					r = true;
					break;
				}
				else {
				}
			}
		}
		if (!r) {
			System.out.println("No existen peer activos en tu lista de vecinos.");
			return null;
		}
		else {
			byte[] b;
			b = data.getBloque();
			return b;
		}
			
	}
	
	public boolean esBien(byte[] br, int chunk) throws NoSuchAlgorithmException {
		byte[] hashRecibido;
		byte[] hashOriginal;
		MessageDigest messageDigest = MessageDigest.getInstance("MD5"); 
		messageDigest.update(br);
		hashRecibido = messageDigest.digest();
		hashOriginal = t.hashes.get(chunk);
		
		return MessageDigest.isEqual(hashRecibido, hashOriginal);
		
	}
	
	public void guardaChunk(byte [] b, int chunk) throws IOException {
		RandomAccessFile raf = new RandomAccessFile(atemp, "rw");
		int tamanioChunk = 512*1024;
		raf.seek(chunk*(tamanioChunk));
		raf.write(b);
		raf.close();
	}
	
	public void nuevoChunk(int chunk) {
		bloquesDisponibles.get(peerName).set(chunk);
	}
	
	public void aNB(int chunk) throws MalformedURLException, RemoteException, NotBoundException {
		for(String p : pAIP.keySet()) {
			if(!(p.equals(peerName))){
				peerRegistry otroPeer = (peerRegistry) Naming.lookup("rmi://"+pAIP.get(peerName)+"/" + p);
				otroPeer.nuevoChunk(peerName, chunk, SoP);
			}
		}
		for(String p : sAIP.keySet()) {
			if(!(p.equals(peerName))){
				peerRegistry otroPeer = (peerRegistry) Naming.lookup("rmi://"+pAIP.get(peerName)+"/" + p);
				otroPeer.nuevoChunk(peerName, chunk, SoP);
			}
		}
	}
	
	public boolean completado() {
		boolean resp = true;
		for(int i = 0 ; i < t.hashes.size() ; i++) {
			if(!bloquesDisponibles.get(peerName).get(i)) {
				resp = false;
			}
		}
		return resp;
	}
	
	public void cambiarASeed(String nombre) throws RemoteException {
		String IP = pAIP.get(nombre);
		pAIP.remove(nombre);
		sAIP.put(nombre, IP);
	}
	
	//CODIGO INICIO PEER
	
	private void iniciar() throws Exception {
		String funcion;
		System.out.println("Pulsa: \n 1 para COMPARTIR el archivo \n 2 para DESCARGAR el archivo");
		Scanner teclado = new Scanner (System.in); 
		funcion=teclado.nextLine();
		
		while(!(funcion.equals("1")) && !(funcion.equals("2"))) {
			System.out.println("Error al introducir una funcion. Compruebe lo que ha escrito");
			funcion=teclado.nextLine();
		}
		
		if(funcion.equals("1")) {
			System.out.println("PEER en modo COMPARTIR ARCHIVO");
			System.out.println("Introduce la IP del REGISTRO: ");
			Scanner introIP = new Scanner (System.in); 
			String IP = introIP.nextLine();
			trackerRegistry tracker = (trackerRegistry)Naming.lookup("rmi://"+IP+"/trackerRegistry");
			if(tracker.todosSeed().isEmpty()) {System.out.println("Comparta su archivo pulsando 1");}
			while(true) {
				System.out.println("------------------------------------------------------------");
				System.out.println("Funcion a realizar\n Pulsa:\n 1 para ENVIAR TORRENT\n 2 para mostrar todos los PEERS activos\n 3 para cerrar PEER");
				System.out.println("------------------------------------------------------------");
				Scanner funcionCompartir = new Scanner (System.in); 
				String fc = funcionCompartir.nextLine();
				switch(fc) {
				case "1":
					String ruta;
					Scanner rutat = new Scanner(System.in);
					System.out.println("Introduce la ruta del fichero que quieres compartir: ");
					ruta = rutat.nextLine();
					atemp= new File(ruta);
					t = new torrent(ruta);
					if(!(t.hashes.isEmpty())){
						data = tracker.registrarSeed(peerName, t, IP);
						
						System.out.println("Torrent registrado correctamente. Los HASHES generados son: ");
						System.out.println(Arrays.deepToString(t.hashes.toArray()));
					}
					pAIP=data.getpAIP();
					sAIP=data.getsAIP();
					BitSet numeroDeBloques = new BitSet((int)t.hashes.size());
					numeroDeBloques.set(0, (int)t.hashes.size(), true);
					if(!pAIP.isEmpty()) {
						for(String p : pAIP.keySet()) {
							if(!(p.equals(peerName))){
								peerRegistry otroPeer = (peerRegistry) Naming.lookup("rmi://"+pAIP.get(p)+"/" + p);
								otroPeer.saludarPeer(peerName,InetAddress.getLocalHost().getHostAddress(),false,numeroDeBloques);
							}
						}
					}
					if(!sAIP.isEmpty()) {
						for(String p : sAIP.keySet()) {
							if(!(p.equals(peerName))){
								peerRegistry otroPeer = (peerRegistry) Naming.lookup("rmi://"+sAIP.get(p)+"/" + p);
								otroPeer.saludarPeer(peerName,InetAddress.getLocalHost().getHostAddress(),false,numeroDeBloques);
							}
						}
					}
					this.addB(peerName, numeroDeBloques);
					reg=true;
					SoP=true;
					sP();
					System.out.println("------------------------------------------------------------");
					break;
					
				case "2":
					System.out.println("Lista de todos los PEER: ");
					pAIP.forEach((k,v) -> System.out.println("Nombre: " + k + " | IP: " + v));
					System.out.println("Lista de todos los SEED: ");
					sAIP.forEach((k,v) -> System.out.println("Nombre: " + k + " | IP: " + v));
					System.out.println("------------------------------------------------------------");
					break;
					
				case "3":
					System.out.println("Cerrando SEED: ");
					for(String p : pAIP.keySet()) {
						if(!(p.equals(peerName))){
							peerRegistry otroPeer = (peerRegistry) Naming.lookup("rmi://"+pAIP.get(peerName)+"/" + p);
							otroPeer.despedirPeer(peerName, true);
						}
					}
					for(String p : sAIP.keySet()) {
						if(!(p.equals(peerName))){
							peerRegistry otroPeer = (peerRegistry) Naming.lookup("rmi://"+sAIP.get(peerName)+"/" + p);
							otroPeer.despedirPeer(peerName, true);
						}
					}
					tracker.borrarPeer(peerName);
					System.out.println("------------------------------------------------------------");
					System.exit(0);
					break;
				}
			}
		}
		
		else if(funcion.equals("2")) {
			System.out.println("PEER en modo DESCARGAR ARCHIVO");
			System.out.println("Introduce la IP del REGISTRO: ");
			String IP = teclado.nextLine();
			trackerRegistry tracker = (trackerRegistry)Naming.lookup("rmi://"+IP+"/trackerRegistry");
			peer peer = new peer();
			Naming.rebind("rmi://"+ InetAddress.getLocalHost().getHostAddress() + "/" + peerName,peer);
			System.out.println("Creada conexion RMI del PEER: " + peerName);
			data = tracker.registrarPeer(peerName,InetAddress.getLocalHost().getHostAddress());
			pAIP=data.getpAIP();
			sAIP=data.getsAIP();
			reg=true;
			SoP=false;
			sP();
			while(true) {
				System.out.println("------------------------------------------------------------");
				System.out.println("Funcion a realizar\n Pulsa:\n 1 para OBTENER TORRENT\n 2 para mostrar todos los PEERS activos\n 3 para cerrar PEER");
				System.out.println("------------------------------------------------------------");
				Scanner funcionDescargar = new Scanner (System.in); 
				String fc = funcionDescargar.nextLine();
				switch(fc) {
				case "1":
					t = data.gettorrent();
					int tamanio = (int) t.hashes.size();
					System.out.println(tamanio);
					BitSet numeroDeBloques = new BitSet(tamanio);
					numeroDeBloques.set(0, (int) t.hashes.size(), false);
					this.addB(peerName, numeroDeBloques);
					if(!pAIP.isEmpty()) {
						for(String p : pAIP.keySet()) {
							if(!(p.equals(peerName))){
								peerRegistry otroPeer = (peerRegistry) Naming.lookup("rmi://"+pAIP.get(p)+"/" + p);
								otroPeer.saludarPeer(peerName,InetAddress.getLocalHost().getHostAddress(),false,numeroDeBloques);
							}
						}
					}
					
					if(!sAIP.isEmpty()) {
						for(String p : sAIP.keySet()) {
							if(!(p.equals(peerName))){
								peerRegistry otroPeer = (peerRegistry) Naming.lookup("rmi://"+sAIP.get(p)+"/" + p);
								otroPeer.saludarPeer(peerName,InetAddress.getLocalHost().getHostAddress(),false,numeroDeBloques);
							}
						}
					}
					System.out.println(Arrays.deepToString(t.hashes.toArray()));
					sP();
					int aux = t.hashes.size();
					while(aux>0) {
						int chunkADescargar = sB();
						byte[] b;
						b = getChunk(chunkADescargar);
						if(b!=null) {
							if(!esBien(b,chunkADescargar)) {
								System.out.println("El bloque se ha recibido de forma incorrecta");
							}
							else {
								guardaChunk(b,chunkADescargar);
								sB();
								nuevoChunk(chunkADescargar);
								aNB(chunkADescargar);
								if(completado()) {
									String tempDir = atemp.getParent();
									File nueva = new File(tempDir + "\\" + t.getNombreOriginal());
									atemp.renameTo(nueva);
									atemp = nueva;
									SoP = true;
									cambiarASeed(peerName);
									tracker.darAltaSeed(peerName);
								}
							}
						}
					}
					
					
					System.out.println("------------------------------------------------------------");
					break;
					
				case "2":
					System.out.println("Lista de todos los PEER: ");
					pAIP.forEach((k,v) -> System.out.println("Nombre: " + k + " | IP: " + v));
					System.out.println("Lista de todos los SEED: ");
					sAIP.forEach((k,v) -> System.out.println("Nombre: " + k + " | IP: " + v));
					System.out.println("------------------------------------------------------------");
					break;
					
				case "3":
					System.out.println("Cerrando peer: ");
					for(String p : pAIP.keySet()) {
						if(!(p.equals(peerName))){
							peerRegistry otroPeer = (peerRegistry) Naming.lookup("rmi://"+pAIP.get(p)+"/" + p);
							otroPeer.despedirPeer(peerName,false);
						}
					}
					for(String p : sAIP.keySet()) {
						if(!(p.equals(peerName))){
							peerRegistry otroPeer = (peerRegistry) Naming.lookup("rmi://"+sAIP.get(p)+"/" + p);
							otroPeer.despedirPeer(peerName,true);
						}
					}
					tracker.borrarPeer(peerName);
					System.out.println("------------------------------------------------------------");
					System.exit(0);
					break;
				}
			}
		}
	}
	
	public static void main (String args[]) throws Exception{
		peer peer = new peer();
		peer.iniciar();
		
	}
}
