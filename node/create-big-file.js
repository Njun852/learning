const {writeFileSync} = require("fs")

for(let i = 0; i < 100000; i++){
    writeFileSync("./content/big-file.txt", `Hello World: ${i}\n`, {flag: "a"})
}

console.log("Writing done");

