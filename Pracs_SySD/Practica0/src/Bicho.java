
public class Bicho {
	//private int patas;
	//private int ojos;
	//private String nombre;
	
	protected int patas;
	protected int ojos;
	protected String nombre;
	static int numeroTotalDeBichos;
	
	public int getPatas() {
		return patas;
	}


	public int getOjos() {
		return ojos;
	}


	public String getNombre() {
		return nombre;
	}


	public int getnumeroTotalDeBichos() {
		return numeroTotalDeBichos;
	}

	//Por defecto
	public Bicho() {
		this.nombre="Sin nombre";
		this.patas = 0;
		this.ojos = 0;
	}
	
	public Bicho(int patas, int ojos, String nombre) {
		this.patas = patas;
		this.ojos = ojos;
		this.nombre = nombre;
	}
	
	public void mostrar() {
		System.out.println("Patas: "+ getPatas() + ", Ojos: " + getOjos() + ", Nombre: " + getNombre() +", Total de bichos: " + getnumeroTotalDeBichos());
	}
}
