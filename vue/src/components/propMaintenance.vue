<template>
  <div>
      <body>
          <propertyTile />
          <maintenanceTile />
      </body>
  </div>
</template>

<script>
import propertyTile from '@/components/propertyTile.vue';
import maintenanceTile from '@/components/maintenanceTile.vue';
export default {
  components: { 
      propertyTile,
      maintenanceTile,
   },
}
</script>

<style>

</style>