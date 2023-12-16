const http = require('http')
const {readFileSync} = require('fs')

const homepage = readFileSync('homepage.html')
const aboutpage = readFileSync('aboutpage.html')
const server = http.createServer((req, res)=>{
    let data = ""
    switch(req.url){
        case "/":
            data = homepage
            break
        case "/about":
            data = aboutpage
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