import { conn } from '../../app';

const SELECT_PROPERTIES_QUERY_PART = `SELECT currency, salary, fix_outcome, cost, 
                                    ROUND(((salary - fix_outcome - cost) * (long_term / 100)),0) AS longs, 
                                    ROUND(((salary - fix_outcome - cost) * (short_term / 100)),0) AS shorts FROM planning`;


export default class Planning {
    constructor(planningItem) {
        this.currency = planningItem.currency;
        this.salary = planningItem.salary;
        this.fix_outcome = planningItem.fix_outcome;
        this.cost = planningItem.cost;
        this.long = planningItem.longs;
        this.short = planningItem.shorts;
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
            'INSERT INTO `planning` (`currency`, `salary`, `fix_outcome`, `cost`, `long_term`, `short_term`) ' +
                'VALUES (?, ?, ?, ?, ?, ?)',
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