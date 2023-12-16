const express = require('express')

const app = express()

app.get('/', (req, res) => {
    console.log('user asked for resource')
    res.status(200).send("Homepage")
})
app.all("/", (req, res) => {
	res.status(200).send('<h1>Resource not found. </h1>')
})
app.listen(5000, () => console.log('listening on port 5000...'))