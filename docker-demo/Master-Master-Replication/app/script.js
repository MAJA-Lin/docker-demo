let DatabaseConnection = require('./lib/DatabaseConnection');
let faker = require('faker');

const firstMasterHost = 'master-1';
const secondMasterHost = 'master-2';

let firstMaster = new DatabaseConnection(firstMasterHost);
let secondMaster = new DatabaseConnection(secondMasterHost);

firstMaster.connect();

let tasks = []

for (let i = 0; i < 5; i++) {
    let firstPromise = firstMaster.query(
        'INSERT INTO persons (last_name, middle_name, first_name) VALUES (?, ?, ?)',
        [faker.name.lastName(), faker.name.title(), faker.name.firstName()],
    );

    let secondPromise = secondMaster.query(
        'INSERT INTO persons (last_name, middle_name, first_name) VALUES (?, ?, ?)',
        [faker.name.lastName(), faker.name.title(), faker.name.firstName()],
    );

    tasks.push(firstPromise);
    tasks.push(secondPromise);
}

// Collect all finished promises
Promise.all(tasks)
    .then(function () {
        console.log("Insert into master 1 completed.");
    });



firstMaster.close();
secondMaster.close();