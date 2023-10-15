<template>
    <container>
        <div>
            <button @click="$router.push('game')">
                New Game
            </button>
            <button @click="modal.load = true">
                Load Game
            </button>
            <button>
                Options
            </button>
        </div>
        <game-load-modal :open="modal.load" @close="modal.load = false" @selectedId="loadGame"></game-load-modal>    
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
import GameLoadModal from '../../modals/GameLoadModal.vue'

export default {
    data() {
        return {
            modal:{
                load:false
            }
        }
    },
    
    components: {
        GameLoadModal
    },

    methods: {
        loadGame(loadId){
            this.modal.load = false;
            this.$router.push({name:'game', params: {id:loadId}});
        }
    }
}

</script>