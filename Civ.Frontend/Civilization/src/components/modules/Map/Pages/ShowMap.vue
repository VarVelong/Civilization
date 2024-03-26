<template>
    <div id="page">
        <div id="wrapper" class="container-fluid">s
            <div class="row">
                <div id="gameArea" class="col-lg-9 col-md-8 col-sm-6">
                    <table id="gameBoard" @mouseleave="cleanPath">
                        <tr v-for="col in cellArray">
                            <td v-for="square in col" :title="`${square.x}-${square.y}`"
                                @click="selectSquare(square.x, square.y)"
                                :class="square === selectedCell ? 'selected grass' : 'grass'"
                                @mouseover="cellHover(square)" @contextmenu="moveUnit($event, square.x, square.y)"
                                @dblclick="onCellDoubleClick(square.x, square.y)">
                                <img v-if="square.unit" src="../../../../assets/Images/MAN.png" />
                                <img v-if="square.city" src="../../../../assets/Images/baseIcon.png"
                                    :title="square.city.name" />
                                {{ square.movementCounter }}
                            </td>
                        </tr>
                    </table>
                </div>
                <div id="actionMenu" class="col-lg-3 col-md-4 col-sm-6">
                    <!-- v-show="selectedCell && selectedCell.unit" -->
                    <ActionMenu  :activeCell="selectedCell" @cellUpdated="updateCell" />
                    <div id="bottomMenu">
                        <div>
                            <button @click="saveGame">
                                Save
                            </button>
                            <button @click="isSaving = false; modal.saves = true">
                                Load
                            </button>
                        </div>
                        <div>
                            <button @click="onExit">
                                Leave to menu
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>





        <!-- <CityModal :open="modal.city" @close="modal.city = false" :city="selectedCity" @spawnUnit="spawnUnit"></CityModal> -->
        <HeroScreenModal :open="modal.heroScreen" :hero="selectedCell?.unit" @close="modal.heroScreen = false">
        </HeroScreenModal>
        <game-saves-modal :isSaving="isSaving" :open="modal.saves" @close="modal.saves = false"
            @selectedId="onSaveSelected"></game-saves-modal>
    </div>
</template>

<style>


#page {
    height: 1080px;
    width: 1920px;
    background-color: grey;
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

#bottomMenu button {
    font-size: 32px;
    padding: 5px;
    margin: 5px;
    align-items: flex-end;
}

#bottomMenu div:first-child {
    float: left;
}

#bottomMenu div:nth-child(2) {
    float: right;
}

/* #wrapper {
    width: max-content;
} */

/* #gameArea {
    float: left;
}

#bottomMenu {
    clear: both;
} */

#actionMenu {
    width: 250px;
    float: left;
    background-color: rgb(75, 75, 75);
    align-items: center;
}

#gameBoard td img {
    max-width: 75px;
    max-height: 75px;
}

.row {
    width: max-content;
}
</style>

<script>
import MapService from '../MapService';
import ActionMenu from '../Components/ActionMenu.vue';
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
            fieldSize: 10,
            modal: {
                saves: false,
                city: false,
                heroScreen: false
            },
            maxSaveNumber: 5,
            isSaving: false
        }
    },

    async mounted() {
        await this.fetchSaves();
        debugger;
        if (this.$route.params.id) {
            await this.loadGame(this.$route.params.id > 0 ? this.$route.params.id : this.saveStateComp.id);
        }
        else {
            for (let i = 0; i < this.fieldSize; i++) {
                this.cellArray.push([]);
                for (let j = 0; j < this.fieldSize; j++) {
                    this.cellArray[i].push({ x: i, y: j });
                }
            }
            this.cellArray[5][5].unit = new Unit(UnitType.Settler, "Jacek", 1);
        }
    },

    components: {
        ActionMenu,
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
                    debugger
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
            if (this.selectedCell.city) {
                this.saveState();
                this.$router.push({ name: 'city', params: { id: this.selectedCell.city.name } });
            }
            if (this.selectedCell.unit) {
                this.modal.heroScreen = true;
            }
        },

        spawnUnit(unit) {
            // if (this.selectedCell.y != this.fieldSize - 1) {
            //     this.cellArray[this.selectedCell.x][this.selectedCell.y - 1].unit = unit;
            // }
            // else {
            //     this.cellArray[this.selectedCell.x][this.selectedCell.y + 1].unit = unit;
            // }
        },

        //TODO fix axises by replacing x with y and y with x (they are opposite)

        onExit() {
            let response = confirm("Are you sure you want to leave?");
            if (response == true) {
                this.$router.push('/');
            }
        },

        async loadGame(loadId) {
            debugger;
            let flatArray = [];
            await MapService.loadGame(loadId)
                .then(cells => {
                    flatArray = cells;
                });

            let biggestX = Math.max(...flatArray.map(o => o.x));
            let biggestY = Math.max(...flatArray.map(o => o.y));
            this.cellArray = [...Array(biggestX + 1)].map(e => Array(biggestY + 1));
            flatArray.forEach(item => {
                this.cellArray[item.x][item.y] = item;
            });
        },

        onSaveSelected(loadId) {
            this.modal.saves = false;
            this.$router.go('game', { id: loadId });
        }
    }
}
</script>