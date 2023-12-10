const http = require("http")


function expensiveCalculation(){
    for(let i = 0; i < 100000; i++){
        console.log(i);
    }
}

const server = http.createServer((req, res)=>{

    switch(req.url){
        case "/":
            res.end("<h1>Home Page</h1>")
            break
        case "/about":
            expensiveCalculation()
            res.end("<h1>About Page</h1>")
            break
        default:
            res.end("<h1>Error Page</h1>")
            break
    }
})

server.listen(5000, ()=>{
    console.log("Listening to port 5000...");
})