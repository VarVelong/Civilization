export default class Creature {
    name = "";
    type = "";
    team = "";
    id = null;
 
    constructor(type, name, team, id) 
    {
        this.type = type;
        this.name = name;
        this.team = team;
        this.id = id;
    }
}

class Hero extends Creature {

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

    constructor(type, name, team, id){
        super(type, name, team, id);
    }

    
    Creatures = [] //place for 


}   

class Monster extends Creature {

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

    constructor(type, name, team, id){
        super(type, name, team, id);
    }
}

