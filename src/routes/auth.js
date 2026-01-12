const express = require('express')
const router = express.Router()
const {login,forgotPassword,changePassword} = require('../controllers/AuthController')

const ValidatorMiddleware = require('../middlewares/ValidatorMiddleware')
const ForgotPasswordMiddleware = require('../middlewares/ForgotPasswordMiddleware')

const LoginValidator = require('../Validators/LoginValidator')
const ForgotPasswordValidator = require('../Validators/ForgotPasswordValidator')
const ChangePasswordValidator = require('../Validators/ChangePasswordValidator')



router.post('/login',LoginValidator,ValidatorMiddleware,login)
router.post('/forgotPassword',ForgotPasswordValidator,ValidatorMiddleware,forgotPassword)
router.post('/changePassword/:token',ForgotPasswordMiddleware,ChangePasswordValidator,ValidatorMiddleware,changePassword)



module.exports = router