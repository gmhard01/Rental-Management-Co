<template>
    <div>
        <body>
            <header>
              <headerBar id="headerBarId" />
            </header>
            <div>
              <applicationTile />
            </div>
            <div>
              <propMaintenance id="propMaintenance" />
            </div>
        </body>
    </div>
</template>

<script>
import headerBar from '@/components/headerBar.vue';
import propMaintenance from '@/components/propMaintenance.vue';
import applicationTile from '@/components/applicationTile';
export default {
  components: {
    headerBar,
    propMaintenance,
    applicationTile
  },
}
</script>

<style>
#propMaintenance{
  margin-top: 8rem; 
}
</style>