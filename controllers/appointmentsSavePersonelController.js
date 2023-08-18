const uploadAppintments = require("../middleware/appointmentsUpload");
const fs = require('fs')
const { promisify } = require('util')
const unlinkAsync = promisify(fs.unlink)
const { connection } = require('../dbConnection');
const dbConnection = connection().promise();
const jwt = require('jsonwebtoken');


exports.AppointmentsSavePersonel = async (req, res) => {
    dbConnection
    try {
        await uploadAppintments(req, res);
        if (req.file == undefined || req.file.originalname == undefined) {
            res.status(400).send({
                message: "please upload the file"
            })
        } else {
            const [images] = await dbConnection.execute('select * from tran_appointments where Picture=?', [`/resources/static/assets/uploads/appointments/${req.file.originalname}`])
            if (images.length > 0) {
                return res.status(400).send({
                    message: `already exist`,
                });

            } else {
                if (req.file == undefined) {
                    return res.status(400).send({ message: "Please upload a file!" });
                }
                res.status(200).send({
                    result: req.file.originalname,
                });
            }
        }
    } catch (err) {
        res.status(500).send({
            message: `Could not upload the file: ${req.file.originalname}. ${err}`,
        });
    } finally {
        if (req.file == undefined || req.file.originalname == undefined) {

        }

        else {
            const [images] = await dbConnection.execute('select * from tran_appointments where Picture=?', [`/resources/static/assets/uploads/appointments/${req.file.originalname}`])
            if (images.length > 0) {
                return res.status(400).send({
                    message: `already exist:`,
                });
            } else {
                let path = "/resources/static/assets/uploads/appointments/" + req.file.originalname;
                var date = new Date()
                const [getLastData] = await dbConnection.execute('select * from tran_appointments order by Sequence_no DESC')
                const [createAppointments] = await dbConnection.execute(`call SP_PER_TranAppointments_Save_Personnel(${getLastData.length > 0 ? parseInt(getLastData[0].Sequence_no) + 1 : 1},'${new Date().toISOString()}','${req.body.Emp_name}','${req.body.Emp_Father_name}','${new Date().toISOString()}','${req.body.Emp_sex_code}','${req.body.Emp_marital_status}','${req.body.Emp_address_line1}','${req.body.Emp_address_line2}','${req.body.Emp_home_tel1}','${req.body.Emp_home_tel2}','${req.body.Emp_office_tel1}','${req.body.Emp_office_tel2}','${req.body.Emp_mobile_No}','${req.body.Emp_email}','${req.body.Emp_nic_no}','${req.body.Emp_NIC_Issue_date}','${req.body.Emp_NIC_Expiry_date}',${parseInt(req.body.Emp_Retirement_age)},'${req.body.Emp_ntn_no}','${req.body.Emp_birth_date}','${req.body.Vehicle_Registration_Number}','${req.body.Contact_Person_Name}','${req.body.Relationship}','${req.body.Contact_address1}','${req.body.Contact_address2}','${req.body.Contact_home_tel1}','${req.body.Contact_home_tel2}','${req.body.Emp_Blood_Group}',${parseInt(req.body.Employment_Type_code)},${parseInt(req.body.Emp_category)},${parseInt(req.body.Emp_Leave_category)},${parseInt(req.body.Emp_Payroll_category)},${parseInt(req.body.Shift_code)},${parseInt(req.body.Desig_code)},${parseInt(req.body.Cost_Centre_code)},${parseInt(req.body.Section_code)},${parseInt(req.body.Grade_code)},${parseInt(req.body.Edu_code)},${parseInt(req.body.Loc_code)},${parseInt(req.body.Religion_Code)},${parseInt(req.body.Supervisor_Code)},'${path}','${req.body.ContractExpiryDate}','${req.body.Emp_ID}','${req.body.Offer_Letter_date}','${req.body.Tentative_Joining_date}','${req.body.RefferedBy}',${parseInt(req.body.Probationary_period_months)},${parseInt(req.body.Notice_period_months)},${parseInt(req.body.Extended_confirmation_days)},'${req.body.Permanent_address}','${req.body.Nationality}',${parseInt(req.body.roster_group_code)},'${req.body.card_no}',${parseInt(req.body.Position_Code)},${parseInt(req.body.Company_Code)},${parseInt(req.body.UserCode)})`)
            }
        }

    }
}

exports.GetAppointmentsBySeqNo = async (req, res, next) => {
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
                            const [getOrders] = await dbConnection.execute(`call getAppointmentBySeqNo(${req.params.No})`)
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
                            const [getOrders] = await dbConnection.execute(`call getAppointmentBySeqNo(${req.params.No})`)
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


exports.GetTranAppointmentsByCompanyCode = async (req, res, next) => {
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
                            const [getOrders] = await dbConnection.execute(`call Get_tranAppointment_by_Company_Code(${decoded.Emp_code},${decoded.company_code})`)
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
                            const [getOrders] = await dbConnection.execute(`call Get_tranAppointment_by_Company_Code(${decoded.Emp_code},${decoded.company_code})`)
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

exports.DeleteTranAppointmentsBySeqNo = async (req, res, next) => {
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
                                try {
                                    var [InsertEdu] = await dbConnection.execute(`call SP_PER_TranAppointments_Delete(${parseInt(req.body.Sequence_no)})`)
                                }
                                catch (err) {
                                    return res.status(400).send({
                                        success: 'failed',
                                        messsage: err,
                                        data: []
                                    })
                                }
                            return res.status(200).send({
                                success: 'success',
                                messsage: "deleted",
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
                            try {
                                var [InsertEdu] = await dbConnection.execute(`call SP_PER_TranAppointments_Delete(${parseInt(req.body.Sequence_no)})`)
                            }
                            catch (err) {
                                return res.status(400).send({
                                    success: 'failed',
                                    messsage: err,
                                    data: []
                                })
                            }
                            MakeToken(decoded, [], "deleted", decoded.Emp_code).then(ree => {
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