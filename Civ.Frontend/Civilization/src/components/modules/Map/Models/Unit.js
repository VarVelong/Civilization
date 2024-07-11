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

class Hero extends Unit {

    name = null;
    baseDamage = null;
    baseDefense = null;

    stats = {
        health: null,
        mana: null,

        strength: null, //more damage
        endurance: null, //more health
        accuracy: null, //more ranged damage
        speed: null, //walks further
        inteligance: null, //more mana
    }

    units = [] //place for 


}   

class Monster extends Unit {

    name = null;
    baseDamage = null;
    baseDefense = null;

    stats = {
        health: null,
        mana: null,

        strength: null, //more damage
        endurance: null, //more health
        accuracy: null, //more ranged damage
        speed: null, //walks further
        inteligance: null, //more mana
    }
}