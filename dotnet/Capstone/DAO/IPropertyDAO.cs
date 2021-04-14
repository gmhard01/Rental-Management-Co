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
        List<Property> GetPropertiesByLandlordID(int landlordId);
        bool SetPropertyToUnavailable(int propertyId);
        bool AddNewProperty(Property propertyToAdd, int landlordId);
        bool UpdateExistingProperty(Property propertyToUpdate);

    }
}