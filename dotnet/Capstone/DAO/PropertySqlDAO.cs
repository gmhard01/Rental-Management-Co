using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Data.SqlClient;
using Capstone.Models;

namespace Capstone.DAO
{
    public class PropertySqlDAO
    {
        private readonly string connectionString;

        public PropertySqlDAO(string dbConnectionString)
        {
            connectionString = dbConnectionString;
        }

        public List<Property> GetAllAvailableProperties()
        {
            List<Property> propertyList = new List<Property>();

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    string sqlString = "SELECT property_id, title, address_id, rent_amount, number_beds, number_baths, landlord_id, picture, available, available_date, property_description FROM properties WHERE available = 1;";
                    SqlCommand cmd = new SqlCommand(sqlString, conn);
                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        Property p = new Property()
                        {
                            PropertyId = Convert.ToInt32(reader["property_id"]),
                            Title = Convert.ToString(reader["title"]),
                            AddressId = Convert.ToInt32(reader["address_id"]),
                            RentAmount = Convert.ToDecimal(reader["rent_amount"]),
                            NumberOfBeds = Convert.ToInt32(reader["number_beds"]),
                            NumberOfBaths = Convert.ToDecimal(reader["number_baths"]),
                            LandlordId = Convert.ToInt32(reader["landlord_id"]),
                            Picture = Convert.ToString(reader["picture"]),
                            Available = Convert.ToBoolean(reader["available"]),
                            AvailableDate = Convert.ToDateTime(reader["available_date"]),
                            PropertyDescription = Convert.ToString(reader["property_description"]),
                        };

                        propertyList.Add(p);
                    }                 
                }
            }
            catch (SqlException)
            {
                throw;
            }

            return propertyList;
        }

    }
}
