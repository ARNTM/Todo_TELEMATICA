/*
	Panel de simulacion
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
import java.awt.Color;
import java.awt.Component;
import java.awt.Dimension;
import java.awt.Font;
import java.awt.Toolkit;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.KeyEvent;
import java.awt.event.KeyListener;
import java.io.File;
import java.io.IOException;

import javax.swing.JButton;
import javax.swing.JDialog;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JSplitPane;
import javax.swing.JTable;
import javax.swing.JTextField;
import javax.swing.JTextPane;
import javax.swing.table.AbstractTableModel;
import javax.swing.table.TableCellRenderer;
import javax.swing.text.BadLocationException;
import javax.swing.text.Style;
import javax.swing.text.StyleConstants;
import javax.swing.text.StyleContext;
import javax.swing.text.StyledDocument;

public class PanelDepuracion extends JPanel {
	private JTextPane desensamblado=new JTextPane();
	private JTextPane puertos = new JTextPane();
	private JScrollPane scrollDes = new JScrollPane(desensamblado);
	private JScrollPane scrollPuertos= new JScrollPane(puertos);
	private JTable tabla = new JTable();
	private JScrollPane scrollTabla = new JScrollPane(tabla);
	private JFrame app;

	private JDialog dialog;
	private JButton aceptarDialog;
	private JButton cancelarDialog;	
	private JTextField editDialog;

	private JDialog dialogPorts;
	private JButton aceptarDlgPort;
	private JButton cancelarDlgPort;
	private JTextField dirPort;
	private JTextField valorPort;
	private JLabel labelPort;
	
	private JDialog dialogBreak;
	private JButton aceptarDlgBreak;
	private JButton cancelarDlgBreak;
	private JTextField dirBreak;

	private File fichero;
	private MotorDebugger motor=null;
	
	private int[] oldPuertos, oldReg;
	private int oldPC;
	private long oldCont;
	private boolean oldZero, oldCarry, oldInt;
	public PanelDepuracion(JFrame app){
		super(new BorderLayout());
		this.app = app;
		puertos.setEditable(false);
		dialogSteps();
		dialogPuertos();
		dialogBreak();
		
		StyledDocument doc = desensamblado.getStyledDocument();
		Style def = StyleContext.getDefaultStyleContext().getStyle(StyleContext.DEFAULT_STYLE);
		StyleConstants.setFontFamily(def, "Courier");
		doc.addStyle("normal", def);
		def = doc.addStyle("bold", def);
		StyleConstants.setBold(def, true);
		def = doc.addStyle("boldYitalic",def);
		StyleConstants.setItalic(def, true);
		StyleConstants.setBackground(def,Color.LIGHT_GRAY);
		def = doc.addStyle("italic",def);
		StyleConstants.setBackground(def,Color.LIGHT_GRAY);
		StyleConstants.setBold(def, false);
		
		doc = puertos.getStyledDocument();
		def = StyleContext.getDefaultStyleContext().getStyle(StyleContext.DEFAULT_STYLE);
		StyleConstants.setFontFamily(def, "Courier");
		doc.addStyle("normal", def);
		def = doc.addStyle("rojo", def);
		StyleConstants.setBold(def, true);
		StyleConstants.setForeground(def, Color.RED);
		
		JSplitPane panelVert = new JSplitPane(JSplitPane.HORIZONTAL_SPLIT, true);
		panelVert.setDividerLocation((int)(Toolkit.getDefaultToolkit().getScreenSize().width*0.65));
		panelVert.setLeftComponent(scrollDes);
		panelVert.setRightComponent(scrollTabla);

		JSplitPane panelHor = new JSplitPane(JSplitPane.VERTICAL_SPLIT, true);
		panelHor.setLeftComponent(panelVert);
		panelHor.setRightComponent(scrollPuertos);
		panelHor.setDividerLocation((int)(Toolkit.getDefaultToolkit().getScreenSize().height*0.65));
		this.add(panelHor,BorderLayout.CENTER);

		desensamblado.setFont(Font.decode("Courier-PLAIN-12"));
		puertos.setFont(Font.decode("Courier-PLAIN-12"));
		this.repaint();
	}
	
	private void dialogSteps(){
		dialog = new JDialog(app,"Steps", true);
		dialog.setResizable(false);
		JPanel panel = new JPanel(new BorderLayout());
		JPanel panelB = new JPanel();
		JPanel panelEdit = new JPanel();

		aceptarDialog = new JButton("Aceptar");
		aceptarDialog.addActionListener(new EventosSteps(this));

		cancelarDialog = new JButton("Cancelar");
		cancelarDialog.addActionListener(new EventosSteps(this));

		editDialog = new JTextField(30);
		editDialog.setText("1");
		
		panelB.add(aceptarDialog,BorderLayout.WEST);
		panelB.add(cancelarDialog,BorderLayout.EAST);
		
		panel.add(panelB,BorderLayout.SOUTH);
		
		panelEdit.add(new JLabel("Número de pasos"));
		panelEdit.add(editDialog);
		panel.add(panelEdit,BorderLayout.CENTER);

		dialog.setContentPane(panel);
		
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
		
		editDialog.addActionListener(new EventosSteps(this));
		
		aceptarDialog.addKeyListener(editDialog.getKeyListeners()[0]);
		cancelarDialog.addKeyListener(editDialog.getKeyListeners()[0]);
		dialog.addKeyListener(editDialog.getKeyListeners()[0]);
		dialog.pack();
	}
	
	private void dialogPuertos(){
		dialogPorts = new JDialog(app,"Puertos", true);
		dialogPorts.setResizable(false);
		JPanel panel = new JPanel(new BorderLayout());
		JPanel panelB = new JPanel();
		JPanel panelEdit = new JPanel();

		aceptarDlgPort = new JButton("Aceptar");
		aceptarDlgPort.addActionListener(new EventosPorts(this));

		cancelarDlgPort= new JButton("Cerrar");
		cancelarDlgPort.addActionListener(new EventosPorts(this));

		dirPort = new JTextField(10);
		dirPort.setText("0");
		dirPort.addActionListener(new EventosPorts(this));
		
		valorPort = new JTextField(10);
		valorPort.setText("0");
		valorPort.addActionListener(new EventosPorts(this));
		
		panelB.add(aceptarDlgPort);
		panelB.add(cancelarDlgPort);
		
		panel.add(panelB,BorderLayout.SOUTH);
		
		labelPort = new JLabel();
		labelPort.setForeground(Color.RED);

		panelEdit.add(new JLabel("Dirección"));
		panelEdit.add(dirPort);
		panelEdit.add(new JLabel("Valor"));
		panelEdit.add(valorPort);
		panelEdit.add(labelPort);
		panel.add(panelEdit,BorderLayout.CENTER);

		dialogPorts.setContentPane(panel);
		
		Dimension d = Toolkit.getDefaultToolkit().getScreenSize();
		dialogPorts.setLocation((int)(d.width*0.3),(int)(d.height*0.4));
		
		dirPort.addKeyListener(new KeyListener()
		{
			public void keyTyped(KeyEvent arg0) {}
			public void keyPressed(KeyEvent arg0) {
				if(arg0.getKeyCode()==KeyEvent.VK_ESCAPE)
				dialogPorts.setVisible(false);
			}
			public void keyReleased(KeyEvent arg0) {}
		});
		
		aceptarDlgPort.addKeyListener(dirPort.getKeyListeners()[0]);
		cancelarDlgPort.addKeyListener(dirPort.getKeyListeners()[0]);
		valorPort.addKeyListener(dirPort.getKeyListeners()[0]);
		dialogPorts.addKeyListener(dirPort.getKeyListeners()[0]);
		dialogPorts.pack();
		dialogPorts.setSize(dialogPorts.getSize().width,dialogPorts.getSize().height+20);
	}
	
	private void dialogBreak(){
		dialogBreak = new JDialog(app,"Breakpoint", true);
		dialogBreak.setResizable(false);
		JPanel panel = new JPanel(new BorderLayout());
		JPanel panelB = new JPanel();
		JPanel panelEdit = new JPanel();

		aceptarDlgBreak = new JButton("Aceptar");
		aceptarDlgBreak.addActionListener(new EventosBreak(this));

		cancelarDlgBreak= new JButton("Cancelar");
		cancelarDlgBreak.addActionListener(new EventosBreak(this));

		dirBreak = new JTextField(10);
		dirBreak.setText("0");
		dirBreak.addActionListener(new EventosBreak(this));
		
		panelB.add(aceptarDlgBreak);
		panelB.add(cancelarDlgBreak);
		
		panel.add(panelB,BorderLayout.SOUTH);
		
		panelEdit.add(new JLabel("Dirección"));
		panelEdit.add(dirBreak);
		panel.add(panelEdit,BorderLayout.CENTER);

		dialogBreak.setContentPane(panel);
		
		Dimension d = Toolkit.getDefaultToolkit().getScreenSize();
		dialogBreak.setLocation((int)(d.width*0.3),(int)(d.height*0.4));
		
		dirBreak.addKeyListener(new KeyListener()
		{
			public void keyTyped(KeyEvent arg0) {}
			public void keyPressed(KeyEvent arg0) {
				if(arg0.getKeyCode()==KeyEvent.VK_ESCAPE)
				dialogBreak.setVisible(false);
			}
			public void keyReleased(KeyEvent arg0) {}
		});
		
		aceptarDlgBreak.addKeyListener(dirBreak.getKeyListeners()[0]);
		cancelarDlgBreak.addKeyListener(dirBreak.getKeyListeners()[0]);
		dialogBreak.addKeyListener(dirBreak.getKeyListeners()[0]);
		dialogBreak.pack();
	}

	public void setFichero(File f){
		String ruta = f.getAbsolutePath();
		int temp = ruta.lastIndexOf(".");
		ruta = ruta.substring(0, temp).concat(".bin");
		
		this.fichero = new File(ruta);
		if(this.fichero.exists())
		{		
			try {
				motor=new MotorDebugger(this.fichero);
			} catch (IOException e) {
				JOptionPane.showMessageDialog(app,"Error de E/S con el fichero"+ f.getAbsolutePath() +".","Error",JOptionPane.ERROR_MESSAGE);
			}
			oldPuertos = new int[motor.getPortSize()];
			oldReg = new int[motor.getRegSize()];
			setOld();
			recrear();
		}
	}
	
	public void recrear(){
		tabla.setModel(new ModeloTabla(motor, this));
		tabla.setDefaultRenderer(String.class, new Render(motor, this));
		this.actualizar();
	}
	
	public void actualizar(){
		((ModeloTabla)tabla.getModel()).fireTableDataChanged();
		this.escribirDesensamblado();
		this.escribirPuertos();	
	}
	
	private void escribirPuertos(){
		StyledDocument doc = puertos.getStyledDocument();
		puertos.setText("");
		try {
			doc.insertString(0,"00\t",doc.getStyle("normal"));
		} catch (BadLocationException e1) {}
		int [] newPuertos = motor.getPortsArray();
		for(int i=0;i<motor.getPortSize();i++)
		{
			String temp = Integer.toHexString(motor.getPort(i)).toUpperCase();
			if (temp.length()==1) temp = "0"+temp;
			try {
				if(i%16==0 && i!=0)
					doc.insertString(doc.getLength(),"\n"+Integer.toHexString(i).toUpperCase()+"\t"+temp+", ", doc.getStyle(oldPuertos[i]!=newPuertos[i]?"rojo":"normal"));
				else
					doc.insertString(doc.getLength(),temp+", ", doc.getStyle(oldPuertos[i]!=newPuertos[i]?"rojo":"normal"));
			} catch (BadLocationException e) {e.printStackTrace();}
		}
		puertos.setCaretPosition(0);
	}
	
	public void setPuerto(){
		labelPort.setVisible(false);
		dialogPorts.setVisible(true);
	}
	
	private void escribirDesensamblado(){
		desensamblado.setText("");
		StyledDocument doc = desensamblado.getStyledDocument();
		String temp;
		try {
			for(int i = 0;i<motor.getNumInstr();i++)
			{
				temp = (i<16? "0" : "" ) + Integer.toHexString(i);
				if(motor.getPC() == i)
					if(motor.isBreakpoint(i))
						doc.insertString(doc.getLength(), temp.toUpperCase()+"    "+motor.getInstrString(i)+"\n",doc.getStyle("boldYitalic"));			
					else
						doc.insertString(doc.getLength(), temp.toUpperCase()+"    "+motor.getInstrString(i)+"\n",doc.getStyle("bold"));			
				else if(motor.isBreakpoint(i))
					doc.insertString(doc.getLength(), temp.toUpperCase()+"    "+motor.getInstrString(i)+"\n", doc.getStyle("italic"));
				else
					doc.insertString(doc.getLength(), temp.toUpperCase()+"    "+motor.getInstrString(i)+"\n", doc.getStyle("normal"));
			}
				desensamblado.setCaretPosition(doc.getDefaultRootElement().getElement(motor.getPC()).getStartOffset());
		} catch (BadLocationException e) {}
			
	}

	private boolean isMotorNotNull()
	{
		if (motor==null)
			JOptionPane.showMessageDialog(app,"Debe compilar primero el proyecto.","Error",JOptionPane.ERROR_MESSAGE);
		return !(motor==null);
	}

	public void setOld(){
		for(int i=0; i<oldPuertos.length;i++){
			if(i<oldReg.length) oldReg[i]=motor.getReg(i); 
			oldPuertos[i] = motor.getPort(i); 
		}
		oldZero = motor.getZero();
		oldCarry = motor.getCarry();
		oldInt = motor.getInt();
		oldPC = motor.getPC();
		oldCont = motor.getContador();
	}
	
	public int getOldPC(){
		return oldPC;
	}
	
	public int[] getOldReg(){
		return oldReg;
	}
	
	public boolean getOldZero(){
		return oldZero;
	}
	
	public boolean getOldCarry(){
		return oldCarry;
	}
	
	public boolean getOldInt(){
		return oldInt;
	}
	
	public long getOldCont(){
		return oldCont;
	}
	
	public void step() {
		if(isMotorNotNull())
		{
			setOld();
			try {
				paso();
			} catch (ExecutionException e) {
				if(e.getType() == ExecutionException.EXEC)
					JOptionPane.showMessageDialog(app,"Se ha intentado ejecutar una instrucción por encima de la longitud de programa.","Error",JOptionPane.ERROR_MESSAGE);
				else if(e.getType() == ExecutionException.STACK)
					JOptionPane.showMessageDialog(app,"Se ha sobrepasado la pila de subrutinas.","Error",JOptionPane.ERROR_MESSAGE);
				else if (e.getType() == ExecutionException.INVALID)
					JOptionPane.showMessageDialog(app,"Instrucción invalida.","Error",JOptionPane.ERROR_MESSAGE);
			} 
			this.actualizar();
		}
	}
	
	private void paso() throws ExecutionException
	{
		motor.step(); 
	}

	public void steps() {
		if (isMotorNotNull()) 
		{
			dialog.setVisible(true);
		}
	}
	
	public void breakpoint(){
		if(isMotorNotNull()){
			dialogBreak.setVisible(true);
		}
	}
	
	public void exeSteps(int i){
		setOld();
		try{
			for(int j=0;j<i;j++){
				paso();
				if(motor.isPCBreakpoint()) break;
			}
		}catch(ExecutionException e)
		{
			if(e.getType() == ExecutionException.EXEC)
				JOptionPane.showMessageDialog(app,"Se ha intentado ejecutar una instrucción por encima de la longitud de programa.","Error",JOptionPane.ERROR_MESSAGE);
			else if(e.getType() == ExecutionException.STACK)
				JOptionPane.showMessageDialog(app,"Se ha sobrepasado la pila de subrutinas.","Error",JOptionPane.ERROR_MESSAGE);
			else if (e.getType() == ExecutionException.INVALID)
				JOptionPane.showMessageDialog(app,"Instrucción invalida.","Error",JOptionPane.ERROR_MESSAGE);
		}
		actualizar();
	}
	
	class EventosPorts implements ActionListener{
		PanelDepuracion pd;
		
		public EventosPorts(PanelDepuracion pd){
			this.pd = pd;
		}
		
		public void actionPerformed(ActionEvent arg0) {
			if (arg0.getSource()==aceptarDlgPort || arg0.getSource() == dirPort || arg0.getSource() == valorPort){
				try{
					int i = Integer.parseInt(dirPort.getText(), 16);
					int j = Integer.parseInt(valorPort.getText(), 16);
					if(i>=0 && i< motor.getPortSize() && j>=0 && j<256){
						motor.setPort(i,j);
						labelPort.setText("Puerto "+Integer.toHexString(i).toUpperCase()+" modificado");
						labelPort.setVisible(true);
						pd.actualizar();
					}
				}catch(NumberFormatException nfe){}
			}
			else dialogPorts.setVisible(false);
		}
	}

	class EventosBreak implements ActionListener{
		PanelDepuracion pd;
		public EventosBreak(PanelDepuracion p){
			pd = p;	
		}

		public void actionPerformed(ActionEvent arg0) {
			if(arg0.getSource() == aceptarDlgBreak || arg0.getSource() == dirBreak)
			{
				int i = Integer.parseInt(dirBreak.getText(), 16);
				if(i>=0 || i<256)
				{
					motor.setBreakpoint(i, !motor.isBreakpoint(i));
					pd.actualizar();
				}
				dialogBreak.setVisible(false);
			}
			else if(arg0.getSource() == cancelarDlgBreak)
				dialogBreak.setVisible(false);
		}
	}
	
	class EventosSteps implements ActionListener{
		PanelDepuracion pd;
		public EventosSteps(PanelDepuracion p){
			pd = p;
		}

		public void actionPerformed(ActionEvent arg0) {
			if (arg0.getSource()==aceptarDialog || arg0.getSource() == editDialog){
				try{
					int i = Integer.parseInt(editDialog.getText());
					if(i>0)
						pd.exeSteps(i); 
				}catch(NumberFormatException nfe){}
			}
			dialog.setVisible(false);
		}
	}

	public void reset() {
		motor.reset();
		this.actualizar();
	}
}

class ModeloTabla extends AbstractTableModel{
	//TODO REPASAR TABLA!
	private MotorDebugger motor;
	private PanelDepuracion pd;
	
	private int posPC;
	private int posZero;
	private int posCarry;
	private int posInt;
	private int posCont;
	
	public ModeloTabla(MotorDebugger motor, PanelDepuracion pd){
		this.pd = pd;
		this.motor=motor;
		posPC = motor.getRegSize();
		posZero = motor.getRegSize()+1;
		posCarry = motor.getRegSize()+2;
		posInt = motor.getRegSize()+3;
		posCont = motor.getRegSize()+4;
	}

	public int getRowCount() {
		return motor.getRegSize()+5;
	}

	public int getColumnCount() {
		return 2;
	}
	
	public Class getColumnClass(int column){
		return String.class;
	}

	public String getColumnName(int column){
		return (column==0? "Nombre": "Valor");
	}
	
	public Object getValueAt(int row, int column) {
		switch(column){
			case 0: 
				if(row == posPC) return "PC";
				else if(row == posZero) return "Zero";
				else if(row ==posCarry) return "Carry";
				else if(row == posInt) return "Interrupciones activadas";
				else if(row == posCont) return "Contador ciclos reloj";
				else return motor.getRegName(row);
			case 1: 
				if(row == posPC) 
				{
					String temp = Integer.toHexString(motor.getPC()).toUpperCase(); 
					return (temp.length()==1? "0": "")+temp;
				}
				else if(row == posZero) return String.valueOf(motor.getZero()?"1":"0");
				else if(row ==posCarry) return String.valueOf(motor.getCarry()?"1":"0");
				else if(row == posInt) return String.valueOf(motor.getInt()?"1":"0");
				else if(row == posCont) return String.valueOf(motor.getContador());
				else 
				{
					String temp = Integer.toHexString(motor.getReg(row)).toUpperCase();
					return (temp.length()==1? "0": "")+temp;
				}
		}
		return null;
	}
	
	public boolean isCellEditable(int row, int column){
		if (column==1) return true;
		else if(row<motor.getRegSize()) return true;
		else return false;
	}
	
	public void setValueAt(Object valor, int row, int column){
		switch(column){
			case 0:
			if(row<motor.getRegSize()){
				PicoInstruccion.setRegName(row, (String)valor);
				motor.reconstruir();
				pd.actualizar();
			}
			break;
			case 1: 
			if(row<=motor.getRegSize()){
				try{
					int a = Integer.parseInt((String)valor,16);
					if(a>=0&a<256)
					{ 				
						if(row == posPC){
							motor.setPC(Integer.parseInt((String)valor,16));
							pd.actualizar();
						}
						else
							motor.setReg(row,Integer.parseInt((String)valor,16));
					}					
				}catch(NumberFormatException NFE){}
			}

			else if(row<posCont){
				if( ((String)valor).equals("1") )
				{
					if(row==posZero) motor.setZero(true);
					else if(row==posCarry) motor.setCarry(true);
					else motor.setInt(true);
				}
				else if( ((String)valor).equals("0") )
				{
					if(row==posZero) motor.setZero(false);
					else if(row==posCarry) motor.setCarry(false);
					else motor.setInt(false);
				}
			}
			else{
				try{
					long a = Long.parseLong((String) valor);
					if(a>=0) motor.setContador(a);
				}catch(NumberFormatException nfe){}				
			}
			
			this.fireTableDataChanged();
			break;
		}
	}	
}

class Render extends JLabel implements TableCellRenderer{
	MotorDebugger motor;
	PanelDepuracion pd;
	
	private int posPC;
	private int posZero;
	private int posCarry;
	private int posInt;
	private int posCont;

	public Render(MotorDebugger motor, PanelDepuracion pd)
	{
		super();
		this.motor = motor;
		this.pd = pd;
		
		posPC = motor.getRegSize();
		posZero = motor.getRegSize()+1;
		posCarry = motor.getRegSize()+2;
		posInt = motor.getRegSize()+3;
		posCont = motor.getRegSize()+4;
	}
	
	public Component getTableCellRendererComponent(JTable tabla, Object str, boolean isSelected, boolean hasFocus, int row, int column) {		
		if(column==1)
		{
			if(row == posPC) setForeground(pd.getOldPC() == motor.getPC()?Color.BLACK:Color.RED);
			else if(row == posZero) setForeground(pd.getOldZero() == motor.getZero()?Color.BLACK:Color.RED);
			else if(row == posCarry) setForeground(pd.getOldCarry() == motor.getCarry()?Color.BLACK:Color.RED);
			else if(row == posInt) setForeground(pd.getOldInt() == motor.getInt()?Color.BLACK:Color.RED);
			else if(row == posCont) setForeground(pd.getOldCont() == motor.getContador()?Color.BLACK:Color.RED);
			else setForeground(pd.getOldReg()[row] == motor.getReg(row)?Color.BLACK:Color.RED);
		}
		else setForeground(Color.BLACK);
		setText((String) str);
		return this;
	}
}