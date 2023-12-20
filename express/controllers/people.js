let {people} = require('../data')
function getPeople(req, res) {
    res.status(200).json({success: true, data: [...people]})
}

function getPost(req, res){
    const {name} = req.body
    if(name){
    return res.status(200).json({success: true, person:name})
    }
    res.status(401).json({success: false, msg: 'Please provide a name'})    
}

function getPostman(req, res) {
    const {name} = req.body
    if(name) {
        return res.status(200)
        .json({success: true, data: [...people.map(person => person.name), name]})
    }
    return res.status(400)
    .json({success: false, msg: 'Please provide a name'})
}

function getPut(req, res) {
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
}

function getDelete(req, res) {
    const {id} = req.params

    if(id && /\d/.test(id)){
        const newPeople = people.filter(person => person.id != Number(id))
        if(newPeople.length === people.length) res.status(404).json({success: false, msg: 'person not found'})
        return res.status(200).json({success:true, data: newPeople})
    }
    res.status(404).json({success: false, msg: 'please provide correct information'})
}

module.exports = {
    getPeople,
    getPost,
    getDelete,
    getPostman,
    getPut
}