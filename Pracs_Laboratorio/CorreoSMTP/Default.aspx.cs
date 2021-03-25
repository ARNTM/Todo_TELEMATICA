using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net.Mail;
using System.Net;
using System.Runtime.InteropServices;
using System.IO;

namespace CorreoSMTP
{
    public partial class Default : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {

        }
        private bool RemoteServerCertificateValidationCallback(object sender, System.Security.Cryptography.X509Certificates.X509Certificate certificate, System.Security.Cryptography.X509Certificates.X509Chain chain, System.Net.Security.SslPolicyErrors sslPolicyErrors)
        {
            return true;
        }
        protected void enviar_click(object sender, EventArgs e)
        {
            NetworkCredential credenciales = new NetworkCredential(desdeText.Text, passText.Text);
            SmtpClient client = new SmtpClient(serverText.Text, 587);
            client.UseDefaultCredentials = false;
            client.Credentials = credenciales;
            MailAddress from = new MailAddress(desdeText.Text, nombreText.Text);
            MailAddress to = new MailAddress(paraText.Text);
            MailMessage message = new MailMessage(from, to);
            message.Subject = asuntoText.Text;
            message.Body = bodyText.Text;
            System.Net.ServicePointManager.ServerCertificateValidationCallback = new System.Net.Security.RemoteCertificateValidationCallback(RemoteServerCertificateValidationCallback);
            client.EnableSsl = true;

            if (adjunto.HasFile)
            {
                foreach (HttpPostedFile archivo in adjunto.PostedFiles) {
                    string fileName = Path.GetFileName(archivo.FileName);
                    message.Attachments.Add(new Attachment(archivo.InputStream, fileName));
                }

            }
            message.SubjectEncoding = System.Text.Encoding.UTF8;
            try
            {
                status.Text = "Enviando correo...";
                client.Send(message);
                status.Text = "Mensaje enviado con éxito";
                nombreText.Text = "";
                serverText.Text = "";
                bodyText.Text = "";
                asuntoText.Text = "";
                desdeText.Text = "";
                paraText.Text = "";
            }
            catch (Exception ex) { status.Text = ex.ToString(); }
            
        }
    }
}