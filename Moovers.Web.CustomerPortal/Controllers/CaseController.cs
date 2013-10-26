using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Business.Models;
using Business.Utility;

namespace MooversCRM.Controllers
{
    public class CaseController : BaseControllers.SecureBaseController
    {
        //
        // GET: /Case/

        public ActionResult Index()
        {

            var claimlistmodel = new Business.ViewModels.ClaimListModel();
            TempData["modal"] = null;
            return View(claimlistmodel);

        }


        public ActionResult AddCase(string lookup)
        {
            var quoterepo = new Business.Models.QuoteRepository();
            Guid quoteId = quoterepo.Get(lookup).QuoteID;
            var caserespo = new Business.Models.CaseRepository();


            var rel = new Case
            {
                Status = true,
                Created = DateTime.Now,
                Updated = DateTime.Now,
                QuoteID = quoteId,


            };
            if (TempData["modal"] != null)
            {
                var customerclaims = (List<Claim>)TempData["modal"];
                foreach (var item in customerclaims)
                {
                    rel.Claims.Add(item);
                }
            }


            caserespo.Add(rel);
            TempData["modal"] = null;

            caserespo.Save();
            return Json("");

        }
        [HttpPost]

        public ActionResult AddClaims(Business.ViewModels.ClaimListModel modal)
        {
            var rel = new Claim
            {
                Inventroy = modal.CustomerClaim.Inventroy,
                ClaimType = modal.CustomerClaim.ClaimType,
                Remarks = modal.CustomerClaim.Remarks,
                Created = DateTime.Now,

            };


            //temp.Add(rel);

            if (TempData["modal"] != null)
            {

                modal.ClaimList = (List<Claim>)TempData["modal"];
                modal.ClaimList.Add(rel);
                TempData["modal"] = modal.ClaimList;
            }
            else
            {
                modal.ClaimList.Add(rel);
                TempData["modal"] = modal.ClaimList;
            }

            modal.Claim = modal.ClaimList;
            return Content(Extensions.SerializeToJson(modal.Claim), "text/json");
            // return View("index" , modal);

        }

    }
}
