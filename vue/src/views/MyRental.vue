<template>
  <div>
    <header>
        <headerBar id="headerBarId" />
      </header>
    <body v-if='$store.state.userRentalProperty.propertyId > 0'>
      <div>
        <propertyTile id="propertyTileId" v-bind:property="getPropertyObject" />
      </div>
      <button class="showPayments" v-on:click='showPaymentHistory === false ? showPaymentHistory = true : showPaymentHistory = false'>Show/Hide Payment History</button>
      <div v-for="transaction in $store.state.userTransactions" v-bind:key="transaction.paymentId">
        <transactionTile id="transactionTileId" v-show="showPaymentHistory" v-bind:transaction="transaction" />
      </div>
      <button class="showPayments" v-on:click='showUpcomingPayments === false ? showUpcomingPayments = true : showUpcomingPayments = false'>Show/Hide Upcoming Payments</button>
      <div v-for="payment in $store.state.userUpcomingPayments" v-bind:key="payment.installmentNumber">
        <upcomingPaymentTile id="upcomingPaymentTileId" v-show="showUpcomingPayments" v-bind:payment="payment" />
      </div>
      <button class= "showPayments" id='paymentBtn' v-on:click='showMakePayment = true'>Make a payment</button>
      <div class="paymentContainer" v-if='showMakePayment'>
        <div id="payForm" class="paymentPopup">
          <h1>Payment Amount</h1>
          <input v-model="payment.amountPaid" type='number' class="paymentInput" placeholder='$0.00'>
          <input v-on:click='submitPayment' type="submit" class="confirmBtn" name="" value="Confirm Payment">
          <button v-on:click='showMakePayment = false'>Close</button>
        </div>
      </div>
      <div class="maintenanceBox">
        <form class="formHolder" v-on:submit.prevent="submitMaintReq">
          <h1>Maintenance Request</h1>
          <textarea class="textBox" name="description" v-model="maintReq.details"></textarea>
          <input type="submit" class="submit" name="" value="Submit">
        </form>
      <!-- <router-link class="btnHolder" :to="this.$store.state.currentSearchIndex"><button class= "backToSearch">Maintenance Request</button></router-link> -->
      </div>
    </body>
    <body class='noRentalView' v-else>
      Your rental could not be found. Apply online or contact your landlord.
    </body>
  </div>
</template>

<script>
import headerBar from '@/components/headerBar.vue';
import propertyTile from '@/components/propertyTile.vue';
import transactionTile from '@/components/transactionTile.vue';
import upcomingPaymentTile from '@/components/upcomingPaymentTile.vue';
import UserService from '@/services/UserService';

export default {
  components: {
    headerBar,
    propertyTile,
    transactionTile,
    upcomingPaymentTile,
  },
  data() {
    return {
      showPaymentHistory: false,
      showUpcomingPayments: false,
      showMakePayment: false,
      payment: {amountPaid: null},
      maintReq: {
        details: "",
        requesterId: this.$store.state.user.userId,
        propertyId: null
      }
    }
  },
  created() {
    UserService.getUserProperty().then ((response) => {
      this.$store.commit("SET_USER_RENTAL_PROPERTY", response.data);
      this.maintReq.propertyId = response.data.propertyId;
    })
    UserService.getUserTransaction().then((response) => {
      this.$store.commit("SET_USER_TRANSACTIONS", response.data);
    })
    UserService.getUserUpcomingPayments().then((response) => {
      this.$store.commit("SET_USER_UPCOMING_PAYMENTS", response.data);
    })
    this.refresh();
},
computed: {
  getPropertyObject() {
    return this.$store.state.userRentalProperty;
  },
},
methods: {
  refresh() {
    if(!window.location.hash) {
        window.location = window.location + '#loaded';
        window.location.reload();
    }
  },
  submitPayment() {
    this.payment.amountPaid = parseFloat(this.payment.amountPaid);
    UserService.makePayment(this.payment)
    .then(() => {
      this.showMakePayment = false;
    })
    },
    submitMaintReq() {
    UserService.postMaintReq(this.maintReq)
    .then(() => {
      this.maintReq = {
        details: "",
        requesterId: this.$store.state.user.userId,
        propertyId: null
      };
    })
    }
}
}
</script>

<style>
#propertyTileId{
  margin-top: 8rem; 
}
.textBox{
  width: 100%;
  min-height: 5rem;
  border-radius: .5rem;
}

h1{
  font-size: 1.5em;
  margin-top: 0;  
}

.formHolder, .paymentPopup, .noRentalView{
  background-color: #fff;
  border-radius: 1.5rem;
  overflow: hidden;
  box-shadow: 0 3rem 6rem rgba(0, 0, 0, 0.589);
  font-family: "Oswald", "Arial", "Helvetica", "sans-serif";
  display: flex;
  flex-direction: column;
  padding: 1rem;
  padding-right: 1.5rem;
}

.paymentContainer{
  box-sizing: border-box;
  position: fixed;
  display: flex;
  align-items: center;
  justify-content: center;
  position: fixed;
  top: 0;
  left: 0;
  width: 100vw;
  height: 100vh;
  background-color: rgba(0, 0, 0, 0.219);
}
.noRentalView{
  margin-top: 9rem;

}
.confirmBtn{
  margin-top: 1rem;
  border-radius: .5rem;
  font-size: 20px;
  border-color: rgba(128, 128, 128, 0.377);
}

.paymentInput{
  padding: .3rem;
}

.paymentPopup , .noRentalView{
  background-color: white;
  padding: 2rem;
  display: flex;
  align-items: center;
  justify-content: center;
  text-align: center;
}

.maintenanceBox{
  padding-top: .7rem;
}

.makePayment{
  background-color:rgb(182, 204, 236);
}

.showPayments{
  width: 20rem;
}

</style>