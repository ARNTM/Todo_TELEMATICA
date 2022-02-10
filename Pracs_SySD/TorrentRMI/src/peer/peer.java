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
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Scanner;
import java.util.UUID;

import peer.funciones.torrent;
import tracker.trackerRegistry;

public class peer  extends UnicastRemoteObject implements peerRegistry{
	
	String peerName = UUID.randomUUID().toString();
	HashMap<String,String> pAIP = new HashMap<String,String>(); // Asocia peerNames con IP
	HashMap<String,String> sAIP = new HashMap<String,String>();
	ArrayList<Integer> bloquesEnPeer = new ArrayList<Integer>();
	torrent t;
	int bloqueSelect=0;
	File atemp;

	protected peer() throws RemoteException {
		super();
	}
	
	@Override
	public void saludarPeer(String peerName, String IP, int SoP) throws RemoteException {
		if(SoP == 1) {sAIP.put(peerName, IP);}
		else {pAIP.put(peerName, IP);}
		
	}
	
	@Override
	public void despedirPeer(String peerName) throws RemoteException {
		pAIP.remove(peerName);
	}
	
	@Override
	public ArrayList<Integer> bloquesDisponibles() throws RemoteException {
		return bloquesEnPeer;
	}
	
	@Override
	public byte[] getB(String ID, 	int i) throws RemoteException, FileNotFoundException, IOException {
		byte[] b = null;
		RandomAccessFile raf = new RandomAccessFile(atemp, "rw");
		int torrentSize = 512*1024;
		raf.seek(i*(torrentSize));
		
		if(i == (t.getHashes().size()-1)) {
			int bytesEnLast = (int) (t.tamanioArchivo - ((t.getHashes().size()-1) * 512 * 1024));
			b = new byte[bytesEnLast];
			raf.read(b, 0, bytesEnLast);
		}
		
		else {
			b = new byte[torrentSize];
			raf.read(b, 0, torrentSize);
		}			
		raf.close();
		
		return b;
		
	}
	
	private void iniciar() throws Exception {
		
		String funcion;
		System.out.println("Pulsa: \n 1 para COMPARTIR el archivo \n 2 para DESCARGAR el archivo");
		Scanner teclado = new Scanner (System.in); 
		funcion=teclado.nextLine();
		
		while(!(funcion.equals("1")) && !(funcion.equals("2"))) {
			System.out.println("Error al introducir una funcion. Compruebe lo que ha escrito");
			funcion=teclado.nextLine();
		}
		
		
		// Compartir archivo
		if(funcion.equals("1")) {
			System.out.println("PEER en modo COMPARTIR ARCHIVO");
			System.out.println("Introduce la IP del REGISTRO: ");
			Scanner introIP = new Scanner (System.in); 
			String IP = introIP.nextLine();
			trackerRegistry tracker = (trackerRegistry)Naming.lookup("rmi://"+IP+"/trackerRegistry");
			peer peer = new peer();
			Naming.rebind("rmi://"+ InetAddress.getLocalHost().getHostAddress() + "/" + peerName,peer);
			System.out.println("Creada conexion RMI del PEER: " + peerName);
			pAIP = tracker.registrarPeer(peerName,InetAddress.getLocalHost().getHostAddress(),1);
			sAIP = tracker.devolverSeed();
			System.out.println("PEER registrado correctamente. A continuacion se muestran los PEER activos");
			pAIP.forEach((k,v) -> System.out.println("Nombre: " + k + " | IP: " + v));
			for(String p : pAIP.keySet()) {
				if(!(p.equals(peerName))){
					peerRegistry otroPeer = (peerRegistry) Naming.lookup("rmi://"+pAIP.get(p)+"/" + p);
					otroPeer.saludarPeer(peerName,InetAddress.getLocalHost().getHostAddress(),1);
				}
			}
			for(String p : sAIP.keySet()) {
				if(!(p.equals(peerName))){
					peerRegistry otroPeer = (peerRegistry) Naming.lookup("rmi://"+sAIP.get(p)+"/" + p);
					otroPeer.saludarPeer(peerName,InetAddress.getLocalHost().getHostAddress(),1);
				}
			}
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
					t = new torrent(ruta);
					if(!(t.hashes.isEmpty())){
						tracker.almacenarTorrent(t);
						for (int i = 0 ; i<t.hashes.size() ; i++) {bloquesEnPeer.add(1);}
						System.out.println("Torrent registrado correctamente. Los HASHES generados son: ");
						System.out.println(Arrays.deepToString(t.hashes.toArray()));
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
					System.out.println("Cerrando PEER: ");
					for(String p : pAIP.keySet()) {
						if(!(p.equals(peerName))){
							peerRegistry otroPeer = (peerRegistry) Naming.lookup("rmi://"+pAIP.get(peerName)+"/" + p);
							otroPeer.despedirPeer(peerName);
						}
					}
					for(String p : sAIP.keySet()) {
						if(!(p.equals(peerName))){
							peerRegistry otroPeer = (peerRegistry) Naming.lookup("rmi://"+sAIP.get(p)+"/" + p);
							otroPeer.saludarPeer(peerName,InetAddress.getLocalHost().getHostAddress(),0);
						}
					}
					tracker.borrarPeer(peerName);
					System.out.println("------------------------------------------------------------");
					System.exit(0);
					break;
				}
			}
		}
		
