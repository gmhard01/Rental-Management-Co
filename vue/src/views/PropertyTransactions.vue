<template>
  <div>
    <body>
      <header>
        <headerBar id="headerBarId" />
      </header>
      <propertyTile v-bind:property="getPropertyObject" id="propertyTileId"/>
      <div v-if="this.$store.state.user.role=='Landlord'">
      <div v-show="checkForApplicationData">
        <div v-for="application in getApplicationsList" v-bind:key="application.applicationId">
          <applicationTile v-bind:application="application" />
        </div>
      </div>
      </div>
      <div v-show="checkForMaintenanceRequestData">
        <div v-for="request in getMaintenanceRequestList" v-bind:key="request.id">
          <maintenanceTile v-bind:request="request" />
        </div>
      </div>
      <div v-if="this.$store.state.user.role=='Landlord'">
      <div v-show="checkForTransactionData">
        <div v-for="transaction in getTransactionsList" v-bind:key="transaction.id">
          <transactionTile v-bind:transaction="transaction" />
        </div>
      </div>
        <button class="showPayments" v-on:click='showUpdateRentalForm === false ? showUpdateRentalForm = true : showUpdateRentalForm = false'>Show/Hide Update Rental Form</button>
        <form class="newRentalForm" v-if='showUpdateRentalForm' @submit.prevent="updatePropertyInServer">
        <h2>Update Rental Info</h2>
        <input id="rentalTitle" type="text" placeholder="Title" v-model="updateProperty.title" required>
        <div class="addressForm">
          <div>
            <input type="number" placeholder="Street Number" v-model="updateProperty.streetNumber" required>
            <input type="text" id="streetName" placeholder="Street Name" v-model="updateProperty.streetName" required>
            <input type="text" placeholder="Unit Number" v-model="updateProperty.unitNumber">
          </div>
          <div>
            <input type="text" placeholder="State Abbreviated" pattern="[A-Za-z]{2}" v-model="updateProperty.state" required>
            <input type="text" placeholder="City" v-model="updateProperty.city" required>
            <input type="text" id="county" placeholder="County" v-model="updateProperty.county">
            <input type="text" placeholder="Zip Code" v-model="updateProperty.zipCode" required>
          </div>
        </div>
        <div class="bedAndBaths">
          <input type="text" placeholder="Rent Amount" v-model="updateProperty.rentAmount" required>
          <input type="number" placeholder="Number of Beds" v-model="updateProperty.numberOfBeds" required>
          <input type="number" placeholder="Number of Baths" v-model="updateProperty.numberOfBaths" required>
          <input type="number" placeholder="Square Footage" v-model="updateProperty.squareFeet">
        </div>
        <div class="inputPictures">
            <input type="text" placeholder="Picture Url 1" v-model="updateProperty.picture[1]" required>
            <input type="text" class="photoDescLL" placeholder="Photo Description 1" v-model="updateProperty.picture[2]">
            <input type="text" placeholder="Picture Url 2" v-model="updateProperty.picture[3]">
            <input type="text" class="photoDescLL" placeholder="Photo Description 2" v-model="updateProperty.picture[4]">
        </div>
        <div class="inputPictures">
            <input type="text" placeholder="Picture Url 3" v-model="updateProperty.picture[5]">
            <input type="text" class="photoDescLL" placeholder="Photo Description 3" v-model="updateProperty.picture[6]">
            <input type="text" placeholder="Picture Url 4" v-model="updateProperty.picture[7]">
            <input type="text" class="photoDescLL" placeholder="Photo Description 4" v-model="updateProperty.picture[8]">
        </div>
        <div>Available Date<input type="date" placeholder="Available Date" v-model="updateProperty.availableDate"></div>
        <textarea class="textBox" name="description" placeholder="Property description" v-model="updateProperty.propertyDescription"></textarea>
        <div class="formBtns">
          <div>
          <select name="propType" class="dropDownInput" v-model="updateProperty.propertyType" required>
            <option selected="House" value="House">House</option>
            <option value="Apartment">Apartment</option>
            <option value="Townhome">Townhome</option>
            <option value="Condo">Condo</option>
          </select>
          <select name="petsAllowed" class="dropDownInput" v-model="updateProperty.petsAllowed" required>
            <option selected="noPets" value="0">No pets</option>
            <option value="1">Pets Allowed</option>
          </select>      
            <select name="Available" class="dropDownInput" v-model="updateProperty.available" required>
              <option selected="1" value="1">Acception Applications</option>
              <option value="0">Not Accepting Applications</option>
            </select>
          </div>
          <input type="submit" class="submit" value="Update Rental"/> 
        </div>             
      </form>
      </div>
    </body>
  </div>
