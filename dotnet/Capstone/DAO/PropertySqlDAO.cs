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

                    string sqlString = "SELECT p.property_id, p.title, p.address_id, p.rent_amount, p.number_beds, p.number_baths, pp.primary_photo, pp.photo_url1, pp.photo_description1, pp.photo_url2, pp.photo_description2, pp.photo_url3, pp.photo_description3, pp.photo_url4, pp.photo_description4, p.landlord_id, p.available, p.available_date, p.property_description, p.square_footage, p.property_type, p.pets_allowed, a.street_number, a.unit_number, a.street_name, a.state_abbreviation, a.city, a.county, a.zip_code, u.phone, u.email " +
                        "FROM properties p " +
                        "JOIN addresses a ON p.address_id = a.address_id " +
                        "JOIN users u ON p.landlord_id = u.user_id " +
                        "LEFT JOIN property_photos pp ON p.property_id = pp.property_id WHERE available = 1;";
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

                    string sqlString = "SELECT properties.property_id, title, properties.address_id, rent_amount, number_beds, number_baths, landlord_id, pp.primary_photo, pp.photo_url1, pp.photo_description1, pp.photo_url2, pp.photo_description2, pp.photo_url3, pp.photo_description3, pp.photo_url4, pp.photo_description4, available, available_date, property_description, square_footage, property_type, pets_allowed, street_number, unit_number, street_name, state_abbreviation, city, county, zip_code, phone, email " + 
                                       "FROM properties " +
                                       "JOIN addresses ON properties.address_id = addresses.address_id " +
                                       "JOIN users ON properties.landlord_id = users.user_id " +
                                       "LEFT JOIN property_photos pp ON properties.property_id = pp.property_id " +
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

                    string sqlString = "SELECT properties.property_id, title, properties.address_id, rent_amount, number_beds, number_baths, landlord_id, pp.primary_photo, pp.photo_url1, pp.photo_description1, pp.photo_url2, pp.photo_description2, pp.photo_url3, pp.photo_description3, pp.photo_url4, pp.photo_description4, available, available_date, property_description, square_footage, property_type, pets_allowed, street_number, unit_number, street_name, state_abbreviation, city, county, zip_code, phone, email FROM properties JOIN addresses ON properties.address_id = addresses.address_id JOIN users ON properties.landlord_id = users.user_id LEFT JOIN property_photos pp ON properties.property_id = pp.property_id WHERE properties.property_id = @property_id;";
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

        public Property GetPropertyByRenterID(int renterId)
        {
            Property returnProperty = new Property();

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    string sqlString = "SELECT properties.property_id, title, properties.address_id, rent_amount, number_beds, number_baths, properties.landlord_id, pp.primary_photo, pp.photo_url1, pp.photo_description1, pp.photo_url2, pp.photo_description2, pp.photo_url3, pp.photo_description3, pp.photo_url4, pp.photo_description4, available, available_date, property_description, square_footage, property_type, pets_allowed, street_number, unit_number, street_name, state_abbreviation, city, county, zip_code, users.phone, users.email " + 
                                       "FROM properties " +
                                       "JOIN addresses ON properties.address_id = addresses.address_id " +
                                       "JOIN users ON properties.landlord_id = users.user_id " +
                                       "JOIN lease_agreements ON properties.property_id = lease_agreements.property_id " +
                                       "JOIN users u ON lease_agreements.renter_id = u.user_id " +
                                       "LEFT JOIN property_photos pp ON properties.property_id = pp.property_id " +
                                       "WHERE renter_id = @renterId;";
                    SqlCommand cmd = new SqlCommand(sqlString, conn);
                    cmd.Parameters.AddWithValue("@renterId", renterId);
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

        public List<Property> GetPropertiesByLandlordID(int landlordId)
        {
            List<Property> returnProperties = new List<Property>();

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    string sqlString = "SELECT properties.property_id, title, properties.address_id, rent_amount, number_beds, number_baths, properties.landlord_id, pp.primary_photo, pp.photo_url1, pp.photo_description1, pp.photo_url2, pp.photo_description2, pp.photo_url3, pp.photo_description3, pp.photo_url4, pp.photo_description4, available, available_date, property_description, square_footage, property_type, pets_allowed, street_number, unit_number, street_name, state_abbreviation, city, county, zip_code, users.phone, users.email " +
                                       "FROM properties " +
                                       "JOIN addresses ON properties.address_id = addresses.address_id " +
                                       "JOIN users ON properties.landlord_id = users.user_id " +
                                       "LEFT JOIN property_photos pp ON properties.property_id = pp.property_id " +
                                       "WHERE properties.landlord_id = @landlordId;";
                    SqlCommand cmd = new SqlCommand(sqlString, conn);
                    cmd.Parameters.AddWithValue("@landlordId", landlordId);
                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        Property p = GetPropertyFromReader(reader);
                        returnProperties.Add(p);
                    }
                }
            }
            catch (SqlException)
            {
                throw;
            }

            return returnProperties;
        }

        public bool SetPropertyToUnavailable(int propertyId)
        {
            int rowsAffected;

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    string sqlString = "UPDATE properties SET available = 0 WHERE property_id = @property_id;";
                    SqlCommand cmd = new SqlCommand(sqlString, conn);
                    cmd.Parameters.AddWithValue("@property_id", propertyId);
                    rowsAffected = cmd.ExecuteNonQuery();
                }
            }
            catch (SqlException)
            {
                throw;
            }
            return (rowsAffected > 0);
        }

        public bool AddNewProperty(Property propertyToAdd, int landlordId)
        {
            int addressId;
            int propertyId;
            int rowsAffected;
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    string sqlStringAddress = "INSERT INTO addresses (street_number, unit_number, street_name, state_abbreviation, city, county, zip_code) " +
                                              "VALUES (@street_number, @unit_number, @street_name, @state_abbreviation, @city, @county, @zip_code); " +
                                              "SELECT SCOPE_IDENTITY()";
                    
                    using (SqlCommand cmd = new SqlCommand(sqlStringAddress, conn))
                    {
                        cmd.Parameters.AddWithValue("@street_number", propertyToAdd.StreetNumber);
                        cmd.Parameters.AddWithValue("@unit_number", propertyToAdd.UnitNumber);
                        cmd.Parameters.AddWithValue("@street_name", propertyToAdd.StreetName);
                        cmd.Parameters.AddWithValue("@state_abbreviation", propertyToAdd.State);
                        cmd.Parameters.AddWithValue("@city", propertyToAdd.City);
                        cmd.Parameters.AddWithValue("@county", propertyToAdd.County);
                        cmd.Parameters.AddWithValue("@zip_code", propertyToAdd.ZipCode);
                        addressId = Convert.ToInt32(cmd.ExecuteScalar());
                    }
                    string sqlStringProperty = "INSERT INTO properties (title, address_id, rent_amount, number_beds, number_baths, landlord_id, available, " +
                                               "available_date, property_description, square_footage, property_type, pets_allowed) " +
                                               "VALUES (@title, @address_id, @rent_amount, @number_beds, @number_baths, @landlord_id, @available, " +
                                               "@available_date, @property_description, @square_footage, @property_type, @pets_allowed); " +
                                               "SELECT SCOPE_IDENTITY()";

                    using (SqlCommand command = new SqlCommand(sqlStringProperty, conn))
                    {
                        command.Parameters.AddWithValue("@title", propertyToAdd.Title);
                        command.Parameters.AddWithValue("@address_id", addressId);
                        command.Parameters.AddWithValue("@rent_amount", propertyToAdd.RentAmount);
                        command.Parameters.AddWithValue("@number_beds", propertyToAdd.NumberOfBeds);
                        command.Parameters.AddWithValue("@number_baths", propertyToAdd.NumberOfBaths);
                        command.Parameters.AddWithValue("@landlord_id", landlordId);
                        //command.Parameters.AddWithValue("@picture", propertyToAdd.Picture);
                        command.Parameters.AddWithValue("@available", propertyToAdd.Available);
                        command.Parameters.AddWithValue("@available_date", propertyToAdd.AvailableDate);
                        command.Parameters.AddWithValue("@property_description", propertyToAdd.PropertyDescription);
                        command.Parameters.AddWithValue("@square_footage", propertyToAdd.SquareFeet);
                        command.Parameters.AddWithValue("@property_type", propertyToAdd.PropertyType);
                        command.Parameters.AddWithValue("@pets_allowed", propertyToAdd.PetsAllowed);
                        propertyId = Convert.ToInt32(command.ExecuteScalar());
                    }

                    string sqlStringPropertyPhotos = "INSERT INTO property_photos (property_id, primary_photo, photo_url1, photo_description1, photo_url2, " +
                                                     "photo_description2, photo_url3, photo_description3, photo_url4, photo_description4) " +
                                                     "VALUES (@property_id, @primary_photo, @photo_url1, @photo_description1, @photo_url2, @photo_description2, " +
                                                     "@photo_url3, @photo_description3, @photo_url4, @photo_description4)";

                    using (SqlCommand comm = new SqlCommand(sqlStringPropertyPhotos, conn))
                    {
                        comm.Parameters.AddWithValue("@property_id", propertyId);
                        comm.Parameters.AddWithValue("@primary_photo", propertyToAdd.Picture[0]);
                        comm.Parameters.AddWithValue("@photo_url1", propertyToAdd.Picture[1]);
                        comm.Parameters.AddWithValue("@photo_description1", propertyToAdd.Picture[2]);
                        comm.Parameters.AddWithValue("@photo_url2", propertyToAdd.Picture[3]);
                        comm.Parameters.AddWithValue("@photo_description2", propertyToAdd.Picture[4]);
                        comm.Parameters.AddWithValue("@photo_url3", propertyToAdd.Picture[5]);
                        comm.Parameters.AddWithValue("@photo_description3", propertyToAdd.Picture[6]);
                        comm.Parameters.AddWithValue("@photo_url4", propertyToAdd.Picture[7]);
                        comm.Parameters.AddWithValue("@photo_description4", propertyToAdd.Picture[8]);
                        rowsAffected = comm.ExecuteNonQuery();
                    }
                }
            }
            catch (SqlException)
            {
                throw;
            }
            return (rowsAffected > 0);
        }

        public bool UpdateExistingProperty(Property propertyToUpdate)
        {
            int rowsAffectedAddress;
            int rowsAffectedProperty;
            int rowsAffectedPropertyPhotos;
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    string sqlStringAddress = "UPDATE addresses SET street_number = @street_number, unit_number = @unit_number, street_name = @street_name, " +
                                              "state_abbreviation = @state_abbreviation, city = @city, county = @county, zip_code = @zip_code " +
                                              "WHERE address_id = @address_id;";

                    using (SqlCommand cmd = new SqlCommand(sqlStringAddress, conn))
                    {
                        cmd.Parameters.AddWithValue("@street_number", propertyToUpdate.StreetNumber);
                        cmd.Parameters.AddWithValue("@unit_number", propertyToUpdate.UnitNumber);
                        cmd.Parameters.AddWithValue("@street_name", propertyToUpdate.StreetName);
                        cmd.Parameters.AddWithValue("@state_abbreviation", propertyToUpdate.State);
                        cmd.Parameters.AddWithValue("@city", propertyToUpdate.City);
                        cmd.Parameters.AddWithValue("@county", propertyToUpdate.County);
                        cmd.Parameters.AddWithValue("@zip_code", propertyToUpdate.ZipCode);
                        cmd.Parameters.AddWithValue("@address_id", propertyToUpdate.AddressId);
                        rowsAffectedAddress = cmd.ExecuteNonQuery();
                    }
                    string sqlStringProperty = "UPDATE properties SET title =  @title, rent_amount = @rent_amount, number_beds = @number_beds, " +
                                               "number_baths = @number_baths, available = @available, " +
                                               "available_date = @available_date, property_description = @property_description, square_footage = @square_footage, " +
                                               "property_type = @property_type, pets_allowed = @pets_allowed " +
                                               "WHERE property_id = @property_id;";

                    using (SqlCommand command = new SqlCommand(sqlStringProperty, conn))
                    {
                        command.Parameters.AddWithValue("@title", propertyToUpdate.Title);
                        command.Parameters.AddWithValue("@rent_amount", propertyToUpdate.RentAmount);
                        command.Parameters.AddWithValue("@number_beds", propertyToUpdate.NumberOfBeds);
                        command.Parameters.AddWithValue("@number_baths", propertyToUpdate.NumberOfBaths);
                        //command.Parameters.AddWithValue("@landlord_id", propertyToUpdate.LandlordId);
                        command.Parameters.AddWithValue("@available", propertyToUpdate.Available);
                        command.Parameters.AddWithValue("@available_date", propertyToUpdate.AvailableDate);
                        command.Parameters.AddWithValue("@property_description", propertyToUpdate.PropertyDescription);
                        command.Parameters.AddWithValue("@square_footage", propertyToUpdate.SquareFeet);
                        command.Parameters.AddWithValue("@property_type", propertyToUpdate.PropertyType);
                        command.Parameters.AddWithValue("@pets_allowed", propertyToUpdate.PetsAllowed);
                        command.Parameters.AddWithValue("@property_id", propertyToUpdate.PropertyId);
                        rowsAffectedProperty = command.ExecuteNonQuery();
                    }

                    string sqlStringPropertyPhotos = "UPDATE property_photos SET photo_url1 = @photo_url1, photo_description1 = @photo_description1, " +
                                                     "photo_url2 = @photo_url2, photo_description2 = @photo_description2, photo_url3 = @photo_url3, " +
                                                     "photo_description3 = @photo_description3, photo_url4 = @photo_url4, photo_description4 = @photo_description4 " +
                                                     "WHERE property_id = @property_id;";

                    using (SqlCommand comm = new SqlCommand(sqlStringPropertyPhotos, conn))
                    { 
                        comm.Parameters.AddWithValue("@photo_url1", propertyToUpdate.Picture[1]);
                        comm.Parameters.AddWithValue("@photo_description1", propertyToUpdate.Picture[2]);
                        comm.Parameters.AddWithValue("@photo_url2", propertyToUpdate.Picture[3]);
                        comm.Parameters.AddWithValue("@photo_description2", propertyToUpdate.Picture[4]);
                        comm.Parameters.AddWithValue("@photo_url3", propertyToUpdate.Picture[5]);
                        comm.Parameters.AddWithValue("@photo_description3", propertyToUpdate.Picture[6]);
                        comm.Parameters.AddWithValue("@photo_url4", propertyToUpdate.Picture[7]);
                        comm.Parameters.AddWithValue("@photo_description4", propertyToUpdate.Picture[8]);
                        comm.Parameters.AddWithValue("@property_id", propertyToUpdate.PropertyId);
                        rowsAffectedPropertyPhotos = comm.ExecuteNonQuery();
                    }
                }
            }
            catch (SqlException)
            {
                throw;
            }
            return (rowsAffectedAddress > 0 || rowsAffectedProperty > 0 || rowsAffectedPropertyPhotos > 0);
        }

        public List<Property> GetPropertiesByMaintWorkerID(int maintWorkerId)
        {
            List<Property> returnProperties = new List<Property>();

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    string sqlString = "SELECT DISTINCT properties.property_id, title, properties.address_id, rent_amount, number_beds, number_baths, properties.landlord_id, pp.primary_photo, pp.photo_url1, pp.photo_description1, pp.photo_url2, pp.photo_description2, pp.photo_url3, pp.photo_description3, pp.photo_url4, pp.photo_description4, available, available_date, property_description, square_footage, property_type, pets_allowed, street_number, unit_number, street_name, state_abbreviation, city, county, zip_code, u.phone, u.email " +
                                       "FROM properties " +
                                       "JOIN addresses ON properties.address_id = addresses.address_id " +
                                       "JOIN maintenance_requests ON properties.property_id = maintenance_requests.property_id " +
                                       "JOIN users ON maintenance_requests.maintenance_worker_id = users.user_id " +
                                       "JOIN users u ON properties.landlord_id = u.user_id " +
                                       "LEFT JOIN property_photos pp ON properties.property_id = pp.property_id " +
                                       "WHERE maintenance_worker_id = @maintWorkerId AND request_status <> 'Complete';";
                    SqlCommand cmd = new SqlCommand(sqlString, conn);
                    cmd.Parameters.AddWithValue("@maintWorkerId", maintWorkerId);
                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        Property p = GetPropertyFromReader(reader);
                        returnProperties.Add(p);
                    }
                }
            }
            catch (SqlException)
            {
                throw;
            }

            return returnProperties;
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
                Picture = new string[] {
                            Convert.ToString(reader["primary_photo"]), 
                            Convert.ToString(reader["photo_url1"]), 
                            Convert.ToString(reader["photo_description1"]), 
                            Convert.ToString(reader["photo_url2"]), 
                            Convert.ToString(reader["photo_description2"]), 
                            Convert.ToString(reader["photo_url3"]), 
                            Convert.ToString(reader["photo_description3"]), 
                            Convert.ToString(reader["photo_url4"]), 
                            Convert.ToString(reader["photo_description4"])
                },
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