		// Descargar archivo
		else if(funcion.equals("2")) {
			System.out.println("PEER en modo DESCARGAR ARCHIVO");
			System.out.println("Introduce la IP del REGISTRO: ");
			String IP = teclado.nextLine();
			
			trackerRegistry tracker = (trackerRegistry)Naming.lookup("rmi://"+IP+"/trackerRegistry");
			peer peer = new peer();
			Naming.rebind("rmi://"+ InetAddress.getLocalHost().getHostAddress() + "/" + peerName,peer);
			System.out.println("Creada conexion RMI del PEER: " + peerName);
			pAIP = tracker.registrarPeer(peerName,InetAddress.getLocalHost().getHostAddress(),0);
			sAIP = tracker.devolverSeed();
			System.out.println("PEER registrado correctamente. A continuacion se muestran los PEER activos");
			pAIP.forEach((k,v) -> System.out.println("Nombre: " + k + " | IP: " + v));
			for(String p : pAIP.keySet()) {
				if(!(p.equals(peerName))){
					peerRegistry otroPeer = (peerRegistry) Naming.lookup("rmi://"+pAIP.get(p)+"/" + p);
					otroPeer.saludarPeer(peerName,InetAddress.getLocalHost().getHostAddress(),0);
				}
			}
			for(String p : sAIP.keySet()) {
				if(!(p.equals(peerName))){
					peerRegistry otroPeer = (peerRegistry) Naming.lookup("rmi://"+sAIP.get(p)+"/" + p);
					otroPeer.saludarPeer(peerName,InetAddress.getLocalHost().getHostAddress(),0);
				}
			}
			while(true) {
				System.out.println("------------------------------------------------------------");
				System.out.println("Funcion a realizar\n Pulsa:\n 1 para OBTENER TORRENT\n 2 para mostrar todos los PEERS activos\n 3 para cerrar PEER");
				System.out.println("------------------------------------------------------------");
				Scanner funcionDescargar = new Scanner (System.in); 
				String fc = funcionDescargar.nextLine();
				switch(fc) {
				case "1":
					t = tracker.resumenTorrent();
					nuevoArchivoTemporal();
					bloqueSelect = sBloque();
					boolean paraDeSeleccionar = false;
					while (paraDeSeleccionar = false) {if(bloquesEnPeer.get(bloqueSelect)==1) bloqueSelect = sBloque(); paraDeSeleccionar = true;}
					System.out.println("Bloque seleccionado para la descarga: " + bloqueSelect);
					
					for(String p : sAIP.keySet()) {
						if(!(p.equals(peerName))){
							peerRegistry otroPeer = (peerRegistry) Naming.lookup("rmi://"+sAIP.get(p)+"/" + p);
							System.out.println(otroPeer.getB(peerName, bloqueSelect).toString());
							escribirBloque(otroPeer.getB(peerName, bloqueSelect),bloqueSelect);
						}
					}
					
					//System.out.println(Arrays.deepToString(t.hashes.toArray()));
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
							otroPeer.despedirPeer(peerName);
						}
					}
					for(String p : sAIP.keySet()) {
						if(!(p.equals(peerName))){
							peerRegistry otroPeer = (peerRegistry) Naming.lookup("rmi://"+sAIP.get(p)+"/" + p);
							otroPeer.saludarPeer(peerName,InetAddress.getLocalHost().getHostAddress(),0);
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
	
	public int sBloque() {
		int b = 0;
		b = (int) (Math.random() * t.getHashes().size());
		return b;
	}
	
	public void nuevoArchivoTemporal() {
		Scanner sc = new Scanner(System.in);
		System.out.println("Donde quieres descargar el archivo.");
		String ruta = sc.nextLine();
		File tempDir = new File(ruta);
		try {
			if (!tempDir.exists()) {
				if(tempDir.mkdirs()) {
					System.out.println("Directorio creado");
				}
				else {
					throw new FileNotFoundException();
				}
			}
			else {
				System.out.println("El directorio ya existe");
			}
			atemp = File.createTempFile("torrent", null, tempDir);
			FileOutputStream fo = new FileOutputStream("" + ruta + "\\" + atemp.getName());
			fo.write(new byte[(int) (t.getTArchivo())]);
			fo.close();
			
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException io) {
			// TODO Auto-generated catch block
			io.printStackTrace();
		}
	}
	
	public void escribirBloque(byte [] b, int i) throws IOException {
		RandomAccessFile raf = new RandomAccessFile(atemp, "rw");
		int blockLength = 512*1024;
		raf.seek(i*(blockLength));
		raf.write(b);
		raf.close();
	}


	public static void main (String args[]) throws Exception{
		peer peer = new peer();
		peer.iniciar();
		
	}
}
