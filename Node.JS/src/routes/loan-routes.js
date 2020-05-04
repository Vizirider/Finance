'use strict';

export default function(router) {
    const loan = require('../controllers/loan-controller');
    const middleware = require('../utils/auth/middleware');

    // User role required
    router.get(
        '/loan',
        middleware.protectedUserRoute,
        loan.read_all_loan_items
    );

    router.get(
        '/sumloan',
        middleware.protectedUserRoute,
        loan.sum_all_loan_items
    );

    router.post(
        '/loan',
        middleware.protectedUserRoute,
        loan.create_loan_item
    );
}