import axios from 'axios';

const https = axios.create({
  baseURL: "https://localhost:44315"
});

export default {
  

  getPropertyList() {
    return https.get('/properties')  //needs updated to match c#
  },
  submitApplication(applicationForm){
    return axios.post('/newapplication', applicationForm);
  },
  getPropertyById(propertyId){
    return https.get(`/properties/${propertyId}`);
  }
}
//https://localhost:44315/properties/page/{numberOfProperties}/{pageIndex}
