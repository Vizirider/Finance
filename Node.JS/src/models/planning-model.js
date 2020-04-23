import { conn } from '../../app';

const SELECT_PROPERTIES_QUERY_PART = `SELECT currency, salary, fix_outcome, cost, 
                                    ROUND(((salary - fix_outcome - cost) * (long_term / 100)),0) AS long_term, 
                                    ROUND(((salary - fix_outcome - cost) * (short_term / 100)),0) AS short_term FROM planning`;


export default class Planning {
    constructor(planningItem) {
        this.currency = planningItem.currency;
        this.salary = planningItem.salary;
        this.fix_outcome = planningItem.fix_outcome;
        this.cost = planningItem.cost;
        this.long_term = planningItem.long_term;
        this.short_term = planningItem.short_term;
    }

    static getAllPlanningItems(res) {
        conn.query(
            `${SELECT_PROPERTIES_QUERY_PART} `,
            [],
            function(err, result) {
                if (err) {
                    console.log('Error: ', err);
                    res(err, null);
                } else {
                    res(null, result);
                }
            }
        );
    }

    static addPlanningItem(newItem, res) {
        conn.query(
            'UPDATE `planning` SET `currency` = ?, `salary` = ?, `fix_outcome` = ?, `cost` = ?, `long_term` = ?, `short_term` = ?' ,
            [
                newItem.currency,
                newItem.salary,
                newItem.fix_outcome,
                newItem.cost,
                newItem.long_term,
                newItem.short_term
            ],
            function(err, response) {
                if (err) {
                    console.log('Error: ', err);
                    res(err, null);
                } else {
                    res(null, response.insertId);
                }
            }
        );
    }

}