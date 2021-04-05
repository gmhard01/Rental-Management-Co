<template>
  <div>
      Property Tile Text
      <h1>{{property.title}}</h1>
      <p>{{property.address}}</p>
      <span><img v-bind:src='property.picture' alt="Picture of current property listing" /></span>
      <span>
        <ul>
          <li>{{property.price}}</li>
          <li>{{property.numBedrooms}}</li>
          <li>{{property.details}}</li>
          <li>{{property.phone}}</li>      
        </ul>
      </span>
  </div>
</template>

<script>
import PropService from '../services/PropService.js';

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
created(){
  PropService.getProperty(parseInt(this.propertyId)).then( (response) => {
      this.property.title = response.data.title;
      this.property.address = response.data.address;
      this.property.price = parseInt(response.data.price);
      this.property.numBedrooms = parseInt(response.data.numBedrooms);
      this.property.details = response.data.details;
      this.property.phone = response.data.phone;
      this.property.picture = response.data.picture;
    })
  }
}
</script>

<style>

</style>