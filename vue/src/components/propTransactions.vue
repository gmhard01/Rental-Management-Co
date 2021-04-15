<template>
  <div>
      <body>
          <!-- <propertyTile v-bind:property="property"/> -->
          <div>
          <div v-for="application in getApplicationsList" v-bind:key="application.applicationId">
            <applicationTile v-bind:application="application" />
          </div>
          </div>
          <div v-for="request in getMaintenanceRequestList" v-bind:key="request.id">
            <maintenanceTile v-bind:request="request" />
          </div>
          <div v-for="transaction in getTransactionsList" v-bind:key="transaction.id">
            <transactionTile v-bind:transaction="transaction" />
          </div>
      </body>
  </div>
</template>

<script>
// import propertyTile from '@/components/propertyTile.vue';
import transactionTile from '@/components/transactionTile.vue';
import maintenanceTile from '@/components/maintenanceTile.vue';
import LandlordService from '@/services/LandlordService.js';
import applicationTile from '@/components/applicationTile.vue';

export default {
  name: "proptransactions",
  props: ["property"],
  components: { 
      // propertyTile,
      transactionTile,
      maintenanceTile,
      applicationTile,
   },
   created() {

    //  this.$store.commit("UPDATE_LANDLORD_PROPERTY_APPLICATIONS", [{
    //    "propertyId" : 126,
    //    "firstName" : "elijah",
    //    "lastName" : "jackson",
    //    "applicationId": "234"}]);
    //  LandlordService.getMaintenanceRequestForProperty(this.property.propertyId).then((response) => {
    //    this.$store.commit("UPDATE_LANDLORD_PROPERTY_MAINTENANCE", response.data, this.property.propertyId);
    //  });
    //  LandlordService.getTransactionsForProperty(this.property.propertyId).then((response) => {
    //    this.$store.commit("UPDATE_LANDLORD_PROPERTY_TRANSACTIONS", response.data, this.property.propertyId);
    //  });
     LandlordService.getApplicationsForProperty(this.property.propertyId).then((response) => {
         if (response.data.length > 0) {
          this.$store.commit("UPDATE_LANDLORD_PROPERTY_APPLICATIONS", response.data);
         }
     });
   },
   computed: {
     getMaintenanceRequestList() {
       return this.$store.state.landlordPropertiesList.find((response) => {
         return response.propertyId == this.property.propertyId;
       }).maintenanceRequest;
     },
     getTransactionsList() {
       return this.$store.state.landlordPropertiesList.find((response) => {
         return response.propertyId == this.property.propertyId;
       }).transactions;
     },
     getApplicationsList() {
       return this.$store.state.landlordPropertiesList.find((response) => {
         return response.propertyId == this.property.propertyId;
       }).applications;
     },
     checkForData() {
       let output = false;
       if ('applications' in this.$store.state.landlordPropertiesList.find((response) => {return response.propertyId = this.property.propertyId})) {
         output = true;
       }
       return output;
     },
   },
}
</script>

<style>

</style>