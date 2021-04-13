<template>
  <div>
      <body>
          <propertyTile />
          <maintenanceTile />
          <transactionTile />
      </body>
  </div>
</template>

<script>
import propertyTile from '@/components/propertyTile.vue';
import transactionTile from '@/components/transactionTile.vue';
import maintenanceTile from '@/components/maintenanceTile.vue;'
export default {
  components: { 
      propertyTile,
      transactionTile,
      maintenanceTile
   },
}
</script>

<style>

</style>