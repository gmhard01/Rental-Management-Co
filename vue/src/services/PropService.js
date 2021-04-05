import axios from 'axios';

export default {

  getPropertyList() {
    return axios.get('/properties')  //needs updated to match c#
  }

}
