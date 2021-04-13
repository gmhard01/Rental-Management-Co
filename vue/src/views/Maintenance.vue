<template>
  <div>
    <body>
    <header>
      <headerBar id="headerBarId" />
    </header>
    <div>
      <propMaintenance id="propMaintenance" />
    </div>
    </body>
  </div>
</template>

<script>
import headerBar from '@/components/headerBar.vue';
import propMaintenance from '@/components/propMaintenance.vue';

export default {
  components: {
    headerBar,
    propMaintenance
  },
}
</script>

<style>
#propMaintenance{
  margin-top: 8rem; 
}
</style>