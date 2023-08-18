const { connection } = require('../dbConnection');
const dbConnection = connection().promise();


exports.getCompanies = async (req, res, next) => {
    try {
        const [getCompanies] = await dbConnection.execute('select * from companies')
        return res.status(200).send({
            success: "success",
            message: "fetched",
            data: getCompanies
        })
    }
    catch (err) {
        next(err)
    }
}