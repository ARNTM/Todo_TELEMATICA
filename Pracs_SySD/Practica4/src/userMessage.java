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
		byte[] header = super.pack();
		ByteBuffer bb = ByteBuffer.allocate(NAME.length()*2+4+header.length);
		bb.put(header);
		bb.putInt(LENGTH);
		bb.put(NAME.getBytes());
		bb.putInt(DNI);
		byte[] mensaje = bb.array();

		return mensaje;
	}
	public void unpack(byte[] bb) {
		ByteBuffer buffer = ByteBuffer.wrap(bb);
		super.unpack(bb);
		int LENGTH = buffer.getInt(8);
		String NAMEunpacked = null;
		for (int i = 12 ; i<((LENGTH-8)/2) ; i+=2) {
			NAMEunpacked += buffer.getChar(i);
		}
		int DNIHunpacked = buffer.getInt(NAME.length()*2);
	}
}
