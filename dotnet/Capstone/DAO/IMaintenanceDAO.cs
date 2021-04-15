using Capstone.Models;
using System.Collections.Generic;

namespace Capstone.DAO
{
    public interface IMaintenanceDAO
    {
        List<MaintenanceRequest> GetNewMaintenanceRequestsForProperty(int propertyId);
        bool AssignMaintReqStatus(int requestId, int maintWorkerId);
        bool SubmitMaintReq(MaintenanceRequest maintReq, int userId);
        List<MaintenanceRequest> GetMaintReqsForWorker(int workerId);
    }
}