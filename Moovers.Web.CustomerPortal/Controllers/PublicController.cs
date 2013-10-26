using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace MooversCRM.Controllers
{
    public class PublicController : BaseControllers.NonSecureBaseController
    {
        public ActionResult Browser()
        {
            return View();
        }

        public ActionResult Error()
        {
            return View();
        }

        public ActionResult Error404()
        {
            Response.StatusCode = 404;
            Response.TrySkipIisCustomErrors = true;
            return View();
        }

        public ActionResult ConfirmMove(string id)
        {
            var confirmRepo = new Business.Models.ScheduleConfirmationRepository();
            var confirm = confirmRepo.Get(id);

            if (confirm != null)
            {
                ViewBag.Key = id;
                return View(confirm);
            }

            if (!String.IsNullOrEmpty(id))
            {
                ViewBag.ErrorMessage = "Your confirmation code wasn't found, please make sure you typed it correctly, or call us at 1-800-MOOVERS";
            }

            return View();
        }

        public ActionResult ProposalView(string id)
        {
            var repo = new Business.Models.ScheduleConfirmationRepository();
            var confirmation = repo.Get(id);
            var file = confirmation.Quote.GetFiles().Where(i => i.Name.Contains("Proposal")).OrderByDescending(i => i.Created).FirstOrDefault();

            if (file != null)
            {
                return File(file.SavedContent, file.ContentType);
            }

            return HttpNotFound();
        }

        public ActionResult EmailView(string id)
        {
            var repo = new Business.Models.ScheduleConfirmationRepository();
            var confirm = repo.Get(id);

            if (confirm == null)
            {
                return HttpNotFound();
            }

            ViewBag.ShowEmailLink = false;
            return Content(RenderViewToString("Emails/MoveConfirmation", confirm), "text/html");
        }

        [HttpPost]
        public ActionResult Confirm(string key)
        {
            if (!String.IsNullOrEmpty(key))
            {
                var confirmRepo = new Business.Models.ScheduleConfirmationRepository();
                var confirm = confirmRepo.Get(key);
                var repo = new Business.Models.QuoteRepository();
                var quote = repo.Get(confirm.QuoteID);
                quote.ConfirmQuote("Email Form", Request["REMOTE_ADDR"], Request["HTTP_USER_AGENT"]);
                repo.Save();
                return RedirectToAction("ConfirmMove", new {
                    id = key
                });
            }

            return HttpNotFound();
        }

        public ActionResult Unsubscribe(string email)
        {
            email = email.Trim().Replace("~", ".");
            if (String.IsNullOrEmpty("email"))
            {
                return HttpNotFound();
            }

            var repo = new Business.Models.EmailUnsubscribeRepository();
            if (!repo.Exists(email))
            {
                var unsubscribe = new Business.Models.EmailUnsubscribe(email, Request.ServerVariables["REMOTE_ADDR"]);
                repo.Add(unsubscribe);
                repo.Save();
            }

            return View((object)email);
        }
    }
}
