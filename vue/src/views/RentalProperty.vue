<template>
<div>
  <body>
    <header>
      <headerBar id="headerBarId" />
    </header>
    <div class="picture-container">
      <div class="rental-details">
        <div class="pictures">
          <div class="mySlides fade">
            <img src="@/assets/rmc.png">
          </div>
          <div class="mySlides fade">
            <img src="@/assets/rmc.png">
          </div>        
          <div class="mySlides fade">
            <img src="@/assets/rmc.png">
          </div>
          <a class="prev" onclick="plusSlides(-1)"></a>
          <a class="next" onclick="plusSlides(1)"></a>
        </div>
      </div>
    </div>
    <div>
      <form class="applicationBox" @submit.prevent="apply()">
        <h1>Application Form</h1>
        <input type="text" name="" placeholder="Legal First Name" required v-model="applicationForm.applicantFirstName" autofocus>
        <input type="text" name="" placeholder="Legal Last Name" required v-model="applicationForm.applicantLastName" autofocus>
        <input type="tel" id="phoneNumber" name="" placeholder="Phone Number" required v-model="applicationForm.applicantPhone" autofocus>
        <input type="submit" class="submit" name="" value="Submit">
      </form>
    </div>
  </body>
</div>
</template>

<script>

import headerBar from '@/components/headerBar.vue';
import PropService from '@/services/PropService';

export default {
name: "rentalProperty",
data() {
  return {
    picIndex: 0,
    hasApplied: "false",
    formNotExcepted: "false",
    errorResponse: "",
    applicationForm: {
      applicantId: this.$store.state.user.userId,
      propertyId: this.$route.params.propertyId,
      approvalStatus: "pending",
      applicantFirstName: "",
      applicantLastName: "",
      applicantPhone: ""
    }    
  }
},
methods: {
  apply() {    
    this.errorResponse = "you have hit submit";
    PropService.submitApplication(this.applicationForm).then(response => {
      if(response.error === null){
        this.hasApplied = true;
      }
      else {
        this.formNotExcepted = true;
      }
    })
    .catch((error) => {
          // const response = error.response;
              this.formNotExcepted = true;
              this.errorResponse = error;
          // if (error.response.status >= 400) {
          //   this.formNotExcepted = true;
          // }
          // else{
          //   this.formNotExcepted = true;
          // }
        });
    this.applicationForm.firstName = "";
    this.applicationForm.lastName = "";
    this.applicationForm.phone = "";   
  }
},
components: {
    headerBar,
  },
}
</script>

<style>
#headerBarId {
  left: 0rem;
}

body{
  display: flex;
  flex-direction: column;
}
.applicationBox {
  margin-top: 10rem;
}

.picture-container {
  box-sizing:border-box;
  margin-top: 10rem;
}

/* Slideshow container */
.rental-details {
  max-width: 1000px;
  position: relative;
  margin: auto;
}

/* Hide the images by default */
.mySlides {
  display: none;
}

/* Next & previous buttons */
.prev, .next {
  cursor: pointer;
  position: absolute;
  top: 50%;
  width: auto;
  margin-top: -22px;
  padding: 16px;
  color: white;
  font-weight: bold;
  font-size: 18px;
  transition: 0.6s ease;
  border-radius: 0 3px 3px 0;
  user-select: none;
}

.next {
  right: 0;
  border-radius: 3px 0 0 3px;
}

/* On hover, add a black background color with a little bit see-through */
.prev:hover, .next:hover {
  background-color: rgba(0,0,0,0.8);
}

/* Caption text */
.text {
  color: #f2f2f2;
  font-size: 15px;
  padding: 8px 12px;
  position: absolute;
  bottom: 8px;
  width: 100%;
  text-align: center;
}

/* Number text (1/3 etc) */
.numbertext {
  color: #f2f2f2;
  font-size: 12px;
  padding: 8px 12px;
  position: absolute;
  top: 0;
}

/* The dots/bullets/indicators */
.dot {
  cursor: pointer;
  height: 15px;
  width: 15px;
  margin: 0 2px;
  background-color: #bbb;
  border-radius: 50%;
  display: inline-block;
  transition: background-color 0.6s ease;
}

.active, .dot:hover {
  background-color: #717171;
}

/* Fading animation */
.fade {
  -webkit-animation-name: fade;
  -webkit-animation-duration: 1.5s;
  animation-name: fade;
  animation-duration: 1.5s;
}

@-webkit-keyframes fade {
  from {opacity: .4}
  to {opacity: 1}
}

@keyframes fade {
  from {opacity: .4}
  to {opacity: 1}
}
</style>