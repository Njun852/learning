const person = {
    talk(){
        setTimeout(()=>console.log("this", this), 1000) //arrow functions dont rebind the "this" keyword
    }
}

person.talk()

