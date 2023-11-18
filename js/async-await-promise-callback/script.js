let stocks = {
    fruits : ["Strawberry", "Grapes", "Banana", "Apple"],
    liquid : ["Water", "Ice"],
    holder : ["Cone", "Cup", "Stick"],
    toppings : ["Chocolate", "Peanuts"]
}

let shopIsOpen = true

let order = (time, work) => {

    return new Promise((resolve, reject)=>{
        if(!shopIsOpen) {
            reject(console.log("Our shop is closed"))
            return
        }

        setTimeout(()=>{
            resolve(work())
        }, time)
    })
}

order(2000, ()=>{console.log(`${stocks.fruits[0]} selected.`)})

.then(()=>{
   return order(0, ()=>{
        console.log("Production has started.")
    })
})
.then(()=>{
    return order(2000, ()=>{
        console.log("Fruit chopped.")
    })
})
.then(()=>{
    return order(1000, ()=>{
        console.log(`${stocks.liquid[0]} and ${stocks.liquid[1]} added.`)
    })
})

.then(()=>{
    return order(1000, ()=>{
        console.log("Machine started.")
    })
})

.then(()=>{
    return order(2000, ()=>{
        console.log(`Ice Cream placed in ${stocks.holder[0]}.`)
    })
})

.then(()=>{
    return order(3000, ()=>{
        console.log(`${stocks.toppings[0]} placed on Ice Cream.`)
    })
})

.then(()=>{
    return order(2000, ()=>{
        console.log("Ice Cream served.")
    })
}).catch(()=>{
    console.log("Custemer left.")
}).finally(()=>{
    console.log("Day ended, shop is closed")
})







