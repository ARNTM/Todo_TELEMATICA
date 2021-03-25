/*
	Panel del editor
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
import java.awt.Font;
import java.awt.Toolkit;
import java.awt.event.KeyAdapter;
import java.awt.event.KeyEvent;
import java.awt.event.KeyListener;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.io.OutputStream;

import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JSplitPane;
import javax.swing.JTextArea;
import javax.swing.event.UndoableEditEvent;
import javax.swing.event.UndoableEditListener;
import javax.swing.text.BadLocationException;
import javax.swing.undo.UndoManager;

public class PanelDesarrollo extends JPanel implements KeyListener, UndoableEditListener{
	private JTextArea consola = new JTextArea(15, 50);
	private JTextArea texto = new JTextArea(400, 400);
	private JScrollPane scrollConsola = new JScrollPane(consola);
	private JScrollPane scrollTexto = new JScrollPane(texto);
	private JFrame app;
	private boolean ficheroEditado;
	private static UndoManager undo;
	private JLabel noLinea = new JLabel("Linea 1 : Columna 0");

	public PanelDesarrollo(JFrame app) {
		super(new BorderLayout());
		this.app = app;
		ficheroEditado=false;
		JSplitPane panel = new JSplitPane(JSplitPane.VERTICAL_SPLIT, true);
		panel.setLeftComponent(scrollTexto);
		panel.setDividerLocation((int)(Toolkit.getDefaultToolkit().getScreenSize().height*0.65));
		panel.setRightComponent(scrollConsola);
		this.add(panel, BorderLayout.CENTER);
		this.add(noLinea,BorderLayout.SOUTH);
		texto.setFont(Font.decode("Courier-PLAIN-12"));
		texto.addKeyListener(new KeyAdapter()
		{
			public void keyTyped(KeyEvent ke) {
				if(ke.getKeyChar() =='\n')
				{
					try {
						int i=texto.getLineStartOffset(texto.getLineOfOffset(texto.getCaretPosition()-1));
						int j=i;
						String s ="";
						String temp ="";
						while( (s=texto.getText(j++,1)).equals(" ") || s.equals("\t"))
							temp = temp+s;
						texto.insert(temp,texto.getCaretPosition());
					} catch (BadLocationException e) {
						e.printStackTrace();
					}
				}
			}

			public void keyPressed(KeyEvent arg0) {
			}

		});
		texto.addMouseListener(new MouseAdapter(){
			public void mouseClicked(MouseEvent me){
				try {
					int pos = texto.getCaretPosition();
					int linea = texto.getLineOfOffset(pos);
					int posRel = texto.getLineStartOffset(linea);
					noLinea.setText("Linea "+(linea+1)+" : Columna "+(pos-posRel));
				} catch (BadLocationException e) {}		
			}
		});
		consola.setFont(Font.decode("Courier-PLAIN-12"));
		this.nuevo();

		texto.addKeyListener(this);
		texto.getDocument().addUndoableEditListener(this);
		this.repaint();
	}
	
	public void setOutputStream(OutputStream os){
	}
	
	public void nuevo(){
		texto.setText("");
		ficheroEditado=false;
		app.setTitle("PicoIDE v 1.0 - Sin Título");
		this.limpiarConsola();
		noLinea.setText("Linea 1 : Columna 0");
		undo = new UndoManager();
	}
	
	public void abrir(String a, String nombref){
		this.setTexto(a);
		this.setTextoEditado(false);
		app.setTitle("PicoIDE v 1.0 - "+nombref);
		this.limpiarConsola();
		undo.discardAllEdits();
	}
	
	public void deshacer(){
		if (undo.canUndo()){
			undo.undo();
		}
	}
	
	public void rehacer(){
		if(undo.canRedo()) {
			undo.redo();
		}
	}
	
	public void copiar(){
		texto.copy();
	}
	
	public void cortar(){
		texto.cut();
	}
	
	public void pegar(){
		texto.paste();
	}
	
	public void setConsola(String S){
		consola.setText(S);
	}
	
	public void addConsola(String S){
		consola.append(S);
	}
	
	public void limpiarConsola(){
		consola.setText("");
	}
	
	public String getTexto(){
		return texto.getText();
	}
	
	public boolean isTextoEditado(){
		return ficheroEditado;
	}
	
	public void setTextoEditado(boolean b){
		ficheroEditado=b;
	}
	
	public void setTexto(String a){
		texto.setText(a);
		texto.setCaretPosition(0);
	}
	
	public void keyTyped(KeyEvent arg0) {
		if(!ficheroEditado){
			app.setTitle(app.getTitle()+"*");
			ficheroEditado=true;
		}		
	}

	public void keyPressed(KeyEvent arg0) {
		try {
			int pos = ((JTextArea)arg0.getSource()).getCaretPosition();
			int linea = ((JTextArea)arg0.getSource()).getLineOfOffset(pos);
			int posRel = ((JTextArea)arg0.getSource()).getLineStartOffset(linea);
			noLinea.setText("Linea "+(linea+1)+" : Columna "+(pos-posRel));
		} catch (BadLocationException e) {}		
	}

	public void keyReleased(KeyEvent arg0) {
		try {
			int pos = ((JTextArea)arg0.getSource()).getCaretPosition();
			int linea = ((JTextArea)arg0.getSource()).getLineOfOffset(pos);
			int posRel = ((JTextArea)arg0.getSource()).getLineStartOffset(linea);
			noLinea.setText("Linea "+(linea+1)+" : Columna "+(pos-posRel));
		} catch (BadLocationException e) {}		
	}

	public void undoableEditHappened(UndoableEditEvent arg0) {
		undo.addEdit(arg0.getEdit());
	}
}

