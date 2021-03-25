using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace SumaPSNR
{
    public partial class Form1 : Form
    {
        private double suma_psnr = 0.0;
        private int n_test = 1;
        private int[,] orig_m = new int[80, 100];
        private int[,] client_m = new int[80, 100];
        private double dif_cuadrado = 0.0;
        private double E_rms = 0.0;
        private double psnrcalc = 0.0;
        private double mediacalc = 0.0;

        public Form1()
        {
            InitializeComponent();
            this.suma_psnr = this.test();
        }

        private double test()
        {
            Random random = new Random(new Random().Next(0, 100));
            this.enviada.Clear();
            this.recibida.Clear();
            for (int index1 = 0; index1 < 80; ++index1)
            {
                for (int index2 = 0; index2 < 100; ++index2)
                {
                    this.orig_m[index1, index2] = random.Next(1, 9);
                    this.enviada.AppendText(this.orig_m[index1, index2].ToString());
                }
                this.enviada.AppendText("\n");
            }
            for (int index1 = 0; index1 < 80; ++index1)
            {
                for (int index2 = 0; index2 < 100; ++index2)
                {
                    this.client_m[index1, index2] = random.Next(1, 4);
                    this.recibida.AppendText(this.client_m[index1, index2].ToString());
                }
                this.recibida.AppendText("\n");
            }
            for (int index1 = 0; index1 < 80; ++index1)
            {
                for (int index2 = 0; index2 < 100; ++index2)
                    this.dif_cuadrado += Math.Pow((double)(this.orig_m[index1, index2] - this.client_m[index1, index2]), 2.0);
            }
            this.E_rms = Math.Sqrt(this.dif_cuadrado / 8000.0);
            this.psnrcalc = 20.0 * Math.Log10((double)byte.MaxValue / this.E_rms);
            this.psnr.Text = string.Concat((object)this.psnrcalc);
            this.suma_psnr += this.psnrcalc;
            return this.suma_psnr;
        }

        private void actualizar_Click(object sender, EventArgs e)
        {
            ++this.n_test;
            this.suma_psnr = this.test();
            this.mediacalc = this.suma_psnr / (double)this.n_test;
            this.media.Text = string.Concat((object)this.mediacalc);
        }
    }
}
