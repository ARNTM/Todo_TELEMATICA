/*
	Codigo principal de la aplicacion
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
import java.awt.Toolkit;
import java.awt.event.ActionListener;
import java.awt.event.KeyEvent;

import javax.swing.ImageIcon;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JMenu;
import javax.swing.JMenuBar;
import javax.swing.JMenuItem;
import javax.swing.JPanel;
import javax.swing.JToolBar;
import javax.swing.KeyStroke;

public class PicoIDE {
	private JFrame App;
	private JMenuBar barra;
	private JToolBar toolbar;
	private JPanel visible = new JPanel(new BorderLayout());
	private PanelDesarrollo desarrollo;
	private PanelDepuracion depuracion;
	private MotorDebugger motor;
	
	public PicoIDE(){
		App = new JFrame("PicoIDE v 1.0 - Sin Título");
		desarrollo  = new PanelDesarrollo(App);
		depuracion = new PanelDepuracion(App);
		Eventos.cargarDeFichero();
		this.aplicamosPropVentana();
		this.creamosMenu();
		this.creamosToolBar();
		Eventos.cargarDeFichero();
	
		App.addWindowListener(new Eventos(this,Eventos.SALIR));
		App.setDefaultCloseOperation(JFrame.DO_NOTHING_ON_CLOSE);
		App.setContentPane(visible);
		visible.add(desarrollo,BorderLayout.CENTER);
		App.show();
	}

	private void creamosToolBar() {
		toolbar = new JToolBar();
		toolbar.setFloatable(false);
		String[] Iconos = {"Iconos/New.gif","Iconos/Open.gif","Iconos/Save.gif","/",
									"Iconos/Copy.gif","Iconos/Cut.gif","Iconos/Paste.gif","/",
									"Iconos/Compile.gif", "Iconos/Breakpoint.gif","Iconos/Step.gif",
									"Iconos/Steps.gif",	"Iconos/Reset.gif","Iconos/Edit.gif","" +									"Iconos/Debug.gif"};
		String[] ToolTip = {"Nuevo", "Abrir...", "Guardar", "",
									"Copiar", "Cortar", "Pegar", "",
									"Compilar", "Activar/Desactivar Breakpoint", "Simular un paso", 
									"Simular varios pasos",	"Reset","Modo Desarrollo", 
									"Modo Depuración"};
		ActionListener[] eventos = {new Eventos(this, Eventos.NUEVO),
												  new Eventos(this, Eventos.ABRIR),
												  new Eventos(this, Eventos.GUARDAR),
												  null,
												  new Eventos(this, Eventos.COPIAR),
												  new Eventos(this, Eventos.CORTAR),
												  new Eventos(this, Eventos.PEGAR),
												  null,
												  new Eventos(this, Eventos.COMPILAR),
												  new Eventos(this, Eventos.BREAKPOINT),
												  new Eventos(this, Eventos.STEP),
												  new Eventos(this, Eventos.STEPS),
												  new Eventos(this, Eventos.RESET),
												  new Eventos(this, Eventos.MODODESARROLLO),
												  new Eventos(this, Eventos.MODODEPURACION)};
		
		this.ponerIconosToolbar(Iconos, ToolTip, eventos);
	}

	private void ponerIconosToolbar(String[] Iconos, String[] ToolTip, ActionListener[] eventos) {
		JButton boton;
		for(int i=0;i<Iconos.length;i++)
		{
			if(Iconos[i].equals("/")){
				toolbar.addSeparator();
				continue;
			}
			boton = new JButton(new ImageIcon(Iconos[i]));
			boton.addActionListener(eventos[i]);
			boton.setToolTipText(ToolTip[i]);
			toolbar.add(boton);
		}
		visible.add(toolbar,BorderLayout.PAGE_START);
	}

	private void creamosMenu() {
		barra = new JMenuBar();
		String[] NombreMenus = {"Nuevo",
								"Abrir...", 
								"Guardar...", 
								"Guardar como...",
								"/",
								"Salir"};
		char[] MenusMne = {'N','A','G','c',' ','S'};
		KeyStroke[] aceleraciones = {KeyStroke.getKeyStroke(KeyEvent.VK_N,KeyEvent.CTRL_MASK),
									 KeyStroke.getKeyStroke(KeyEvent.VK_A,KeyEvent.CTRL_MASK),
									 KeyStroke.getKeyStroke(KeyEvent.VK_G,KeyEvent.CTRL_MASK),
									 null,
									 null,
									 KeyStroke.getKeyStroke(KeyEvent.VK_Q,KeyEvent.CTRL_MASK)};									 
		ActionListener[] eventos = {new Eventos(this, Eventos.NUEVO),
									new Eventos(this, Eventos.ABRIR), 
									new Eventos(this, Eventos.GUARDAR), 
									new Eventos(this, Eventos.GUARDARCOMO), 
									null, 
									new Eventos(this, Eventos.SALIR)};
		this.anadirMenus(barra, "Archivo", 'A', NombreMenus, MenusMne,aceleraciones, eventos);
		

		String[] NombreMenusE = {"Deshacer",
								"Rehacer",
								"/",
								"Copiar", 
								"Cortar", 
								"Pegar"};
		char[] MenusMneE = {'D','R',' ','C','t','P'};
		KeyStroke[] aceleracionesE = {KeyStroke.getKeyStroke(KeyEvent.VK_Z,KeyEvent.CTRL_MASK),
									 KeyStroke.getKeyStroke(KeyEvent.VK_R,KeyEvent.CTRL_MASK),
									 null,
						 			 KeyStroke.getKeyStroke(KeyEvent.VK_C,KeyEvent.CTRL_MASK),
									 KeyStroke.getKeyStroke(KeyEvent.VK_X,KeyEvent.CTRL_MASK),
									 KeyStroke.getKeyStroke(KeyEvent.VK_V,KeyEvent.CTRL_MASK)};									 
		ActionListener[] eventosE = {new Eventos(this, Eventos.DESHACER),
									new Eventos(this, Eventos.REHACER),
									null, 
									new Eventos(this, Eventos.COPIAR), 
									new Eventos(this, Eventos.CORTAR), 
									new Eventos(this, Eventos.PEGAR)}; 
		this.anadirMenus(barra, "Edición", 'E', NombreMenusE, MenusMneE,aceleracionesE, eventosE);


		String[] NombreMenusC = {"Pasar a Modo Depuración",
								 "Pasar a Modo Desarrollo",
								 "/", 
								 "Compilar",
								 "/",
								 "Activar/Desactivar Breakpoint",
								 "Simular un paso", 
								 "Simular varios pasos...",
								 "Reset",
								 "/",
								 "Modificar Puerto...",
								 "/",
								 "Propiedades..."};								
		char[] MenusMneC = {'D', 'e', ' ', 'o', ' ', 'B', 'S', 'v','R' , ' ','M',' ','P'};
		KeyStroke[] aceleracionesC = {KeyStroke.getKeyStroke(KeyEvent.VK_D,KeyEvent.CTRL_MASK),
								KeyStroke.getKeyStroke(KeyEvent.VK_E,KeyEvent.CTRL_MASK),
								null,
								KeyStroke.getKeyStroke(KeyEvent.VK_W,KeyEvent.CTRL_MASK),
								null,
								KeyStroke.getKeyStroke(KeyEvent.VK_B, KeyEvent.CTRL_MASK),
								KeyStroke.getKeyStroke(KeyEvent.VK_F5, 0),
								KeyStroke.getKeyStroke(KeyEvent.VK_F8, 0),
								null,
								null,
								KeyStroke.getKeyStroke(KeyEvent.VK_M,KeyEvent.CTRL_MASK),
								null,
								null};									 
		ActionListener[] eventosC = {new Eventos(this, Eventos.MODODEPURACION), 
						  		new Eventos(this, Eventos.MODODESARROLLO),
						  		null, 
						   		new Eventos(this, Eventos.COMPILAR),
						   		null,
						   		new Eventos(this, Eventos.BREAKPOINT), 
								new Eventos(this, Eventos.STEP), 
								new Eventos(this, Eventos.STEPS),
								new Eventos(this, Eventos.RESET),
								null,
								new Eventos(this, Eventos.CAMBIARPORTS),
								null,
								new Eventos(this, Eventos.PROPDESARROLLO)}; 

		this.anadirMenus(barra, "Desarrollo", 'D', NombreMenusC, MenusMneC,aceleracionesC, eventosC);
		
		String[] NombreMenusAy = {"Acerca de..."};
		char[] MenusMneAy = {'A'};
		KeyStroke[] aceleracionesAy = {null};
		Eventos[] eventosAy ={new Eventos(this,Eventos.ACERCADE)};  
		this.anadirMenus(barra, "Ayuda", 'y', NombreMenusAy, MenusMneAy,aceleracionesAy, eventosAy);

		App.setJMenuBar(barra);
				
	}

	private void anadirMenus(JMenuBar menubar,
							 String menuStr, 
							 char menuMne, 
							 String[] menuItems, 
							 char[] menuMnemonic, 
							 KeyStroke[] menuAccelerator, 
							 ActionListener[] eventos){
		JMenu menu = new JMenu(menuStr);
		menu.setMnemonic(menuMne);		

		JMenuItem temp;
		for(int i=0;i<menuItems.length;i++){
			if(menuItems[i].equals("/")){
				menu.addSeparator();
				 continue; 
			}

			temp = new JMenuItem(menuItems[i]);
			temp.setMnemonic(menuMnemonic[i]);
			if (menuAccelerator[i]!=null)
				temp.setAccelerator(menuAccelerator[i]);
			temp.addActionListener(eventos[i]);
			
			menu.add(temp);
			menubar.add(menu);
		}
	}
		
	private void aplicamosPropVentana() {
//		GraphicsDevice device = GraphicsEnvironment.getLocalGraphicsEnvironment().getDefaultScreenDevice();
//		device.setFullScreenWindow(App);
		App.setSize(Toolkit.getDefaultToolkit().getScreenSize());	
	}
	
	private void repintar(){
		App.repaint();
		App.validate();
	}
	
	public MotorDebugger getMotorDebugger(){
		return motor;
	}
	
	public void setPanelDepuracion(){
		visible.remove(desarrollo);
		visible.add(depuracion,BorderLayout.CENTER);
		repintar();
	}
	
	public void setPanelDesarrollo(){
		visible.remove(depuracion);
		visible.add(desarrollo,BorderLayout.CENTER);
		repintar();
	}
	
	public PanelDesarrollo getPanelDesarrollo(){
		return desarrollo;
	}
	
	public PanelDepuracion getPanelDepuracion(){
		return depuracion;
	}
	
	public JFrame getFrame(){
		return App;
	}
		
	public static void main(String[] args) {
		new PicoIDE();
	}
}
