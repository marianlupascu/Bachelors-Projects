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
        if (Page.IsPostBack)
        {
            
        }
        else
        {
            Random r = new Random();
            int nr = r.Next(101);
            Session["MyRand"] = nr;
        }
    }

    protected void ClickBttn(object sender, EventArgs e)
    {

        if (Button1.Text == "Joacă din nou")
        {
            Button1.Text = "Submit";
            LiteralAfisareMesaj.Text = "";
            Random r = new Random();
            int nr = r.Next(101);
            Session["MyRand"] = nr;
        }
        else
        {
            if (int.Parse(TextBoxNumar.Text) == (int)Session["MyRand"])
            {
                Button1.Text = "Joacă din nou";
                LiteralAfisareMesaj.Text = "Asta e numarul";
            }
            else
            {
                if (int.Parse(TextBoxNumar.Text) > (int)Session["MyRand"])
                    LiteralAfisareMesaj.Text = "Numărul este mai mic";
                else
                {
                    LiteralAfisareMesaj.Text = "Numărul este mai mare";
                }
            }
        }
        
    }
}