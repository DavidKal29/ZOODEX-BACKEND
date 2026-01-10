const connection = require('mysql2/promise')
const dotenv = require('dotenv').config()

const pool = connection.createPool({
    host:process.env.MYSQL_HOST,
    user:process.env.MYSQL_USER,
    password:process.env.MYSQL_PASSWORD,
    database:process.env.MYSQL_DB,
})


module.exports = pool