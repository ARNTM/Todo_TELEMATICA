/*
    Excepcion en la ejecucion de la simulacion
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

public class ExecutionException extends Exception {
	public static final int STACK = 0;
	public static final int EXEC =1;
	public static final int INVALID = 2;
	
	private int tipo; 
	public ExecutionException(int tipo)
	{
		this.tipo = tipo;
	}
	
	public int getType(){
		return tipo;
	}
}
