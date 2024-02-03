<template>
    <div id="background">
        <!-- <img id="cityHall" src="../../../../assets/Images/CityHall.png" title="City Hall" @click="openCityHall" />
        <city-hall-modal :open="modal.cityHall" @close="modal.cityHall = false" @barrackCreated="barrackCreated" ></city-hall-modal>

        <img v-if="barracks.length > 0" src="../../../../assets/Images/barracks.png" title="Barracks" @click="openBarracks" />
        <img v-if="barracks.length > 1" src="../../../../assets/Images/barracks.png" title="Barracks" @click="openBarracks" /> -->
        <barracks-modal :open="modal.barracks" @close="modal.barracks = false"></barracks-modal>
        <div id="city-grid" class="container-fluid">

            <!-- TO DO!!! INSERT A PROPER BUILDING INTO RESPECTIVE CELL (photo on phone)-->

            <div class="row">
                <div class="col-lg-3 col-md-3 col-sm-6">
                    <img src="../../../../assets/Images/barracks.png" title="Barracks" @click="openBarracks" />
                </div>
                <div class="col-lg-3 col-md-3 col-sm-6">
                    <img src="../../../../assets/Images/barracks.png" title="Barracks" @click="openBarracks" />
                </div>
                <div class="col-lg-3 col-md-3 col-sm-6">
                    <img src="../../../../assets/Images/barracks.png" title="Barracks" @click="openBarracks" />
                </div>
                <div class="col-lg-3 col-md-3 col-sm-6">
                    <img src="../../../../assets/Images/barracks.png" title="Barracks" @click="openBarracks" />
                </div>
            </div>
            <div class="row">
                <div class="col-lg-3 col-md-3 col-sm-6">
                    <img src="../../../../assets/Images/barracks.png" title="Barracks" @click="openBarracks" />
                </div>
                <div class="col-lg-3 col-md-3 col-sm-6">
                    <img src="../../../../assets/Images/barracks.png" title="Barracks" @click="openBarracks" />
                </div>
                <div class="col-lg-3 col-md-3 col-sm-6">
                    <img src="../../../../assets/Images/barracks.png" title="Barracks" @click="openBarracks" />
                </div>
                <div class="col-lg-3 col-md-3 col-sm-6">
                    <img src="../../../../assets/Images/barracks.png" title="Barracks" @click="openBarracks" />
                </div>
            </div>
            <div class="row">
                <div class="col-lg-3 col-md-3 col-sm-6">
                    <img src="../../../../assets/Images/barracks.png" title="Barracks" @click="openBarracks" />
                </div>
                <div class="col-lg-3 col-md-3 col-sm-6">
                    <img src="../../../../assets/Images/barracks.png" title="Barracks" @click="openBarracks" />
                </div>
                <div class="col-lg-3 col-md-3 col-sm-6">
                    <img src="../../../../assets/Images/barracks.png" title="Barracks" @click="openBarracks" />
                </div>
                <div class="col-lg-3 col-md-3 col-sm-6">
                    <img src="../../../../assets/Images/barracks.png" title="Barracks" @click="openBarracks" />
                </div>
            </div>
        </div>
        <button @click="returnToMap" id="returnButton"> RETURN </button>
    </div>
</template>


<style scoped>
#city-grid img{
    height: 90%;
    width: 90%;
}

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

/* .container{
    width: auto;
} */
</style>


<script>
import CityHallModal from '../Components/CityHallModal.vue';
import BarracksModal from '../Components/BarracksModal.vue';

export default {
    data() {
        return {
            modal: {
                cityHall: false,
                barracks: false
            },
            barracks: []
        }
    },

    components: {
        CityHallModal,
        BarracksModal
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
        },

        barrackCreated(barrack) {
            this.barracks.push(barrack);
        }
    }
}

</script>