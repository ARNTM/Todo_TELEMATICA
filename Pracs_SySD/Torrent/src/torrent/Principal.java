package torrent;

public class Principal {

	public static void main(String[] args) throws Exception {
		CreaHashMD5 t = new CreaHashMD5("F:\\Andres\\Videos\\Base Profile\\Base Profile Screenshot 2018.09.30 - 12.36.41.26.png");
		System.out.println(t.getHashes());
		new CompartirArchivo();
		//new DetectaSO();
	}
}