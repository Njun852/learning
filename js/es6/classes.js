class Person {
    constructor(name){
        this.name = name
    }
    walk(){
        console.log(`${this.name} is walking.`)
    }
}

const myPerson = new Person("Mosh")
myPerson.walk()

//Inheritance
class Teacher extends Person {
    constructor(name, degree){
        super(name)
        this.degree = degree
    }
    teach(){
        console.log(`${this.name} is teaching.`)
    }
}

const myTeacher = new Teacher("Mish", "Doctor")
