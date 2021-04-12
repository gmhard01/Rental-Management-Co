using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Data.SqlClient;
using Capstone.Models;

namespace Capstone.DAO
{
    public class LeaseSqlDAO : ILeaseDAO
    {
        private readonly string connectionString;

        public LeaseSqlDAO(string dbConnectionString)
        {
            connectionString = dbConnectionString;
        }

        public LeaseAgreement CreateNewLease(LeaseAgreement leaseToCreate)
        {
            LeaseAgreement returnLease = new LeaseAgreement();
            int leaseId;

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    string sqlString = "INSERT INTO lease_agreements (property_id, landlord_id, renter_id, monthly_rent, lease_start_date, lease_term) VALUES (@property_id, @landlord_id, @renter_id, @monthly_rent, @lease_start_date, @lease_term); SELECT SCOPE_IDENTITY()";
                    SqlCommand cmd = new SqlCommand(sqlString, conn);
                    cmd.Parameters.AddWithValue("@property_id", leaseToCreate.PropertyId);
                    cmd.Parameters.AddWithValue("@landlord_id", leaseToCreate.LandlordId);
                    cmd.Parameters.AddWithValue("@renter_id", leaseToCreate.RenterId);
                    cmd.Parameters.AddWithValue("@monthly_rent", leaseToCreate.MonthlyRent);
                    cmd.Parameters.AddWithValue("@lease_start_date", leaseToCreate.LeaseStartDate);
                    cmd.Parameters.AddWithValue("@lease_term", leaseToCreate.LeaseTerm);
                    leaseId = Convert.ToInt32(cmd.ExecuteScalar());

                    returnLease = GetLeaseById(leaseId);
                }
            }
            catch (SqlException)
            {
                throw;
            }

            return (returnLease);
        }

        private LeaseAgreement GetLeaseById(int leaseId)
        {
            LeaseAgreement returnLease = new LeaseAgreement();

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    string sqlString = "SELECT lease_id, property_id, landlord_id, renter_id, monthly_rent, lease_start_date, lease_term FROM lease_agreements WHERE lease_id = @leaseId;";
                    SqlCommand cmd = new SqlCommand(sqlString, conn);
                    cmd.Parameters.AddWithValue("@leaseId", leaseId);
                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        returnLease = GetLeaseFromReader(reader);
                    }
                }
            }
            catch (SqlException)
            {
                throw;
            }

            return returnLease;
        }

        private LeaseAgreement GetLeaseFromReader(SqlDataReader reader)
        {
            LeaseAgreement lease = new LeaseAgreement()
            {
                LeaseId = Convert.ToInt32(reader["lease_id"]),
                PropertyId = Convert.ToInt32(reader["property_id"]),
                LandlordId = Convert.ToInt32(reader["landlord_id"]),
                RenterId = Convert.ToInt32(reader["renter_id"]),
                MonthlyRent = Convert.ToDecimal(reader["monthly_rent"]),
                LeaseStartDate = Convert.ToString(reader["lease_start_date"]),
                LeaseTerm = Convert.ToInt32(reader["lease_term"])
            };

            return lease;
        }
    }
}
