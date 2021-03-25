
import java.io.IOException;
import java.nio.*;
import java.nio.charset.Charset;
import java.net.*;
import java.nio.channels.*;
import java.util.Iterator;

public class NonBlockingServer {

	/**
	 * @param args
	 */
	public static final int PORT = 8080;
	
	public static void main(String[] args) 
		// TODO Auto-generated method stub
		throws IOException {
		    //byte stream requiere el tipo de codificacion usada.
		    String encoding = System.getProperty("file.encoding");
		    Charset cs = Charset.forName(encoding);
		    ByteBuffer buffer = ByteBuffer.allocate(16);
		    SocketChannel ch = null;
		    ServerSocketChannel ssc = ServerSocketChannel.open();
		    Selector sel = Selector.open();
		    try {
		      //Es obligatorio configurarlo como no-bloqueante
			ssc.configureBlocking(false);
			//Puerto que escuchara
		      ssc.socket().bind(new InetSocketAddress(PORT));
		      // Registramos que estamos interesados en eventos ACCEPT 
		      SelectionKey key =
		        ssc.register(sel, SelectionKey.OP_ACCEPT);
		      System.out.println("Server on port: " + PORT);
		      while(true) {
		        sel.select();
		        System.out.println("Returning from Select()");
		        //Recorremremos todas las claves (eventos) que nos 
			//devuelva el selector y atendemos los eventos
			Iterator<SelectionKey> it = sel.selectedKeys().iterator();
		        while(it.hasNext()) {
		          SelectionKey skey = (SelectionKey)it.next();
		          it.remove();
			//Si el evento es ACCEPT aceptamos la conexion pendiente
		          if(skey.isAcceptable()) {
		            ch = ssc.accept();
		            System.out.println(
		              "Accepted connection from:" + ch.socket());
			//Configuramos el socket no bloqueante
		            ch.configureBlocking(false);
			//Registramos al selector que queremos recibir eventos READ
			//de ese socket
		            ch.register(sel, SelectionKey.OP_READ);
		          } else {
		            // Deberiamos comprobrar si el evento es lectura o escritura 
				//Pero simplificamos..
		            ch = (SocketChannel)skey.channel();
		            ch.read(buffer);
		            CharBuffer cb = cs.decode(
		              (ByteBuffer)buffer.flip());
		            String response = cb.toString();
		            System.out.print("Echoing : " + response);
		            ch.write((ByteBuffer)buffer.rewind());
		            if(response.indexOf("quit") != -1) ch.close();
		            buffer.clear();
		          }
		        }
		      }
		    } finally {
		      if(ch != null) ch.close();
		      ssc.close();
		      sel.close();
		    }
	}

}
