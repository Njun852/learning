function authorize(req, res, next) {
    const {user} = req.query
    if(!user || user != 'John') {
        return res.status(401).send('Unauthorized')
    }
    req.user = {name: user, id: 1}
    next()
}

module.exports = authorize