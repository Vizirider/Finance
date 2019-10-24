'use strict';

const config = require('../../../config');
import { conn } from '../../../app';
import { errorMessages } from '../../models/error-model';
import jwt from 'jsonwebtoken';

function decodeJWT(req, res, next) {
    let token = req.headers['x-access-token'] || req.headers['authorization'];
    if (token) {
        token.startsWith('Bearer ')
            ? (token = token.slice(7, token.length))
            : token.startsWith('Bearer: ')
            ? (token = token.slice(8, token.length))
            : (token = token);

        const now = Date.now().valueOf() / 1000;

        jwt.verify(
            token,
            config.tokenKey,
            { ignoreExpiration: true },
            (err, decoded) => {
                if (typeof decoded !== 'undefined') {
                    if (
                        typeof decoded.exp !== 'undefined' &&
                        decoded.exp < now &&
                        isDeviceDesktop(req)
                    ) {
                        res.status(401).send(
                            'Token expired. Please, login again!'
                        );
                        return next('Token expired.');
                    } else {
                        req.token = jwt.sign(
                            {
                                id: decoded.id,
                                name: decoded.name,
                                email: decoded.email,
                                default_site_id: decoded.default_site_id,
                                is_admin: decoded.is_admin,
                            },
                            config.tokenKey,
                            { expiresIn: config.tokenExpiration }
                        );
                        jwt.verify(
                            req.token,
                            config.tokenKey,
                            (error, newDecodedJWT) => {
                                req.decodedJWT = newDecodedJWT;
                                res.header(
                                    'Authorization',
                                    `Bearer ${req.token}`
                                );
                            }
                        );
                    }
                } else if (err) {
                    res.status(403).send(
                        `Invalid token provided! Reason: ${err.message}`
                    );
                    return next(`Invalid token. Reason: ${err.message}`);
                } else {
                    req.token = token;
                    req.decodedJWT = decoded;
                    res.header('Authorization', `Bearer ${req.token}`);
                }
            }
        );
    } else {
        res.status(403).send('No token provided!');
        return next('No token found.');
    }
}

const protectedUserRoute = (req, res, next) => {
    decodeJWT(req, res, next);
    next();
};

const protectedAdminRoute = (req, res, next) => {
    decodeJWT(req, res, next);
    if (req.decodedJWT && req.token) {
        conn.query(
            'SELECT id FROM user WHERE id = ? AND is_admin = 1',
            [req.decodedJWT.id],
            function(err, result) {
                if (err) {
                    console.log('Error: ', err);
                    res.send(err, null);
                    return;
                } else {
                    if (result.length === 1) {
                        next();
                    } else {
                        res.status(403).send(errorMessages.get(403));
                        return next(errorMessages.get(403));
                    }
                }
            }
        );
    }
};

function getIdForRequest(req) {
    return typeof req.params.id !== 'undefined'
        ? req.params.id
        : req.decodedJWT.id;
}

function isDeviceDesktop(req) {
    return (
        req.device.type
            .trim()
            .toLowerCase()
            .indexOf('desktop') > -1 ||
        req.device.type
            .trim()
            .toLowerCase()
            .indexOf('tablet') > -1
    );
}

module.exports = {
    protectedUserRoute: protectedUserRoute,
    protectedAdminRoute: protectedAdminRoute,
    getIdForRequest: getIdForRequest,
};
