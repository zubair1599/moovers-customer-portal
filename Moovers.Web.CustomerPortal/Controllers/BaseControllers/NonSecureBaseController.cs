using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace MooversCRM.Controllers.BaseControllers
{
    public class NonSecureBaseController : BaseController
    {
        protected Guid  FranchiseID
        {
            get
            {
                //var repo = new Business.Models.aspnet_UserRepository();
                var repo = new Business.Models.FranchiseRepository();
               Guid FranchiseId = repo.GetSingleFranchise();
               return FranchiseId;
            }
        }
    }
}

