'use strict';

import Planning from '../models/planning-model';
import { errorMessages } from '../models/error-model';

export function create_Planning_item(req, res) {
    const newItem = new Planning(req.body);
    Planning.addPlanningItem(newItem, function(err, insertId) {
        if (err) {
            res.status(400).send(err);
            return;
        } else {
            res.status(200).send(
                `Picked up new planning item with the ID: ${insertId}.`
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
