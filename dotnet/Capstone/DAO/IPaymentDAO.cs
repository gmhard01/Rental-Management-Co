using Capstone.Models;
using System.Collections.Generic;

namespace Capstone.DAO
{
    public interface IPaymentDAO
    {
        List<Payment> GetPaymentHistoryByPayerId(int payerId);
    }
}