using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Http;
using System.Web.Mvc;
using System.Web.Optimization;
using System.Web.Routing;

namespace Moovers.Web.CustomerPortal
{
    // Note: For instructions on enabling IIS6 or IIS7 classic mode, 
    // visit http://go.microsoft.com/?LinkId=9394801

    public class MvcApplication : System.Web.HttpApplication
    {
        protected void Application_Start()
        {

            

            ViewEngines.Engines.Add(new RazorViewEngine());
            AreaRegistration.RegisterAllAreas();
            

            WebApiConfig.Register(GlobalConfiguration.Configuration);
            FilterConfig.RegisterGlobalFilters(GlobalFilters.Filters);
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            //BundleConfig.RegisterBundles(BundleTable.Bundles);
            //AuthConfig.RegisterAuth();
        }

//           protected void Application_Error(object sender, EventArgs e)
//        {
//            var context = HttpContext.Current;
//            var repo = new Business.Models.ErrorRepository();

//            var error = context.Server.GetLastError();
//            if (error is HttpException && ((HttpException)error).GetHttpCode() == 404)
//            {
//                Server.ClearError();
//                context.Response.StatusCode = 404;
//                var routedata = new RouteData();
//                routedata.Values.Add("controller", "Public");
//                routedata.Values.Add("action", "Error404");
//                IController errorController = new MooversCRM.Controllers.PublicController();
//                errorController.Execute(new RequestContext(new HttpContextWrapper(Context), routedata));
//                return;
//            }

//            if (error.InnerException != null)
//            {
//                error = error.InnerException;
//            }

//            repo.Log(error, context.Request.Url.ToString(), context.Request.ServerVariables, context.Request.Form);
//            repo.Save();

//#if !DEBUG
//            context.Server.ClearError();
//            context.Response.StatusCode = 500;
//            context.Response.Redirect("~/Error");
//#endif
//        }
    }
    }
