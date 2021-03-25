/*
	Gestion de los eventos de los menus
	Copyright (C) 2004  Jose Carlos Fernandez Conesa   mail: zirition@gmail.com

	This program is free software; you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation; either version 2 of the License, or
	(at your option) any later version.

	This program is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with this program; if not, write to the Free Software
	Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */

import java.awt.BorderLayout;
import java.awt.Dimension;
import java.awt.Toolkit;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.KeyEvent;
import java.awt.event.KeyListener;
import java.awt.event.WindowEvent;
import java.awt.event.WindowListener;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;

import javax.swing.JButton;
import javax.swing.JDialog;
import javax.swing.JFileChooser;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JTextField;
import javax.swing.filechooser.FileFilter;

public class Eventos implements ActionListener, WindowListener{
	public static final int NUEVO = 0;
	public static final int ABRIR = 1;
	public static final int GUARDAR = 2;
	public static final int GUARDARCOMO = 3;
	public static final int SALIR = 4;
	public static final int DESHACER = 5;
	public static final int REHACER = 6;
	public static final int COPIAR = 7;
	public static final int CORTAR = 8;
	public static final int PEGAR = 9;
	public static final int MODODEPURACION = 10;
	public static final int MODODESARROLLO = 11;
	public static final int COMPILAR = 12;
	public static final int STEP = 13;
	public static final int STEPS = 14;
	public static final int RESET = 15;
	public static final int CAMBIARPORTS = 16;
	public static final int PROPDESARROLLO = 17;
	public static final int ACERCADE = 18;
	public static final int BREAKPOINT = 19;
	
	private PicoIDE app;
	private int evento;
	private static File fichero = null;
	private static String path = null;
	private static String[] ejecutable = {"."+File.separator+"asm", ""};

	JDialog dialog;
	JButton aceptarDialog;
	JButton cancelarDialog;	
	JTextField editDialog;
		
	public Eventos(PicoIDE app, int evento){
		this.app = app;
		this.evento = evento;
		if(evento==PROPDESARROLLO)
			crearDialog();		
	}
	
	private void asignarFichero(){
		ejecutable[1]=fichero.getAbsolutePath();
		path = fichero.getAbsolutePath();
	}
	
	public static void cargarDeFichero(){
		File f = new File("."+File.separator+"Config.ini");
		if(f.exists())
		{
			try {
				FileReader fr = new FileReader(f);
				char c;
				StringBuffer s = new StringBuffer();
				
				while((c = (char)fr.read()) != '\n' && c != -1) s.append(c);
				if (c == -1) return;
				File f2 = new File(s.toString());
				ejecutable[0] = s.toString();
				
				s = new StringBuffer();
				while((c = (char)fr.read()) != '\n' && c != -1) s.append(c);
				if (c == -1) return;
				f2 = new File(s.toString());
				path = f2.getAbsolutePath();
			} catch (FileNotFoundException e) {}
			  catch (IOException e) {}
		}
	}

	private void crearDialog() {
		dialog = new JDialog(app.getFrame(),"Propiedades", true);
		JPanel panel = new JPanel(new BorderLayout());
		JPanel panelB = new JPanel();
		JPanel panelEdit = new JPanel();

		aceptarDialog = new JButton("Aceptar");
		aceptarDialog.addActionListener(new EventosProp());

		cancelarDialog = new JButton("Cancelar");
		cancelarDialog.addActionListener(new EventosProp());

		editDialog = new JTextField(30);
		editDialog.setText(ejecutable[0]);
		editDialog.addActionListener(new EventosProp());
		
		JButton rutaDialog = new JButton("Explorar");
		rutaDialog.addActionListener(new ActionListener()
		{
			public void actionPerformed(ActionEvent ae)
			{
				JFileChooser jfc = new JFileChooser();
				if(jfc.showOpenDialog(app.getFrame()) == JFileChooser.APPROVE_OPTION)
					editDialog.setText(jfc.getSelectedFile().getAbsolutePath());
					editDialog.select(0,editDialog.getText().length());
			}
		}
		);
		panelB.add(aceptarDialog,BorderLayout.WEST);
		panelB.add(cancelarDialog,BorderLayout.EAST);
		
		panel.add(panelB,BorderLayout.SOUTH);
		
		panelEdit.add(new JLabel("Ruta al compilador"));
		panelEdit.add(editDialog);
		panelEdit.add(rutaDialog);
		panel.add(panelEdit,BorderLayout.CENTER);

		dialog.setContentPane(panel);
		editDialog.select(0,editDialog.getText().length());
		
		Dimension d = Toolkit.getDefaultToolkit().getScreenSize();
		dialog.setLocation((int)(d.width*0.3),(int)(d.height*0.4));
		
		editDialog.addKeyListener(new KeyListener()
		{
			public void keyTyped(KeyEvent arg0) {}
			public void keyPressed(KeyEvent arg0) {
				if(arg0.getKeyCode()==KeyEvent.VK_ESCAPE)
				dialog.setVisible(false);
			}
			public void keyReleased(KeyEvent arg0) {}
		});
		
		aceptarDialog.addKeyListener(editDialog.getKeyListeners()[0]);
		cancelarDialog.addKeyListener(editDialog.getKeyListeners()[0]);
		dialog.addKeyListener(editDialog.getKeyListeners()[0]);
	}

