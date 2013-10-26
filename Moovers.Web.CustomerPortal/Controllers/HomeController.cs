using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;

namespace MooversCRM.Controllers
{
    public class HomeController : BaseControllers.SecureBaseController
    {
        [Authorize]
        [HttpGet]
        public ActionResult Index(string error = "")
        {

            return View();
        }

    }
}
