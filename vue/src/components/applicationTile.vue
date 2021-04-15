<template>
    <div>
        <div class="applicationTile" v-if="showElements==0">
            <div class="leftApplication">
                <div>Applicant Name: {{application.applicantFirstName}} {{application.applicantLastName}}</div>
                <div>Phone: {{application.applicantPhone}}</div>
            </div>
            <div class="applicationBtns">
                <button id="approve" v-on:click="approveApplication()">Approve</button>
                <button id="decline" v-on:click="declineApplication()">Decline</button>
            </div>
        </div>
        <div class="applicationTile" v-if="showElements==1">
            <div class="leftApplication">
                <div>Applicant Name: {{application.applicantFirstName}} {{application.applicantLastName}} has been approved</div>
            </div>
        </div>
        <div class="applicationTile" v-if="showElements==2">
            <div class="leftApplication">
                <div>Applicant Name: {{application.applicantFirstName}} {{application.applicantLastName}} has been denied</div>
            </div>
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
            this.populateLeaseDetails();
            LandlordService.createLease(this.lease).then((response) => {
                this.lease.leaseId = response.data.leaseId;
                LandlordService.createPaySched(this.lease);
            })
            this.showElements=1;
        },
        declineApplication() {
            this.$store.commit('LANDLORD_DECLINE_APPLICATION', this.application.applicationId);
            LandlordService.updateApplicationApproveDecline(this.application);
            this.showElements=2;
        },
        populateLeaseDetails() {
            let date = new Date(Date.now());
            date.setMonth(date.getMonth() + 1);
            date.setDate(1);

            this.lease.propertyId = this.application.propertyId;
            this.lease.landlordId = this.$store.state.user.userId;
            this.lease.renterId = this.application.applicantId;
            this.lease.monthlyRent = this.$store.state.currentProperty.rentAmount;
            this.lease.leaseStartDate = date;
            this.lease.leaseTerm = 12;
        }
    },
    data() {
    return {
      showElements: 0,
      lease: {}
    }
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