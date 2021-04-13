<template>
  <div>
      <body>
          <div v-for="property in getPropertyMaintenanceRequest" v-bind:key="property.propertyId">
          <propertyTile v-bind:property="property" />
          <maintenanceTile v-bind:requests="property.maintenanceRequest" />
          </div>
      </body>
  </div>
</template>

<script>
import propertyTile from '@/components/propertyTile.vue';
import maintenanceTile from '@/components/maintenanceTile.vue';
import MaintenanceService from '@/services/MaintenanceService.js';

export default {
  name: "propMaintenance",
  data() {
    return {
    }
  },
  components: { 
      propertyTile,
      maintenanceTile,      
   },
  created() {
    MaintenanceService.getPropertyByMaintenanceID(this.$store.state.user.userId).then((response) => {
      this.$store.commit("SET_MAINTENANCE_PROPERTIES", response.data); 
     })
   },
  computed: {
    getPropertyMaintenanceRequest() {
      return this.$store.state.propertyMaintenanceRequest;
    }
  },
}
</script>

<style>

</style>