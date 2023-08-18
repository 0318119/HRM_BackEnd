

const mysql = require("mysql2");

function connection() {
  const dbConnection = mysql.createConnection({
    host: "localhost",
    user: "root",
    database: "hrsmart_ssssco",
    password: ""
  });

  dbConnection.connect((err) => {
    if (err) {
      console.error("Error connecting to database: " + err);
      return;
    }

    console.log("Connected to the database");
  });

  return dbConnection;
}

module.exports = { connection };



// code for smart star software solutions services.All right reserved.