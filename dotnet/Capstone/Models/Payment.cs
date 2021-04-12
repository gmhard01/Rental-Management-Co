using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Capstone.Models
{
    public class Payment
    {
        public int PaymentId { get; set; }
        public int PayerId { get; set; }
        public string PaidDate { get; set; }
        public int LeaseId { get; set; }
        public decimal AmountPaid { get; set; }
    }
}
