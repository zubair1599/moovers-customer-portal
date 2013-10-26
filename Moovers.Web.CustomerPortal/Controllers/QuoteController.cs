using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Business.Utility;

namespace MooversCRM.Controllers
{
    public class QuoteController : BaseControllers.SecureBaseController
    {
        //
        // GET: /Quote/

        public ActionResult Index(string search = "", Business.ViewModels.QuoteSort sort = Business.ViewModels.QuoteSort.LastModified, int page = 0, bool desc = true, int take = 25)
        {
            var repo = new Business.Models.AccountRepository();
             var quotes = repo.GetAccountByUserId(AspUserID).BillingQuotes;
             var items = new PagedResult<Business.Models.Quote>(quotes.AsQueryable() , page, take);
             var model = new Business.ViewModels.QuoteListModel(items, Business.ViewModels.QuoteSort.Date, true);
             return View(model);
            
        }

    }
}
