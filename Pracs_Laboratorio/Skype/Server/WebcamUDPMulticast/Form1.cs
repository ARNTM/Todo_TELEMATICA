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
using Microsoft.DirectX.DirectSound;
using System.Threading;
using System.Drawing.Text;
using ALaw;



// IMAGE
using System.Drawing.Imaging;

namespace WebcamUDPMulticast
{
    public partial class Form1 : Form
    {
        private CameraFrameSource _frameSource;
        private static Bitmap _latestFrame;
        private UdpClient ServidorUDP; // Necesaria inicialización
        private int UDP_PORT = 20989;
        private IPEndPoint remote;
        private IPAddress multicastaddress;
        private int nImagen = 0;
        private int chunkS = 2500;

        // En primer lugar, esto actua como receptor de mensajes
        private UdpClient ClienteUDPchat;
        private int puertoUDPchatCliente = 20993;
        private IPEndPoint remoteChatCliente;
        private String textoMensaje;
        private Socket socketClienteChat;
        private Byte[] bufferClienteChat;
        delegate void StringArgReturningVoidDelegate(string text);

        // Tambien debe actua como servidor
        private int puertoUDPchatServidor = 20995;
        private UdpClient ServidorUDPchat;
        private IPEndPoint remoteChatServidor;

        private bool iniciado = false;

        //AUDIO

        private CaptureDevicesCollection coleccionMicrofono;

        public Form1()
        {
            InitializeComponent();
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            send.Enabled = false;
            transmision.Enabled = false;

            foreach (Camera cam in CameraService.AvailableCameras)
            {
                seleccionCam.Items.Add(cam);
            }

            //coleccionMicrofono = new CaptureDevicesCollection();
            /*for (int i = 0; i < coleccionDispositivosCaptura.Count; i++)
            {
                DeviceInformation mic = coleccionDispositivosCaptura[i];
                seleccionMic.Items.Add(mic.Description);
            }*/

        }

        private void transmision_Click(object sender, EventArgs e)
        {
            if (name.Text != "")
            {
                if (transmision.Text == "Comenzar transmisión") {
                    CambioCamara();
                    IniciarCaptura();
                    iniciado = true;
                    name.Enabled = false;

                }

                else if (transmision.Text == "Detener transmisión")
                {
                    CambioCamara();
                    byte[] bufferSalidaMensajes = Encoding.UTF8.GetBytes(";La video conferencia ha finalizado"); 
                    ServidorUDPchat.Send(bufferSalidaMensajes, bufferSalidaMensajes.Length, remoteChatServidor);
                    transmision.Text = "Comenzar transmisión";
                    iniciado = false;
                }

            }
            else { MessageBox.Show("Para unirte a la videoconferencia tienes que introducir un nombre", "Error"); }

        }

        private void CambioCamara()
        {
            if (_frameSource != null)
            {
                _frameSource.NewFrame -= OnImageCaptured;
                _frameSource.Camera.Dispose();
                setFrameSource(null);
                cam.Paint -= new PaintEventHandler(drawLatestImage);
                cam.Image = global::WebcamUDPMulticast.Properties.Resources.ba90873c887ab58970a7e946158d24fe_pantalla_de_prueba_de_television_sin_senal_ilustracion_vectorial;
            }
        }

        private void IniciarCaptura()
        {
            try
            {
                Camera c = (Camera)seleccionCam.SelectedItem;
                setFrameSource(new CameraFrameSource(c));
                _frameSource.Camera.CaptureWidth = 360;
                _frameSource.Camera.CaptureHeight = 240;
                _frameSource.Camera.Fps = 30;
                _frameSource.NewFrame += OnImageCaptured;
                cam.Paint += new PaintEventHandler(drawLatestImage);
                _frameSource.StartFrameCapture();
                transmision.Text = "Detener transmisión";
                iniciado = false;
                send.Enabled = true;
            }

            catch
            {
                MessageBox.Show("Selecciona una cámara", "Error");
                CambioCamara();
                transmision.Text = "Comenzar transmisión";
                iniciado = false;
            }
        }

        private void iniciarVideo() {
                ServidorUDP = new UdpClient();
                this.remote = new IPEndPoint(multicastaddress, UDP_PORT);
                ServidorUDP.JoinMulticastGroup(multicastaddress);
        }

        public void iniciarServicioAudio()
        {

        }

        private void iniciarChat()
        {

            //Damos de alta el servidor
            this.ServidorUDPchat = new UdpClient();
            this.remoteChatServidor = new IPEndPoint(multicastaddress, puertoUDPchatServidor);
            ServidorUDPchat.JoinMulticastGroup(multicastaddress);


            this.ClienteUDPchat = new UdpClient();
            this.remoteChatCliente = new IPEndPoint(IPAddress.Any, this.puertoUDPchatCliente); 
            ClienteUDPchat.JoinMulticastGroup(multicastaddress);

            this.socketClienteChat = ClienteUDPchat.Client;
            this.socketClienteChat.SetSocketOption(SocketOptionLevel.Socket, SocketOptionName.Broadcast, true);
            this.socketClienteChat.Bind(remoteChatCliente);

            Task clienteChat = new Task(recibirMensajesChat); 
            clienteChat.Start();
        }

