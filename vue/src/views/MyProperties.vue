<template>
    <div>
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
            <div class="arrowBar">
              <img src="@/assets/LeftArrow.png" alt="Prev Arrow" class="ArrowBtn" v-on:click="previous(getCurrentIndex)" />
              <img v-show="checkForEndOfList" src="@/assets/RightArrow.png" alt="Next Arrow" class="ArrowBtn" v-on:click="next()" />
            </div>
        </body>
    </div>
</template>

<script>
import headerBar from '@/components/headerBar.vue';
import propertyTile from '@/components/propertyTile.vue';
import LandlordService from '@/services/LandlordService.js';

export default {
  name: "landlord",
  data() {
    return {
      startingTileIndex: 0,
      tileIncrementNum: 5,
      lastTileTocall: 0,
    }
  },
  components: {
    headerBar,
    propertyTile,
  },
  created() {
    LandlordService.getPropertyList().then((response) => {
      this.$store.commit("SET_LANDLORD_PROPERTIES", response.data);
    });
    this.removeCurrentPropertyFromStore();
    // this.refresh();
  },
  computed: {
    getProperties() {
      return this.$store.state.landlordPropertiesList;
    },
    slicedArray(){
      let previousIndex = this.getCurrentIndex * this.tileIncrementNum;
      let newIndex = (this.getCurrentIndex + 1) * this.tileIncrementNum;
      
      if (this.getProperties.length <= newIndex){
        newIndex = this.getProperties.length;
      }

      if (this.getProperties.length <= previousIndex){
        previousIndex = 0;
        newIndex = 1;
      }

      return this.getProperties.slice(previousIndex, newIndex);
    },
    getCurrentIndex(){
      return parseInt(this.$route.params.page);
    },
    checkForEndOfList() {
      let output = true;
      if (this.getProperties.length < ((this.getCurrentIndex + 1) * this.tileIncrementNum)) {
        output = false;
      }
      return output;
    },
  },
  methods: {
    refresh() {
    if(!window.location.hash) {
        window.location = window.location + '#loaded';
        window.location.reload();
    }
  },
  next(){
      let startingTileIndex = this.getCurrentIndex + 1;
      this.$router.push({name: "my-properties", params: {page: startingTileIndex}});
      this.saveCurrentSearchIndex();
      window.scrollTo(0, 0);      
    },
  previous(){
      let startingTileIndex = this.getCurrentIndex - 1;
      if (startingTileIndex != 0) {
        this.$router.push({name: "my-properties", params: {page: startingTileIndex}});
      }
      else {
        this.$router.push("/my-rentals");
      }
      this.saveCurrentSearchIndex();
    //   this.getNewPropertyList();
      window.scrollTo(0, 0);
    },
    saveCurrentSearchIndex(){
      this.$store.commit("SAVE_CURRENT_SEARCH_INDEX", this.getCurrentRoute);
    },
    goToProperty(currentProperty){
      this.$router.push({name: "property-transactions", params: {propertyId: currentProperty.propertyId}});
    },    
    removeCurrentPropertyFromStore() {
      this.$store.commit("REMOVE_DATA_FOR_CURRENT_LANDLORD_PROPERTY_FROM_STORE");
    },
  },
}
</script>

<style>
#headerBarId {
  left: 0rem;
}

#propTransactions{
  margin-top: 8rem; 
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

.arrowBar{
  display: flex;
  flex-direction: row;
  justify-content: space-around;
}

.ArrowBtn:hover {
  opacity: 1.0;
  transition: 1s;
}

@media only screen and (max-width: 60em){
 .ArrowBtn {
   width: 3rem;
   padding-top: .5rem;
 } 
}
</style>