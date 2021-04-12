using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Data.SqlClient;
using Capstone.Models;

namespace Capstone.DAO
{
    public class PaymentSqlDAO : IPaymentDAO
    {
        private readonly string connectionString;

        public PaymentSqlDAO(string dbConnectionString)
        {
            connectionString = dbConnectionString;
        }

        public List<Payment> GetPaymentHistoryByPayerId(int payerId)
        {
            List<Payment> returnPayments = new List<Payment>();

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    string sqlString = "SELECT payment_id, payer_id, paid_date, lease_id, amount_paid FROM payments WHERE payer_id = @payerId; ";
                    SqlCommand cmd = new SqlCommand(sqlString, conn);
                    cmd.Parameters.AddWithValue("@payerId", payerId);
                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        returnPayments.Add(GetPaymentFromReader(reader));
                    }
                }
            }
            catch (SqlException)
            {
                throw;
            }

            return returnPayments;
        }

        private Payment GetPaymentFromReader(SqlDataReader reader)
        {
            Payment p = new Payment()
            {
                PaymentId = Convert.ToInt32(reader["payment_id"]),
                PayerId = Convert.ToInt32(reader["payer_id"]),
                PaidDate = Convert.ToString(reader["paid_date"]),
                LeaseId = Convert.ToInt32(reader["lease_id"]),
                AmountPaid = Convert.ToDecimal(reader["amount_paid"])
            };

            return p;
        }
    }
}
