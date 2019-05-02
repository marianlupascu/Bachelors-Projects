<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Admin.aspx.cs" Inherits="Admin_Admin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <h1>Welcome to the administrator page.</h1>
    <asp:LoginView runat="server">
        <RoleGroups>

        </RoleGroups>
    </asp:LoginView>
</asp:Content>

