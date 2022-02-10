
public class userText extends Header{
	
	public String TEXT;
	public int DNI;
	
	public userText(int TYPE, int LENGTH, String TEXT, int DNI) {
		super(TYPE,LENGTH);
		this.TEXT=TEXT;
		this.DNI=DNI;
	}
}
