<template>
    <div>
        <body>
          <header>
            <headerBar id="headerBarId" />
          </header>
          <div class=gridHolder>
            <main id="propertyTileId">
              <div v-for="property in getProperties" v-bind:key="property.propertyId">
                <propertyTile v-bind:property="property" />
                <propTransactions v-bind:property="property" id="propTransactions" />
              </div>
            </main>
          </div>
          <button class="showPayments" v-on:click='showNewRentalForm === false ? showNewRentalForm = true : showNewRentalForm = false'>Show/Hide New Rental Form</button>
          <form class="newRentalForm" v-if='showNewRentalForm'>
            <h2>Add a rental</h2>
            <input id="rentalTitle" type="text" placeholder="Title" required>
            <div class="addressForm">
              <div>
                <input type="number" placeholder="Street Number" required>
                <input type="text" id="streetName" placeholder="Street Name" required>
                <input type="text" placeholder="Unit Number">
              </div>
              <div>
                <input type="text" placeholder="State Abbreviated" pattern="[A-Za-z]{2}" required>
                <input type="text" placeholder="City" required>
                <input type="text" id="county" placeholder="County">
                <input type="text" placeholder="Zip Code" required>
              </div>
            </div>
            <div class="bedAndBaths">
              <input type="text" placeholder="Rent Amount" required>
              <input type="number" placeholder="Number of Beds" required>
              <input type="number" placeholder="Number of Baths" required>
              <input type="number" placeholder="Square Footage">
            </div>
            <div class="inputPictures">
                <input type="text" placeholder="Picture Url 1" required>
                <input type="text" class="photoDescLL" placeholder="Photo Description 1">
                <input type="text" placeholder="Picture Url 2">
                <input type="text" class="photoDescLL" placeholder="Photo Description 2">
            </div>
            <div class="inputPictures">
                <input type="text" placeholder="Picture Url 3">
                <input type="text" class="photoDescLL" placeholder="Photo Description 3">
                <input type="text" placeholder="Picture Url 4">
                <input type="text" class="photoDescLL" placeholder="Photo Description 4">
            </div>
            <input type="date" placeholder="Available Date">
            <textarea class="textBox" name="description" placeholder="Property description"></textarea>
            <div class="formBtns">
              <div>
              <select name="propType" class="dropDownInput" required>
                <option selected="House" value="House">House</option>
                <option value="Apartment">Apartment</option>
                <option value="Apartment">Townhome</option>
                <option value="Apartment">Condo</option>
              </select>
              <select name="petsAllowed" class="dropDownInput" required>
                <option selected="noPets" value="0">No pets</option>
                <option value="pets">Pets Allowed</option>
              </select>
              </div>
              <input type="submit" class="submit" value="Add Rental"/> 
            </div>             
          </form>
        </body>
    </div>
</template>

<script>
import headerBar from '@/components/headerBar.vue';
import propertyTile from '@/components/propertyTile.vue';
//import propTransactions from '@/components/propTransactions.vue';
import LandlordService from '@/services/LandlordService.js';

export default {
  components: {
    headerBar,
    propertyTile,
    //propTransactions
  },
    data() {
    return {
      showNewRentalForm: false,
    }
  },
  created() {
    LandlordService.getPropertyList().then((response) => {
      this.$store.commit("SET_LANDLORD_PROPERTIES", response.data);
    })
    this.refresh();
  },
  computed: {
    getProperties() {
      return this.$store.state.landlordPropertiesList;
    },
  },
  methods: {
    refresh() {
    if(!window.location.hash) {
        window.location = window.location + '#loaded';
        window.location.reload();
    }
  }
  }
}
</script>

<style>
#headerBarId {
  left: 0rem;
}

#propTransactions{
  margin-top: 8rem; 
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

</style>