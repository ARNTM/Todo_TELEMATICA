/**
 * 
 * @author aruznieto
 */

package game;

import java.awt.BorderLayout;
import java.awt.EventQueue;

import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.border.EmptyBorder;
import javax.swing.JLabel;
import java.awt.Font;
import javax.swing.SwingConstants;
import javax.swing.JComboBox;
import javax.swing.DefaultComboBoxModel;
import javax.swing.JButton;
import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;
import javax.swing.JTextPane;
import java.awt.Color;
import java.awt.SystemColor;

public class MenuPrincipal extends JFrame {

	private JPanel contentPane;
	public int activaMusica;

	/**
	 * Launch the application.
	 */
	public static void main(String[] args) {
		EventQueue.invokeLater(new Runnable() {
			public void run() {
				try {
					MenuPrincipal frame = new MenuPrincipal();
					frame.setVisible(true);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		});
	}

	/**
	 * Create the frame.
	 */
	public MenuPrincipal() {
		setResizable(false);
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setBounds(100, 100, 450, 300);
		contentPane = new JPanel();
		contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));
		contentPane.setLayout(new BorderLayout(0, 0));
		setContentPane(contentPane);
		
		JPanel panel = new JPanel();
		contentPane.add(panel, BorderLayout.NORTH);
		panel.setLayout(new BorderLayout(0, 0));
		
		JLabel lblBienvenidoAlJuego = new JLabel("BIENVENIDO AL JUEGO");
		lblBienvenidoAlJuego.setHorizontalAlignment(SwingConstants.CENTER);
		lblBienvenidoAlJuego.setFont(new Font("Arial Black", Font.PLAIN, 18));
		panel.add(lblBienvenidoAlJuego, BorderLayout.NORTH);
		
		JLabel lblSeleccionaLosParmetros = new JLabel("Selecciona los parámetros de inicio.");
		lblSeleccionaLosParmetros.setHorizontalAlignment(SwingConstants.CENTER);
		panel.add(lblSeleccionaLosParmetros, BorderLayout.SOUTH);
		
		JPanel panel_1 = new JPanel();
		contentPane.add(panel_1, BorderLayout.CENTER);
		panel_1.setLayout(null);
		
		JLabel lblSeleccionaElTamao = new JLabel("Tamaño:");
		lblSeleccionaElTamao.setBounds(37, 23, 115, 14);
		panel_1.add(lblSeleccionaElTamao);
		
		final JComboBox tamanio = new JComboBox();
		tamanio.setModel(new DefaultComboBoxModel(new String[] {"6x6", "8x8", "10x10", "12x12", "16x16", "20x20"}));
		tamanio.setBounds(107, 20, 100, 20);
		panel_1.add(tamanio);
		
		JButton btnSalir = new JButton("SALIR");
		btnSalir.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				System.exit(0);
			}
		});
		btnSalir.setBounds(325, 177, 89, 23);
		panel_1.add(btnSalir);
		
		JButton btnJugar = new JButton("JUGAR");
		btnJugar.setBounds(226, 177, 89, 23);
		panel_1.add(btnJugar);
		
		JLabel lblVistas = new JLabel("Vistas:");
		lblVistas.setBounds(37, 58, 115, 14);
		panel_1.add(lblVistas);
		
		final JComboBox vistas = new JComboBox();
		vistas.setModel(new DefaultComboBoxModel(new String[] {"Iconos", "Colores", "Geométrica"}));
		vistas.setBounds(107, 55, 100, 20);
		panel_1.add(vistas);
		
		JLabel lblAutomtico = new JLabel("Automático:");
		lblAutomtico.setBounds(37, 90, 115, 14);
		panel_1.add(lblAutomtico);
		
		final JComboBox auto = new JComboBox();
		auto.setModel(new DefaultComboBoxModel(new String[] {"Sí", "No"}));
		auto.setBounds(107, 87, 100, 20);
		panel_1.add(auto);
		
		JLabel lblAndrsRuz = new JLabel("© Andrés Ruz Nieto");
		lblAndrsRuz.setBounds(0, 197, 121, 14);
		panel_1.add(lblAndrsRuz);
		
		JTextPane txtpnSeleccionaLos = new JTextPane();
		txtpnSeleccionaLos.setEditable(false);
		txtpnSeleccionaLos.setBackground(SystemColor.menu);
		txtpnSeleccionaLos.setText("- Selecciona los paramétros\r\nque desees.\r\n- Pulsa sobre JUGAR.\r\n- Una vez dentro, con la barra\r\nespaciadora podrás parar y \r\nreanudar el juego.\r\n- En el menú ARCHIVO, podrás\r\ncargar y guardar tu partida.");
		txtpnSeleccionaLos.setBounds(218, 37, 176, 118);
		panel_1.add(txtpnSeleccionaLos);
		
		JLabel lblcmoSeJuega = new JLabel("¿Cómo se juega?");
		lblcmoSeJuega.setFont(new Font("Arial Black", Font.PLAIN, 11));
		lblcmoSeJuega.setBounds(241, 20, 108, 14);
		panel_1.add(lblcmoSeJuega);
		
		btnJugar.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				
				
				String vistasGame = vistas.getSelectedItem().toString();
				if(vistasGame.equals("Iconos")) {
					GameCanvas.setVistas(2);
				}
				else if(vistasGame.equals("Colores")) {
					GameCanvas.setVistas(1);
				}
				else if(vistasGame.equals("Geométrica")) {
					GameCanvas.setVistas(3);
				}
				
				int tamanioCuad = tamanio.getSelectedIndex();
				int autoCuad = auto.getSelectedIndex();
				
				switch(tamanioCuad) {
					case 0:
						try {
							if(autoCuad==0) {Game gui = new Game(480/6,1);}
							else {Game gui = new Game(480/6,0);}
							dispose();
						} catch (Exception e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
						break;
					case 1:
						try {
							if(autoCuad==0) {Game gui = new Game(480/8,1);}
							else {Game gui = new Game(480/8,0);}
							dispose();
						} catch (Exception e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
						break;
					case 2:
						try {
							if(autoCuad==0) {Game gui = new Game(480/10,1);}
							else {Game gui = new Game(480/10,0);}
							dispose();
						} catch (Exception e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
						break;
					case 3:
						try {
							if(autoCuad==0) {Game gui = new Game(480/12,1);}
							else {Game gui = new Game(480/12,0);}
							dispose();
						} catch (Exception e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
						break;
					case 4:
						try {
							if(autoCuad==0) {Game gui = new Game(480/16,1);}
							else {Game gui = new Game(480/16,0);}
							dispose();
						} catch (Exception e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
						break;
					case 5:
						try {
							if(autoCuad==0) {Game gui = new Game(480/20,1);}
							else {Game gui = new Game(480/20,0);}
							dispose();
						} catch (Exception e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
						break;
					default:
						try {
							if(autoCuad==0) {Game gui = new Game(480/12,1);}
							else {Game gui = new Game(480/12,0);}
							dispose();
						} catch (Exception e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
				}
			}
		});
	}

}
