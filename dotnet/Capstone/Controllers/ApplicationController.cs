using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Authorization;
using Capstone.DAO;
using Capstone.Models;

namespace Capstone.Controllers
{
    [Route("/applications")]
    [ApiController]
    public class ApplicationController : ControllerBase
    {
        private readonly IApplicationDAO applicationDAO;

        public ApplicationController(IApplicationDAO _applicationDAO)
        {
            applicationDAO = _applicationDAO;
        }

        [HttpGet]
        [Authorize(Roles = "landlord")]
        public ActionResult<List<Application>> GetApplications()
        {
            int userId = Convert.ToInt32(User.FindFirst("sub").Value);
            List<Application> applications = applicationDAO.GetPendingApplicationsForLandlord(userId);
            return Ok(applications);
        }
    }
}
