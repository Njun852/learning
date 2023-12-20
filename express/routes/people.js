const express = require('express')
const router = express.Router()
const {
    getDelete,
    getPut,
    getPost,
    getPeople,
    getPostman
} = require('../controllers/people')
// router.delete('/:id', getDelete)
// router.put('/:id', getPut)
// router.post('/', getPost)
// router.get('/', getPeople)
// router.post('/postman', getPostman)

router.route('/').get(getPeople).post(getPost)
router.route('/postman').post(getPostman)
router.route('/:id').delete(getDelete).put(getPut)
module.exports = router