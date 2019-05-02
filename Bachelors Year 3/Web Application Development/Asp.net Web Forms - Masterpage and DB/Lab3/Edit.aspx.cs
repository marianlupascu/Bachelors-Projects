using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Edit : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (IsPostBack == false)
        {
            int id = int.Parse(Request.Params["id"].ToString());

            string query = "SELECT *"
                           + " FROM ANGAJATI"
                           + " WHERE id = @id";

            SqlConnection con =
                new SqlConnection(@"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\Database.mdf;Integrated Security=True");

            con.Open();
            try
            {
                // Se construieste comanda SQL
                SqlCommand com = new SqlCommand(query, con);
                com.Parameters.AddWithValue("id", id);
                // Se executa comanda si se returneaza valorile intr-un reader
                SqlDataReader reader = com.ExecuteReader();
                // Citim rand cu rand din baza de date
                while (reader.Read())
                {
                    Nume.Text = reader["NUME"].ToString();
                    Prenume.Text = reader["PRENUME"].ToString();
                    Salariu.Text = reader["SALARIU"].ToString();
                    Departament.Text = reader["DEPARTAMENT"].ToString();
                }
            }
            catch (Exception ex)
            {
                EroareBazaDate.Text = "Eroare din baza de date: " + ex.Message;
            }
            finally
            {
                con.Close();
            }

            TextBox1.Text = Nume.Text;
            TextBox2.Text = Prenume.Text;
            TextBox3.Text = Salariu.Text;
            DropDownList1.SelectedIndex = int.Parse(Departament.Text) - 1;
        }
    }


    protected void Button1_Click(object sender, EventArgs e)
    {
        String nume = TextBox1.Text;
        String prenume = TextBox2.Text;
        Double salariu = Double.Parse(TextBox3.Text);
        int departament = DropDownList1.SelectedIndex + 1;
        String query = "UPDATE Angajati " +
                       "SET NUME = @NUMEQ, PRENUME = @PRENUMEQ, SALARIU = @SALARIUQ, DEPARTAMENT = @ID_DEPQ " +
                       "WHERE Id = @id";
        //Response.Write(query);

        SqlConnection con =
            new SqlConnection(@"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\Database.mdf;Integrated Security=True");

        con.Open();
        try
        {
            // Introducem parametrii in cererea SQL
            SqlCommand com = new SqlCommand(query, con);
            com.Parameters.AddWithValue("NUMEQ", nume);
            com.Parameters.AddWithValue("PRENUMEQ", prenume);
            com.Parameters.AddWithValue("SALARIUQ", salariu);
            com.Parameters.AddWithValue("ID_DEPQ", departament);
            com.Parameters.AddWithValue("id", Request.Params["id"].ToString());
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
