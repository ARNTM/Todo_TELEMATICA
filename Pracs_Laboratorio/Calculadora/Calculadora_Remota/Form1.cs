using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using op;
using System.Runtime.Remoting;
using System.Runtime.Remoting.Channels.Http;
using System.Runtime.Remoting.Channels;
using System.Diagnostics.CodeAnalysis;

namespace Calculadora
{
    public partial class Form1 : Form
    {
        
        public Form1()
        {
            InitializeComponent();
        }

        operaciones op = (operaciones)Activator.GetObject(typeof(operaciones), "http://localhost:8090/operaciones");

        private void suma_Click(object sender, EventArgs e)
        {
            double a, b = 0;
            if (double.TryParse(sumando1.Text, out a) && double.TryParse(sumando2.Text, out b))
            {
                resultados.Items.Insert(0, op.sumar(a, b));
                
            }
            else MessageBox.Show("No has insertado 2 números");
        }

        private void resta_Click(object sender, EventArgs e)
        {
            double a, b = 0;
            if (double.TryParse(sumando1.Text, out a) && double.TryParse(sumando2.Text, out b))
            {
                resultados.Items.Insert(0, op.restar(a, b));
            }
            else MessageBox.Show("No has insertado 2 números");
        }

        private void multiplica_Click(object sender, EventArgs e)
        {
            double a, b = 0;
            if (double.TryParse(sumando1.Text, out a) && double.TryParse(sumando2.Text, out b))
            {
                resultados.Items.Insert(0, op.multiplicar(a, b));
            }
            else MessageBox.Show("No has insertado 2 números");
        }

        private void divide_Click(object sender, EventArgs e)
        {
            double a, b = 0;
            if (double.TryParse(sumando1.Text, out a) && double.TryParse(sumando2.Text, out b))
            {
                if (b != 0) resultados.Items.Insert(0 , op.dividir(a, b));
                else MessageBox.Show("No puedes dividir entre 0");
                    
            }
            else MessageBox.Show("No has insertado 2 números");
        }

        private void modulo_Click(object sender, EventArgs e)
        {
            double a, b = 0;
            if (double.TryParse(sumando1.Text, out a) && double.TryParse(sumando2.Text, out b))
            {
                resultados.Items.Insert(0, op.modulo(a, b));

            }
            else MessageBox.Show("No has insertado 2 números");
        }

        private void log_Click(object sender, EventArgs e)
        {
            double a, b = 0;
            if (double.TryParse(sumando1.Text, out a) && double.TryParse(sumando2.Text, out b))
            {
                resultados.Items.Insert(0, op.logaritmo(a, b));
            }
            else MessageBox.Show("No has insertado 2 números");
        }

        private void pot_Click(object sender, EventArgs e)
        {
            double a, b = 0;
            if (double.TryParse(sumando1.Text, out a) && double.TryParse(sumando2.Text, out b))
            {
                resultados.Items.Insert(0, op.potencia(a, b));
            }
            else MessageBox.Show("No has insertado 2 números");
        }

        private void raiz_Click(object sender, EventArgs e)
        {
            double a, b = 0;
            if (double.TryParse(sumando1.Text, out a) && double.TryParse(sumando2.Text, out b))
            {
                if(a>=0 && b>=0) resultados.Items.Insert(0, op.raiz(a, b));
                else MessageBox.Show("No puedes operar con números negativos");
            }
            else MessageBox.Show("No has insertado 2 números");
        }
    }
}
