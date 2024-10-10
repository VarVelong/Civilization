<template>
    <Modal :modalActive="open">
        <div>
            <button @click="createBarrack(barrackTiers[0])"> Create tier 1 barracks </button>
            <button @click="createBarrack(barrackTiers[1])"> Create tier 2 barracks </button>
            <button @click="createBarrack(barrackTiers[2])"> Create tier 3 barracks </button>
            <button @click="createBarrack(barrackTiers[3])"> Create tier 4 barracks </button>
            <button @click="createBarrack(barrackTiers[4])"> Create tier 5 barracks </button>
            <button @click="createBarrack(barrackTiers[5])"> Create tier 6 barracks </button>
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
import BarracksTier from '../Enums/BarracksTier.js'

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

    computed: {
        barrackTiers(){
            return BarracksTier;
        }   
    },
    
    mounted(){
    
    },
    
    methods: {
        closeModal() {
            this.$emit("close");
        },

        createBarrack(barracksTier) {
            this.$emit("barrackCreated", { tier: barracksTier.id });
            this.$emit("close");
        }
    }
}


</script>