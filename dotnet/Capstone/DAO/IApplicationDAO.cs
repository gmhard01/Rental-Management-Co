using Capstone.Models;
using System.Collections.Generic;

namespace Capstone.DAO
{
    public interface IApplicationDAO
    {
        List<Application> GetPendingApplicationsForProperty(int propertyId);
        List<Application> GetPendingApplicationsForApplicant(int applicantId);
        Application CreateNewApplication(int userId, int propertyId, string applicantFirstName, string applicantLastName, string applicantPhone);
        bool UpdateApplicationStatus(int applicationId, string approvalStatus);
    }
}
