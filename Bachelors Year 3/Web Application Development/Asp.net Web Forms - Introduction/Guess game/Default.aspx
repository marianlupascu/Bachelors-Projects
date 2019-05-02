<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet"
          href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO"
          crossorigin="anonymous">

</head>
<body>
<!--
    Creați un site web pentru un joc care presupune ca utilizatorul să ghicească un număr
    între 1 și 100. La încărcarea paginii se va genera aleator numărul. Pagina va conține un
    câmp text și un buton. În câmpul text utilizatorul va trece opțiunea sa, care va fi
    verificată la apăsarea butonului. În cazul în care utilizatorul ghicește numărul, va apărea
    un buton cu mesajul “Joacă din nou” prin care va fi pornit un alt joc. Altfel, vor fi afișate
    mesaje corespunzatoare de tipul “Numărul este mai mare” sau “Numărul este mai mic”. 
-->
    <form id="form1" runat="server">
        
        <asp:Label ID="LabelNume" runat="server" Text="Numar"
                   AssociatedControlID="TextBoxNumar"></asp:Label>
        <asp:TextBox ID="TextBoxNumar" runat="server"></asp:TextBox>
        <br />
        <asp:Button ID="Button1" runat="server" Text="Submit"
                    BorderStyle="Solid" ToolTip="Submit" OnClick="ClickBttn" CssClass="btn btn-primary"/>
        <br />
        <asp:Literal ID="LiteralAfisareMesaj" runat="server"></asp:Literal>
        
    </form>
</body>
</html>
