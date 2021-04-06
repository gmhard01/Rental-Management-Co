using Capstone.Models;
using System.Collections.Generic;

namespace Capstone.DAO
{
    public interface IPropertyDAO
    {
        List<Property> GetAllProperties();
    }
}