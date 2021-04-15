<template>
  <div>
    <body>
      <header>
        <headerBar id="headerBarId" />
      </header>
      <propertyTile v-bind:property="getPropertyObject" id="propertyTileId"/>
      <div v-show="checkForMaintenanceRequestData">
        <div v-for="request in getMaintenanceRequestList" v-bind:key="request.id">
          <maintenanceTile v-bind:request="request" />
        </div>
      </div>
    </body>
  </div>
</template>

<script>
import headerBar from '@/components/headerBar.vue';
import propertyTile from '@/components/propertyTile.vue';
import LandlordService from '@/services/LandlordService.js';
import PropService from '@/services/PropService';

export default {
  name: "maintenance",
  components: {
    headerBar,
    propertyTile
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
  },
  computed: {
    getCurrentPropertyId() {
      return this.$route.params.propertyId;
     },
    getMaintenanceRequestList() {
       return this.$store.state.landlordMaintenanceRequestForProperty;
     },
    checkForMaintenanceRequestData() {
      let output = false;
      if (this.$store.landlordMaintenanceRequestForProperty != {}) {
        output = true;
      }
      return output;
    },
  }
}
</script>

<style>
#propMaintenance{
  margin-top: 8rem; 
}
</style>