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
            this.modulo = new System.Windows.Forms.Button();
            this.log = new System.Windows.Forms.Button();
            this.pot = new System.Windows.Forms.Button();
            this.raiz = new System.Windows.Forms.Button();
            this.A = new System.Windows.Forms.Label();
            this.B = new System.Windows.Forms.Label();
            this.SuspendLayout();
            // 
            // suma
            // 
            this.suma.Location = new System.Drawing.Point(201, 36);
            this.suma.Name = "suma";
            this.suma.Size = new System.Drawing.Size(75, 23);
            this.suma.TabIndex = 0;
            this.suma.Text = "A+B";
            this.suma.UseVisualStyleBackColor = true;
            this.suma.Click += new System.EventHandler(this.suma_Click);
            // 
            // divide
            // 
            this.divide.Location = new System.Drawing.Point(299, 65);
            this.divide.Name = "divide";
            this.divide.Size = new System.Drawing.Size(75, 23);
            this.divide.TabIndex = 1;
            this.divide.Text = "A/B";
            this.divide.UseVisualStyleBackColor = true;
            this.divide.Click += new System.EventHandler(this.divide_Click);
            // 
            // resta
            // 
            this.resta.Location = new System.Drawing.Point(299, 36);
            this.resta.Name = "resta";
            this.resta.Size = new System.Drawing.Size(75, 23);
            this.resta.TabIndex = 2;
            this.resta.Text = "A-B";
            this.resta.UseVisualStyleBackColor = true;
            this.resta.Click += new System.EventHandler(this.resta_Click);
            // 
            // multiplica
            // 
            this.multiplica.Location = new System.Drawing.Point(201, 65);
            this.multiplica.Name = "multiplica";
            this.multiplica.Size = new System.Drawing.Size(75, 23);
            this.multiplica.TabIndex = 3;
            this.multiplica.Text = "A*B";
            this.multiplica.UseVisualStyleBackColor = true;
            this.multiplica.Click += new System.EventHandler(this.multiplica_Click);
            // 
            // sumando1
            // 
            this.sumando1.Location = new System.Drawing.Point(67, 65);
            this.sumando1.Name = "sumando1";
            this.sumando1.Size = new System.Drawing.Size(100, 20);
            this.sumando1.TabIndex = 4;
            // 
            // sumando2
            // 
            this.sumando2.Location = new System.Drawing.Point(67, 94);
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
            // modulo
            // 
            this.modulo.Location = new System.Drawing.Point(201, 94);
            this.modulo.Name = "modulo";
            this.modulo.Size = new System.Drawing.Size(75, 23);
            this.modulo.TabIndex = 8;
            this.modulo.Text = "A%B";
            this.modulo.UseVisualStyleBackColor = true;
            this.modulo.Click += new System.EventHandler(this.modulo_Click);
            // 
            // log
            // 
            this.log.Location = new System.Drawing.Point(299, 94);
            this.log.Name = "log";
            this.log.Size = new System.Drawing.Size(75, 23);
            this.log.TabIndex = 9;
            this.log.Text = "logB(A)";
            this.log.UseVisualStyleBackColor = true;
            this.log.Click += new System.EventHandler(this.log_Click);
            // 
            // pot
            // 
            this.pot.Location = new System.Drawing.Point(201, 123);
            this.pot.Name = "pot";
            this.pot.Size = new System.Drawing.Size(75, 23);
            this.pot.TabIndex = 10;
            this.pot.Text = "A^B";
            this.pot.UseVisualStyleBackColor = true;
            this.pot.Click += new System.EventHandler(this.pot_Click);
            // 
            // raiz
            // 
            this.raiz.Location = new System.Drawing.Point(299, 123);
            this.raiz.Name = "raiz";
            this.raiz.Size = new System.Drawing.Size(75, 23);
            this.raiz.TabIndex = 11;
            this.raiz.Text = "Raiz A de B";
            this.raiz.UseVisualStyleBackColor = true;
            this.raiz.Click += new System.EventHandler(this.raiz_Click);
            // 
            // A
            // 
            this.A.AutoSize = true;
            this.A.Location = new System.Drawing.Point(50, 68);
            this.A.Name = "A";
            this.A.Size = new System.Drawing.Size(14, 13);
            this.A.TabIndex = 12;
            this.A.Text = "A";
            // 
            // B
            // 
            this.B.AutoSize = true;
            this.B.Location = new System.Drawing.Point(50, 97);
            this.B.Name = "B";
            this.B.Size = new System.Drawing.Size(14, 13);
            this.B.TabIndex = 13;
            this.B.Text = "B";
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(606, 171);
            this.Controls.Add(this.B);
            this.Controls.Add(this.A);
            this.Controls.Add(this.raiz);
            this.Controls.Add(this.pot);
            this.Controls.Add(this.log);
            this.Controls.Add(this.modulo);
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
        private System.Windows.Forms.Button modulo;
        private System.Windows.Forms.Button log;
        private System.Windows.Forms.Button pot;
        private System.Windows.Forms.Button raiz;
        private System.Windows.Forms.Label A;
        private System.Windows.Forms.Label B;
    }
}

