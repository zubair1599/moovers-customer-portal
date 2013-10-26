using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;

namespace MooversCRM.Controllers.BaseControllers
{
#if RELEASE
    [RequireHttps]
#endif
    [Authorize]
    public abstract class SecureBaseController : BaseController
    {
        #region Permissions

        public bool IsCorporateUser
        {
            get
            {
                return Business.Roles.IsCorporateUser(Roles.GetRolesForUser());
            }
        }

        public bool IsFranchiseUser
        {
            get 
            {
                return !IsCorporateUser;
            }
        }

        private bool ShowStorage
        {
            get
            {
                return IsCorporateUser;
            }
        }

        private bool ShowLeads
        {
            get
            {
                return true;
            }
        }

        private bool ShowAccounts
        {
            get
            {
                // all users can see accounts to some extent, permissions are on a per-account basis
                return true;
            }
        }

        private bool ShowQuotes
        {
            get
            {
                // all users can see quotes to some extent, permissions are on a per-quote basis
                return true;
            }
        }

        private bool ShowSchedule
        {
            get
            {
                // all users can see quotes to some extent, permissions are on a per-quote basis
                return true;
            }
        }

        private bool ShowCases
        {
            get
            {
                return true;
            }
        }

        private bool ShowEmployees
        {
            get
            {
                var allowedRoles = new object[] {
                    Business.Roles.CorporateRoles.Administrator,
                    Business.Roles.CorporateRoles.CallCenterSupervisor,
                    Business.Roles.CorporateRoles.CallCenterAgent,
                    Business.Roles.CorporateRoles.HumanResources,
                    Business.Roles.CorporateRoles.Claims,
                    Business.Roles.FranchiseRoles.Dispatch,
                    Business.Roles.FranchiseRoles.Manager,
                    Business.Roles.FranchiseRoles.Sales
                };

                return Business.Roles.IsInRole(User.Identity.Name, allowedRoles);
            }
        }

        private bool ShowAdmin
        {
            get
            {
                return Business.Roles.IsInRole(User.Identity.Name, Business.Roles.CorporateRoles.Administrator);
            }
        }

        private bool ShowPosting
        {
            get
            {
                return true;
            }
        }


        #endregion

        /// <summary>
        /// For users with multiple franchises, this will return their current selected franchise
        /// 
        /// For users with a single franchise, this will return their franchise.
        /// </summary>
        protected Guid SessionFranchiseID
        {
            get
            {
                if (AspUser.HasMultipleFranchises())
                {
                    if (Session["franchiseid"] == null)
                    {
                        // if a user can access multiple franchises, we default to Kansas City
                        Session["franchiseid"] = new Business.Models.FranchiseRepository().GetStorage().FranchiseID;
                    }

                    return (Guid)Session["franchiseid"];
                }
            
                return AspUser.GetSingleFranchise().FranchiseID;
            }
            set
            {
                Session["franchiseid"] = value;
            }
        }

        protected Guid WebQuoteUserID
        {
            get
            {
                return (Guid)Membership.GetUser(Business.Utility.General.WebQuoteUser).ProviderUserKey;
            }
        }

        protected bool IsAdministrator
        {
            get
            {
                return Business.Roles.IsInRole(User.Identity.Name, Business.Roles.CorporateRoles.Administrator);
            }
        }

        protected Guid AspUserID
        {
            get
            {
                return (Guid)Membership.GetUser(User.Identity.Name).ProviderUserKey;
            }
        }

        protected Business.Models.aspnet_User AspUser
        {
            get
            {
                var repo = new Business.Models.aspnet_UserRepository();
                return repo.Get(AspUserID);
            }
        }

        protected override void OnActionExecuted(ActionExecutedContext filterContext)
        {
            if (!this.AspUser.HasMultipleFranchises())
            {
                this.SessionFranchiseID = this.AspUser.GetSingleFranchise().FranchiseID;
            }

            ViewBag.IsDevelopment = this.IsDevelopment;
            ViewBag.IsDevelopmentDB = this.IsDevelopmentDB;

            ViewBag.ParentMenu = this.ControllerContext.RouteData.Values["Controller"].ToString().ToLower();
            ViewBag.WebQuoteUserID = this.WebQuoteUserID;
            ViewBag.ShowStorage = this.ShowStorage;
            ViewBag.SubMenu = this.ControllerContext.RouteData.Values["Action"];
            ViewBag.ShowAccounts = this.ShowAccounts;
            ViewBag.ShowQuotes = this.ShowQuotes;
            ViewBag.ShowSchedule = this.ShowSchedule;
            ViewBag.ShowCases = this.ShowCases;
            ViewBag.ShowEmployees = this.ShowEmployees;
            ViewBag.ShowAdmin = this.ShowAdmin;
            ViewBag.ShowLeads = this.ShowLeads;
            ViewBag.ShowPosting = this.ShowPosting;
            ViewBag.MaxTruckWeight = Business.Models.Quote.MaxTruckWeight;
            ViewBag.MaxTruckCubicFeet = Business.Models.Quote.MaxTruckCubicFeet;

            ViewBag.IsAdministrator = this.IsAdministrator;
            ViewBag.MaxPriceDiscount = Business.ViewModels.QuotePricingModel.MaxPriceDiscount;

            ViewBag.HasMultipleFranchises = this.AspUser.HasMultipleFranchises();
            ViewBag.SingleFranchise = (this.AspUser.HasMultipleFranchises()) ? default(Business.Models.Franchise) : this.AspUser.GetSingleFranchise();

            var franchiseRepo = new Business.Models.FranchiseRepository();
            ViewBag.SessionFranchiseID = this.SessionFranchiseID;
            ViewBag.SessionFranchise = franchiseRepo.Get(this.SessionFranchiseID);
            ViewBag.AllFranchises = franchiseRepo.GetAll();

            ViewBag.DestinationMultiplier = Business.ViewModels.QuotePricingModel.DestinationMultiplier;
            ViewBag.MaxHourlySourceTime = Business.ViewModels.QuotePricingModel.MaxHourlySourceTime;
            ViewBag.MaxHourlyTravelTime = Business.ViewModels.QuotePricingModel.MaxHourlyTravelTime;
            
            ViewBag.AbsoluteUrl = this.AbsoluteUrl;
            ViewBag.UserID = this.AspUserID;

            if (this.IsDevelopment)
            {
                ViewBag.JavascriptFiles = GetJavascriptFiles();
                ViewBag.ScreenCssFiles = GetScreenCssFiles();
                ViewBag.PrintCssFiles = GetPrintCssFiles();
            }

            base.OnActionExecuted(filterContext);
        }
    }
}