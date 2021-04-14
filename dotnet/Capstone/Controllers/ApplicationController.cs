﻿using System;
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

        [HttpGet("/applications/{propertyId}")]
        [Authorize(Roles = "landlord, renter")]
        public ActionResult<List<Application>> GetApplications(int propertyId)
        {
            List<Application> applications = applicationDAO.GetPendingApplicationsForProperty(propertyId);
            return Ok(applications);
        }

        [HttpPost("/newapplication")]
        [Authorize(Roles = "renter")]
        public ActionResult<Application> CreateApplication(Application newApp)
        {            
            Application applicationCreated = applicationDAO.CreateNewApplication(newApp.ApplicantId, newApp.PropertyId, newApp.ApplicantFirstName, newApp.ApplicantLastName, newApp.ApplicantPhone);
            return Created($"Application Id #{applicationCreated.ApplicationId} was successfully submitted.", applicationCreated);
        }

        [HttpPut("/applications/updatestatus")]
        [Authorize(Roles = "landlord")]
        public ActionResult ApproveOrRejectApplication(Application appToUpdate)
        {
            bool appUpdatedSuccessfully = applicationDAO.UpdateApplicationStatus(appToUpdate.ApplicationId, appToUpdate.ApprovalStatus);
            
            if (appUpdatedSuccessfully)
            {
                return Ok();
            }
            else
            {
                return StatusCode(400);
            }
        }
    }
}
