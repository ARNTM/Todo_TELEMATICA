import java.nio.ByteBuffer;

public class userMessage extends Header{

	public String NAME;
	public int DNI;
	
	public userMessage(int LENGTH, String NAME, int DNI) {
		super(1, LENGTH);
		this.NAME=NAME;
		this.DNI=DNI;
	}
	
	public byte[] pack() {
		ByteBuffer bb = null;
		bb.allocate(NAME.length()*2+4);
		bb.putInt(LENGTH);
		bb.put(NAME.getBytes());
		bb.putInt(DNI);
		
		return bb.array();
	}
	public void unpack(byte[] bb) {
		ByteBuffer buffer = ByteBuffer.wrap(bb);
		int LENGTH = buffer.getInt(0);
		String NAMEunpacked = null;
		for (int i = 4 ; i<((LENGTH-8)/2) ; i+=2) {
			NAMEunpacked += buffer.getChar(i);
		}
		int DNIHunpacked = buffer.getInt(NAME.length()*2);
	}
}
