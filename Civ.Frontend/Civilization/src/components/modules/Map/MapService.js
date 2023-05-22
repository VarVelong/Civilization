
export default {
    getVersion(){
        return fetch("https://localhost:7058/Game/version", { method:"GET" })
            .then(response => {
                return response.json();
            });
    }
}
