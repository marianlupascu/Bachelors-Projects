using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Add : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
    }


    protected void Button1_Click(object sender, EventArgs e)
    {
        String nume = TextBox1.Text;
        String prenume = TextBox2.Text;
        Double salariu = Double.Parse(TextBox3.Text);
        int departament = DropDownList1.SelectedIndex + 1;
        String query = "INSERT INTO Angajati " +
                       "(NUME, PRENUME, SALARIU, DEPARTAMENT)" +
                       "VALUES(@NUME, @PRENUME, @SALARIU, @ID_DEP)";
        //Response.Write(query);

        SqlConnection con =
            new SqlConnection(@"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\Database.mdf;Integrated Security=True");

        con.Open();
        try
        {
            // Introducem parametrii in cererea SQL
            SqlCommand com = new SqlCommand(query, con);
            com.Parameters.AddWithValue("NUME", nume);
            com.Parameters.AddWithValue("PRENUME", prenume);
            com.Parameters.AddWithValue("SALARIU", salariu);
            com.Parameters.AddWithValue("ID_DEP", departament);
            com.ExecuteNonQuery();
            EroareBazaDate.Text = "Merge";
            Response.Redirect("lab4.aspx");
        }
        catch (Exception ex)
        {
            EroareBazaDate.Text = "Eroare din baza de date: " + ex.Message;
        }
        finally
        {
            // Nu lasam conexiunea deschisa.
            con.Close();
        }
        
    }
}