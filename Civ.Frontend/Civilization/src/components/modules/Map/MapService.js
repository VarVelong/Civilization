
export default {
    getVersion(){
        return fetch("https://localhost:7058/Game/version", { method:"GET" })
            .then(response => {
                return response.json();
            });
    },

    saveGame(cells) {
        return fetch("https://localhost:7058/Field/create", { method:"POST",
        headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json'
          },
        body:JSON.stringify(cells)})
            .then(response => {
                return response.json();
            });
    },

    getSaves(){
        return fetch("https://localhost:7058/save", { method:"GET" })
            .then(response => {
                return response.json();
            });
    }
}
