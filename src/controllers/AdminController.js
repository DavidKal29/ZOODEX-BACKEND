const pool = require('../database/db.js')
const bcryt = require('bcryptjs')
const jwt = require('jsonwebtoken')
const dotenv = require('dotenv').config()
const cookieOptions = require('../cookies/cookieOptions.js')

const dashboard = async (req,res)=>{
    try {
        const user = req.user

        if (!user) {
            return res.status(404).json({
                error:'No se ha encontrado al usuario de la sesión'
            })
        }

        return res.status(200).json({
            success:'Perfil obtenido con éxito',
            user:user
        })

    } catch (error) {
        console.log(error);

        return res.status(500).json({error:'Error al obtener el perfil'})
        
    }
}

const logout = async (req,res)=>{
    try {
        res.clearCookie('token',cookieOptions)

        res.status(200).json({
            success:'Sesión cerrada con éxito'
        })
        

    } catch (error) {
        console.log(error);

        return res.status(500).json({error:'Error al cerrar sesión'})
        
    }
}

const editProfile = async (req,res)=>{
    let conn
    try {

        const {email,username, password} = req.body

        const user = req.user

        conn = await pool.getConnection()
        
        if (password != '') {
            const [usersPassword] = await conn.query('SELECT password FROM users WHERE id = ?',[user.id])

            if (usersPassword.length === 0) {
                return res.status(404).json({
                    error:'No se ha podido obtener la contraseña del usuario'
                })
            }

            const passwordIsEqual = await bcryt.compare(password, usersPassword[0].password)

            if (email === user.email && username === user.username && passwordIsEqual) {
                return res.status(400).json({
                    error:'Asegurate de que al menos un campo sea distinto'
                })
            }

            const newEncriptedPassword = await bcryt.hash(password,10)

            await conn.query('UPDATE users SET email = ?, username = ?, password = ?',[email,username,newEncriptedPassword])

            return res.status(200).json({
                success:'Datos cambiado con éxito'
            })
        
        }

        if (email === user.email && username === user.username) {
            return res.status(400).json({
                error:'Asegurate de que al menos un campo sea distinto'
            })
        }else{
            await conn.query('UPDATE users SET email = ?, username = ?',[email,username])

            return res.status(200).json({
                success:'Datos cambiado con éxito'
            })
        }    

    } catch (error) {
        console.log(error);

        return res.status(500).json({error:'Error al editar el perfil'})
        
    }finally{
        if (conn) {
            conn.release()
        }
    }
}

const getEditAnimal = async (req,res)=>{
    let conn
    try {
        conn = await pool.getConnection()

        const id = req.params.id

        const consulta = `
            SELECT a.id, a.name, a.description, a.inteligence, a.height, a.weight,
            a.speed, a.danger, a.longevity, a.image,
            c.name as category, sc.id as subcategory, t.id as type, t.color as color, d.id as diet
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
            WHERE a.id = ?  
        `

        const [animals] = await conn.query(consulta, [id])
        
        if (animals.length === 0) {
            return res.status(404).json({
                error:'No se ha encontrado al animal'
            })
        }

        const animal = animals[0]

        const metadata = {}
                
        const queries = {
            'subcategories':'SELECT id, name FROM subcategories',
            'diets':'SELECT id, name FROM diets',
            'types':'SELECT id, name FROM types'
        }

        for (const key in queries) {
            
            const [data] = await conn.query(queries[key])
            
            metadata[key] = data
            
        }

        return res.status(200).json({
            success:'Animal obtenido con éxito',
            animal:animal,
            metadata:metadata
        })

        

    } catch (error) {
        console.log(error);

        return res.status(500).json({error:'Error al obtner el animal'})
        
    }finally{
        if (conn) {
            conn.release()
        }
    }
}



module.exports = {dashboard, logout ,editProfile, getEditAnimal}