using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using Touchless.Vision.Camera;
using System.Threading.Tasks;

// UDP y Multicast.
using System.Net.Sockets;
using System.Net;
using System.IO;

// IMAGE
using System.Drawing.Imaging;

namespace WebcamUDPMulticast
{
    public partial class Form1 : Form
    {

        private UdpClient clienteUDP;
        private int puertoVideo = 20989;
        private IPEndPoint remote;
        private IPAddress multicastaddress;

        private Socket socketVideo;
        private Byte[] buffer;

        private int imagenesR;
        private int paqueteR = 0;
        private int paquetesPerdidos = 0;
        private int auxPP = 0;
        private Byte[] imagenCompleta = null;
        private int[] jitterArray = null;
        private Task t1;
        private bool inicio = false;
        private bool parado = false;


        private UdpClient ClienteUDPchat;
        private int puertoUDPchatCliente = 20995;
        private IPEndPoint remoteChatCliente;
        private String textoMensaje;
        private Socket socketClienteChat;
        private Byte[] bufferClienteChat;
        delegate void StringArgReturningVoidDelegate(string text);
        private Task clienteChat;

        private UdpClient ServidorUDPchat;
        private IPEndPoint remoteChatServidor;
        private int puertoUDPchatServidor = 20993;

        public Form1()
        {
            InitializeComponent();
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            ping.Text = "";
            perdidos.Text = "";
            jitter.Text = "No hay conexión";
            send.Enabled = false;
            transmision.Enabled = false;
        }

        private void transmision_Click(object sender, EventArgs e)
        {
            if (transmision.Text == "Unirse a la transmisión")
            {
                if (name.Text != "")
                {
                    send.Enabled = true;
                    name.Enabled = false;
                    iniciarVideo();
                    iniciarChat();
                    inicio = true;
                    byte[] bufferSalidaMensajes = Encoding.UTF8.GetBytes(";" + name.Text + " se ha unido a la videoconferencia");
                    ServidorUDPchat.Send(bufferSalidaMensajes, bufferSalidaMensajes.Length, remoteChatServidor);
                    transmision.Text = "Viendo videoconferencia";
                    transmision.Enabled = false;
                }
                else { MessageBox.Show("Para unirte a la videoconferencia tienes que introducir un nombre", "Error"); }
            }
        }
        private void iniciarVideo()
        {
            this.clienteUDP = new UdpClient();
            this.remote = new IPEndPoint(IPAddress.Any, this.puertoVideo);
            this.clienteUDP.JoinMulticastGroup(this.multicastaddress);


            this.socketVideo = clienteUDP.Client;
            this.socketVideo.SetSocketOption(SocketOptionLevel.Socket, SocketOptionName.Broadcast, true);
            this.socketVideo.Bind(remote);



            t1 = new Task(visualizar_imagen); 
            t1.Start();
            
        }

        private void iniciarChat()
        {
            this.ServidorUDPchat = new UdpClient();
            this.remoteChatServidor = new IPEndPoint(multicastaddress, puertoUDPchatServidor);
            ServidorUDPchat.JoinMulticastGroup(multicastaddress);


            this.ClienteUDPchat = new UdpClient();
            this.remoteChatCliente = new IPEndPoint(IPAddress.Any, this.puertoUDPchatCliente);
            ClienteUDPchat.JoinMulticastGroup(multicastaddress);

            this.socketClienteChat = ClienteUDPchat.Client; 
            this.socketClienteChat.SetSocketOption(SocketOptionLevel.Socket, SocketOptionName.Broadcast, true);
            this.socketClienteChat.Bind(remoteChatCliente); 

            clienteChat = new Task(recibirMensajesChat);
            clienteChat.Start();
        }

        private void recibirMensajesChat()
        {
            while (inicio)
            {

                this.bufferClienteChat = ClienteUDPchat.Receive(ref remoteChatCliente);
                textoMensaje = Encoding.UTF8.GetString(bufferClienteChat, 0, bufferClienteChat.Length);
                reflejarMensaje(textoMensaje);

            }
        }

        private void reflejarMensaje(string textoMensaje)
        {


            if (this.chat.InvokeRequired)
            {
                StringArgReturningVoidDelegate delegado = new StringArgReturningVoidDelegate(reflejarMensaje);
                this.Invoke(delegado, new object[] { textoMensaje });

            }
            else
            {
                string[] s = textoMensaje.Split(';');
                if (s[0] != "")
                {
                    this.chat.SelectionFont = new Font(this.chat.Font, FontStyle.Bold);
                    this.chat.AppendText("> " + s[0] + ": ");
                    this.chat.SelectionFont = new Font(this.chat.Font, FontStyle.Regular);
                    this.chat.AppendText(s[1]);
                    this.chat.AppendText(Environment.NewLine);
                    this.chat.ScrollToCaret();
                }
                else
                {

                    this.chat.SelectionFont = new Font(this.chat.Font, FontStyle.Bold);
                    this.chat.AppendText(s[1]);
                    this.chat.AppendText(Environment.NewLine);
                    this.chat.ScrollToCaret();
                    if (s[1] == "La video conferencia ha finalizado") {
                        ping.Text = "";
                        jitter.Text = "No hay conexión";
                        perdidos.Text = "";
                        cam.Image = global::WebcamUDPMulticast.Properties.Resources.ba90873c887ab58970a7e946158d24fe_pantalla_de_prueba_de_television_sin_senal_ilustracion_vectorial;
                    }
                }
            }
        }

