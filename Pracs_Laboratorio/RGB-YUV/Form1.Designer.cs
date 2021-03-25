
namespace RGB_YUV
{
    partial class genYUVMat
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(genYUVMat));
            this.gen = new System.Windows.Forms.TableLayoutPanel();
            this.sup = new System.Windows.Forms.TableLayoutPanel();
            this.yuv_tab = new System.Windows.Forms.TableLayoutPanel();
            this.yuv = new System.Windows.Forms.RichTextBox();
            this.label1 = new System.Windows.Forms.Label();
            this.movimiento_tab = new System.Windows.Forms.TableLayoutPanel();
            this.matriz_movimiento = new System.Windows.Forms.Label();
            this.movimiento = new System.Windows.Forms.RichTextBox();
            this.inf = new System.Windows.Forms.TableLayoutPanel();
            this.b = new System.Windows.Forms.TableLayoutPanel();
            this.blue = new System.Windows.Forms.RichTextBox();
            this.label4 = new System.Windows.Forms.Label();
            this.g = new System.Windows.Forms.TableLayoutPanel();
            this.green = new System.Windows.Forms.RichTextBox();
            this.label3 = new System.Windows.Forms.Label();
            this.r = new System.Windows.Forms.TableLayoutPanel();
            this.red = new System.Windows.Forms.RichTextBox();
            this.label2 = new System.Windows.Forms.Label();
            this.gen.SuspendLayout();
            this.sup.SuspendLayout();
            this.yuv_tab.SuspendLayout();
            this.movimiento_tab.SuspendLayout();
            this.inf.SuspendLayout();
            this.b.SuspendLayout();
            this.g.SuspendLayout();
            this.r.SuspendLayout();
            this.SuspendLayout();
            // 
            // gen
            // 
            resources.ApplyResources(this.gen, "gen");
            this.gen.Controls.Add(this.sup, 0, 0);
            this.gen.Controls.Add(this.inf, 0, 1);
            this.gen.Name = "gen";
            // 
            // sup
            // 
            resources.ApplyResources(this.sup, "sup");
            this.sup.Controls.Add(this.yuv_tab, 1, 0);
            this.sup.Controls.Add(this.movimiento_tab, 0, 0);
            this.sup.Name = "sup";
            // 
            // yuv_tab
            // 
            resources.ApplyResources(this.yuv_tab, "yuv_tab");
            this.yuv_tab.Controls.Add(this.yuv, 0, 1);
            this.yuv_tab.Controls.Add(this.label1, 0, 0);
            this.yuv_tab.Name = "yuv_tab";
            // 
            // yuv
            // 
            resources.ApplyResources(this.yuv, "yuv");
            this.yuv.Name = "yuv";
            this.yuv.ReadOnly = true;
            // 
            // label1
            // 
            resources.ApplyResources(this.label1, "label1");
            this.label1.Name = "label1";
            // 
            // movimiento_tab
            // 
            resources.ApplyResources(this.movimiento_tab, "movimiento_tab");
            this.movimiento_tab.Controls.Add(this.matriz_movimiento, 0, 0);
            this.movimiento_tab.Controls.Add(this.movimiento, 0, 1);
            this.movimiento_tab.Name = "movimiento_tab";
            // 
            // matriz_movimiento
            // 
            resources.ApplyResources(this.matriz_movimiento, "matriz_movimiento");
            this.matriz_movimiento.Name = "matriz_movimiento";
            // 
            // movimiento
            // 
            resources.ApplyResources(this.movimiento, "movimiento");
            this.movimiento.Name = "movimiento";
            this.movimiento.ReadOnly = true;
            // 
            // inf
            // 
            resources.ApplyResources(this.inf, "inf");
            this.inf.Controls.Add(this.b, 0, 0);
            this.inf.Controls.Add(this.g, 0, 0);
            this.inf.Controls.Add(this.r, 0, 0);
            this.inf.Name = "inf";
            // 
            // b
            // 
            resources.ApplyResources(this.b, "b");
            this.b.Controls.Add(this.blue, 0, 1);
            this.b.Controls.Add(this.label4, 0, 0);
            this.b.Name = "b";
            // 
            // blue
            // 
            resources.ApplyResources(this.blue, "blue");
            this.blue.Name = "blue";
            this.blue.ReadOnly = true;
            // 
            // label4
            // 
            resources.ApplyResources(this.label4, "label4");
            this.label4.ForeColor = System.Drawing.Color.Blue;
            this.label4.Name = "label4";
            // 
            // g
            // 
            resources.ApplyResources(this.g, "g");
            this.g.Controls.Add(this.green, 0, 1);
            this.g.Controls.Add(this.label3, 0, 0);
            this.g.Name = "g";
            // 
            // green
            // 
            resources.ApplyResources(this.green, "green");
            this.green.Name = "green";
            this.green.ReadOnly = true;
            // 
            // label3
            // 
            resources.ApplyResources(this.label3, "label3");
            this.label3.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(0)))), ((int)(((byte)(192)))), ((int)(((byte)(0)))));
            this.label3.Name = "label3";
            // 
            // r
            // 
            resources.ApplyResources(this.r, "r");
            this.r.Controls.Add(this.red, 0, 1);
            this.r.Controls.Add(this.label2, 0, 0);
            this.r.Name = "r";
            // 
            // red
            // 
            resources.ApplyResources(this.red, "red");
            this.red.Name = "red";
            this.red.ReadOnly = true;
            // 
            // label2
            // 
            resources.ApplyResources(this.label2, "label2");
            this.label2.ForeColor = System.Drawing.Color.Red;
            this.label2.Name = "label2";
            // 
            // genYUVMat
            // 
            resources.ApplyResources(this, "$this");
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.Controls.Add(this.gen);
            this.Name = "genYUVMat";
            this.gen.ResumeLayout(false);
            this.sup.ResumeLayout(false);
            this.yuv_tab.ResumeLayout(false);
            this.yuv_tab.PerformLayout();
            this.movimiento_tab.ResumeLayout(false);
            this.movimiento_tab.PerformLayout();
            this.inf.ResumeLayout(false);
            this.b.ResumeLayout(false);
            this.b.PerformLayout();
            this.g.ResumeLayout(false);
            this.g.PerformLayout();
            this.r.ResumeLayout(false);
            this.r.PerformLayout();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.TableLayoutPanel gen;
        private System.Windows.Forms.TableLayoutPanel sup;
        private System.Windows.Forms.TableLayoutPanel yuv_tab;
        private System.Windows.Forms.TableLayoutPanel movimiento_tab;
        private System.Windows.Forms.TableLayoutPanel inf;
        private System.Windows.Forms.TableLayoutPanel g;
        private System.Windows.Forms.TableLayoutPanel r;
        private System.Windows.Forms.RichTextBox yuv;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label matriz_movimiento;
        private System.Windows.Forms.RichTextBox movimiento;
        private System.Windows.Forms.TableLayoutPanel b;
        private System.Windows.Forms.RichTextBox blue;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.RichTextBox green;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.RichTextBox red;
        private System.Windows.Forms.Label label2;
    }
}

