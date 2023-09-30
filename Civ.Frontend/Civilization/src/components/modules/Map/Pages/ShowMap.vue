<template>
    <div id="page">   
        <div id="wrapper">
            <div id="gameArea">
                <table id="gameBoard" @mouseleave="cleanPath">
                    <tr v-for="col in cellArray">
                        <td v-for="square in col" :title="`${square.x}-${square.y}`" @click="selectSquare(square.x, square.y)" 
                            :class="square === selectedCell ? 'selected grass' : 'grass'" @mouseover="cellHover(square)"
                            @contextmenu="moveUnit($event, square.x, square.y)" @dblclick="onDoubleClick(square.x, square.y)">
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
            <div>
                <button @click="saveGame">
                Save
                </button>
                <button @click="modal.load = true">
                Load
                </button>
            </div>
            <div>
                <button @click="onExit">
                    Leave to menu
                </button>
            </div>
        </div>

        <CityModal :open="modal.city" @close="modal.city = false" :city="selectedCity" @spawnUnit="spawnUnit">
    
        </CityModal>

        <load-game-modal :open="modal.load" @close="modal.load = false" @selectedId="loadGameState"></load-game-modal>
    </div>
</template>

<style>
    #page {
        margin: auto;
        margin-top: 20px;
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

    #bottomMenu button {
        font-size: 32px;
        padding: 5px;
        margin: 5px;
    }

    #bottomMenu div:first-child {
        float: left;
    }

    #bottomMenu div:nth-child(2) {
        float: right;
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
import CityModal from '../../../modals/CityModal.vue';

export default {
    data() {
        return {
            newSaveId: 1,
            print: "", 
            cellArray: [],
            saves: null,
            selectedCell: null,
            selectedCity: null,
            fieldSize: 10,
            modal:{
                load:false,
                city:false
            }
        }
    },
    
    async mounted(){
        if(this.$route.params.id){
            await this.loadGame(this.$route.params.id);
        }
        else{
            for (let i = 0; i < this.fieldSize; i++){
                this.cellArray.push([]);
                for(let j = 0; j < this.fieldSize; j++){
                    this.cellArray[i].push({x:i,y:j});
                } 
            }
            this.cellArray[5][5].man=true;
        }


        MapService.getVersion().then(version =>{
            this.print = version.value;
        }); 
        this.fetchSaves();
    },

    components:{
    loadGameModal,
    ActionMenu,
    CityModal
},

    methods:{
        saveGame(){
            let cellArray = [];
            for(let i = 0; i < this.cellArray.length; i++){
                this.cellArray[i].forEach(cell =>{
                    cell.saveId = this.newSaveId;
                });
                cellArray = cellArray.concat(this.cellArray[i]);
            }

            MapService.saveGame(cellArray).then(version =>{
                alert("Game Saved");
                this.fetchSaves();
            });
        },

        cleanPath(){
            for(let i = 0; i < this.cellArray.length; i++){
                this.cellArray[i].forEach(cell =>{
                    cell.movementCounter = null;
                });
            }
        },

        cellHover(cell){ 
            this.cleanPath();
            if(!this.selectedCell || (this.selectedCell.x == cell.x && this.selectedCell.y == cell.y)){
                return;
            }
            
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

                this.cellArray[coordinates.x][coordinates.y].movementCounter = iteration;
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

        updateCell(cell, clearSelection){
            this.selectedCell = cell;
            if(clearSelection){
                this.selectedCell = null;
            }
        },

        selectSquare(verse, column){
            if(this.cellArray[verse][column].man){
                this.selectedCell = this.cellArray[verse][column];
            }
        },

        moveUnit(e, verse, column){
            this.selectedCell.man = false;
            this.cellArray[verse][column].man = true;
            this.selectedCell = null;
            e.preventDefault();
        },

        onDoubleClick(verse, column){
            this.selectedCell = this.cellArray[verse][column];
            this.modal.city = this.cellArray[verse][column].city;
        },

        spawnUnit(man){
            if(this.selectedCell.y != this.fieldSize - 1){
                this.cellArray[this.selectedCell.x][this.selectedCell.y - 1].man = man;
            }
            else{
                this.cellArray[this.selectedCell.x][this.selectedCell.y + 1].man = man;
            }
        },
            
        //TODO fix axises by replacing x with y and y with x (they are opposite)

        onExit(){
            let response = confirm("Are you sure you want to leave?");
            if(response == true){
                this.$router.push('/');
            }
        },

        async loadGame(loadId){
            let flatArray = this.cellArray = [];
            await MapService.getGameState(loadId)
            .then(cellArray => { 
                flatArray = cellArray;
            });

            for (let i = 0; i < 10; i++){
                this.cellArray.push([]);
                for(let j = 0; j < 10; j++){
                    this.cellArray[i].push(flatArray.find(cell => cell.x == i && cell.y == j));
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