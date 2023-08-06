<template>
    <Modal :modalActive="open">
        <div>test</div>
        <button @click="closeModal">close</button>
    </Modal>
</template>

<style>
</style>

<script>
import Modal from '../Modal.vue';


export default {
    data() {
        return {

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
    
    methods: {
        closeModal() {
            this.$emit("close");
        }
    }
}


</script>