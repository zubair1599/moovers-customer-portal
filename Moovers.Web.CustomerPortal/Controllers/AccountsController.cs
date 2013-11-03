using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using FluentValidation;
using Business.Utility;
using System.Web.Security;

namespace MooversCRM.Controllers
{

    public class AccountsController : BaseControllers.NonSecureBaseController
    {
        [HttpPost]
        public ActionResult Index(string accountId = null, string quoteId = null)
        {
            Guid? accountID = null;
            if (!string.IsNullOrEmpty(accountId))
            {
                var repo = new Business.Models.AccountRepository();

                var account = repo.Get(accountId);

                if (account != null)
                {
                    var quote = account.BillingQuotes.SingleOrDefault(i => i.Lookup == quoteId);
                    if (quoteId != null)
                    {
                        accountID = account.AccountID;
                        var modal = new Business.ViewModels.PersonAccountModel();
                        modal.Account = account.PersonAccount;
                        modal.Account.Account = modal.Account.Account;
                        // modal.user_name = modal.Account.Account_Customer_Credentials.FirstOrDefault().UserName;
                        modal.PrimaryEmail = account.Account_EmailAddress_Rel.FirstOrDefault() == null ? null : account.Account_EmailAddress_Rel.FirstOrDefault().EmailAddress;
                        modal.SecondaryEmail = account.Account_EmailAddress_Rel.FirstOrDefault(o => o.Type == 1) == null ? null : account.Account_EmailAddress_Rel.FirstOrDefault().EmailAddress;
                        modal.SecondaryPhone = account.Account_PhoneNumber_Rel.FirstOrDefault(o => o.Type == 1) == null ? null : account.Account_PhoneNumber_Rel.FirstOrDefault(o => o.Type == 1).PhoneNumber;
                        if (modal.SecondaryPhone != null)
                        {
                            modal.SecondaryPhone.Number = modal.SecondaryPhone.Number;
                        }
                        modal.PrimaryPhone = account.Account_PhoneNumber_Rel.FirstOrDefault() == null ? null : account.Account_PhoneNumber_Rel.FirstOrDefault().PhoneNumber;
                        modal.FaxPhone = account.Account_PhoneNumber_Rel.FirstOrDefault(o => o.Type == 2) == null ? null : account.Account_PhoneNumber_Rel.FirstOrDefault(o => o.Type == 2).PhoneNumber;
                        if (modal.FaxPhone != null)
                        {
                            modal.FaxPhone.Number = account.Account_PhoneNumber_Rel.FirstOrDefault(o => o.Type == 2) == null ? null : account.Account_PhoneNumber_Rel.FirstOrDefault(o => o.Type == 2).PhoneNumber.Number;
                        }

                        modal.BillingAddress = account.Account_Address_Rel.FirstOrDefault(o => o.Type == 0) == null ? null : account.Account_Address_Rel.FirstOrDefault(o => o.Type == 0).Address;
                        modal.MailingAddress = account.Account_Address_Rel.FirstOrDefault(o => o.Type == 1) == null ? null : account.Account_Address_Rel.FirstOrDefault(o => o.Type == 0).Address;
                       // modal.Account.AccountID = accountID.Value;
                        //if (modal.BillingAddress != null)
                        //{
                        //    modal.BillingAddress.City = account.Account_Address_Rel.FirstOrDefault(o => o.Type == 0) == null ? null : account.Account_Address_Rel.FirstOrDefault(o => o.Type == 0).Address.City;
                        //    modal.BillingAddress.Zip = account.Account_Address_Rel.FirstOrDefault(o => o.Type == 0) == null ? null : account.Account_Address_Rel.FirstOrDefault(o => o.Type == 0).Address.Zip;
                        //    modal.BillingAddress.State = account.Account_Address_Rel.FirstOrDefault(o => o.Type == 0) == null ? null : account.Account_Address_Rel.FirstOrDefault(o => o.Type == 0).Address.State;
                        //    modal.BillingAddress.Street1 = account.Account_Address_Rel.FirstOrDefault(o => o.Type == 0) == null ? null : account.Account_Address_Rel.FirstOrDefault(o => o.Type == 0).Address.Street1;
                        //    modal.BillingAddress.Street1 = account.Account_Address_Rel.FirstOrDefault(o => o.Type == 0) == null ? null : account.Account_Address_Rel.FirstOrDefault(o => o.Type == 0).Address.Street2;

                        //}
                        return View(modal);
                    }
                }
                else
                {
                    return RedirectToAction("Index", "Login");
                }


            }

            return View();
        }




