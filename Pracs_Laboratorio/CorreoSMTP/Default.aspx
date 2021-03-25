<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="CorreoSMTP.Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Envio de Email</title>

</head>
<body>
    <form id="form1" runat="server">
        <div>
            <table style="border-collapse: separate; border-spacing: 10px; width:100%;">
                <thead>
                    <tr>
                        <th style="width:25%">
                            <asp:Label ID="nombre" runat="server" Text="Nombre: " ForeColor="Black"></asp:Label> <br />
                            <asp:TextBox ID="nombreText" runat="server" BackColor="#CCCCCC" Width="250px" required="true"></asp:TextBox>    
                        </th>
                        <th style="width:25%">
                            <asp:Label ID="from" runat="server" Text="Desde: " ForeColor="Black"></asp:Label> <br />
                            <asp:TextBox ID="desdeText" runat="server" BackColor="#CCCCCC" Width="250px" TextMode="Email" required="true"></asp:TextBox>    
                        </th>
                        <th style="width:25%">
                            <asp:Label ID="pass" runat="server" Text="Contraseña: " ForeColor="Black"></asp:Label> <br />
                            <asp:TextBox ID="passText" runat="server" BackColor="#CCCCCC" TextMode="Password" Width="250px" required="true"></asp:TextBox>
                        </th>
                        <th style="width:25%">
                            <asp:Label ID="servidor" runat="server" Text="Servidor: " ForeColor="Black"></asp:Label> <br />
                            <asp:TextBox ID="serverText" runat="server" BackColor="#CCCCCC" Width="250px" required="true"></asp:TextBox>
                        </th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td colspan="4" style="text-align: center;">
                            <asp:Label ID="to" runat="server" Text="Para: " ForeColor="Black"></asp:Label><br />
                            <asp:TextBox ID="paraText" runat="server" BackColor="#CCCCCC" Width="900px" TextMode="Email" required="true"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4" style="text-align: center;">
                            <asp:Label ID="subject" runat="server" Text="Asunto: " ForeColor="Black"></asp:Label><br />
                            <asp:TextBox ID="asuntoText" runat="server" BackColor="#CCCCCC" Width="900px" required="true"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4" style="text-align: center !important; align-content:center !important;" >
                            <asp:Label ID="body" runat="server" Text="Contenido: " ForeColor="Black"></asp:Label> <br />
                            <asp:TextBox ID="bodyText" runat="server" BackColor="#CCCCCC" Width="900px" Height="200px" TextMode="MultiLine" required="true"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4" style="text-align: center;">
                            <asp:Label ID="attach" runat="server" Text="Adjuntar: " ForeColor="Black"></asp:Label><br />
                            <asp:FileUpload ID="adjunto" AllowMultiple="true" runat="server" Width="900px" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4" style="text-align: center;">
                            <asp:Button ID="enviar" runat="server" Text="Enviar" OnClick="enviar_click" BackColor="#66FF33" ForeColor="Black" Width="250px"/>
                        </td>
                    </tr>
                </tbody>
                <tfoot>
                    <tr>
                        <td colspan="5" style="text-align: center;">
                            <asp:TextBox ID="status" runat="server" BackColor="#CCCCCC" Width="900px" ReadOnly="True"></asp:TextBox>
                        </td>
                    </tr>
                </tfoot>
            </table>
        </div>
    </form>
</body>
</html>