</template>

<script>
import headerBar from '@/components/headerBar.vue';
import propertyTile from '@/components/propertyTile.vue';
import transactionTile from '@/components/transactionTile.vue';
import maintenanceTile from '@/components/maintenanceTile.vue';
import LandlordService from '@/services/LandlordService.js';
import applicationTile from '@/components/applicationTile.vue';
import PropService from '@/services/PropService';

export default {
  name: "propertytransactions",
  components: { 
      headerBar,
      propertyTile,
      transactionTile,
      maintenanceTile,
      applicationTile,
  },
  data() {
    return {
      showUpdateRentalForm: false,
      updateProperty: {
        title: "",
        rentAmount: "",
        numberOfBeds: "",
        numberOfBaths: "",
        picture: ["1", "", "", "", "", "", "", "", ""],
        available: 0,
        availableDate: "",
        propertyDescription: "",
        squareFeet: "",
        propertyType: "",
        petsAllowed: "",
        streetNumber: "",
        unitNumber: "",
        streetName: "",
        state: "",
        city: "",
        county: "",
        zipCode: "",
      },
    }
  },
   created() {
     PropService.getPropertyById(this.getCurrentPropertyId).then ((response) => {
        this.$store.commit("SET_PROPERTY", response.data);        
      });
     LandlordService.getMaintenanceRequestForProperty(this.getCurrentPropertyId).then((response) => {
       if (response.data.length > 0) {
        this.$store.commit("SET_LANDLORD_PROPERTY_MAINTENANCE", response.data);
       }
     });
     LandlordService.getTransactionsForProperty(this.getCurrentPropertyId).then((response) => {
       if (response.data.length > 0) {
        this.$store.commit("SET_LANDLORD_PROPERTY_TRANSACTIONS", response.data);
       }
     });
     LandlordService.getApplicationsForProperty(this.getCurrentPropertyId).then((response) => {
         if (response.data.length > 0) {
          this.$store.commit("SET_LANDLORD_PROPERTY_APPLICATIONS", response.data);
         }
     });
   },
   methods: {
     updatePropertyInServer() {
        this.updateProperty.rentAmount = parseFloat(this.updateProperty.rentAmount);
        this.updateProperty.numberOfBeds = parseInt(this.updateProperty.numberOfBeds);
        this.updateProperty.numberOfBaths = parseInt(this.updateProperty.numberOfBaths);
        this.updateProperty.squareFeet = parseInt(this.updateProperty.squareFeet);
        this.updateProperty.streetNumber = parseInt(this.updateProperty.streetNumber);
        this.updateProperty.petsAllowed = Boolean(this.updateProperty.petsAllowed);
        this.updateProperty.available = Boolean(this.updateProperty.available);
        LandlordService.updateProperty(this.updateProperty).then((response) => {
          if (response.status === 201) {
            this.refresh();
          }
        });
        
     },
     refresh() {
      if(!window.location.hash) {
          window.location = window.location + '#loaded';
          window.location.reload();
      }
    },
   },
   computed: {
     getCurrentPropertyId() {
      return this.$route.params.propertyId;
     },
     getPropertyObject() {
        return this.$store.state.currentProperty;
     },
     getMaintenanceRequestList() {
       return this.$store.state.landlordMaintenanceRequestForProperty;
     },
     getTransactionsList() {
       return this.$store.state.landlordTransactionsForProperty;
     },
     getApplicationsList() {
       return this.$store.state.landlordApplicationsForProperty;
     },
     checkForApplicationData() {
       let output = false;
       if (this.$store.landlordApplicationsForProperty != {}) {
         output = true;
       }
       return output;
     },
     checkForTransactionData() {
       let output = false;
       if (this.$store.landlordTransactionsForProperty != {}) {
         output = true;
       }
       return output;
     },
     checkForMaintenanceRequestData() {
       let output = false;
       if (this.$store.landlordMaintenanceRequestForProperty != {}) {
         output = true;
       }
       return output;
     },
   },
}
</script>

<style>
#propertyTileId {
  margin-top: 8rem; 
}
</style>