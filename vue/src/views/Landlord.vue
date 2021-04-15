<template>
    <div>
        <body>
          <header>
            <headerBar id="headerBarId" />
          </header>
          <div class=gridHolder>
            <main id="propertyTileId">
              <div v-for="property in slicedArray" v-bind:key="property.propertyId" v-on:click="goToProperty(property)">
                <propertyTile v-bind:property="property" />
              </div>
            </main>
          </div>
          <button class="showPayments" v-on:click='showNewRentalForm === false ? showNewRentalForm = true : showNewRentalForm = false'>Show/Hide New Rental Form</button>
          <form class="newRentalForm" v-if='showNewRentalForm' @submit.prevent="addProperty">
            <h2>Add a rental</h2>
            <input id="rentalTitle" type="text" placeholder="Title" v-model="newProperty.title" required>
            <div class="addressForm">
              <div>
                <input type="number" placeholder="Street Number" v-model="newProperty.streetNumber" required>
                <input type="text" id="streetName" placeholder="Street Name" v-model="newProperty.streetName" required>
                <input type="text" placeholder="Unit Number" v-model="newProperty.unitNumber">
              </div>
              <div>
                <input type="text" placeholder="State Abbreviated" pattern="[A-Za-z]{2}" v-model="newProperty.state" required>
                <input type="text" placeholder="City" v-model="newProperty.city" required>
                <input type="text" id="county" placeholder="County" v-model="newProperty.county">
                <input type="text" placeholder="Zip Code" v-model="newProperty.zipCode" required>
              </div>
            </div>
            <div class="bedAndBaths">
              <input type="text" placeholder="Rent Amount" v-model="newProperty.rentAmount" required>
              <input type="number" placeholder="Number of Beds" v-model="newProperty.numberOfBeds" required>
              <input type="number" placeholder="Number of Baths" v-model="newProperty.numberOfBaths" required>
              <input type="number" placeholder="Square Footage" v-model="newProperty.squareFeet">
            </div>
            <div class="inputPictures">
                <input type="text" placeholder="Picture Url 1" v-model="newProperty.picture[0]" required>
                <input type="text" class="photoDescLL" placeholder="Photo Description 1" v-model="newProperty.picture[1]">
                <input type="text" placeholder="Picture Url 2" v-model="newProperty.picture[2]">
                <input type="text" class="photoDescLL" placeholder="Photo Description 2" v-model="newProperty.picture[3]">
            </div>
            <div class="inputPictures">
                <input type="text" placeholder="Picture Url 3" v-model="newProperty.picture[4]">
                <input type="text" class="photoDescLL" placeholder="Photo Description 3" v-model="newProperty.picture[5]">
                <input type="text" placeholder="Picture Url 4" v-model="newProperty.picture[6]">
                <input type="text" class="photoDescLL" placeholder="Photo Description 4" v-model="newProperty.picture[7]">
            </div>
            <input type="date" placeholder="Available Date" v-model="newProperty.availableDate">
            <textarea class="textBox" name="description" placeholder="Property description" v-model="newProperty.propertyDescription"></textarea>
            <div class="formBtns">
              <div>
              <select name="propType" class="dropDownInput" v-model="newProperty.propertyType" required>
                <option selected="House" value="House">House</option>
                <option value="Apartment">Apartment</option>
                <option value="Apartment">Townhome</option>
                <option value="Apartment">Condo</option>
              </select>
              <select name="petsAllowed" class="dropDownInput" v-model="newProperty.petsAllowed" required>
                <option selected="noPets" value="0">No pets</option>
                <option value="pets">Pets Allowed</option>
              </select>
              </div>
              <input type="submit" class="submit" value="Add Rental"/> 
            </div>             
          </form>
          <div class="arrowBar">
              <img src="@/assets/RightArrow.png" alt="Next Arrow" class="ArrowBtn" v-on:click="next()" />
          </div>
        </body>
    </div>
</template>

<script>
import headerBar from '@/components/headerBar.vue';
import propertyTile from '@/components/propertyTile.vue';
import LandlordService from '@/services/LandlordService.js';

