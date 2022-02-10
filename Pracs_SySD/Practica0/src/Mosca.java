
public class Mosca extends Bicho{
	public Mosca() {
		super(4,2,"Mosca");
		numeroTotalDeBichos++;
	}
	
	public Mosca(int patas, int ojos, String nombre) {
		this.patas=patas;
		this.ojos=ojos;
		this.nombre=nombre;
		numeroTotalDeBichos++;
	}
}
