using System;
using System.Collections.Generic;
using System.Text;

namespace Ejercicio1
{
    class cliente{
        static void Main(string[] args){
            cuentas CuentaAndres = new cuentas();
            while (true) {
                Console.WriteLine("\n=========================================\nPara ingresar dinero pulse 1 \nPara sacar dinero pulse 2 \nPara consultar tu saldo pulse 3\nPasa salir de la aplicación pulse 4\n1 s=========================================\n");
                String option = Console.ReadLine();
                double cantidad = 0;
                switch (option) {
                    case "1":
                        Console.WriteLine("¿Cuánto dinero quieres ingresar?");
                        String ingreso = Console.ReadLine();
                        Double.TryParse(ingreso, out cantidad);
                        Console.WriteLine(CuentaAndres.Ingreso(cantidad));
                        break;
                    case "2":
                        Console.WriteLine("¿Cuánto dinero quieres sacar?");
                        String gasto = Console.ReadLine();
                        Double.TryParse(gasto, out cantidad);
                        Console.WriteLine(CuentaAndres.Gasto(cantidad));
                        break;
                    case "3":
                        Console.WriteLine("Tu saldo actual es de " + CuentaAndres.SaldoEnCuenta);
                        break;
                    case "4":
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
