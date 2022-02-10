import java.io.*;
import java.net.*;
import java.nio.*;
import java.nio.channels.*;

public class Cliente {
  
      public static void main(String[] args) {
          try {
              String[] messages = {"I like non-blocking servers", "Hello non-blocking world!", "One more message..", "exit"};
              System.out.println("Starting client...");
              SocketChannel client = SocketChannel.open(new InetSocketAddress("localhost", 8089));
  
              for (String msg : messages) {
                  System.out.println("Prepared message: " + msg);
                  ByteBuffer buffer = ByteBuffer.allocate(1024);
                  buffer.put(msg.getBytes());
                  buffer.flip();
                  int bytesWritten = client.write(buffer);
                  System.out.println(String.format("Sending Message: %s\nbufforBytes: %d", msg, bytesWritten));
              }
  
              client.close();
              System.out.println("Client connection closed");
  
          } catch (IOException e) {
              e.printStackTrace();
          }
      }
  }