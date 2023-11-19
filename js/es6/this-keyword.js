const person = {
    name: "Mosh",
    walk(){
        console.log(this)
    }
}

person.walk() //will print person object

const walk = person.walk //walk is a function
walk() //will refer to the window object if ran in browser