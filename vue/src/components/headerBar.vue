<template>
  <body class="headerHolder">
    <header class="topnav">
      <div class="leftSide">
        <div class="logoWithTitle">
          <a href="#">
            <router-link :to="{ name: 'home' }"><img src="@/assets/rmc.png" alt="Company Logo" class="logo" /></router-link>
          </a>
          <div class="title">Rental Management Co.</div>
        </div>
        <input type="text" placeholder="Search.." class="searchBar" />
      </div>
      <div class="rightSide">
        <ul class="navList">
          <li><router-link :to="{ name: 'home' }">Home</router-link></li>
          <li v-if="this.$store.state.user.role=='renter'">|</li>
          <li><router-link v-if="this.$store.state.user.role=='renter'" :to="{ name: 'my-rental'}">My Rental</router-link></li>
          <li v-if="this.$store.state.user.role=='landlord'">|</li>
          <li><router-link v-if="this.$store.state.user.role=='landlord'" :to="{ name: 'home'}">My Rentals</router-link></li>
          <li v-if="this.$store.state.user.role=='maintenance'">|</li>
          <li><router-link v-if="this.$store.state.user.role=='maintenance'" :to="{ name: 'home'}">Maintenance To-Dos</router-link></li>
        </ul>
        <div class="signIn">
          <router-link :to="{ name: 'login' }" class="myAccount"
            ><img src="@/assets/user-circle-solid.png"
          /></router-link>
          <router-link v-if="!isLoggedIn" :to="{ name: 'login' }" class="signInText">Sign In</router-link>
          <router-link v-else :to="{ name: 'logout' }" class="signInText">Log Out</router-link>
        </div>
      </div>
    </header>
  </body>
</template>

<script>
export default {
  name: "headerBar",
  data() {
    return {      
      currentPath: this.getCurrentRoute,
    }
  },
  created() {
  },
  methods: {    
  },
  computed: {
    //getPath(){
      /*this.$route.*/
    //},
    isLoggedIn() {
      if(this.$store.state.user.username != null){
        return true;
      }
      else{
        return false;
      }
    },
  }
};
</script>

<style>
.headerHolder {
  position: fixed;
  top: 0;
  width: 100%;
  margin: 0;
}

.topnav {
  background-color: rgb(182, 204, 236);
  padding: 20px;
  display: flex;
  flex-direction: row;
  align-items: center;
  justify-content: space-between;
}

.leftSide{
  display: flex;
  flex-direction: row;
  align-items: center;
  justify-content: flex-start;
}

.rightSide {
  display: flex;
  flex-direction: row;
  align-items: center;
}

.logoWithTitle {
  display: flex;
  flex-direction: column;
  align-items: center;
  font-family: "Oswald", "Arial", "Helvetica", "sans-serif";
  font-size: 10px;
  font-weight: bold;
  text-transform: uppercase;
  color: #808080;
  padding-right: 5px;
}
.logo {
  width: 6rem;
}

.searchBar {
  font-size: 20px;
  height: 20%;
  margin-left: 0px;
  width: 18rem;
  border-radius: .5rem;
  border: 2px solid #9bbdd3;
}

.navList {
  margin: 0;
  padding-left: 0px;
  list-style-type: none;
  display: flex;
  flex-direction: row;
}

li a {
  font-family: "Oswald", "Arial", "Helvetica", "sans-serif";
  font-size: 18px;
  padding: 10px;
  text-transform: uppercase;
  color: #808080;
  text-decoration: none;
  align-self: center;
}

a:hover {
  color: #050e9c;
  text-decoration: underline;
}

.topnav .myAccount {
  display: flex;
  justify-self: flex-end;
  align-self: center;
}

.signIn {
  display: flex;
  flex-direction: column;
  padding-left: 6px;
}

.signInText {
  font-family: "Oswald", "Arial";
  font-size: 15px;
  text-transform: uppercase;
  color: #808080;
  text-transform: none;
  text-decoration: none;
}
.myAccount img {
  width: 40px;
  margin-bottom: 5px;
}

@media only screen and (max-width: 60em){
.topnav {
  padding-top: 1rem;
  padding-bottom: 0;
  display: flex;
  flex-direction: column;
}

.searchBar {
  font-size: 20px;
  height: 20%;
  margin-left: 0px;
  width: 13rem;
}

.rightSide a{
  font-size: 10px;
  align-content: center;
  padding: .3rem;
}

.logo {
  width: 60px;
  padding-right: 1rem;
}

.myAccount{
  width: 20px;
}

.title{
  display:none;
}

.signInText{
  display:none;
}
}
</style>