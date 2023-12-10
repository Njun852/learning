const http = require("http")

const server = http.createServer((req, res)=>{
	console.log("request received")
	res.end("Respond Sent")
})

server.listen(5000, ()=>{
	console.log("Listening for port 5000...")
})