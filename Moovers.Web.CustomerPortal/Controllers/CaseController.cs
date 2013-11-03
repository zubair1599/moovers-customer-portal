﻿using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
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

        public ActionResult Index(string lookup)
        {

            var claimlistmodel = new Business.ViewModels.ClaimListModel();

            var quoterepo = new Business.Models.QuoteRepository();
            var quote = quoterepo.Get(lookup);
            Guid quoteId = quote.QuoteID;
            var Case = quote.Cases.FirstOrDefault();

            if (Case == null)
            {
                var caserespo = new Business.Models.CaseRepository();

                var rel = new Case
                {
                    Status = true,
                    Created = DateTime.Now,
                    Updated = DateTime.Now,
                    QuoteID = quoteId,


                };

                caserespo.Add(rel);

                caserespo.Save();
                claimlistmodel.CaseId = rel.CaseID;
                // lookup number is generated by trigger in db and after save repo entity does not contain its updated value so another call in db to get lookup number.
                var updatedcaserepo = new Business.Models.CaseRepository();
                claimlistmodel.Caselookup = updatedcaserepo.Get(rel.CaseID).Lookup;
            }
            else
            {
                claimlistmodel.CaseId = Case.CaseID;
                claimlistmodel.Claim = Case.Claims;
                claimlistmodel.Caselookup = Case.Lookup;


            }
            return View(claimlistmodel);

        }





        [HttpPost]
        public ActionResult AddClaims(Business.ViewModels.ClaimListModel modal, Guid CaseId)
        {

            var caserepo = new Business.Models.CaseRepository();
            var claimrepo = new Business.Models.ClaimRespository();

            var rel = new Claim
            {
                Inventroy = modal.CustomerClaim.Inventroy,
                ClaimType = modal.CustomerClaim.ClaimType,
                Remarks = modal.CustomerClaim.Remarks,
                Created = DateTime.Now,
                CaseID = CaseId

            };

            foreach (string fileitem in Request.Files)
            {
                HttpPostedFileBase InventoryImage = Request.Files[fileitem] as HttpPostedFileBase;
                if (InventoryImage.ContentLength == 0)
                    continue;
                var rel_claim_inventory = new Claim_Inventory_Items
                           {
                               Created = DateTime.Now,
                               updated = DateTime.Now,
                               ClaimInventoryImage = User.Identity.Name + "_" + InventoryImage.FileName,
                               FileUploadControllerName = fileitem,
                               ImageOrignalName = InventoryImage.FileName

                           };

                rel.Claim_Inventory_Items.Add(rel_claim_inventory);
                var caselookup = caserepo.Get(CaseId).Lookup;
                SaveInventoryImageonFolder(caselookup, InventoryImage, rel_claim_inventory.ClaimInventoryImage);
            }
            claimrepo.Add(rel);
            claimrepo.Save();


            modal.CustomerClaim.Inventroy = rel.Inventroy;
            modal.CustomerClaim.Remarks = rel.Remarks;
            // modal.CustomerClaim.ClaimTypeDisplayName = Enum.GetName(typeof(Business.ViewModels.ClaimType), rel.ClaimType);
            modal.CustomerClaim.ClaimID = rel.ClaimID;
            modal.CustomerClaim.Created = rel.Created;
            return Content(modal.CustomerClaim.SerializeToJson(), "text/json");
        }

        [HttpPost]
        public ActionResult UpdateClaim(Business.ViewModels.ClaimListModel modal, Guid CaseId, Guid ClaimId)
        {

            var repo = new Business.Models.ClaimRespository();
            var caserepo = new Business.Models.CaseRepository();
            Claim claim = repo.Get(ClaimId);
            foreach (string fileitem in Request.Files)
            {
                HttpPostedFileBase InventoryImage = Request.Files[fileitem] as HttpPostedFileBase;
                if (InventoryImage.ContentLength == 0)
                    continue;
                var rel_claim_inventory = new Claim_Inventory_Items
                {
                    //Created = DateTime.Now,
                    updated = DateTime.Now,
                    ClaimInventoryImage = User.Identity.Name + "_" + InventoryImage.FileName,
                    FileUploadControllerName = fileitem,
                    ImageOrignalName = InventoryImage.FileName

                };

                claim.Claim_Inventory_Items.Add(rel_claim_inventory);
                var caselookup = caserepo.Get(CaseId).Lookup;
                SaveInventoryImageonFolder(caselookup, InventoryImage, rel_claim_inventory.ClaimInventoryImage);
            }
            // repo.add(claim);

            claim.Inventroy = modal.CustomerClaim.Inventroy;
            claim.Remarks = modal.CustomerClaim.Remarks;
            claim.ClaimType = modal.CustomerClaim.ClaimType;

            repo.Save();
            modal.CustomerClaim.ClaimID = ClaimId;
            modal.CustomerClaim.Created = claim.Created;
            //modal.CustomerClaim.ClaimTypeDisplayName = Enum.GetName(typeof(Business.ViewModels.ClaimType), claim.ClaimType);
            return Content(Extensions.SerializeToJson(modal.CustomerClaim), "text/json");

        }

        private void SaveInventoryImageonFolder(string caselookup, HttpPostedFileBase file, string filename)
        {
            string physicalpath = System.Configuration.ConfigurationManager.AppSettings["InventoryImagesPath"];
            physicalpath = physicalpath + caselookup;
            if (!Directory.Exists(physicalpath))
            {
                Directory.CreateDirectory(physicalpath);
            }


            file.SaveAs(physicalpath + "/" + filename);
        }

        [HttpPost]

        public ActionResult RemoveClaim(Guid id)
        {
            var repo = new Business.Models.ClaimRespository();
            repo.Remove(id);
            repo.Save();
            return Content("Removed");

        }


        public ActionResult GetInventoryImages(Guid id)
        {
            var repo = new Business.Models.ClaimRespository();
            var modal = new Business.ViewModels.ClaimListModel();
            List<Claim_Inventory_Items> lstClaimInventoryItems = new List<Claim_Inventory_Items>();
            IEnumerable<Claim_Inventory_Items> claiminventory = repo.Get(id).Claim_Inventory_Items;
            foreach (var item in claiminventory)
            {
                Claim_Inventory_Items InventoryItem = new Claim_Inventory_Items();
                InventoryItem.FileUploadControllerName = item.FileUploadControllerName;
                InventoryItem.ImageOrignalName = item.ImageOrignalName;
                lstClaimInventoryItems.Add(InventoryItem);
            }


            return Content(Extensions.SerializeToJson(lstClaimInventoryItems), "text/json");
        }

    }
}
