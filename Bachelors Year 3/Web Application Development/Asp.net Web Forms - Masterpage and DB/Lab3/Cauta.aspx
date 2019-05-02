<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Cauta.aspx.cs" Inherits="Cauta" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [Nume], [Prenume], [Salariu], [Departament] FROM [Angajati]"></asp:SqlDataSource>
    </br>
    <asp:Repeater OnPreRender="Repeater1_OnPreRender" ID="Repeater1" runat="server" DataSourceID="SqlDataSource1">
        <HeaderTemplate>NUME PRENUME SALARIU </br></HeaderTemplate>
        <ItemTemplate><%#Eval("nume") %> <%#Eval("prenume")%> <%#Eval("salariu") %></br></ItemTemplate>
    </asp:Repeater>
    <asp:Literal ID="Literal1" runat="server"></asp:Literal>

</asp:Content>

