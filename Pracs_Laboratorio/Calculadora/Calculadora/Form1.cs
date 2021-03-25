using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using BibliotecaDeClases;
using operaciones;

namespace Calculadora
{
    public partial class Form1 : Form
    {
        operaciones.operaciones op = new operaciones.operaciones();
        public Form1()
        {
            InitializeComponent();
        }



        private void suma_Click(object sender, EventArgs e)
        {
            double a, b = 0;
            if (double.TryParse(sumando1.Text, out a) && double.TryParse(sumando2.Text, out b))
            {
                resultados.Items.Insert(0, op.sumar(a,b));
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


    }
}
