import { CATEGORIES } from '../shared/constansts';
import { conn } from '../../app';

const SELECT_PROPERTIES_QUERY_PART = `SELECT loan.loan, loan.amount, loan.currency, loancategory.percentage, loan.Date`;
const INNER_JOIN_QUERY_PART = `FROM loan INNER JOIN loancategory ON loan.product_category = loancategory.loancategory`;


export default class Loan {
    constructor(loanItem) {
        this.product_category = loanItem.product_category;
        this.amount = loanItem.amount;
        this.currency = loanItem.currency;
        this.Date = new Date(loanItem.Date);
    }

    static getAllLoanItems(res) {
        conn.query(
            `${SELECT_PROPERTIES_QUERY_PART}, loancategory.name AS category_name
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

    static sumAllLoanItems(res){
        conn.query(
            `SELECT SUM(amount) FROM loan`,
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

    static addLoanItem(newItem, res) {
        conn.query(
            'INSERT INTO `loan` (`product_category`, `amount`, `currency`, `Date`) ' +
                'VALUES (?, ?, ?, ?)',
            [
                newItem.product_category,
                newItem.amount,
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