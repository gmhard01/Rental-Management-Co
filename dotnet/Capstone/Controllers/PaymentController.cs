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
        public ActionResult<List<Property>> GetPaymentHistory()
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
    }
}
