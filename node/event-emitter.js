const EventEmitter = require("events")

const customEmitter = new EventEmitter()

customEmitter.on("response", ()=>{
    console.log("response received");
})
customEmitter.on("response", ()=>{
	console.log("some other things")
})
customEmitter.on("response", (name)=>{
	console.log(`Hello${name ? ` ${name}`: ""}!`)
})
customEmitter.emit("response", "")