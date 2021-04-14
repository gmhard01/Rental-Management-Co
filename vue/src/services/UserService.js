import axios from 'axios';

const https = axios.create({
  baseURL: "https://localhost:44315"
});

export default {
  getUserProperty() {
    return https.get('/properties/renter')
  },
  getUserTransaction() {
      return https.get("/payments");
  },
  getUserUpcomingPayments() {
    return https.get("/payments/upcoming");
  },
  makePayment(payment) {
    return axios.post("/submitpayment", payment);
  }
}