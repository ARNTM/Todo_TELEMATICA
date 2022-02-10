import java.io.*;
import java.util.*;

	public class listado_ordenado {
		public listado_ordenado() throws IOException{
			File dir = new File("C:\\Users\\andre\\Desktop\\SOFTWARE_AKAI");
			String[] ficheros = dir.list();
			if (ficheros == null) {
				System.out.println("Directorio vacio");
			}
			else {		
					List<String> list = new ArrayList<String>();
					list.addAll(Arrays.asList(ficheros));
					Collections.sort(list);
					System.out.println(list);
			}
		}	
	}
