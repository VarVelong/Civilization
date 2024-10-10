<template>
    <container>
        <div>
            <button @click="$router.push('game')">
                New Game
            </button>
            <button @click="modal.saves = true">
                Load Game
            </button>
            <button>
                Options
            </button>
        </div>
        <game-saves-modal :open="modal.saves" @close="modal.saves = false" @selected="loadGame"></game-saves-modal>    
    </container>
</template>

<style scoped>
    button{
        display: block;
        font-size: 32px;
        margin: auto;
        width: 50%;
        padding: 10px;
        margin-bottom: 50px;
    }

    button:first-of-type{
        margin-top: 300px;
    }

    

</style>

<script>
import GameSavesModal from '../../modals/GameSavesModal.vue'

export default {
    data() {
        return {
            modal:{
                saves:false
            }
        }
    },
    
    components: {
        GameSavesModal
    },

    methods: {
        loadGame(loadId){
            this.modal.saves = false;
            this.$router.push({name:'game', params: {id:loadId}});
        }
    }
}

</script>