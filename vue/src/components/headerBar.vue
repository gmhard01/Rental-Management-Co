<template>
  <body>
    <header class="topnav">
      <a href=#>
        <img src="@/assets/logo.png" alt="Company Logo" class="logo">
      </a>
      <input type="text" placeholder="Search.." class="searchBar">
      <div class="spacer">&nbsp;</div>
      <ul>
        <li><a href="#">Home</a></li>
        <li><a href="#">My Apartments</a></li>
        <li><a href="#">Maintanance Requests</a></li>
      </ul>
      <a href="#" class="myAccount">
          <img src="@/assets/user-circle-solid.png" />
      </a>
    </header>
  </body>
</template>

<script>
export default {
    name: "headerBar"
}
</script>

<style>
body {
  position: absolute;
  width: 100%;
  margin: 0;
}

header {
  background-color: aliceblue;
  padding: 20px;
  display: flex;
  flex-direction: row;
  align-items: center;
  justify-content: space-around;
}

.logo {
  width: 80px;
}

.searchBar {
  font-size: 20px;
  height: 20%;
  margin-left: 0px;
  width: 300px;
}

ul {
  margin: 0;
  padding-left: 100px;
  list-style-type: none;
  display: flex;
  flex-direction: row;
}

li a {
  font-family: 'Oswald', 'Arial', 'Helvetica', 'sans-serif';
  font-size: 18px;
  text-transform: uppercase;
  padding: 0px 20px 0 0;
  color: #8f8d8d;
  text-decoration: none;
  align-self: center;
}

li a:hover {
  color: #00AFEF;
  text-decoration: underline;
}

header .myAccount{
  display: flex;
  justify-self: end;
  align-self: center;
}

.myAccount img {
  width: 50px;
}

</style>