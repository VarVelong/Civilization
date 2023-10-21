<template>
    <Modal :modalActive="open">
        <div>

        </div>
        <div>
            <button @click="closeModal">Close</button>
        </div>
    </Modal>
</template>

<style scoped>
    button{
        display: inline-block;
        margin-top: 20px;
        width: 50px;
        height: 30px;
        margin-left: 5px;
    }
</style>

<script>
import Modal from '../../../Modal.vue';
import Unit from '../Models/Unit.js';

//inventory, equipment, abilities, statistics, team(what creatures are inside heroes party)

export default {
    data() {
        return {

        }
    },

    watch:{
        open(){
        }
    },
    
    props: {
        open: {
            type: Boolean,
            required: true
        },

        hero: {
            type: Unit,
            required: true
        }
    },

    components: {
        Modal
    },
    
    mounted(){
    
    },
    
    methods: {
        closeModal() {
            this.$emit("close");
        }
    }
}
</script>