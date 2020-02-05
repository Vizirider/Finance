'use strict';

import catalogueRoutes from './src/routes/catalogue-routes';
import transactionRoutes from './src/routes/transaction-routes';
import loanRoutes from './src/routes/loan-routes';
import errorRoutes from './src/routes/error-routes';
import express from 'express';
import { json, urlencoded } from 'body-parser';
import userRoutes from './src/routes/user-routes';
const app = express();
const device = require('express-device');
const config = require('./config');

// SERVER CONFIGURATION
app.use(device.capture());
app.use(json());
app.use(urlencoded({ extended: true }));
app.use(express.static(__dirname));

// SETTING CORS-POLICY (FOR DEVELOPMENT)
app.use(function(req, res, next) {
    res.header('Access-Control-Allow-Origin', '*');
    res.header(
        'Access-Control-Allow-Headers',
        'Origin, X-Requested-With, Content-Type, Accept, Authorization'
    );
    res.header(
        'Access-Control-Allow-Methods',
        'GET, POST, OPTIONS, PUT, PATCH, DELETE'
    );
    res.header('Access-Control-Allow-Credentials', true);
    next();
});

// PREFIXING ROUTES
const router = express.Router();
userRoutes(router);
catalogueRoutes(router);
transactionRoutes(router);
loanRoutes(router);
errorRoutes(router);
app.use(config.appVersion, router);

// START APPLICATION
app.listen(config.appPort, () => {
    console.log(`Finance software ${config.appPort}...`);
});

// DATABASE CONNECTION
const mysql = require(config.dbDriver);
export const conn = mysql.createConnection({
    host: config.dbHost,
    user: config.dbUser,
    password: config.dbPassword,
    database: config.dbName,
    port: config.dbPort,
});
conn.connect(function(err) {
    if (err) {
        console.log('Database connection error! Error: ' + err);
    } else {
        console.log(
            `Connection to '${config.dbName}' database successful on port ${config.dbPort}!`
        );
    }
});

module.exports = app;
