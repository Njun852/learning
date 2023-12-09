const os = require("os")

const user = os.userInfo()
console.log(user)

const uptime = Math.floor(os.uptime()/3600)
console.log(`Your computer has been running for ${uptime} hour${uptime > 1 ? "s" : ""}`)

const currentOS = {
    name: os.type(),
    release: os.release(),
    totalMem: os.totalmem(),
    freeMem: os.freemem()
}

console.log(currentOS)
