using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Lab6.Controllers
{
    public class ComputeController : Controller
    {
        // GET: Compute
        [Route("Compute/{n:int}")]
        public String Index1(int n)
        {
            int nr = 0;
            while (n != 0)
            {
                if (n % 2 == 0)
                    nr++;
                n = n / 10;
            }

            return "Nr pare = " + nr.ToString();
        }


        [Route("Compute/{n:alpha}")]
        public String Index1(String n)
        {
            int nr = 0;
            n = n.ToLower();
            String voc = "aeiou";
            for(int i= 0; i < n.Length; i++)
                if (voc.Contains(n[i]))
                    nr++;

            return "Nr vocali = " + nr.ToString();
        }
    }
}