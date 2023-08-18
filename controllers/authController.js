const { connection } = require('../dbConnection');
const dbConnection = connection().promise();
const { MakeToken } = require('./tokenController')
const bcrypt = require('bcryptjs');



exports.SuperAdminLogin = async (req, res, next) => {
    dbConnection
    try {
        const [getEmpName] = await dbConnection.execute('select * from sys_employees where Emp_name=? and company_code=?', [req.body.Emp_name, req.body.company_code])
        if (getEmpName.length > 0) {
            const passMatch = await bcrypt.compare(req.body.Emp_password, getEmpName[0].Emp_password);
            if (passMatch == false) {
                return res.status(404).send({
                    failed: 'failed',
                    message: "password not matched."
                })
            }
            else {
                MakeToken(getEmpName[0], getEmpName, "successfully login.", getEmpName[0].Emp_code).then(ree => {
                    return res.status(200).send(ree)
                })

            }
        }
        else {
            return res.status(404).send({
                failed: 'failed',
                message: "Emp_name or company code is invalid."
            })
        }

    }
    catch (err) {
        next(err)
    }
}