namespace WebcamUDPMulticast
{
    partial class Form1
    {
        /// <summary>
        /// Variable del diseñador necesaria.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Limpiar los recursos que se estén usando.
        /// </summary>
        /// <param name="disposing">true si los recursos administrados se deben desechar; false en caso contrario.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Código generado por el Diseñador de Windows Forms

        /// <summary>
        /// Método necesario para admitir el Diseñador. No se puede modificar
        /// el contenido de este método con el editor de código.
        /// </summary>
        private void InitializeComponent()
        {
            this.general = new System.Windows.Forms.TableLayoutPanel();
            this.configuraciones = new System.Windows.Forms.TableLayoutPanel();
            this.initService = new System.Windows.Forms.Button();
            this.textSeleccionName = new System.Windows.Forms.Label();
            this.name = new System.Windows.Forms.TextBox();
            this.ip = new System.Windows.Forms.Label();
            this.ipText = new System.Windows.Forms.TextBox();
            this.tablazonacam = new System.Windows.Forms.TableLayoutPanel();
            this.cam = new System.Windows.Forms.PictureBox();
            this.tableLayoutPanel1 = new System.Windows.Forms.TableLayoutPanel();
            this.textoAlerta = new System.Windows.Forms.Label();
            this.transmision = new System.Windows.Forms.Button();
            this.chatzone = new System.Windows.Forms.TableLayoutPanel();
            this.chat = new System.Windows.Forms.RichTextBox();
            this.escribirzone = new System.Windows.Forms.TableLayoutPanel();
            this.mensaje = new System.Windows.Forms.RichTextBox();
            this.send = new System.Windows.Forms.Button();
            this.estadisticas = new System.Windows.Forms.TableLayoutPanel();
            this.ping = new System.Windows.Forms.Label();
            this.jitter = new System.Windows.Forms.Label();
            this.perdidos = new System.Windows.Forms.Label();
            this.general.SuspendLayout();
            this.configuraciones.SuspendLayout();
            this.tablazonacam.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.cam)).BeginInit();
            this.tableLayoutPanel1.SuspendLayout();
            this.chatzone.SuspendLayout();
            this.escribirzone.SuspendLayout();
            this.estadisticas.SuspendLayout();
            this.SuspendLayout();
            // 
            // general
            // 
            this.general.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.general.ColumnCount = 2;
            this.general.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 50F));
            this.general.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 50F));
            this.general.Controls.Add(this.configuraciones, 0, 0);
            this.general.Controls.Add(this.tablazonacam, 0, 1);
            this.general.Controls.Add(this.chatzone, 1, 1);
            this.general.Controls.Add(this.estadisticas, 1, 0);
            this.general.Location = new System.Drawing.Point(16, 15);
            this.general.Margin = new System.Windows.Forms.Padding(4);
            this.general.Name = "general";
            this.general.RowCount = 2;
            this.general.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 15.78073F));
            this.general.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 84.21927F));
            this.general.Size = new System.Drawing.Size(1565, 741);
            this.general.TabIndex = 0;
            // 
            // configuraciones
            // 
            this.configuraciones.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.configuraciones.ColumnCount = 2;
            this.configuraciones.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 41.48021F));
            this.configuraciones.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 58.51979F));
            this.configuraciones.Controls.Add(this.initService, 0, 2);
            this.configuraciones.Controls.Add(this.textSeleccionName, 0, 0);
            this.configuraciones.Controls.Add(this.name, 1, 0);
            this.configuraciones.Controls.Add(this.ip, 0, 1);
            this.configuraciones.Controls.Add(this.ipText, 1, 1);
            this.configuraciones.Location = new System.Drawing.Point(4, 4);
            this.configuraciones.Margin = new System.Windows.Forms.Padding(4);
            this.configuraciones.Name = "configuraciones";
            this.configuraciones.RowCount = 3;
            this.configuraciones.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 33.33333F));
            this.configuraciones.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 33.33333F));
            this.configuraciones.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 33.33333F));
            this.configuraciones.Size = new System.Drawing.Size(774, 108);
            this.configuraciones.TabIndex = 0;
            // 
            // initService
            // 
            this.initService.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.initService.Location = new System.Drawing.Point(4, 76);
            this.initService.Margin = new System.Windows.Forms.Padding(4);
            this.initService.Name = "initService";
            this.initService.Size = new System.Drawing.Size(313, 28);
            this.initService.TabIndex = 8;
            this.initService.Text = "Iniciar servicios";
            this.initService.UseVisualStyleBackColor = true;
            this.initService.Click += new System.EventHandler(this.initService_Click);
            // 
            // textSeleccionName
            // 
            this.textSeleccionName.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.textSeleccionName.AutoSize = true;
            this.textSeleccionName.Font = new System.Drawing.Font("Arial", 11.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.textSeleccionName.ImageAlign = System.Drawing.ContentAlignment.TopLeft;
            this.textSeleccionName.Location = new System.Drawing.Point(4, 0);
            this.textSeleccionName.Margin = new System.Windows.Forms.Padding(4, 0, 4, 0);
            this.textSeleccionName.Name = "textSeleccionName";
            this.textSeleccionName.Size = new System.Drawing.Size(313, 36);
            this.textSeleccionName.TabIndex = 0;
            this.textSeleccionName.Text = "Introduce tu nombre de usuario";
            this.textSeleccionName.TextAlign = System.Drawing.ContentAlignment.MiddleLeft;
            // 
            // name
            // 
            this.name.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.name.Location = new System.Drawing.Point(325, 4);
            this.name.Margin = new System.Windows.Forms.Padding(4);
            this.name.Name = "name";
            this.name.Size = new System.Drawing.Size(445, 22);
            this.name.TabIndex = 5;
            // 
            // ip
            // 
            this.ip.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.ip.AutoSize = true;
            this.ip.Font = new System.Drawing.Font("Arial", 11.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.ip.ImageAlign = System.Drawing.ContentAlignment.TopLeft;
            this.ip.Location = new System.Drawing.Point(4, 36);
            this.ip.Margin = new System.Windows.Forms.Padding(4, 0, 4, 0);
            this.ip.Name = "ip";
            this.ip.Size = new System.Drawing.Size(313, 36);
            this.ip.TabIndex = 6;
            this.ip.Text = "Introducir IP";
            // 
            // ipText
            // 
            this.ipText.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.ipText.Location = new System.Drawing.Point(325, 40);
            this.ipText.Margin = new System.Windows.Forms.Padding(4);
            this.ipText.Name = "ipText";
            this.ipText.Size = new System.Drawing.Size(445, 22);
            this.ipText.TabIndex = 7;
            // 
            // tablazonacam
            // 
            this.tablazonacam.ColumnCount = 1;
            this.tablazonacam.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 50F));
            this.tablazonacam.Controls.Add(this.cam, 0, 0);
            this.tablazonacam.Controls.Add(this.tableLayoutPanel1, 0, 1);
            this.tablazonacam.Dock = System.Windows.Forms.DockStyle.Fill;
            this.tablazonacam.Location = new System.Drawing.Point(4, 120);
            this.tablazonacam.Margin = new System.Windows.Forms.Padding(4);
            this.tablazonacam.Name = "tablazonacam";
            this.tablazonacam.RowCount = 2;
            this.tablazonacam.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 68.26347F));
            this.tablazonacam.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 31.73653F));
            this.tablazonacam.Size = new System.Drawing.Size(774, 617);
            this.tablazonacam.TabIndex = 2;
            // 
            // cam
            // 
            this.cam.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.cam.Image = global::WebcamUDPMulticast.Properties.Resources.ba90873c887ab58970a7e946158d24fe_pantalla_de_prueba_de_television_sin_senal_ilustracion_vectorial;
            this.cam.Location = new System.Drawing.Point(4, 4);
            this.cam.Margin = new System.Windows.Forms.Padding(4);
            this.cam.Name = "cam";
            this.cam.Size = new System.Drawing.Size(766, 413);
            this.cam.SizeMode = System.Windows.Forms.PictureBoxSizeMode.Zoom;
            this.cam.TabIndex = 1;
            this.cam.TabStop = false;
            // 
            // tableLayoutPanel1
            // 
            this.tableLayoutPanel1.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.tableLayoutPanel1.ColumnCount = 1;
            this.tableLayoutPanel1.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 50F));
            this.tableLayoutPanel1.Controls.Add(this.textoAlerta, 0, 1);
            this.tableLayoutPanel1.Controls.Add(this.transmision, 0, 0);
            this.tableLayoutPanel1.Location = new System.Drawing.Point(4, 425);
            this.tableLayoutPanel1.Margin = new System.Windows.Forms.Padding(4);
            this.tableLayoutPanel1.Name = "tableLayoutPanel1";
            this.tableLayoutPanel1.RowCount = 2;
            this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 50F));
            this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 50F));
            this.tableLayoutPanel1.Size = new System.Drawing.Size(766, 188);
            this.tableLayoutPanel1.TabIndex = 2;
            // 
            // textoAlerta
            // 
            this.textoAlerta.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.textoAlerta.AutoSize = true;
            this.textoAlerta.Font = new System.Drawing.Font("Arial Black", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.textoAlerta.ForeColor = System.Drawing.Color.Red;
            this.textoAlerta.ImageAlign = System.Drawing.ContentAlignment.BottomLeft;
            this.textoAlerta.Location = new System.Drawing.Point(4, 94);
            this.textoAlerta.Margin = new System.Windows.Forms.Padding(4, 0, 4, 0);
            this.textoAlerta.Name = "textoAlerta";
            this.textoAlerta.Size = new System.Drawing.Size(758, 94);
            this.textoAlerta.TabIndex = 4;
            this.textoAlerta.Text = "Servicio no iniciado. Por favor, introduzca una IP para poder inicializar los ser" +
    "vicios";
            this.textoAlerta.TextAlign = System.Drawing.ContentAlignment.BottomLeft;
            // 
            // transmision
            // 
            this.transmision.Font = new System.Drawing.Font("Arial", 11.25F, System.Drawing.FontStyle.Bold);
            this.transmision.Location = new System.Drawing.Point(4, 4);
            this.transmision.Margin = new System.Windows.Forms.Padding(4);
            this.transmision.Name = "transmision";
            this.transmision.Size = new System.Drawing.Size(758, 65);
            this.transmision.TabIndex = 2;
            this.transmision.Text = "Unirse a la transmisión";
            this.transmision.UseVisualStyleBackColor = true;
            this.transmision.Click += new System.EventHandler(this.transmision_Click);
            // 
            // chatzone
            // 
            this.chatzone.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.chatzone.ColumnCount = 1;
            this.chatzone.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 100F));
            this.chatzone.Controls.Add(this.chat, 0, 0);
            this.chatzone.Controls.Add(this.escribirzone, 0, 1);
            this.chatzone.Location = new System.Drawing.Point(786, 120);
            this.chatzone.Margin = new System.Windows.Forms.Padding(4);
            this.chatzone.Name = "chatzone";
            this.chatzone.RowCount = 2;
            this.chatzone.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 90F));
            this.chatzone.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 10F));
            this.chatzone.Size = new System.Drawing.Size(775, 617);
            this.chatzone.TabIndex = 3;
            // 
            // chat
            // 
            this.chat.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.chat.Location = new System.Drawing.Point(4, 4);
            this.chat.Margin = new System.Windows.Forms.Padding(4);
            this.chat.Name = "chat";
            this.chat.ReadOnly = true;
            this.chat.Size = new System.Drawing.Size(767, 547);
            this.chat.TabIndex = 0;
            this.chat.Text = "";
            // 
            // escribirzone
            // 
            this.escribirzone.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.escribirzone.ColumnCount = 2;
            this.escribirzone.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 80F));
            this.escribirzone.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 20F));
            this.escribirzone.Controls.Add(this.mensaje, 0, 0);
            this.escribirzone.Controls.Add(this.send, 1, 0);
            this.escribirzone.Location = new System.Drawing.Point(4, 559);
            this.escribirzone.Margin = new System.Windows.Forms.Padding(4);
            this.escribirzone.Name = "escribirzone";
            this.escribirzone.RowCount = 1;
            this.escribirzone.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 100F));
            this.escribirzone.Size = new System.Drawing.Size(767, 54);
            this.escribirzone.TabIndex = 1;
            // 
            // mensaje
            // 
            this.mensaje.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.mensaje.Location = new System.Drawing.Point(4, 4);
            this.mensaje.Margin = new System.Windows.Forms.Padding(4);
            this.mensaje.Name = "mensaje";
            this.mensaje.Size = new System.Drawing.Size(605, 46);
            this.mensaje.TabIndex = 0;
            this.mensaje.Text = "";
            // 
            // send
            // 
            this.send.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.send.Location = new System.Drawing.Point(617, 4);
            this.send.Margin = new System.Windows.Forms.Padding(4);
            this.send.Name = "send";
            this.send.Size = new System.Drawing.Size(146, 46);
            this.send.TabIndex = 1;
            this.send.Text = "Enviar";
            this.send.UseVisualStyleBackColor = true;
            this.send.Click += new System.EventHandler(this.send_Click);
            // 
            // estadisticas
            // 
            this.estadisticas.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.estadisticas.ColumnCount = 2;
            this.estadisticas.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 50F));
            this.estadisticas.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 50F));
            this.estadisticas.Controls.Add(this.ping, 1, 0);
            this.estadisticas.Controls.Add(this.jitter, 1, 1);
            this.estadisticas.Controls.Add(this.perdidos, 1, 2);
            this.estadisticas.Location = new System.Drawing.Point(786, 4);
            this.estadisticas.Margin = new System.Windows.Forms.Padding(4);
            this.estadisticas.Name = "estadisticas";
            this.estadisticas.RowCount = 4;
            this.estadisticas.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 20F));
            this.estadisticas.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 20F));
            this.estadisticas.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 20F));
            this.estadisticas.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 40F));
            this.estadisticas.Size = new System.Drawing.Size(775, 108);
            this.estadisticas.TabIndex = 4;
            // 
            // ping
            // 
            this.ping.AutoSize = true;
            this.ping.Location = new System.Drawing.Point(391, 0);
            this.ping.Margin = new System.Windows.Forms.Padding(4, 0, 4, 0);
            this.ping.Name = "ping";
            this.ping.Size = new System.Drawing.Size(46, 17);
            this.ping.TabIndex = 0;
            this.ping.Text = "label1";
            // 
            // jitter
            // 
            this.jitter.AutoSize = true;
            this.jitter.Location = new System.Drawing.Point(391, 21);
            this.jitter.Margin = new System.Windows.Forms.Padding(4, 0, 4, 0);
            this.jitter.Name = "jitter";
            this.jitter.Size = new System.Drawing.Size(46, 17);
            this.jitter.TabIndex = 1;
            this.jitter.Text = "label1";
            // 
            // perdidos
            // 
            this.perdidos.AutoSize = true;
            this.perdidos.Location = new System.Drawing.Point(391, 42);
            this.perdidos.Margin = new System.Windows.Forms.Padding(4, 0, 4, 0);
            this.perdidos.Name = "perdidos";
            this.perdidos.Size = new System.Drawing.Size(46, 17);
            this.perdidos.TabIndex = 2;
            this.perdidos.Text = "label1";
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.AutoSize = true;
            this.ClientSize = new System.Drawing.Size(1597, 770);
            this.Controls.Add(this.general);
            this.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            this.Name = "Form1";
            this.Text = "Cliente";
            this.Load += new System.EventHandler(this.Form1_Load);
            this.general.ResumeLayout(false);
            this.configuraciones.ResumeLayout(false);
            this.configuraciones.PerformLayout();
            this.tablazonacam.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.cam)).EndInit();
            this.tableLayoutPanel1.ResumeLayout(false);
            this.tableLayoutPanel1.PerformLayout();
            this.chatzone.ResumeLayout(false);
            this.escribirzone.ResumeLayout(false);
            this.estadisticas.ResumeLayout(false);
            this.estadisticas.PerformLayout();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.TableLayoutPanel general;
        private System.Windows.Forms.TableLayoutPanel configuraciones;
        private System.Windows.Forms.Label textSeleccionName;
        private System.Windows.Forms.TextBox name;
        private System.Windows.Forms.PictureBox cam;
        private System.Windows.Forms.TableLayoutPanel tablazonacam;
        private System.Windows.Forms.Button transmision;
        private System.Windows.Forms.TableLayoutPanel chatzone;
        private System.Windows.Forms.RichTextBox chat;
        private System.Windows.Forms.TableLayoutPanel escribirzone;
        private System.Windows.Forms.RichTextBox mensaje;
        private System.Windows.Forms.Button send;
        private System.Windows.Forms.TableLayoutPanel estadisticas;
        private System.Windows.Forms.Label ping;
        private System.Windows.Forms.Label jitter;
        private System.Windows.Forms.Button initService;
        private System.Windows.Forms.Label ip;
        private System.Windows.Forms.TextBox ipText;
        private System.Windows.Forms.TableLayoutPanel tableLayoutPanel1;
        private System.Windows.Forms.Label textoAlerta;
        private System.Windows.Forms.Label perdidos;
    }
}

