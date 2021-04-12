<template>
  <div class="home">
    <body>
      <header>
        <headerBar id="headerBarId" />
      </header>
    <div class=gridHolder>
      <main id="propertyTileId">
      <div v-for="property in propertylist" v-bind:key="property.propertyId" v-on:click="goToProperty(property)">
        <propertyTile v-bind:property="property" />
      </div>
      </main>
    </div>
    <img src="@/assets/DownArrow.png" alt="Next Arrow" class="ArrowBtn" v-on:click="next(getCurrentIndex)" />
    </body>
  </div>
</template>

<script>
import headerBar from '@/components/headerBar.vue';
import propertyTile from '@/components/propertyTile.vue';
import PropService from '@/services/PropService';

export default {
  name: "availableProperties",
  data() {
    return {
      startingTileIndex: 0,
      tileIncrementNum: 5,
    }
  },
  components: {
    headerBar,
    propertyTile
  },
  
  created() {
    PropService.getPropertiesByParameters(this.tileIncrementNum, this.getCurrentIndex).then ((response) => {
        this.$store.commit("SET_PROPERTIES", response.data);        
      })
      this.removePathFromStore();
      },
  beforeRouteUpdate(to, from, next) {
    this.param = to.params.param;
    next();},
  computed: {
    propertylist(){
      return this.$store.state.properties;
    },
    getCurrentIndex(){
      return parseInt(this.$route.params.page);
    },
    // slicedArray(){
    //   let previousIndex = this.getCurrentIndex * 7;
    //   let newIndex = (this.getCurrentIndex + 1) * 7;
      
    //   if (this.propertylist.length <= newIndex){
    //     newIndex = this.propertylist.length;
    //   }

    //   if (this.propertylist.length <= previousIndex){
    //     previousIndex = 0;
    //     newIndex = 1;
    //   }

    //   return this.propertylist.slice(previousIndex, newIndex);
    // },
    getCurrentRoute() {
      return this.$route.path;
    },
  },
  methods: {
    next(indexNum = 0){
      let startingTileIndex = indexNum + 1;
      this.$router.push({name: "available-properties", params: {page: startingTileIndex}});
      this.saveCurrentSearchIndex();
      this.getNewPropertyList();
      window.scrollTo(0, 0);
    },
    getNewPropertyList(){
      PropService.getPropertiesByParameters(this.tileIncrementNum, this.getCurrentIndex).then ((response) => {
        this.$store.commit("SET_PROPERTIES", response.data);        
      })
    },
    previous(){
      this.startingTileIndex -=15;
      this.getCurrentListing(this.startingTileIndex);
    },
    getCurrentListing(page){
      PropService.getPropertyList(page).then ((response) => {
        this.propertylist = response.data;
      })
    },
    goToProperty(currentProperty){
      this.$router.push({name: "rental-property", params: {propertyId: currentProperty.propertyId}});      
    },
    saveCurrentSearchIndex(){
      this.$store.commit("SAVE_CURRENT_SEARCH_INDEX", this.getCurrentRoute);
    },
    removePathFromStore() {
      this.$store.commit("REMOVE_CURRENT_ROUTE");
    },
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

.ArrowBtn {
  width: 5rem;
  display: block;
  padding-top: 1rem;
  margin-left: auto;
  margin-right: auto;
  cursor: pointer;
}
</style>
