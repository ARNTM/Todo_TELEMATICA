
namespace SumaPSNR
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
            this.gen = new System.Windows.Forms.TableLayoutPanel();
            this.matpanel = new System.Windows.Forms.TableLayoutPanel();
            this.label1 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.enviada = new System.Windows.Forms.RichTextBox();
            this.recibida = new System.Windows.Forms.RichTextBox();
            this.tableLayoutPanel1 = new System.Windows.Forms.TableLayoutPanel();
            this.psnrtext = new System.Windows.Forms.Label();
            this.mediatext = new System.Windows.Forms.Label();
            this.actualizar = new System.Windows.Forms.Button();
            this.psnr = new System.Windows.Forms.TextBox();
            this.media = new System.Windows.Forms.TextBox();
            this.gen.SuspendLayout();
            this.matpanel.SuspendLayout();
            this.tableLayoutPanel1.SuspendLayout();
            this.SuspendLayout();
            // 
            // gen
            // 
            this.gen.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.gen.ColumnCount = 1;
            this.gen.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 100F));
            this.gen.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Absolute, 20F));
            this.gen.Controls.Add(this.matpanel, 0, 0);
            this.gen.Controls.Add(this.tableLayoutPanel1, 0, 1);
            this.gen.Location = new System.Drawing.Point(12, 12);
            this.gen.Name = "gen";
            this.gen.RowCount = 2;
            this.gen.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 80F));
            this.gen.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 20F));
            this.gen.Size = new System.Drawing.Size(1040, 417);
            this.gen.TabIndex = 0;
            // 
            // matpanel
            // 
            this.matpanel.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.matpanel.ColumnCount = 2;
            this.matpanel.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 50F));
            this.matpanel.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 50F));
            this.matpanel.Controls.Add(this.recibida, 1, 1);
            this.matpanel.Controls.Add(this.label2, 1, 0);
            this.matpanel.Controls.Add(this.label1, 0, 0);
            this.matpanel.Controls.Add(this.enviada, 0, 1);
            this.matpanel.Location = new System.Drawing.Point(3, 3);
            this.matpanel.Name = "matpanel";
            this.matpanel.RowCount = 2;
            this.matpanel.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 10F));
            this.matpanel.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 90F));
            this.matpanel.Size = new System.Drawing.Size(1034, 327);
            this.matpanel.TabIndex = 0;
            // 
            // label1
            // 
            this.label1.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Consolas", 15.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label1.Location = new System.Drawing.Point(3, 0);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(511, 32);
            this.label1.TabIndex = 0;
            this.label1.Text = "Matriz enviada";
            this.label1.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
            // 
            // label2
            // 
            this.label2.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.label2.AutoSize = true;
            this.label2.Font = new System.Drawing.Font("Consolas", 15.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label2.Location = new System.Drawing.Point(520, 0);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(511, 32);
            this.label2.TabIndex = 1;
            this.label2.Text = "Matriz recibida";
            this.label2.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
            // 
            // enviada
            // 
            this.enviada.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.enviada.Location = new System.Drawing.Point(3, 35);
            this.enviada.Name = "enviada";
            this.enviada.ReadOnly = true;
            this.enviada.Size = new System.Drawing.Size(511, 289);
            this.enviada.TabIndex = 2;
            this.enviada.Text = "";
            this.enviada.WordWrap = false;
            // 
            // recibida
            // 
            this.recibida.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.recibida.Location = new System.Drawing.Point(520, 35);
            this.recibida.Name = "recibida";
            this.recibida.ReadOnly = true;
            this.recibida.Size = new System.Drawing.Size(511, 289);
            this.recibida.TabIndex = 3;
            this.recibida.Text = "";
            this.recibida.WordWrap = false;
            // 
            // tableLayoutPanel1
            // 
            this.tableLayoutPanel1.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.tableLayoutPanel1.ColumnCount = 3;
            this.tableLayoutPanel1.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 33.33333F));
            this.tableLayoutPanel1.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 33.33333F));
            this.tableLayoutPanel1.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 33.33333F));
            this.tableLayoutPanel1.Controls.Add(this.psnrtext, 0, 0);
            this.tableLayoutPanel1.Controls.Add(this.mediatext, 2, 0);
            this.tableLayoutPanel1.Controls.Add(this.actualizar, 1, 0);
            this.tableLayoutPanel1.Controls.Add(this.psnr, 0, 1);
            this.tableLayoutPanel1.Controls.Add(this.media, 2, 1);
            this.tableLayoutPanel1.Location = new System.Drawing.Point(3, 336);
            this.tableLayoutPanel1.Name = "tableLayoutPanel1";
            this.tableLayoutPanel1.RowCount = 2;
            this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 50F));
            this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 50F));
            this.tableLayoutPanel1.Size = new System.Drawing.Size(1034, 78);
            this.tableLayoutPanel1.TabIndex = 1;
            // 
            // psnrtext
            // 
            this.psnrtext.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.psnrtext.AutoSize = true;
            this.psnrtext.Font = new System.Drawing.Font("Consolas", 15.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.psnrtext.Location = new System.Drawing.Point(3, 0);
            this.psnrtext.Name = "psnrtext";
            this.psnrtext.Size = new System.Drawing.Size(338, 39);
            this.psnrtext.TabIndex = 1;
            this.psnrtext.Text = "PSNR";
            this.psnrtext.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
            // 
            // mediatext
            // 
            this.mediatext.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.mediatext.AutoSize = true;
            this.mediatext.Font = new System.Drawing.Font("Consolas", 15.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.mediatext.Location = new System.Drawing.Point(691, 0);
            this.mediatext.Name = "mediatext";
            this.mediatext.Size = new System.Drawing.Size(340, 39);
            this.mediatext.TabIndex = 2;
            this.mediatext.Text = "MEDIA";
            this.mediatext.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
            // 
            // actualizar
            // 
            this.actualizar.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.actualizar.Font = new System.Drawing.Font("Consolas", 15.75F, System.Drawing.FontStyle.Bold);
            this.actualizar.Location = new System.Drawing.Point(347, 3);
            this.actualizar.Name = "actualizar";
            this.actualizar.Size = new System.Drawing.Size(338, 33);
            this.actualizar.TabIndex = 3;
            this.actualizar.Text = "ACTUALIZAR";
            this.actualizar.UseVisualStyleBackColor = true;
            this.actualizar.Click += new System.EventHandler(this.actualizar_Click);
            // 
            // psnr
            // 
            this.psnr.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.psnr.Location = new System.Drawing.Point(3, 42);
            this.psnr.Name = "psnr";
            this.psnr.ReadOnly = true;
            this.psnr.Size = new System.Drawing.Size(338, 20);
            this.psnr.TabIndex = 4;
            this.psnr.TextAlign = System.Windows.Forms.HorizontalAlignment.Center;
            // 
            // media
            // 
            this.media.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.media.Location = new System.Drawing.Point(691, 42);
            this.media.Name = "media";
            this.media.ReadOnly = true;
            this.media.Size = new System.Drawing.Size(340, 20);
            this.media.TabIndex = 5;
            this.media.TextAlign = System.Windows.Forms.HorizontalAlignment.Center;
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1064, 441);
            this.Controls.Add(this.gen);
            this.Name = "Form1";
            this.Text = "Form1";
            this.gen.ResumeLayout(false);
            this.matpanel.ResumeLayout(false);
            this.matpanel.PerformLayout();
            this.tableLayoutPanel1.ResumeLayout(false);
            this.tableLayoutPanel1.PerformLayout();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.TableLayoutPanel gen;
        private System.Windows.Forms.TableLayoutPanel matpanel;
        private System.Windows.Forms.RichTextBox recibida;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.RichTextBox enviada;
        private System.Windows.Forms.TableLayoutPanel tableLayoutPanel1;
        private System.Windows.Forms.Label psnrtext;
        private System.Windows.Forms.Label mediatext;
        private System.Windows.Forms.Button actualizar;
        private System.Windows.Forms.TextBox psnr;
        private System.Windows.Forms.TextBox media;
    }
}

