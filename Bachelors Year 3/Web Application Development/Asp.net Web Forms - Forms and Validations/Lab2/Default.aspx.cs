using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void ClickBttn(object sender, EventArgs e)
    {
        Response.Write("Nume = " + TextBoxNume.Text + " <br/>");
        Response.Write("Prenume = " +  TextBox1.Text + "<br/>");
        Response.Write("Mail = " +  TextBox2.Text + "<br/>");
        Response.Write("Parola = " + TextBox3.Text + "<br/>");
        Response.Write("ConfirmareParola = " + TextBox4.Text + "<br/>");
        Response.Write("Facultate = " + DropDownList1.Text + "<br/>");
        Response.Write("An" + DropDownList2.Text + "<br/>");
        Response.Write("DataNasterii = " + TextBox5.Text + "<br/>");
        Response.Write("Sex = " + RadioButtonList1.Text + "<br/>");
        Response.Write("Varsta = " + TextBox6.Text + "<br/>");
        Response.Write("Angajat = " + CheckBox1.Checked + "<br/>");
    }


    protected void CustomValidator1_ServerValidate(object source, ServerValidateEventArgs args)
    {
        args.IsValid = false;
        DateTime dataNasterii = DateTime.Parse(TextBox5.Text);
        DateTime now = DateTime.Now;

        TimeSpan a = now.ToUniversalTime() - dataNasterii.ToUniversalTime();
        int varsta = int.Parse(TextBox6.Text);
        if (Math.Floor(a.TotalDays / 365) == varsta)
        {
            args.IsValid = true;
        }
        else
        {
            args.IsValid = false;
        }
    }

    protected void CheckBox1_OnCheckedChanged(object sender, EventArgs e)
    {
        Panel1.Visible = !Panel1.Visible;
    }

    protected void Button2_OnClick(object sender, EventArgs e)
    {
        Response.Write(TextBox9.Text);
    }
}