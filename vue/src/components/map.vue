<template>
  <div id="mapView">
    <div id="map" ref="map">
        <map-info-window :lat="39.18822842582619" :lng="-84.48297657808968"><a href="http://localhost:8080/rental-property/100">6505 Hasler Ln</a></map-info-window>
        <map-info-window :lat="39.1040156454818" :lng="-84.45792858835486"><a href="http://localhost:8080/rental-property/101">72 Stacy Ln</a></map-info-window>
        <map-info-window :lat="39.16148541239039" :lng="-84.30554708650416"><a href="http://localhost:8080/rental-property/103">407 Amherst Ave</a></map-info-window>
        <map-info-window :lat="39.236566798064004" :lng="-84.54157600184519"><a href="http://localhost:8080/rental-property/104">7862 Martin St</a></map-info-window>
        <map-info-window :lat="39.122617082068594" :lng="-84.52225013068319"><a href="http://localhost:8080/rental-property/105">238 Klotter Ave</a></map-info-window>
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

        const marker = document.getElementById
		marker.addEventListener('click', console.log('hi'))
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