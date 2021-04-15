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
    [Route("/maintenance")]
    [ApiController]
    public class MaintenanceController : ControllerBase
    {
        private readonly IMaintenanceDAO maintenanceDAO;

        public MaintenanceController(IMaintenanceDAO _maintenanceDAO)
        {
            maintenanceDAO = _maintenanceDAO;
        }

        [HttpGet("/maintenance/{propertyId}")]
        [Authorize(Roles = "Landlord, Maintenance")]
        public ActionResult<List<MaintenanceRequest>> GetMaintenanceRequests(int propertyId)
        {
            List<MaintenanceRequest> requests = maintenanceDAO.GetNewMaintenanceRequestsForProperty(propertyId);

            if(requests.Count > 0)
            {
                return Ok(requests);
            }
            else
            {
                return NotFound();
            }
        }

        [HttpPut("/maintenance/assign")]
        [Authorize(Roles = "Landlord")]
        public ActionResult AssignRequestToWorker(MaintenanceRequest requestToAssign)
        {
            bool assignedSuccessfully = maintenanceDAO.AssignMaintReqStatus(requestToAssign.RequestId, requestToAssign.MaintenanceWorkerId);

            if (assignedSuccessfully)
            {
                return Ok();
            }
            else
            {
                return StatusCode(400);
            }
        }

        [HttpPost("/submitmaintenancereq")]
        [Authorize(Roles = "Renter")]
        public ActionResult PostMaintReq(MaintenanceRequest maintReq)
        {
            int userId = Convert.ToInt32(User.FindFirst("sub").Value);
            bool submittedSuccessfully = maintenanceDAO.SubmitMaintReq(maintReq, userId);

            if (submittedSuccessfully)
            {
                return StatusCode(201);
            }
            else
            {
                return StatusCode(400);
            }
        }
    }
}
