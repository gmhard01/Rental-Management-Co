<template>
    <div class="applicationTile">
        <div class="leftApplication">
            <div>Applicant Name: {{application.applicantFirstName}} {{application.applicantLastName}}</div>
            <div>Phone: {{application.applicantPhone}}</div>
        </div>
        <div class="applicationBtns">
            <button id="approve" v-on:click="approveApplication()">Approve</button>
            <button id="decline" v-on:click="declineApplication()">Decline</button>
        </div>
    </div>
</template>

<script>
import LandlordService from '../services/LandlordService.js';

export default {
    name: "applicationTile",
    props: ["application"],
    methods: {
        approveApplication() {
            this.$store.commit('LANDLORD_APPROVE_APPLICATION', this.application.applicationId);
            LandlordService.updateApplicationApproveDecline(this.application);
        },
        declineApplication() {
            this.$store.commit('LANDLORD_DECLINE_APPLICATION', this.application.applicationId);
            LandlordService.updateApplicationApproveDecline(this.application);
        },
    }
}
</script>

<style>
.applicationTile{
  margin-top: .2rem;
  background-color: #fff;
  border-radius: 1.5rem;
  overflow: hidden;
  box-shadow: 0 3rem 6rem rgba(0, 0, 0, 0.589);
  margin-bottom: .5rem;
  padding: 20px;
  display: flex;
  flex-direction: row;
  justify-content: space-between;
  align-items: center;
  font-family: "Oswald", "Arial", "Helvetica", "sans-serif";
}

.leftApplication{
    display: flex;
    flex-direction: row;
    justify-content: space-between;
    align-items: center;
    margin: 1rem;
    min-width: 45rem;
    font-size: 1.8rem;
}
.applicationBtns{
    display: flex;
    flex-direction: row;
    justify-content: space-between;
    align-items: center;
    min-width: 20rem;
}

#approve, #decline{
    height: 3rem;
    font-size: 2rem;
    border-radius: 1rem;
}
</style>