using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace op
{
    public class operaciones : MarshalByRefObject
    {
        public double sumar(double a, double b)
        {
            return a + b;
        }
        public double restar(double a, double b)
        {
            return a - b;
        }
        public double multiplicar(double a, double b)
        {
            return a * b;
        }
        public double dividir(double a, double b)
        {
            return a / b;
        }

        public double modulo(double a, double b)
        {
            return a % b;
        }

        public double logaritmo(double a, double b)
        {
            return Math.Log(a,b);
        }

        public double potencia(double a, double b)
        {
            return Math.Pow(a,b);
        }

        public double raiz(double a, double b)
        {
            return Math.Pow(a, 1/b);
        }
    }
}
