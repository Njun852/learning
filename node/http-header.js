const http = require('http')

const server = http.createServer((req, res)=>{
    let data = ""
    switch(req.url){
        case "/":
            data = "<h1>Home Page</h1>"
            break
        case "/about":
            data = "<h1>About page</h1>"
            break
        default:
            res.writeHead(404,"Go Home", {
                'content-type':'text/html'
            })
            res.write("<h1>404 page not found</h1>")
            res.end()
            return
        }
    res.writeHead(200, {
        'content-type':'text/html'
    })
    res.write(data)
    res.end()    
})         
            
server.listen(5000)