import axios from 'axios';

const https = axios.create({
  baseURL: "https://localhost:44315"
});

export default {

  getPropertyList() {
    return https.get('/properties')  //needs updated to match c#
  }
}
