using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Capstone.Models
{
    public class Property
    {
        public int PropertyId { get; set; }
        public string Title { get; set; }
        public int AddressId { get; set; }
        public decimal RentAmount { get; set; }
        public int NumberOfBeds { get; set; }
        public decimal NumberOfBaths { get; set; }
        public int LandlordId { get; set; }
        public string[] Picture { get; set; }
        public bool Available { get; set; }
        public DateTime AvailableDate { get; set; }
        public string PropertyDescription { get; set; }
        public int SquareFeet { get; set; }
        public string PropertyType { get; set; }
        public bool PetsAllowed { get; set; }
        public int StreetNumber { get; set; }
        public string UnitNumber { get; set; }
        public string StreetName { get; set; }
        public string State { get; set; }
        public string City { get; set; }
        public string County { get; set; }
        public string ZipCode { get; set; }
        public string ContactPhone { get; set; }
        public string ContactEmail { get; set; }
    }
}
