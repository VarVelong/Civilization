<template>
    <div class="modal" v-show="modalActive">
        <div class="modalInner">
            <i class="fa fa-plus"></i>
            <slot />
        </div>
    </div>

</template>

<script>

    export default {
        props: {
            modalActive: Boolean
        }
    }
</script>

<style scoped>
    .modal{
        display: flex;
        height: 100vh;
        width: 100vw;
        top: 0;
        left: 0;
        position: fixed;
        align-items: center;
        justify-content: center;
        background-color: rgba(128, 128, 128, 0.718);
        
    }

    .modalInner{
        position: relative;
        background-color: silver;
        width: 40%;
        height: 80%;
        padding: 60px;
        border: 10px solid;
        border-color: darkgray;
    }

</style>