<template>
  <div id="mapView">
    <div id="map" ref="map">
        <map-info-window :lat="39.17564660817805" :lng="-84.46540583097251"><a href="http://localhost:8080/rental-property/100">1733 Garden Ln</a></map-info-window>
        <map-info-window :lat="39.1040156454818" :lng="-84.45792858835486"><a href="http://localhost:8080/rental-property/101">72 Stacy Ln</a></map-info-window>
        <map-info-window :lat="39.175321860732936" :lng="-84.4280565450431"><a href="http://localhost:8080/rental-property/102">3149 Auten Ave</a></map-info-window>
        <map-info-window :lat="39.16585683712683" :lng="-84.35728655980859"><a href="http://localhost:8080/rental-property/105">7985 Brill Rd</a></map-info-window>
        <map-info-window :lat="39.236566798064004" :lng="-84.54157600184519"><a href="http://localhost:8080/rental-property/104">7862 Martin St</a></map-info-window>
    </div>
  </div>
</template>

<script>
import mapInfoWindow from '@/components/mapInfoWindow.vue';

export default {
    components: {
			mapInfoWindow
    },
    data: () => ({
        map: null,
        showInfoWindow: false
    }),
    async mounted() {
        this.map = await new window.google.maps.Map(this.$refs["map"], {
            center: {lat: 39.16, lng: -84.53},
            zoom: 11
        })
    },
    methods: {
		getMap(callback) {
			let vm = this
			function checkForMap() {
				if (vm.map) callback(vm.map)
				else setTimeout(checkForMap, 200)
			}
			checkForMap()
		},
        goToProperty() {
            this.$router.push('/rental-property/100');
        }
    }
}
</script>

<style scoped>
#mapView {
    display: flex;
    flex-direction: column;
    align-items: center;
}

#map {
    margin-top: 25px;
    height: 70vh;
    width: 80vw;
    border-radius: 15px;
}
</style>