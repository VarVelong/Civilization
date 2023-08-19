<template>
    <Modal :modalActive="open">
        <div>
            <button @click="spawnUnit">Spawn Unit</button>
            <button @click="closeModal">Close</button>
        </div>
    </Modal>
</template>


<style scoped>

</style>


<script>
import Modal from '../Modal.vue';

export default{
    data() {
        return{}
    },

    components: {
        Modal
    },

    watch:{
        open(){
            this.loadCity();
        }
    },

    props: {
        open: {
            type: Boolean,
            required: true
        },
        city: Object
    },

    methods: {
        loadCity(){

        },

        spawnUnit(city){
            let man = true;
            this.$emit("spawn-unit", man);
        },

        closeModal() {
            this.$emit("close");
        }
    }
}

</script>