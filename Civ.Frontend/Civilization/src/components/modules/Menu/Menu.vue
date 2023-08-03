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
        <load-game-modal v-model="modal.load"></load-game-modal>    
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
import LoadGameModal from '../../modals/LoadGameModal.vue'

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
    }
}

</script>