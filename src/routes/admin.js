const express = require('express')
const router = express.Router()
const {dashboard,logout} = require('../controllers/AdminController')
const AdminMiddleware = require('../middlewares/AdminMiddleware')


router.get('/dashboard',AdminMiddleware,dashboard)
router.get('/logout',AdminMiddleware,logout)



module.exports = router