const router = require('express').Router();
const { getCompanies } = require('./controllers/companiesController')
const { SuperAdminLogin } = require('./controllers/authController')
const { GetDirMenus } = require('./controllers/dirmenusController')
const { GetEmploymentTypeCode } = require('./controllers/employmentTypeCodeController')
const { GetEmploymentCategory } = require('./controllers/employmentCategoryController')
const { GetEmploymentLeaveCategory } = require('./controllers/employmentLeaveCatogoryController')
const { GetEmploymentPayroll } = require('./controllers/employmentPayrollController')
const { GetEmploymentShift } = require('./controllers/employmentShiftController')
const { GetEmploymentDesig } = require('./controllers/employmentDesigController')
const { GetEmploymentCostCenter } = require('./controllers/employmentCostCenterCodeController')
const { GetEmploymentSectionCode } = require('./controllers/employmentSectionCodeController')
const { GetGradeCode } = require('./controllers/gradeCodeController')
const { GetEducationCode, InsertTranEducation, GetTranEducationByEmpCode, deleteTranEducation, UpdateTranEducation } = require('./controllers/eductionCodeController')
const { GetEmploymentLocationCode } = require('./controllers/locationCodeController')
const { GetEmploymentReligionCode } = require('./controllers/religionCodeController')
const { AppointmentsSavePersonel, GetAppointmentsBySeqNo, GetTranAppointmentsByCompanyCode,DeleteTranAppointmentsBySeqNo } = require('./controllers/appointmentsSavePersonelController')
const { GetMasterAllEmployees } = require('./controllers/masterAllEmployeesController')
const { GetInstitutions } = require('./controllers/institutionsController')
const { GetPositionCode } = require('./controllers/positionCodeController')
const { GetAllEmployer } = require('./controllers/allEmployerController')
const { CreateTranExperience, UpdateTranExperience, deleteTranExperience, GetTranExperienceByEmpCode } = require('./controllers/employmentExperienceController')
const { GetAllAllownces } = require('./controllers/allowncesController')
const { GetAllCheckList, InsertCheckList, GetTranhiringchecklistBySeqNo } = require('./controllers/checkListController')
const { InsertEmployeeSalary, GetEmployeeSalaryBySeqNo } = require('./controllers/employeeSalaryController')
const { GetPaymentMode } = require('./controllers/paymentModeControlller')
const { GetBankBranches } = require('./controllers/banksController')
const { InsertPayroll, GetPayRollBySeqNo } = require('./controllers/payrollController')
const { InsertTranMarriages, UpdateTranMarriages, DeleteTranMarriages, GetTranMarriagesBySeqNo } = require('./controllers/marriageController')
const { CreateFamilies, UpdateTranFamilies, DeleteTranFamilies, GetTranFamiliesBySNo, GetTranFamiliesBySeqNo } = require('./controllers/familyController')


const cors = require("cors");
const { route } = require('express/lib/router');
router.use(cors())

router.get('/', (req, res) => {
    console.log("hello world")
})

router.get('/companies/getCompanies', getCompanies)

router.post('/auth/SuperAdminLogin', SuperAdminLogin)

router.get('/dirmenus/GetDirMenus', GetDirMenus)

router.get('/employment_type_code/GetEmploymentTypeCode', GetEmploymentTypeCode)

router.get('/employment_category/GetEmploymentCategory', GetEmploymentCategory)

router.get('/employment_leave_category/GetEmploymentLeaveCategory', GetEmploymentLeaveCategory)

router.get('/employment_payroll/GetEmploymentPayroll', GetEmploymentPayroll)

router.get('/employment_shift/GetEmploymentShift', GetEmploymentShift)

router.get('/employment_desig/GetEmploymentDesig', GetEmploymentDesig)

router.get('/employment_cost_center/GetEmploymentCostCenter', GetEmploymentCostCenter)

router.get('/employment_section_code/GetEmploymentSectionCode', GetEmploymentSectionCode)

router.get('/grade_code/GetGradeCode', GetGradeCode)

router.get('/education_code/GetEducationCode', GetEducationCode)

router.get('/payment_mode/GetPaymentMode', GetPaymentMode)

router.get('/banks/GetBankBranches', GetBankBranches)

router.post('/education_code/InsertTranEducation', InsertTranEducation)

router.get('/eduation_code/GetTranEducationByEmpCode/:Emp_code', GetTranEducationByEmpCode)

router.post('/eduation_code/deleteTranEducation', deleteTranEducation)

router.post('/eduation_code/UpdateTranEducation', UpdateTranEducation)

router.get('/location_code/GetEmploymentLocationCode', GetEmploymentLocationCode)

router.get('/religion_code/GetEmploymentReligionCode', GetEmploymentReligionCode)

router.get('/master_all_employees/GetMasterAllEmployees', GetMasterAllEmployees)

router.get('/institutions/GetInstitutions', GetInstitutions)

router.get('/positions/GetPositionCode', GetPositionCode)

router.get('/appointments/GetAppointmentsBySeqNo/:No', GetAppointmentsBySeqNo)

router.post('/appointments/AppointmentsSavePersonel', AppointmentsSavePersonel)

router.get('/appointments/GetTranAppointmentsByCompanyCode', GetTranAppointmentsByCompanyCode)

router.get('/allemployer/GetAllEmployer', GetAllEmployer)

router.get('/allownces/GetAllAllownces', GetAllAllownces)

router.get('/checklist/GetAllCheckList', GetAllCheckList)

router.post('/checklist/InsertCheckList', InsertCheckList)

router.get('/checklist/GetTranhiringchecklistBySeqNo/:seqNo', GetTranhiringchecklistBySeqNo)

router.post('/employement_experience/CreateTranExperience', CreateTranExperience)

router.post('/employement_experience/UpdateTranExperience', UpdateTranExperience)

router.post('/employement_experience/deleteTranExperience', deleteTranExperience)

router.post('/employee_salary/InsertEmployeeSalary', InsertEmployeeSalary)

router.post('/payroll/InsertPayroll', InsertPayroll)

router.get('/employee_salary/GetEmployeeSalaryBySeqNo/:seqNo', GetEmployeeSalaryBySeqNo)

router.get('/payroll/GetPayRollBySeqNo/:seqno', GetPayRollBySeqNo)

router.get('/employement_experience/GetTranExperienceByEmpCode/:Emp_code', GetTranExperienceByEmpCode)

router.get('/marriages/GetTranMarriagesBySeqNo/:SeqNo', GetTranMarriagesBySeqNo)

router.post('/marriages/DeleteTranMarriages', DeleteTranMarriages)

router.post('/marriages/UpdateTranMarriages', UpdateTranMarriages)

router.post('/marriages/InsertTranMarriages', InsertTranMarriages)

router.post('/families/CreateFamilies', CreateFamilies)

router.post('/families/UpdateTranFamilies', UpdateTranFamilies)

router.post('/families/DeleteTranFamilies', DeleteTranFamilies)

router.get('/families/GetTranFamiliesBySNo/:SNo', GetTranFamiliesBySNo)

router.get('/families/GetTranFamiliesBySeqNo/:SeqNo', GetTranFamiliesBySeqNo)


router.post('/appointments/DeleteTranAppointmentsBySeqNo', DeleteTranAppointmentsBySeqNo)

module.exports = router;



// code for smart star software solutions services.All right reserved.