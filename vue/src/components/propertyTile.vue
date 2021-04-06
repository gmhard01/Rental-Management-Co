<template>
  <div class="grid-border">
    <body class=gridHolder>
      <div class="grid">
        <div class="gridItem">
          <div class="card">
            <img class="cardImg" src="@/assets/rmc.png" alt="Property Picture" />
            <div class="titleAndDetails">
              <h1 class="cardHeader">Title of Card</h1>
              <p class="cardDetails">
                This is where the card details will go
              </p>
            </div>
              <ul>
                <li>Price: </li>
                <li>Address: </li>
                <li>Bedrooms: </li>
                <li>Bathrooms: </li>
                <li>Contact Landlord: </li>
              </ul>
          </div>  
        </div>
      </div>
      <div class="grid">
        <div class="gridItem">
          <div class="card">
            <img class="cardImg" src="@/assets/rmc.png" alt="Property Picture" />
            <div class="titleAndDetails">
              <h1 class="cardHeader">Title of Card</h1>
              <p class="cardDetails">
                This is where the card details will go
              </p>
            </div>
              <ul>
                <li>Price: </li>
                <li>Address: </li>
                <li>Bedrooms: </li>
                <li>Bathrooms: </li>
                <li>Contact Landlord: </li>
              </ul>
          </div>  
        </div>
      </div>
      <!--<h1>{{property.title}}</h1>
      <p>{{property.address}}</p>
      <span><img v-bind:src='property.picture' alt="Picture of current property listing" /></span>
      <span>
        <ul>
          <li>{{property.price}}</li>
          <li>{{property.numBedrooms}}</li>
          <li>{{property.details}}</li>
          <li>{{property.phone}}</li>      
        </ul>
      </span>-->
    </body>
  </div>
</template>

<script>
/*import PropService from '../services/PropService.js';*/

export default {
    name: "propertyTile",
    props: ['propertyId'],
    data() {
      return {
        property: {
          title: '',
          address: '',
          price: 0,
          numBedrooms: 0,
          details: '',
          phone: '',
          picture: ''
        }
      }
    },
  /*created(){
    PropService.getProperty(parseInt(this.propertyId)).then( (response) => {
        this.property.title = response.data.title;
        this.property.address = response.data.address;
        this.property.price = parseInt(response.data.price);
        this.property.numBedrooms = parseInt(response.data.numBedrooms);
        this.property.details = response.data.details;
        this.property.phone = response.data.phone;
        this.property.picture = response.data.picture;
      })
    }*/
  }
</script>

<style>

.cardImg {
  display: block;
  width: 25rem;
  height: 20rem;
  object-fit: cover;
}

.card {
  display: flex;
  align-items: center;
}

.gridHolder {
  font-family: "Oswald", "Arial", "Helvetica", "sans-serif";
  display: flex;
  color: #808080;
  flex-direction: column;
  padding: 0rem;
  min-height: 100vh;
}

.gridItem {
  background-color: #fff;
  border-radius: 0.4rem;
  overflow: hidden;
  box-shadow: 0 3rem 6rem rgba(0, 0, 0, 0.589);
  cursor: pointer;
  transition: 0.2s;
  margin-bottom: .5rem;
}

.titleAndDetails {
  padding: 3rem;
}
/*
.grid-border {
  box-sizing: border-box;
  font-size: 62.5%;
  margin: 0;
  padding: 0;
}

.gridHolder {
  background-color: #eee;
  font-family: "Oswald", "Arial", "Helvetica", "sans-serif";
  display: flex;
  flex-direction: row;
  justify-content: center;
  align-items: center;
  min-height: 100vh;
}

.grid {
  display: grid;
  width: 144em;
  grid-gap: 6rem;
  grid-template-columns: repeat(auto-fit, minmax(20rem, 1fr));
  align-items: start;
}

.gridItem {
  background-color: #fff;
  border-radius: 0.4rem;
  overflow: hidden;
  box-shadow: 0 3rem 6rem rgba(0, 0, 0, 0.1);
  cursor: pointer;
  transition: 0.2s;
}

.gridItem:hover {
  transform: translateY(-.05%);
  box-shadow: 0 4rem 8rem rgba(0, 0, 0, 0.5);
}

.card-img {
  display: block;
  width: 100%;
  height: 20rem;
  object-fit: cover;
}

.titleAndDetails {
  padding: 3rem;
}

.cardHeader{
  font-size: 3rem;
  font-weight: 500;
  color: #0d0d0d;
  margin-bottom: 1.5rem;
}

.cardDetails {
  font-size: 1.6rem;
  letter-spacing: 0.1rem;
  line-height: 1.7;
  color: #3d3d3d;
  margin-bottom: 2.5rem;
}

@media only screen and (max-width: 60em) {
  body {
    padding: 3rem;
  }

  .grid {
    grid-gap: 3rem;
  }
}*/
</style>