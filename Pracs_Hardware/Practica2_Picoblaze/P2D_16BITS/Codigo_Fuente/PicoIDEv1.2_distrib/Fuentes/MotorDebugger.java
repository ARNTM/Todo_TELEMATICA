/*
	Codigo del motor de depuracion
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
import java.io.File;
import java.io.IOException;
import java.io.RandomAccessFile;

public class MotorDebugger {
	private PicoInstruccion[] programa;
	private int pc;
	
	private int registros[] = new int[PicoInstruccion.getNumRegs()];
	private String regNames[] = PicoInstruccion.getRegNameArray();
	private int noLlamadas;
	private int stack[] = new int[PicoInstruccion.getStackSize()];
	private int stackInt;
	private int ports[] = new int[PicoInstruccion.getPortSize()];
	private boolean carry;
	private boolean zero;
	private boolean interrupcion;
	private long contador = 0;
	
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
	
	public MotorDebugger(File programa) throws IOException{
		this.programa = new PicoInstruccion[PicoInstruccion.getNumInstr()];
		RandomAccessFile raf;
			raf = new RandomAccessFile(programa, "r");
			for(int i=0;i<this.programa.length;i++)
			{
				while(raf.readByte()!=':');
				raf.skipBytes(1);
				byte c1=raf.readByte();
				byte c2=raf.readByte();
				byte t1=0;
				byte t2=0;
			
				if(c1>='0'&c1<='9')
					t1=(byte)(c1-'0');
				else t1=(byte)(c1-'A'+10);

				if(c2>='0'&c2<='9')
					t2=(byte)(c2-'0');
				else t2=(byte)(c2-'A'+10);
				
				byte b1=(byte) (t1*16+t2);
			
				c1=raf.readByte();
				c2=raf.readByte();

				if(c1>='0'&c1<='9')
					t1=(byte)(c1-'0');
				else t1=(byte)(c1-'A'+10);

				if(c2>='0'&c2<='9')
					t2=(byte)(c2-'0');
				else t2=(byte)(c2-'A'+10);
			
				byte b2=(byte) (t1*16+t2);
			
				raf.skipBytes(2);
			
				this.programa[i] = new PicoInstruccion(b1,b2);
			}
			reset();
	}
	
	public boolean isPCBreakpoint(){
		return programa[pc].isBreakpoint();
	}
	
	public boolean isBreakpoint(int instr)
	{
		return programa[instr].isBreakpoint();
	}
	
	public void setBreakpoint(int instr, boolean b){
		programa[instr].setBreakpoint(b);
	}
	
	private void ejecutar() throws ExecutionException{
		if(pc>=PicoInstruccion.getNumInstr()) throw new ExecutionException(ExecutionException.EXEC);
		if(noLlamadas>=PicoInstruccion.getStackSize()) throw new ExecutionException(ExecutionException.STACK);
		
		PicoInstruccion actual = programa[pc];
		int op=actual.getOp();
		int arg1 = actual.getArg1();
		int arg2 = actual.getArg2();
		if (!getInt())
		switch(op){
			case LOADREGINM: 
			case LOADREGREG: exeLoad(op, arg1, arg2);break;
			case ANDREGINM: 
			case ANDREGREG: exeAnd(op, arg1, arg2);break;
			case ORREGINM: 
			case ORREGREG: exeOr(op, arg1, arg2);break;
			case XORREGINM:
			case XORREGREG: exeXor(op, arg1, arg2);break;
			case ADDREGINM: 
			case ADDREGREG: exeAdd(op,arg1, arg2);break;
			case ADDCYREGINM: 
			case ADDCYREGREG: exeAddcy(op, arg1, arg2);break;
			case SUBREGINM: 
			case SUBREGREG: exeSub(op, arg1, arg2);break;
			case SUBCYREGINM: 
			case SUBCYREGREG: exeSubcy(op, arg1, arg2);break;
			case INPUTREGADD: 
			case INPUTREGREG: exeInput(op, arg1, arg2);break;
			case OUTPUTREGADD: 
			case OUTPUTREGREG: exeOutput(op, arg1, arg2);break;
			case JUMP: 
			case JUMPZ: 
			case JUMPNZ: 
			case JUMPC: 
			case JUMPNC: exeJump(op, arg1, arg2); break;
			case CALL: 
			case CALLZ: 
			case CALLNZ: 
			case CALLC: 
			case CALLNC: exeCall(op,arg1, arg2); break; 
			case RETURN: 
			case RETURNZ: 
			case RETURNNZ: 
			case RETURNC: 
			case RETURNNC: exeReturn(op,arg1, arg2); break;
			case SR0:
			case SR1:
			case SRX:
			case SRA:
			case RR: exeSR(op, arg1, arg2);break;
			case SL0:
			case SL1:
			case SLA:
			case SLX:
			case RL:	exeSL(op, arg1, arg2); break;
			case RETURNI:
			case ENABLEINT:
			case DISABLEINT: exeInt(op, arg1, arg2);break;
			
			default : throw new ExecutionException(ExecutionException.INVALID);
		}
		else {
			stackInt=pc+1;
			pc=this.getNumInstr()-1;
			setInt(false);
		}
		contador+=actual.getDuracion();
	}
	
	private void exeInt(int op, int arg1, int arg2) {
		switch(op){
			case RETURNI: pc = stackInt; break;
			case ENABLEINT: this.setInt(true); break;
			case DISABLEINT: this.setInt(false); break;
		}
	}

	private void exeSL(int op, int arg1, int arg2) {
		int primerBit = registros[arg1] & 0x01;
		int ultimoBit = (registros[arg1] & 0x80)>>7;
		
		registros[arg1] = registros[arg1] & 0xFF;
		registros[arg1] = registros[arg1] << 1;

		switch(op){
			case SL0:
				break;
			case SL1:
				registros[arg1] = registros[arg1] | 0x01;
				break;
			case SLX:
				registros[arg1] = registros[arg1] | primerBit;
				break;
			case SLA:
				registros[arg1] = registros[arg1] | (carry?0x01: 0x00);
				break;
			case RL:
				registros[arg1] = registros[arg1] | ultimoBit;
				break;				
		}
		registros[arg1] = registros[arg1] & 0xFF;
		zero=(registros[arg1]==0);
		carry=(ultimoBit!=0);
		
		pc++;
	}

	private void exeSR(int op, int arg1, int arg2) {
		int ultimoBit = (registros[arg1] & 0x01)<<7; 	//Pone el ultimo bit en la primera posicion
		int primerBit = (registros[arg1] & 0x80);

		registros[arg1] = registros[arg1] & 0xFF;
		registros[arg1] = registros[arg1] >> 1;
		switch(op){
			case SR0: 
				break;
			case SR1:
				registros[arg1] = registros[arg1] | 0x80;
				break;
			case SRX:
				registros[arg1] = registros[arg1] | primerBit;
				break;
			case SRA:
				registros[arg1] = registros[arg1] | (carry? 0x80: 0x00);
				break;
			case RR:
				registros[arg1] = registros[arg1] | ultimoBit;
				break; 
		}
		registros[arg1] = registros[arg1] & 0xFF;
		zero = (registros[arg1]==0);
		carry=(ultimoBit!=0);

		pc++;
	}

	private void exeReturn(int op,int arg1, int arg2) {
		switch(op){
			case RETURN: pc=stack[--noLlamadas];break;
			case RETURNZ: if(zero) pc=stack[--noLlamadas]; else pc++;break;
			case RETURNNZ: if(!zero) pc=stack[--noLlamadas]; else pc++;break;
			case RETURNC: if(carry) pc=stack[--noLlamadas]; else pc++;break;
			case RETURNNC: if(!carry) pc=stack[--noLlamadas]; else pc++;break;
		}
//		TODO Hacer algo si excedemos pila!
	}

	private void exeCall(int op, int arg1, int arg2) {
		switch(op){
			case CALL:
				stack[noLlamadas++]=pc+1;
				pc = arg1;
				break;

			case CALLZ:
				if(zero){
					stack[noLlamadas++]=pc+1;
					pc = arg1;
				}
				else pc++;
				break;

			case CALLNZ:
				if(!zero){
					stack[noLlamadas++]=pc+1;
					pc = arg1;
				}
				else pc++;
				break;

			case CALLC:
				if(carry){
					stack[noLlamadas++]=pc+1;
					pc = arg1;
				}
				else pc++;
				break;

			case CALLNC:
				if(!carry){
					stack[noLlamadas++]=pc+1;
					pc = arg1;
				}
				else pc++;
				break;
		}
//		TODO Hacer algo si excedemos pila! 
	}

	private void exeJump(int op,int arg1, int arg2) {
		switch(op){
			case JUMP: pc = arg1;break;
			case JUMPZ: if(zero) pc = arg1; else pc++; break;
			case JUMPNZ: if(!zero) pc=arg1; else pc++; break;
			case JUMPC: if(carry) pc=arg1; else pc++; break;
			case JUMPNC: if(!carry) pc=arg1; else pc++; break;
		}
	}

	private void exeOutput(int op, int arg1, int arg2) {
		if(op==OUTPUTREGREG) ports[registros[arg2]]=registros[arg1];
		else ports[arg2]=registros[arg1];
		pc++;
	}


	private void exeInput(int op, int arg1, int arg2) {
		if(op==INPUTREGREG) registros[arg1]=ports[registros[arg2]];
		else registros[arg1]=ports[arg2];
		pc++;
	}

	private void exeSubcy(int op, int arg1, int arg2) {
		if(op==SUBCYREGREG) registros[arg1]=registros[arg1]-(carry?registros[arg2]+1:registros[arg2]);
		else registros[arg1]=registros[arg1]-(carry?arg2+1:arg2);
		if (registros[arg1]<0){
			carry=true;
			registros[arg1]=registros[arg1]&0xFF;
		}
		else carry=false;
		zero=(registros[arg1]==0);
		pc++;
	}

	private void exeSub(int op, int arg1, int arg2) {
		if(op==SUBREGREG) registros[arg1]=registros[arg1]-registros[arg2];
		else registros[arg1]=registros[arg1]-arg2;
		if (registros[arg1]<0){
			carry=true;
			registros[arg1]=registros[arg1]&0xFF;
		}
		else carry=false;
		zero=(registros[arg1]==0);
		pc++;
	}

	private void exeAddcy(int op, int arg1, int arg2) {
		if(op==ADDCYREGREG) registros[arg1]=registros[arg1]+(carry?registros[arg2]+1:registros[arg2]);
		else registros[arg1]=registros[arg1]+(carry?arg2+1:arg2);
		if (registros[arg1]>0xFF){
			carry=true;
			registros[arg1]=registros[arg1]&0xFF;
		}
		else carry=false;
		zero=(registros[arg1]==0);
		pc++;
	}

	private void exeAdd(int op, int arg1, int arg2) {
		if(op==ADDREGREG) registros[arg1]=registros[arg1]+registros[arg2];
		else registros[arg1] = registros[arg1] + arg2;
		if (registros[arg1]>0xFF){
			carry=true;
			registros[arg1]=registros[arg1]&0xFF;
		}
		else carry=false;
		zero=(registros[arg1]==0);
		pc++;
	}

	private void exeXor(int op, int arg1, int arg2) {
		if(op==XORREGREG) registros[arg1] = registros[arg1] ^ registros[arg2];
		else registros[arg1] = registros[arg1] ^arg2;
		carry = false;
		zero=(registros[arg1]==0);
		pc++;				
	}
	
	private void exeOr(int op, int arg1, int arg2) {
		if (op==ORREGREG) registros[arg1] = registros[arg1] | registros[arg2];
		else registros[arg1]=registros[arg1] | arg2;
		carry=false;
		zero=(registros[arg1]==0);
		pc++;
	}

	private void exeAnd(int op, int arg1, int arg2) {
		if (op==ANDREGREG) registros[arg1] = registros[arg1] & registros[arg2];
		else registros[arg1]=registros[arg1] & arg2;
		carry=false;
		zero=(registros[arg1]==0);
		pc++;
	}

	private void exeLoad(int op, int arg1, int arg2) {
		if(op==LOADREGREG)	registros[arg1]=registros[arg2];
		else registros[arg1] = arg2;
		zero=(registros[arg1]==0);
		carry=false;
		pc++;
	}


	public void reset(){
		pc=0;
		noLlamadas=0;
		interrupcion=false;
		for(int i=0;i<registros.length;i++) registros[i]=0;
		for(int i=0;i<ports.length;i++) ports[i]=0;
		for(int i=0;i<stack.length;i++) stack[i]=0;
		carry = false;
		zero = false;
		stackInt = 0;
	}
		
	public int getPC(){
		return pc;
	}
	
	public void setPort(int add, int value){
		ports[add] = value;
	}
	
	public int getPort(int add){
		return ports[add];
	}
	
	public int getPortSize(){
		return ports.length;
	}
	
	public int[] getPortsArray(){
		return ports;
	}
	
	public int getReg(int num){
		return registros[num];
	}
	
	public int getRegSize(){
		return registros.length;
	}
	
	public void setReg(int num, int valor){
		registros[num] = valor;
	}
	
	public int[] getRegArray(){
		return registros;
	}
	
	public String getRegName(int num){
		return regNames[num];
	}
		
	public String[] getRegNameArray(){
		return regNames;
	}
	
	public boolean getZero(){
		return zero;
	}
	
	public boolean getCarry(){
		return carry;
	}
	
	public boolean getInt(){
		return interrupcion;
	}
	
	public int[] getStack(){
		return stack;
	}
	
	public long getContador(){
		return contador;
	}
	
	public void step() throws ExecutionException{
		ejecutar();
	}
	
	public String getInstrString(int i){
		return programa[i].getStringInstr();
	}
	
	public int getNumInstr(){
		return PicoInstruccion.getNumInstr();
	}
	
	public byte getInstrB1(int i){
		return programa[i].getB1Instr();
	}

	public byte getInstrB2(int i){
		return programa[i].getB2Instr();
	}

	public void setPC(int i) {
		pc=i;
	}

	public void setZero(boolean b) {
		zero=b;
	}

	public void setCarry(boolean b) {
		carry = b;		
	}

	public void setInt(boolean b) {
		interrupcion=b;
	}
	
	public void setContador(long l){
		contador = l;
	}
	
	public void reconstruir(){
		for(int i=0;i<PicoInstruccion.getNumInstr();i++)
			programa[i].reconstruir();
	}

}
