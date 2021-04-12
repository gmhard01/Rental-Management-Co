<template>
  <div>
      <body>
    <header>
      <headerBar id="headerBarId" />
    </header>
    <div>
      <propertyTile id="propertyTileId" v-bind:property="getPropertyObject" />
    </div>
    <div>
      <transactionTile id="transactionTileId" v-bind:user="getPropertyObject" />
    </div>
  </body>
  </div>
</template>

<script>
import headerBar from '@/components/headerBar.vue';
import propertyTile from '@/components/propertyTile.vue';
import transactionTile from '@/components/transactionTile.vue';
import UserService from '@/services/UserService';

export default {
  components: {
    headerBar,
    propertyTile,
    transactionTile,
  },
  created() {
    UserService.getUserProperty(this.$store.state.user.userId).then ((response) => {
      this.$store.commit("SET_USER_RENTAL_PROPERTY", response.data);
    })
},
computed: {
  getPropertyObject() {
    return this.$store.state.userRentalProperty;
  },
},
}
</script>

<style>
#propertyTileId{
  margin-top: 8rem; 
}
</style>