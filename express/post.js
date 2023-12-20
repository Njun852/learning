const express = require('express')

const app = express()

app.use(express.static('./methods-public'))
app.use(express.json())

app.post('/api/people', (req, res) => {
    const {name} = req.body
    if(name){
    return res.status(200).json({success: true, person:name})
    }
    res.status(401).json({success: false, msg: 'Please provide a name'})
})
app.post('/login', (req, res) => {
    const {name} = req.body
    if(name){
        return res.status(200).send(`Welocme ${name}!`)
    }
    res.status(401).send('Please enter a name')
})
app.listen(5000, () => {
    console.log('Listening on port 5000....')
})