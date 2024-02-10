
export default {
    getVersion(){
        return fetch("https://localhost:7058/Game/version", { method:"GET" })
            .then(response => {
                return response.json();
            });
    },

    saveGame(cells, saveType) {
        return fetch("https://localhost:7058/Field/create", {
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

    getSaves(){
        return fetch("https://localhost:7058/save", { method:"GET" })
            .then(response => {
                return response.json();
            });
    },

    getGameState(saveId){
        return fetch(`https://localhost:7058/field/get/${saveId}`, { method:"GET" })
            .then(response => {
                return response.json();
            });
    }
}
