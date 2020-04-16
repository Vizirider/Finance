import { CATEGORIES } from '../shared/constansts';
import { conn } from '../../app';

const SELECT_PROPERTIES_QUERY_PART = `SELECT groups.groups, groups.income_outcome, groups.currency, groups.Date, groups.message`;
const INNER_JOIN_QUERY_PART = `FROM groups INNER JOIN category ON groups.product_category = category.id ORDER BY groups.Date`;


export default class Groups {
    constructor(groupsItem) {
        this.product_category = groupsItem.product_category;
        this.income_outcome = groupsItem.income_outcome;
        this.currency = groupsItem.currency;
        this.Date = new Date(groupsItem.Date);
    }

    static getAllGroupsItem(res) {
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

    static addGroupsItem(newItem, res) {
        conn.query(
            'INSERT INTO `groups` (`product_category`, `income_outcome`, `currency`, `Date`, `message`) ' +
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