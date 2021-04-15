<template>
  <div>
    <body>
      <header>
        <headerBar id="headerBarId" />
      </header>
      <propertyTile v-bind:property="getPropertyObject" id="propertyTileId"/>
      <div v-show="checkForApplicationData">
        <div v-for="application in getApplicationsList" v-bind:key="application.applicationId">
          <applicationTile v-bind:application="application" />
        </div>
      </div>
      <div v-show="checkForMaintenanceRequestData">
        <div v-for="request in getMaintenanceRequestList" v-bind:key="request.id">
          <maintenanceTile v-bind:request="request" />
        </div>
      </div>
      <div v-show="checkForTransactionData">
        <div v-for="transaction in getTransactionsList" v-bind:key="transaction.id">
          <transactionTile v-bind:transaction="transaction" />
        </div>
      </div>
    </body>
  </div>
</template>

<script>
import headerBar from '@/components/headerBar.vue';
import propertyTile from '@/components/propertyTile.vue';
import transactionTile from '@/components/transactionTile.vue';
import maintenanceTile from '@/components/maintenanceTile.vue';
import LandlordService from '@/services/LandlordService.js';
import applicationTile from '@/components/applicationTile.vue';
import PropService from '@/services/PropService';

export default {
  name: "propertytransactions",
  components: { 
      headerBar,
      propertyTile,
      transactionTile,
      maintenanceTile,
      applicationTile,
   },
   created() {
     PropService.getPropertyById(this.getCurrentPropertyId).then ((response) => {
        this.$store.commit("SET_PROPERTY", response.data);        
      });
     LandlordService.getMaintenanceRequestForProperty(this.getCurrentPropertyId).then((response) => {
       if (response.data.length > 0) {
        this.$store.commit("SET_LANDLORD_PROPERTY_MAINTENANCE", response.data);
       }
     });
     LandlordService.getTransactionsForProperty(this.getCurrentPropertyId).then((response) => {
       if (response.data.length > 0) {
        this.$store.commit("SET_LANDLORD_PROPERTY_TRANSACTIONS", response.data);
       }
     });
     LandlordService.getApplicationsForProperty(this.getCurrentPropertyId).then((response) => {
         if (response.data.length > 0) {
          this.$store.commit("SET_LANDLORD_PROPERTY_APPLICATIONS", response.data);
         }
     });
   },
   computed: {
     getCurrentPropertyId() {
      return this.$route.params.propertyId;
     },
     getPropertyObject() {
      return this.$store.state.currentProperty;
     },
     getMaintenanceRequestList() {
       return this.$store.state.landlordMaintenanceRequestForProperty;
     },
     getTransactionsList() {
       return this.$store.state.landlordTransactionsForProperty;
     },
     getApplicationsList() {
       return this.$store.state.landlordApplicationsForProperty;
     },
     checkForApplicationData() {
       let output = false;
       if (this.$store.landlordApplicationsForProperty != {}) {
         output = true;
       }
       return output;
     },
     checkForTransactionData() {
       let output = false;
       if (this.$store.landlordTransactionsForProperty != {}) {
         output = true;
       }
       return output;
     },
     checkForMaintenanceRequestData() {
       let output = false;
       if (this.$store.landlordMaintenanceRequestForProperty != {}) {
         output = true;
       }
       return output;
     },
   },
}
</script>

<style>
#propertyTileId {
  margin-top: 8rem; 
}
</style>