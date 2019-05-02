using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Mvc;
using System.Web.UI;

namespace Lab7.Controllers
{
    public class Lab7Controller : Controller
    {
        // GET: Lab7
        public ActionResult AfisearaText(String text)
        {
            return Content(text);
        }

        public ActionResult Download(String fisier, String text)
        {
            byte[] fisier2 = Encoding.ASCII.GetBytes(text);
            return File(fisier2,
                System.Net.Mime.MediaTypeNames.Application.Octet, fisier);
        }

        public ActionResult goToGoogle()
        {
            return Redirect("https://www.google.com/?gws_rd=cr");
        }

        public ActionResult redirectAux()
        {
            return Redirect("GoToGoogle");
        }

        [ActionName("2")]
        [OutputCache(Duration = 60, Location = OutputCacheLocation.Client, VaryByParam = "*")]
        public ActionResult getDate()
        {
            String text = "";
            DateTime data = DateTime.Now;
            text = data.ToString();
            return Content(text);
        }

        [NonAction]
        public String getCeva()
        {
            return "ceva";
        }

    }
}