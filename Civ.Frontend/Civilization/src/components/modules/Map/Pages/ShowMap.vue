<template>
    <div>   
        <div id="wrapper">
            <div id="gameArea">
                <table id="gameBoard">
                    <tr v-for="col in cells">
                        <td v-for="square in col" :title="`${square.x}-${square.y}`" @click="selectSquare(square.x, square.y)" 
                            :class="square === selectedCell ? 'selected grass' : 'grass'">
                            <img v-if="square.man" src="../../../../assets/Images/MAN.png" />
                            <div v-if="square.city">{{square.city.name}}</div>
                        </td>
                    </tr>
                </table>
            </div>
            <ActionMenu id="actionMenu" v-show="selectedCell" :activeCell="selectedCell" @cellUpdated="updateCell"/>
        </div>

        <button @click="saveGame">
            Save
        </button>
        <button @click="modal.load = true">
            Load
        </button>
        <button @click="onExit">
            Leave to menu
        </button>

        <load-game-modal :open="modal.load" @close="modal.load = false" @selectedId="loadGameState"></load-game-modal>
    </div>
</template>

<style>
    #gameBoard, #gameBoard tr, #gameBoard td {
        border: 2px solid;
        border-color: blue;
        border-spacing: 0px;
    }

    #gameBoard td{
        height: 75px;
        width: 75px;
    }

    #gameBoard{
        table-layout:fixed;
        width: 100%;
    }

    .grass{
        background-color: rgba(0, 255, 0, 0.222);
    }

    .selected{
        border-color: red !important;
    }

    #gameBoard td:hover {
    border-color: rgb(149, 196, 31);
    border-style: dashed;
    }

    #actionMenu{
        float: right;
        width: 10%;
    }

    button{
        display: block;
    }
/* 
    #wrapper{
        width:100%;
        display:flex;
        margin-top: 50px;
        overflow: hidden;
    }

    #gameArea{      
        float:left;

        width: auto;
        margin-right: 200px;    
        height: 100px;
        background: purple;  
    } */

/*try to the right the one that on the left; https://coder-coder.com/display-divs-side-by-side/*/

    #actionMenu{
        width: 200px;
        background: yellow;

    }

</style>

<script>
import MapService from '../MapService';
import loadGameModal from '../../../modals/loadGameModal.vue';
import ActionMenu   from '../Components/ActionMenu.vue';

export default {
    data() {
        return {
            newSaveId: 1,
            print: "", 
            cells: [],
            saves: null,
            selectedCell: null,
            modal:{
                load:false
            }
        }
    },
    
    async mounted(){
        if(this.$route.params.id){
            await this.loadGame(this.$route.params.id);
        }
        else{
            for (let i = 0; i < 10; i++){
                this.cells.push([]);
                for(let j = 0; j < 10; j++){
                    this.cells[i].push({x:i,y:j});
                } 
            }
            this.cells[5][5].man=true;
        }


        MapService.getVersion().then(version =>{
            this.print = version.value;
        }); 
        this.fetchSaves();
    },

    components:{
        loadGameModal,
        ActionMenu 
    },

    methods:{
        saveGame(){
            let cells = [];
            for(let i = 0; i < this.cells.length; i++){
                this.cells[i].forEach(cell =>{
                    cell.saveId = this.newSaveId;
                });
                cells = cells.concat(this.cells[i]);
            }

            MapService.saveGame(cells).then(version =>{
                alert("Game Saved");
                this.fetchSaves();
            });
        },

        fetchSaves(){
            MapService.getSaves().then(saves =>{
                this.saves = saves;
                if(saves) {
                    this.newSaveId = saves.length + 1;
                }
            })
        },

        updateCell(cell){
            this.selectedCell = cell;
        },

        selectSquare(verse, column){
            this.selectedCell = this.cells[verse][column];
        },

        //TODO IS_MAN CHANGED TO ID_MAN, PASS DATA ABOUT THE MAN INTO ACTION MENU

        moveMan(verse, column){
            this.cells.forEach(element => {
                element.forEach(element2 => {
                    element2.man = false;
                })
            });
            this.cells[column][verse].man = true;
        },

        onExit(){
            let response = confirm("Are you sure you want to leave?");
            if(response == true){
                this.$router.push('/');
            }
        },

        async loadGame(loadId){
            let flatArray = this.cells = [];
            await MapService.getGameState(loadId)
            .then(cellArray => { 
                flatArray = cellArray;
            });

            for (let i = 0; i < 10; i++){
                this.cells.push([]);
                for(let j = 0; j < 10; j++){
                    this.cells[i].push(flatArray.find(cell => cell.x == i && cell.y == j));
                } 
            }
        },

        loadGameState(loadId){
            this.modal.load = false;
            this.$router.push({name:'game', params: {id:loadId}});
            this.loadGame(loadId);
        }
    }
}
</script>