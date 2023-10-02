<template>
    <Modal :modalActive="open">
        <div>

        </div>
        <div class="buttonsOnRight">
            <button @click="loadGame">Load</button>
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
    .buttonsOnRight{
        text-align: right;
    }

</style>

<script>
import Modal from '../../../Modal.vue';

export default {
    data() {
        return {
            saves: null,
            selectedId: 0
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