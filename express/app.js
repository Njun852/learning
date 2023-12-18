const express = require('express')
const logger = require('./logger')
const authorize = require('./authorize')
const morgan = require('morgan')

const app = express()
app.use(morgan('tiny'))
app.get('/', (req, res) => {
    res.send('Homepage')
})
app.get('/login', authorize, (req, res) =>{
    res.send(req.user)
})
app.get('/about', (req, res) => {
    res.send('About')
})
app.get('/api/products', (req, res) => {
    res.send('Products')
})
app.get('/api/items', (req, res) => {
    res.send('Items')
})
app.listen(5000, () => {
    console.log('listening on port 5000...')
})