<template>
    <Modal :modalActive="open">
        <div id="overall">
            <div id="stats">
                <h3>Stats</h3>
            </div>
            <div id="abilities">
                <h3>Abilities</h3>
            </div>
            <div id="inventory">
                <h3>Inventory</h3>
            </div>
            <div id="team">
                <h3>Team</h3>
            </div>
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

    #overall div{
        border: 2px red solid;
        margin: 1%;
        padding: 5px
    }

    #stats{
        float: left;
        width: 38%;

    }

    #abilities{
        float: right;
        width: 58%;

    }

    #inventory{
        float: left;
        width: 38%;

    }

    #team{
        float: right;
        width: 58%; 

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