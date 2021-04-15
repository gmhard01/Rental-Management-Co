import axios from 'axios';

const https = axios.create({
  baseURL: "https://localhost:44315"
});

export default {
  

  getPropertyList() {
    return https.get('/properties/landlord');
  },
  getMaintenanceRequestForProperty(propertyId) {
      return https.get(`/landlord/maintenance/${propertyId}`);
  },
  getTransactionsForProperty(propertId) {
      return https.get(`/landlord/transactions/${propertId}`);
  },
  getApplicationsForProperty(propertyId) {
    return https.get(`/applications/${propertyId}`);
  },
  updateApplicationApproveDecline(application) {
    return https.put(`/applications/updatestatus`, application);
  },
  addProperty(newProperty) {
    return axios.post(`/addproperty`, newProperty);
  }
}