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

        public List<Property> GetAvailableProperties()
        {
            List<Property> propertyList = new List<Property>();

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    string sqlString = "SELECT property_id, title, properties.address_id, rent_amount, number_beds, number_baths, landlord_id, picture, available, available_date, property_description, square_footage, property_type, pets_allowed, street_number, unit_number, street_name, state_abbreviation, city, county, zip_code, phone, email FROM properties JOIN addresses ON properties.address_id = addresses.address_id JOIN users ON properties.landlord_id = users.user_id WHERE available = 1;";
                    SqlCommand cmd = new SqlCommand(sqlString, conn);
                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        Property p = GetPropertyFromReader(reader);
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

        public List<Property> GetAvailablePropertiesPage(int numberOfProperties, int pageIndex)
        {
            List<Property> propertyList = new List<Property>();

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    string sqlString = "SELECT property_id, title, properties.address_id, rent_amount, number_beds, number_baths, landlord_id, picture, available, available_date, property_description, square_footage, property_type, pets_allowed, street_number, unit_number, street_name, state_abbreviation, city, county, zip_code, phone, email " + 
                                       "FROM properties JOIN addresses ON properties.address_id = addresses.address_id " +
                                       "JOIN users ON properties.landlord_id = users.user_id " +
                                       "WHERE available = 1 " +
                                       "ORDER BY property_id ASC " +
                                       "OFFSET @PageSize *@PageIndex ROWS " +
                                       "FETCH NEXT @PageSize ROWS ONLY;";
                    SqlCommand cmd = new SqlCommand(sqlString, conn);
                    cmd.Parameters.AddWithValue("@PageSize", numberOfProperties);
                    cmd.Parameters.AddWithValue("@PageIndex", pageIndex);
                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        Property p = GetPropertyFromReader(reader);
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

        public Property GetPropertyByID(int id)
        {
            Property returnProperty = new Property();

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    string sqlString = "SELECT property_id, title, properties.address_id, rent_amount, number_beds, number_baths, landlord_id, picture, available, available_date, property_description, square_footage, property_type, pets_allowed, street_number, unit_number, street_name, state_abbreviation, city, county, zip_code, phone, email FROM properties JOIN addresses ON properties.address_id = addresses.address_id JOIN users ON properties.landlord_id = users.user_id WHERE property_id = @property_id;";
                    SqlCommand cmd = new SqlCommand(sqlString, conn);
                    cmd.Parameters.AddWithValue("@property_id", id);
                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        returnProperty = GetPropertyFromReader(reader);
                    }
                }
            }
            catch (SqlException)
            {
                throw;
            }

            return returnProperty;
        }

        private Property GetPropertyFromReader(SqlDataReader reader)
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
                AvailableDate = (reader["available_date"] == DBNull.Value) ? default(DateTime) : Convert.ToDateTime(reader["available_date"]),
                PropertyDescription = Convert.ToString(reader["property_description"]),
                SquareFeet = (reader["square_footage"] == DBNull.Value) ? -1 : Convert.ToInt32(reader["square_footage"]),
                PropertyType = Convert.ToString(reader["property_type"]),
                PetsAllowed = (reader["pets_allowed"] == DBNull.Value) ? false : Convert.ToBoolean(reader["pets_allowed"]),
                StreetNumber = Convert.ToInt32(reader["street_number"]),
                //unit number may be null in the DB, if so set to -1
                UnitNumber = (reader["unit_number"] == DBNull.Value) ? "-1" : Convert.ToString(reader["unit_number"]),
                StreetName = Convert.ToString(reader["street_name"]),
                State = Convert.ToString(reader["state_abbreviation"]),
                City = Convert.ToString(reader["city"]),
                County = Convert.ToString(reader["county"]),
                ZipCode = Convert.ToString(reader["zip_code"]),
                ContactPhone = Convert.ToString(reader["phone"]),
                ContactEmail = Convert.ToString(reader["email"])
            };

            return p;
        }

    }
}
