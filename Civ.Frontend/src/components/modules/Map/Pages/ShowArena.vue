<template>
    <div id="page">

        <div id="playerInfo" class="col-lg-3 col-md-4 col-sm-6">

        </div>

        <div id="gameArea" class="container-fluid">
            <div class="row">
                <table id="gameBoard" @mouseleave="cleanPath">
                    <tr v-for="col in cellArray">
                        <td v-for="square in col" :title="`${square.x}-${square.y}`"
                            @click="selectSquare(square.x, square.y)"
                            :class="square === selectedCell ? 'selected grass' : 'grass'" @mouseover="cellHover(square)"
                            @contextmenu="moveUnit($event, square.x, square.y)"
                            @dblclick="onCellDoubleClick(square.x, square.y)">
                            <img v-if="square.unit" src="../../../../assets/Images/MAN.png" />
                            {{ square.movementCounter }}
                        </td>
                    </tr>
                </table>
            </div>
        </div>

        <div id="enemyInfo" class="col-lg-3 col-md-4 col-sm-6">

        </div>
    </div>



</template>

<style>
#page {
    background-color: grey;
    width: 100vw;
    height: 100vh;
    display: flex;
}

#gameBoard,
#gameBoard tr,
#gameBoard td {
    border: 2px solid;
    border-color: blue;
    border-spacing: 0px;
}

#gameBoard td {
    height: 75px;
    min-width: 75px;
}

.grass {
    background-color: rgba(0, 255, 0, 0.222);
}

.selected {
    border-color: red !important;
}

#gameBoard td:hover {
    border-color: rgb(149, 196, 31);
    border-style: dashed;
}

#gameArea {
    flex-grow: 1;
    overflow: scroll;
}

#playerInfo {
    background-color: rgb(75, 75, 75);
    align-items: center;
}

#enemyInfo {
    background-color: rgb(75, 75, 75);
    align-items: center;
}

#gameBoard td img {
    max-width: 75px;
    max-height: 75px;
}

;
</style>

<script>
import MapService from '../MapService';
import CityModal from '../Components/CityModal.vue';
import GameSavesModal from '../../../modals/GameSavesModal.vue'
import HeroScreenModal from '../Components/HeroScreenModal.vue'
import Unit from '../Models/Unit.js'
import UnitType from '../Enums/UnitType.js'
import SaveType from '../Enums/SaveType.js'

export default {
    data() {
        return {
            newSaveId: 1,
            print: "",
            cellArray: [],
            saves: null,
            selectedCell: null,
            selectedCity: null,
            fieldSizeY: 24,
            fieldSizeX: 12,
            modal: {
                saves: false,
                city: false,
                heroScreen: false
            },
            maxSaveNumber: 5,
            isSaving: false,

            enemy: {
                units: {
                    unit1: null,
                    unit2: null,
                    unit3: null,
                    unit4: null,
                    unit5: null,
                    unit6: null,
                }
            },

            party: {
                units: {
                    unit1: null,
                    unit2: null,
                    unit3: null,
                    unit4: null,
                    unit5: null,
                    unit6: null,
                }
            }
        }
    },

    async mounted() {
        await this.fetchSaves();

        if (this.$route.params.id) {
            await this.loadGame(this.$route.params.id > 0 ? this.$route.params.id : this.saveStateComp.id);
        }
        else {
            for (let i = 0; i < this.fieldSizeX; i++) {
                this.cellArray.push([]);
                for (let j = 0; j < this.fieldSizeY; j++) {
                    this.cellArray[i].push({ x: i, y: j });
                }
            }
            this.cellArray[5][5].unit = new Unit(UnitType.Settler, "Jacek", 1);
        }
    },

    components: {
        CityModal,
        GameSavesModal,
        HeroScreenModal
    },

    computed: {
        saveStateComp() {
            return this.saves.find(s => s.saveType == 3);
        }
    },

    methods: {
        getSaveGameData() {
            let cellArray = [];
            for (let i = 0; i < this.cellArray.length; i++) {
                this.cellArray[i].forEach(cell => {
                    cell.saveId = this.newSaveId;
                });
                cellArray = cellArray.concat(this.cellArray[i]);
            }
            return cellArray;
        },

        saveGame() {
            //test this, test modal on save and load, change modal button, fix field
            let saveGameData = this.getSaveGameData();
            if (this.saves.length <= this.maxSaveNumber) {
                MapService.createSave(saveGameData, SaveType.UserSave).then(save => {

                    alert("Game Saved");
                    this.fetchSaves();
                });
            }
            else {
                this.isSaving = true;
                this.modal.saves = true;
            }
        },

        saveState() {
            let saveGameData = this.getSaveGameData();
            if (this.saveStateComp) {
                MapService.updateSave(saveGameData, SaveType.SaveState).then(version => {
                    alert("Game Saved");
                    this.fetchSaves();
                });
            }
            else {
                MapService.createSave(saveGameData, SaveType.SaveState).then(version => {
                    alert("Game Saved");
                    this.fetchSaves();
                });
            }
        },

        cleanPath() {
            for (let i = 0; i < this.cellArray.length; i++) {
                this.cellArray[i].forEach(cell => {
                    cell.movementCounter = null;
                });
            }
        },

        cellHover(cell) {
            this.cleanPath();
            if (!this.selectedCell || (this.selectedCell.x == cell.x && this.selectedCell.y == cell.y)) {
                return;
            }

            let coordinates = { x: this.selectedCell.x, y: this.selectedCell.y };
            let iteration = 0;
            while (coordinates.x != cell.x || coordinates.y != cell.y) {
                iteration++;
                if (coordinates.x != cell.x) {
                    coordinates.x += Math.sign(cell.x - this.selectedCell.x);
                }

                if (coordinates.y != cell.y) {
                    coordinates.y += Math.sign(cell.y - this.selectedCell.y);
                }

                this.cellArray[coordinates.x][coordinates.y].movementCounter = iteration;
            }
        },

        async fetchSaves() {
            await MapService.getSaves().then(saves => {
                this.saves = saves;
                if (saves) {
                    this.newSaveId = saves.length + 1;
                }
            })
        },

        updateCell(cell, clearSelection) {
            this.selectedCell = cell;
            if (clearSelection) {
                this.selectedCell = null;
            }
        },

        selectSquare(verse, column) {
            if (this.cellArray[verse][column].unit) {
                this.selectedCell = this.cellArray[verse][column];
            }
        },

        moveUnit(e, verse, column) {
            if (this.selectedCell.unit) {
                this.selectedCell.unit = false;
                this.cellArray[verse][column].unit = true;
                this.selectedCell = null;
                e.preventDefault();
            }
            else {
                alert("No unit to move.")
            }
        },

        onCellDoubleClick(verse, column) {
            this.selectedCell = this.cellArray[verse][column];
            if (this.selectedCell.unit) {
                this.modal.heroScreen = true;
            }
        },

        onExit() {
            let response = confirm("Are you sure you want to leave?");
            if (response == true) {
                this.$router.push('/');
            }
        },

        //NEW FUNCTIONS - actions during battle

        attack() {

        },

        block(){

        },

        useItem(){

        },

        skipTurn(){

        },

        getCommanderById() {

        },

        getCreatursByCommander() {

        },

        sortCreatures() {

        },

        sortEnemyCreatures() {
            
        }
    }
}
</script>