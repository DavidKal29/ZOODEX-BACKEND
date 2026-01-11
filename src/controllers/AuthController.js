const pool = require('../database/db.js')
const bcryt = require('bcryptjs')
const jwt = require('jsonwebtoken')
const dotenv = require('dotenv').config()
const cookieOptions = require('../cookies/cookieOptions.js')

const login = async (req,res)=>{
    let conn
    try {

        const {email, password} = req.body

        conn = await pool.getConnection()

        const consulta = 'SELECT * FROM users WHERE email = ?'

        const [user_exists] = await conn.query(consulta,[email])

        if (user_exists.length === 0) {
            return res.status(404).json({
                error:'No hay ninguna cuenta asociada a los datos introducidos'
            })
        }

        const passwordIsEqual = await bcryt.compare(password, user_exists[0].password)

        console.log(passwordIsEqual);
        

        if (passwordIsEqual) {
            const id = user_exists[0].id

            const JWT_SECRET_KEY = process.env.JWT_SECRET_KEY

            const token = jwt.sign({id}, JWT_SECRET_KEY, {expiresIn:'1h'})

            res.cookie('token',token,cookieOptions)

            return res.status(200).json({
                success:'Sesión iniciada correctamente'
            })
        }else{
            return res.status(404).json({
                error:'No hay ninguna cuenta asociada a los datos introducidos'
            })
        }

    } catch (error) {
        console.log(error);

        return res.status(500).json({error:'Error al iniciar sesión'})
        
    }finally{
        if (conn) {
            conn.release()
        }
    }
}




module.exports = {login}