const express = require('express')
const router = express.Router()
const {getAllAnimals, getRandomAnimals} = require('../controllers/animals/ListController')
const {getAllFilters, getSubCategories, getSubcategoryAnimals, getDietAnimals, getTypeAnimals} = require('../controllers/animals/FiltersController')
const {getAnimal} = require('../controllers/animals/DetailsController')
const {getTop5Rankings, getFullRanking} = require('../controllers/animals/RankingsController')
const {getSearchAnimals} = require('../controllers/animals/SearchController')


router.get('/getAllAnimals/:page',getAllAnimals)
router.get('/getRandomAnimals',getRandomAnimals)
router.get('/getAllFilters',getAllFilters)
router.get('/getSubCategories/:name',getSubCategories)
router.get('/getSubcategoryAnimals/:name',getSubcategoryAnimals)
router.get('/getDietAnimals/:name/:page',getDietAnimals)
router.get('/getTypeAnimals/:name/:page',getTypeAnimals)
router.get('/getAnimal/:name',getAnimal)
router.get('/getTop5Rankings',getTop5Rankings)
router.get('/getFullRanking/:name/:page',getFullRanking)
router.post('/getSearchAnimals',getSearchAnimals)



module.exports = router