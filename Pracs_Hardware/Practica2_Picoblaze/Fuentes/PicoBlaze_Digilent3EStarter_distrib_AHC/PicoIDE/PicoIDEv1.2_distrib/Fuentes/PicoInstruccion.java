/*
    Codigo que simula una instruccion
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

public class PicoInstruccion 
{
	private String instruccion;
	private byte b1, b2;
	private static String[] REGNAME = {"s0","s1","s2","s3","s4","s5","s6","s7"};
	private static final int NUMREGS= 8; 
	private static final boolean EXITSINTERRUPTS = true;
	private static final int NUMINSTR = 256;
	private static final int STACKSIZE = 16;
	private static final int PORTSIZE = 256;
	private boolean breakpoint = false;
	private int duracion;
	private int op;
	private int arg1;
	private int arg2;
	
	private final int LOADREGINM = 0;	// LOAD reg, #
	private final int LOADREGREG = 1;	//LOAD reg, reg
	private final int ANDREGINM = 2;	//AND reg, #
	private final int ANDREGREG = 3;	//AND reg, reg
	private final int ORREGINM = 4;		//...
	private final int ORREGREG = 5;
	private final int XORREGINM = 6;
	private final int XORREGREG = 7;
	private final int ADDREGINM = 8;
	private final int ADDREGREG = 9;
	private final int ADDCYREGINM = 10;
	private final int ADDCYREGREG =11;
	private final int SUBREGINM = 12;
	private final int SUBREGREG = 13;
	private final int SUBCYREGINM = 14;
	private final int SUBCYREGREG = 15;
	private final int INPUTREGADD = 16;
	private final int INPUTREGREG = 17;
	private final int OUTPUTREGADD = 18;
	private final int OUTPUTREGREG = 19;
	private final int JUMP = 20;
	private final int JUMPZ = 21;
	private final int JUMPNZ = 22;
	private final int JUMPC = 23;
	private final int JUMPNC = 24;
	private final int CALL = 25;
	private final int CALLZ = 26;
	private final int CALLNZ = 27;
	private final int CALLC = 28;
	private final int CALLNC = 29;
	private final int RETURN = 30;
	private final int RETURNZ =31;
	private final int RETURNNZ = 32;
	private final int RETURNC = 33;
	private final int RETURNNC = 34;
	private final int SR0 = 35;
	private final int SR1 = 36;
	private final int SRX = 37;
	private final int SRA = 38;
	private final int RR = 39;
	private final int SL0 = 40;
	private final int SL1 = 41;
	private final int SLX = 42;
	private final int SLA = 43;
	private final int RL = 44;
	private final int RETURNI = 45;
	private final int ENABLEINT = 46;
	private final int DISABLEINT = 47;
	
	public PicoInstruccion(byte b1, byte b2)
	{
		this.b1=b1;
		this.b2=b2;
		reconstruir();
	}
	
	public int getRegNumber(){
		return NUMREGS;
	}
	
	public boolean getExistenInterrupts(){
		return EXITSINTERRUPTS;
	}
	
	public boolean isBreakpoint(){
		return breakpoint;
	}
	
	public void setBreakpoint(boolean b){
		breakpoint = b;
	}
	
	public static void setRegName(int r, String s)
	{
		REGNAME[r] = s;
	}
	
	public int getDuracion(){
		return duracion;
	}
	
	public void reconstruir(){
		instruccion=Decodificar(b1,b2);
	}
	
	private String Decodificar(byte b1, byte b2)
	{
		switch(b1)
		{
			case (byte) 0xD0 :				//Salto incondicional
			case (byte) 0xD1 :
			case (byte) 0xD2 :
			case (byte) 0xD3 :
				op = JUMP;
				arg1 = b2&0x00FF;
				arg2 = 0;
				duracion = 2;
				return "JUMP\t\t"+HexString(b2);
			
			case (byte) 0xD4:				//Saltos condicionales
				op = JUMPZ;
				arg1 = b2&0x00FF;
				arg2 = 0;
				duracion = 2;
				return "JUMP\t\tZ, "+HexString(b2);
			case (byte) 0xD5:
				op = JUMPNZ;
				arg1 = b2&0x00FF;
				arg2 = 0;
				duracion = 2;
				return "JUMP\t\tNZ, "+HexString(b2);
			case (byte) 0xD6:
				op = JUMPC;
				arg1 = b2&0x00FF;
				arg2 = 0;
				duracion = 2;
				return "JUMP\t\tC, "+HexString(b2);
			case (byte) 0xD7:
				op = JUMPNC;
				arg1 = b2&0x00FF;
				arg2 = 0;
				duracion = 2;
				return "JUMP\t\tNC, "+HexString(b2);
				
			case (byte) 0xD8:				//Llamadas a funciones incondicionales
			case (byte) 0xD9:
			case (byte) 0xDA:
			case (byte) 0xDB:
				op = CALL;
				arg1 = b2&0x00FF;
				arg2 = 0;
				duracion = 2;
				return "CALL\t\t"+HexString(b2);

			case (byte) 0xDC:				//Llamadas condicionales
				op = CALL;
				arg1 = b2&0x00FF;
				arg2 = 0;
				duracion = 2;
				return "CALL\t\tZ,"+HexString(b2);		
			case (byte) 0xDD:		
				op = CALLNZ;
				arg1 = b2&0x00FF;
				arg2 = 0;
				duracion = 2;
				return "CALL\t\tNZ,"+HexString(b2);	
			case (byte) 0xDE:		
				op = CALLC;
				arg1 = b2&0x00FF;
				arg2 = 0;
				duracion = 2;
				return "CALL\t\tC,"+HexString(b2);
			case (byte) 0xDF:		
				op = CALLNC;
				arg1 = b2&0x00FF;
				arg2 = 0;
				duracion = 2;
				return "CALL\t\tNC,"+HexString(b2);

			case (byte) 0x90:				//Retorno de funciones incondicionales y cosas relacionadas con interrupciones
			case (byte) 0x91:
			case (byte) 0x92:
			case (byte) 0x93:
				op = RETURN;
				arg1 = 0;
				arg2 = 0;
				duracion = 2;
				return "RETURN";
			
			case (byte) 0x94: 
				op = RETURNZ;
				arg1 = 0;
				arg2 = 0;
				duracion = 2;
				return "RETURN\t\tZ";
				
			case (byte) 0x95: 
				op = RETURNNZ;
				arg1 = 0;
				arg2 = 0;
				duracion = 2;
				return "RETURN\t\tNZ";
				
			case (byte) 0x96: 
				op = RETURNC;
				arg1 = 0;
				arg2 = 0;
				duracion = 2;
				return "RETURN\t\tC";
				
			case (byte) 0x97: 
				op = RETURNNC;
				arg1 = 0;
				arg2 = 0;
				duracion = 2;
				return "RETURN\t\tNC";
				
			case (byte) 0xF0 : case (byte) 0xF1 :			
			case (byte) 0xF2 : case (byte) 0xF3 :			
			case (byte) 0xF4 : case (byte) 0xF5 :			
			case (byte) 0xF6 : case (byte) 0xF7 :
				if(((byte)b2&0x01)==0){			
					op = ENABLEINT;
					arg1 = 0;
					arg2 = 0;
					duracion = 2;
					return "INTERRUPT\t\tENABLE";
				}
				else{
					op = DISABLEINT;
					arg1 = 0;
					arg2 = 0;
					duracion = 2;
					return "INTERRUPT\t\tDISABLE";
				}
				
			case (byte) 0xB0 : case (byte) 0xB1 :			
			case (byte) 0xB2 : case (byte) 0xB3 :			
			case (byte) 0xB4 : case (byte) 0xB5 :			
			case (byte) 0xB6 : case (byte) 0xB7 :
				op = RETURNI;
				arg1 = 0;
				arg2 = 0;
				duracion = 2;
				return "RETURNI";


			case (byte) 0x00 :	case (byte) 0x01 : 
			case (byte) 0x02 :	case (byte) 0x03 : 
			case (byte) 0x04 :	case (byte) 0x05 : 
			case (byte) 0x06 :	case (byte) 0x07 : 
				op = LOADREGINM;
				arg1 = b1&0X07;
				arg2 = b2&0x00FF;
				duracion = 2;
				return "LOAD\t\t"+REGNAME[b1&0x07]+", "+HexString(b2);

			case (byte) 0x40 :	case (byte) 0x41 : 
			case (byte) 0x42 :	case (byte) 0x43 : 
			case (byte) 0x44 :	case (byte) 0x45 : 
			case (byte) 0x46 :  case (byte) 0x47 : 
				op = LOADREGREG;
				arg1 = b1&0x07;
				arg2 = (b2&0xE0)>>5;
				duracion = 2;
				return "LOAD\t\t"+REGNAME[b1&0x07]+", "+REGNAME[(b2&0xE0)>>5];

			case (byte) 0x48 :	case (byte) 0x49 : 
			case (byte) 0x4A :	case (byte) 0x4B : 
			case (byte) 0x4C :	case (byte) 0x4D : 
			case (byte) 0x4E :  case (byte) 0x4F : 
				op = ANDREGREG;
				arg1 = b1&0x07;
				arg2 = (b2>>5) & 0x07;
				duracion = 2;
				return "AND\t\t"+REGNAME[arg1]+", "+REGNAME[arg2];

			case (byte) 0x50 :	case (byte) 0x51 : 
			case (byte) 0x52 :	case (byte) 0x53 : 
			case (byte) 0x54 :	case (byte) 0x55 : 
			case (byte) 0x56 :  case (byte) 0x57 : 
				op = ORREGREG;
				arg1 = b1&0x07;
				arg2 = (b2&0xE0)>>5;
				duracion = 2;
				return "OR\t\t"+REGNAME[b1&0x07]+", "+REGNAME[(b2&0xE0)>>5];

			case (byte) 0x58 :	case (byte) 0x59 : 
			case (byte) 0x5A :	case (byte) 0x5B : 
			case (byte) 0x5C :	case (byte) 0x5D : 
			case (byte) 0x5E :   case (byte) 0x5F : 
				op = XORREGREG;
				arg1 = b1&0x07;
				arg2 = (b2&0xE0)>>5;
				duracion = 2;
				return "XOR\t\t"+REGNAME[b1&0x07]+", "+REGNAME[(b2&0xE0)>>5];

			case (byte) 0x60 :	case (byte) 0x61 : 
			case (byte) 0x62 :	case (byte) 0x63 : 
			case (byte) 0x64 :	case (byte) 0x65 : 
			case (byte) 0x66 :  case (byte) 0x67 : 
				op = ADDREGREG;
				arg1 = b1&0x07;
				arg2 = (b2&0xE0)>>5;
				duracion = 2;
				return "ADD\t\t"+REGNAME[b1&0x07]+", "+REGNAME[(b2&0xE0)>>5];

			case (byte) 0x68 :	case (byte) 0x69 : 
			case (byte) 0x6A :	case (byte) 0x6B : 
			case (byte) 0x6C :	case (byte) 0x6D : 
			case (byte) 0x6E :  case (byte) 0x6F : 
				op = ADDCYREGREG;
				arg1 = b1&0X07;
				arg2 = (b2&0xE0)>>5;
				duracion = 2;
				return "ADDCY\t\ts"+REGNAME[b1&0x07]+", "+REGNAME[(b2&0xE0)>>5];

			case (byte) 0x70 :	case (byte) 0x71 : 
			case (byte) 0x72 :	case (byte) 0x73 : 
			case (byte) 0x74 :	case (byte) 0x75 : 
			case (byte) 0x76 :  case (byte) 0x77 : 
				op = SUBREGREG;
				arg1 = b1&0x07;
				arg2 = (b2&0xE0)>>5;
				duracion = 2;
				return "SUB\t\t"+REGNAME[b1&0x07]+", "+REGNAME[(b2&0xE0)>>5];

			case (byte) 0x78 :	case (byte) 0x79 : 
			case (byte) 0x7A :	case (byte) 0x7B : 
			case (byte) 0x7C :	case (byte) 0x7D : 
			case (byte) 0x7E :  case (byte) 0x7F : 
				op = SUBCYREGREG;
				arg1 = b1&0x07;
				arg2 = (b2&0xE0)>>5;
				duracion = 2;
				return "SUBCY\t\t"+REGNAME[b1&0x07]+", "+REGNAME[(b2&0xE0)>>5];
			
			case (byte) 0x08 :	case (byte) 0x09 : 
			case (byte) 0x0A :	case (byte) 0x0B : 
			case (byte) 0x0C :	case (byte) 0x0D : 
			case (byte) 0x0E :	case (byte) 0x0F : 
				op = ANDREGINM;
				arg1 = b1&0X07;
				arg2 = b2&0x00FF;
				duracion = 2;
				return "AND\t\t"+REGNAME[b1&0x07]+", "+HexString(b2);
			
			case (byte) 0x10 :	case (byte) 0x11 : 
			case (byte) 0x12 :	case (byte) 0x13 : 
			case (byte) 0x14 :	case (byte) 0x15 : 
			case (byte) 0x16 :	case (byte) 0x17 : 
				op = ORREGINM;
				arg1 = b1&0x07;
				arg2 = b2&0x00FF;
				duracion = 2;
				return "OR\t\t"+REGNAME[b1&0x07]+", "+HexString(b2);
		
			case (byte) 0x18 :	case (byte) 0x19 : 
			case (byte) 0x1A :	case (byte) 0x1B : 
			case (byte) 0x1C :	case (byte) 0x1D : 
			case (byte) 0x1E :	case (byte) 0x1F : 
				op = XORREGINM;
				arg1 = b1&0X07;
				arg2 = b2&0x00FF;
				duracion = 2;
				return "XOR\t\t"+REGNAME[b1&0x07]+", "+HexString(b2);
		
			case (byte) 0x20 :	case (byte) 0x21 : 
			case (byte) 0x22 :	case (byte) 0x23 : 
			case (byte) 0x24 :	case (byte) 0x25 : 
			case (byte) 0x26 :	case (byte) 0x27 : 
				op = ADDREGINM;
				arg1 = b1&0x07;
				arg2 = b2&0x00FF;
				duracion = 2;
				return "ADD\t\t"+REGNAME[b1&0x07]+", "+HexString(b2);
		
			case (byte) 0x28 :	case (byte) 0x29 : 
			case (byte) 0x2A :	case (byte) 0x2B : 
			case (byte) 0x2C :	case (byte) 0x2D : 
			case (byte) 0x2E :	case (byte) 0x2F : 
				op = ADDCYREGINM;
				arg1 = b1&0x07;
				arg2 = b2&0x00FF;
				duracion = 2;
				return "ADDCY\t\t"+REGNAME[b1&0x07]+", "+HexString(b2);
		
			case (byte) 0x30 :	case (byte) 0x31 : 
			case (byte) 0x32 :	case (byte) 0x33 : 
			case (byte) 0x34 :	case (byte) 0x35 : 
			case (byte) 0x36 :	case (byte) 0x37 : 
				op = SUBREGINM;
				arg1 = b1&0x07;
				arg2 = b2&0x00FF;
				duracion = 2;
				return "SUB\t\t"+REGNAME[b1&0x07]+", "+HexString(b2);
	
			case (byte) 0x38 :	case (byte) 0x39 : 
			case (byte) 0x3A :	case (byte) 0x3B : 
			case (byte) 0x3C :	case (byte) 0x3D : 
			case (byte) 0x3E :	case (byte) 0x3F : 
				op = SUBCYREGINM;
				arg1 = b1&0X07;
				arg2 = b2&0x00FF;
				duracion = 2;
				return "SUBCY\t\t"+REGNAME[b1&0x07]+", "+HexString(b2);
	
			case (byte) 0xA0 :	case (byte) 0xA1 : 
			case (byte) 0xA2 :	case (byte) 0xA3 : 
			case (byte) 0xA4 :	case (byte) 0xA5 : 
			case (byte) 0xA6 :	case (byte) 0xA7 : 
				byte b = (byte) (b2&0x07);
				boolean derecha = ((byte)(b2&0x08)!=0);
				if(derecha){
					switch(b)
					{
						case 6: 
						op = SR0;
						arg1 = b1&0X07;
						arg2 = 0;
						duracion = 2;
						return "SR0\t\t"+REGNAME[b1&0x07];

						case 7: 
						op = SR1;
						arg1 = b1&0X07;
						arg2 = 0;
						duracion = 2;
						return "SR1\t\t"+REGNAME[b1&0x07];

						case 2: 
						op = SRX;
						arg1 = b1&0X07;
						arg2 = 0;
						duracion = 2;
						return "SRX\t\t"+REGNAME[b1&0x07];

						case 0: 
						op = SRA;
						arg1 = b1&0X07;
						arg2 = 0;
						duracion = 2;
						return "SRA\t\t"+REGNAME[b1&0x07];

						case 4: 
						op = RR;
						arg1 = b1&0X07;
						arg2 = 0;
						duracion = 2;
						return "RR\t\t"+REGNAME[b1&0x07];
					}
				}
				else{
					switch(b)
					{
						case 6: 
						op = SL0;
						arg1 = b1&0X07;
						arg2 = 0;
						duracion = 2;
						return "SL0\t\t"+REGNAME[b1&0x07];

						case 7: 
						op = SL1;
						arg1 = b1&0X07;
						arg2 = 0;
						duracion = 2;
						return "SL1\t\t"+REGNAME[b1&0x07];

						case 2: 
						op = SLX;
						arg1 = b1&0X07;
						arg2 = 0;
						duracion = 2;
						return "SLX\t\t"+REGNAME[b1&0x07];

						case 0: 
						op = SLA;
						arg1 = b1&0X07;
						arg2 = 0;
						duracion = 2;
						return "SLA\t\t"+REGNAME[b1&0x07];

						case 4: 
						op = RL;
						arg1 = b1&0X07;
						arg2 = 0;
						duracion = 2;
						return "RL\t\t"+REGNAME[b1&0x07];
					}
				}
				
			case (byte) 0x80 :	case (byte) 0x81 : 
			case (byte) 0x82 :	case (byte) 0x83 : 
			case (byte) 0x84 :	case (byte) 0x85 : 
			case (byte) 0x86 :	case (byte) 0x87 : 
				op = INPUTREGADD;
				arg1 = b1&0X07;
				arg2 = b2&0x00FF;;
				duracion = 2;
				return "INPUT\t"+REGNAME[b1&0x07]+", "+HexString(b2);
		
			case (byte) 0xC0 :	case (byte) 0xC1 : 
			case (byte) 0xC2 :	case (byte) 0xC3 : 
			case (byte) 0xC4 :	case (byte) 0xC5 : 
			case (byte) 0xC6 :	case (byte) 0xC7 : 
				op = INPUTREGREG;
				arg1 = b1&0X07;
				arg2 = (b2&0xE0)>>5;
				duracion = 2;
				return "INPUT\t"+REGNAME[b1&0x07]+", "+REGNAME[((b2&0xE0)>>5)];
			
			case (byte) 0x88 :	case (byte) 0x89 : 
			case (byte) 0x8A :	case (byte) 0x8B : 
			case (byte) 0x8C :	case (byte) 0x8D : 
			case (byte) 0x8E :	case (byte) 0x8F : 
				op = OUTPUTREGADD;
				arg1 = b1&0x07;
				arg2 = b2&0x00FF;
				duracion = 2;
				return "OUTPUT\t"+REGNAME[b1&0x07]+", "+HexString(b2);
			
			case (byte) 0xC8 :	case (byte) 0xC9 : 
			case (byte) 0xCA :	case (byte) 0xCB : 
			case (byte) 0xCC :	case (byte) 0xCD : 
			case (byte) 0xCE :	case (byte) 0xCF : 
				op = OUTPUTREGREG;
				arg1 = b1&0X07;
				arg2 = (b2&0XE0)>>5;
				duracion = 2;
				return "OUTPUT\t"+REGNAME[b1&0x07]+", "+REGNAME[(b2&0xE0)>>5];
	
			default:
				op = -1; 
				return "INVALID"; 
		}	
	}
	
	public String getStringInstr()
	{
		return instruccion;
	}
	
	public byte[] getBytesInstr()
	{
		byte[] a = {b1,b2};
		return a;
	}
	
	public byte getB1Instr()
	{
		return b1;	
	}
	
	public byte getB2Instr()
	{
		return b2;	
	}
	
	private String HexString(int i)
	{
		String s = Integer.toHexString(i);
		if(s.length()>=2)
			s=s.substring(s.length()-2,s.length());
		else s='0'+s;
		return s.toUpperCase();
	}
	
	public static int getNumRegs(){
		return NUMREGS;
	}
	
	public static int getNumInstr(){
		return NUMINSTR;
	}
	
	public static int getStackSize(){
		return STACKSIZE;
	}

	public static int getPortSize(){
		return PORTSIZE;
	}

	public static boolean getInterruptExist(){
		return EXITSINTERRUPTS;
	}
	
	public String getRegName(int n){
		return REGNAME[n];
	}
	
	public int getOp(){
		return op;
	}
	
	public int getArg1(){
		return arg1;
	}
	
	public int getArg2(){
		return arg2;
	}
	
	public static String[] getRegNameArray(){
		return REGNAME;
	}
	
}
