using System.Web;
using System.Web.Mvc;

namespace Moovers.Web.CustomerPortal
{
    public class FilterConfig
    {
        public static void RegisterGlobalFilters(GlobalFilterCollection filters)
        {
            filters.Add(new HandleErrorAttribute());
        }
    }
}