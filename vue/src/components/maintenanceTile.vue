<template>
    <div>
        <div class="maintenanceTile" v-if="!showMaintSuccess">
            <div class="clientInfo">
                <div>Client Name: {{$attrs.request.requesterFirstName}} {{$attrs.request.requesterLastName}}</div>
                <div>Client Phone: {{$attrs.request.requesterPhone}}</div>
            </div>
            <div class="maintDetails">
                <div>Description: {{$attrs.request.details}}</div>
                <div>Status: {{$attrs.request.requestStatus}}</div>
            </div>
            <div v-if="this.$store.state.user.role=='Maintenance'" class="btn">
                <input type="submit" class="submit" name="" value="Complete" v-on:click="showMaintSuccess=true">
            </div>
            <div v-if="this.$store.state.user.role=='Landlord'" class="landlordInputs">
                <input v-model="maintWorkerId" type="text" id="maintenanceUserName" class="assignWorker" placeholder="Maintenance UserID" />
                <input v-show="$attrs.request.requestStatus === 'New'" v-on:click="assignMaintReq" type="button" class="submitUser" name="" value="Assign">
                <input v-show="$attrs.request.requestStatus === 'In Progress'" v-on:click="assignMaintReq" type="button" class="submitUser" name="" value="Re-Assign">
            </div>
        </div>
        <div v-else id="payForm" class="paymentPopup">
          <h1>Submitted Request</h1>
          <button v-on:click='showMaintSuccess = false'>Close</button>
        </div>
    </div>
</template>

<script>
import LandlordService from '@/services/LandlordService.js';

export default {
    name: "maintenanceTile",
    props: ['requests'],
    methods: {
        assignMaintReq() {
            this.$attrs.request.maintenanceWorkerId = parseInt(this.maintWorkerId);
            LandlordService.updateMaintReqWorker(this.$attrs.request);
            this.showMaintSuccess=true;
        }
    },
    data() {
        return {
            maintWorkerId: "",
            showMaintSuccess: false
        }
    }
}
</script>

<style>
.maintenanceTile{
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
  justify-content: space-between;
  font-family: "Oswald", "Arial", "Helvetica", "sans-serif";
}

.clientInfo{
    min-width: 28rem;
    display: flex;
    flex-direction: row;
    justify-content: space-between;
}

.landlordInputs{
    display: flex;
    flex-direction: column;
    align-items: center;
}

.submitUser{
    background-color:rgb(182, 204, 236);
    border-radius: 1rem;
    height: 2rem;
    width: 7rem;
    font-size: 1rem;
}

.assignWorker{
    border-radius: .5rem;
    border-color: rgba(128, 128, 128, 0.377);
    font-size: 1.2rem;
    margin: .5rem;
}

.maintDetails{
    padding:2rem;
}
</style>