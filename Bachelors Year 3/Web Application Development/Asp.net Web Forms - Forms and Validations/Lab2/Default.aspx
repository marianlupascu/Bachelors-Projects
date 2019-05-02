<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

</head>
<body>
    <form id="form1" runat="server">
        <asp:Label ID="LabelNume" runat="server" Text="Nume"
                   AssociatedControlID="TextBoxNume"></asp:Label>
        <asp:TextBox ID="TextBoxNume" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="RequiredFieldValidator" ControlToValidate="TextBoxNume"></asp:RequiredFieldValidator>
        <p>
            Prenume<asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ControlToValidate="TextBox1" runat="server" ErrorMessage="RequiredFieldValidator"></asp:RequiredFieldValidator>
        </p>
        <p>
            Mail<asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ControlToValidate="TextBox2" runat="server" ErrorMessage="RequiredFieldValidator"></asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" ControlToValidate="TextBox2" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"  runat="server" ErrorMessage="RegularExpressionValidator"></asp:RegularExpressionValidator>
        </p>
        Parola<asp:TextBox ID="TextBox3" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" ControlToValidate="TextBox3" runat="server" ErrorMessage="RequiredFieldValidator"></asp:RequiredFieldValidator>
        <br />
        ConfirmareParola<asp:TextBox ID="TextBox4" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" ControlToValidate="TextBox4" runat="server" ErrorMessage="RequiredFieldValidator"></asp:RequiredFieldValidator>
        <asp:CompareValidator ID="CompareValidator3" runat="server"
                              ControlToCompare="TextBox4" Operator="Equal"
                              ControlToValidate="TextBox3" ErrorMessage="Reconfirmarea parolei nu este corecta">*</asp:CompareValidator>
        <br />
        Facultate<asp:DropDownList ID="DropDownList1" runat="server">
            <asp:ListItem>--Select--</asp:ListItem>
            <asp:ListItem>FMI</asp:ListItem>
            <asp:ListItem>Biologie</asp:ListItem>
            <asp:ListItem>Fizica</asp:ListItem>
        </asp:DropDownList>
        <asp:CompareValidator ID="CompareValidator1" ValueToCompare="--Select--" ControlToValidate="DropDownList1" Operator="NotEqual" runat="server" ErrorMessage="CompareValidator"></asp:CompareValidator>
        <br />
        An de studiu<asp:DropDownList ID="DropDownList2" runat="server">
            <asp:ListItem>--Select--</asp:ListItem>
            <asp:ListItem>1</asp:ListItem>
            <asp:ListItem>2</asp:ListItem>
            <asp:ListItem>3</asp:ListItem>
        </asp:DropDownList>
        <asp:CompareValidator ID="CompareValidator2" ValueToCompare="--Select--" ControlToValidate="DropDownList2" Operator="NotEqual" runat="server" ErrorMessage="CompareValidator"></asp:CompareValidator>
        <br />
        <br />
        Data Nasterii<asp:TextBox ID="TextBox5" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator6" ControlToValidate="TextBox5" runat="server" ErrorMessage="RequiredFieldValidator"></asp:RequiredFieldValidator>
        <asp:CompareValidator ID="CompareValidator4" ControlToValidate="TextBox5" Type="Date" Operator="DataTypeCheck"
                              runat="server" ErrorMessage="CompareValidator">DataTypeCheck</asp:CompareValidator>
        <br />
        Sex<asp:RadioButtonList ID="RadioButtonList1" runat="server">
            <asp:ListItem>M</asp:ListItem>
            <asp:ListItem>F</asp:ListItem>
        </asp:RadioButtonList>
        <br />
        Varsta<asp:TextBox ID="TextBox6" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator7" ControlToValidate="TextBox6" runat="server" ErrorMessage="RequiredFieldValidator"></asp:RequiredFieldValidator>
        <asp:RangeValidator ID="RangeValidator1" runat="server"
                            ControlToValidate="TextBox6" Display="Dynamic" ErrorMessage="Dati varsta
in intervalul 0-120" MaximumValue="120" MinimumValue="0"
                            Type="Integer">*</asp:RangeValidator>
        <asp:CustomValidator ID="CustomValidator1"
                             ControlToValidate="TextBox6"
                             runat="server" ErrorMessage="CustomValidator" OnServerValidate="CustomValidator1_ServerValidate">Varsta nu corespunde cu data nasterii</asp:CustomValidator>
        <br />
        Angajat<asp:CheckBox ID="CheckBox1" OnCheckedChanged="CheckBox1_OnCheckedChanged" Autopostback="True"
                             runat="server" />
        <br />
        <br />
        <asp:Panel ID="Panel1" runat="server" Visible="False">
            
            <asp:Label ID="Label1" runat="server" Text="Firma"></asp:Label>
            <asp:TextBox ID="TextBox7" runat="server"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ErrorMessage="RequiredFieldValidator" ControlToValidate="TextBox7"></asp:RequiredFieldValidator>
            <asp:Label ID="Label2" runat="server" Text="Salariu"></asp:Label>
            <asp:TextBox ID="TextBox8" runat="server"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ErrorMessage="RequiredFieldValidator" ControlToValidate="TextBox8"></asp:RequiredFieldValidator>

        </asp:Panel>

        <asp:Button ID="Button1" runat="server" Text="Submit"
                    BorderStyle="Solid" ToolTip="Submit" OnClick="ClickBttn"
                    CssClass="btn btn-primary"/>
        
        <asp:TextBox ID="TextBox9" runat="server" ValidationGroup="Ceva"></asp:TextBox>
        <asp:Button ID="Button2" runat="server" OnClick="Button2_OnClick" Text="Button" ValidationGroup="Ceva"/>

    </form>
</body>
</html>