        public ActionResult Get(Guid id)
        {
            var repo = new Business.Models.AccountRepository();
            var account = repo.Get(id);

            if (account == null)
            {
                return HttpNotFound();
            }

            return Json(account.ToJsonObject(), JsonRequestBehavior.AllowGet);
        }

        // POST: /Accounts/Person/Add
        [HttpPost]
        public ActionResult CreatePerson(Guid? accountid, FormCollection coll, Business.ViewModels.PersonAccountModel model, bool currentMailing = false)
        {


            #region Create User for asp_membership

            MembershipCreateStatus status;
            MembershipUser User = Membership.CreateUser(model.user_name, model.password, model.PrimaryEmail.Email, null, null, true, out status);

            if (status == MembershipCreateStatus.DuplicateEmail)
            {

                return Json(new Business.ViewModels.ErrorModel("Email", "E-Mail address is already in use"));
            }
            else if (status == MembershipCreateStatus.DuplicateUserName)
            {

                return Json(new Business.ViewModels.ErrorModel("Username", "Username is already in use"));
            }
            else if (status == MembershipCreateStatus.InvalidEmail)
            {
                return Json(new Business.ViewModels.ErrorModel("Email", "Invalid e-mail address"));

            }
            else if (status == MembershipCreateStatus.InvalidPassword)
            {

                return Json(new Business.ViewModels.ErrorModel("Password", "Please ensure your password has at least 1 uppercase letter, 1 lowercase letter, and 1 non-letter character."));
            }
            else if (status == MembershipCreateStatus.InvalidUserName)
            {
                return Json(new Business.ViewModels.ErrorModel("Username", "Invalid Username"));

            }

            if (status != MembershipCreateStatus.Success)
            {
                return View(model);
            }

            var aspnet_repo = new Business.Models.aspnet_UserRepository();
            var user = aspnet_repo.Get(model.user_name);

            var franchise_rel_repo = new Business.Models.Franchise_aspnet_UserRepository();
            var rel = new Business.Models.Franchise_aspnetUser
            {
                FranchiseID = FranchiseID,
                UserID = user.UserId
            };

            franchise_rel_repo.Add(rel);
            franchise_rel_repo.Save();

            var profile = new Business.Models.aspnet_Users_Profile()
            {
                FirstName = model.Account.FirstName,
                LastName = model.Account.LastName,
                Phone = model.PrimaryPhone.Number,
                Title = "Customer",
                UserType = (int)Business.Models.UserType.Customer
            };

            user.aspnet_Users_Profile.Add(profile);
            aspnet_repo.Save();
            #endregion

            var repo = new Business.Models.PersonAccountRepository();
            var account = (accountid.HasValue) ? repo.Get(accountid.Value) : new Business.Models.PersonAccount();
            var validator = new Business.Validators.AccountModelValidator<Business.Models.PersonAccount>();

            if (!accountid.HasValue)
            {
                repo.Add(account);
            }


            model.UpdateAddresses(account, coll, currentMailing);
            var validation = validator.Validate(model);
            if (!validation.IsValid)
            {
                return Json(new Business.ViewModels.ErrorModel(validation));
            }

            repo.UpdateFromForm(FranchiseID, account, model);
            repo.UpdateCustomerCredentials(model, account, user.UserId);
            repo.Save();
            FormsAuthentication.SetAuthCookie(model.user_name, false, "/");

            return RedirectToAction("Index" , "Home");
            //return Content(Extensions.SerializeToJson(account.ToJsonObject()), "text/json");
        }


    }
}
