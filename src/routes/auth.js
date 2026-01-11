const express = require('express')
const router = express.Router()
const {login} = require('../controllers/AuthController')
const validator = require('../middlewares/validator')

const {LoginValidator} = require('../Validators/LoginValidator')


router.post('/login',LoginValidator,validator,login)



module.exports = router