	public void actionPerformed(ActionEvent e) {
		switch(evento){
			case NUEVO: nuevo();break;
			case ABRIR: abrir(); break;
			case GUARDAR: guardar(); break;
			case GUARDARCOMO: guardarComo();guardar(); break;
			case SALIR: this.salir(); break;
			
			case DESHACER: deshacer(); break;
			case REHACER: rehacer(); break;
			case COPIAR: copiar(); break;
			case CORTAR: cortar(); break;
			case PEGAR: app.getPanelDesarrollo().pegar(); break;
			
			case MODODEPURACION: app.setPanelDepuracion(); break;
			case MODODESARROLLO: app.setPanelDesarrollo(); break;
			case COMPILAR: app.setPanelDesarrollo();compilar(); break;
			case BREAKPOINT: app.setPanelDepuracion(); app.getPanelDepuracion().breakpoint() ; break;
			case STEP: app.setPanelDepuracion(); app.getPanelDepuracion().step(); break;
			case STEPS: app.setPanelDepuracion(); app.getPanelDepuracion().steps(); break;
			case RESET: app.setPanelDepuracion(); app.getPanelDepuracion().reset(); break;
			case CAMBIARPORTS: app.setPanelDepuracion();app.getPanelDepuracion().setPuerto(); break;
			case PROPDESARROLLO: propiedades(); break;
			
			case ACERCADE: acercaDe();break;
		}
	}
	
	private void acercaDe() {
		JOptionPane.showMessageDialog(app.getFrame()," PicoIDE v 1.0\n Autor: José Carlos Fernández Conesa\n Licencia GNU GPL: http://www.gnu.org/copyleft/gpl.html\n\n  Para comentarios, bugs y demas: zirition@gmail.com");
	}

	private void nuevo(){
		if(!app.getPanelDesarrollo().isTextoEditado() || guardarPrimero()){
			app.getPanelDesarrollo().nuevo();
			if(fichero != null) path =fichero.getAbsolutePath();
			fichero = null;
		}
	}
	
	private void abrir(){
		if(!app.getPanelDesarrollo().isTextoEditado() || guardarPrimero()){
			JFileChooser fc = new JFileChooser(path);
			fc.setAcceptAllFileFilterUsed(false);
			fc.setFileFilter(new FileFilter(){

				public boolean accept(File arg0) {
					if(arg0.getName().toLowerCase().endsWith(".asm")) return true;
					else if(arg0.isDirectory()) return true;
					else return false;
				}

				public String getDescription() {
					return "Fuentes PicoBlaze";
				}
			});
			int j=fc.showOpenDialog(app.getFrame());
			if(j==JFileChooser.APPROVE_OPTION){
				fichero=fc.getSelectedFile();
				try {
					FileReader fr = new FileReader(fichero);
					int i;
					String a = "";
					while((i=fr.read())!=-1){
						a=a+(char)i;
					}
					app.getPanelDesarrollo().abrir(a, fichero.getName());
					app.getPanelDepuracion().setFichero(fichero);
					asignarFichero();
					
				} catch (FileNotFoundException e) {
					this.FileNotFound();
					e.printStackTrace();
				} catch (IOException ioe){
					this.IOError(fichero.getName());					
				}
			}
		}
	}
	
	private boolean guardar(){
		if(fichero!=null || guardarComo()){
			try {
				FileOutputStream fos = new FileOutputStream(fichero);
				PrintWriter ps = new PrintWriter(fos);
				ps.write(app.getPanelDesarrollo().getTexto());
				ps.flush();
				ps.close();
				fos.close();
				asignarFichero();				
			} catch (FileNotFoundException e) {
				this.FileNotFound();
				e.printStackTrace();
				return false;
			} catch (IOException ioe) {
				this.IOError(fichero.getName());
				return false;
			}
			app.getFrame().setTitle("PicoIDE v1.0 - "+fichero.getName());
			app.getPanelDesarrollo().setTextoEditado(false);
			return true;
		}
		else return false;		
	}
	
