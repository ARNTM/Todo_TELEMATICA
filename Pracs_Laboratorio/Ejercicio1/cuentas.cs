using System;

namespace Ejercicio1
{
    class cuentas
    {
        protected double saldoEnCuenta = 0;
        public double SaldoEnCuenta {
            get { return this.saldoEnCuenta; }
        }

        public String Gasto(double c) {
            if (c <= 0) return "No puedes gastar 0";
            if ((saldoEnCuenta - c) < 0) return "No puedes gastar más de lo que tienes.";
            this.saldoEnCuenta -= c;
            return "Cuenta actualizada, su saldo actual es de " + this.saldoEnCuenta;
        }

        public String Ingreso(double c) {
            if (c <= 0) return "No puedes ingresar 0";
            this.saldoEnCuenta += c;
            return "Cuenta actualizada, su saldo actual es de " + this.saldoEnCuenta;
        }
    }
}