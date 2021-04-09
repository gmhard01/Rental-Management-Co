<template>
<div>
  <body>
    <header>
      <headerBar id="headerBarId" />
    </header>
    <div>
      <form class="applicationBox" @submit.prevent="apply()">
        <h1>Application Form</h1>
        <input type="text" name="" placeholder="Legal First Name" required v-model="applicationForm.applicantFirstName" autofocus>
        <input type="text" name="" placeholder="Legal Last Name" required v-model="applicationForm.applicantLastName" autofocus>
        <input type="tel" id="phoneNumber" name="" placeholder="Phone Number" required v-model="applicationForm.applicantPhone" autofocus>
        <input type="submit" class="submit" name="" value="Submit">
      </form>
    </div>
  </body>
</div>
</template>

<script>

import headerBar from '@/components/headerBar.vue';
import PropService from '@/services/PropService';

export default {
name: "rentalProperty",
data() {
  return {
    hasApplied: "false",
    formNotExcepted: "false",
    errorResponse: "",
    applicationForm: {
      applicantId: this.$store.state.user.userId,
      propertyId: this.$route.params.propertyId,
      approvalStatus: "pending",
      applicantFirstName: "",
      applicantLastName: "",
      applicantPhone: ""
    }    
  }
},
methods: {
  apply() {    
    this.errorResponse = "you have hit submit";
    PropService.submitApplication(this.applicationForm).then(response => {
      if(response.error === null){
        this.hasApplied = true;
      }
      else {
        this.formNotExcepted = true;
      }
    })
    .catch((error) => {
          // const response = error.response;
              this.formNotExcepted = true;
              this.errorResponse = error;
          // if (error.response.status >= 400) {
          //   this.formNotExcepted = true;
          // }
          // else{
          //   this.formNotExcepted = true;
          // }
        });
    this.applicationForm.firstName = "";
    this.applicationForm.lastName = "";
    this.applicationForm.phone = "";   
  }
},
components: {
    headerBar,
  },
}
</script>

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