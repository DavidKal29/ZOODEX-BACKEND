const pool = require('../../database/db.js')

const getTop5Rankings = async (req,res)=>{
    let conn
    try {

        conn = await pool.getConnection()

        const features = ['weight','height','speed','longevity','danger','inteligence']
        const titles = ['Más Pesados','Más Altos','Más Rapidos','Más Longevos','Más Peligrosos','Más Inteligentes']

        const rankings = {}

        for (let i = 0; i < features.length; i++) {
            const consulta = `
                SELECT a.id, a.name, a.${features[i]}, a.image, sc.name as subcategory, c.name as category
                FROM animals as a
                INNER JOIN subcategories as sc
                ON a.id_subcategory = sc.id
                INNER JOIN categories as c
                ON sc.id_category = c.id
                ORDER BY ${features[i]} DESC
                LIMIT 5 
            `

            const [animals] = await conn.query(consulta) 

            if (animals.length>0) {
                rankings[titles[i]] = animals
            }
            
        }

        return res.status(200).json({
            success:'Rankings obtenidos con éxito',
            rankings:rankings
        })

    } catch (error) {
        console.log(error);

        return res.status(500).json({error:'Error al obtener los rankings'})
        
    }finally{
        if (conn) {
            conn.release()
        }
    }
}


const getFullRanking = async (req,res)=>{
    let conn
    try {

        conn = await pool.getConnection()

        let name = req.params.name

        let page = req.params.page
        page = Number(page)

        
        const features = ['weight','height','speed','longevity','danger','inteligence']
        const titles = ['Más Pesados','Más Altos','Más Rapidos','Más Longevos','Más Peligrosos','Más Inteligentes']

        if (!titles.includes(name)) {
            return res.status(404).json({
                error:'Ranking no existe'
            })
        }

        const index = titles.findIndex(title=>title === name)
        const feature = features[index]

        const consulta = `
            SELECT COUNT(*) OVER() as counter, a.${feature},a.id, a.name, 
            c.name as category, sc.name as subcategory, a.image, t.name as type, t.color as color
            FROM animals as a
            INNER JOIN animal_types as at
            ON a.id = at.id_animal
            INNER JOIN types as t
            ON at.id_type = t.id
            INNER JOIN subcategories as sc
            ON a.id_subcategory = sc.id
            INNER JOIN categories as c
            ON sc.id_category = c.id
            ORDER BY ${feature} DESC
            LIMIT 30
            OFFSET ?
        `
        const offset = 30 * (page - 1)

        let total = 0

        const [ranking] = await conn.query(consulta,[offset])

        if (ranking.length === 0) {
            return res.status(404).json({
                error:'No se han encontrado animales en este ranking'
            })
        }

        total = ranking[0].counter
        const total_pages = Math.ceil(total/30)
        
        if (page > total_pages) {
            return res.status(400).json({error:'El numero de pagina es mayor a las paginas permitidas'})
        }

        return res.status(200).json({
            success:'Ranking obtenido con éxito',
            ranking:ranking,
            total:total,
            total_pages:total_pages
        })

    } catch (error) {
        console.log(error);

        return res.status(500).json({error:'Error al obtener el ranking'})
        
    }finally{
        if (conn) {
            conn.release()
        }
    }
}



module.exports = {getTop5Rankings, getFullRanking}


