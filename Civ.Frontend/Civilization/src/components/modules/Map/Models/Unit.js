export default class Unit {
    id = null;
    name = "";
    type = "";
    team = "";
 
    constructor(type, name, team) 
    {
        this.type = type;
        this.name = name;
        this.team = team;
    }
}