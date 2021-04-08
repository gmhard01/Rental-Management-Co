<template>
  <div class="home">
    <body>
      <header>
        <headerBar id="headerBarId" />
      </header>
    <div class=gridHolder>
      <main id="propertyTileId">
      <div v-for="property in slicedArray" v-bind:key="property.propertyId" v-on:click="goToProperty(property)">
        <propertyTile v-bind:property="property" />
      </div>
      </main>
    </div>
    <img src="@/assets/DownArrow.png" alt="Next Arrow" class="ArrowBtn" v-on:click="next()" />
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
    slicedArray(){
      let previousIndex = 0;
      let newIndex = 7;
      
      if (this.propertylist.length <= newIndex){
        newIndex = this.propertylist.length;
      }

      if (this.propertylist.length <= previousIndex){
        previousIndex = 0;
        newIndex = 1;
      }

      return this.propertylist.slice(previousIndex, newIndex);
    },
  },
  methods: {
    next(indexNum = 0){
      let startingTileIndex = indexNum + 1;
      this.$router.push({name: "available-properties", params: {page: startingTileIndex}});
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
}

@media only screen and (max-width: 60em){
 .ArrowBtn {
   width: 3rem;
   padding-top: .5rem;
 } 
}
</style>
