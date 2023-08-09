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
        <load-game-modal :open="modal.load" @close="modal.load = false" @selectedId="loadGame"></load-game-modal>    
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
import LoadGameModal from '../../modals/loadGameModal.vue'

export default {
    data() {
        return {
            modal:{
                load:false
            }
        }
    },
    
    components:{
        LoadGameModal
    },

    methods: {
        loadGame(loadId){
            this.modal.load = false;
            this.$router.push({name:'game', params: {id:loadId}});
        }
    }
}

</script>