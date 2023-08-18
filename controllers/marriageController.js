const { connection } = require('../dbConnection');
const dbConnection = connection().promise();
const { MakeToken } = require('./tokenController')
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');

exports.InsertTranMarriages = async (req, res, next) => {
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
                            const [InsertEdu] = await dbConnection.execute(`call CreateMarriages(${parseInt(req.body.Sequenceno)},'${new Date().toISOString()}','${req.body.MarriageDate}','${req.body.Spausename}','${req.body.SpauseDOB}','${new Date().toISOString()}',${parseInt(decoded.Emp_code)},${parseInt(decoded.company_code)})`)
                            if (InsertEdu.affectedRows == 1) {
                                return res.status(200).send({
                                    success: 'success',
                                    messsage: "Created",
                                    data: []
                                })
                            }
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
                            const [InsertEdu] = await dbConnection.execute(`call CreateMarriages(${parseInt(req.body.Sequenceno)},'${new Date().toISOString()}','${req.body.MarriageDate}','${req.body.Spausename}','${req.body.SpauseDOB}','${new Date().toISOString()}',${parseInt(decoded.Emp_code)},${parseInt(decoded.company_code)})`)
                            if (InsertEdu.affectedRows == 1) {
                                MakeToken(decoded, [], "Created", decoded.Emp_code).then(ree => {
                                    return res.status(200).send(ree)
                                })
                            }


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

exports.UpdateTranMarriages = async (req, res, next) => {
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
                            const [InsertEdu] = await dbConnection.execute(`call UpdateMarriages(${parseInt(req.body.Sequenceno)},'${req.body.MarriageDate}','${req.body.Spausename}','${req.body.SpauseDOB}',${parseInt(decoded.company_code)})`)
                            if (InsertEdu.affectedRows == 1) {
                                return res.status(200).send({
                                    success: 'success',
                                    messsage: "updated",
                                    data: []
                                })
                            }
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
                            const [InsertEdu] = await dbConnection.execute(`call UpdateMarriages(${parseInt(req.body.Sequenceno)},'${req.body.MarriageDate}','${req.body.Spausename}','${req.body.SpauseDOB}',${parseInt(decoded.company_code)})`)
                            if (InsertEdu.affectedRows == 1) {
                                MakeToken(decoded, [], "updated", decoded.Emp_code).then(ree => {
                                    return res.status(200).send(ree)
                                })
                            }


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

exports.DeleteTranMarriages = async (req, res, next) => {
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
                            const [InsertEdu] = await dbConnection.execute(`call DeleteMarriages(${parseInt(req.body.Sequenceno)},${parseInt(decoded.company_code)})`)
                            if (InsertEdu.affectedRows == 1) {
                                return res.status(200).send({
                                    success: 'success',
                                    messsage: "deleted",
                                    data: []
                                })
                            }
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
                            const [InsertEdu] = await dbConnection.execute(`call DeleteMarriages(${parseInt(req.body.Sequenceno)},${parseInt(decoded.company_code)})`)
                            if (InsertEdu.affectedRows == 1) {
                                MakeToken(decoded, [], "deleted", decoded.Emp_code).then(ree => {
                                    return res.status(200).send(ree)
                                })
                            }


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

exports.GetTranMarriagesBySeqNo = async (req, res, next) => {
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
                            const [getOrders] = await dbConnection.execute(`call GetMarriagesBySeqNo(${req.params.SeqNo})`)
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
                            const [getOrders] = await dbConnection.execute(`call GetMarriagesBySeqNo(${req.params.SeqNo})`)
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