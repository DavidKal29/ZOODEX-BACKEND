const pool = require('../../database/db.js')

const getSearchAnimals = async (req,res)=>{
    let conn
    try {

        let {search} = req.body

        search = search.trim().replace(/[,.]/g, '').replace(/\s+/g, ' ')
        conn = await pool.getConnection()

        if (/^\d+$/.test(search[0])) {
            new_search = ''
            for (const s of search) {
                if (/^\d+$/.test(s)){
                    new_search += s
                }else{
                    search = new_search
                    break
                }
            }
        }


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
            WHERE a.name LIKE ? or a.id = ?
            ORDER BY a.id 
        `
        

        let search_id = parseInt(search)

        if (isNaN(search_id)) {
            search_id = -1
        }

        search = '%' + search + '%'

        const [animals] = await conn.query(consulta,[search, search_id])

        if (animals.length === 0) {
            return res.status(404).json({
                error:'No se ha encontrado ningun animal'
            })
        }
        
        return res.status(200).json({
            success:'Animales obtenidos con éxito',
            animals:animals
        })

    } catch (error) {
        console.log(error);

        return res.status(500).json({error:'Error al obtener los animales'})
        
    }finally{
        if (conn) {
            conn.release()
        }
    }
}



module.exports = {getSearchAnimals}


