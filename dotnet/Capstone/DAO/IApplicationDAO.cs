using Capstone.Models;
using System.Collections.Generic;

namespace Capstone.DAO
{
    public interface IApplicationDAO
    {
        public List<Application> GetPendingApplicationsForLandlord(int landlordId);
        public List<Application> GetPendingApplicationsForApplicant(int applicantId);
        public Application CreateNewApplication(int userId, int propertyId, string applicantFirstName, string applicantLastName, string applicantPhone);
        public bool UpdateApplicationStatus(int applicationId, string approvalStatus);
    }
}
