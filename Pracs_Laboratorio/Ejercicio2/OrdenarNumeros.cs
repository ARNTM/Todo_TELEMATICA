using System;

namespace Ejercicio2
{
    class OrdenarNumeros
    {
        static void Main(string[] args)
        {
            ordenar Ordena = new ordenar();
            while (true)
            {

                Random rnd = new Random();
                int[] numeros = new int[50];

                for (int i = 0; i < 50; i++){
                    numeros[i] = rnd.Next();
                }
                Console.WriteLine("Generando 50 números aleatorios:");
                Console.WriteLine("################################");
                foreach (int num in numeros)
                {
                    Console.WriteLine(num);
                }
                Console.WriteLine("################################\n");
                Console.WriteLine("Pulsa 1 para ordenar de forma creciente.\nPulsa 2 para ordenar de forma decreciente.\nPulsa 3 para salir.");
                String option = Console.ReadLine();
                Console.WriteLine("\nMostrando los números ordenados\n");
                switch (option) {
                    case "1":
                        Ordena.creciente(numeros);
                        foreach (int num in numeros) {
                            Console.WriteLine(num);
                        }
                        Console.WriteLine("Pulsa INTRO para volver a generar otra lista de números");
                        Console.ReadLine();
                        break;
                    case "2":
                        Ordena.decreciente(numeros);
                        foreach (int num in numeros) {
                            Console.WriteLine(num);
                        }
                        Console.WriteLine("Pulsa INTRO para volver a generar otra lista de números");
                        Console.ReadLine();
                        break;
                    case "3":
                        Environment.Exit(-1);
                        break;
                    default:
                        Console.WriteLine("Operación no válida");
                        break;
            }


            }
        }
    }
}
