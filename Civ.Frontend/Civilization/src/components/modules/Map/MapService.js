
export default {
    createSave(cells, saveType) {
        return fetch("https://localhost:7058/game/save", {
            method: "POST",
            headers: {
                'Accept': 'application/json',
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({cells:cells, saveType:saveType})})
            .then(response => {
                return response.json();
            });
    },

    updateSave(cells, saveType, slotNumber) {
        return fetch("https://localhost:7058/game/save", {
            method: "PATCH",
            headers: {
                'Accept': 'application/json',
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({cells:cells, saveType:saveType, saveSlotNumber:slotNumber})})
            .then(response => {
                return response.json();
            });
    },

    getSaves(){
        return fetch("https://localhost:7058/game/save", { method:"GET" })
            .then(response => {
                return response.json();
            });
    },

    getGameState(saveId){
        return fetch(`https://localhost:7058/game/save/${saveId}`, { method:"GET" })
            .then(response => {
                return response.json();
            });
    }
}
