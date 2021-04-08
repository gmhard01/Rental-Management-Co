<template>
<div>
  <body>
    <header>
      <headerBar id="headerBarId" />
    </header>
    <div>
      <propertyTile />
    </div>
    <div>
    <form class="applicationBox">
      <h1>Application Form</h1>
      <input type="text" name="" placeholder="Full Name" required autofocus>
      <input type="tel" id="phoneNumber" name="" placeholder="Phone Number" required autofocus>
      <input type="submit" class="submit" name="" value="Submit">
    </form>
    </div>
  </body>
</div>
</template>

<script>

import headerBar from '@/components/headerBar.vue';
import propertyTile from '@/components/propertyTile.vue';

export default {
name: "rentalProperty",

components: {
    headerBar,
    propertyTile
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
</style>