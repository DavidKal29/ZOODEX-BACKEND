const pool = require('../../database/db.js')

const getAllAnimals = async (req,res)=>{
    let conn
    try {
        conn = await pool.getConnection()

        let page = Number(req.params.page)

        if (page<1) {
            return res.status(404).json({error:'La paginación no puede ser menor a 1'})
        }
    
        const consulta = `
            SELECT COUNT(*) OVER() as counter,
            a.id, a.name, c.name, sc.name, a.image, t.name, t.color
            FROM animals as a
            INNER JOIN animal_types as at
            ON a.id = at.id_animal
            INNER JOIN types as t
            ON at.id_type = t.id
            INNER JOIN subcategories as sc
            ON a.id_subcategory = sc.id
            INNER JOIN categories as c
            ON sc.id_category = c.id
            ORDER BY a.id
            LIMIT 30
            OFFSET ?
        `

        const offset = 30 * (page - 1)

        const [animals] = await conn.query(consulta, [offset])

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

        return res.status(500).json({error:'Error al obtener a todos los animales'})
        
    }finally{
        if (conn) {
            conn.release()
        }
    }
}

const getRandomAnimals = async (req,res)=>{
    let conn
    try {
        conn = await pool.getConnection()
    
        const consulta = `
            SELECT a.id, a.name, c.name, sc.name, a.image, t.name, t.color
            FROM animals as a
            INNER JOIN animal_types as at
            ON a.id = at.id_animal
            INNER JOIN types as t
            ON at.id_type = t.id
            INNER JOIN subcategories as sc
            ON a.id_subcategory = sc.id
            INNER JOIN categories as c
            ON sc.id_category = c.id
            ORDER BY RAND()
            LIMIT 8    
        `

        const [animals] = await conn.query(consulta)

        if (animals.length === 0) {
            return res.status(404).json({error:'No se han encontrado a los animales'})
        }

        return res.status(200).json({
            success:'Animales obtenidos con éxito', 
            animals:animals
        })

    } catch (error) {
        console.log(error);

        return res.status(500).json({error:'Error al obtener a todos los animales'})
        
    }finally{
        if (conn) {
            conn.release()
        }
    }
}


module.exports = {getAllAnimals, getRandomAnimals}