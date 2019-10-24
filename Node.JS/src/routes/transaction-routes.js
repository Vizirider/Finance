'use strict';

export default function(router) {
    const transaction = require('../controllers/transaction-controller');
    const middleware = require('../utils/auth/middleware');

    // User role required
    router.get(
        '/transaction',
        middleware.protectedUserRoute,
        transaction.read_all_transaction_items
    );

    router.get(
        '/sumtransaction',
        middleware.protectedUserRoute,
        transaction.sum_all_transaction_items
    );

    router.post(
        '/transaction',
        middleware.protectedUserRoute,
        transaction.create_transaction_item
    );
}