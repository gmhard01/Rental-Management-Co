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
    <div>
      <form class="formHolder">
        <h1>Maintenance Request</h1>
        <textarea class="textBox" name="description"></textarea>
        <input type="submit" class="submit" name="" value="Submit">
      </form>
    <!-- <router-link class="btnHolder" :to="this.$store.state.currentSearchIndex"><button class= "backToSearch">Maintenance Request</button></router-link> -->
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
    UserService.getUserProperty().then ((response) => {
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
.textBox{
  width: 100%;
  min-height: 5rem;
  border-radius: .5rem;
}

h1{
  font-size: 1.5em;
  margin-top: 0;  
}

.formHolder {
  background-color: #fff;
  border-radius: 1.5rem;
  overflow: hidden;
  box-shadow: 0 3rem 6rem rgba(0, 0, 0, 0.589);
  font-family: "Oswald", "Arial", "Helvetica", "sans-serif";
  display: flex;
  flex-direction: column;
  padding: 1rem;
  padding-right: 1.5rem;
}
</style>