'use strict';

import Groups from '../models/groups-model';
import { errorMessages } from '../models/error-model';

export function create_groups_item(req, res) {
    const newItem = new Groups(req.body);
    Groups.addGroupsItem(newItem, function(err, insertId) {
        if (err) {
            res.status(400).send(err);
            return;
        } else {
            res.status(200).send(
                `Picked up new groups item with the ID: ${insertId}.`
            );
            return;
        }
    });
}

export function read_all_groups_items(req, res) {
    Groups.getAllGroupsItem(function(err, groups) {
        if (err) {
            res.status(400).send(err);
            return;
        } else {
            res.json({ groups });
            return;
        }
    });
}
