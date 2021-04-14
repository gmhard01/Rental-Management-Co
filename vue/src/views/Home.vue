<template>
  <div class="home">
    <body>
      <header>
        <headerBar id="headerBarId" />
      </header>
    <div class=gridHolder>
      <main id="propertyTileId">
      <div v-for="property in propertyList" v-bind:key="property.propertyId" v-on:click="goToProperty(property)">
        <propertyTile v-bind:property="property" />
      </div>
      </main>
    </div>
    <div class="arrowBar">
    <img src="@/assets/RightArrow.png" alt="Next Arrow" class="ArrowBtn" v-on:click="next()" />
    </div>
    <button id="mapButton" v-on:click="showMap === false ? showMap = true : showMap = false">Show/Hide Map (beta)</button>
    <googleMap v-show="showMap"/> 
    </body>
  </div>
</template>

<script>
import headerBar from '@/components/headerBar.vue';
import propertyTile from '@/components/propertyTile.vue';
import googleMap from '@/components/map.vue';
import PropService from '@/services/PropService';

export default {
  name: "home",
  data() {
    return {
      startingTileIndex: 0,
      tileIncrementNum: 5,
      showMap: false
    }
  },
  components: {
    headerBar,
    propertyTile,
    googleMap
  },
  
  created() {
    PropService.getPropertiesByParameters(this.tileIncrementNum, this.startingTileIndex).then ((response) => {
        this.$store.commit("SET_PROPERTIES", response.data);
        this.saveCurrentSearchIndex();         
        this.removePathFromStore();       
      })
      },
  computed: {
    propertyList(){
      return this.$store.state.properties;
    },
    // slicedArray(){
    //   let previousIndex = 0;
    //   let newIndex = 7;
      
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
      window.scrollTo(0, 0);      
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
  margin-top: 8rem; 
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
  opacity: 0.3;
}

.ArrowBtn:hover {
  opacity: 1.0;
  transition: 1s;
}

#mapButton {
  width: 20rem;
  margin-top: 15px;
  align-self: center;
  cursor: pointer;
}

@media only screen and (max-width: 60em){
 .ArrowBtn {
   width: 3rem;
   padding-top: .5rem;
 } 
}
</style>
