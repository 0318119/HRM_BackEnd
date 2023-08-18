const { connection } = require('../dbConnection');
const dbConnection = connection().promise();
const jwt = require('jsonwebtoken');


exports.MakeToken = async (obj, array, mess, Emp_code) => {
    const access_token = jwt.sign({
        Emp_code: obj.Emp_code,
        Emp_name: obj.Emp_name,
        HR_security_level: obj.HR_security_level,
        Payroll_security_level: obj.Payroll_security_level,
        Allow_Calculate_Button: obj.Allow_Calculate_Button,
        Show_Own_Appraisal_Form: obj.Show_Own_Appraisal_Form,
        Show_Earning_Form: obj.Show_Earning_Form,
        Emp_User_ID: obj.Emp_User_ID,
        Sort_key: obj.Sort_key,
        password_Change_flag: obj.password_Change_flag,
        Wrong_Password_Count: obj.Wrong_Password_Count,
        Password_Change_Date: obj.Password_Change_Date,
        Report_Salary_Option_View_Flag: obj.Report_Salary_Option_View_Flag,
        Role_Code: obj.Role_Code,
        id: obj.id,
        company_code: obj.company_code
    },
        'access token jwt', {
        expiresIn: "60m"
    });
    const refresh_token = jwt.sign({
        Emp_code: obj.Emp_code,
        Emp_name: obj.Emp_name,
        HR_security_level: obj.HR_security_level,
        Payroll_security_level: obj.Payroll_security_level,
        Allow_Calculate_Button: obj.Allow_Calculate_Button,
        Show_Own_Appraisal_Form: obj.Show_Own_Appraisal_Form,
        Show_Earning_Form: obj.Show_Earning_Form,
        Emp_User_ID: obj.Emp_User_ID,
        Sort_key: obj.Sort_key,
        password_Change_flag: obj.password_Change_flag,
        Wrong_Password_Count: obj.Wrong_Password_Count,
        Password_Change_Date: obj.Password_Change_Date,
        Report_Salary_Option_View_Flag: obj.Report_Salary_Option_View_Flag,
        Role_Code: obj.Role_Code,
        id: obj.id,
        company_code: obj.company_code
    },
        'refersh token jwt', {
        expiresIn: "80m"
    });
    const [updateaccess_refresh] = await dbConnection.execute('update sys_employees set access_token=?,refresh_token=? where Emp_code=?', [access_token, refresh_token, Emp_code])
    var ress = {
        success: 'success',
        message: mess,
        access_token: access_token,
        referesh_token: refresh_token,
        data: array
    }
    return ress
}