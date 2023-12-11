const {createReadStream} = require("fs")

const stream = createReadStream("./content/big-file.txt", {
	highWaterMark: 90000,
	encoding: "utf-8"
})

stream.on("data", (result)=>{
    console.log(result);
})
