'use strict';

import Planning from '../models/planning-model';
import { errorMessages } from '../models/error-model';

export function create_Planning_item(req, res) {
    const newItem = new Planning(req.body);
    Planning.addPlanningItem(newItem, function(err) {
        if (err) {
            res.status(400).send(err);
            return;
        } else {
            res.status(200).send(
                `Successfully update the finance planning.`
            );
            return;
        }
    });
}

export function read_all_planning_items(req, res) {
    Planning.getAllPlanningItems(function(err, transaction) {
        if (err) {
            res.status(400).send(err);
            return;
        } else {
            res.json({ transaction });
            return;
        }
    });
}
