<template>
    <div>
        <div id="map">
            placeholder for future minimap
        </div>

        <div id="resources" class="container-fluid">
            <div class="line">
                <div class="resource">Gold: X</div>
                <div class="resource">Mana: X</div>
                <div class="resource">Wood: X</div>
            </div>
            <div class="line">
                <div class="resource">Stone: X</div>
                <div class="resource">Cristal: X</div>
                <div class="resource">Gems: X</div>
            </div>
        </div>

        <ul>
            <li @click="createCity">Create City</li>
            <li>Attack</li>
            <li @click="deleteUnit">Delete Unit</li>
        </ul>

        <div>
            
        </div>
    </div>
</template>

<style scoped>

#map{
    border: 3px solid black;
    color: rgb(150, 150, 150);
    margin: 20px;
}

.resource{
    border: 2px solid;
    font-size: 14pt;
    padding-left: 5px; 
    padding-right: 5px;
    background-color: rgb(150, 150, 150);  
    margin: 5px;    
    width: 100%;
} 

#resources{
    display: flex;
}

.line{
    display: inline-block;
    padding: 5px;
    vertical-align: middle;
}

ul{
    display: inline-block;
    text-align: left;
    width: 90%; 
}

li{
    border: 2px solid;
    list-style-type: none;
    margin-bottom: 2px;
    font-size: 14pt;
    padding-left: 5px; 
    background-color: rgb(150, 150, 150); 
    
}

li:hover{
    border-color: red;
    background-color: rosybrown;
}

.selected{
    border-color: green;
    background-color: rgb(117, 173, 32);
}

</style>

<script>
export default {
    data() {},

    props:{
        activeCell:{
            type:Object,
            required: true
        }
    },

    methods:{
        createCity(){
            let cityName = prompt("Name your city")
            this.activeCell.city = {name: cityName};
            this.activeCell.unit = false;
            this.$emit("cellUpdated", this.activeCell, true);
        },

        deleteUnit() {
            let question = confirm("Are you sure you want to delete this unit?")
            if (question) {
                this.activeCell.unit = 0;
            }
        }
    }
}

</script>