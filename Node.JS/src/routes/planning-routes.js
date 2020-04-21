'use strict';

export default function(router) {
    const planning = require('../controllers/planning-controller');
    const middleware = require('../utils/auth/middleware');

    // User role required
    router.get(
        '/planning',
        middleware.protectedUserRoute,
        planning.read_all_planning_items
    );


    router.post(
        '/planning',
        middleware.protectedUserRoute,
        planning.create_Planning_item
    );
}