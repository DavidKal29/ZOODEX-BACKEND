const pool = require('../../database/db.js')

const getAllFilters = async (req,res)=>{
    let conn
    try {
        conn = await pool.getConnection()

        let consulta = 'SELECT * FROM categories'

        const [categories] = await conn.query(consulta)

        consulta = 'SELECT * FROM diets'

        const [diets] = await conn.query(consulta)
        
        consulta = 'SELECT * FROM types'

        const [types] = await conn.query(consulta)

        if (categories.length === 0 || diets.length === 0 || types.length === 0) {
            return res.status(404).json({
                error:'No se han encontrado las categorias, dietas y tipos'
            })
        }

        return res.status(200).json({
            success:'Filtros obtenidos con éxito',
            categories:categories,
            diets:diets,
            types:types
        })

    } catch (error) {
        console.log(error);

        return res.status(500).json({error:'Error al obtener los filtros'})
        
    }finally{
        if (conn) {
            conn.release()
        }
    }
}

const getSubCategories = async (req,res)=>{
    let conn
    try {
        
        let name = req.params.name
        name = name.toUpperCase()

        conn = await pool.getConnection()

        const consulta = `
            SELECT sc.* FROM categories as c
            INNER JOIN subcategories as sc
            ON c.id = sc.id_category
            WHERE c.name = ?
        `

        const [subcategories] = await conn.query(consulta,[name])

        if (subcategories.length === 0) {
            return res.status(404).json({
                error:'No se han encontrado las subcategorias de esa categoria'
            })
        }
        
        return res.status(200).json({
            success:'Subcategorias obtenidos con éxito',
            subcategories:subcategories
        })

    } catch (error) {
        console.log(error);

        return res.status(500).json({error:'Error al obtener las subcategorias'})
        
    }finally{
        if (conn) {
            conn.release()
        }
    }
}

const getSubcategoryAnimals = async (req,res)=>{
    let conn
    try {
        
        let name = req.params.name
        name = name.toUpperCase()

        conn = await pool.getConnection()

        const consulta = `
            SELECT a.id, a.name, c.name as category, sc.name as subcategory, 
            a.image, t.name as type, t.color as color
            FROM animals as a
            INNER JOIN animal_types as at
            ON a.id = at.id_animal
            INNER JOIN types as t
            ON at.id_type = t.id
            INNER JOIN subcategories as sc
            ON a.id_subcategory = sc.id
            INNER JOIN categories as c
            ON sc.id_category = c.id
            WHERE sc.name = ?
        `

        const [animals] = await conn.query(consulta,[name])

        if (animals.length === 0) {
            return res.status(404).json({
                error:'No se han encontrado animales relacionados a esa subcategoria'
            })
        }
        
        return res.status(200).json({
            success:'Animales obtenidos con éxito',
            animals:animals
        })

    } catch (error) {
        console.log(error);

        return res.status(500).json({error:'Error al obtener los animales de esa subcategoria'})
        
    }finally{
        if (conn) {
            conn.release()
        }
    }
}

const getDietAnimals = async (req,res)=>{
    let conn
    try {
        
        let page = Number(req.params.page)

        if (page<1) {
            return res.status(404).json({error:'La paginación no puede ser menor a 1'})
        }

        let name = req.params.name
        name = name[0].toUpperCase() + name.slice(1)

        let conn = await pool.getConnection()

        const consulta = `
            SELECT COUNT(*) OVER() as counter, a.id, a.name, c.name as category, 
            sc.name as subcategory, a.image, t.name as type, t.color as color
            FROM animals as a
            INNER JOIN animal_types as at
            ON a.id = at.id_animal
            INNER JOIN types as t
            ON at.id_type = t.id
            INNER JOIN diets as d
            ON a.id_diet = d.id
            INNER JOIN subcategories as sc
            ON a.id_subcategory = sc.id
            INNER JOIN categories as c
            ON sc.id_category = c.id
            WHERE d.name = ?
            ORDER BY a.name
            LIMIT 30
            OFFSET ?
        `

        const offset = 30 * (page - 1)

        const [animals] = await conn.query(consulta, [name, offset])

        let total = 0

        if (animals.length === 0) {
            return res.status(404).json({error:'No se han encontrado a los animales'})
        }

        total = animals[0].counter

        const total_pages = Math.ceil(total/30)
        
        if (page > total_pages) {
            return res.status(400).json({error:'El numero de pagina es mayor a las paginas permitidas'})
        }

        return res.status(200).json({
            success:'Animales obtenidos con éxito', 
            animals:animals,
            total:total,
            total_pages:total_pages
        })

    } catch (error) {
        console.log(error);

        return res.status(500).json({error:'Error al obtener los animales de esa dieta'})
        
    }finally{
        if (conn) {
            conn.release()
        }
    }
}

const getTypeAnimals = async (req,res)=>{
    let conn
    try {
        
        let page = Number(req.params.page)

        if (page<1) {
            return res.status(404).json({error:'La paginación no puede ser menor a 1'})
        }

        let name = req.params.name
        name = name[0].toUpperCase() + name.slice(1)

        let conn = await pool.getConnection()

        const consulta = `
            SELECT COUNT(*) OVER() as counter, 
            a.id, a.name, c.name as category, sc.name as subcategory, 
            a.image, t.name as type, t.color as color
            FROM animals as a
            INNER JOIN animal_types as at
            ON a.id = at.id_animal
            INNER JOIN types as t
            ON at.id_type = t.id
            INNER JOIN subcategories as sc
            ON a.id_subcategory = sc.id
            INNER JOIN categories as c
            ON sc.id_category = c.id
            WHERE t.name = ?
            ORDER BY a.name
            LIMIT 30
            OFFSET ?
        `

        const offset = 30 * (page - 1)

        const [animals] = await conn.query(consulta, [name, offset])

        let total = 0

        if (animals.length === 0) {
            return res.status(404).json({error:'No se han encontrado a los animales'})
        }

        total = animals[0].counter

        const total_pages = Math.ceil(total/30)
        
        if (page > total_pages) {
            return res.status(400).json({error:'El numero de pagina es mayor a las paginas permitidas'})
        }

        return res.status(200).json({
            success:'Animales obtenidos con éxito', 
            animals:animals,
            total:total,
            total_pages:total_pages
        })

    } catch (error) {
        console.log(error);

        return res.status(500).json({error:'Error al obtener los animales de ese tipo'})
        
    }finally{
        if (conn) {
            conn.release()
        }
    }
}



module.exports = {getAllFilters, getSubCategories, getSubcategoryAnimals, getDietAnimals, getTypeAnimals}