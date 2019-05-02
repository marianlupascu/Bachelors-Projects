using System.Web;
using System.Web.Mvc;
using Lab7.ActionFilters;

namespace Lab7
{
    public class FilterConfig
    {
        public static void RegisterGlobalFilters(GlobalFilterCollection filters)
        {
            filters.Add(new HandleErrorAttribute());
            filters.Add(new log());
        }
    }
}
