using Capstone.Models;
using System.Collections.Generic;

namespace Capstone.DAO
{
    public interface IMaintenanceDAO
    {
        List<MaintenanceRequest> GetLandlordMaintenanceRequestsForProperty(int propertyId);
        List<MaintenanceRequest> GetWorkerMaintenanceRequestsForProperty(int propertyId);
        bool AssignMaintReqStatus(int requestId, int maintWorkerId);
        bool SubmitMaintReq(MaintenanceRequest maintReq, int userId);
        List<MaintenanceRequest> GetMaintReqsForWorker(int workerId);
    }
}