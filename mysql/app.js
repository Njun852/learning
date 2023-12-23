const express = require('express')
const mysql = require('mysql2')
const {readFileSync} = require('fs')
const pool = mysql.createPool({
    connectionLimit: 10,
    host: 'localhost',
    user: 'root',
    password: 'password',
    database: 'mydatabase'
})

const app = express()
const test = readFileSync('testing.sql', 'utf-8')
app.get('/', (req, res) => {
    console.log(test)
    pool.query(test, (err, response, fields) => {
        if(err) return res.status(400).json({success: false, msg: 'Something went wrong'})
        res.status(200).json(response)
    })
})
app.listen(5000, () => console.log('App listening on port 5000...'))