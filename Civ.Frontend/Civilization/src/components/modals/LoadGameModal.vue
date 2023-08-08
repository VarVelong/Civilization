<template>
    <Modal :modalActive="open">
        <div>
            <ul>
            <li v-for="save in saves"> {{save.id}} saved on {{dateTime(save.savedOn).format('DD/MM/YYYY hh:mm')}} </li>
            </ul>
        </div>
        <button @click="closeModal">close</button>
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
        margin-top: 20px;
        width: 50px;
        height: 30px;
    }

</style>

<script>
import Modal from '../Modal.vue';
import MapService from '../modules/Map/MapService';
import moment from 'moment';

export default {
    data() {
        return {
            saves: null
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
        }           
    }
}


</script>