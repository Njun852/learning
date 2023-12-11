const http = require("http")
const {createReadStream} = require("fs")

const server = http.createServer((req, res)=>{
    const stream = createReadStream("./content/big-file.txt", {
        highWaterMark: 90000,
        encoding: "utf-8"
    })
    stream.on("open", ()=>{
        stream.pipe(res)
    })
})

server.listen(5000)