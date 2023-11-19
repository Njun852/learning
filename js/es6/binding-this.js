const person = {
    name: "Mosh",
    walk(){
        console.log(this.name)
    }
}

person.walk()

const walk = person.walk.bind(person)
walk()

