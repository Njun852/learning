const express = require('express')
const {people} = require('./data')
const app = express()

app.use(express.json())

app.delete('/api/people/:id', (req, res) => {
    const {id} = req.params

    if(id && /\d/.test(id)){
        const newPeople = people.filter(person => person.id != Number(id))
        if(newPeople.length === people.length) res.status(404).json({success: false, msg: 'person not found'})
        return res.status(200).json({success:true, data: newPeople})
    }
    res.status(404).json({success: false, msg: 'please provide correct information'})
})
app.listen(5000, () => {
    console.log('Listening on port 5000....')
})