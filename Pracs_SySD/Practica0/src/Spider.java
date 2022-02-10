
public class Spider extends Bicho{
	public Spider() {
		super(8,8,"Spider");
		numeroTotalDeBichos++;
	}
	
	public Spider(int patas, int ojos, String nombre) {
		this.patas=patas;
		this.ojos=ojos;
		this.nombre=nombre;
		numeroTotalDeBichos++;
	}
}
