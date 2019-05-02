<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Home.aspx.cs" Inherits="Home" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    
    <a href ="Add.aspx">Add</a>

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [Angajati]"></asp:SqlDataSource>
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="Id" DataSourceID="SqlDataSource1">
        <Columns>
            <asp:BoundField DataField="Id" HeaderText="Id" InsertVisible="False" ReadOnly="True" SortExpression="Id" />
            <asp:BoundField DataField="Nume" HeaderText="Nume" SortExpression="Nume" />
            <asp:BoundField DataField="Prenume" HeaderText="Prenume" SortExpression="Prenume" />
            <asp:BoundField DataField="Salariu" HeaderText="Salariu" SortExpression="Salariu" />
            <asp:BoundField DataField="Departament" HeaderText="Departament" SortExpression="Departament" />
            <asp:HyperLinkField DataNavigateUrlFields="Id"
                                DataNavigateUrlFormatString="~/Edit.aspx?id={0}"
                                HeaderText="Edit Car" Text="Edit" />
            <asp:HyperLinkField DataNavigateUrlFields="Id"
                                DataNavigateUrlFormatString="~/Delete.aspx?id={0}"
                                HeaderText="Delete" Text="Delete" />
        </Columns>
    </asp:GridView>

</asp:Content>

