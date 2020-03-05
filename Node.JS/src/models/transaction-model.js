import { CATEGORIES } from '../shared/constansts';
import { conn } from '../../app';

const SELECT_PROPERTIES_QUERY_PART = `SELECT transaction.transaction, transaction.income_outcome, transaction.currency, transaction.Date, transaction.message`;
const INNER_JOIN_QUERY_PART = `FROM transaction INNER JOIN category ON transaction.product_category = category.id ORDER BY transaction.Date`;


export default class Transaction {
    constructor(transactionItem) {
        this.product_category = transactionItem.product_category;
        this.income_outcome = transactionItem.income_outcome;
        this.currency = transactionItem.currency;
        this.Date = new Date(transactionItem.Date);
    }

    static getAllTransactionItems(res) {
        conn.query(
            `${SELECT_PROPERTIES_QUERY_PART}, category.name AS category_name
                ${INNER_JOIN_QUERY_PART}`,
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

    static sumAllTransactionItems(res){
        conn.query(
            `SELECT SUM(income_outcome) AS balance FROM transaction`,
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

    static addTransactionItem(newItem, res) {
        conn.query(
            'INSERT INTO `transaction` (`product_category`, `income_outcome`, `currency`, `Date`, `message`) ' +
                'VALUES (?, ?, ?, ?)',
            [
                newItem.product_category,
                newItem.income_outcome,
                newItem.currency,
                newItem.Date
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