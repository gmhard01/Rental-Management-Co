using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Data.SqlClient;
using Capstone.Models;

namespace Capstone.DAO
{
    public class MaintenanceSqlDAO : IMaintenanceDAO
    {
        private readonly string connectionString;

        public MaintenanceSqlDAO(string dbConnectionString)
        {
            connectionString = dbConnectionString;
        }

        public List<MaintenanceRequest> GetNewMaintenanceRequestsForProperty(int propertyId)
        {
            List<MaintenanceRequest> returnRequests = new List<MaintenanceRequest>();

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    string sqlString = "SELECT request_id, property_id, requester_id, maintenance_worker_id, request_status, details, date_received, date_completed, first_name, last_name, phone FROM maintenance_requests JOIN users ON maintenance_requests.requester_id = users.user_id WHERE property_id = @propertyId AND request_status = 'New';";
                    SqlCommand cmd = new SqlCommand(sqlString, conn);
                    cmd.Parameters.AddWithValue("@propertyId", propertyId);
                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        MaintenanceRequest mr = GetMaintRequestFromReader(reader);
                        returnRequests.Add(mr);
                    }
                }
            }
            catch (SqlException)
            {
                throw;
            }

            return returnRequests;
        }

        public bool AssignMaintReqStatus(int requestId, int maintWorkerId)
        {
            int rowsAffected;

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    string sqlString = "UPDATE maintenance_requests SET maintenance_worker_id = @maintWorkerId, request_status = 'In Progress' WHERE request_id = @requestId;";
                    SqlCommand cmd = new SqlCommand(sqlString, conn);
                    cmd.Parameters.AddWithValue("@requestId", requestId);
                    cmd.Parameters.AddWithValue("@maintWorkerId", maintWorkerId);
                    rowsAffected = cmd.ExecuteNonQuery();
                }
            }
            catch (SqlException)
            {
                throw;
            }
            return (rowsAffected > 0);
        }

        public bool SubmitMaintReq(MaintenanceRequest maintReq, int userId)
        {
            bool submittedSuccessfuly = false;
            int rowsAffected;

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    string sqlString = "INSERT INTO maintenance_requests (property_id, requester_id, request_status, details, date_received) VALUES (@propertyId, @userId, 'New', @details, GETDATE());";
                    SqlCommand cmd = new SqlCommand(sqlString, conn);
                    cmd.Parameters.AddWithValue("@userId", userId);
                    cmd.Parameters.AddWithValue("@propertyId", maintReq.PropertyId);
                    cmd.Parameters.AddWithValue("@details", maintReq.Details);
                    rowsAffected = Convert.ToInt32(cmd.ExecuteNonQuery());

                    if (rowsAffected > 0)
                    {
                        submittedSuccessfuly = true;
                    }
                }
            }
            catch (SqlException)
            {
                throw;
            }

            return submittedSuccessfuly;
        }

        private MaintenanceRequest GetMaintReqById(int reqId)
        {
            MaintenanceRequest returnReq = new MaintenanceRequest();

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    string sqlString = "SELECT request_id, property_id, requester_id, maintenance_worker_id, request_status, details, date_received, date_completed FROM maintenance_requests WHERE request_id = @request_id;";
                    SqlCommand cmd = new SqlCommand(sqlString, conn);
                    cmd.Parameters.AddWithValue("@request_id", reqId);
                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        returnReq = GetMaintRequestFromReader(reader);
                    }
                }
            }
            catch (SqlException)
            {
                throw;
            }

            return returnReq;
        }

        private MaintenanceRequest GetMaintRequestFromReader(SqlDataReader reader)
        {
            MaintenanceRequest mr = new MaintenanceRequest()
            {
                RequestId = Convert.ToInt32(reader["request_id"]),
                PropertyId = Convert.ToInt32(reader["property_id"]),
                RequesterId = Convert.ToInt32(reader["requester_id"]),
                MaintenanceWorkerId = (reader["maintenance_worker_id"] == DBNull.Value) ? -1 : Convert.ToInt32(reader["maintenance_worker_id"]),
                RequestStatus = Convert.ToString(reader["request_status"]),
                Details = Convert.ToString(reader["details"]),
                DateReceived = Convert.ToString(reader["date_received"]),
                RequesterFirstName = Convert.ToString(reader["first_name"]),
                RequesterLastName = Convert.ToString(reader["last_name"]),
                RequesterPhone = Convert.ToString(reader["phone"])
            };

            return mr;
        }
    }
}
