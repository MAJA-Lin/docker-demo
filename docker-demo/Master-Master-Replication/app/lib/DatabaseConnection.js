let mysql = require('mysql');

class DatabaseConnection {
    constructor(host) {
        this.connection = mysql.createConnection({
            host: host,
            user: 'root',
            password: 'root',
            database: 'prova'
        });
    }

    connect() {
        this.connection.connect((err) => {
            if (err) {
                console.error('error connecting: ' + err.stack);
                return;
            }

            console.log('connected as id ' + this.connection.threadId);
        });
    }

    close() {
        this.connection.end();
    }
}

module.exports = DatabaseConnection