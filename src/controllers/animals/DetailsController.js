const pool = require('../../database/db.js')

const getAnimal = async (req,res)=>{
    let conn
    try {

        let name = req.params.name

        conn = await pool.getConnection()

        const consulta = `
            SELECT a.id, a.name, a.description, a.inteligence, a.height, a.weight,
                a.speed, a.danger, a.longevity, a.image,
                c.name as category, sc.name as subcategory, t.name as type, t.color as color, d.name as diet
            FROM animals as a
            INNER JOIN animal_types as at
            ON a.id = at.id_animal
            INNER JOIN types as t
            ON at.id_type = t.id
            INNER JOIN subcategories as sc
            ON a.id_subcategory = sc.id
            INNER JOIN categories as c
            ON sc.id_category = c.id
            INNER JOIN diets as d
            ON a.id_diet = d.id
            WHERE a.name = ?  
        `

        const [animal] = await conn.query(consulta,[name])

        if (animal.length === 0) {
            return res.status(404).json({
                error:'No se ha encontrado ningun animal'
            })
        }
        
        return res.status(200).json({
            success:'Animal obtenido con éxito',
            animal:animal[0]
        })

    } catch (error) {
        console.log(error);

        return res.status(500).json({error:'Error al obtener al animal'})
        
    }finally{
        if (conn) {
            conn.release()
        }
    }
}



module.exports = {getAnimal}