export default {
  name: "landlord",
  data() {
    return {
      startingTileIndex: 0,
      tileIncrementNum: 5,      
      showNewRentalForm: false,
      newProperty: {
        title: "",
        rentAmount: "",
        numberOfBeds: "",
        numberOfBaths: "",
        picture: [],
        available: false,
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
        // contactPhone: "",
        // contactEmail: "",
      },
    }
  },
  components: {
    headerBar,
    propertyTile,
  },
  created() {
    LandlordService.getPropertyList().then((response) => {
      this.$store.commit("SET_LANDLORD_PROPERTIES", response.data);
    })
    this.removeCurrentPropertyFromStore();
    // this.refresh();
  },
  computed: {
    getProperties() {
      return this.$store.state.landlordPropertiesList;
    },
    slicedArray(){
      let previousIndex = 0;
      let newIndex = this.tileIncrementNum;
      
      if (this.getProperties.length <= newIndex){
        newIndex = this.getProperties.length;
      }

      if (this.getProperties.length <= previousIndex){
        previousIndex = 0;
        newIndex = 1;
      }

      return this.getProperties.slice(previousIndex, newIndex);
    },
  },
  methods: {
    addProperty() {
      return LandlordService.addProperty(this.newProperty);
    },
    refresh() {
    if(!window.location.hash) {
        window.location = window.location + '#loaded';
        window.location.reload();
    }
  },
  next(indexNum = 0){
      let startingTileIndex = indexNum + 1;
      this.$router.push({name: "my-properties", params: {page: startingTileIndex}});
      this.saveCurrentSearchIndex();
      window.scrollTo(0, 0);      
    },
    previous(){
      this.startingTileIndex -=15;
      this.getCurrentListing(this.startingTileIndex);
    },
    saveCurrentSearchIndex(){
      this.$store.commit("SAVE_CURRENT_SEARCH_INDEX", this.getCurrentRoute);
    },
    goToProperty(currentProperty){
      this.$router.push({name: "property-transactions", params: {propertyId: currentProperty.propertyId}});
    },
    removeCurrentPropertyFromStore() {
      this.$store.commit("REMOVE_DATA_FOR_CURRENT_LANDLORD_PROPERTY_FROM_STORE");
    },
  },
}
</script>

<style>
#headerBarId {
  left: 0rem;
}

#propTransactions{
  margin-top: 8rem; 
}

.ArrowBtn {
  width: 5rem;
  display: block;
  padding-top: 1rem;
  margin-left: auto;
  margin-right: auto;
  cursor: pointer;
  opacity: 0.3;
}

.ArrowBtn:hover {
  opacity: 1.0;
  transition: 1s;
}

.newRentalForm{
  margin-top: .2rem;
  background-color: #fff;
  border-radius: 1.5rem;
  overflow: hidden;
  box-shadow: 0 3rem 6rem rgba(0, 0, 0, 0.589);
  margin-bottom: .5rem;
  padding: 20px;
  display: flex;
  flex-direction: column;
  align-items: left;
  font-family: "Oswald", "Arial", "Helvetica", "sans-serif";
}

.formBtns, .InputPictures{
  display: flex;
  flex-direction: row;
  justify-content: space-between;

}

.newRentalForm input[type = "text"], .newRentalForm input[type = "number"], .newRentalForm input[type = "date"], .newRentalForm textarea, .dropDownInput{
  border-radius: 1rem;
  text-align: center;
  border-color:rgba(145, 145, 145, 0.281);
  border-width: 2px;
  margin: .5rem;
  font-size: 1rem;
}
.newRentalForm input[type = "text"], .newRentalForm input[type = "number"], .newRentalForm input[type = "date"], .dropDownInput{
  width: 8rem;
}
#rentalTitle{
  width: 16rem;
  font-size: 1.5rem;
}

.inputPictures input[type = "text"]{
  width: 10rem;
}

#streetName, #county{
  width: 13rem;
}

@media only screen and (max-width: 60em){
 .ArrowBtn {
   width: 3rem;
   padding-top: .5rem;
 } 
}
</style>