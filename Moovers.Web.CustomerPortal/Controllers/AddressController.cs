using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace MooversCRM.Controllers
{
    public class AddressController : BaseControllers.NonSecureBaseController
    {
        [HttpPost]
        public ActionResult GetSuggestions(Business.Models.Address address)
        {
            var candidates = Enumerable.Empty<Business.Utility.SmartyStreet.CandidateAddress>();
            if (!String.IsNullOrEmpty(address.Street1))
            {
                candidates = Business.Utility.AddressVerification.GetCandidates(address);
            }

            return Json(candidates);
        }

        [HttpPost]
        public ActionResult VerifyZipCode(string zip)
        {
            var repo = new Business.Models.ZipCodeRepository();

            var zipCode = repo.Get(zip);
            if (zipCode == null)
            {
                var errorModel = new Business.ViewModels.ErrorModel("zip", "Couldn't find the zip");
                return Json(errorModel);
            }

            var latLng1 = new Business.Utility.LatLng() { Latitude = (double)zipCode.Latitude, Longitude = (double)zipCode.Longitude };
            var latLng2 = new Business.Utility.LatLng() { Latitude = Business.Utility.DistanceCalculator.KansasCityLatitude, Longitude = Business.Utility.DistanceCalculator.KansasCityLongitude };

            try
            {
                // before verifying an address, make sure we can get directions to/from it, because we use distance calculations a lot, and can't have them throwing errors
                latLng1.GetDistance(latLng2);
            }
            catch (Exception e)
            {
                var errorrepo = new Business.Models.ErrorRepository();
                errorrepo.Log(e, "VerifyZip", new System.Collections.Specialized.NameValueCollection(), new System.Collections.Specialized.NameValueCollection());
                errorrepo.Save();
            }

            return Content("Success");
        }

        [HttpGet]
        public ActionResult GetDistance(Guid address1id, Guid address2id)
        {
            var addressRepo = new Business.Models.AddressRepository();
            var address1 = addressRepo.Get(address1id);
            var address2 = addressRepo.Get(address2id);
            var distance = address1.GetLatLng().GetDistance(address2.GetLatLng());
            var time = address1.GetLatLng().GetTime(address2.GetLatLng());

            return Json(new
            {
                distance = Math.Ceiling(distance),
                time = Math.Ceiling(time)
            }, JsonRequestBehavior.AllowGet);
        }
    }
}
