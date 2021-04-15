using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Authorization;
using Capstone.DAO;
using Capstone.Models;

namespace Capstone.Controllers
{
    [Route("/payments")]
    [ApiController]
    public class PaymentController : ControllerBase
    {
        private readonly IPaymentDAO paymentDAO;

        public PaymentController(IPaymentDAO _paymentDAO)
        {
            paymentDAO = _paymentDAO;
        }

        [HttpGet]
        [Authorize]
        public ActionResult<List<Payment>> GetPaymentHistory()
        {
            int userId = Convert.ToInt32(User.FindFirst("sub").Value);
            List<Payment> payments = paymentDAO.GetPaymentHistoryByPayerId(userId);

            if (payments.Count > 0)
            {
                return Ok(payments);
            }
            else
            {
                return NotFound();
            }
        }

        [HttpGet("/payments/upcoming")]
        [Authorize]
        public ActionResult<List<PaymentSchedule>> GetFuturePayments()
        {
            int userId = Convert.ToInt32(User.FindFirst("sub").Value);
            List<PaymentSchedule> payments = paymentDAO.GetFuturePaymentsByPayerId(userId);

            if (payments.Count > 0)
            {
                return Ok(payments);
            }
            else
            {
                return NotFound();
            }
        }

        [HttpGet("/payments/{propertyId}")]
        [Authorize]
        public ActionResult<List<Payment>> GetPropertyPayments(int propertyId)
        {
            List<Payment> payments = paymentDAO.GetPaymentHistoryForProperty(propertyId);

            if (payments.Count > 0)
            {
                return Ok(payments);
            }
            else
            {
                return NotFound();
            }
        }

        [HttpPost("/createpayschedule")]
        [Authorize]
        public ActionResult<bool> GeneratePaymentSchedule(LeaseAgreement lease)
        {
            bool created = paymentDAO.CreatePaymentSchedule(lease);

            if (created)
            {
                return StatusCode(201);
            }
            else
            {
                return StatusCode(400);
            }
        }

        [HttpPost("/submitpayment")]
        [Authorize(Roles = "Renter")]
        public ActionResult<Payment> PostPayment(Payment payment)
        {
            int userId = Convert.ToInt32(User.FindFirst("sub").Value);
            Payment paymentPosted = paymentDAO.MakePayment(payment, userId);
            return Created($"", paymentPosted);
        }
    }
}
