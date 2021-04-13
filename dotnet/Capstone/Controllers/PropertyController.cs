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
    [Route("/properties")]
    [ApiController]
    public class PropertyController : ControllerBase
    {
        private readonly IPropertyDAO propertyDAO;

        public PropertyController(IPropertyDAO _propertyDAO)
        {
            propertyDAO = _propertyDAO;
        }

        [HttpGet]
        public ActionResult<List<Property>> GetProperties()
        {
            List<Property> properties = propertyDAO.GetAvailableProperties();

            if (properties.Count > 0)
            {
                return Ok(properties);
            }
            else
            {
                return NotFound();
            }
        }

        [HttpGet("/properties/page/{numberOfProperties}/{pageIndex}")]
        public ActionResult<List<Property>> GetPropertiesPage(int numberOfProperties, int pageIndex)
        {
            List<Property> properties = propertyDAO.GetAvailablePropertiesPage(numberOfProperties, pageIndex);

            if (properties.Count > 0)
            {
                return Ok(properties);
            }
            else
            {
                return NotFound();
            }
        }

        [HttpGet("/properties/{id}")]
        public ActionResult<Property> GetProperty(int id)
        {
            Property property = propertyDAO.GetPropertyByID(id);

            if (property.PropertyId != 0)
            {
                return Ok(property);
            }
            else
            {
                return NotFound();
            }
        }

        [HttpGet("/properties/renter")]
        [Authorize(Roles = "renter")]
        public ActionResult<Property> GetPropertyForRenter()
        {
            int userId = Convert.ToInt32(User.FindFirst("sub").Value);
            Property property = propertyDAO.GetPropertyByRenterID(userId);

            if (property.PropertyId != 0)
            {
                return Ok(property);
            }
            else
            {
                return NotFound();
            }
        }

        [HttpPut("/property/unavailable")]
        //[Authorize]
        public ActionResult<bool> MakePropertyUnavailable(Property propertyToUpdate)
        {
            bool updated = propertyDAO.SetPropertyToUnavailable(propertyToUpdate.PropertyId);

            if (updated)
            {
                return StatusCode(201);
            }
            else
            {
                return StatusCode(400);
            }
        }

        [HttpPost("/addproperty")]
        [Authorize(Roles = "landlord, admin")]
        public ActionResult<Property> CreateNewProperty(Property propertyToAdd)
        {
            int landlordId = Convert.ToInt32(User.FindFirst("sub").Value);
            bool newProperty = propertyDAO.AddNewProperty(propertyToAdd, landlordId);
            return Created($"Property was successfully submitted.", newProperty);
        }


        [HttpPut("/property-update")]
        [Authorize(Roles = "landlord, admin")]
        public ActionResult<Property> UpdateProperty(Property propertyDetailsToUpdate)
        {

            bool updated = propertyDAO.UpdateExistingProperty(propertyDetailsToUpdate);

            if (updated)
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
