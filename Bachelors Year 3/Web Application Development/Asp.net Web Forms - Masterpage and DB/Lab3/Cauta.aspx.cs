using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Cauta : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        
        if (!Page.IsPostBack)
        {
            String text = Request.Params["q"];
            if (text == "")
            {
                Literal1.Text = "Nici o data de afisat";
                Repeater1.ItemTemplate = null;
            }
            else
            {
                text = "%" + text + "%";
                SqlDataSource1.SelectCommand = " SELECT * FROM ANGAJATI WHERE NUME LIKE @nume";
                SqlDataSource1.SelectParameters.Add("nume", text);
                SqlDataSource1.DataBind();
            }

        }
    }

    protected void Repeater1_OnPreRender(object sender, EventArgs e)
    {
        //Literal1.Text = "";
        if (Repeater1.Items.Count == 0)
            Literal1.Text = "Nici o data de afisat";
    }
}