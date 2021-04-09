<template>
<div>
  <body>
    <header>
      <headerBar id="headerBarId" />
    </header>
    <div>
      <propertyTile v-bind:property="getPropertyObject" />
    </div>
    <div>
      <form class="applicationBox" @submit.prevent="apply">
        <h1>Application Form</h1>
        <input type="text" name="" placeholder="Legal First Name" required v-model="applicationForm.applicantFirstName" autofocus>
        <input type="text" name="" placeholder="Legal Last Name" required v-model="applicationForm.applicantLastName" autofocus>
        <input type="tel" id="phoneNumber" name="" placeholder="Phone Number" required v-model="applicationForm.applicantPhone" autofocus>
        <input type="submit" class="submit" name="" value="Submit">
      </form>
      {{responseData}}
    </div>
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
    responseData: {},   
  }
},
methods: {
  apply() {    
    this.errorResponse = "you have hit submit";
    PropService.submitApplication(this.applicationForm).then(response => {
      this.responseData = response;
      if(response.applicationId != null){
        this.hasApplied = true;
      }
      else {
        this.formNotExcepted = true;
      }
    })
    .catch(() => {
              this.formNotExcepted = true;
    });
    this.applicationForm.applicantFirstName = "";
    this.applicationForm.applicantLastName = "";
    this.applicationForm.applicantPhone = "";   
  }
},
computed: {
  getPropertyObject() {
    return this.$store.state.currentProperty;
  },
  getCurrentPropertyId() {
    return this.$route.params.propertyId;
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
  }
}
</script>

PropertyTile
<style>
#headerBarId {
  left: 0rem;
}

body{
  display: flex;
  flex-direction: column;
}
.applicationBox {
  margin-top: 10rem;
}
</style>