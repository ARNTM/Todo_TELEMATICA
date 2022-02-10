import java.io.Serializable;
import java.nio.ByteBuffer;

public class Header implements Serializable{
	
	public int TYPE;
	public int LENGTH;

			
	public Header(int TYPE, int LENGTH) {
		this.TYPE=TYPE;
		this.LENGTH=LENGTH;
		
	}
	
	public byte[] pack() {
		ByteBuffer bb = ByteBuffer.allocate(8);
		bb.putInt(TYPE);
		bb.putInt(LENGTH);
		
		return bb.array();
	}
	public void unpack(byte[] bb) {
		ByteBuffer buffer = ByteBuffer.wrap(bb);
		int TYPEunpacked = buffer.getInt(0);
		int LENGTHunpacked = buffer.getInt(4);
	}
}
