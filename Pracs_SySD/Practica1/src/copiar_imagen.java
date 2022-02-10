import java.io.*;
import java.nio.file.*;
import java.nio.ByteBuffer;
import java.nio.channels.*;



public class copiar_imagen {
	public copiar_imagen(String imagen) throws IOException{
		File source = new File ("D:\\GIT\\Universidad\\Pracs_SistYServDist\\source\\" + imagen);
		Path source_path = source.toPath();
		File target = new File ("D:\\GIT\\Universidad\\Pracs_SistYServDist\\target\\" + imagen);
		Path target_path = target.toPath();
		
		FileChannel in = (FileChannel) Files.newByteChannel(source_path);
		FileChannel out = (FileChannel) Files.newByteChannel(target_path, StandardOpenOption.CREATE, StandardOpenOption.APPEND);
		
		ByteBuffer buffer = ByteBuffer.allocate(1024*8);
		
		while (in.read(buffer) != -1) {
			System.out.println(buffer.position());
			
			buffer.flip();
			System.out.println(buffer.position());
			
			out.write(buffer);
			System.out.println(buffer.position());
			
			buffer.clear();
		}
	}
	
}
