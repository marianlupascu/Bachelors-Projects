using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Delete : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        if (IsPostBack == false)
        {

            Response.Write("Sunteti sigur ca vreti sa stergeti aceasta inregistrare?\n");
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
        }

    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        if (Request.Params["id"] != null)
        {
            // Luam ID-ul
            int ID = int.Parse(Request.Params["id"].ToString());
            // Salvam cererea SQL intr-un string
            string query = "DELETE"
                           + " FROM ANGAJATI"
                           + " WHERE id = @id";
            // Deschidem conexiunea la baza de date
            SqlConnection con = new SqlConnection(@"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\Database.mdf;Integrated Security=True");

            // Incercam sa executam comanda
            try
            {
                con.Open();
                // Se construieste comanda SQL
                SqlCommand com = new SqlCommand(query, con);
                com.Parameters.AddWithValue("id", ID);
                int deleted = com.ExecuteNonQuery();
                if (deleted > 0)
                {
                    Response.Write("Intrarea a fost stearsa din baza de date");
                }
                else
                {
                    Response.Write("Intrarea nu a fost stearsa. Va rugam incercati din nou");
                }
                Response.Redirect("lab4.aspx");
            }
            catch (Exception ex)
            {
                Response.Write("Eroare din baza de date: " + ex.Message);
            }
            finally
            {
                con.Close();
            }

        }
        
    }

    protected void Button2_Click(object sender, EventArgs e)
    {
        Response.Redirect("lab4.aspx");
    }
}