<template>
    <Modal :modalActive="open">
        <div>
            <ul>
                <li v-for="save in saves" :class="save.id == selectedId ? 'selected' : ''" @click="selectedId = save.id"> 
                    {{save.id}} saved on {{dateTime(save.savedOn).format('DD/MM/YYYY hh:mm')}} 
                </li>
            </ul>
        </div>
        <div class="buttonsOnRight">
            <button @click="loadGame">Load</button>
            <button @click="closeModal">Close</button>
        </div>
    </Modal>
</template>

<style scoped>
    li{
        border: 2px solid;
        list-style-type: none;
        margin-bottom: 2px;
        font-size: 14pt;
        padding-left: 5px;   
    }

    li:hover{
        border-color: red;
        background-color: rosybrown;
    }

    button{
        display: inline-block;
        margin-top: 20px;
        width: 50px;
        height: 30px;
        margin-left: 5px;
    }

    .selected{
        border-color: green;
        background-color: rgb(117, 173, 32);
    }

    .buttonsOnRight{
        text-align: right;
    }

</style>

<script>
import Modal from '../Modal.vue';
import MapService from '../modules/Map/MapService';
import moment from 'moment';

export default {
    data() {
        return {
            saves: null,
            selectedId: 0
        }
    },

    watch:{
        open(){
            this.fetchSaves();
        }
    },
    
    props: {
        open: {
            type: Boolean,
            required: true
        },
    },

    components: {
        Modal
    },
    
    mounted(){
        this.fetchSaves();
    },
    
    methods: {
        closeModal() {
            this.$emit("close");
        },

        fetchSaves(){
            MapService.getSaves().then(saves =>{
                this.saves = saves;
            })
        },

        dateTime(value) {
            return moment.utc(value).local();
        },

        loadGame(){
            this.$emit("selectedId", this.selectedId);
        }
    }
}


</script>