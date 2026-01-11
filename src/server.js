const express = require('express')
const cookieParser = require('cookie-parser')
const cors = require('cors')
const dotenv = require('dotenv')

const app = express()
const PORT = process.env.PORT || 5000

const animalsRoutes = require('./routes/animals')
const authRoutes = require('./routes/auth')

app.use(express.json())
app.use(express.urlencoded({extended:true}))
app.use(cors({
    origin:process.env.FRONTEND_URL,
    credentials:true
}))

app.use('/animals',animalsRoutes)
app.use('/auth',authRoutes)


app.get('/',(req,res)=>{
    res.status(200).json({success:'Bienvenido al servidor backend de ZooDex'})
})


app.listen(PORT,()=>{
    console.log(`Servidor corriendo en el puerto ${PORT}`);
})


