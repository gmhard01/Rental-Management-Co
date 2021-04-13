using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Capstone.Models
{
    public class PaymentSchedule
    {
        public int InstallmentNumber { get; set; }
        public int LeaseId { get; set; }
        public string DueDate { get; set; }
        public decimal AmountDue { get; set; }
    }
}
