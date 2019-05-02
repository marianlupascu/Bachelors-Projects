using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

namespace Lab6
{
    public class RouteConfig
    {
        public static void RegisterRoutes(RouteCollection routes)
        {
            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");

            routes.MapMvcAttributeRoutes();

            routes.MapRoute(
                name: "Name",
                url: "Hello/{aaaa}",
                defaults: new
                {
                    controller = "Hello",
                    action = "Name",
                    aaaa = "World"
                }
            );

            routes.MapRoute(
                name: "Hello",
                url: "Hello/{nume}/{varsta}",
                defaults: new
                {
                    controller = "Hello",
                    action = "Index",
                    nume = "World",
                    varsta = UrlParameter.Optional
                },
                constraints: new { varsta = @"\d+" }
            );

            routes.MapRoute(
                name: "Hellox",
                url: "Hello/{nr}",
                defaults: new
                {
                    controller = "Hello",
                    action = "Hellox",
                    nr = "1"
                },
                constraints: new { nr = @"\d+" }
            );



            routes.MapRoute(
                name: "Default2",
                url: "Laborator6",
                defaults: new { controller = "Home", action = "About", id = UrlParameter.Optional }
            );

            routes.MapRoute(
                name: "Default",
                url: "{controller}/{action}/{id}",
                defaults: new { controller = "Home", action = "Index", id = UrlParameter.Optional }
            );
        }
    }
}
