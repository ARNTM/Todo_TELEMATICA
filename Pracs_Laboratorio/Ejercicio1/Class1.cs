using System;
using System.Collections.Generic;
using System.Text;

using System;

namespace prueba

{

    class Program

    {

        static double cuentabanco = 50.0;

        static void Main(string[] args)

        {

            double ingreso = 100.0;

            double ahorro = jornal(ref ingreso);

            Console.Write(ahorro);

            Console.Write(ingreso);

        }

        static double jornal(ref double dinero)

        {

            cuentabanco = dinero + cuentabanco;

            return dinero = cuentabanco;

        }

    }

}