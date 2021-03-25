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
using System.Threading;

namespace Servidor
{
    public partial class Servidor : Form
    {
        UdpClient clienteUDP;
        IPEndPoint remote;
        private delegate void SafeCallDelegate(string text);
        public Servidor()
        {

            clienteUDP = new UdpClient(8080);
            IPAddress multicast = IPAddress.Parse("224.1.0.1");
            clienteUDP.JoinMulticastGroup(multicast);
            remote = null;

            Thread hilo = new Thread(new ThreadStart(hilo_metodo));

            hilo.Start();
            hilo.IsBackground = true;

            Controls.Add(mensajes);
            Controls.Add(ultimo_mensaje);

            InitializeComponent();
            
    }

        private void hilo_metodo()
        {
            while (true)
            {
                Byte[] mensaje = clienteUDP.Receive(ref remote);
                string mensaje_usuario = Encoding.UTF8.GetString(mensaje);
                WriteMensaje(mensaje_usuario);
                WriteUltimoMensaje(mensaje_usuario);
            }
        }

        private void WriteUltimoMensaje(string text)
        {
            if (ultimo_mensaje.InvokeRequired)
            {
                var d = new SafeCallDelegate(WriteUltimoMensaje);
                ultimo_mensaje.Invoke(d, new object[] { text });
            }
            else
            {
                ultimo_mensaje.Text = text;
            }
        }

        private void WriteMensaje(string text)
        {
            if (mensajes.InvokeRequired)
            {
                var d = new SafeCallDelegate(WriteMensaje);
                mensajes.Invoke(d, new object[] { text });
            }
            else
            {
                mensajes.Items.Insert(0,text);
            }
        }

        private void clear_Click(object sender, EventArgs e)
        {
            mensajes.Items.Clear();
        }
    }
}
