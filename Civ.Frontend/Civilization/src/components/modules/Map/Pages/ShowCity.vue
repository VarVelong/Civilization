<template>
    <div id="background">
        <img id="cityHall" src="../../../../assets/Images/CityHall.png" title="City Hall" @click="openCityHall" />
        <city-hall-modal :open="modal.cityHall" @close="modal.cityHall = false"></city-hall-modal>

        <img id="t1barracks" src="../../../../assets/Images/barracks.png" title="Tier 1 Barracks" @click="openBarracks" />
        <tier1-barracks-modal :open="modal.barracks" @close="modal.barracks = false"></tier1-barracks-modal>

        <button @click="returnToMap" id="returnButton"> RETURN </button>
    </div>
</template>


<style scoped>
#background {
    background: url(../../../../assets/Images/CityBackground.png);
    width: 100vw;
    height: 100vh;
}

#cityHall {
    width: 20vw;
    height: 20vh;
    margin-left: 50vh;
    margin-top: 30vh;
    cursor: pointer;

}

#cityHall:hover {
    filter: saturate(3);
}

#returnButton {
    position: absolute;
    left: 5vw;
    bottom: 5vh;
}
</style>


<script>
import CityHallModal from '../Components/CityHallModal.vue';
import Tier1BarracksModal from '../Components/Barracks1Modal.vue';

export default {
    data() {
        return {
            modal: {
                cityHall: false,
                barracks: false
            }
        }
    },

    components: {
        CityHallModal,
        Tier1BarracksModal
    },

    methods: {
        openCityHall() {
            this.modal.cityHall = true;
        },

        openBarracks() {
            this.modal.barracks = true;
        },

        returnToMap() {
            this.$router.push({ name: 'game', params: { id: 1 } });
            //find a way to pass all the date about city back
        }
    }
}

</script>