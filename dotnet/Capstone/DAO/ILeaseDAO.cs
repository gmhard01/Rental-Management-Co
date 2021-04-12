using Capstone.Models;

namespace Capstone.DAO
{
    public interface ILeaseDAO
    {
        LeaseAgreement CreateNewLease(LeaseAgreement leaseToCreate);
    }
}