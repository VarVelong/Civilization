<template>
    <Modal :modalActive="open">
        <div class="container-flud">
            <div class="row">
                <div class="col-lg-8">
                    <label>CHOOSE YOUR HERO</label>
                    <select class="form-select" size="5" aria-label="multiple select example" @change="">
                        <option selected>Open this select menu</option>
                        <option value="1">One</option>
                        <option value="2">Two</option>
                        <option value="3">Three</option>
                    </select>
                </div>
                <div class="col-lg-4">
                    <p>Statistics</p>
                </div>
            </div>
        </div>
        <div class="buttonsOnRight">
            <button @click="spawnUnit">Choose Hero</button>
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
            selectedId: 0,
            city: null,
            selectedHero: null,
            heroPool: [{
                name: "Arthur",
                healthPoints: 30,
                manaPoints: 20,
                strength: 9,
                iniciative: 5
            }, {
                name: "Elf",
                healthPoints: 10,
                manaPoints: 5,
                strength: 4,
                iniciative: 2
                }]
            
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
            //this.modalActive = false;
            this.$emit("close");
        },

        spawnUnit(city){
            let man = true;
            this.$emit("spawn-unit", man);
            this.$emit("close");
        }
    }
}


</script>