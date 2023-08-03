<template>
    <b-modal v-model="open" size="xl" :footer="false" id="my-modal"> something1 </b-modal>
</template>

<style>
</style>

<script>

export default {
    data() {
        return {

        }
    },
    
    props: {
        value: {
            type: Boolean,
            required: true
        },
    },

    computed: {
        open: {
            get() {
                return this.value;
            },
            set(newValue) {
                this.$emit('input', newValue);
            }
        },
    }
}


</script>