using Capstone.Models;
using System.Collections.Generic;

namespace Capstone.DAO
{
    public interface IPaymentDAO
    {
        List<Payment> GetPaymentHistoryByPayerId(int payerId);
        public List<PaymentSchedule> GetFuturePaymentsByPayerId(int payerId);
        public bool CreatePaymentSchedule(LeaseAgreement lease);
        Payment MakePayment(Payment payment, int userId);
    }
}