using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Lab7.ActionFilters
{
    public class log : ActionFilterAttribute, IActionFilter
    {

        public override void OnActionExecuted(ActionExecutedContext  filterContext)
        {
            StreamWriter obj = new
            StreamWriter(HttpContext.Current.Server.MapPath("~/data.txt"), true);
            obj.Write(DateTime.Now.ToString() + "\n" + filterContext.HttpContext.Request.Url + "\n");

            obj.Close();
        }
    }
}