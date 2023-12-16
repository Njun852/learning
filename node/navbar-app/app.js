const http = require('http')
const {readFileSync} = require('fs')

const page = readFileSync('./navbar-app/index.html')
const styles = readFileSync('./navbar-app/styles.css')
const svg = readFileSync('./navbar-app/logo.svg')
const browserApp = readFileSync('./navbar-app/browser-app.js')
const server = http.createServer((req, res)=>{
    switch(req.url){
        case "/":
            res.writeHead(200, {
                'content-type': 'text/html'
            })
            res.end(page)
            break
        case '/browser-app.js':
            res.writeHead(200, {
                'content-type': 'application/javascript'
            })
            res.end(browserApp)
            break
        case "/styles.css":
            res.writeHead(200, {
                'content-type': 'text/css'
            })
            res.end(styles)
            break
        case "/logo.svg":
            res.writeHead(200, {
                'content-type': 'image/svg+xml'
            })
            res.end(svg)
            break
        default:
            res.writeHead(404, {
                'content-type': 'text/html'
            })
            res.end('<h1>Page not found</h1>')
            break
    }
}).listen(5000)