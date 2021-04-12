<template>
  <div class="grid-border">
    <body class=gridHolder>
      <div class="grid">
        <div class="gridItem">
          <div class="card">
            <img class="cardImg" v-bind:src="imageGiven" alt="Property Picture" />
            <div class="titleAndDetails">
              <p v-if="Date.now() < Date.parse(property.availableDate)">{{property.propertyType}} available {{property.availableDate.slice(5,10)}}-{{property.availableDate.slice(0,4)}}</p>
              <p v-else>{{property.propertyType}} available now</p>
              <h1 class="cardHeader">{{property.title}}</h1>
              <p>{{address}} {{property.zipCode}}</p>
              <p class="cardDetails">
                {{property.propertyDescription}}
              </p>
              <ul class="detailsList">
                <li>${{property.rentAmount}} </li>
                <li>{{property.numberOfBeds}} Bedroom<span v-if="property.numberOfBeds>1">s</span></li>
                <li>{{property.numberOfBaths}} Bathroom<span v-if="property.numberOfBaths>1">s</span></li>
                <li v-if="property.petsAllowed">Pets allowed</li>
                <li v-else>No pets</li>
                <li>{{property.contactPhone}}</li>
                <li>{{property.contactEmail}}</li>
              </ul>
            </div>
          </div>  
        </div>
      </div>
    </body>
  </div>
</template>

<script>

export default {
    name: "propertyTile",
    props: ['property'],
    data() {
      return {
        address: `${this.property.streetNumber} ${this.property.streetName} ${this.property.city} ${this.property.state}`,
      }
      },
    computed: {
      propertyobject() {
        return this.$store.state.properties.find((property) => {property.propertyId == this.propertyTile})
        },
      imageGiven() {
        if(this.property.picture == ""){
          return require("@/assets/No_Image_Available.jpg");
        }
        else{
          return this.property.picture;
        }
      }
    }
  }
</script>

<style>

.card {
  display: flex;
  align-items: center;
  height: 19rem;
}

.gridItem {
  background-color: #fff;
  border-radius: 1.5rem;
  overflow: hidden;
  box-shadow: 0 3rem 6rem rgba(0, 0, 0, 0.589);
  cursor: pointer;
  margin-bottom: .5rem;
  font-family: "Oswald", "Arial", "Helvetica", "sans-serif";
}

.cardImg {
  display: block;
  width: 25rem;
  min-width: 25rem;
  height: 25rem;
  object-fit: cover;
}

.titleAndDetails {
  padding: 2rem;
}

.cardHeader{
  padding-left: 0;
  font-size: 2rem;
  font-weight: bold;
  color: #0d0d0d;
  margin-top: 0;
  margin-bottom: 1rem;
}

.detailsList {
  margin: 0;
  padding-left: 0px;
  list-style-type: none;
  height: 5rem;
  display: flex;
  flex-direction: column;
  flex-wrap: wrap;
}

li{
  margin-bottom: .3rem;
}

.cardDetails {
  max-height: 4.3rem;
  text-overflow: ellipsis;
  overflow: auto;
}

.cardDetails::-webkit-scrollbar {
  border-radius: 1rem;
  background: rgba(182, 203, 236, 0.493);
}

@media only screen and (max-width: 60em){
.cardImg {
  width: 10rem;
  height: 13rem;
  min-width: 10rem;
}

.card {
  display: flex;
  align-items: center;
  height: 13rem;
}

.gridHolder {
  font-size: .5rem;
}

.cardHeader{
  font-size: .65rem;
  margin-bottom: .1rem;
}

.cardDetails {
     max-height: 5rem;
}

.titleAndDetails{
  padding: .5rem;
  padding-left: 1rem;
  padding-right: .8rem;
  width: 8.5rem;
}

.detailsList {
  height: 2.5rem;
  width: 10rem;
  display: flex;
  flex-direction: column;
  flex-wrap: wrap;
}

li{
  margin-bottom: .1rem;
}
}
</style>