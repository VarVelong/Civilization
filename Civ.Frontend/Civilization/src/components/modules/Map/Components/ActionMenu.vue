<template>
    <div>
        <ul>
            <li @click="createCity">Create City</li>
            <li>Move</li>
            <li>Attack</li>
            <li>Delete Unit</li>
        </ul>
    </div>
</template>

<style scoped>

li{
        border: 2px solid;
        list-style-type: none;
        margin-bottom: 2px;
        font-size: 14pt;
        padding-left: 5px;   
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
            this.activeCell.man = null;
            this.$emit("cellUpdated", this.activeCell);
        },
    }
}

</script>