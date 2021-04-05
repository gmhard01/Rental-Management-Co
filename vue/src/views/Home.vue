<template>
  <div class="home">
    <header />
    <propertyTile />
    <p>You must be authenticated to see this</p>
  </div>
</template>

<script>
import header from '@/components/header.vue';

export default {
  name: "home",
  components: {
    header,
    propertyTile
  },
    /*created(){
      PropService.getPropertyList(
    ).then((resp) => {
      this.prop = resp;
    });
  }*/
};
</script>
