using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace RGB_YUV
{
    public partial class genYUVMat : Form
    {

        //Definimos el tamaño de la imagen, la matriz de bloques, las matrices R,G,B y la matriz YUV
        static int width = 800;
        static int height = 640;

        Random rng = new Random();
        double[,] coeficientes = new double[3, 3] { { 0.299, 0.587, 0.114 }, { -0.147, -0.289, 0.436 }, { 0.615, -0.515, -0.100 } };
        bool one = false; //Nos servirá para detectar el primer bloque de 1s

        int[,] chunkMat = new int[width / 8, height / 8];
        double[,] redMat = new double[width / 8, height / 8];
        double[,] greenMat = new double[width / 8, height / 8];
        double[,] blueMat = new double[width / 8, height / 8];
        double[] yuvMat = new double[3];

        public genYUVMat()
        {
            InitializeComponent();

            for (int i = 0; i < chunkMat.GetLength(0)/2; i++) {
                for (int j = 0; j < chunkMat.GetLength(1)/2; j++) {
                    int mov = rng.Next(2);  // Devuelve un entero aleatorio no negativo que es inferior al máximo especificado.
                    chunkMat[2*i, 2*j] = mov;
                    chunkMat[2*i+1, 2*j] = mov;
                    chunkMat[2*i, 2*j+1] = mov;
                    chunkMat[2*i+1, 2*j+1] = mov;
                    if (mov != 0) { // Si mov es distinto de 0, rellenamos también las matrices de colores
                        redMat[i, j] = rng.NextDouble();
                        greenMat[i, j] = rng.NextDouble();
                        blueMat[i, j] = rng.NextDouble();
                    }
                    else {
                        redMat[i, j] = 0;
                        greenMat[i, j] = 0;
                        blueMat[i, j] = 0;
                    }
                }
            }

            // ======= IMPRIMIR MATRIZ DE MOVIMIENTO =======
            for (int i = 0; i < chunkMat.GetLength(0); i++) {
                for (int j = 0; j < chunkMat.GetLength(1); j++) {
                    if (j != 0 && j % 2 != 0) {
                        movimiento.Text += chunkMat[i, j] + "  ";
                        movimiento.Text += "  ";
                    }
                    else {
                        movimiento.Text += chunkMat[i, j] + "  ";
                    }
                }

                if (i != 0 && i % 2 != 0) {
                    movimiento.Text += "\n";
                    movimiento.Text += "\n";
                }
                else {
                    movimiento.Text += "\n";
                }
            }

            // ======= IMPRIMIR MATRICES DE RGB =======
            for (int i = 0; i < redMat.GetLength(0)/2; i++) {
                for (int j = 0; j < redMat.GetLength(1)/2; j++) {
                    red.Text += string.Format("{0:0.00}", redMat[i, j]) + " ";
                    green.Text += string.Format("{0:0.00}", greenMat[i, j]) + " ";
                    blue.Text += string.Format("{0:0.00}", blueMat[i, j]) + " ";
                }
                red.Text += "\n";
                green.Text += "\n";
                blue.Text += "\n";
            }

            // ======= IMPRIMIR YUV =======
            for (int i = 0; i < chunkMat.GetLength(0) / 2; i++) {
                for (int j = 0; j < chunkMat.GetLength(1) / 2; j++) {
                    if (!one && chunkMat[2*i, 2*j] != 0) {
                        one = true;
                        for (int k = 0; k < 3; k++) {
                            yuvMat[k] = coeficientes[k, 0] * redMat[i, j];
                            yuvMat[k] = coeficientes[k, 1] * greenMat[i, j];
                            yuvMat[k] = coeficientes[k, 2] * blueMat[i, j];
                            yuv.Text += "YUV[" + k + "] = " + string.Format("{0:0.00}", yuvMat[k]) + "\n";
                        }
                    }
                }
            }
        }
    }
}
