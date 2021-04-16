using Capstone.Models;
using System;
using System.Collections.Generic;

namespace Capstone.DAO
{
    public interface IPaymentDAO
    {
        List<Payment> GetPaymentHistoryByPayerId(int payerId);
        public List<PaymentSchedule> GetFuturePaymentsByPayerId(int payerId);
        public bool CreatePaymentSchedule(LeaseAgreement lease);
        Payment MakePayment(Payment payment, int userId);
        List<Payment> GetPaymentHistoryForProperty(int propertyId);
        Decimal GetBalanceDue(int leaseId);
    }
}