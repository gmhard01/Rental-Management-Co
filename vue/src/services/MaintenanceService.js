import axios from 'axios';

const https = axios.create({
  baseURL: "https://localhost:44315"
});

export default {
  getPropertyByMaintenanceID() {
    return https.get('/properties/maintworker');
  },  
}