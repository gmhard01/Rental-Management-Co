<template>
<div>
  <body>
    <header>
      <headerBar id="headerBarId" />
    </header>
    <div>
      <propertyTile id="propertyTileId" v-bind:property="getPropertyObject" />
    </div>
    <div class="appFormHolder">
      <form class="applicationBox" @submit.prevent="apply" v-if="!hasApplied && isLoggedIn && this.$store.state.user.role=='Renter'">
        <h1>Apply Here</h1>
        <div class="rowOne">
          <input type="text" class="textInputs" name="" placeholder="Legal First Name" required v-model="applicationForm.applicantFirstName" autofocus>
          <input type="text" class="textInputs" name="" placeholder="Legal Last Name" required v-model="applicationForm.applicantLastName" autofocus>
          <input type="tel" class="textInputs" id="phoneNumber" name="" placeholder="Phone Number" required v-model="applicationForm.applicantPhone" autofocus>
        </div>
        <input type="submit" class="submit" name="" value="Submit">
      </form>
      <p class="needToSignIn" v-if="hasApplied">You have successfully applied</p>
      <div class="needToSignIn" v-if="!isLoggedIn">
        You must be signed in to apply
      <router-link :to="{ name: 'login' }"><button>Login</button></router-link>
      </div>
    </div>
    <router-link :to="this.$store.state.currentSearchIndex"><button class= "backToSearch">Back to search results</button></router-link>
  </body>
</div>
</template>

<script>

import headerBar from '@/components/headerBar.vue';
import PropService from '@/services/PropService';
import propertyTile from '@/components/propertyTile.vue';

export default {
name: "rentalProperty",
data() {
  return {
    hasApplied: false,
    formNotExcepted: false,
    errorResponse: "",
    applicationForm: {
      applicantId: this.$store.state.user.userId,
      propertyId: parseInt(this.$route.params.propertyId),
      approvalStatus: "pending",
      applicantFirstName: "",
      applicantLastName: "",
      applicantPhone: ""
    }, 
  }
},
methods: {
  apply() {    
    this.errorResponse = "you have hit submit";
    PropService.submitApplication(this.applicationForm).then(response => {
      if(response.data.applicationId != null){
        this.hasApplied = true;
      }
      else {
        this.formNotExcepted = true;
      }
    })
    .catch((error) => {
              this.formNotExcepted = true;
              console.log(error);
    });
    this.applicationForm.applicantFirstName = "";
    this.applicationForm.applicantLastName = "";
    this.applicationForm.applicantPhone = "";   
  },
  saveCurrentRoute() {
      this.$store.commit("SAVE_CURRENT_ROUTE", this.getCurrentRoute);
    },
},
computed: {
  getPropertyObject() {
    return this.$store.state.currentProperty;
  },
  getCurrentPropertyId() {
    return this.$route.params.propertyId;
  },
  isLoggedIn() {
  if(this.$store.state.user.username != null){
    return true;
  }
  else{
    return false;
  }},
  getCurrentRoute() {
    return this.$route.path;
  }
},
components: {
    headerBar,
    propertyTile,
  },
  created() {
    PropService.getPropertyById(this.getCurrentPropertyId).then ((response) => {
        this.$store.commit("SET_PROPERTY", response.data);        
      })
    
    this.saveCurrentRoute();
  },
}
</script>

<style>
#headerBarId {
  left: 0rem;
}

.backToSearch {
  background-color: rgb(182, 204, 236);
  border-color: rgba(128, 128, 128, 0.377);
  text-align: center;
}

#propertyTileId {
  margin-top: 8rem; 
}

body{
  display: flex;
  flex-direction: column;
  justify-content: center;
}
.applicationBox, .needToSignIn{
  margin-top: .2rem;
  background-color: #fff;
  border-radius: 1.5rem;
  overflow: hidden;
  box-shadow: 0 3rem 6rem rgba(0, 0, 0, 0.589);
  margin-bottom: .5rem;
  padding: 20px;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: space-between;
  font-family: "Oswald", "Arial", "Helvetica", "sans-serif";
  width: 97%;
}

.appFormHolder{
  display: flex;
  justify-content: center;
  align-items: center;
}

.needToSignIn{
  display: flex;
  align-content: center;
  justify-content: center;
}

.textInputs, .submit {
  font-size: 20px;
  height: 20%;
  margin: .5rem;
  width: 13rem;
  border-radius: .5rem;
  border-color:rgba(128, 128, 128, 0.377);
  text-align: center;
}

button{
  margin: .5rem;
  border-radius: .5rem;
  font-size: 20px;
  border-color: rgba(128, 128, 128, 0.377);
}

.rowOne{
  display: flex;
  flex-direction: column;
}

h1{
  font-size: 25px;  
  padding-left: .7rem;
}
</style>