        private void recibirMensajesChat()
        {
            while (true)
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
                if (s[0] != "" && s[0] != "pG09Evag")
                {
                    this.chat.SelectionFont = new Font(this.chat.Font, FontStyle.Bold);
                    this.chat.AppendText("> " + s[0] + ": ");
                    this.chat.SelectionFont = new Font(this.chat.Font, FontStyle.Regular);
                    this.chat.AppendText(s[1]);
                    this.chat.AppendText(Environment.NewLine);
                    this.chat.ScrollToCaret();
                }
                else {
                    if (s[0] == "pG09Evag")
                    {
                        if (resolucion.Text == "1080x720")
                        {
                            resolucion.Text = "720x480";
                        }
                        else if (resolucion.Text == "720x480")
                        {
                            resolucion.Text = "320x240";
                        }
                    }
                    else {
                        this.chat.SelectionFont = new Font(this.chat.Font, FontStyle.Bold);
                        this.chat.AppendText(s[1]);
                        this.chat.AppendText(Environment.NewLine);
                        this.chat.ScrollToCaret();
                    }

                }
            }
        }

        private void setFrameSource(CameraFrameSource cameraFrameSource)
        {
    
            if (_frameSource != cameraFrameSource)
            {
                _frameSource = cameraFrameSource;
            }
        }

        public void OnImageCaptured(Touchless.Vision.Contracts.IFrameSource frameSource, Touchless.Vision.Contracts.Frame frame, double fps)
        {
            _latestFrame = frame.Image;
            cam.Invalidate();
        }

        private void drawLatestImage(object sender, PaintEventArgs e)
        {
            if (_latestFrame != null)
            {
                string[] s = resolucion.Text.Split('x');
                _latestFrame = new Bitmap(_latestFrame, new Size(Convert.ToInt32(s[0]), Convert.ToInt32(s[0])));
                e.Graphics.DrawImage(_latestFrame, 0, 0, cam.Width, cam.Height);
                nImagen++;
                if (nImagen == 2147483647)
                {
                    nImagen = 0;
                }

                MemoryStream ms = new MemoryStream(); 
                Bitmap mapaImagen = new Bitmap(_latestFrame, new Size(Convert.ToInt32(s[0]), Convert.ToInt32(s[0])));
                mapaImagen.Save(ms, ImageFormat.Jpeg);

                Byte[][] chunks = BufferSplit(ms.ToArray(), chunkS);
                Byte[] timestamp = BitConverter.GetBytes(DateTime.Now.ToBinary()); // 8 bytes
                Byte[] totalPaquetes = BitConverter.GetBytes(chunks.Length); // 4 bytes
                Byte[] totalSize = BitConverter.GetBytes(ms.ToArray().Length); // 4 bytes
                Byte[] nImagenBytes = BitConverter.GetBytes(nImagen); // 4 bytes
                Byte[] chunkSize = BitConverter.GetBytes(chunkS); // 4 bytes

                for (int i = 0; i < chunks.Length; i++) {
                    Byte[] nSecuencia = BitConverter.GetBytes(i); // 4 bytes
                    Byte[] cabecera = Combine(Combine(Combine(timestamp, nImagenBytes), Combine(nSecuencia, totalPaquetes)),Combine(totalSize, chunkSize));
                    ServidorUDP.Send(Combine(cabecera, chunks[i]), Combine(cabecera, chunks[i]).Length, this.remote);
                }
                
            }
        }

        private void send_Click(object sender, EventArgs e)
        {
            try
            {
                this.chat.SelectionFont = new Font(this.chat.Font, FontStyle.Bold);
                chat.AppendText("> " + name.Text + ": ");
                this.chat.SelectionFont = new Font(this.chat.Font, FontStyle.Regular);
                chat.AppendText(mensaje.Text);
                chat.AppendText(Environment.NewLine);
                this.chat.ScrollToCaret();
                byte[] bufferSalidaMensajes = Encoding.UTF8.GetBytes(name.Text + ";"+ mensaje.Text); // Pasamos al buffer el mensaje
                ServidorUDPchat.Send(bufferSalidaMensajes, bufferSalidaMensajes.Length, remoteChatServidor);
                mensaje.Clear();
            }
            catch
            {
                MessageBox.Show("Se ha producido un error al enviar el mensaje");
            }
        }

        public static byte[][] BufferSplit(byte[] buffer, int blockSize)
        {
            byte[][] blocks = new byte[(buffer.Length + blockSize - 1) / blockSize][];

            for (int i = 0, j = 0; i < blocks.Length; i++, j += blockSize)
            {
                blocks[i] = new byte[Math.Min(blockSize, buffer.Length - j)];
                Array.Copy(buffer, j, blocks[i], 0, blocks[i].Length);
            }

            return blocks;
        }

        public static byte[] Combine(byte[] first, byte[] second)
        {
            byte[] bytes = new byte[first.Length + second.Length];
            System.Buffer.BlockCopy(first, 0, bytes, 0, first.Length);
            System.Buffer.BlockCopy(second, 0, bytes, first.Length, second.Length);
            return bytes;
        }

        private void seleccionCam_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (iniciado)
            {
                CambioCamara();
                IniciarCaptura();
            }

        }

        private void initService_Click(object sender, EventArgs e)
        {
            try
            {
                multicastaddress = IPAddress.Parse(ipText.Text);
                iniciarVideo();
                iniciarChat();
                iniciarServicioAudio();
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
