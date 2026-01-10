const express = require('express')
const router = express.Router()
const {getAllAnimals, getRandomAnimals} = require('../controllers/animals/ListController')
const {getAllFilters, getSubCategories, getSubcategoryAnimals, getDietAnimals, getTypeAnimals} = require('../controllers/animals/FiltersController')

router.get('/getAllAnimals/:page',getAllAnimals)
router.get('/getRandomAnimals',getRandomAnimals)
router.get('/getAllFilters',getAllFilters)
router.get('/getSubCategories/:name',getSubCategories)
router.get('/getSubcategoryAnimals/:name',getSubcategoryAnimals)
router.get('/getDietAnimals/:name/:page',getDietAnimals)
router.get('/getTypeAnimals/:name/:page',getTypeAnimals)

module.exports = router