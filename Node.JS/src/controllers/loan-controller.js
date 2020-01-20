'use strict';

import Loan from '../models/loan-model';
import { errorMessages } from '../models/error-model';

export function create_loan_item(req, res) {
    const newItem = new Loan(req.body);
    Loan.addLoanItem(newItem, function(err, insertId) {
        if (err) {
            res.status(400).send(err);
            return;
        } else {
            res.status(200).send(
                `Picked up new loan item with the ID: ${insertId}.`
            );
            return;
        }
    });
}

export function read_all_loan_items(req, res) {
    Loan.getAllLoanItems(function(err, loan) {
        if (err) {
            res.status(400).send(err);
            return;
        } else {
            res.json({ loan });
            return;
        }
    });
}

export function sum_all_loan_items(req, res) {
    Loan.sumAllLoanItems(function(err, loan) {
        if (err) {
            res.status(400).send(err);
            return;
        } else {
            res.json({ loan });
            return;
        }
    });
}