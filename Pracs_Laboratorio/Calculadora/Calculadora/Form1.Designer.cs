namespace Calculadora
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
            this.suma = new System.Windows.Forms.Button();
            this.divide = new System.Windows.Forms.Button();
            this.resta = new System.Windows.Forms.Button();
            this.multiplica = new System.Windows.Forms.Button();
            this.sumando1 = new System.Windows.Forms.TextBox();
            this.sumando2 = new System.Windows.Forms.TextBox();
            this.resultados = new System.Windows.Forms.ListBox();
            this.SuspendLayout();
            // 
            // suma
            // 
            this.suma.Location = new System.Drawing.Point(201, 36);
            this.suma.Name = "suma";
            this.suma.Size = new System.Drawing.Size(75, 23);
            this.suma.TabIndex = 0;
            this.suma.Text = "+";
            this.suma.UseVisualStyleBackColor = true;
            this.suma.Click += new System.EventHandler(this.suma_Click);
            // 
            // divide
            // 
            this.divide.Location = new System.Drawing.Point(299, 108);
            this.divide.Name = "divide";
            this.divide.Size = new System.Drawing.Size(75, 23);
            this.divide.TabIndex = 1;
            this.divide.Text = "/";
            this.divide.UseVisualStyleBackColor = true;
            this.divide.Click += new System.EventHandler(this.divide_Click);
            // 
            // resta
            // 
            this.resta.Location = new System.Drawing.Point(299, 36);
            this.resta.Name = "resta";
            this.resta.Size = new System.Drawing.Size(75, 23);
            this.resta.TabIndex = 2;
            this.resta.Text = "-";
            this.resta.UseVisualStyleBackColor = true;
            this.resta.Click += new System.EventHandler(this.resta_Click);
            // 
            // multiplica
            // 
            this.multiplica.Location = new System.Drawing.Point(201, 108);
            this.multiplica.Name = "multiplica";
            this.multiplica.Size = new System.Drawing.Size(75, 23);
            this.multiplica.TabIndex = 3;
            this.multiplica.Text = "*";
            this.multiplica.UseVisualStyleBackColor = true;
            this.multiplica.Click += new System.EventHandler(this.multiplica_Click);
            // 
            // sumando1
            // 
            this.sumando1.Location = new System.Drawing.Point(67, 36);
            this.sumando1.Name = "sumando1";
            this.sumando1.Size = new System.Drawing.Size(100, 20);
            this.sumando1.TabIndex = 4;
            // 
            // sumando2
            // 
            this.sumando2.Location = new System.Drawing.Point(67, 108);
            this.sumando2.Name = "sumando2";
            this.sumando2.Size = new System.Drawing.Size(100, 20);
            this.sumando2.TabIndex = 5;
            // 
            // resultados
            // 
            this.resultados.FormattingEnabled = true;
            this.resultados.Location = new System.Drawing.Point(407, 36);
            this.resultados.Name = "resultados";
            this.resultados.Size = new System.Drawing.Size(120, 95);
            this.resultados.TabIndex = 7;
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(606, 173);
            this.Controls.Add(this.resultados);
            this.Controls.Add(this.sumando2);
            this.Controls.Add(this.sumando1);
            this.Controls.Add(this.multiplica);
            this.Controls.Add(this.resta);
            this.Controls.Add(this.divide);
            this.Controls.Add(this.suma);
            this.Name = "Form1";
            this.Text = "Form1";
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Button suma;
        private System.Windows.Forms.Button divide;
        private System.Windows.Forms.Button resta;
        private System.Windows.Forms.Button multiplica;
        private System.Windows.Forms.TextBox sumando1;
        private System.Windows.Forms.TextBox sumando2;
        private System.Windows.Forms.ListBox resultados;
    }
}

