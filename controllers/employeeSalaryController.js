const { connection } = require('../dbConnection');
const dbConnection = connection().promise();
const { MakeToken } = require('./tokenController')
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');




exports.InsertEmployeeSalary = async (req, res, next) => {
    dbConnection
    try {
        const access_token = req.headers.access_token !== undefined ? req.headers.access_token.split('Bareer ')[1] : req.headers.access_token;
        const refresh_token = req.headers.referesh_token !== undefined ? req.headers.referesh_token.split('Bareer ')[1] : req.headers.referesh_token;
        const access_token1 = req.headers.access_token !== undefined ? req.headers.access_token.split('Bareer ')[1] : "ssss";
        const refresh_token1 = req.headers.referesh_token !== undefined ? req.headers.referesh_token.split('Bareer ')[1] : "sss";
        const [getUserAccess] = await dbConnection.execute('select * from sys_employees where access_token=?', [access_token1])
        const [getUserRefresh] = await dbConnection.execute('select * from sys_employees where refresh_token=?', [refresh_token1])
        if (getUserAccess.length > 0 || getUserRefresh.length > 0) {
            if (refresh_token == undefined && access_token == undefined) {
                return res.status(401).send({
                    failed: 'failed',
                    messsage: "unauthorized"
                })
            } else {
                if (refresh_token == undefined) {
                    const verify_access_token = jwt.verify(access_token, 'access token jwt', async (err, decoded) => {
                        if (err) {
                            return res.status(401).send({
                                failed: 'failed',
                                messsage: "unauthorized"
                            })
                        } else {
                            for (var i of req.body.allownces) {
                                try {
                                    var [InsertEdu] = await dbConnection.execute(`call SP_PER_TranAppointmentEarnings_Save(${parseInt(req.body.Sequence_no)},${parseInt(i.code)},'${new Date().toISOString()}','${new Date().toISOString()}',${parseFloat(i.amount)},${parseInt(decoded.Emp_code)},'${req.body.FirstTimeFlag}',${parseInt(decoded.company_code)})`)
                                }
                                catch (err) {
                                    return res.status(400).send({
                                        success: 'failed',
                                        messsage: "can't add duplicate entry.",
                                        data: []
                                    })
                                }
                            }
                            return res.status(200).send({
                                success: 'success',
                                messsage: "Created",
                                data: []
                            })
                        }
                    })
                } else {
                    const verify_refresh_token = jwt.verify(refresh_token, 'refersh token jwt', async (err, decoded) => {
                        if (err) {
                            return res.status(408).send({
                                messsage: "timeout error",
                                bool: false
                            })
                        } else {
                            for (var i of req.body.allownces) {
                                try {
                                    var [InsertEdu] = await dbConnection.execute(`call SP_PER_TranAppointmentEarnings_Save(${parseInt(req.body.Sequence_no)},${parseInt(i.code)},'${new Date().toISOString()}','${new Date().toISOString()}',${parseFloat(i.amount)},${parseInt(decoded.Emp_code)},'${req.body.FirstTimeFlag}',${parseInt(decoded.company_code)})`)
                                }
                                catch (err) {
                                    return res.status(400).send({
                                        success: 'failed',
                                        messsage: err,
                                        data: []
                                    })
                                }
                            }
                            MakeToken(decoded, [], "Created", decoded.Emp_code).then(ree => {
                                return res.status(200).send(ree)
                            })
                        }
                    })
                }
            }
        } else {
            return res.status(408).send({
                messsage: "timeout error",
                bool: false
            })
        }

    } catch (err) {
        next(err)
    }
}


exports.GetEmployeeSalaryBySeqNo = async (req, res, next) => {
    dbConnection
    try {
        const access_token = req.headers.access_token !== undefined ? req.headers.access_token.split('Bareer ')[1] : req.headers.access_token;
        const refresh_token = req.headers.referesh_token !== undefined ? req.headers.referesh_token.split('Bareer ')[1] : req.headers.referesh_token;
        const access_token1 = req.headers.access_token !== undefined ? req.headers.access_token.split('Bareer ')[1] : "ssss";
        const refresh_token1 = req.headers.referesh_token !== undefined ? req.headers.referesh_token.split('Bareer ')[1] : "sss";
        const [getUserAccess] = await dbConnection.execute('select * from sys_employees where access_token=?', [access_token1])
        const [getUserRefresh] = await dbConnection.execute('select * from sys_employees where refresh_token=?', [refresh_token1])
        if (getUserAccess.length > 0 || getUserRefresh.length > 0) {
            if (refresh_token == undefined && access_token == undefined) {
                return res.status(401).send({
                    failed: 'failed',
                    messsage: "unauthorized"
                })
            } else {
                if (refresh_token == undefined) {
                    const verify_access_token = jwt.verify(access_token, 'access token jwt', async (err, decoded) => {
                        if (err) {
                            return res.status(401).send({
                                failed: 'failed',
                                messsage: "unauthorized"
                            })
                        } else {
                            const [getOrders] = await dbConnection.execute(`call getEmployeeSalary(${parseInt(req.params.seqNo)},${parseInt(decoded.company_code)})`)
                            return res.status(200).send({
                                success: 'success',
                                messsage: "Fetched",
                                data: getOrders
                            })
                        }
                    })
                } else {
                    const verify_refresh_token = jwt.verify(refresh_token, 'refersh token jwt', async (err, decoded) => {
                        if (err) {
                            return res.status(408).send({
                                messsage: "timeout error",
                                bool: false
                            })
                        } else {
                            const [getOrders] = await dbConnection.execute(`call getEmployeeSalary(${parseInt(req.params.seqNo)},${parseInt(decoded.company_code)})`)
                            MakeToken(decoded, getOrders, "Fetched", decoded.Emp_code).then(ree => {
                                return res.status(200).send(ree)
                            })


                        }
                    })
                }
            }
        } else {
            return res.status(408).send({
                messsage: "timeout error",
                bool: false
            })
        }

    } catch (err) {
        next(err)
    }
}

