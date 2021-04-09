<template>
<div>
  <body>
    <header>
      <headerBar id="headerBarId" />
    </header>
    <div>
      <propertyTile />
    </div>
    <div>
    <form class="applicationBox" @submit.prevent="apply">
      <h1>Application Form</h1>
      <input type="text" name="" placeholder="First Name" required v-model="applicationForm.firstName" autofocus>
      <input type="text" name="" placeholder="Last Name" required v-model="applicationForm.lastName" autofocus>
      <input type="tel" id="phoneNumber" name="" placeholder="Phone Number" required v-model="applicationForm.phone" autofocus>
      <input type="submit" class="submit" name="" value="Submit">
    </form>
    </div>
  </body>
</div>
</template>

<script>

import headerBar from '@/components/headerBar.vue';
import propertyTile from '@/components/propertyTile.vue';
import PropService from '@/services/PropService';

export default {
name: "rentalProperty",
data() {
  return {
    hasApplied: "false",
    applicationForm: {
      applicantId: this.$store.state.user.userId,
      propertyId: this.$route.params.propertyId,
      approvalStatus: "pending",
      firstName: "",
      lastName: "",
      phone: ""
    }    
  }
},
methods: {
  apply() {
    this.applicationForm.firstName = "";
    this.applicationForm.lastName = "";
    this.applicationForm.phone = "";
    this.hasApplied = PropService.submitApplication(this.applicationForm);    
  }
},
components: {
    headerBar,
    propertyTile
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