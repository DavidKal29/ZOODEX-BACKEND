const dotenv = require('dotenv').config()

const cookieOptions = {
    httpOnly: (process.env.COOKIE_HTTPONLY === 'true'),
    secure: (process.env.COOKIE_SECURE === 'true'),
    sameSite: process.env.COOKIE_SAMESITE,
    maxAge: 3600 * 1000
}

module.exports = cookieOptions