        private void reflejarPing(string p)
        {


            if (this.ping.InvokeRequired)
            {
                StringArgReturningVoidDelegate delegado = new StringArgReturningVoidDelegate(reflejarPing);
                this.Invoke(delegado, new object[] { p });

            }
            else
            {
                ping.Text = p;
            }
        }

        private void reflejarJitter(string j)
        {


            if (this.jitter.InvokeRequired)
            {
                StringArgReturningVoidDelegate delegado = new StringArgReturningVoidDelegate(reflejarJitter);
                this.Invoke(delegado, new object[] { j });

            }
            else
            {
                jitter.Text = j;
            }
        }

        private void reflejarPerdidas(string j)
        {


            if (this.perdidos.InvokeRequired)
            {
                StringArgReturningVoidDelegate delegado = new StringArgReturningVoidDelegate(reflejarPerdidas);
                this.Invoke(delegado, new object[] { j });

            }
            else
            {
                perdidos.Text = j;
            }
        }

        private void visualizar_imagen()
        {

            while (inicio)
            {
                try
                {
                    this.buffer = clienteUDP.Receive(ref remote);

                    Byte[] timestamp = this.buffer.Take(8).ToArray();
                    Byte[] nImagenBytes = this.buffer.Skip(8).Take(4).ToArray();
                    Byte[] nSecuencia = this.buffer.Skip(12).Take(4).ToArray();
                    Byte[] totalPaquetes = this.buffer.Skip(16).Take(4).ToArray();
                    Byte[] totalSize = this.buffer.Skip(20).Take(4).ToArray();
                    Byte[] chunkSize = this.buffer.Skip(24).Take(4).ToArray();

                    DateTime timestampRecibido = DateTime.FromBinary(BitConverter.ToInt64(timestamp, 0));
                    DateTime timestampActual = DateTime.Now;
                    int nImagenRecibidaInt = BitConverter.ToInt32(nImagenBytes, 0);
                    int nSecuenciaRecibidaInt = BitConverter.ToInt32(nSecuencia, 0);
                    int totalPaquetesInt = BitConverter.ToInt32(totalPaquetes, 0);
                    int totalSizeInt = BitConverter.ToInt32(totalSize, 0);
                    int chunkSizeInt = BitConverter.ToInt32(chunkSize, 0);

                    int ping = timestampActual.TimeOfDay.Milliseconds - timestampRecibido.TimeOfDay.Milliseconds;
                    reflejarPing("Ping: " + ping.ToString() + " ms");

                    Byte[] chunkImg = this.buffer.Skip(28).ToArray();

                    Console.WriteLine("Numero de imagen recibida: " + nImagenRecibidaInt);
                    Console.WriteLine("Numero de secuencia recibida: " + nSecuenciaRecibidaInt);
                    Console.WriteLine("Paquetes totales: " + totalPaquetesInt);
                    Console.WriteLine("Tamaño total: " + totalSizeInt);
                    Console.WriteLine("----- Paquetes actual: " + paqueteR + "-----");

                    if (nSecuenciaRecibidaInt == 0) //PRIMER PAQUETE
                    {

                        imagenCompleta = new byte[totalSizeInt];
                        jitterArray = new int[totalPaquetesInt];
                        imagenesR = nImagenRecibidaInt;
                        paqueteR++;
                        jitterArray[nSecuenciaRecibidaInt] = ping;

                        Array.Copy(chunkImg, 0, imagenCompleta, 0, chunkImg.Length);

                        Console.WriteLine("==  Secuencia " + nSecuenciaRecibidaInt + " ==");
                        Console.WriteLine("==  Procesando imagen " + imagenesR + " ==");
                    }

                    else {
                        if (imagenesR == nImagenRecibidaInt && paqueteR == totalPaquetesInt - 1)
                        { //ULTIMO PAQUETE

                            Array.Copy(chunkImg, 0, imagenCompleta, nSecuenciaRecibidaInt * chunkSizeInt, chunkImg.Length);

                            jitterArray[nSecuenciaRecibidaInt] = ping;
                            paqueteR = 0;

                            MemoryStream ms_video = new MemoryStream(imagenCompleta);
                            cam.Image = new Bitmap(Image.FromStream(ms_video), new Size(cam.Width, cam.Height)); //REPRESENTAMOS IMAGEN

                            reflejarJitter("Jitter: " + calculaJitter(jitterArray).ToString() + " ms");
                            Console.WriteLine("============= IMAGEN REPRESENTADA =============");
                        }
                        else {
                            if (imagenesR == nImagenRecibidaInt && paqueteR == nSecuenciaRecibidaInt) // CUALQUIER OTRO PAQUETE
                            {
                                Array.Copy(chunkImg, 0, imagenCompleta, nSecuenciaRecibidaInt * chunkSizeInt, chunkImg.Length);
                                jitterArray[nSecuenciaRecibidaInt] = ping;
                                paqueteR++;
                            }
                            else {
                                if (paqueteR > totalPaquetesInt)
                                {
                                    paqueteR = nSecuenciaRecibidaInt;
                                }
                                else {
                                    paquetesPerdidos++;
                                    auxPP++;
                                    reflejarPerdidas("Paquetes perdidos: " + paquetesPerdidos);
                                    if (auxPP == 50) {
                                        auxPP = 0;
                                        byte[] bufferSalidaMensajes = Encoding.UTF8.GetBytes("pG09Evag;");
                                        ServidorUDPchat.Send(bufferSalidaMensajes, bufferSalidaMensajes.Length, remoteChatServidor);
                                    }
                                    
                                }
                            }
                        }
                    }

                    /*if (nSecuenciaRecibidaInt == 0)
                    {
                        Console.WriteLine("==  Secuencia " + nSecuenciaRecibidaInt + " ==");
                        imagenCompleta = new byte[totalSizeInt];
                        jitterArray = new int[totalPaquetesInt];
                        imagenesR = nImagenRecibidaInt;
                        Console.WriteLine("==  Procesando imagen " + imagenesR + " ==");
                        paqueteR++;
                        Array.Copy(chunkImg, 0, imagenCompleta, 0, chunkImg.Length);
                        jitterArray[nSecuenciaRecibidaInt] = ping;
                    }
                    else if (paqueteR == totalPaquetesInt - 1)
                    {
                        if (nImagenRecibidaInt == imagenesR && paqueteR < totalPaquetesInt)
                        {
                            Console.WriteLine("============= IMAGEN REPRESENTADA =============");
                            Array.Copy(chunkImg, 0, imagenCompleta, nSecuenciaRecibidaInt * chunkSizeInt, chunkImg.Length);
                            jitterArray[nSecuenciaRecibidaInt] = ping;
                            reflejarJitter("Jitter: " + calculaJitter(jitterArray).ToString() + " ms");
                            paqueteR = 0;
                            MemoryStream ms_video = new MemoryStream(imagenCompleta);
                            cam.Image = new Bitmap(Image.FromStream(ms_video), new Size(cam.Width, cam.Height));
                        }

                    }
                    else if (paqueteR >= totalPaquetesInt || nImagenRecibidaInt != imagenesR) {
                        paqueteR = nSecuenciaRecibidaInt;
                        imagenCompleta = new byte[totalSizeInt];
                        imagenesR = nImagenRecibidaInt;
                    }
                    else
                    {
                        if (nImagenRecibidaInt == imagenesR)
                        {
                            Array.Copy(chunkImg, 0, imagenCompleta, nSecuenciaRecibidaInt * chunkSizeInt, chunkImg.Length);
                            jitterArray[nSecuenciaRecibidaInt] = ping;
                            paqueteR++;
                        }
                    }*/

                }
                catch
                {

                }

            }
        }

