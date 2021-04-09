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

                    string sqlString = "SELECT application_id, applicant_id, applications.property_id, approval_status, applicant_first_name, applicant_last_name, applicant_phone FROM applications JOIN properties ON applications.property_id = properties.property_id WHERE landlord_id = @landlordId AND approval_status = 'Pending';";
                    SqlCommand cmd = new SqlCommand(sqlString, conn);
                    cmd.Parameters.AddWithValue("@landlordId", landlordId);
                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        Application a = GetApplicationFromReader(reader);
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

        public List<Application> GetPendingApplicationsForApplicant(int applicantId)
        {
            List<Application> returnApplications = new List<Application>();

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    string sqlString = "SELECT application_id, applicant_id, applications.property_id, approval_status, applicant_first_name, applicant_last_name, applicant_phone FROM applications JOIN properties ON applications.property_id = properties.property_id WHERE applicant_id = @applicantId AND approval_status = 'Pending';";
                    SqlCommand cmd = new SqlCommand(sqlString, conn);
                    cmd.Parameters.AddWithValue("@applicantId", applicantId);
                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        Application a = GetApplicationFromReader(reader);
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

        public Application CreateNewApplication(int applicantId, int propertyId, string applicantFirstName, string applicantLastName, string applicantPhone)
        {
            Application returnApplication = new Application();
            int applicationId;
            

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    string sqlString = "INSERT INTO applications (applicant_id, property_id, approval_status, applicant_first_name, applicant_last_name, applicant_phone) VALUES (@applicantId, @propertyId, 'Pending', @applicant_first_name, @applicant_last_name, @applicant_phone); SELECT SCOPE_IDENTITY()";
                    SqlCommand cmd = new SqlCommand(sqlString, conn);
                    cmd.Parameters.AddWithValue("@applicantId", applicantId);
                    cmd.Parameters.AddWithValue("@propertyId", propertyId);
                    cmd.Parameters.AddWithValue("@applicant_first_name", applicantFirstName);
                    cmd.Parameters.AddWithValue("@applicant_last_name", applicantLastName);
                    cmd.Parameters.AddWithValue("@applicant_phone", applicantPhone);
                    applicationId = Convert.ToInt32(cmd.ExecuteScalar());

                    returnApplication = GetApplicationById(applicationId);
                }
            }
            catch (SqlException)
            {
                throw;
            }

            return (returnApplication);
        }

        public bool UpdateApplicationStatus(int applicationId, string approvalStatus)
        {
            int rowsAffected;

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    string sqlString = "UPDATE applications SET approval_status = @approvalStatus WHERE application_id = @applicationId; ";
                    SqlCommand cmd = new SqlCommand(sqlString, conn);
                    cmd.Parameters.AddWithValue("@applicationId", applicationId);
                    cmd.Parameters.AddWithValue("@approvalStatus", approvalStatus);
                    rowsAffected = cmd.ExecuteNonQuery();   
                }
            }
            catch (SqlException)
            {
                throw;
            }
            return (rowsAffected > 0);
        }

        private Application GetApplicationById(int applicationId)
        {
            Application returnApp = new Application();

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    string sqlString = "SELECT application_id, applicant_id, property_id, approval_status, applicant_first_name, applicant_last_name, applicant_phone FROM applications WHERE application_id = @applicationId;";
                    SqlCommand cmd = new SqlCommand(sqlString, conn);
                    cmd.Parameters.AddWithValue("@applicationId", applicationId);
                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        returnApp = GetApplicationFromReader(reader);
                    }
                }
            }
            catch (SqlException)
            {
                throw;
            }

            return returnApp;
        }

        private Application GetApplicationFromReader(SqlDataReader reader)
        {
            Application a = new Application()
            {
                ApplicationId = Convert.ToInt32(reader["application_id"]),
                ApplicantId = Convert.ToInt32(reader["applicant_id"]),
                PropertyId = Convert.ToInt32(reader["property_id"]),
                ApprovalStatus = Convert.ToString(reader["approval_status"]),
                ApplicantFirstName = Convert.ToString(reader["applicant_first_name"]),
                ApplicantLastName = Convert.ToString(reader["applicant_last_name"]),
                ApplicantPhone = Convert.ToString(reader["applicant_phone"])
            };

            return a;
        }
    }
}
