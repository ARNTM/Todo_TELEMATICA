using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Net;
using System.Net.Sockets;

namespace Cliente
{
    public partial class Cliente : Form
    {
        UdpClient clienteUDP;
        IPEndPoint remote;
        public Cliente()
        {
            clienteUDP = new UdpClient();
            IPAddress multicast = IPAddress.Parse("224.1.0.1");
            clienteUDP.JoinMulticastGroup(multicast);
            remote = new IPEndPoint(multicast, 8080);
            InitializeComponent();
        }

        private void enviar_Click(object sender, EventArgs e)
        {
            if (name.Text == "") { MessageBox.Show("Inserta un nombre para enviar mensajes."); }
            else if (mensajes.Text == "") { MessageBox.Show("Escribe algún mensaje para enviar."); }
            else
            {
                Byte[] mensaje = Encoding.UTF8.GetBytes(name.Text + ": " + mensajes.Text);
                mensajes_enviados.Items.Insert(0, mensajes.Text);
                clienteUDP.Send(mensaje, mensaje.Length, remote);
                mensajes.Text = "";
            }
        }
    }
}
