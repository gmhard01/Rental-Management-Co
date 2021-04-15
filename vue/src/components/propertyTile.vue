<template>
  <div class="grid-border">
    <body class=gridHolder>
      <div class="grid">
        <div class="gridItem">
          <div class="card">
            <!-- <img class="cardImg" v-bind:src="property.picture[1]" alt="Property Picture" /> -->
            <div id="pictureAndBtns">
              <div class="cardImg" v-if="pictureNumb==1">
                <img class="propImgs" v-bind:src="property.picture[1]">
                <div class="photoDesc">{{property.picture[2]}}</div>
                <div class="directionalBtns">
                  <a class="prev" v-on:click="prevImg()">&#10094;</a>
                  <a class="next" v-on:click="nextImg()">&#10095;</a>
                </div>
              </div>
              <div class="cardImg" v-if="pictureNumb==2">
                <img class="propImgs" v-bind:src="property.picture[3]">
                <div class="photoDesc">{{property.picture[4]}}</div>
                <div class="directionalBtns">
                  <a class="prev" v-on:click="prevImg()">&#10094;</a>
                  <a class="next" v-on:click="nextImg()">&#10095;</a>
                </div>
              </div>
              <div class="cardImg" v-if="pictureNumb==3">
                <img class="propImgs" v-bind:src="property.picture[5]">
                <div class="photoDesc">{{property.picture[6]}}</div>
                <div class="directionalBtns">
                  <a class="prev" v-on:click="prevImg()">&#10094;</a>
                  <a class="next" v-on:click="nextImg()">&#10095;</a>
                </div>
              </div>
              <div class="cardImg" v-if="pictureNumb==4">
                <img class="propImgs" v-bind:src="property.picture[7]">
                <div class="photoDesc">{{property.picture[8]}}</div>
                <div class="directionalBtns">
                  <a class="prev" v-on:click="prevImg()">&#10094;</a>
                  <a class="next" v-on:click="nextImg()">&#10095;</a>
                </div>
              </div>
            </div>
            <div class="titleAndDetails">
              <div id="topRow">
                <p v-if="Date.now() < Date.parse(property.availableDate)">{{property.propertyType}} available {{property.availableDate.slice(5,10)}}-{{property.availableDate.slice(0,4)}}</p>
                <p v-else>{{property.propertyType}} available now</p>
                <img class="alertImg" src="@/assets/Alert-Free-PNG-Image.png" alt="Company Logo" v-if="1==2"/>
              </div>
              <h1 class="cardHeader">{{property.title}}</h1>
              <p>{{property.streetNumber}} {{property.streetName}} {{property.city}} {{property.state}} {{property.zipCode}}</p>
              <p class="cardDetails">
                {{property.propertyDescription}}
              </p>
              <ul class="detailsList">
                <li>${{parseFloat(property.rentAmount).toFixed(2)}} </li>
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
        pictureNumb: 1
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
    },
    methods: {
      nextImg() {
        if(this.pictureNumb==4){
          this.pictureNumb=1;
        }
        else {
          this.pictureNumb+=1;
        }
      },
      prevImg() {
        if(this.pictureNumb==1){
          this.pictureNumb=4;
        }
        else {
          this.pictureNumb-=1;
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

.cardImg, .propImgs {
  display: block;
  width: 25rem;
  min-width: 25rem;
  height: 25rem;
  margin-left: 0;
  object-fit: cover;
}

.alertImg{
  width: 4rem;
  height: 4rem;
}

#topRow{
  display: flex;
  flex-direction: row;
  justify-content: space-between;
  min-width: 100%;
}

.photoDesc{
  display: flex;
  justify-content: center;
  margin-top: -5rem;
  color: rgb(255, 255, 255);
  font-weight: bold;
  font-size: 1.5rem;
  text-shadow: 2px 2px #525252;
}
.titleAndDetails {
  padding: 2rem;
  width: 100%;
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

.next {
  border-radius: 3px 0 0 3px;
  right: 0;
}

.prev, .next {
  cursor: pointer;
  width: auto;
  padding: 16px;
  color: white;
  font-weight: bold;
  font-size: 18px;
  transition: 0.6s ease;
  border-radius: 0 3px 3px 0;
  user-select: none;
  margin-top: -11rem;
  height: 1.8rem;
}
.directionalBtns{
  display:flex;
  justify-content: space-between;
  padding-top: -5rem;
}
.prev:hover, .next:hover {
  background-color: rgba(0,0,0,0.8);
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