'use strict';

import Transaction from '../models/transaction-model';
import { errorMessages } from '../models/error-model';

export function create_transaction_item(req, res) {
    const newItem = new Transaction(req.body);
    Transaction.addTransactionItem(newItem, function(err, insertId) {
        if (err) {
            res.status(400).send(err);
            return;
        } else {
            res.status(200).send(
                `Picked up new transaction item with the ID: ${insertId}.`
            );
            return;
        }
    });
}

export function read_all_transaction_items(req, res) {
    Transaction.getAllTransactionItems(function(err, transaction) {
        if (err) {
            res.status(400).send(err);
            return;
        } else {
            res.json({ transaction });
            return;
        }
    });
}

export function sum_all_transaction_items(req, res) {
    Transaction.sumAllTransactionItems(function(err, transaction) {
        if (err) {
            res.status(400).send(err);
            return;
        } else {
            res.json ({ transaction });
            return;
        }
    });
}