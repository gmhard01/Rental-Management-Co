<template>
  <div>
      <body>
          <propertyTile v-bind:property="property"/>
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
import propertyTile from '@/components/propertyTile.vue';
import transactionTile from '@/components/transactionTile.vue';
import maintenanceTile from '@/components/maintenanceTile.vue';
import LandlordService from '@/services/LandlordService.js';

export default {
  name: "proptransactions",
  props: ["property"],
  components: { 
      propertyTile,
      transactionTile,
      maintenanceTile
   },
   created() {
     LandlordService.getMaintenanceRequestForProperty(this.property.propertyId).then((response) => {
       this.$store.commit("UPDATE_LANDLORD_PROPERTY_MAINTENANCE", response.data, this.property.propertyId);
     });
     LandlordService.getTransactionsForProperty(this.property.propertyId).then((response) => {
       this.$store.commit("UPDATE_LANDLORD_PROPERTY_TRANSACTIONS", response.data, this.property.propertyId);
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
   },
}
</script>

<style>

</style>