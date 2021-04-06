using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Data.SqlClient;
using Capstone.Models;

namespace Capstone.DAO
{
    public class PropertySqlDAO : IPropertyDAO
    {
        private readonly string connectionString;

        public PropertySqlDAO(string dbConnectionString)
        {
            connectionString = dbConnectionString;
        }

        public List<Property> GetAllProperties()
        {
            List<Property> propertyList = new List<Property>();

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    string sqlString = "SELECT property_id, title, properties.address_id, rent_amount, number_beds, number_baths, landlord_id, picture, available, available_date, property_description, street_number, unit_number, street_name, state_abbreviation, city, county, zip_code FROM properties JOIN addresses ON properties.address_id = addresses.address_id;";
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
                            //available date may be null in the DB, if it is then set to default datetime (0001-01-01)
                            AvailableDate =(reader["available_date"] == DBNull.Value) ? default(DateTime) : Convert.ToDateTime(reader["available_date"]),
                            PropertyDescription = Convert.ToString(reader["property_description"]),
                            StreetNumber = Convert.ToInt32(reader["street_number"]),
                            //unit number may be null in the DB, if so set to -1
                            UnitNumber = (reader["unit_number"] == DBNull.Value) ? -1 : Convert.ToInt32(reader["unit_number"]),
                            StreetName = Convert.ToString(reader["street_name"]),
                            State = Convert.ToString(reader["state_abbreviation"]),
                            City = Convert.ToString(reader["city"]),
                            County = Convert.ToString(reader["county"]),
                            ZipCode = Convert.ToString(reader["zip_code"])
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
