import java.io.Serializable;
import java.rmi.Naming;

public class Matriz implements Serializable{
	
	public int row, col;
	private int [][] mat; 
	
	public Matriz(int row, int col) {
		this.col=col;
		this.row=row;
		mat = new int [row][col];
		for(int i = 0 ; i<row ; i++) {
			for(int j = 0 ; j<col ; j++) {
				mat[i][j] = (int)(Math.random()*10+1);
			}
		}
	}

	public void ImprimeMat() {
		if(mat!=null) {
			for(int i = 0 ; i<row ; i++) {
				for(int j = 0 ; j<col ; j++) {
					System.out.print(mat[i][j]);
					System.out.print(" ");
				}
				System.out.println();
			}
		}
	}

	public int getRow() {
		return row;
	}

	public int getCol() {
		return col;
	}
	
	public int getValorPos(int row, int col) {
		int valor = mat[row][col];
		return valor;
	}
	public void setValorPos(int row, int col, int valor) {
		mat[row][col] = valor;
	}
}
