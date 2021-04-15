import axios from 'axios';

const https = axios.create({
  baseURL: "https://localhost:44315"
});

export default {
  

  getPropertyList() {
    return https.get('/properties/landlord');
  },
  getMaintenanceRequestForProperty(propertyId) {
      return https.get(`/maintenance/${propertyId}`);
  },
  getTransactionsForProperty(propertyId) {
      return https.get(`/payments/${propertyId}`);
  },
  getApplicationsForProperty(propertyId) {
    return https.get(`/applications/${propertyId}`);
  },
  updateApplicationApproveDecline(application) {
    return https.put(`/applications/updatestatus`, application);
  },
  createLease(lease) {
    return axios.post(`/newlease`, lease);
  },
  createPaySched(lease) {
    return axios.post(`/createpayschedule`, lease);
  },
  updatePropertyToUnavailable(property) {
    return https.put('/property/unavailable', property)
  },
  addProperty(newProperty) {
    return axios.post(`/addproperty`, newProperty);
  },
  updateProperty(propertyToUpdate) {
    return axios.put('/property-update', propertyToUpdate);
  },
  updateMaintReqWorker(maintReq) {
    return axios.put('/maintenance/assign', maintReq);
  }
}