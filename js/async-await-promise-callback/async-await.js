let stocks = {
    fruits : ["Strawberry", "Grapes", "Banana", "Apple"],
    liquid : ["Water", "Ice"],
    holder : ["Cone", "Cup", "Stick"],
    toppings : ["Chocolate", "Peanuts"]
}

let shopIsOpen = true

function time(ms){
    return new Promise((resolve, reject)=>{
        if(!shopIsOpen){
            reject(console.log("Shop is closed."))
            return
        }
        setTimeout(()=>{
            resolve()
        },ms)
    })
}

async function kitchen(){
    try{
        await time(2000)
        console.log(`${stocks.fruits[0]} selected.`)
        console.log("Started the production.")
        await time(2000)
        console.log("Fruit was cut.")
        await time(1000)
        console.log(`Added ${stocks.liquid[0]} and ${stocks.liquid[1]}.`)
        await time(1000)
        console.log("Machine started.")
        await time(2000)
        console.log(`Ice Cream placed in ${stocks.holder[0]}.`)
        await time(3000)
        console.log(`${stocks.toppings[0]} placed as toppings.`)
        await time(2000)
        console.log("Ice Cream served.")
    }catch(error){
        console.log("Customer Left")
    }finally{
        console.log("Day ended, shop is closed.")
    }
}

kitchen()