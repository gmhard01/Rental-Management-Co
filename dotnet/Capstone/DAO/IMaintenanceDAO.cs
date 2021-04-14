using Capstone.Models;
using System.Collections.Generic;

namespace Capstone.DAO
{
    public interface IMaintenanceDAO
    {
        List<MaintenanceRequest> GetNewMaintenanceRequestsForProperty(int propertyId);
        bool AssignMaintReqStatus(int requestId, int maintWorkerId);
    }
}