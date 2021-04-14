using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Capstone.Models
{
    public class MaintenanceRequest
    {
        public int RequestId { get; set; }
        public int PropertyId { get; set; }
        public int RequesterId { get; set; }
        public int MaintenanceWorkerId { get; set; }
        public string RequestStatus { get; set; }
        public string Details { get; set; }
        public string DateReceived { get; set; }
        public string RequesterFirstName { get; set; }
        public string RequesterLastName { get; set; }
        public string RequesterPhone { get; set; }

    }
}
