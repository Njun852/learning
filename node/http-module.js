const http = require("http")

const server = http.createServer((req, res)=>{
    if(req.url === "/"){
		res.write("Welcome to my homepage")
	}else
	if(req.url === "/about"){
        res.write("This is the about page")
	}else{
        res.write(`
        <h1>We can't find the page you are looking for</h1>
        <a href="/">Go back home</a>
	    `)
    }
    res.end()
})

server.listen(5000)