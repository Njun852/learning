const express = require('express')
const {people} = require('./data')
const app = express()

app.use(express.json())

app.post('/postman/people', (req, res) => {
    const {name} = req.body
    if(name) {
        return res.status(200)
        .json({success: true, data: [...people.map(person => person.name), name]})
    }
    return res.status(400)
    .json({success: false, msg: 'Please provide a name'})
})
app.listen(5000, () => {
    console.log('Listening on port 5000....')
})