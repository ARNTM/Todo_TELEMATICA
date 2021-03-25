namespace Convertidor
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
            this.guardar = new System.Windows.Forms.Button();
            this.abrir = new System.Windows.Forms.Button();
            this.seleccionguardar = new System.Windows.Forms.ComboBox();
            this.seleccionabrir = new System.Windows.Forms.ComboBox();
            this.imagenmostrada = new System.Windows.Forms.PictureBox();
            this.label1 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            ((System.ComponentModel.ISupportInitialize)(this.imagenmostrada)).BeginInit();
            this.SuspendLayout();
            // 
            // guardar
            // 
            this.guardar.Location = new System.Drawing.Point(41, 209);
            this.guardar.Name = "guardar";
            this.guardar.Size = new System.Drawing.Size(121, 23);
            this.guardar.TabIndex = 0;
            this.guardar.Text = "Guardar";
            this.guardar.UseVisualStyleBackColor = true;
            this.guardar.Click += new System.EventHandler(this.guardar_Click);
            // 
            // abrir
            // 
            this.abrir.Location = new System.Drawing.Point(41, 103);
            this.abrir.Name = "abrir";
            this.abrir.Size = new System.Drawing.Size(121, 23);
            this.abrir.TabIndex = 1;
            this.abrir.Text = "Abrir";
            this.abrir.UseVisualStyleBackColor = true;
            this.abrir.Click += new System.EventHandler(this.abrir_Click);
            // 
            // seleccionguardar
            // 
            this.seleccionguardar.FormattingEnabled = true;
            this.seleccionguardar.Items.AddRange(new object[] {
            "*.jpg",
            "*.bmp",
            "*.emf",
            "*.exif",
            "*.gif",
            "*.jpeg",
            "*.png",
            "*.tiff",
            "*.wmf"});
            this.seleccionguardar.Location = new System.Drawing.Point(41, 182);
            this.seleccionguardar.Name = "seleccionguardar";
            this.seleccionguardar.Size = new System.Drawing.Size(121, 21);
            this.seleccionguardar.TabIndex = 2;
            this.seleccionguardar.SelectedIndexChanged += new System.EventHandler(this.comboBox1_SelectedIndexChanged);
            // 
            // seleccionabrir
            // 
            this.seleccionabrir.FormattingEnabled = true;
            this.seleccionabrir.Items.AddRange(new object[] {
            "*.jpg",
            "*.bmp",
            "*.emf",
            "*.exif",
            "*.gif",
            "*.jpeg",
            "*.png",
            "*.tiff",
            "*.wmf"});
            this.seleccionabrir.Location = new System.Drawing.Point(41, 76);
            this.seleccionabrir.Name = "seleccionabrir";
            this.seleccionabrir.Size = new System.Drawing.Size(121, 21);
            this.seleccionabrir.TabIndex = 3;
            this.seleccionabrir.SelectedIndexChanged += new System.EventHandler(this.comboBox2_SelectedIndexChanged);
            // 
            // imagenmostrada
            // 
            this.imagenmostrada.Image = global::Convertidor.Properties.Resources._404;
            this.imagenmostrada.InitialImage = global::Convertidor.Properties.Resources._404;
            this.imagenmostrada.Location = new System.Drawing.Point(211, 30);
            this.imagenmostrada.MaximumSize = new System.Drawing.Size(559, 392);
            this.imagenmostrada.Name = "imagenmostrada";
            this.imagenmostrada.Size = new System.Drawing.Size(559, 392);
            this.imagenmostrada.SizeMode = System.Windows.Forms.PictureBoxSizeMode.Zoom;
            this.imagenmostrada.TabIndex = 4;
            this.imagenmostrada.TabStop = false;
            this.imagenmostrada.WaitOnLoad = true;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(43, 60);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(119, 13);
            this.label1.TabIndex = 5;
            this.label1.Text = "Abrir archivo a convertir";
            this.label1.Click += new System.EventHandler(this.label1_Click);
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(57, 166);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(87, 13);
            this.label2.TabIndex = 6;
            this.label2.Text = "Convertir archivo";
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(800, 450);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.imagenmostrada);
            this.Controls.Add(this.seleccionabrir);
            this.Controls.Add(this.seleccionguardar);
            this.Controls.Add(this.abrir);
            this.Controls.Add(this.guardar);
            this.MaximizeBox = false;
            this.Name = "Form1";
            this.Text = "Form1";
            ((System.ComponentModel.ISupportInitialize)(this.imagenmostrada)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Button guardar;
        private System.Windows.Forms.Button abrir;
        private System.Windows.Forms.ComboBox seleccionguardar;
        private System.Windows.Forms.ComboBox seleccionabrir;
        private System.Windows.Forms.PictureBox imagenmostrada;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label2;
    }
}

