/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package common;

import java.io.*;

/**
 *
 * @author japf
 */
public class KeyBoard {
    
    	public static final byte 	BYTE_ERR 	=	Byte.MAX_VALUE;
	public static final short 	SHORT_ERR 	= 	Short.MAX_VALUE;
	public static final int 	INT_ERR 	=	Integer.MAX_VALUE;
	public static final double 	DOUBLE_ERR 	= 	Double.MAX_VALUE;
	public static final float  	FLOAT_ERR 	= 	Float.MAX_VALUE;
	public static final char  	CHAR_ERR 	= 	Character.MAX_VALUE;
	public static final String	STRING_ERR 	= 	null;


	/** 
	 *  Método que lee una línea de teclado y devuelve el <code><b>byte</b></code> escrito por el usuario. 
	 *  @return Devuelve el <code><b>byte</b></code> introducido por el usuario o <code><b>KeyBoard.BYTE_ERR</b></code> si no se introdujo un byte.
	 */
	public static byte readByte () {
		byte val=BYTE_ERR;
		try	{
			BufferedReader in = new BufferedReader (new InputStreamReader (System.in));
			val = Byte.parseByte (in.readLine());
		} catch (IOException ioe) {
			System.out.println (">> Excepción (readLnByte): Imposible leer línea");
		} catch (NumberFormatException nfe) {
			System.out.println (">> Excepción (readLnByte): Valor introducido no byte");
		} catch (Exception e) {
			System.out.println (">> Excepción (readLnByte): Ocurrió una excepción");
		}
		return val;
	}

	/** 
	 *  Método que lee una línea de teclado y devuelve el <code><b>short</b></code> escrito por el usuario. 
	 *  @return Devuelve el <code><b>short</b></code> introducido por el usuario o <code><b>KeyBoard.SHORT_ERR</b></code> si no se introdujo un byte.
	 */
	public static short readShort () {
		short val=SHORT_ERR;
		try	{
			BufferedReader in = new BufferedReader (new InputStreamReader (System.in));
			val = Short.parseShort (in.readLine());
		} catch (IOException ioe) {
			System.out.println (">> Excepción (readLnShort): Imposible leer línea");
		} catch (NumberFormatException nfe) {
			System.out.println (">> Excepción (readLnShort): Valor introducido no short");
		} catch (Exception e) {
			System.out.println (">> Excepción (readLnShort): Ocurrió una excepción");
		}
		return val;
	}

	/** 
	 *  Método que lee una línea de teclado y devuelve el <code><b>int</b></code> escrito por el usuario. 
	 *  @return Devuelve el <code><b>int</b></code> introducido por el usuario o <code><b>KeyBoard.INT_ERR</b></code> si no se introdujo un byte.
	 */
	public static int readInt () {
		int val=INT_ERR;
		try	{
			BufferedReader in = new BufferedReader (new InputStreamReader (System.in));
			val = Integer.parseInt (in.readLine());
		} catch (IOException ioe) {
			System.out.println (">> Excepción (readLnInt): Imposible leer línea");
		} catch (NumberFormatException nfe) {
			System.out.println (">> Excepción (readLnInt): Valor introducido no entero");
		} catch (Exception e) {
			System.out.println (">> Excepción (readLnInt): Ocurrió una excepción");
		}
		return val;
	}


	/** 
	 *  Método que lee una línea de teclado y devuelve el <code><b>double</b></code> escrito por el usuario. 
	 *  @return Devuelve el <code><b>double</b></code> introducido por el usuario o <code><b>KeyBoard.DOUBLE_ERR</b></code> si no se introdujo un byte.
	 */
	public static double readDouble () {
		double val=DOUBLE_ERR;
		try	{
			BufferedReader in = new BufferedReader (new InputStreamReader (System.in));
			val = Double.parseDouble (in.readLine());
		} catch (IOException ioe) {
			System.out.println (">> Excepción (readLnDouble): Imposible leer línea");
		} catch (NumberFormatException nfe) {
			System.out.println (">> Excepción (readLnDouble): Valor introducido no double");
		} catch (Exception e) {
			System.out.println (">> Excepción (readLnDouble): Ocurrió una excepción");
		}
		return val;
	}

	/** 
	 *  Método que lee una línea de teclado y devuelve el <code><b>float</b></code> escrito por el usuario. 
	 *  @return Devuelve el <code><b>float</b></code> introducido por el usuario o <code><b>KeyBoard.FLOAT_ERR</b></code> si no se introdujo un byte.
	 */
	public static double readFloat () {
		float val=FLOAT_ERR;
		try	{
			BufferedReader in = new BufferedReader (new InputStreamReader (System.in));
			val = Float.parseFloat (in.readLine());
		} catch (IOException ioe) {
			System.out.println (">> Excepción (readLnFloat): Imposible leer línea");
		} catch (NumberFormatException nfe) {
			System.out.println (">> Excepción (readLnFloat): Valor introducido no float");
		} catch (Exception e) {
			System.out.println (">> Excepción (readLnFloat): Ocurrió una excepción");
		}
		return val;
	}

	/** 
	 *  Método que lee una línea de teclado y devuelve el <code><b>char</b></code> escrito por el usuario. 
	 *  @return Devuelve el <code><b>char</b></code> introducido por el usuario o <code><b>KeyBoard.CHAR_ERR</b></code> si no se introdujo un byte.
	 */
	
	public static char readChar () {
		char val = CHAR_ERR;
		try	{
			BufferedReader in = new BufferedReader (new InputStreamReader (System.in));
			val = (char) in.read(); 
		} catch (IOException ioe) {
			System.out.println (">> Excepción (readLnChar): Imposible leer caracter");
		} catch (Exception e) {
			System.out.println (">> Excepción (readLnChar): Ocurrió una excepción");
		}
		return val;
	}

	/** 
	 *  Método que lee una línea de teclado y devuelve el <code><b>String</b></code> escrito por el usuario. 
	 *  @return Devuelve el <code><b>String</b></code> introducido por el usuario o <code><b>KeyBoard.STRING_ERR</b></code> si no se introdujo un byte.
	 */
	public static String readString () {
		String val=STRING_ERR;
		try	{
			BufferedReader in = new BufferedReader (new InputStreamReader (System.in));
			val = in.readLine();
		} catch (IOException ioe) {
			System.out.println (">> Excepción (readLnString): Imposible leer línea");
		} catch (Exception e) {
			System.out.println (">> Excepción (readLnString): Ocurrió una excepción");
		}
		return val;
	}

        
        
}
