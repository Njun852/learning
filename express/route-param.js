const express = require('express')
const {products} = require('./data')
const app = express()

app.get('/', (req, res) => {
    res.send('<h1>Homepage</h1> <a href="/api/products">products</a>')
})
app.get('/api/products/:productID', (req, res) => {
    const {productID} = req.params
    const product = products.find(product => product.id === Number(productID))
    if(!productID || !product){
        return res.status(404).send('Not found')
    }
    return res.send(product)
})

app.listen(5000, () => console.log("listening on port 5000..."))