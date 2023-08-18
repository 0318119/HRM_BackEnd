
const { connection } = require('../dbConnection');
const dbConnection = connection().promise();
const { MakeToken } = require('./tokenController')
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');



exports.CreateTranExperience = async (req, res, next) => {
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
                            const [getLastData] = await dbConnection.execute('select * from tran_experiences order by ID DESC')
                            const [InsertEdu] = await dbConnection.execute(`call CreateExperience(${getLastData.length > 0 ? parseInt(getLastData[0].ID) + 1 : 1},${parseInt(req.body.Sequence_no)},${parseInt(req.body.EmployerCode)},'${req.body.designation}','${req.body.department}','${req.body.Start_Date}','${req.body.End_Date}','${req.body.SubmitFlag}','${(decoded.Emp_code)}','${new Date().toISOString()}','${decoded.Emp_code}','${new Date().toISOString()}','${decoded.Emp_code}','${new Date().toISOString()}')`)
                            if (InsertEdu.affectedRows == 1) {
                                return res.status(200).send({
                                    success: 'success',
                                    messsage: "created",
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
                            const [getLastData] = await dbConnection.execute('select * from tran_experiences order by ID DESC')
                            const [InsertEdu] = await dbConnection.execute(`call CreateExperience(${getLastData.length > 0 ? parseInt(getLastData[0].ID) + 1 : 1},${parseInt(req.body.Sequence_no)},${parseInt(req.body.EmployerCode)},'${req.body.designation}','${req.body.department}','${req.body.Start_Date}','${req.body.End_Date}','${req.body.SubmitFlag}','${(decoded.Emp_code)}','${new Date().toISOString()}','${decoded.Emp_code}','${new Date().toISOString()}','${decoded.Emp_code}','${new Date().toISOString()}')`)
                            if (InsertEdu.affectedRows == 1) {
                                MakeToken(decoded, [], "created", decoded.Emp_code).then(ree => {
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

exports.UpdateTranExperience = async (req, res, next) => {
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
                            const [InsertEdu] = await dbConnection.execute(`call UpdateExperience(${req.body.id},${parseInt(req.body.EmployerCode)},'${req.body.designation}','${req.body.department}','${req.body.Start_Date}','${req.body.End_Date}','${req.body.SubmitFlag}','${(decoded.Emp_code)}','${new Date().toISOString()}','${decoded.Emp_code}','${new Date().toISOString()}','${decoded.Emp_code}','${new Date().toISOString()}')`)
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
                            const [InsertEdu] = await dbConnection.execute(`call UpdateExperience(${req.body.id},${parseInt(req.body.EmployerCode)},'${req.body.designation}','${req.body.department}','${req.body.Start_Date}','${req.body.End_Date}','${req.body.SubmitFlag}','${(decoded.Emp_code)}','${new Date().toISOString()}','${decoded.Emp_code}','${new Date().toISOString()}','${decoded.Emp_code}','${new Date().toISOString()}')`)
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

exports.deleteTranExperience = async (req, res, next) => {
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
                            const [InsertEdu] = await dbConnection.execute(`call deleteTranExp(${req.body.id})`)
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
                            const [InsertEdu] = await dbConnection.execute(`call deleteTranExp(${req.body.ID})`)
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

exports.GetTranExperienceByEmpCode = async (req, res, next) => {
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
                            const [getOrders] = await dbConnection.execute(`call get_Experienceby_Emp_Code(${req.params.Emp_code})`)
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
                            const [getOrders] = await dbConnection.execute(`call get_Experienceby_Emp_Code(${req.params.Emp_code})`)
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