	private boolean guardarComo(){
		JFileChooser fc = new JFileChooser(path);
		fc.setAcceptAllFileFilterUsed(false);
		fc.setFileFilter(new FileFilter(){
			public boolean accept(File arg0) {
				if(arg0.getName().toLowerCase().endsWith(".asm")) return true;
				else if(arg0.isDirectory()) return true;
				else return false;
			}

			public String getDescription() {
				return "Fuentes PicoBlaze";
			}
		});
		int j=fc.showSaveDialog(app.getFrame());
		if(j==JFileChooser.APPROVE_OPTION){
			fichero=fc.getSelectedFile();
			String f = fichero.getAbsolutePath();
			if(!f.endsWith(".asm")){
				f=f.concat(".asm");
				fichero = new File(f);
			}

			return true;		
		}
		else return false;
	}

	private void salir() {
		if(!app.getPanelDesarrollo().isTextoEditado() || guardarPrimero()){
			File f = new File("."+File.separator+"Config.ini");
			try {
				FileWriter fw = new FileWriter(f);
				fw.write(ejecutable[0],0,ejecutable[0].length());
				fw.write('\n');
				fw.write(fichero != null ? fichero.getAbsolutePath() : "" );
				fw.write('\n');
				fw.flush();
				fw.close();
			} catch (IOException e) {
				IOError(f.getName()); 	
			}
			System.exit(0);
		}		
	}
	
	private void deshacer(){
		app.getPanelDesarrollo().deshacer();
	}
	
	private void rehacer(){
		app.getPanelDesarrollo().rehacer();
	}
	
	private void copiar(){
		app.getPanelDesarrollo().copiar(); //TODO Copiar, cortar y pegar en todo el prog.
	}
	
	private void cortar(){
		app.getPanelDesarrollo().cortar();
	}
	
	private boolean compilar(){
		if(guardar()){
			Thread t = new Thread(){
				public void run(){
					boolean b;
					if(fichero==null) b=guardar();
					else b=true;
				
					if(!b) return;
					try{
						app.getPanelDesarrollo().limpiarConsola();
						Process p = Runtime.getRuntime().exec(ejecutable);
						InputStreamReader isr = new InputStreamReader(p.getInputStream());
						BufferedReader bf = new BufferedReader(isr);
						String S;

						boolean sigueVivo = true;
						while(sigueVivo){
							try{
								p.exitValue();
								sigueVivo=false;
							}catch(IllegalThreadStateException itse){
								while((S=bf.readLine()) != null){
									app.getPanelDesarrollo().addConsola(S+"\n");								
								}						
							}
							while((S=bf.readLine()) != null){
								app.getPanelDesarrollo().addConsola(S+"\n");								
							}
							app.getPanelDepuracion().setFichero(fichero);						
						}
					}catch(IOException e){}
				}
			};
			t.start();
			return true;
		}
		else return false;
	}
	
	private void propiedades(){
		editDialog.setText(ejecutable[0]);
		dialog.pack();
		dialog.setVisible(true);
		editDialog.requestFocusInWindow();
		editDialog.selectAll();
	}
	
	private boolean guardarPrimero(){
		String[] temp = {"Sí", "No"};
		int i=JOptionPane.showOptionDialog(app.getFrame(),"¿Deseas guardar primero?","PicoIDE",JOptionPane.YES_NO_OPTION,JOptionPane.QUESTION_MESSAGE,null,temp,temp[0]);
		if(i==0) {
			return guardar();
		} 
		else if(i==JOptionPane.CLOSED_OPTION)
			return false;
		else return true;
	}
	
	private void FileNotFound(){
		JOptionPane.showMessageDialog(app.getFrame(),"Fichero no encontrado.","Error",JOptionPane.ERROR_MESSAGE);
	}
	
	private void IOError(String s){
		JOptionPane.showMessageDialog(app.getFrame(),"Error de E/S con el fichero"+ s +".","Error",JOptionPane.ERROR_MESSAGE);
	}

	class EventosProp implements ActionListener{
	
		public void actionPerformed(ActionEvent arg0) {
			if(arg0.getSource()!=cancelarDialog){
				ejecutable[0]=editDialog.getText();
			}
			dialog.setVisible(false);
		}
	}

	public void windowOpened(WindowEvent arg0) {
	}

	public void windowClosing(WindowEvent arg0) {
		salir();
	}

	public void windowClosed(WindowEvent arg0) {
	}
	public void windowIconified(WindowEvent arg0) {
	}
	public void windowDeiconified(WindowEvent arg0) {
	}
	public void windowActivated(WindowEvent arg0) {
	}
	public void windowDeactivated(WindowEvent arg0) {
	}
}

