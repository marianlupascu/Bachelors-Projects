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
<form id="form1" runat="server">
    
    <!--
    Creați un site web care să conțină un câmp text și un buton. În câmpul text va fi introdus
    un nume, iar la apăsarea butonului va fi afișat mesajul “Hello, [nume]”.
    Efectuați acest exercițiu folosind mai întâi controale clasice HTML, apoi folosind
    controale ASP.
    Adăugați la încărcarea o verificare în care să testați valoarea parametrului
    Page.isPostBack. Când este true și când este false?
    -->
    
    <asp:Literal ID="LiteralTF" runat="server"></asp:Literal>

    <!-- HTML -->
    <br/><br/>
    <input type="text" value="Micky" id="InputText" runat="server"/>
    <input name="Button1" runat="server" value="Submit" id="Button1" title="Submit" style="border-style:Solid;" type="submit" onserverclick ="ClickBttnHTML"/>
    <input type="text" value="" id="Text2" runat="server"/> <br /><br /><br />

    <!-- ASP  -->
    <asp:Label ID="LabelNume" runat="server" Text="Nume"
               AssociatedControlID="TextBoxNume">
    </asp:Label>
    <asp:TextBox ID="TextBoxNume" runat="server"></asp:TextBox>
    <asp:Button ID="Button2" runat="server" Text="Submit"
                BorderStyle="Solid" ToolTip="Submit" OnClick="ClickBttn" CssClass="btn btn-primary"/>
    <asp:Literal ID="LiteralAfisareNume" runat="server"></asp:Literal>
</form>
</body>
</html>
