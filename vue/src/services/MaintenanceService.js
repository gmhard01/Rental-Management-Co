import axios from 'axios';

const https = axios.create({
  baseURL: "https://localhost:44315"
});

export default {
  getPropertyByMaintenanceID(employeeId) {
    return https.get(`/maintenance/${employeeId}`)  //needs updated to match c#
  },  
}