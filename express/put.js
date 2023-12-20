const express = require('express')
const {people} = require('./data')
const app = express()

app.use(express.json())

app.put('/api/people/:id', (req, res) => {
    const {id} = req.params
    const {name} = req.body
    if((id && name) && /\d/g.test(id)){
        const person = people.find(person => person.id === Number(id))
        if(!person)
        return res.status(404).json({success: false, msg: 'person not found'})
        return res.status(201).json({success: true, data: people.map(p => {
            if(p == person){
                p.name = name
            }
            return p
        })})
    }
    res.status(401).json({success: false, msg: 'Provide the correct information'})
})
app.listen(5000, () => {
    console.log('Listening on port 5000....')
})