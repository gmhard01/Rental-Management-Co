<template>
    <div>
        <body>
            <header>
              <headerBar id="headerBarId" />
            </header>
            <div class=gridHolder>
              <main id="propertyTileId">
                <div v-for="property in getProperties" v-bind:key="property.propertyId">
                  <propertyTile v-bind:property="property" />
                  <propTransactions v-bind:property="property" id="propTransactions" />
                </div>
              </main>
            </div>
        </body>
    </div>
</template>

<script>
import headerBar from '@/components/headerBar.vue';
import propertyTile from '@/components/propertyTile.vue';
//import propTransactions from '@/components/propTransactions.vue';
import LandlordService from '@/services/LandlordService.js';

export default {
  components: {
    headerBar,
    propertyTile,
    //propTransactions
  },
  created() {
    LandlordService.getPropertyList().then((response) => {
      this.$store.commit("SET_LANDLORD_PROPERTIES", response.data);
    })
    this.refresh();
  },
  computed: {
    getProperties() {
      return this.$store.state.landlordPropertiesList;
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
#headerBarId {
  left: 0rem;
}

#propTransactions{
  margin-top: 8rem; 
}
</style>