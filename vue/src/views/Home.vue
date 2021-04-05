<template>
  <div class="home">
    <headerBar />
    <propertyTile />
    <p>You must be authenticated to see this</p>
  </div>
</template>

<script>
import headerBar from '@/components/headerBar.vue';
import propertyTile from '@/components/propertyTile.vue';

export default {
  name: "home",
  components: {
    headerBar,
    propertyTile
  }
    /*created(){
      PropService.getPropertyList(
    ).then((resp) => {
      this.prop = resp;
    });
  }*/
};
</script>
