<template>
    <div>
       {{ print }} 

        <div>
            <div>
                <table id="gameBoard">
                    <tr v-for="col in cells">
                        <td v-for="square in col" :title="`${square.x}-${square.y}`" @click="selectSquare(square.x, square.y)" 
                            :class="square.isSelected ? 'selected grass' : 'grass'">
                            <img v-if="square.man" src="../../../../assets/Images/MAN.png" />
                            
                        </td>
                    </tr>
                </table>
            </div>
            <div id="actionMenu">
                <ul>
                    <li>Create City</li>
                    <li>Move</li>
                    <li>Attack</li>
                    <li>Delete Unit</li>
                </ul>
            </div>
        </div>


        <ul>
            <li v-for="save in saves"> {{save.id}} saved on {{save.savedOn}} </li>
        </ul>

        <button @click="saveGame">
            Save
        </button>


    </div>
</template>

<style>
    #gameBoard, #gameBoard tr, #gameBoard td {
        border: 2px solid;
        border-color: blue;
        border-spacing: 0px;
    }

    .grass{
        height: 25px;
        width: 25PX;
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
    }

</style>

<script>
import { version } from 'vue';
import MapService from '../MapService';

export default {
    data() {
        return {
            newSaveId: 1,
            print: "", 
            cells: [],
            saves: null
        }
    },
    
    mounted(){
        for (let i = 0; i < 10; i++){
            this.cells.push([]);
            for(let j = 0; j < 10; j++){
                this.cells[i].push({x:i,y:j});
            }
        }

        this.cells[2][2].man=true;

        MapService.getVersion().then(version =>{
            this.print = version.value;
        }); 
        this.fetchSaves();
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



        selectSquare(verse, column){
            this.cells[verse][column].isSelected = true;
        },

        //TODO IS_MAN CHANGED TO ID_MAN, PASS DATA ABOUT THE MAN INTO ACTION MENU

        moveMan(verse, column){
            this.cells.forEach(element => {
                element.forEach(element2 => {
                    element2.man = false;
                })
            });
            this.cells[column][verse].man = true;
        }
    }

}
</script>