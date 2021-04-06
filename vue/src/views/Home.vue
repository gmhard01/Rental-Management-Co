<template>
  <div class="home">
    <headerBar id="headerBarId" />
    <propertyTile id="propertyTileId" />
    <body>
      <div v-for="propertyid in propertylist" v-bind:key="propertyid">
        <propertyTile v-bind:property-id="propertyid" />
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
      propertylist: [],
      startingTileIndex: 0
    }
  },
  components: {
    headerBar,
    propertyTile
  },
  /*created(){
      PropService.getPropertyList(
    ).then((resp) => {
      this.prop = resp;
    });
  }*/
  created() {
    PropService.getPropertyList(0).then ((response) => {
        this.propertylist = response.data;})
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
#propertyTileId {
  margin-top: 7.5rem; 
}


</style>
