using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Business.Models;

namespace MooversCRM.Controllers
{
    public class NewCaseController : BaseControllers.SecureBaseController
    {
        //
        // GET: /NewCase/

        public ActionResult Index()
        {

            var repo = new Business.Models.AccountRepository() ;
          // var inventoryitems = repo.GetAccountByUserId(AspUserID).StorageWorkOrders.FirstOrDefault().StorageWorkOrder_InventoryItem_Rel.FirstOrDefault().InventoryItem;
            var claimlistmodel = new Business.ViewModels.ClaimListModel();
            
            return View("../Case/NewCase" , claimlistmodel);
            
        }

        [HttpPost]
        public ActionResult AddCase(Business.ViewModels.ClaimListModel modal)

        {
            var caserespo = new Business.Models.CaseRepository();
            var repo = new Business.Models.AccountRepository();
            var inventoryitems = repo.GetAccountByUserId(AspUserID);
            var rel = new Case
            {
                Status =  (int)Business.ViewModels.CaseStatus.Pending,
                Created = DateTime.Now,
                Updated = DateTime.Now,
                
            };
            //rel.Claims.Add(modal.CustomerClaim);

            caserespo.Add(rel);
            caserespo.Save();
            return View();
        
        }

    }
}
