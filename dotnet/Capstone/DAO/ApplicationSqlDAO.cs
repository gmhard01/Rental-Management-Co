using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Data.SqlClient;
using Capstone.Models;

namespace Capstone.DAO
{
    public class ApplicationSqlDAO : IApplicationDAO
    {
        private readonly string connectionString;

        public ApplicationSqlDAO(string dbConnectionString)
        {
            connectionString = dbConnectionString;
        }

        public List<Application> GetPendingApplicationsForLandlord(int landlordId)
        {
            List<Application> returnApplications = new List<Application>();

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    string sqlString = "SELECT application_id, applicant_id, applications.property_id, approval_status, applicant_name, applicant_phone FROM applications JOIN properties ON applications.property_id = properties.property_id WHERE landlord_id = @landlordId AND approval_status = 0;";
                    SqlCommand cmd = new SqlCommand(sqlString, conn);
                    cmd.Parameters.AddWithValue("@landlordId", landlordId);
                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        Application a = new Application()
                        {
                            ApplicationId = Convert.ToInt32(reader["application_id"]),
                            ApplicantId = Convert.ToInt32(reader["applicant_id"]),
                            PropertyId = Convert.ToInt32(reader["property_id"]),
                            ApprovalStatus = Convert.ToInt32(reader["approval_status"]),
                            ApplicantName = Convert.ToString(reader["applicant_name"]),
                            ApplicantPhone = Convert.ToString(reader["applicant_phone"])
                        };

                        returnApplications.Add(a);
                    }
                }
            }
            catch (SqlException)
            {
                throw;
            }

            return returnApplications;
        }
    }
}
