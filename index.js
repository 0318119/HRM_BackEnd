const express = require('express');
var bodyParser = require('body-parser');
const app = express();
const routes = require('./routes');
const cors = require('cors');
app.use(cors());
app.use(bodyParser.json({ limit: '50mb' }));
app.use(bodyParser.urlencoded({ limit: '50mb', extended: true }));


app.use(express.json());
app.use(routes);
app.use((err, req, res, next) => {
    err.statusCode = err.statusCode || 500;
    err.message = err.message || "Internal Server Error";
    res.status(err.statusCode).json({
        message: err.message,
    });
});
app.listen(5000, () => console.log('Server is running on port 5000'));

// code for smart star software solutions services.All right reserved.