using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

namespace Lab7
{
    public class RouteConfig
    {
        public static void RegisterRoutes(RouteCollection routes)
        {
            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");

            routes.MapRoute(
                name: "getDate",
                url: "cerinta2",
                defaults: new { controller = "Lab7", action = "getDate" }
            );

            routes.MapRoute(
                name: "redirect",
                url: "d",
                defaults: new { controller = "Lab7", action = "redirectAux"}
            );

            routes.MapRoute(
                name: "GoToGoogle",
                url: "c",
                defaults: new { controller = "Lab7", action = "goToGoogle" }
            );

            routes.MapRoute(
                name: "Download",
                url: "b/{fisier}/{text}",
                defaults: new { controller = "Lab7", action = "Download"}
            );

            routes.MapRoute(
                name: "text",
                url: "a/{text}",
                defaults: new { controller = "Lab7", action = "AfisearaText", text = "Buna" }
            );

            routes.MapRoute(
                name: "Default",
                url: "{controller}/{action}/{id}",
                defaults: new { controller = "Home", action = "Index", id = UrlParameter.Optional }
            );
        }
    }
}
