<template>
    <div>
        <body>
            <header>
                <headerBar id="headerBarId" />
            </header>
            <div v-for="property in getPropeties" v-bind:key="property.id">
                <propTransactions v-bind:property="property" id="propTransactions" />
            </div>
        </body>
    </div>
</template>

<script>
import headerBar from '@/components/headerBar.vue';
import propTransactions from '@/components/propTransactions.vue';
import LandlordService from '@/services/LandlordService.js';

export default {
  components: {
    headerBar,
    propTransactions
  },
  created() {
    LandlordService.getPropertyList().then((response) => {
      this.$store.commit("SET_LANDLORD_PROPERTIES", response.data);
    })
  },
  computed: {
    getProperties() {
      return this.$store.state.landlordProperties;
    },
  },
}
</script>

<style>
#propTransactions{
  margin-top: 8rem; 
}
</style>