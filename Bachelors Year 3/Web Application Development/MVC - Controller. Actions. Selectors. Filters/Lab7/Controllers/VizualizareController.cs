using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Lab7.Controllers
{
    public class VizualizareController : Controller
    {
        // GET: Vizualizare
        public ActionResult Index()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Index(String nume)
        {
            return Content(nume);
        }
    }
}