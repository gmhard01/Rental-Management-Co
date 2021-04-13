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

                    string sqlString = "SELECT payment_id, payer_id, paid_date, lease_id, amount_paid FROM payments WHERE payer_id = @payerId;";
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

        public List<PaymentSchedule> GetFuturePaymentsByPayerId(int payerId)
        {
            List<PaymentSchedule> returnPayments = new List<PaymentSchedule>();

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    string sqlString = "SELECT installment_number, payment_schedule.lease_id, due_date, amount_due FROM payment_schedule JOIN lease_agreements ON payment_schedule.lease_id = lease_agreements.lease_id WHERE renter_id = @payerId AND due_date >= GETDATE(); ";
                    SqlCommand cmd = new SqlCommand(sqlString, conn);
                    cmd.Parameters.AddWithValue("@payerId", payerId);
                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        returnPayments.Add(GetPaymentScheduleFromReader(reader));
                    }
                }
            }
            catch (SqlException)
            {
                throw;
            }

            return returnPayments;
        }

        public bool CreatePaymentSchedule(LeaseAgreement lease)
        {
            bool createdSuccessfully = false;
            DateTime startDate = Convert.ToDateTime(lease.LeaseStartDate);

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    for (int i = 1; i <= lease.LeaseTerm; i++)
                    {
                        string sqlString = "INSERT INTO payment_schedule (installment_number, lease_id, due_date, amount_due) VALUES (@installment_number, @lease_id, @due_date, @amount_due);";
                        SqlCommand cmd = new SqlCommand(sqlString, conn);
                        cmd.Parameters.AddWithValue("@installment_number", i);
                        cmd.Parameters.AddWithValue("@lease_id", lease.LeaseId);
                        cmd.Parameters.AddWithValue("@due_date", startDate);
                        cmd.Parameters.AddWithValue("@amount_due", lease.MonthlyRent);
                        cmd.ExecuteNonQuery();

                        startDate = startDate.AddMonths(1);
                    }

                    createdSuccessfully = true;
                }
            }
            catch (SqlException)
            {
                throw;
            }

            return createdSuccessfully;
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

        private PaymentSchedule GetPaymentScheduleFromReader(SqlDataReader reader)
        {
            PaymentSchedule p = new PaymentSchedule()
            {
                InstallmentNumber = Convert.ToInt32(reader["installment_number"]),
                LeaseId = Convert.ToInt32(reader["lease_id"]),
                DueDate = Convert.ToString(reader["due_date"]),
                AmountDue = Convert.ToDecimal(reader["amount_due"])
            };

            return p;
        }
    }
}
