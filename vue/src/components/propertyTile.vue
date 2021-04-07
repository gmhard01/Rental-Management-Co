<template>
  <div class="grid-border">
    <body class=gridHolder>
      <div class="grid">
        <div class="gridItem">
          <div class="card">
            <img class="cardImg" v-bind:src="imageGiven" alt="Property Picture" />
            <div class="titleAndDetails">
              <p>{{property.availableDate}}</p>
              <h1 class="cardHeader">{{property.title}}</h1>
              <p>{{address}}</p>
              <p class="cardDetails">
                {{property.propertyDescription}}
              </p>
              <ul>
                <li>${{property.rentAmount}} </li>
                <li>{{property.numberOfBeds}} Bedroom<span>s</span></li>
                <li>{{property.numberOfBaths}} Bathroom<span>s</span></li>
                <li>555-555-5555</li>
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
}

.cardImg {
  display: block;
  width: 25rem;
  height: 25rem;
  object-fit: cover;
}

.titleAndDetails {
  padding: 2rem;
}

.cardHeader{
  font-size: 2rem;
  font-weight: bold;
  color: #0d0d0d;
  margin-top: 0;
  margin-bottom: 1rem;
}

ul {
  margin: 0;
  padding-left: 0px;
  list-style-type: none;
}
li{
  margin-bottom: .3rem;
}

.cardDetails {
     max-height: 3rem;
     overflow: hidden;
}
@media only screen and (max-width: 60em){
.cardImg {
  width: 10rem;
  height: 13rem;
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
     overflow: hidden;
     text-overflow: ellipsis;
}

.titleAndDetails{
  padding: .5rem;
  padding-left: 1rem;
  padding-right: .8rem;
}

li{
  margin-bottom: .1rem;
}
}
</style>