        private void send_Click(object sender, EventArgs e)
        {
            try
            {
                this.chat.SelectionFont = new Font(this.chat.Font, FontStyle.Bold);
                chat.AppendText("> "+ name.Text +": ");
                this.chat.SelectionFont = new Font(this.chat.Font, FontStyle.Regular);
                chat.AppendText(mensaje.Text);
                chat.AppendText(Environment.NewLine);
                this.chat.ScrollToCaret();
                byte[] bufferSalidaMensajes = Encoding.UTF8.GetBytes(name.Text + ";" + mensaje.Text); // Pasamos al buffer el mensaje
                ServidorUDPchat.Send(bufferSalidaMensajes, bufferSalidaMensajes.Length, remoteChatServidor);
                mensaje.Clear();
            }
            catch
            {
                MessageBox.Show("Se ha producido un error al enviar el mensaje");
            }
        }

        private double calculaJitter(int[] j) {
            
            if (j.Length < 2) { return 0.0; }

            double jitterS = 0.0;

            for (int i = 0 ; i< j.Length; i++) {
                if (i > 0) jitterS += Math.Abs(j[i-1] - j[i]);
            }

            return Math.Round(jitterS / (j.Length - 1) ,2) ;
        }

        private void initService_Click(object sender, EventArgs e)
        {
            try
            {
                multicastaddress = IPAddress.Parse(ipText.Text);
                transmision.Enabled = true;
                ipText.Enabled = false;
                textoAlerta.Text = "Servicios inicializados correctamente. Ya puede iniciar su videoconferencia";
                textoAlerta.ForeColor = System.Drawing.Color.Green;
            }
            catch
            {
                MessageBox.Show("Introduce una IP válida", "Error");
            }
        }
    }
}
