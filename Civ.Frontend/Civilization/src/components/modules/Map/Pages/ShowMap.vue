<template>
    <div>
       {{ print }} 

        <table id="gameBoard">
            <tr v-for="col in cells">
                <td v-for="row in col" :title="`${row.x}-${row.y}` ">
                    <img v-if="row.man" src="../../../../assets/Images/MAN.png" />
                    ddd
                </td>
            </tr>
        </table>


    </div>
</template>

<style>
    #gameBoard, #gameBoard tr, #gameBoard td {
        border: 2px solid;
        border-color: blue;
        border-spacing: 0px;
    }
</style>

<script>
import { version } from 'vue';
import MapService from '../MapService';

export default {
    data() {
        return {
            print: "", 
            cells: [
                [ {x:0,y:0}, {x:1,y:0},  {x:2,y:0},  {x:3,y:0},  {x:4,y:0} ],
                [ {x:0,y:1}, {x:1,y:1},  {x:2,y:1},  {x:3,y:1},  {x:4,y:1} ],
                [ {x:0,y:2}, {x:1,y:2},  {x:2,y:2},  {x:3,y:2},  {x:4,y:2} ],
                [ {x:0,y:3}, {x:1,y:3},  {x:2,y:3},  {x:3,y:3},  {x:4,y:3} ],
                [ {x:0,y:4}, {x:1,y:4},  {x:2,y:4},  {x:3,y:4},  {x:4,y:4} ]                
            ]
        }
    },
    mounted(){
        this.cells[3][4].man=true;

        MapService.getVersion().then(version =>{
            this.print = version.value;
        })
    }
}
</script>