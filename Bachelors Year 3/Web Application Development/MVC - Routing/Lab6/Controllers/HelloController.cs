using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Lab6.Controllers
{
    public class HelloController : Controller
    {
        public String Name(string aaaa)
        {
            return "Hello " + aaaa;
        }

        public String Hellox(int nr)
        {
            String ret = "";
            for (int i = 1; i <= nr; i++)
            {
                ret = ret + "Hello ";
            }

            return ret;
        }
        // GET: Hello
        public String Index(string nume, int? varsta)
        {
            if (varsta != null)
            {
                return "Hello, " + nume + " this guy have " + varsta + " years old.";
            }
            else
            {
                return "Hello, " + nume;
            }
        }
    }
}