<template>
    <div class="applicationTile">
        <div class="leftApplication">
            <div>Applicant Name: {{application.applicantFirstName}} {{application.applicantLastName}}</div>
            <div>Phone: {{application.applicantPhone}}</div>
        </div>
        <div class="applicationBtns">
            <button v-on:click="approveApplication()">Approve</button>
            <button v-on:click="declineApplication()">Decline</button>
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
  align-items: center;
  font-family: "Oswald", "Arial", "Helvetica", "sans-serif";
}

.leftApplication{
    display: flex;
    flex-direction: column;
    justify-content: space-around;
    align-items: center;
}
.applicationBtns{
    display: flex;
    flex-direction: column;
    justify-content: space-around;
    align-items: center;
}
</style>