using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Drawing.Imaging;

namespace Convertidor
{
    public partial class Form1 : Form
    {

        private Bitmap imagen;
        public Form1()
        {
            InitializeComponent();
        }

        private void comboBox1_SelectedIndexChanged(object sender, EventArgs e)
        {
        }

        private void abrir_Click(object sender, EventArgs e)
        {
            OpenFileDialog ofd = new OpenFileDialog();
            ofd.Filter = this.seleccionabrir.Text + "|" + this.seleccionabrir.Text;
            if (ofd.Filter.Length > 1)
            {
                DialogResult dr = ofd.ShowDialog();
                if (dr == DialogResult.OK)
                {
                    imagen = new Bitmap(ofd.FileName);
                    imagenmostrada.Image = imagen;
                }
                else if (dr != DialogResult.Cancel) { MessageBox.Show("Error al abrir el archivo", "Error"); }
            }
            else { MessageBox.Show("Debes seleccionar una opción para abrir una imagen", "Error");}

        }

        private void comboBox2_SelectedIndexChanged(object sender, EventArgs e)
        {
        }

        private void guardar_Click(object sender, EventArgs e)
        {
            SaveFileDialog sfd = new SaveFileDialog();
            sfd.Filter = this.seleccionguardar.Text + "|" + this.seleccionguardar.Text;
            if (sfd.Filter.Length > 1 && imagen != null)
            {
                DialogResult dr = sfd.ShowDialog();
                if (dr == DialogResult.OK)
                {
                    String opcion = this.seleccionguardar.Text;
                    switch (opcion) {
                        case "*.bmp":
                            imagen.Save(sfd.FileName, ImageFormat.Bmp);
                            break;
                        case "*.jpg":
                            imagen.Save(sfd.FileName, ImageFormat.Jpeg);
                            break;
                        case "*.emf":
                            imagen.Save(sfd.FileName, ImageFormat.Emf);
                            break;
                        case "*.exif":
                            imagen.Save(sfd.FileName, ImageFormat.Exif);
                            break;
                        case "*.gif":
                            imagen.Save(sfd.FileName, ImageFormat.Gif);
                            break;
                        case "*.jpeg":
                            imagen.Save(sfd.FileName, ImageFormat.Jpeg);
                            break;
                        case "*.png":
                            imagen.Save(sfd.FileName, ImageFormat.Png);
                            break;
                        case "*.tiff":
                            imagen.Save(sfd.FileName, ImageFormat.Tiff);
                            break;
                        case "*.wmf":
                            imagen.Save(sfd.FileName, ImageFormat.Wmf);
                            break;
                    }

                    MessageBox.Show("Imagen convertida exitosamente", "Imagen convertida");
                }
                else if (dr != DialogResult.Cancel) { MessageBox.Show("Error al guardar el archivo", "Error"); }
            }

            else { MessageBox.Show("Debes seleccionar una opción de guardado y tener una imagen abierta", "Error"); }
        }

        private void label1_Click(object sender, EventArgs e)
        {

        }

        private void alertas_Click(object sender, EventArgs e)
        {

        }

        private void label3_Click(object sender, EventArgs e)
        {

        }

        private void textBox1_TextChanged(object sender, EventArgs e)
        {

        }
    }
}
