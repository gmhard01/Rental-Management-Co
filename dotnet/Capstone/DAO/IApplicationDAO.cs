using Capstone.Models;
using System.Collections.Generic;

namespace Capstone.DAO
{
    public interface IApplicationDAO
    {
        List<Application> GetPendingApplicationsForLandlord(int landlordId);
    }
}
