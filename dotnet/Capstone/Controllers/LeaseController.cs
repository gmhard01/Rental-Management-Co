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
    [Route("/lease")]
    [ApiController]
    public class LeaseController : ControllerBase
    {
        private readonly ILeaseDAO leaseDAO;

        public LeaseController(ILeaseDAO _leaseDAO)
        {
            leaseDAO = _leaseDAO;
        }

        [HttpPost("/newlease")]
        [Authorize(Roles = "Landlord, Admin")]
        public ActionResult<LeaseAgreement> CreateLease(LeaseAgreement newLease)
        {
            LeaseAgreement leaseCreated = leaseDAO.CreateNewLease(newLease);
            return Created($"Lease Id #{leaseCreated.LeaseId} was successfully submitted.", leaseCreated);
        }
    }
}
