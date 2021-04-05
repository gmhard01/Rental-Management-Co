using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Capstone.Models
{
    public class Address
    {
        public int AddressId { get; set; }
        public int StreetNumber { get; set; }
        public int UnitNumber { get; set; }
        public string StreetName { get; set; }
        public string State { get; set; }
        public string City { get; set; }
        public string County { get; set; }
        public string ZipCode { get; set; }
    }
}
