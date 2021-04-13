using Capstone.Models;
using System.Collections.Generic;

namespace Capstone.DAO
{
    public interface IPropertyDAO
    {
        List<Property> GetAvailableProperties();
        List<Property> GetAvailablePropertiesPage(int numberOfProperties, int pageIndex);
        Property GetPropertyByID(int id);
        Property GetPropertyByRenterID(int renterId);
        bool SetPropertyToUnavailable(int propertyId);
    }
}