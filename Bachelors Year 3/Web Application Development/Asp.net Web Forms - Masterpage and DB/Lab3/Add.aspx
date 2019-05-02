<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Add.aspx.cs" Inherits="Add" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    
    
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [Departamente]"></asp:SqlDataSource>
    
    <asp:Label ID="Label1" runat="server" Text="Nume"></asp:Label>
    <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
    
    <br />
    
    <asp:Label ID="Label2" runat="server" Text="Prenume"></asp:Label>
    <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
    
    <br />
    
    <asp:Label ID="Label3" runat="server" Text="Salariu"></asp:Label>
    <asp:TextBox ID="TextBox3" runat="server"></asp:TextBox>
    
    <br />
    
    <asp:Label ID="Label4" runat="server" Text="Departament"></asp:Label>
    <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="SqlDataSource2" DataTextField="Nume" DataValueField="Id"></asp:DropDownList>
    
    <br />
    <br />
    <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Button" Width="174px" />
    
    <asp:Literal ID="EroareBazaDate" runat="server"></asp:Literal>

</asp:Content>

