import { Person } from "./person.js";

export function promote(){}

//Use default keyword so we can make a default export
export default class Teacher extends Person {
    constructor(name, degree){
        super(name)
        this.degree = degree
    }
    teach(){
        console.log(`${this.name} is teaching.`)
    }
}