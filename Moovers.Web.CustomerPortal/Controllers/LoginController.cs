﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;

namespace MooversCRM.Controllers
{
#if RELEASE
    [RequireHttps]
#endif
    public class LoginController : BaseControllers.NonSecureBaseController
    {
        public ActionResult Index(string username = "", bool reset = false)
        {
            ViewBag.Username = username;
            ViewBag.Reset = reset;

            if (User.Identity.IsAuthenticated)
            {
                return RedirectToAction("Index", "Home");
            }

            return View();
        }

        [HttpPost]
        public ActionResult Index(string username, string password, bool rememberMe = false)
        {
            ViewBag.Username = username;
            ViewBag.Reset = false;
            int UserType = -1;
            if (ModelState.IsValid)
            {
                var aspUserRepo = new Business.Models.aspnet_UserRepository();
                var aspUser = aspUserRepo.Get(username);
                if (aspUser != null)
                {
                    UserType = aspUser.aspnet_Users_Profile.FirstOrDefault() == null ? -1 : aspUser.aspnet_Users_Profile.FirstOrDefault().UserType.HasValue ? aspUser.aspnet_Users_Profile.FirstOrDefault().UserType.Value : -1;
                }


                if (!Membership.ValidateUser(username, password) || UserType != (int)Business.Models.UserType.Customer)
                {
                    ModelState.AddModelError("username", "User and password combination doesn't exist");
                    return View();
                }


                FormsAuthentication.SetAuthCookie(username, rememberMe, "/");
            }

            return RedirectToAction("Index", "Home");
        }

        public ActionResult Login()
        {
            return RedirectToActionPermanent("Index");
        }

        public ActionResult LogOff()
        {
            FormsAuthentication.SignOut();
            Session.Abandon();
            return RedirectToAction("Index", "Home");
        }

        public ActionResult ForgotPassword(bool success = false)
        {
            ViewBag.Success = success;
            return View();
        }

        [HttpPost]
        public ActionResult ForgotPassword(string username)
        {
            MembershipUser aspUser = Membership.GetUser(username);
            if (aspUser == null)
            {
                username = Membership.GetUserNameByEmail(username) ?? String.Empty;
                aspUser = Membership.GetUser(username);
            }

            if (aspUser == null)
            {
                ModelState.AddModelError("username", "User not found in the system");
                ViewBag.Success = false;
                return View();
            }

            var repo = new Business.Models.PasswordResetRepository();
            var reset = new Business.Models.PasswordReset
            {
                UserName = username
            };
            repo.Add(reset);
            repo.Save();

            var body = RenderViewToString("Emails/PasswordReset", reset.ResetKey);
            var subject = "Your Moovers CRM Password Reset Link";
            Business.Utility.Email.SendEmail(aspUser.Email, "support@1800moovers.com", subject, body);

            return RedirectToAction("ForgotPassword", new { success = true });
        }

        public ActionResult ResetPassword(string id, bool success = false)
        {
            var repo = new Business.Models.PasswordResetRepository();
            var reset = repo.Get(id);
            if (reset == null)
            {
                return HttpNotFound();
            }

            ViewBag.Success = success;
            return View(reset);
        }

        [HttpPost]
        public ActionResult ResetPassword(string id, string password, string confirmpassword)
        {
            var repo = new Business.Models.PasswordResetRepository();
            var reset = repo.Get(id);

            if (reset == null)
            {
                return HttpNotFound();
            }

            if (password != confirmpassword)
            {
                ModelState.AddModelError("password", "please ensure your passwords match");
            }

            if (ModelState.IsValid)
            {
                var user = Membership.GetUser(reset.UserName);
                user.UnlockUser();
                var pass = user.ResetPassword();

                try
                {
                    user.ChangePassword(pass, password);
                    reset.DateRequested = new DateTime(1970, 1, 1);
                    repo.Save();
                    return RedirectToAction("Index", new { reset = true });
                }
                catch (Exception)
                {
                    ModelState.AddModelError("password", "Please ensure your password has a number, a letter, and a symbol.");
                }
            }

            return View(reset);
        }


    }
}
