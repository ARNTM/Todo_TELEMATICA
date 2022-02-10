package peer.funciones;

import java.io.Serializable;
import java.util.HashMap;

public class datos implements Serializable{
	
	HashMap<String,String> pAIP = new HashMap<String,String>(); // Peer con IP
	HashMap<String,String> sAIP = new HashMap<String,String>(); // Seed con IP
	
	torrent t;
	
	byte[] bitchunk;
	
	String r;
	boolean c;
	
	public datos(torrent t, HashMap<String,String> sAIP) {
		this.t = t;
		this.sAIP = sAIP;
	}
	
	public datos(torrent t, HashMap<String,String> sAIP, String r) {
		this.t = t;
		this.sAIP = sAIP;
		this.r = r;
	}
	
	public datos(torrent t, HashMap<String,String> sAIP, HashMap<String,String> pAIP) {
		this.t = t;
		this.sAIP = sAIP;
		this.pAIP = pAIP;
	}
	
	public datos(boolean c) {
		this.c = c;
	}
	
	public datos(boolean c, byte[] bitchunk) {
		this.c = c;
		this.bitchunk = bitchunk;
	}
	
	public byte[] getBloque() {
		return bitchunk;
	}
	
	public boolean getC() {
		return c;
	}

	public torrent gettorrent() {
		return t;
	}
	
	public HashMap<String,String> getpAIP()  {
		return pAIP;
	}
	
	public HashMap<String,String> getsAIP() {
		return sAIP;
	}
	
	public String getR() {
		return r;
	}

}
