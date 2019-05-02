<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [Locatii]"></asp:SqlDataSource>
            <asp:GridView ID="GridView1" runat="server"
                          DataSourceID="SqlDataSource1">
            </asp:GridView>
            
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT a.Nume, a.Prenume, d.Nume AS Expr1, l.Oras, l.Tara FROM Angajati AS a INNER JOIN Departamente AS d ON a.Departament = d.Id INNER JOIN Locatii AS l ON d.Locatie = l.Id"></asp:SqlDataSource>
            <asp:GridView ID="GridView2" runat="server"
                          DataSourceID="SqlDataSource2" AutoGenerateColumns="False">
                <Columns>
                    <asp:BoundField DataField="Nume" HeaderText="Nume" SortExpression="Nume" />
                    <asp:BoundField DataField="Prenume" HeaderText="Prenume" SortExpression="Prenume" />
                    <asp:BoundField DataField="Expr1" HeaderText="Expr1" SortExpression="Expr1" />
                    <asp:BoundField DataField="Oras" HeaderText="Oras" SortExpression="Oras" />
                    <asp:BoundField DataField="Tara" HeaderText="Tara" SortExpression="Tara" />
                </Columns>
            </asp:GridView>
            
            <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [Angajati]" DeleteCommand="DELETE FROM [Angajati] WHERE [Id] = @Id" InsertCommand="INSERT INTO [Angajati] ([Nume], [Prenume], [Salariu], [Departament]) VALUES (@Nume, @Prenume, @Salariu, @Departament)" UpdateCommand="UPDATE [Angajati] SET [Nume] = @Nume, [Prenume] = @Prenume, [Salariu] = @Salariu, [Departament] = @Departament WHERE [Id] = @Id">
                <DeleteParameters>
                    <asp:Parameter Name="Id" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="Nume" Type="String" />
                    <asp:Parameter Name="Prenume" Type="String" />
                    <asp:Parameter Name="Salariu" Type="Double" />
                    <asp:Parameter Name="Departament" Type="Int32" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="Nume" Type="String" />
                    <asp:Parameter Name="Prenume" Type="String" />
                    <asp:Parameter Name="Salariu" Type="Double" />
                    <asp:Parameter Name="Departament" Type="Int32" />
                    <asp:Parameter Name="Id" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>
            <asp:GridView ID="GridView3" runat="server"
                          DataSourceID="SqlDataSource3" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="Id">
                <Columns>
                    <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
                    <asp:BoundField DataField="Id" HeaderText="Id" InsertVisible="False" ReadOnly="True" SortExpression="Id" />
                    <asp:BoundField DataField="Nume" HeaderText="Nume" SortExpression="Nume" />
                    <asp:BoundField DataField="Prenume" HeaderText="Prenume" SortExpression="Prenume" />
                    <asp:BoundField DataField="Salariu" HeaderText="Salariu" SortExpression="Salariu" />
                    <asp:BoundField DataField="Departament" HeaderText="Departament" SortExpression="Departament" />
                </Columns>
            </asp:GridView>
            <asp:ListView ID="ListView1" runat="server" DataKeyNames="Id" DataSourceID="SqlDataSource3" InsertItemPosition="LastItem">
                <AlternatingItemTemplate>
                    <tr style="">
                        <td></td>
                        <td>
                            <asp:Label ID="IdLabel" runat="server" Text='<%# Eval("Id") %>' />
                        </td>
                        <td>
                            <asp:Label ID="NumeLabel" runat="server" Text='<%# Eval("Nume") %>' />
                        </td>
                        <td>
                            <asp:Label ID="PrenumeLabel" runat="server" Text='<%# Eval("Prenume") %>' />
                        </td>
                        <td>
                            <asp:Label ID="SalariuLabel" runat="server" Text='<%# Eval("Salariu") %>' />
                        </td>
                        <td>
                            <asp:Label ID="DepartamentLabel" runat="server" Text='<%# Eval("Departament") %>' />
                        </td>
                    </tr>
                </AlternatingItemTemplate>
                <EditItemTemplate>
                    <tr style="">
                        <td>
                            <asp:Button ID="UpdateButton" runat="server" CommandName="Update" Text="Update" />
                            <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancel" />
                        </td>
                        <td>
                            <asp:Label ID="IdLabel1" runat="server" Text='<%# Eval("Id") %>' />
                        </td>
                        <td>
                            <asp:TextBox ID="NumeTextBox" runat="server" Text='<%# Bind("Nume") %>' />
                        </td>
                        <td>
                            <asp:TextBox ID="PrenumeTextBox" runat="server" Text='<%# Bind("Prenume") %>' />
                        </td>
                        <td>
                            <asp:TextBox ID="SalariuTextBox" runat="server" Text='<%# Bind("Salariu") %>' />
                        </td>
                        <td>
                            <asp:TextBox ID="DepartamentTextBox" runat="server" Text='<%# Bind("Departament") %>' />
                        </td>
                    </tr>
                </EditItemTemplate>
                <EmptyDataTemplate>
                    <table runat="server" style="">
                        <tr>
                            <td>No data was returned.</td>
                        </tr>
                    </table>
                </EmptyDataTemplate>
                <InsertItemTemplate>
                    <tr style="">
                        <td>
                            <asp:Button ID="InsertButton" runat="server" CommandName="Insert" Text="Insert" />
                            <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Clear" />
                        </td>
                        <td>&nbsp;</td>
                        <td>
                            <asp:TextBox ID="NumeTextBox" runat="server" Text='<%# Bind("Nume") %>' />
                        </td>
                        <td>
                            <asp:TextBox ID="PrenumeTextBox" runat="server" Text='<%# Bind("Prenume") %>' />
                        </td>
                        <td>
                            <asp:TextBox ID="SalariuTextBox" runat="server" Text='<%# Bind("Salariu") %>' />
                        </td>
                        <td>
                            <asp:TextBox ID="DepartamentTextBox" runat="server" Text='<%# Bind("Departament") %>' />
                        </td>
                    </tr>
                </InsertItemTemplate>
                <ItemTemplate>
                    <tr style="">
                        <td></td>
                        <td>
                            <asp:Label ID="IdLabel" runat="server" Text='<%# Eval("Id") %>' />
                        </td>
                        <td>
                            <asp:Label ID="NumeLabel" runat="server" Text='<%# Eval("Nume") %>' />
                        </td>
                        <td>
                            <asp:Label ID="PrenumeLabel" runat="server" Text='<%# Eval("Prenume") %>' />
                        </td>
                        <td>
                            <asp:Label ID="SalariuLabel" runat="server" Text='<%# Eval("Salariu") %>' />
                        </td>
                        <td>
                            <asp:Label ID="DepartamentLabel" runat="server" Text='<%# Eval("Departament") %>' />
                        </td>
                    </tr>
                </ItemTemplate>
                <LayoutTemplate>
                    <table runat="server">
                        <tr runat="server">
                            <td runat="server">
                                <table id="itemPlaceholderContainer" runat="server" border="0" style="">
                                    <tr runat="server" style="">
                                        <th runat="server"></th>
                                        <th runat="server">Id</th>
                                        <th runat="server">Nume</th>
                                        <th runat="server">Prenume</th>
                                        <th runat="server">Salariu</th>
                                        <th runat="server">Departament</th>
                                    </tr>
                                    <tr id="itemPlaceholder" runat="server">
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr runat="server">
                            <td runat="server" style=""></td>
                        </tr>
                    </table>
                </LayoutTemplate>
                <SelectedItemTemplate>
                    <tr style="">
                        <td></td>
                        <td>
                            <asp:Label ID="IdLabel" runat="server" Text='<%# Eval("Id") %>' />
                        </td>
                        <td>
                            <asp:Label ID="NumeLabel" runat="server" Text='<%# Eval("Nume") %>' />
                        </td>
                        <td>
                            <asp:Label ID="PrenumeLabel" runat="server" Text='<%# Eval("Prenume") %>' />
                        </td>
                        <td>
                            <asp:Label ID="SalariuLabel" runat="server" Text='<%# Eval("Salariu") %>' />
                        </td>
                        <td>
                            <asp:Label ID="DepartamentLabel" runat="server" Text='<%# Eval("Departament") %>' />
                        </td>
                    </tr>
                </SelectedItemTemplate>
            </asp:ListView>
            </div>
    </form>
</body>
</html>
