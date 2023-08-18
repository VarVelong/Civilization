<template>
    <div id="page">   
        <div id="wrapper">
            <div id="gameArea">
                <table id="gameBoard" @mouseleave="cleanPath">
                    <tr v-for="col in cells">
                        <td v-for="square in col" :title="`${square.x}-${square.y}`" @click="selectSquare(square.x, square.y)" 
                            :class="square === selectedCell ? 'selected grass' : 'grass'" @mouseover="cellHover(square)">
                            <img v-if="square.man" src="../../../../assets/Images/MAN.png" />
                            <img v-if="square.city" src="../../../../assets/Images/baseIcon.png" :title="square.city.name"/>
                            {{square.movementCounter}}
                        </td>
                    </tr>
                </table>
            </div>
            <ActionMenu  v-show="selectedCell && selectedCell.man" id="actionMenu" :activeCell="selectedCell" @cellUpdated="updateCell"/>
        </div>

        <div id="bottomMenu">
            <button @click="saveGame">
                Save
            </button>
            <button @click="modal.load = true">
                Load
            </button>
            <button @click="onExit">
                Leave to menu
            </button>
        </div>

        <load-game-modal :open="modal.load" @close="modal.load = false" @selectedId="loadGameState"></load-game-modal>
    </div>
</template>

<style>
    #page {
        margin: auto;
        margin-top: 20px;
        width: 50%;
    }

    #gameBoard, #gameBoard tr, #gameBoard td {
        border: 2px solid;
        border-color: blue;
        border-spacing: 0px;
    }

    #gameBoard td{
        height: 75px;
        min-width: 75px;
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

    button{
        display: block;
    }

    #wrapper{
        width: max-content;
    }

    #gameArea{      
        float: left;
    }

    #actionMenu{
        width: 250px;
        float: left;
    }

    #bottomMenu {
        clear: both;
    }

    #gameBoard td img{
        max-width: 75px;
        max-height: 75px;
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

        cleanPath(){
            for(let i = 0; i < this.cells.length; i++){
                this.cells[i].forEach(cell =>{
                    cell.movementCounter = null;
                });
            }
        },

        cellHover(cell){ 
            this.cleanPath();
            if(!this.selectedCell || (this.selectedCell.x == cell.x && this.selectedCell.y == cell.y)){
                return;
            }
            debugger
            let coordinates = {x:this.selectedCell.x, y:this.selectedCell.y};
            let iteration = 0;
            while(coordinates.x != cell.x || coordinates.y != cell.y){
                iteration++;
                if(coordinates.x != cell.x){
                    coordinates.x += Math.sign(cell.x - this.selectedCell.x);
                }

                if(coordinates.y != cell.y){
                    coordinates.y += Math.sign(cell.y - this.selectedCell.y);
                }

                this.cells[coordinates.x][coordinates.y].movementCounter = iteration;


            }
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