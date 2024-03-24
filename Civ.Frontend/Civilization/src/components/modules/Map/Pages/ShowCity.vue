<template>
    <div id="background">
        <!-- <img id="cityHall" src="../../../../assets/Images/CityHall.png" title="City Hall" @click="openCityHall" />
        <city-hall-modal :open="modal.cityHall" @close="modal.cityHall = false" @barrackCreated="barrackCreated" ></city-hall-modal>

        <img v-if="barracks.length > 0" src="../../../../assets/Images/barracks.png" title="Barracks" @click="openBarracks" />
        <img v-if="barracks.length > 1" src="../../../../assets/Images/barracks.png" title="Barracks" @click="openBarracks" /> -->
        <barracks-modal :open="modal.barracks" @close="modal.barracks = false"></barracks-modal>
        <tavern-modal :open="modal.tavern" @close="modal.tavern = false"></tavern-modal>

        <div id="city-grid" class="container-fluid">

            <div class="row">
                <div :class="barracksThree ? 'col-lg-3 col-md-3 col-sm-6' : 'disabled col-lg-3 col-md-3 col-sm-6'">
                    <img src="../../../../assets/Images/B3.png" title="Barracks3" @click="openBarracks" />
                </div>
                <div :class="barracksFour ? 'col-lg-3 col-md-3 col-sm-6' : 'disabled col-lg-3 col-md-3 col-sm-6'">
                    <img src="../../../../assets/Images/B4.png" title="Barracks4" @click="openBarracks" />
                </div>
                <div :class="barracksFive ? 'col-lg-3 col-md-3 col-sm-6' : 'disabled col-lg-3 col-md-3 col-sm-6'">
                    <img src="../../../../assets/Images/B5.png" title="Barracks5" @click="openBarracks" />
                </div>
                <div :class="barracksSix ? 'col-lg-3 col-md-3 col-sm-6' : 'disabled col-lg-3 col-md-3 col-sm-6'">
                    <img src="../../../../assets/Images/B6.png" title="Barracks6" @click="openBarracks" />
                </div>
            </div>

            <div class="row">
                <div :class="barracksOne ? 'col-lg-3 col-md-3 col-sm-6' : 'disabled col-lg-3 col-md-3 col-sm-6'">
                    <img src="../../../../assets/Images/B1.png" title="Barracks1" @click="openBarracks" />
                </div>
                <div :class="cityHall ? 'col-lg-3 col-md-3 col-sm-6' : 'disabled col-lg-3 col-md-3 col-sm-6'">
                    <img src="../../../../assets/Images/CityHall.png" title="City Hall" />
                </div>
                <div :class="tavern ? 'col-lg-3 col-md-3 col-sm-6' : 'disabled col-lg-3 col-md-3 col-sm-6'">
                    <img src="../../../../assets/Images/Tavern.png" title="Tavern" @click="modal.tavern = true" />
                </div>
                <div :class="barracksTwo ? 'col-lg-3 col-md-3 col-sm-6' : 'disabled col-lg-3 col-md-3 col-sm-6'">
                    <img src="../../../../assets/Images/B2.png" title="Barracks2" @click="openBarracks" />
                </div>
            </div>

            <div class="row">
                <div :class="unknownOne ? 'col-lg-3 col-md-3 col-sm-6' : 'disabled col-lg-3 col-md-3 col-sm-6'">
                    <img src="../../../../assets/Images/Unknown.png" title="Unknown" />
                </div>
                <div :class="magicTower ? 'col-lg-3 col-md-3 col-sm-6' : 'disabled col-lg-3 col-md-3 col-sm-6'">
                    <img src="../../../../assets/Images/MagicTower.png" title="Magic Tower" />
                </div>
                <div :class="market ? 'col-lg-3 col-md-3 col-sm-6' : 'disabled col-lg-3 col-md-3 col-sm-6'">
                    <img src="../../../../assets/Images/Market.png" title="Market" />
                </div>
                <div :class="unknownTwo ? 'col-lg-3 col-md-3 col-sm-6' : 'disabled col-lg-3 col-md-3 col-sm-6'">
                    <img src="../../../../assets/Images/Unknown.png" title="Unknown" />
                </div>
            </div>
        </div>
        <button @click="returnToMap" id="returnButton"> RETURN </button>

    </div>
</template>


<style scoped>
#city-grid img {
    height: 75%;
    width: 75%;
}

#background {
    background: url(../../../../assets/Images/CityBackground.png);
    width: 100vw;
    height: 100vh;
}

div.disabled img {
    opacity: 0.5;
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
import TavernModal from '../Components/TavernModal.vue';

export default {
    data() {
        return {
            modal: {
                cityHall: false,
                barracks: false,
                tavern: false
            },
            cityHall: true,
            magicTower: false,
            tavern: true,
            market: false,
            unknownOne: false,
            unknownTwo: false,
            barracksOne: false,
            barracksTwo: false,
            barracksThree: false,
            barracksFour: false,
            barracksFive: false,
            barracksSix: false
        }
    },

    components: {
        CityHallModal,
        BarracksModal,
        TavernModal
    },

    methods: {
        openCityHall() {
            this.modal.cityHall = true;
        },

        openBarracks() {
            this.modal.barracks = true;
        },

        returnToMap() {
            this.$router.push({ name: 'game', params: { id: -1 } });
            //find a way to pass all the date about city back
        },

        barrackCreated(barrack) {
            this.barracks.push(barrack);
        }
    }
}

</script>