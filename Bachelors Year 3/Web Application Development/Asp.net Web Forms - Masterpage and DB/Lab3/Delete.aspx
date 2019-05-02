<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Delete.aspx.cs" Inherits="Delete" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <asp:Label ID="Label1" runat="server" Text="Nume"></asp:Label>
    <asp:Literal ID="Nume" runat="server"></asp:Literal>
    
    <br />
    
    <asp:Label ID="Label2" runat="server" Text="Prenume"></asp:Label>
    <asp:Literal ID="Prenume" runat="server"></asp:Literal>
    
    <br />
    
    <asp:Label ID="Label3" runat="server" Text="Salariu"></asp:Label>
    <asp:Literal ID="Salariu" runat="server"></asp:Literal>
    
    <br />
    
    <asp:Label ID="Label4" runat="server" Text="Departament"></asp:Label>
    <asp:Literal ID="Departament" runat="server"></asp:Literal>
    
    
    <br />
    
    
    <asp:Button ID="Button1" runat="server" Text="DA" OnClick="Button1_Click" />
    <asp:Button ID="Button2" runat="server" Text="BA" OnClick="Button2_Click" />
    
    
    <br />
    
    
    <asp:Literal ID="EroareBazaDate" runat="server"></asp:Literal>

</asp:Content>

