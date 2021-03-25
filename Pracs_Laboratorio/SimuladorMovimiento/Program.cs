using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Collections;
using System.Threading.Tasks;

namespace SimuladorMovimiento
{
    class Program
    {
        static void Main(string[] args)
        {
            int ancho = 128;
            int alto = 112;
            int macrobloquesMax = (ancho / 8) * (alto / 8);
            int numFilas = (ancho / 8);
            int numCols = (alto / 8); 

            int[,] matrizMov = new int[ancho, alto];

            ArrayList bloquesPuestosP = new ArrayList();
            while (true) {
                int contador = 1;
                int contadorBloqueMovimiento = 1;
                Random rng = new Random();
                int[] bloquesPuestos = new int[macrobloquesMax];

                Console.Write("Introduzca la cantidad de movimiento de la imagen en %: ");
                String porcentaje = Console.ReadLine();
                double movimiento = Convert.ToInt32(porcentaje);

                double macrobloquesMovimiento = macrobloquesMax * (movimiento / 100);

                for (int i = 0; i < matrizMov.GetLength(0); i++)
                {
                    for (int j = 0; j < matrizMov.GetLength(1); j++)
                    {
                        matrizMov[i, j] = 0;
                    }
                }
                for (int i = 0; i < bloquesPuestos.Length; i++)
                {
                    bloquesPuestos[i] = i + 1;
                }
                //Console.WriteLine("Matriz inicializada a 0 de dimensiones : " + matrizMov.GetLength(0) + " x " + matrizMov.GetLength(1));

                while (macrobloquesMovimiento >= contadorBloqueMovimiento)
                {
                    int tipo = rng.Next(2);
                    //Console.WriteLine("Escribiendo macrobloque de " + tipo + "s");
                    if (tipo == 1)
                    {
                        //if (!bloquesPuestosP.Contains(contador)) {
                            for (int a = 8 * (contador % numFilas); a < 8 * (contador % numFilas) + 8; a++)
                            { // FILAS
                                for (int b = 8 * (contador % numCols); b < 8 * (contador % numCols) + 8; b++) // COLS
                                {
                                    //Console.WriteLine("Escribiendo 1 en la posicion (" + a + "," + b + ")");
                                    matrizMov[a, b] = tipo;
                                }
                            }
                            contadorBloqueMovimiento++;
                            if (contador > macrobloquesMax) contador = 1;
                            contador++;
                            bloquesPuestosP.Add(contador);
                            //Console.WriteLine("Bloque " + contador + " añadido a la lista de bloques puestos");
                            //Console.WriteLine();
                            /*for (int i = 0; i < bloquesPuestosP.Count; i++) {
                                Console.Write(" " + bloquesPuestosP[i] +" ");
                            }
                            Console.ReadLine();*/
                        //}

                    }
                    else
                    {
                        if (contador > macrobloquesMax) contador = 1;
                        //if (!bloquesPuestosP.Contains(contador)) {
                            contador = contador + 4;
                            bloquesPuestosP.Add(contador);
                            bloquesPuestosP.Add(contador + 1);
                            bloquesPuestosP.Add(contador + numFilas);
                            bloquesPuestosP.Add(contador + numFilas + 1);
                            Console.WriteLine("Bloque " + contador + " añadido a la lista de bloques puestos");
                            Console.WriteLine("Bloque " + (contador + 1) + " añadido a la lista de bloques puestos");
                            Console.WriteLine("Bloque " + (contador + numFilas) + " añadido a la lista de bloques puestos");
                            Console.WriteLine("Bloque " + (contador + numFilas + 1) + " añadido a la lista de bloques puestos");
                            Console.WriteLine();
                            /*for (int i = 0; i < bloquesPuestosP.Count; i++)
                            {
                                Console.Write(" " + bloquesPuestosP[i] + " ");
                            }
                            Console.ReadLine();*/
                        //}

                        //Console.ReadLine();
                    }
                }

                for (int i = 0; i < matrizMov.GetLength(0); i++)
                {
                    for (int j = 0; j < matrizMov.GetLength(1); j++)
                    {
                        Console.Write(matrizMov[i, j]);
                    }
                    Console.WriteLine();
                }
                Console.ReadLine();


            }
            
        }
    }
}
