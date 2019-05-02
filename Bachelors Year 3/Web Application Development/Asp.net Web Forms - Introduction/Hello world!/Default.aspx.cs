using System;
using System.Activities.Statements;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services.Description;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Page.IsPostBack)
            LiteralTF.Text = "True";
        else
            LiteralTF.Text = "False";
    }

    protected void ClickBttnHTML(object sender, EventArgs e)
    {
        Text2.Value = InputText.Value;
    }

    protected void ClickBttn(object sender, EventArgs e)
    {
        LiteralAfisareNume.Text = TextBoxNume.Text;
    }
}