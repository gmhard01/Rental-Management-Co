using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Capstone.Models
{
    public class Application
    {
        public int ApplicationId { get; set; }
        public int ApplicantId { get; set; }
        public int PropertyId { get; set; }
        public string ApprovalStatus { get; set; }
        public string ApplicantFirstName { get; set; }
        public string ApplicantLastName { get; set; }
        public string ApplicantPhone { get; set; }
    }
}
