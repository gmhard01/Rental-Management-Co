<template>
  <div class="home">
    <body>
      <header>
        <headerBar id="headerBarId" />
      </header>
    <div class=gridHolder>
      <main id="propertyTileId">
      <div v-for="property in propertylist" v-bind:key="property.propertyId">
        <propertyTile v-bind:property="property" />
      </div>
      </main>
    </div> 
    </body>
  </div>
</template>

<script>
import headerBar from '@/components/headerBar.vue';
import propertyTile from '@/components/propertyTile.vue';
import PropService from '@/services/PropService';

export default {
  name: "home",
  data() {
    return {
      startingTileIndex: 0,
      TileIncrementNum: 7,
    }
  },
  components: {
    headerBar,
    propertyTile
  },
  
  created() {
    PropService.getPropertyList().then ((response) => {
        this.$store.commit("SET_PROPERTIES", response.data);        
      })
      },
  computed: {
    propertylist(){
      return this.$store.state.properties;
    },
  },
  methods: {
    next(){
      this.startingTileIndex += 15;
      this.getCurrentListing(this.startingTileIndex);
    },
    previous(){
      this.startingTileIndex -=15;
      this.getCurrentListing(this.startingTileIndex);
    },
    getCurrentListing(page){
      PropService.getPropertyList(page).then ((response) => {
        this.propertylist = response.data;
      })
    }
  }};
</script>
<style scoped>
#headerBarId {
  left: 0rem;
}
#propertyTileId {
  margin-top: 8.5rem; 
}
.gridHolder {
  font-family: "Oswald", "Arial", "Helvetica", "sans-serif";
  font-size: .9rem;
  display: flex;
  color: #808080;
  flex-direction: column;
  padding: 0rem;
  min-height: 100vh;
}
</style>
