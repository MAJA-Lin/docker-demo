let DatabaseConnection = require('./lib/DatabaseConnection');
let faker = require('faker');

const firstMasterHost = 'master-1';
const secondMasterHost = 'master-2';

let firstMaster = new DatabaseConnection(firstMasterHost);
let secondMaster = new DatabaseConnection(secondMasterHost);

firstMaster.connect();

firstMaster.connection.query(
    'INSERT INTO persons (last_name, middle_name, first_name) VALUES (?, ?, ?)',
    [faker.name.lastName(), faker.name.title(), faker.name.firstName()],
    function (error, results, fields) {
        if (error) {
            throw error;
        }

        console.log(results);
    }
)


firstMaster.close();
secondMaster.close();