﻿using Capstone.Models;
using System.Collections.Generic;

namespace Capstone.DAO
{
    public interface IPropertyDAO
    {
        List<Property> GetAvailableProperties();
        List<Property> GetAvailablePropertiesPage(int numberOfProperties, int pageIndex);
        Property GetPropertyByID(int id);
    }
}