'use strict';

export default function(router) {
    const groups = require('../controllers/groups-controller');
    const middleware = require('../utils/auth/middleware');

    // User role required
    router.get(
        '/groups',
        middleware.protectedUserRoute,
        groups.read_all_groups_items
    );

    router.post(
        '/groups',
        middleware.protectedUserRoute,
        groups.create_groups_item
    );
}