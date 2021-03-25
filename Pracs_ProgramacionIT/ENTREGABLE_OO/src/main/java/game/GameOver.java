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
import javax.sound.sampled.AudioSystem;
import javax.sound.sampled.Clip;
import javax.sound.sampled.LineUnavailableException;
import javax.sound.sampled.UnsupportedAudioFileException;
import javax.swing.JButton;
import java.awt.event.ActionListener;
import java.io.File;
import java.io.IOException;
import java.awt.event.ActionEvent;

public class GameOver extends JFrame {

	private JPanel contentPane;
	
	Clip gameover;

	/**
	 * Launch the application.
	 */
	public static void main(String[] args) {
		EventQueue.invokeLater(new Runnable() {
			public void run() {
				try {
					GameOver frame = new GameOver(0,0);
					frame.setVisible(true);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		});
	}

	/**
	 * Create the frame.
	 * @throws LineUnavailableException 
	 * @throws UnsupportedAudioFileException 
	 * @throws IOException 
	 */
	public GameOver(int puntosrh, int pantalla) throws LineUnavailableException, IOException, UnsupportedAudioFileException {
		
    	gameover = AudioSystem.getClip();
    	gameover.open(AudioSystem.getAudioInputStream(new File("src/main/resources/sounds/gameover.wav")));
    	
    	gameover.setFramePosition(0);
    	gameover.start();
    	
		
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setBounds(100, 100, 450, 300);
		contentPane = new JPanel();
		contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));
		contentPane.setLayout(new BorderLayout(0, 0));
		setContentPane(contentPane);
		
		JLabel lblGameOver = new JLabel("GAME OVER");
		lblGameOver.setHorizontalAlignment(SwingConstants.CENTER);
		lblGameOver.setFont(new Font("Arial Black", Font.PLAIN, 20));
		contentPane.add(lblGameOver, BorderLayout.NORTH);
		
		JPanel panel = new JPanel();
		contentPane.add(panel, BorderLayout.CENTER);
		panel.setLayout(null);
		
		
		
		JButton btnReiniciar = new JButton("REINICIAR");
		btnReiniciar.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				MenuPrincipal m = new MenuPrincipal();
				m.setVisible(true);
				dispose();
			}
		});
		btnReiniciar.setBounds(194, 191, 121, 23);
		panel.add(btnReiniciar);
		
		JButton btnSalir = new JButton("SALIR");
		btnSalir.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				System.exit(0);
			}
		});
		btnSalir.setBounds(325, 191, 89, 23);
		panel.add(btnSalir);
		JLabel lblNewLabel = new JLabel("Puntos: " + puntosrh);
		lblNewLabel.setHorizontalAlignment(SwingConstants.CENTER);
		lblNewLabel.setFont(new Font("Arial Black", Font.PLAIN, 14));
		lblNewLabel.setBounds(0, 11, 424, 33);
		panel.add(lblNewLabel);
		
		JLabel lblPantalla = new JLabel("Pantalla: " + pantalla);
		lblPantalla.setHorizontalAlignment(SwingConstants.CENTER);
		lblPantalla.setFont(new Font("Arial Black", Font.PLAIN, 14));
		lblPantalla.setBounds(0, 45, 424, 33);
		panel.add(lblPantalla);
		
		JLabel lblAndrsRuz = new JLabel("© Andrés Ruz Nieto");
		lblAndrsRuz.setBounds(0, 197, 121, 14);
		panel.add(lblAndrsRuz);
		
		JLabel lblgraciasPorJugar = new JLabel("¡GRACIAS POR JUGAR!");
		lblgraciasPorJugar.setHorizontalAlignment(SwingConstants.CENTER);
		lblgraciasPorJugar.setFont(new Font("Arial Black", Font.PLAIN, 20));
		lblgraciasPorJugar.setBounds(0, 118, 424, 23);
		panel.add(lblgraciasPorJugar);
	}
}
