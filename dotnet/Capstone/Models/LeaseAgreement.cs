using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Capstone.Models
{
    public class LeaseAgreement
    {
        public int LeaseId { get; set; }
        public int PropertyId { get; set; }
        public int LandlordId { get; set; }
        public int RenterId { get; set; }
        public decimal MonthlyRent { get; set; }
        public string LeaseStartDate { get; set; }
        public int LeaseTerm { get; set; }
    }
}
