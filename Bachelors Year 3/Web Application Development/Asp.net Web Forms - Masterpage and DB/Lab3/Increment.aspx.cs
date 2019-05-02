using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Increment : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Session["sesCount"] = Convert.ToInt32(Session["sesCount"]) + 1;
        Application["hitCount"] = Convert.ToInt32(Application["hitCount"]) + 1;
        Response.Write("sesCount = "+ Session["sesCount"] + '\n');
        Response.Write("hitCount = " + Application["hitCount"]);
    }
}