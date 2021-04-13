<template>
  <div>
      <body>
    <header>
      <headerBar id="headerBarId" />
    </header>
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
    <router-link :to="{ name: 'home' }"><button class= "makePayment">Make a payment</button></router-link>
    <div class="maintenanceBox">
      <form class="formHolder">
        <h1>Maintenance Request</h1>
        <textarea class="textBox" name="description"></textarea>
        <input type="submit" class="submit" name="" value="Submit">
      </form>
    <!-- <router-link class="btnHolder" :to="this.$store.state.currentSearchIndex"><button class= "backToSearch">Maintenance Request</button></router-link> -->
    </div>  
  </body>
  </div>
</template>

<script>
import headerBar from '@/components/headerBar.vue';
import propertyTile from '@/components/propertyTile.vue';
import transactionTile from '@/components/transactionTile.vue';
import upcomingPaymentTile from '@/components/upcomingPaymentTile.vue'
import UserService from '@/services/UserService';

export default {
  components: {
    headerBar,
    propertyTile,
    transactionTile,
    upcomingPaymentTile
  },
  data() {
    return {
      showPaymentHistory: false,
      showUpcomingPayments: false
    }
  },
  created() {
    UserService.getUserProperty().then ((response) => {
      this.$store.commit("SET_USER_RENTAL_PROPERTY", response.data);
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

.formHolder {
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