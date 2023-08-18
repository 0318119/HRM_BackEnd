-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 07, 2023 at 09:43 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `hrsmart_ssssco`
--

DELIMITER $$
--
-- Procedures
--
CREATE  PROCEDURE `All_Employees` (IN `company_code` INT)   BEGIN
	SELECT *  FROM master_all_employees where Company_Code=company_code;
END$$

CREATE  PROCEDURE `Cost_Centre_code` ()   BEGIN
	SELECT *  FROM dir_cost_centres;
END$$

CREATE  PROCEDURE `CreateEducation` (IN `srno` INT, IN `EmpCode` INT, IN `EduCode` INT, IN `EduYear` INT, IN `EduGrade` TEXT, IN `Topflag` TEXT, IN `institutecode` INT, IN `postedBy` INT, IN `posteddate` TEXT, IN `Initiatedby` INT, IN `Initiatedon` TEXT)   BEGIN
	insert into tran_educations(`Sr_No`,`Emp_Code`,`Edu_Code`,`Edu_Year`,`Edu_Grade`,`Top_flag`,`institute_code`,`postedby`,`posteddate`,`Initiatedby`,`Initiatedon`) values(srno,EmpCode,EduCode,EduYear,EduGrade,Topflag,institutecode,postedBy,posteddate,Initiatedby,Initiatedon);
END$$

CREATE  PROCEDURE `CreateExperience` (IN `ids` INT, IN `EmpCode` INT, IN `EmployerCode` INT, IN `designation` TEXT, IN `department` TEXT, IN `Start_Date` TEXT, IN `End_Date` TEXT, IN `SubmitFlag` TEXT, IN `SubmitBy` TEXT, IN `SubmitOn` TEXT, IN `ApproveBy` TEXT, IN `ApproveOn` TEXT, IN `Createdby` TEXT, IN `Createdon` TEXT)   BEGIN
	insert into tran_experiences(`ID`,`Emp_Code`,`Employer_Code`,`Designation`,`Department`,`StartDate`,`EndDate`,`Submit_Flag`,`Submit_By`,`Submit_On`,`Approve_By`,`Approve_On`,`Created_by`,`Created_on`) values(ids,EmpCode,EmployerCode,designation,department,Start_Date,End_Date,SubmitFlag,SubmitBy,SubmitOn,ApproveBy,ApproveOn,Createdby,Createdon);
END$$

CREATE  PROCEDURE `CreateFamilies` (IN `Sequenceno` INT, IN `Sno` INT, IN `FamMemberType` TEXT, IN `FamMemberName` TEXT, IN `FamMemberDOB` TEXT, IN `CNICNo` TEXT, IN `companycode` INT)   BEGIN
	insert into tran_appointment_families(`Sequence_no`,`S_no`,`Fam_Member_Type`,`Fam_Member_Name`,`Fam_Member_DOB`,`CNIC_No`,`company_code`) values(Sequenceno,Sno,FamMemberType,FamMemberName,FamMemberDOB,CNICNo,companycode);
END$$

CREATE  PROCEDURE `CreateMarriages` (IN `Sequenceno` INT, IN `TransactionDate` TEXT, IN `MarriageDate` TEXT, IN `Spausename` TEXT, IN `SpauseDOB` TEXT, IN `Postingdate` TEXT, IN `Postedby` INT, IN `companycode` INT)   BEGIN
	insert into tran_appointment_marriages(`Sequence_no`,`Transaction_Date`,`Marriage_Date`,`Spause_name`,`Spause_DOB`,`Posting_date`,`Posted_by`,`company_code`) values(Sequenceno,TransactionDate,MarriageDate,Spausename,SpauseDOB,Postingdate,Postedby,companycode);
END$$

CREATE  PROCEDURE `DeleteFamilies` (IN `Sequenceno` INT, IN `Sno` INT, IN `companycode` INT)   BEGIN
	delete from tran_appointment_families where `company_code`=companycode and `Sequence_no`=Sequenceno and `S_no`=Sno;
END$$

CREATE  PROCEDURE `DeleteMarriages` (IN `Sequenceno` INT, IN `companycode` INT)   BEGIN
	DELETE from tran_appointment_marriages where `Sequence_no`=Sequenceno and `company_code`=companycode;
END$$

CREATE  PROCEDURE `deleteTranEdu` (IN `srNo` INT)   BEGIN
	DELETE from tran_educations where Sr_No=srNo;
END$$

CREATE  PROCEDURE `deleteTranExp` (IN `ids` INT)   BEGIN
	DELETE from tran_experiences where ID=ids;
END$$

CREATE  PROCEDURE `Desig_code` ()   BEGIN
	SELECT *  FROM dir_designations;
END$$

CREATE  PROCEDURE `dirsetupgets` (IN `companyCode` INT)   BEGIN
    SELECT * FROM dir_setups WHERE Company_Code = companyCode;
END$$

CREATE  PROCEDURE `dir_menus` (IN `usercode` INT, IN `companycode` INT)   with recursive MyCTE  as (
 SELECT  menucode, menulabel, ParentCode,1 AS Level, 
                 CAST((menulabel) AS VARCHAR(1000)) AS Hierarchy
    FROM    dirmenus t1
    WHERE   ParentCode=0

    UNION ALL
       
    SELECT  t2.menucode, t2.menulabel, t2.ParentCode,M.level + 1 AS Level,
                 CAST((M.Hierarchy + '->' + t2.menulabel) AS VARCHAR(1000)) AS Hierarchy
    FROM    dirmenus AS t2
            JOIN MyCTE AS M ON t2.ParentCode = M.menucode  
)
select * from MyCTE a INNER JOIN linkusermenusaccess b on a.menucode=b.menucode where b.usercode=usercode and b.company_code=companycode$$

CREATE  PROCEDURE `dir_setups` (IN `company_code` INT(50))   BEGIN
	SELECT *  FROM dir_setups where Company_Code=company_code;
END$$

CREATE  PROCEDURE `dummy` (IN `value` INT)   proc_label:BEGIN
     IF value < 0 THEN
     SELECT 'Value cannot be negative';
          LEAVE proc_label;
     END IF;
     
    IF value < 0 THEN
        SELECT 'Value cannot be negative';
     
    ELSE
        SELECT 'Value is valid';
    END IF;
END$$

CREATE  PROCEDURE `Edu_code` ()   BEGIN
	SELECT *  FROM dir_educations;
END$$

CREATE  PROCEDURE `employmnt_type_code` ()   BEGIN
	SELECT *  FROM dir_employment_types;
END$$

CREATE  PROCEDURE `Emp_category` ()   BEGIN
	SELECT *  FROM dir_employee_categories;
END$$

CREATE  PROCEDURE `Emp_Leave_category` ()   BEGIN
	SELECT *  FROM dir_leave_categories;
END$$

CREATE  PROCEDURE `Emp_Payroll_category` ()   BEGIN
	SELECT *  FROM dir_payroll_categories;
END$$

CREATE  PROCEDURE `getAllFamiliesBySeqNo` (IN `seqNo` INT)   BEGIN
	SELECT *  FROM tran_appointment_families where Sequence_no=seqNo;
END$$

CREATE  PROCEDURE `getAllFamiliesBySno` (IN `Sno` INT)   BEGIN
	SELECT *  FROM tran_appointment_families where S_no=Sno;
END$$

CREATE  PROCEDURE `getAppointmentBySeqNo` (IN `seqNo` INT)   BEGIN
	SELECT a.Sequence_no,a.Emp_name,c.Dept_name,d.Desig_name FROM tran_appointments a 
inner join dir_sections  b on a.Section_code=b.Section_code
inner join dir_departments c on b.Dept_code=c.Dept_code
inner join dir_designations d on a.Desig_code=d.Desig_code where a.Sequence_no=seqNo;
END$$

CREATE  PROCEDURE `getEmployeeSalary` (IN `seqNo` INT, IN `companyCode` INT)   BEGIN
	SELECT *  FROM tran_appointment_earnings where Sequence_no=seqNo and company_code=companyCode;
END$$

CREATE  PROCEDURE `GetMarriagesBySeqNo` (IN `Sequenceno` INT)   BEGIN
	select * from tran_appointment_marriages where `Sequence_no`=Sequenceno;
END$$

CREATE  PROCEDURE `get_all_bank_branches` ()   BEGIN
	SELECT *  FROM dir_bank_branches;
END$$

CREATE  PROCEDURE `get_All_Check_List` ()   BEGIN
	SELECT *  FROM dir_hiring_checklist;
END$$

CREATE  PROCEDURE `get_All_Employers` ()   BEGIN
	SELECT *  FROM dir_previous_employers;
END$$

CREATE  PROCEDURE `get_all_payment_mode` ()   BEGIN
	SELECT *  FROM dir_mode_of_payments;
END$$

CREATE  PROCEDURE `get_Educationby_Emp_Code` (IN `empCode` INT)   BEGIN
	SELECT *  FROM tran_educations where Emp_Code=empCode;
END$$

CREATE  PROCEDURE `get_Experienceby_Emp_Code` (IN `empCode` INT)   BEGIN
	SELECT *  FROM tran_experiences where Emp_Code=empCode;
END$$

CREATE  PROCEDURE `Get_Institutions` ()   BEGIN
	SELECT *  FROM dir_institutions;
END$$

CREATE  PROCEDURE `get_payroll_by_seqno` (IN `seqno` INT)   BEGIN
	SELECT *  FROM tran_appointments where Sequence_no=seqno;
END$$

CREATE  PROCEDURE `Get_tranAppointment_by_Company_Code` (IN `user_code` INT, IN `companycode` INT)   BEGIN
	SELECT * from tran_appointments where UserCode=user_code and Company_Code=companycode;
END$$

CREATE  PROCEDURE `get_tran_hiring_chk_By_seqNo` (IN `seqno` INT, IN `companycode` INT)   BEGIN
	SELECT *  FROM tran_hiring_checklist where SeqNo=seqno and company_code=companycode;
END$$

CREATE  PROCEDURE `Grade_code` ()   BEGIN
	SELECT *  FROM dir_grades;
END$$

CREATE  PROCEDURE `Loc_code` ()   BEGIN
	SELECT *  FROM dir_locations;
END$$

CREATE  PROCEDURE `PositionCode` ()   BEGIN
	SELECT *  FROM dir_positions;
END$$

CREATE  PROCEDURE `Religion_code` ()   BEGIN
	SELECT *  FROM dir_religions;
END$$

CREATE  PROCEDURE `Section_code` ()   BEGIN
	SELECT *  FROM dir_sections;
END$$

CREATE  PROCEDURE `Shift_code` ()   BEGIN
	SELECT *  FROM dir_shifts;
END$$

CREATE  PROCEDURE `SP_PAY_DirAllowances_List_AppFlagY` ()   BEGIN
    SELECT allowance_code, Allowance_name
    FROM dir_allowances
    WHERE appointment_flag = 'Y';
END$$

CREATE  PROCEDURE `SP_PER_TranAppointmentEarnings_Save` (IN `Emp_code` INT, IN `Allowance_code` INT, IN `Transaction_Date` TEXT, IN `Increment_Date` TEXT, IN `Amount` DECIMAL(18,2), IN `Posted_by` INT, IN `FirstTimeFlag` VARCHAR(1), IN `companycode` INT)   BEGIN
    START TRANSACTION;

    SELECT emp_appointment_date INTO @Increment_Date
    FROM tran_appointments
    WHERE Sequence_no = Emp_code;

    IF FirstTimeFlag = 'Y' THEN
        DELETE FROM tran_appointment_earnings
        WHERE Sequence_no = Emp_code;
    END IF;

    INSERT INTO tran_appointment_earnings
    VALUES (Emp_code, Transaction_Date, Allowance_code, Increment_Date, Amount, NOW(), Posted_by,companycode);

    UPDATE tran_appointments
    SET Status = 'Salary Done'
    WHERE Sequence_no = Emp_code;

    INSERT INTO log_tran_appointment_earnings
    VALUES (Emp_code, NOW(), Allowance_code, Increment_Date, Amount, NOW(), Posted_by,companycode);

    COMMIT;
END$$

CREATE  PROCEDURE `SP_PER_TranAppointments_Process` (IN `Sequence_no` INT, IN `InputEmpCode` VARCHAR(50), IN `PayrollMonth` INT, IN `v_UserCode` INT, IN `v_Replacement_flag` CHAR(1), IN `v_Replacement_emp_code` INT)   SP_PER_TranAppointments_Process:BEGIN
  DECLARE empnametopost VARCHAR(100);
  DECLARE maximum_date_save_this_transaction DATETIME;
  DECLARE Probationary_period_months INT;
  DECLARE Transaction_Date DATETIME;
  DECLARE Emp_appointment_date DATETIME;
  DECLARE save_process_counter INT;
  DECLARE payrollmonth_for_stoflag INT;
  DECLARE p_PayrollMonth INT;
  DECLARE HR_Entry_Stop_Flag CHAR(1);
  
  DECLARE CompEmpLimit INT;
  DECLARE AutoEmpCodeType VARCHAR(1);
  DECLARE Emp_Code INT;
  DECLARE PayrollModuleFlag VARCHAR(1);
  DECLARE Emp_Payroll_Category INT;
  DECLARE Payroll_Year INT;
  DECLARE Payroll_Month INT;
  DECLARE Position_code INT;
  DECLARE FuelFlag VARCHAR(1);
  DECLARE v_empnametopost VARCHAR(100);                    
DECLARE v_maximum_date_save_this_transaction DATETIME(3);                    
Declare v_Probationary_period_months int;                    
Declare v_Transaction_Date Datetime(3);                     
Declare v_Emp_appointment_date Datetime(3);                    
  DECLARE v_save_process_counter INT;   
  DECLARE v_payrollmonth_for_stoflag INT; 
  
DECLARE v_HR_Entry_Stop_Flag VARCHAR(1);  
       
DECLARE v_CompEmpLimit INT;                    
DECLARE v_AutoEmpCodeType VARCHAR(1);                    
DECLARE v_Emp_code INT;                    
DECLARE v_PayrollModuleFlag VARCHAR(1);                    
DECLARE v_Emp_Payroll_Category INT;                    
DECLARE v_Payroll_Year INT;                    
DECLARE v_Payroll_Month INT;                    
DECLARE v_Position_code INT;  
  DECLARE v_FuelFlag VARCHAR(1);   
  DECLARE v_leave_encashment_calculation_Monthly_flag VARCHAR(1);                    
DECLARE v_leave_encashment_allowance_code INT;                    
DECLARE v_shift_allowance_calculation_Monthly_flag VARCHAR(1);                    
DECLARE v_shift_allowance_code INT; 
         
DECLARE v_gross_amount NUMERIC(12, 0);                    
   
 DECLARE v_shift_allowance_calculation_flag VARCHAR(1); 
                     
   DECLARE v_shift_group_leave_encashment_flag VARCHAR(1);                    
 DECLARE v_apt_date DATETIME(3);                    
declare v_Emp_Leave_Category int;                      
 
DECLARE v_EmpTypeCode INT;                    
                    
 
DECLARE v_PermanantFlag VARCHAR(1);                    
                    
         
DECLARE v_desig_code_for_branch INT;                    
DECLARE v_loc_code_for_branch INT;                    
            declare Leave_type_code int;                                    
 declare Annual_Credit decimal(18,0);                                     
 declare v_Leave_ent_days  decimal(5, 1);                                    
 declare v_Leave_ent_hours decimal(18,0);                                    
 declare v_Leave_Balance_days decimal(5, 1);             
 declare v_Leave_Balance_hours decimal(18,0);     
    declare v_Months integer;                       
 declare v_days_A decimal(5, 1);                                    
    declare v_Points Numeric(4,1);                                    
 declare Proportionate_flag varchar(1);                    
 declare Join_Confirm_flag varchar(1);            
 declare v_Confirmation_Date datetime(3);                    
 declare v_EligibiltyDate Datetime(3);                                    
                                     
Declare  v_ESS_GroupCode int;                   
Declare  v_ess_block_flag char(1);


DECLARE Leave_Type_cursor CURSOR FOR
SELECT Leave_type_code, Annual_Credit, Proportionate_flag, Join_Confirm_flag
FROM dir_leave_types
WHERE leave_category_code = @Emp_Leave_Category
AND on_confirm_flag = 'N';

DECLARE CONTINUE HANDLER FOR NOT FOUND SET @finished = 1;

OPEN Leave_Type_cursor;

FETCH Leave_Type_cursor INTO Leave_Type_Code, Annual_Credit, Proportionate_flag, Join_Confirm_flag;

IF (@finished = 1) THEN
  CLOSE Leave_Type_cursor;
  LEAVE SP_PER_TranAppointments_Process;
END IF;

WHILE (@finished = 0) DO
  SET @Leave_ent_days = Annual_Credit;
  SET @Leave_Balance_days = Annual_Credit;
  SET @EligibiltyDate = @Confirmation_Date;

  IF Join_Confirm_flag = 'J' THEN
    SET @EligibiltyDate = @Emp_appointment_date;
  END IF;

  IF Proportionate_flag = 'Y' THEN
    -- Calculate days
    IF YEAR(@EligibiltyDate) = YEAR(CURDATE()) - 1 THEN
      SET @Months = 12;
    ELSE
      SET @Months = 12 - MONTH(@EligibiltyDate);
      IF DAY(@EligibiltyDate) < 15 THEN
        SET @Months = @Months + 1;
      END IF;
    END IF;

    SET @days_A = (@Months * Annual_Credit) / 12;
    SET @Points = @days_A - FLOOR(@days_A);

    SET @Leave_ent_days = FLOOR(@days_A);
    SET @Leave_Balance_days = FLOOR(@days_A);

    IF (@Points >= 0.01 AND @Points <= 0.50) THEN
      SET @Leave_ent_days = @Leave_ent_days + 0.5;
      SET @Leave_Balance_days = @Leave_Balance_days + 0.5;
    END IF;

    IF (@Points > 0.50) THEN
      SET @Leave_ent_days = @Leave_ent_days + 1;
      SET @Leave_Balance_days = @Leave_Balance_days + 1;
    END IF;
  END IF;

  INSERT INTO Master_Leaves
  values
  (@Emp_code,
   @Leave_Type_code,
   @Leave_ent_days,
   0,
   0,
   @Leave_Balance_days,
   0,
   0,
   0,
   'N',
   YEAR(CURDATE()));

  FETCH Leave_Type_cursor INTO Leave_Type_Code, Annual_Credit, Proportionate_flag, Join_Confirm_flag;
END WHILE;

CLOSE Leave_Type_cursor;

  
  SELECT MAX(postedon) INTO maximum_date_save_this_transaction
  FROM Log_Tran_Appointments
  WHERE Sequence_no = Sequence_no;
  
  SELECT emp_name, Probationary_period_months, Transaction_Date, Emp_appointment_date
  INTO empnametopost, Probationary_period_months, Transaction_Date, Emp_appointment_date
  FROM Tran_Appointments
  WHERE Sequence_no = Sequence_no;
  
  SET save_process_counter = 0;
  
  SELECT COUNT(*) INTO save_process_counter
  FROM Log_Tran_Appointments
  WHERE sequence_no = Sequence_no
    AND posteddby = UserCode
    AND emp_name = empnametopost
    AND postedon = maximum_date_save_this_transaction;
  
  SELECT HR_Entry_Stop_Flag INTO HR_Entry_Stop_Flag
  FROM Dir_Setups;
  
  IF EXISTS (
    SELECT *
    FROM Master_All_Employees
    WHERE Emp_Id = InputEmpCode
  ) THEN
    SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'This Employee Code already assigned job Cancelled';
      LEAVE SP_PER_TranAppointments_Process;
  END IF;
  
  IF EXISTS (
    SELECT *
    FROM History_Contract_To_Permanant
    WHERE Old_Emp_id = InputEmpCode
  ) THEN
       SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Employee code already exists in History Contracts';
      LEAVE SP_PER_TranAppointments_Process;
  END IF;
  
  IF PayrollMonth = 0 THEN
    IF HR_Entry_Stop_Flag = 'Y' THEN
         SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'You cannot process this transaction because Payroll Section has stopped HR entry';
      LEAVE SP_PER_TranAppointments_Process;
    END IF;
  END IF;
  
  -- Continue with the rest of your code logic
  SELECT max(postedon) INTO v_maximum_date_save_this_transaction                    
FROM Log_Tran_Appointments                    
WHERE Sequence_no = p_Sequence_no;                    
                    
-- SQLINES DEMO *** n_Appointments  order by 1 desc            
                    
-- SQLINES LICENSE FOR EVALUATION USE ONLY
SELECT emp_name,Probationary_period_months,Transaction_Date,                    
       Emp_appointment_date INTO v_empnametopost, v_Probationary_period_months, v_Transaction_Date, v_Emp_appointment_date                    
FROM Tran_Appointments                    
WHERE Sequence_no = p_Sequence_no;                    
                    
                    
                     
                    
SET v_save_process_counter = 0;                    
                    
-- SQLINES LICENSE FOR EVALUATION USE ONLY
SELECT ifnull(count(*), 0) INTO v_save_process_counter                    
FROM Log_Tran_Appointments                    
WHERE sequence_no = p_Sequence_no                    
 AND posteddby = p_UserCode                    
 AND emp_name = v_empnametopost                    
 AND postedon = v_maximum_date_save_this_transaction;                    
                    
-- SQLINES DEMO *** _counter>0                                        
--  SQLINES DEMO ***                                                                      
-- SQLINES DEMO *** ake this transaction, You can not process it ',16,1)                                                                                  
--  SQLINES DEMO ***                                                                       
--  SQLINES DEMO ***                                                                    
                    
                    
SET v_payrollmonth_for_stoflag = p_PayrollMonth;                    
                                      
                    
SET v_HR_Entry_Stop_Flag = (                    
  SELECT HR_Entry_Stop_Flag                    
  FROM Dir_Setups                    
  );                    
                    
IF EXISTS (                    
  SELECT *                    
  FROM Master_All_Employees                    
  WHERE Emp_Id = p_InputEmpCode                    
  )                    
THEN                    
 SIGNAL SQLSTATE '02000' SET MESSAGE_TEXT =                     
   'This Employee Code already assigned job Cancelled'                    
;                    
                    
 LEAVE SP_PER_TranAppointments_Process;                    
END IF;                    
 IF Exists(select * From History_Contract_To_Permanant          
     where Old_Emp_id=p_InputEmpCode)          
 Then          
     signal SQLSTATE '02000' SET MESSAGE_TEXT = 'Employee code already exists in History Contracts';          
  leave SP_PER_TranAppointments_Process;          
 End if;                    
IF p_PayrollMonth = 0                    
THEN                    
 IF v_HR_Entry_Stop_Flag = 'Y'                    
 THEN                    
  SIGNAL SQLSTATE '02000' SET MESSAGE_TEXT =                     
    'You can not process this transaction because Payroll Section has stopped HR entry'                    
;            
                    
  LEAVE SP_PER_TranAppointments_Process;            
 END IF;                    
END IF;                    
                    
                   
                  
   BEGIN                
 start transaction;                      
                  
-- SQLINES LICENSE FOR EVALUATION USE ONLY
select Position_code into v_Position_code from Tran_Appointments  
where Sequence_no=p_Sequence_no;  
  
                    
SET v_CompEmpLimit = (                    
  SELECT Company_Employee_Code_Limit                    
  FROM Dir_Setups                    
  );                    
SET v_AutoEmpCodeType = (                    
  SELECT Auto_Emp_Code_Type                    
FROM dir_Setups                    
  );                    
SET v_PayrollModuleFlag = (                    
  SELECT Payroll_Module_Flag                    
  FROM dir_Setups                    
  );                    
SET v_Emp_code = (            
 SELECT max(emp_code) + 1                    
  FROM Master_All_Employees                    
  );                    
                    
                 
IF EXISTS (                    
  SELECT *                    
  FROM dir_grades                    
  WHERE grade_code = (                    
    SELECT grade_code                    
    FROM Tran_Appointments                    
    WHERE Sequence_no = p_Sequence_no                    
    )                    
   AND Litres_for_Petrol > 0                    
  )                    
THEN                    
 SET v_FuelFlag = 'Y';                    
ELSE                    
 SET v_FuelFlag = 'N';                    
END IF;                    
                    
-- SQLINES DEMO *** ter_Employees            
                                
IF v_PayrollModuleFlag = 'Y'                    
THEN                    
 -- SQLINES LICENSE FOR EVALUATION USE ONLY
 INSERT INTO Master_Employees                    
 SELECT v_Emp_code                    
  ,now(3)                    
  ,Emp_name                    
  ,Emp_Father_name                    
  ,Emp_sex_code                    
  ,Emp_marital_status                    
  ,Emp_birth_date                    
  ,Emp_appointment_date                    
  ,Emp_confirm_date                    
  ,Emp_Category                    
  ,Emp_Leave_Category                    
  ,Emp_address_line1                    
  ,Emp_address_line2                    
  ,Emp_home_tel1                    
  ,Emp_home_tel2                    
  ,Emp_office_tel1                    
  ,Emp_office_tel2                    
  ,Emp_mobile_No                    
  ,Emp_nic_no                    
  ,Emp_nic_issue_date                    
  ,Emp_nic_expiry_date                    
  ,Emp_retirement_age                    
  ,Emp_ntn_no                    
  ,Emp_email                    
  ,'N'                    
  ,Empt_Type_code                    
  ,Desig_code                    
  ,Grade_code                    
  ,Cost_Centre_code                    
  ,Dept_code                    
  ,Section_Code                    
  ,Shift_Code                    
  ,Loc_code                    
  ,Edu_code                    
  ,Transport_code                    
  ,Supervisor_Code                    
  ,Religion_Code                    
  ,'N'                    
  ,Contact_Person_Name                    
  ,Relationship                    
  ,Contact_address1                    
  ,Contact_address2                    
  ,Contact_home_tel1                    
  ,Contact_home_tel2                    
  ,Emp_Blood_Group                    
  ,Vehicle_Registration_Number                    
  ,Emp_Payroll_category                    
 ,Mode_Of_Payment                 
  ,Bank_Account_No1     
  ,Branch_Code1                    
  ,Bank_Amount_1                    
  ,Bank_Percent_1                    
  ,Bank_Account_No2                    
  ,Branch_Code2                    
  ,Bank_Amount_2                    
  ,Bank_Percent_2                    
  ,Bank_Account_No3                    
  ,Branch_Code3                    
  ,Bank_Amount_3                    
  ,Bank_Percent_3                    
  ,Bank_Account_No4                    
  ,Branch_Code4            
  ,Bank_Amount_4                    
  ,Bank_Percent_4                    
  ,SESSI_Flag                    
  ,EOBI_Flag                    
  ,Union_Flag                    
  ,Recreation_Club_Flag                    
  ,Meal_Deduction_Flag                    
  ,Overtime_Flag                    
  ,Incentive_Flag                    
  ,Bonus_Type                    
  ,'N'                    
  ,now(3)                    
  ,'N/A'                    
  ,'N'                  ,EOBI_Number                    
  ,SESSI_Number                    
  ,ACCOUNT_TYPE1                    
  ,ACCOUNT_TYPE2                    
  ,ACCOUNT_TYPE3                    
  ,ACCOUNT_TYPE4                    
  ,INTEREST_FLAG                    
  ,ZAKAT_FLAG                    
  ,'N'                    
  ,now(3)                    
  ,now(3)                    
  ,0                    
  ,0                    
  ,v_FuelFlag                    
  ,Picture                    
  ,0                    
  ,''                    
  ,''                    
  ,p_InputEmpCode                    
  ,`Offer_Letter_date`                    
  ,`Tentative_Joining_date`                    
  ,`RefferedBy`                    
  ,`Probationary_period_months`                    
  ,`Notice_period_months`                    
  ,`Extended_confirmation_days`                    
  ,`Permanent_address`                    
  ,`Nationality`                    
  ,1                    
  ,roster_group_code                    
  ,card_no          
  ,'N'   
  ,Company_Code  
  ,''   
  ,0                  
 FROM Tran_Appointments                    
 WHERE Sequence_no = p_Sequence_no;                    
                
                    
 -- SQLINES LICENSE FOR EVALUATION USE ONLY
 INSERT INTO Master_All_Employees                    
 SELECT v_Emp_code                    
  ,now(3)                    
  ,Emp_name                    
  ,Emp_Father_name                    
  ,Emp_sex_code                    
  ,Emp_marital_status                    
  ,Emp_birth_date                    
  ,Emp_appointment_date                    
  ,Emp_confirm_date                    
  ,Emp_Category                    
  ,Emp_Leave_Category                    
  ,Emp_address_line1                    
  ,Emp_address_line2                    
  ,Emp_home_tel1                    
  ,Emp_home_tel2                    
  ,Emp_office_tel1                    
  ,Emp_office_tel2                    
  ,Emp_mobile_No                    
  ,Emp_nic_no                    
  ,Emp_nic_issue_date                    
  ,Emp_nic_expiry_date                    
  ,Emp_retirement_age                    
  ,Emp_ntn_no                    
  ,Emp_email                    
  ,'N'                    
  ,Empt_Type_code                    
  ,Desig_code                    
  ,Grade_code                    
  ,Cost_Centre_code                    
  ,Dept_code                    
  ,Section_Code                    
  ,Shift_Code                    
  ,Loc_code                    
  ,Edu_code                    
  ,Transport_code                    
  ,Supervisor_Code                    
  ,Religion_Code                    
  ,'N'                    
  ,Contact_Person_Name                    
  ,Relationship                    
  ,Contact_address1                    
  ,Contact_address2                    
  ,Contact_home_tel1                    
  ,Contact_home_tel2                    
  ,Emp_Blood_Group                    
  ,Vehicle_Registration_Number                    
  ,Emp_Payroll_category         
  ,Mode_Of_Payment            
  ,Bank_Account_No1         
  ,Branch_Code1                   
  ,Bank_Amount_1                    
  ,Bank_Percent_1                    
  ,Bank_Account_No2                    
  ,Branch_Code2                    
  ,Bank_Amount_2                    
  ,Bank_Percent_2                    
  ,Bank_Account_No3                    
  ,Branch_Code3                    
  ,Bank_Amount_3                    
  ,Bank_Percent_3                    
  ,Bank_Account_No4                    
  ,Branch_Code4                    
  ,Bank_Amount_4                    
  ,Bank_Percent_4                    
  ,SESSI_Flag                    
  ,EOBI_Flag                    
  ,Union_Flag                    
  ,Recreation_Club_Flag                    
  ,Meal_Deduction_Flag                    
  ,Overtime_Flag                    
  ,Incentive_Flag                    
  ,Bonus_Type                    
  ,'N'                    
  ,now(3)                    
  ,'N/A'                    
  ,'N'                    
  ,EOBI_Number                    
  ,SESSI_Number                    
  ,ACCOUNT_TYPE1                    
  ,ACCOUNT_TYPE2                    
  ,ACCOUNT_TYPE3                    
  ,ACCOUNT_TYPE4                    
  ,INTEREST_FLAG                    
  ,ZAKAT_FLAG                    
  ,'N'                    
  ,now(3)                    
  ,now(3)                    
  ,0                    
  ,0                    
  ,v_FuelFlag                    
  ,Picture                    
  ,0       
  ,''                    
  ,''                    
  ,p_InputEmpCode                    
  ,`Offer_Letter_date`                    
  ,`Tentative_Joining_date`                    
  ,`RefferedBy`                    
  ,`Probationary_period_months`                    
  ,`Notice_period_months`                    
  ,`Extended_confirmation_days`                    
  ,`Permanent_address`                    
  ,`Nationality`                    
  ,1                    
  ,roster_group_code                    
  ,card_no          
  ,'N'                    
  ,Company_Code   
  ,''      
  ,0                
 FROM Tran_Appointments                    
 WHERE Sequence_no = p_Sequence_no;                    
                    
 -- SQLINES DEMO *** ter_all_employees              
                             
 -- SQLINES LICENSE FOR EVALUATION USE ONLY
 INSERT INTO History_Appointments                    
 SELECT v_Emp_code                    
  ,now(3)                    
  ,Emp_name                    
  ,Emp_Father_name                    
  ,Emp_sex_code                    
  ,Emp_marital_status                    
  ,Emp_birth_date                    
  ,Emp_appointment_date                    
  ,Emp_confirm_date                    
  ,Emp_Category                    
  ,Emp_Leave_Category                    
  ,Emp_address_line1                    
  ,Emp_address_line2                    
  ,Emp_home_tel1                    
  ,Emp_home_tel2                    
  ,Emp_office_tel1                    
  ,Emp_office_tel2                    
  ,Emp_mobile_No                    
  ,Emp_nic_no                    
  ,Emp_nic_issue_date                    
  ,Emp_nic_expiry_date                    
  ,Emp_retirement_age                    
  ,Emp_ntn_no                    
  ,Emp_email                    
  ,'N'                    
  ,Empt_Type_code                    
  ,Desig_code             
  ,Grade_code                    
  ,Cost_Centre_code                    
  ,Dept_code                    
  ,Loc_code                    
  ,Edu_code                    
  ,Transport_code                    
  ,Supervisor_Code                
  ,Religion_Code                    
  ,Section_Code                    
  ,Shift_Code                    
  ,'N'                    
  ,Emp_Payroll_category                    
  ,Mode_Of_Payment                    
  ,ACCOUNT_TYPE1                    
  ,Bank_Account_No1                    
  ,Branch_Code1                    
  ,Bank_Amount_1                    
  ,Bank_Percent_1                    
  ,ACCOUNT_TYPE2                    
  ,Bank_Account_No2       
  ,Branch_Code2        
  ,Bank_Amount_2       
  ,Bank_Percent_2                    
  ,ACCOUNT_TYPE3                    
  ,Bank_Account_No3                    
  ,Branch_Code3                    
  ,Bank_Amount_3                    
  ,Bank_Percent_3                    
  ,ACCOUNT_TYPE4                    
  ,Bank_Account_No4                    
  ,Branch_Code4                    
  ,Bank_Amount_4                    
  ,Bank_Percent_4                    
  ,SESSI_Flag                    
  ,EOBI_Flag                    
  ,Union_Flag                    
  ,Recreation_Club_Flag                    
  ,Meal_Deduction_Flag                    
  ,Overtime_Flag                    
  ,Incentive_Flag                    
  ,Bonus_Type                    
  ,Contact_Person_Name                    
  ,Relationship                    
  ,Contact_address1                    
  ,Contact_address2                    
  ,Contact_home_tel1                    
  ,Contact_home_tel2                    
  ,Emp_Blood_Group                    
  ,EOBI_Number                    
  ,SESSI_Number                    
  ,Vehicle_Registration_Number                    
  ,'N'                    
  ,INTEREST_FLAG                    
  ,ZAKAT_FLAG                    
  ,Picture                    
  ,p_InputEmpCode                    
  ,`Offer_Letter_date`                    
  ,`Tentative_Joining_date`                    
  ,`RefferedBy`                    
  ,`Probationary_period_months`                    
  ,`Notice_period_months`                    
  ,`Extended_confirmation_days`                    
  ,`Permanent_address`                    
  ,`Nationality`                    
  ,roster_group_code                    
  ,card_no         
  ,ContractExpiryDate    
  ,Position_Code                    
  ,Company_Code  
 FROM Tran_Appointments                    
 WHERE Sequence_no = p_Sequence_no;                    
ELSE                    
 -- SQLINES DEMO *** ter_Employees               
                        
 -- SQLINES LICENSE FOR EVALUATION USE ONLY
 INSERT INTO Master_Employees                    
 SELECT v_Emp_code                    
  ,now(3)                    
  ,Emp_name                    
  ,Emp_Father_name                    
  ,Emp_sex_code                    
  ,Emp_marital_status                    
  ,Emp_birth_date                    
  ,Emp_appointment_date                    
  ,Emp_confirm_date                    
  ,Emp_Category                    
  ,Emp_Leave_Category                    
  ,Emp_address_line1                    
  ,Emp_address_line2                    
  ,Emp_home_tel1                    
  ,Emp_home_tel2                    
  ,Emp_office_tel1                    
  ,Emp_office_tel2                    
  ,Emp_mobile_No                    
  ,Emp_nic_no                    
  ,Emp_nic_issue_date                    
  ,Emp_nic_expiry_date                    
  ,Emp_retirement_age                    
  ,Emp_ntn_no                    
  ,Emp_email                    
  ,'N'                    
  ,Empt_Type_code                    
  ,Desig_code                    
  ,Grade_code                    
  ,Cost_Centre_code                   
  ,Dept_code                    
  ,Section_Code                    
  ,Shift_Code                    
  ,Loc_code                    
  ,Edu_code                    
  ,Transport_code                    
  ,Supervisor_Code                    
  ,Religion_Code                    
  ,'N'                    
  ,Contact_Person_Name                    
  ,Relationship                    
  ,Contact_address1                    
  ,Contact_address2                    
  ,Contact_home_tel1                    
  ,Contact_home_tel2                    
  ,Emp_Blood_Group                    
  ,Vehicle_Registration_Number                    
  ,0                    
  ,0                    
  ,'0'                    
  ,0                    
  ,0                    
  ,0                    
  ,'0'                    
  ,0                    
  ,0                    
  ,0    
 ,'0'                  
  ,0    
  ,0                    
  ,0                    
,'0'                    
  ,0                    
  ,0                    
  ,0                    
  ,'N'                    
  ,'N'                    
  ,'N'                    
  ,'N'                    
  ,'N'                    
  ,'N'                    
  ,'N'          
  "N"                    
  ,Bonus_Type                    
  ,'N'                    
  ,now(3)                    
  ,'N/A'                    
  ,'N'                    
  ,'0'                    
  ,'0'                    
  ,'N'                    
  ,'N'                    
  ,'N'                    
  ,'N'                    
  ,'N'                    
  ,'N'                    
  ,'N'                    
  ,now(3)                    
  ,now(3)                    
  ,0                    
  ,0                    
  ,v_FuelFlag                    
  ,Picture                    
  ,0                    
  ,''                    
  ,''                    
  ,p_InputEmpCode                    
  ,`Offer_Letter_date`                    
  ,`Tentative_Joining_date`                    
  ,`RefferedBy`                    
  ,`Probationary_period_months`                    
  ,`Notice_period_months`                    
  ,`Extended_confirmation_days`                    
  ,`Permanent_address`                    
  ,`Nationality`                    
  ,1                    
  ,roster_group_code                    
  ,card_no           
  ,'N'                   
  ,Company_Code  
  ,''    
  ,0  
   FROM Tran_Appointments                    
 WHERE Sequence_no = p_Sequence_no;                    
                    
 -- SQLINES LICENSE FOR EVALUATION USE ONLY
 INSERT INTO Master_All_Employees                    
 SELECT v_Emp_code                    
  ,now(3)                    
  ,Emp_name                    
  ,Emp_Father_name                    
  ,Emp_sex_code                    
  ,Emp_marital_status                    
  ,Emp_birth_date                    
  ,Emp_appointment_date                    
  ,Emp_confirm_date                    
  ,Emp_Category                    
  ,Emp_Leave_Category                    
  ,Emp_address_line1                    
  ,Emp_address_line2                    
  ,Emp_home_tel1                    
  ,Emp_home_tel2                    
  ,Emp_office_tel1                    
  ,Emp_office_tel2                    
  ,Emp_mobile_No                    
  ,Emp_nic_no                    
  ,Emp_nic_issue_date                    
  ,Emp_nic_expiry_date                    
  ,Emp_retirement_age                    
  ,Emp_ntn_no                    
  ,Emp_email                    
  ,'N'                    
  ,Empt_Type_code                    
  ,Desig_code                    
  ,Grade_code                    
  ,Cost_Centre_code                   
  ,Dept_code                    
  ,Section_Code                    
  ,Shift_Code                    
  ,Loc_code                    
  ,Edu_code                    
  ,Transport_code                    
  ,Supervisor_Code                    
  ,Religion_Code                    
  ,'N'                    
  ,Contact_Person_Name                    
  ,Relationship                    
  ,Contact_address1                    
  ,Contact_address2                    
  ,Contact_home_tel1                    
  ,Contact_home_tel2                    
  ,Emp_Blood_Group                    
  ,Vehicle_Registration_Number                    
  ,0                    
  ,0                    
  ,'0'                    
  ,0                    
  ,0                    
  ,0                    
  ,'0'                    
  ,0                    
  ,0                    
  ,0                    
  ,'0'                    
  ,0                    
  ,0                    
  ,0                    
  ,'0'                    
  ,0                    
  ,0                    
  ,0                    
  ,'N'                    
  ,'N'                    
  ,'N'                    
  ,'N'                    
  ,'N'                    
  ,'N'                    
  ,'N'          
"N"                    
  ,Bonus_Type                    
  ,'N'                    
  ,now(3)                  
  ,'N/A'                    
  ,'N'                    
  ,'0'                    
  ,'0'                    
  ,'N'                    
  ,'N'                    
  ,'N'                    
  ,'N'                    
  ,'N'                    
  ,'N'                    
  ,'N'                    
  ,now(3)                    
  ,now(3)                    
  ,0                    
  ,0                    
  ,v_FuelFlag                    
  ,Picture                    
  ,0                    
  ,''                    
  ,''                    
  ,p_InputEmpCode                    
  ,`Offer_Letter_date`                    
  ,`Tentative_Joining_date`                    
  ,`RefferedBy`                    
  ,`Probationary_period_months`                    
  ,`Notice_period_months`                    
  ,`Extended_confirmation_days`                    
  ,`Permanent_address`                    
  ,`Nationality`                    
  ,1                    
  ,roster_group_code                    
  ,card_no           
  ,'N'   
  ,Company_Code    
  ,''         
  ,0           
 FROM Tran_Appointments                    
 WHERE Sequence_no = p_Sequence_no;                    
                    
 -- SQLINES LICENSE FOR EVALUATION USE ONLY
 INSERT INTO History_Appointments                    
 SELECT v_Emp_code                    
  ,now(3)                    
  ,Emp_name                    
  ,Emp_Father_name                    
  ,Emp_sex_code                    
  ,Emp_marital_status                    
  ,Emp_birth_date       
  ,Emp_appointment_date                    
  ,Emp_confirm_date                    
  ,Emp_Category                    
  ,Emp_Leave_Category                    
  ,Emp_address_line1                    
  ,Emp_address_line2                    
  ,Emp_home_tel1                
  ,Emp_home_tel2                    
  ,Emp_office_tel1                    
  ,Emp_office_tel2                    
  ,Emp_mobile_No                    
  ,Emp_nic_no                    
  ,Emp_nic_issue_date            
  ,Emp_nic_expiry_date                    
  ,Emp_retirement_age                    
  ,Emp_ntn_no                    
  ,Emp_email                    
  ,'N'                 
  ,Empt_Type_code                    
  ,Desig_code                    
  ,Grade_code                    
  ,Cost_Centre_code                    
  ,Dept_code                    
  ,Loc_code                    
  ,Edu_code                    
  ,Transport_code                    
  ,Supervisor_Code                    
  ,Religion_Code                    
  ,Section_Code                    
  ,Shift_Code                    
  ,'N'                    
  ,0                    
  ,0                    
  ,'N'                    
  ,'0'                    
  ,0                    
  ,0                    
  ,0                    
  ,'N'                    
  ,'0'                    
  ,0                    
  ,0                    
  ,0                    
  ,'N'                    
  ,'0'                    
  ,0                    
  ,0                    
  ,0                    
  ,'N'                    
  ,'0'                    
  ,0       
  ,0                    
  ,0                    
  ,'N'                    
  ,'N'                    
  ,'N'                    
  ,'N'                    
  ,'N'                    
  ,'N'                    
  ,'N'                    
  ,Bonus_Type                    
  ,Contact_Person_Name                    
  ,Relationship                    
  ,Contact_address1                    
  ,Contact_address2                    
  ,Contact_home_tel1                    
  ,Contact_home_tel2                    
  ,Emp_Blood_Group                    
  ,0                    
  ,0                    
  ,Vehicle_Registration_Number                    
  ,'N'                    
  ,'N'                    
  ,'N'                    
  ,Picture                    
  ,p_InputEmpCode                    
  ,`Offer_Letter_date`                    
  ,`Tentative_Joining_date`              
  ,`RefferedBy`          
  ,`Probationary_period_months`             
  ,`Notice_period_months`                    
  ,`Extended_confirmation_days`                    
  ,`Permanent_address`                    
  ,`Nationality`                    
  ,roster_group_code                    
  ,card_no         
  ,ContractExpiryDate     
  ,Position_Code                    
  ,Company_Code  
   FROM Tran_Appointments                    
 WHERE Sequence_no = p_Sequence_no;                    
END IF;                    
                    
SET v_Emp_Payroll_Category = (                    
  SELECT Emp_Payroll_Category                    
  FROM Master_Employees                    
  WHERE Emp_Code = v_Emp_code                    
  );                    
SET v_Payroll_Year = (                    
  SELECT Payroll_Year                    
  FROM Dir_Payroll_Categories                    
  WHERE Payroll_Category_code = v_Emp_Payroll_Category                    
  );                    
SET v_Payroll_Month = (                    
  SELECT Payroll_Month                    
  FROM Dir_Payroll_Categories                    
  WHERE Payroll_Category_code = v_Emp_Payroll_Category                    
  );                    
SET v_Payroll_Month = v_Payroll_Month + 1;                    
                    
IF v_Payroll_Month > 12                    
THEN                    
 SET v_Payroll_Month = 1;                    
 SET v_Payroll_Year = v_Payroll_Year + 1;                    
END IF;                    
                    
IF v_payrollmonth_for_stoflag = 1                    
THEN                    
 SET v_Payroll_Month = v_Payroll_Month + 1;                    
                    
 UPDATE master_employees                    
 SET Salary_Hold_Flag = 'Y'                    
 WHERE Emp_code = v_Emp_code;                    
                    
 UPDATE master_all_employees                    
 SET Salary_Hold_Flag = 'Y'                    
 WHERE Emp_code = v_Emp_code;                    
END IF;                    
                    
--  SQLINES DEMO ***                                                                   
--  SQLINES DEMO ***                                                       
--  SQLINES DEMO *** =@Payroll_Month+1                                                                  
--  SQLINES DEMO ***                                                    
IF v_Payroll_Month > 12                    
THEN                    
 SET v_Payroll_Month = 1;                    
 SET v_Payroll_Year = v_Payroll_Year + 1;                    
END IF;                    
                    
-- SQLINES LICENSE FOR EVALUATION USE ONLY
INSERT INTO Master_Earnings                    
SELECT v_Emp_code                    
 ,Allowance_code                    
 ,Amount                    
 ,'N'                    
FROM tran_appointment_earnings                    
WHERE Sequence_no = p_Sequence_no;                    
                    
-- SQLINES LICENSE FOR EVALUATION USE ONLY
INSERT INTO history_increments                    
SELECT v_Emp_code                    
 ,v_Emp_appointment_date                    
 ,Allowance_code                    
,Transaction_Date                    
 ,Amount                    
 ,now(3)                    
 ,Posted_by                    
 ,v_Payroll_Month                    
 ,v_Payroll_Year                    
FROM tran_appointment_earnings                    
WHERE Sequence_no = p_Sequence_no;                    
                    
--  SQLINES DEMO ***  by khalid jan 6 2020  for shift and leave encashment allowance                      
--  SQLINES DEMO *** alid on jan 5 2020  for hascol  shift and leave encashment allowance .MK will make part of automation                      
                   
                    
-- SQLINES LICENSE FOR EVALUATION USE ONLY
SELECT shift_allowance_calculation_Monthly_flag                    
 , shift_allowance_code                    
, leave_encashment_calculation_Monthly_flag                    
 , leave_encashment_allowance_code INTO v_shift_allowance_calculation_Monthly_flag, v_shift_allowance_code, v_leave_encashment_calculation_Monthly_flag, v_leave_encashment_allowance_code                    
FROM dir_setups;                    
                    
SET v_gross_amount = 0;                    
                    
-- SQLINES LICENSE FOR EVALUATION USE ONLY
SELECT ifnull(sum(amount), 0) INTO v_gross_amount                    
FROM tran_appointment_earnings                    
WHERE Sequence_no = p_Sequence_no;                    
                    
IF v_shift_allowance_calculation_Monthly_flag = 'Y'                    
THEN                                       
                    
 --  SQLINES DEMO *** 2_group_leave_encashment_flag                      
 -- SQLINES LICENSE FOR EVALUATION USE ONLY
 SELECT ifnull(b.shift_allowance_flag, 'N') INTO v_shift_allowance_calculation_flag                    
 FROM master_employees a                    
 JOIN RS_Dir_Groups b ON a.roster_group_code = b.Group_Code                   
 WHERE emp_code = v_Emp_code;                    
                    
 IF v_shift_allowance_calculation_flag = 'Y'                    
 THEN                    
  -- SQLINES LICENSE FOR EVALUATION USE ONLY
  INSERT INTO Master_Earnings                    
  SELECT v_Emp_code                    
   ,v_shift_allowance_code                    
   ,round((((v_gross_amount / 100.0) * 10)), 0)                    
   ,'N'                    
  FROM tran_appointment_earnings                    
  WHERE Sequence_no = p_Sequence_no                    
   AND allowance_code = 1;                    
                    
  -- SQLINES LICENSE FOR EVALUATION USE ONLY
  INSERT INTO History_Increments                    
  SELECT v_Emp_code                    
   ,Increment_Date                    
   ,v_shift_allowance_code                    
   ,Transaction_Date                    
   ,round((((v_gross_amount / 100.0) * 10)), 0)                    
   ,Posting_date                    
   ,Posted_by                
   ,v_Payroll_Month                    
   ,v_Payroll_Year                    
  FROM tran_appointment_earnings                    
  WHERE Sequence_no = p_Sequence_no                    
   AND allowance_code = 1;                    
 END IF;                    
END IF;                    
                    
IF v_leave_encashment_calculation_Monthly_flag = 'Y'                    
THEN                    
 --  SQLINES DEMO *** 2_group_leave_encashment_flag                      
                    
 -- SQLINES LICENSE FOR EVALUATION USE ONLY
 SELECT ifnull(b.Leave_encashment_allowance_flag, 'N') INTO v_shift_group_leave_encashment_flag                    
 FROM master_employees a                    
 JOIN RS_Dir_Groups b ON a.roster_group_code = b.Group_Code                    
 WHERE emp_code = v_Emp_code;                    
                    
 IF v_shift_group_leave_encashment_flag = 'Y'                    
 THEN                    
  -- SQLINES LICENSE FOR EVALUATION USE ONLY
  INSERT INTO master_earnings                    
  SELECT v_Emp_code                    
   ,v_leave_encashment_allowance_code      ,round((((v_gross_amount / 30.0) * 22) / 12.0), 0)                    
   ,'N'                    
  FROM tran_appointment_earnings                    
  WHERE Sequence_no = p_Sequence_no                    
   AND allowance_code = 1;                    
                    
  -- SQLINES LICENSE FOR EVALUATION USE ONLY
  INSERT INTO History_Increments                    
  SELECT v_Emp_code                    
   ,Increment_Date                    
   ,v_leave_encashment_allowance_code                    
   ,Transaction_Date                    
   ,round((((v_gross_amount / 30.0) * 22) / 12.0), 0)                    
   ,Posting_date                    
   ,Posted_by                    
  ,v_Payroll_Month                    
   ,v_Payroll_Year             
  FROM tran_appointment_earnings                    
  WHERE Sequence_no = p_Sequence_no                    
   AND allowance_code = 1;                    
 END IF;                    
END IF;                            
-- SQLINES DEMO *** 2020                       
--  SQLINES DEMO *** d                       
--  SQLINES DEMO *** ppointment_Earnings                                                                                   
--  SQLINES DEMO *** = @Sequence_no                                                                                   
                     
-- SQLINES LICENSE FOR EVALUATION USE ONLY
select emp_appointment_date  , Emp_Leave_Category into v_apt_date, v_Emp_Leave_Category                                              
from Tran_Appointments                                     
where Sequence_no = p_Sequence_no;                      
                    
                    
-- SQLINES LICENSE FOR EVALUATION USE ONLY
SELECT Empt_Type_code INTO v_EmpTypeCode                    
FROM Tran_Appointments                    
WHERE Sequence_no = p_Sequence_no;                    
                    
SET v_PermanantFlag = '';                    
                    
-- SQLINES LICENSE FOR EVALUATION USE ONLY
SELECT PermanantFlag INTO v_PermanantFlag                    
FROM Dir_Employment_Types                    
WHERE Empt_Type_code = v_EmpTypeCode;                    
                    
-- SQLINES DEMO *** tory_contract_employees          
                                                                
IF v_PermanantFlag = 'N'                    
THEN                    
 -- SQLINES LICENSE FOR EVALUATION USE ONLY
 INSERT INTO history_contract_employees                    
 SELECT v_Emp_code                    
  ,emp_appointment_date                    
  ,ContractExpiryDate         
  ,v_Payroll_Month                    
  ,v_Payroll_Year                    
  ,NOW(3)                    
  ,p_UserCode  
  ,'Y'                    
 FROM Tran_Appointments                    
 WHERE Sequence_no = p_Sequence_no;                    
                    
 -- SQLINES LICENSE FOR EVALUATION USE ONLY
 INSERT INTO log_history_contract_employees                    
 SELECT v_Emp_code                    
  ,emp_appointment_date                    
  ,ContractExpiryDate         
  ,v_Payroll_Month                    
  ,v_Payroll_Year                    
  ,NOW(3)             
  ,'Add'                    
  ,p_UserCode                    
 FROM Tran_Appointments                    
 WHERE Sequence_no = p_Sequence_no;                    
END IF;                    
                    
-- SQLINES LICENSE FOR EVALUATION USE ONLY
SELECT desig_code                    
 , Loc_code INTO v_desig_code_for_branch, v_loc_code_for_branch                    
FROM Tran_Appointments                    
WHERE Sequence_no = p_Sequence_no;                    
                    
--  SQLINES DEMO *** ppointments                                                                                   
--  SQLINES DEMO *** = @Sequence_no   
                                                             
UPDATE Tran_Appointments                    
SET Process_Flag = 'Y',Emp_Id=p_InputEmpCode                    
WHERE Sequence_no = p_Sequence_no;                    
                    
-- SQLINES LICENSE FOR EVALUATION USE ONLY
INSERT INTO LogHrSystem                    
VALUES (                    
 10                    
 ,10                    
 ,10                    
 ,CONCAT('Process' , convert(v_Emp_code, CHAR))                    
 ,now(3)                    
 ,p_UserCode                    
 ,'Log_Tran_Appointments'                    
 );                    
                    
                    
         
                
                    
                    
                    
   -- SQLINES DEMO *** art                               
 
 -- SQLINES LICENSE FOR EVALUATION USE ONLY
 select Emp_Confirm_date into v_Confirmation_Date from Master_Employees;                    
                                    
  -- SQLINES LICENSE FOR EVALUATION USE ONLY
                                    
                    
  -- SQLINES DEMO *** d                          
          
                            
                        
-- if v_Probationary_period_months=0                    
-- Then                    
--     call SP_PER_TranConfirmations_Process v_Emp_code,v_Transaction_Date,v_Emp_appointment_date,v_Emp_appointment_date,p_UserCode,'Y'                 
-- End if;                    
                    
  
if exists (select * from Dir_Setups where PositionFlag='N')  
 Then  
  CALL Proc_PER_TranAppointments_Process_replacement(v_UserCode,v_Emp_code,v_Replacement_emp_code,v_Replacement_flag);                    
else   
  update Dir_Positions  
  set PermanentEmp_Code=v_Emp_code  
  where Position_Code=v_Position_code;  
 End if;                    
                  
-- SQLINES DEMO *** his Employee                  
-- SQLINES DEMO *** _Employees                  
-- SQLINES LICENSE FOR EVALUATION USE ONLY
insert into Sys_Employees                    
select v_Emp_code,Emp_name,'xyz',1,1,'Y','Y','Y','Y',Emp_ID,'ZZ','N',0,now(3),'N',1                  
from Master_All_Employees                   
where Emp_code=v_Emp_code;                   
                             
                
-- SQLINES LICENSE FOR EVALUATION USE ONLY
select ESS_GroupCode,ess_block_flag into @ESS_GroupCode, v_ess_block_flag from Dir_Setups;                  
                
                
if v_ess_block_flag='N'                 
then                
                  
 call add_user_group(v_Emp_code,v_ESS_GroupCode);                  
 call proc_Emp_GroupAccess_Log(v_UserCode,v_Emp_code,v_ESS_GroupCode);                  
end if;                
                
call proc_Emp_Access_Log_group_employee(v_UserCode,v_Emp_code,'Previous');                  
call proc_Emp_Access_Log_group_employee(v_UserCode,v_Emp_code,'Current');                  
                
-- --                  
                  
-- SQLINES DEMO *** erations Head                  
--  execute SP_PER_TranAppointments_NewAppointment_Email v_Emp_code                  
                  
                    
END;              
--   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
--   BEGIN                     
    --       SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Severe error occured - Contact Paperless Technology , job cancelled';                     
    -- rollback;                     
    -- leave SP_PER_TranAppointments_Process;                     
--   END;                               
 commit;
 
END$$

CREATE  PROCEDURE `SP_PER_TranAppointments_Save_Payroll` (IN `Sequenceno` INT, IN `Mode_Of_Payment` INT, IN `Recreation_Club_Flag` VARCHAR(1), IN `Meal_Deduction_Flag` VARCHAR(1), IN `Union_Flag` VARCHAR(1), IN `Overtime_Flag` VARCHAR(1), IN `Incentive_Flag` VARCHAR(1), IN `Bonus_Type` VARCHAR(30), IN `SESSI_Flag` VARCHAR(1), IN `EOBI_Flag` VARCHAR(1), IN `SESSI_Number` VARCHAR(20), IN `EOBI_Number` VARCHAR(20), IN `Account_Type1` VARCHAR(20), IN `Bank_Account_No1` VARCHAR(30), IN `Branch_Code1` INT, IN `Bank_Amount_1` INT, IN `Bank_Percent_1` INT, IN `User_Code` INT)   BEGIN
    DECLARE Cash_Bank_Flag CHAR(1);
    
    IF Mode_Of_Payment = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Please select a mode of payment, job cancelled.';
    END IF;
    
    SELECT Cash_Bank_Flag INTO Cash_Bank_Flag FROM dir_mode_of_payments
    WHERE Payment_code = Mode_Of_Payment;
    
    IF Cash_Bank_Flag = 'B' THEN
        IF Bank_Account_No1 = '' THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Bank Account No 1 cannot be blank, job cancelled.';
        END IF;
        IF Bank_Amount_1 <= 0 AND Bank_Percent_1 <= 0 THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Bank Amount and bank percent cannot be negative or zero, job cancelled.';
        END IF;
        IF Bank_Amount_1 > 0 AND Bank_Percent_1 > 0 THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Bank Amount and bank percent both cannot be greater than zero, job cancelled.';
        END IF;
    END IF;
    
    START TRANSACTION;
    
    UPDATE tran_appointments
    SET Mode_Of_Payment = Mode_Of_Payment,
        Recreation_Club_Flag = Recreation_Club_Flag,
        Meal_Deduction_Flag = Meal_Deduction_Flag,
        Union_Flag = Union_Flag,
        Overtime_Flag = Overtime_Flag,
        Incentive_Flag = Incentive_Flag,
        Bonus_Type = Bonus_Type,
        SESSI_Flag = SESSI_Flag,
        EOBI_Flag = EOBI_Flag,
        SESSI_Number = SESSI_Number,
        EOBI_Number = EOBI_Number,
        Account_Type1 = Account_Type1,
        Bank_Account_No1 = Bank_Account_No1,
        Branch_Code1 = Branch_Code1,
        Bank_Amount_1 = Bank_Amount_1,
        Bank_Percent_1 = Bank_Percent_1,
        Status = 'Payroll Done'
    WHERE Sequence_No = Sequenceno;
    
     insert into log_tran_appointments            
   select  Sequence_no, Transaction_Date, Emp_name, Emp_Father_name, Emp_sex_code, Emp_marital_status,            
    Emp_birth_date, Emp_appointment_date, Emp_confirm_date, Emp_category, Emp_Leave_category,            
     Emp_address_line1, Emp_address_line2, Emp_home_tel1, Emp_home_tel2, Emp_office_tel1,            
      Emp_office_tel2, Emp_mobile_No, Emp_nic_no,Emp_nic_issue_date,Emp_nic_expiry_date,Emp_retirement_age, Emp_ntn_no, Emp_email, Confirmation_Flag, Empt_Type_code,             
      Desig_code, Grade_code, Cost_Centre_code, Dept_code, Loc_code, Edu_code, Transport_code, Supervisor_Code,            
       Religion_Code, Section_code, Shift_code, Deletion_Flag, Emp_Payroll_category,            
        Mode_Of_Payment, Bank_Account_No1, Branch_Code1, Bank_Amount_1, Bank_Percent_1, Bank_Account_No2, Branch_Code2,             
        Bank_Amount_2, Bank_Percent_2, Bank_Account_No3, Branch_Code3, Bank_Amount_3, Bank_Percent_3, Bank_Account_No4,             
        Branch_Code4, Bank_Amount_4, Bank_Percent_4, SESSI_Flag, EOBI_Flag, Union_Flag, Recreation_Club_Flag, Meal_Deduction_Flag,            
         Overtime_Flag, Incentive_Flag,Bonus_Type, Contact_Person_Name, Relationship, Contact_address1, Contact_address2, Contact_home_tel1,           
         Contact_home_tel2, Emp_Blood_Group, EOBI_Number, SESSI_Number, Vehicle_Registration_Number, `Status`,         
          Interest_Flag, Zakat_Flag, Account_Type1, Account_Type2, Account_Type3, Account_Type4, Picture,             
           Emp_id, Offer_Letter_date, Tentative_Joining_date, RefferedBy, Probationary_period_months,            
           Notice_period_months, Extended_confirmation_days, Permanent_address, Nationality, User_Code, NOW(), roster_group_code,card_no,    
     ContractExpiryDate,Position_Code,Company_Code,User_Code  from tran_appointments             
           where Sequence_no=@Sequenceno;
           
             insert into loghrsystem(Module_item,Menu_Item,Menu_Option,ACtion_On_Button,ACtion_date,User_code,remarks)            
values(10,10,10,'SavePayroll',NOW(),0,'log_tran_appointments'); 
    
  
End$$

CREATE  PROCEDURE `SP_PER_TranAppointments_Save_Personnel` (IN `Sequence_no` INT, IN `Transaction_date` DATETIME, IN `Emp_name` VARCHAR(30), IN `Emp_Father_name` VARCHAR(30), IN `Emp_joining_date` DATETIME, IN `Emp_sex_code` VARCHAR(1), IN `Emp_marital_status` VARCHAR(1), IN `Emp_address_line1` VARCHAR(200), IN `Emp_address_line2` VARCHAR(40), IN `Emp_home_tel1` VARCHAR(15), IN `Emp_home_tel2` VARCHAR(15), IN `Emp_office_tel1` VARCHAR(15), IN `Emp_office_tel2` VARCHAR(15), IN `Emp_mobile_No` VARCHAR(20), IN `Emp_email` VARCHAR(70), IN `Emp_nic_no` VARCHAR(30), IN `Emp_NIC_Issue_date` DATE, IN `Emp_NIC_Expiry_date` DATE, IN `Emp_Retirement_age` INT, IN `Emp_ntn_no` VARCHAR(15), IN `Emp_birth_date` DATETIME, IN `Vehicle_Registration_Number` VARCHAR(100), IN `Contact_Person_Name` VARCHAR(30), IN `Relationship` VARCHAR(15), IN `Contact_address1` VARCHAR(40), IN `Contact_address2` VARCHAR(40), IN `Contact_home_tel1` VARCHAR(20), IN `Contact_home_tel2` VARCHAR(20), IN `Emp_Blood_Group` VARCHAR(4), IN `Employment_Type_code` INT, IN `Emp_category` INT, IN `Emp_Leave_category` INT, IN `Emp_Payroll_category` INT, IN `Shift_code` INT, IN `Desig_code` INT, IN `Cost_Centre_code` INT, IN `Section_code` INT, IN `Grade_code` INT, IN `Edu_code` INT, IN `Loc_code` INT, IN `Religion_Code` INT, IN `Supervisor_Code` INT, IN `photo` TEXT, IN `ContractExpiryDate` DATETIME, IN `Emp_ID` VARCHAR(50), IN `Offer_Letter_date` DATETIME, IN `Tentative_Joining_date` DATETIME, IN `RefferedBy` VARCHAR(50), IN `Probationary_period_months` INT, IN `Notice_period_months` INT, IN `Extended_confirmation_days` INT, IN `Permanent_address` VARCHAR(50), IN `Nationality` VARCHAR(50), IN `roster_group_code` INT, IN `card_no` VARCHAR(50), IN `Position_Code` INT, IN `Company_Code` INT, IN `UserCode` INT)   SP_PER_TranAppointments_Save_Personnel:BEGIN
DECLARE Dept_code INT;
  DECLARE Overtime_Flag VARCHAR(1);

IF EXISTS (
    SELECT *
    FROM dir_setups
    WHERE Auto_Emp_Code_Type = 'N' and Company_Code=@CompanyCode
  )
  THEN
    IF Emp_ID = ''
    THEN
      SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Please Enter Employee Code';
      LEAVE SP_PER_TranAppointments_Save_Personnel;
    END IF;

    IF EXISTS (
      SELECT *
      FROM tran_appointments
      WHERE Sequence_no <> @SequenceNo
        AND Emp_id = @EmpId and Company_Code=@CompanyCode
    )
    THEN
      SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Employee Code already used in your Transaction';
      LEAVE SP_PER_TranAppointments_Save_Personnel;
    END IF;

    IF EXISTS (
      SELECT *
      FROM master_employees
      WHERE Emp_id = @EmpId and Company_Code=@CompanyCode
    )
    THEN
      SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Employee Code already entered in Employee Master';
      LEAVE SP_PER_TranAppointments_Save_Personnel;
    END IF;

    IF EXISTS (
      SELECT *
      FROM master_all_employees
      WHERE Emp_id = @EmpId and Company_Code=@CompanyCode
    )
    THEN
      SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Employee Code already entered in Employee Master';
      LEAVE SP_PER_TranAppointments_Save_Personnel;
    END IF;
  END IF;

  IF EXISTS (
    SELECT *
    FROM dir_setups
    WHERE MultipleCompanyFlag = 'Y' and Company_Code=@CompanyCode
  )
  THEN
    IF Company_Code = -1
    THEN
      SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Please Select Company, job cancelled';
      LEAVE SP_PER_TranAppointments_Save_Personnel;
    END IF;
  END IF;

  IF EXISTS (
    SELECT *
    FROM dir_setups
    WHERE MultipleCompanyFlag = 'N' and Company_Code=@CompanyCode
  )
  THEN
    SET Company_Code = 0;
  END IF;

  IF EXISTS (
    SELECT *
    FROM dir_setups
    WHERE PositionFlag = 'Y' and Company_Code=@CompanyCode
  )
  THEN
    IF Position_Code = 0
    THEN
      SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Please Select Position, job cancelled';
      LEAVE SP_PER_TranAppointments_Save_Personnel;
    END IF;
  END IF;

  IF EXISTS (
    SELECT *
    FROM dir_setups
    WHERE PositionFlag = 'N' and Company_Code=@CompanyCode
 )
  THEN
    SET Position_Code = 0;
  END IF;

  SELECT Dept_code INTO Dept_code
  FROM dir_sections
  WHERE Section_code = @Sectioncode;

   SELECT Overtime_Flag INTO Overtime_Flag
  FROM dir_grades
  WHERE Grade_code = @Gradecode;


  IF EXISTS (SELECT * FROM master_employees WHERE Emp_nic_no = Emp_nic_no and Company_Code=@CompanyCode) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'CNIC No already exists, job cancelled';
  END IF;

  IF ContractExpiryDate <= Emp_joining_date THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Contract Expiry Date cannot be less than or equal to Joining Date, job cancelled';
  END IF;

  IF EXISTS (SELECT * FROM tran_appointments WHERE Sequence_no = Sequence_no and Company_Code=@CompanyCode) THEN
    UPDATE tran_appointments
    SET Transaction_date = Transaction_date,
        Emp_name = Emp_name,
        Emp_Father_name = Emp_Father_name,
        Emp_sex_code = Emp_sex_code,
        Emp_marital_status = Emp_marital_status,
        Emp_birth_date = Emp_birth_date,
        Emp_appointment_date = Emp_joining_date,
        Emp_address_line1 = Emp_address_line1,
        Emp_address_line2 = Emp_address_line2,
        Emp_home_tel1 = Emp_home_tel1,
        Emp_home_tel2 = Emp_home_tel2,
        Emp_office_tel1 = Emp_office_tel1,
        Emp_office_tel2 = Emp_office_tel2,
        Emp_mobile_No = Emp_mobile_No,
        Emp_email = Emp_email,
        Emp_nic_no = Emp_nic_no,
        Emp_NIC_Issue_date = Emp_NIC_Issue_date,
        Emp_NIC_Expiry_date = Emp_NIC_Expiry_date,
        Emp_Retirement_age = Emp_Retirement_age,
        Emp_ntn_no = Emp_ntn_no,
        Emp_Blood_Group = Emp_Blood_Group,
        Empt_Type_code = Employment_Type_code,
        Emp_category = Emp_category,
        Emp_Leave_category = Emp_Leave_category,
        Emp_Payroll_category = Emp_Payroll_category,
        Shift_code = Shift_code,
        Desig_code = Desig_code,
        Cost_Centre_code = Cost_Centre_code,
        Section_code = Sectioncode,
        Grade_code = Gradecode,
        Edu_code = Edu_code,
        Loc_code = Loc_code,
        Religion_Code = Religion_Code,
        Supervisor_Code = Supervisor_Code,
        Picture = photo,
        ContractExpiryDate = ContractExpiryDate,
        Emp_ID = Emp_ID,
        Offer_Letter_date = Offer_Letter_date,
        Tentative_Joining_date = Tentative_Joining_date,
        RefferedBy = RefferedBy,
        Probationary_period_months = Probationary_period_months,
        Notice_period_months = Notice_period_months,
        Extended_confirmation_days = Extended_confirmation_days,
        Permanent_address = Permanent_address,
        Nationality = Nationality,
        roster_group_code = roster_group_code,
        card_no = card_no,
        Position_Code = Position_Code,
        Company_Code = CompanyCode,
        UserCode = UserCode
    WHERE Sequence_no = SequenceNo;
  ELSE
    INSERT INTO tran_appointments(
        Sequence_no,
        Transaction_date,
        Emp_name,
        Emp_Father_name,
        Emp_sex_code,
        Emp_marital_status,
        Emp_birth_date,
        Emp_appointment_date,
        Emp_address_line1,
        Emp_address_line2,
        Emp_home_tel1,
        Emp_home_tel2,
        Emp_office_tel1,
        Emp_office_tel2,
        Emp_mobile_No,
        Emp_email,
        Emp_nic_no,
        Emp_NIC_Issue_date,
        Emp_NIC_Expiry_date,
        Emp_Retirement_age,
        Emp_ntn_no,
        Emp_Blood_Group,
        Empt_Type_code,
        Emp_category,
        Emp_Leave_category,
        Emp_Payroll_category,
        Shift_code,
        Desig_code,
        Cost_Centre_code,
        Section_code,
        Grade_code,
        Edu_code,
        Loc_code,
        Religion_Code,
        Supervisor_Code,
        Picture,
        ContractExpiryDate,
        Emp_ID,
        Offer_Letter_date,
        Tentative_Joining_date,
        RefferedBy,
        Probationary_period_months,
        Notice_period_months,
        Extended_confirmation_days,
        Permanent_address,
        Nationality,
        roster_group_code,
        card_no,
        Position_Code,
        Company_Code,
        UserCode
    ) VALUES (
        Sequence_no,
        Transaction_date,
        Emp_name,
        Emp_Father_name,
        Emp_sex_code,
        Emp_marital_status,
        Emp_birth_date,
        Emp_joining_date,
        Emp_address_line1,
        Emp_address_line2,
        Emp_home_tel1,
        Emp_home_tel2,
        Emp_office_tel1,
        Emp_office_tel2,
        Emp_mobile_No,
        Emp_email,
        Emp_nic_no,
        Emp_NIC_Issue_date,
        Emp_NIC_Expiry_date,
        Emp_Retirement_age,
        Emp_ntn_no,
        Emp_Blood_Group,
        Employment_Type_code,
        Emp_category,
        Emp_Leave_category,
        Emp_Payroll_category,
        Shift_code,
        Desig_code,
        Cost_Centre_code,
        Section_code,
        Grade_code,
        Edu_code,
        Loc_code,
        Religion_Code,
        Supervisor_Code,
        photo,
        ContractExpiryDate,
        Emp_ID,
        Offer_Letter_date,
        Tentative_Joining_date,
        RefferedBy,
        Probationary_period_months,
        Notice_period_months,
        Extended_confirmation_days,
        Permanent_address,
        Nationality,
        roster_group_code,
        card_no,
        Position_Code,
        Company_Code,
        UserCode
    );
INSERT INTO log_tran_appointments 
(Sequence_no, Transaction_Date, Emp_name, Emp_Father_name, Emp_sex_code, Emp_marital_status, Emp_birth_date, Emp_appointment_date, Emp_confirm_date, Emp_category, Emp_Leave_category, Emp_address_line1, Emp_address_line2, Emp_home_tel1, Emp_home_tel2, Emp_office_tel1, Emp_office_tel2, Emp_mobile_No, Emp_nic_no, Emp_nic_issue_date, Emp_nic_expiry_date, Emp_retirement_age, Emp_ntn_no, Emp_email, Confirmation_Flag, Empt_Type_code, Desig_code, Grade_code, Cost_Centre_code, Dept_code, Loc_code, Edu_code, Transport_code, Supervisor_Code, Religion_Code, Section_code, Shift_code, Deletion_Flag, Emp_Payroll_category, Mode_Of_Payment, Bank_Account_No1, Branch_Code1, Bank_Amount_1, Bank_Percent_1, Bank_Account_No2, Branch_Code2, Bank_Amount_2, Bank_Percent_2, Bank_Account_No3, Branch_Code3, Bank_Amount_3, Bank_Percent_3, Bank_Account_No4, Branch_Code4, Bank_Amount_4, Bank_Percent_4, SESSI_Flag, EOBI_Flag, Union_Flag, Recreation_Club_Flag, Meal_Deduction_Flag, Overtime_Flag, Incentive_Flag, Bonus_Type, Contact_Person_Name, Relationship, Contact_address1, Contact_address2, Contact_home_tel1, Contact_home_tel2, Emp_Blood_Group, EOBI_Number, SESSI_Number, Vehicle_Registration_Number, STATUS, Interest_Flag, Zakat_Flag, Account_Type1, Account_Type2, Account_Type3, Account_Type4, Picture, Emp_id, Offer_Letter_date, Tentative_Joining_date, RefferedBy, Probationary_period_months, Notice_period_months, Extended_confirmation_days, Permanent_address, Nationality, UserCode, PostedOn, roster_group_code, card_no, ContractExpiryDate, Position_Code, Company_Code)
SELECT Sequence_no, Transaction_Date, Emp_name, Emp_Father_name, Emp_sex_code, Emp_marital_status, Emp_birth_date, Emp_appointment_date, Emp_confirm_date, Emp_category, Emp_Leave_category, Emp_address_line1, Emp_address_line2, Emp_home_tel1, Emp_home_tel2, Emp_office_tel1, Emp_office_tel2, Emp_mobile_No, Emp_nic_no, Emp_nic_issue_date, Emp_nic_expiry_date, Emp_retirement_age, Emp_ntn_no, Emp_email, Confirmation_Flag, Empt_Type_code, Desig_code, Grade_code, Cost_Centre_code, Dept_code, Loc_code, Edu_code, Transport_code, Supervisor_Code, Religion_Code, Section_code, Shift_code, Deletion_Flag, Emp_Payroll_category, Mode_Of_Payment, Bank_Account_No1, Branch_Code1, Bank_Amount_1, Bank_Percent_1, Bank_Account_No2, Branch_Code2, Bank_Amount_2, Bank_Percent_2, Bank_Account_No3, Branch_Code3, Bank_Amount_3, Bank_Percent_3, Bank_Account_No4, Branch_Code4, Bank_Amount_4, Bank_Percent_4, SESSI_Flag, EOBI_Flag, Union_Flag, Recreation_Club_Flag, Meal_Deduction_Flag, Overtime_Flag, Incentive_Flag, Bonus_Type, Contact_Person_Name, Relationship, Contact_address1, Contact_address2, Contact_home_tel1, Contact_home_tel2, Emp_Blood_Group, EOBI_Number, SESSI_Number, Vehicle_Registration_Number, STATUS, Interest_Flag, Zakat_Flag, Account_Type1, Account_Type2, Account_Type3, Account_Type4, Picture, Emp_id, Offer_Letter_date, Tentative_Joining_date, RefferedBy, Probationary_period_months, Notice_period_months, Extended_confirmation_days, Permanent_address, Nationality, @UserCode, NOW(), @roster_group_code, @card_no, @ContractExpiryDate, @Position_Code, @CompanyCode
FROM tran_appointments
WHERE Sequence_no = @SequenceNo;

 END IF;
END$$

CREATE  PROCEDURE `sp_PER_Tran_Hiring_Checklist_UpdateTran` (IN `seq` INT, IN `item` INT, IN `User_Code` INT, IN `companyCode` INT, IN `flag` TEXT)   BEGIN
if flag = 'Y' then
	DELETE FROM tran_hiring_checklist
        WHERE SeqNo = seq and company_code=companyCode;
	    END IF;
    INSERT INTO tran_hiring_checkList
    VALUES (seq, item,User_Code,companyCode);

    COMMIT;
END$$

CREATE  PROCEDURE `UpdateEducation` (IN `srno` INT, IN `EduCode` INT, IN `EduYear` INT, IN `EduGrade` TEXT, IN `Topflag` TEXT, IN `institutecode` INT, IN `postedBy` INT, IN `posteddate` TEXT, IN `Initiatedby` INT, IN `Initiatedon` TEXT)   BEGIN
	update tran_educations set `Edu_Code`=EduCode,`Edu_Year`=EduYear,`Edu_Grade`=EduGrade,`Top_flag`=Topflag,`institute_code`=institutecode,`postedby`=postedBy,`posteddate`=posteddate,`Initiatedby`=Initiatedby,`Initiatedon`=Initiatedon where Sr_No=srno;
END$$

CREATE  PROCEDURE `UpdateExperience` (IN `ids` INT, IN `EmployerCode` INT, IN `designation` TEXT, IN `department` TEXT, IN `Start_Date` TEXT, IN `End_Date` TEXT, IN `SubmitFlag` TEXT, IN `SubmitBy` TEXT, IN `SubmitOn` TEXT, IN `ApproveBy` TEXT, IN `ApproveOn` TEXT, IN `Createdby` TEXT, IN `Createdon` TEXT)   BEGIN
	update tran_experiences set `Employer_Code`=EmployerCode,`Designation`=designation,`Department`=department,`StartDate`=Start_Date,`EndDate`=End_Date,`Submit_Flag`=SubmitFlag,`Submit_By`=SubmitBy,`Submit_On`=SubmitOn,`Approve_By`=ApproveBy,`Approve_On`=ApproveOn,`Created_by`=Createdby,`Created_on`=Createdon where `ID`=ids;
END$$

CREATE  PROCEDURE `UpdateFamilies` (IN `Sequenceno` INT, IN `Sno` INT, IN `FamMemberType` TEXT, IN `FamMemberName` TEXT, IN `FamMemberDOB` TEXT, IN `CNICNo` TEXT, IN `companycode` INT)   BEGIN
	update tran_appointment_families set `Fam_Member_Type`=FamMemberType,`Fam_Member_Name`=FamMemberName,`Fam_Member_DOB`=FamMemberDOB,`CNIC_No`=CNICNo where `company_code`=companycode and Sequence_no=Sequenceno and `S_no`=Sno;
END$$

CREATE  PROCEDURE `UpdateMarriages` (IN `Sequenceno` INT, IN `MarriageDate` TEXT, IN `Spausename` TEXT, IN `SpauseDOB` TEXT, IN `companycode` INT)   BEGIN
	UPDATE tran_appointment_marriages set `Marriage_Date`=MarriageDate,`Spause_name`=Spausename,`Spause_DOB`=SpauseDOB where `Sequence_no`=Sequenceno and `company_code`=companycode;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `companies`
--

CREATE TABLE `companies` (
  `id` int(11) NOT NULL,
  `company_name` text NOT NULL,
  `company_code` int(11) NOT NULL,
  `created_at` date NOT NULL,
  `updated_at` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `companies`
--

INSERT INTO `companies` (`id`, `company_name`, `company_code`, `created_at`, `updated_at`) VALUES
(1, 'ssssco', 1, '0000-00-00', '0000-00-00'),
(2, 'welabs', 2, '0000-00-00', '0000-00-00'),
(3, 'logomish', 3, '0000-00-00', '0000-00-00');

-- --------------------------------------------------------

--
-- Table structure for table `dirmenus`
--

CREATE TABLE `dirmenus` (
  `MenuCode` int(11) NOT NULL,
  `MenuLabel` varchar(100) DEFAULT NULL,
  `Menuurl` varchar(150) DEFAULT NULL,
  `AllowAll` char(1) DEFAULT NULL,
  `SortKey` varchar(2) DEFAULT NULL,
  `ParentCode` int(11) DEFAULT NULL,
  `CSSClass` varchar(100) DEFAULT NULL,
  `ActiveFlag` char(1) DEFAULT NULL,
  `MenuType` varchar(10) DEFAULT NULL,
  `company_code` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `dirmenus`
--

INSERT INTO `dirmenus` (`MenuCode`, `MenuLabel`, `Menuurl`, `AllowAll`, `SortKey`, `ParentCode`, `CSSClass`, `ActiveFlag`, `MenuType`, `company_code`) VALUES
(1000, 'Administration', 'Administration.aspx', '', 'MA', 0, NULL, 'Y', 'Standard', 0),
(1100, 'Reports', 'Reports.aspx', '', 'N', 1000, NULL, 'Y', 'Standard', 0),
(1101, 'User Access Report', 'Per_ReportUserAccessByProgram.aspx?id=1', '', 'pp', 1100, NULL, 'Y', 'Standard', 0),
(1102, 'Group Access Report', 'Per_ReportGroupAccess.aspx?id=1', '', 'pp', 1100, NULL, 'Y', 'Standard', 0),
(1103, 'Payroll Access Report', 'Per_ReportPayrollAccess.aspx?id=1', '', 'pp', 1100, NULL, 'Y', 'Standard', 0),
(1104, 'User Access (Save & Process Buttons)', 'Per_ReportUserAccessSaveProcessButtons.aspx?id=1', '', 'pp', 1100, NULL, 'Y', 'Standard', 0),
(1105, 'Group Access (Save & Process Buttons)', 'Per_ReportGroupAccessSaveProcessButtons.aspx?id=1', '', 'pp', 1100, NULL, 'Y', 'Standard', 0),
(1200, 'HR Admin Access', '../Hr_Operations/HR_Div_Access.aspx', '', 'MM', 1000, NULL, 'Y', 'Standard', 0),
(1300, 'User Profiles', 'UserProfiles.aspx', '', 'PP', 1000, NULL, 'Y', 'Standard', 0),
(1301, 'Update Employees ID', '../HR_Operations/update_sys_employees.aspx', '', 'PP', 1300, NULL, 'Y', 'Standard', 0),
(1302, 'Create User', 'Admin_create_user.aspx?id=1', '', 'pp', 1300, NULL, 'Y', 'Standard', 0),
(1303, 'Edit User', 'Admin_User_Edit.aspx?id=1', '', 'pp', 1300, NULL, 'Y', 'Standard', 0),
(1304, 'Delete User', 'Admin_delete_user.aspx?id=1', '', 'pp', 1300, NULL, 'Y', 'Standard', 0),
(1305, 'Change Password', '../Administration/Admin_Change_password.aspx', '', 'pp', 1300, NULL, 'Y', 'Standard', 0),
(1306, 'Email Password', 'Admin_EmailPassword.aspx?id=1', '', 'pp', 1300, NULL, 'Y', 'Standard', 0),
(1400, 'User Access Control', 'UserAccessControl.aspx', '', 'N', 1000, NULL, 'Y', 'Standard', 0),
(1401, 'Access Control', '../Administration/UsersAccess.aspx?id=1', '', 'pp', 1400, NULL, 'Y', 'Standard', 0),
(1403, 'User Access On one Menu', 'DirMenueAccess.aspx?id=1', '', 'pp', 1400, NULL, 'Y', 'Standard', 0),
(1404, 'DashBoard Option Enable Form', 'ESS_Dashboard_User_Access.aspx?id=1', '', 'pp', 1400, NULL, 'Y', 'Standard', 0),
(1405, 'Employee Same access as Others', 'Sys_Employees_Same_Acess.aspx', '', 'pp', 1400, NULL, 'Y', 'Standard', 0),
(1500, 'Group Profiles', 'GroupProfiles.aspx', '', 'N', 1000, NULL, 'Y', 'Standard', 0),
(1501, 'Create Group', 'Admin_Create_Group.aspx?id=1', '', 'pp', 1500, NULL, 'Y', 'Standard', 0),
(1600, 'Group Access Control', 'GroupAccessControl.aspx', '', 'N', 1000, NULL, 'Y', 'Standard', 0),
(1601, 'Group Access Control', 'groupAccess.aspx?id=1', '', 'pp', 1600, NULL, 'Y', 'Standard', 0),
(1602, 'Group Access Save and Process Butto', 'Admin_Group_Access_Update_Button_Control.aspx?id=1', '', 'pp', 1600, NULL, 'Y', 'Standard', 0),
(1603, 'User/Group Linking', 'Admin_group_link_access.aspx?id=1', '', 'pp', 1600, NULL, 'Y', 'Standard', 0),
(2000, 'HR Operations', 'HROperations.aspx', '', 'MM', 0, NULL, 'Y', 'Standard', 0),
(2100, 'Manual Transaction Posting ', 'ManualTransactionPosting.aspx', '', 'N', 2000, NULL, 'Y', 'Standard', 0),
(2101, 'Transaction Pending List', 'Per_Transection_Pending_List.aspx?id=10', '', 'Tr', 2100, NULL, 'Y', 'Standard', 0),
(2102, 'Appointment', '../HR_Operations/Per_TranAppointments_List.aspx', '', 'Ap', 2100, NULL, 'Y', 'Standard', 0),
(2103, 'Appointment Letter', 'Per_TranAppointment_Letter_List.aspx?id=10', '', 'Ap', 2100, NULL, 'Y', 'Standard', 0),
(2104, 'Confirmatio', '../Hr_Operations/Per_TranConfirmations_List.aspx', '', 'Co', 2100, NULL, 'Y', 'Standard', 0),
(2105, 'Confirmation Extensio', '../HR_Operations/Per_TranConfirmationsExtend_List.aspx?id=10', '', 'Co', 2100, NULL, 'Y', 'Standard', 0),
(2106, 'Confirmation Memo', 'Per_TranConfirmationsMemo_List.aspx?id=10', '', 'Co', 2100, NULL, 'Y', 'Standard', 0),
(2107, 'Increment', '../Hr_Operations/Per_TranIncrements_List.aspx', '', 'I', 2100, NULL, 'Y', 'Standard', 0),
(2109, 'Promotio', '../Hr_Operations/Per_TranPromotions_List.aspx', '', 'Pr', 2100, NULL, 'Y', 'Standard', 0),
(2110, 'Leave', '../HR_OPERATIONS/Per_TranLeaves_List.aspx', '', 'Le', 2100, NULL, 'Y', 'Standard', 0),
(2111, 'Manual Leave Deletio', '../HR_OPERATIONS/Per_TranLeavesDeletion_Process.aspx', '', 'Le', 2100, NULL, 'Y', 'Standard', 0),
(2112, 'Marriage', '../HR_Operations/Per_TranMarriages_List.aspx?id=10', '', 'Ma', 2100, NULL, 'Y', 'Standard', 0),
(2113, 'Family', '../HR_Operations/Per_TranFamilies_List.aspx?id=10', '', 'Fa', 2100, NULL, 'Y', 'Standard', 0),
(2114, 'Dependent', 'TranEmployeeDependents_HRApproval.aspx', '', 'De', 2100, NULL, 'Y', 'Standard', 0),
(2115, 'Educatio', '../HR_Operations/Per_TranEducations_List.aspx?id=10', '', 'Ed', 2100, NULL, 'Y', 'Standard', 0),
(2116, 'Experience', '../HR_Operations/Per_TranExperiences_List.aspx?id=10', '', 'Ex', 2100, NULL, 'Y', 'Standard', 0),
(2117, 'ReOrganizatio', '../Hr_Operations/Per_TranTransfers_List.aspx?id=10', '', 'Tr', 2100, NULL, 'Y', 'Standard', 0),
(2118, 'Upload EOBI', '../HR_Operations/Per_TranUploadEOBIdata.aspx?id=10', '', 'Up', 2100, NULL, 'Y', 'Standard', 0),
(2119, 'Anual Leave Planning', 'Per_Annual_Leave_Planning_List.aspx?id=10', '', 'A', 2100, NULL, 'Y', 'Standard', 0),
(2120, 'Pre Employment Medical', 'Per_Pre_Employment_Medical_Planning_List.aspx?id=10', '', 'Pr', 2100, NULL, 'Y', 'Standard', 0),
(2121, 'Change of Contract Employee Manual', '../HR_Operations/PER_EmployeeRenewel_List.aspx?id=10', '', 'Co', 2100, NULL, 'Y', 'Standard', 0),
(2122, 'Edit Contract Employee Renewel', 'PER_EmployeeRenewel_List1.aspx?id=10', '', 'Ed', 2100, NULL, 'Y', 'Standard', 0),
(2123, 'Staff Job Descriptions', '../Hr_Operations/Per_Staff_Job_Description_Report.aspx?id=10', '', 'St', 2100, NULL, 'Y', 'Standard', 0),
(2124, 'Contract To Permanent', 'PER_ContractToPermanent_List.aspx?id=10', '', 'Co', 2100, NULL, 'Y', 'Standard', 0),
(2125, 'Re-Designatio', '../Hr_Operations/per_designation_transfer_list.aspx?id=10', '', 'Tr', 2100, NULL, 'Y', 'Standard', 0),
(2126, 'Holidays', 'Per_holiday.aspx?id=10', '', 'Ho', 2100, NULL, 'Y', 'Standard', 0),
(2127, 'Warning/Explanation Letters', 'Plan_Employee_Official_letters.aspx?id=70', '', 'Wa', 2100, NULL, 'Y', 'Standard', 0),
(2128, 'Upload User Ids', 'Per_TranUploaduserid.aspx?id=10', '', 'Up', 2100, NULL, 'Y', 'Standard', 0),
(2129, 'Upload Leave Pla', 'Per_TranUploadLeavePlan.aspx?id=10', '', 'Up', 2100, NULL, 'Y', 'Standard', 0),
(2130, 'References', 'History_references.aspx', '', 'Re', 2100, NULL, 'Y', 'Standard', 0),
(2131, 'Update All Employees Leave_Balances', 'Download_Yearly_Leaves.aspx?id=10', '', 'Up', 2100, NULL, 'Y', 'Standard', 0),
(2132, 'Resigned Leave Transactio', 'Per_TranLeaves_Resignation_List.aspx?id=10', '', 'Re', 2100, NULL, 'Y', 'Standard', 0),
(2133, 'Resigned Staff last Salary', 'ResignStaff_SalaryDataDownload.aspx?id=10', '', 'Re', 2100, NULL, 'Y', 'Standard', 0),
(2134, 'Hoildays BranchWise', 'Working_Holiday_BranchWise.aspx?id=10', '', 'Ho', 2100, NULL, 'Y', 'Standard', 0),
(2135, 'Personal And Official Visits', 'Personal_Official_Visits_Employee.aspx', '', 'Pe', 2100, NULL, 'Y', 'Standard', 0),
(2136, 'Link Correct Designatio', 'Link_Designation.aspx', '', 'Li', 2100, NULL, 'Y', 'Standard', 0),
(2137, 'Referance Letter Ex Staff', 'Referance_Letter.aspx', '', 'Re', 2100, NULL, 'Y', 'Standard', 0),
(2138, 'HR Email Setups For Options', 'Hr_admin_directory.aspx', '', 'HR', 2100, NULL, 'Y', 'Standard', 0),
(2139, 'JOB Description Upload', 'DesignationDocUpload.aspx', '', 'JO', 2100, NULL, 'Y', 'Standard', 0),
(2140, 'New Account HR Approval', 'ESS_NewAccount_HRPanel.aspx', '', 'Ne', 2100, NULL, 'Y', 'Standard', 0),
(2141, 'PF Additional Contributio', '../hr_operations/PFAdditionalContribution.aspx', '', 'ZZ', 2100, '', 'Y', 'Standard', 0),
(2142, 'Flaxible Timings', 'Employee_Flexibility_Individual.aspx', '', 'Fl', 2100, NULL, 'Y', 'Standard', 0),
(2143, 'Late Arrival', 'LateArrivals.aspx?id=10', '', 'La', 2100, NULL, 'Y', 'Standard', 0),
(2144, 'Organizational Chart', 'VB.aspx', '', 'Or', 2100, NULL, 'Y', 'Standard', 0),
(2145, 'Late Arrival Upload', 'LateArrivals_Uploading.aspx?id=10', '', 'La', 2100, NULL, 'Y', 'Standard', 0),
(2146, 'Supervisor Update', 'App_BulkAppraisalNew.aspx', '', 'Su', 2100, NULL, 'Y', 'Standard', 0),
(2147, 'Leave Hisrrachy and Supervisor Upload ', 'excel_upload_supervisor_levels.aspx', '', 'Le', 2100, NULL, 'Y', 'Standard', 0),
(2148, 'LWP Only Posting', 'historyleavesnewApprovals.aspx?id=10', '', 'LW', 2100, NULL, 'Y', 'Standard', 0),
(2149, 'Restore Resingned', 'restore_employee_process.aspx?id=10', '', 'Re', 2100, NULL, 'Y', 'Standard', 0),
(2150, 'Budget Upload', 'excel_upload_employee_budget_information.aspx', '', 'Bu', 2100, NULL, 'Y', 'Standard', 0),
(2151, 'Leave Delete (khi worker)', '../HR_OPERATIONS/Per_TranLeavesDeletion_Process_queetaworker.aspx', '', 'pp', 2100, NULL, 'Y', 'Standard', 0),
(2152, 'Master Leave (khi worker)', '../HR_OPERATIONS/Per_TranLeaves_Process_queeta_workwer.aspx', '', 'pp', 2100, NULL, 'Y', 'Standard', 0),
(2153, 'Leave (khi worker)', '../HR_OPERATIONS/Per_TranLeaves_Process_queeta_workwer.aspx', '', 'pp', 2100, NULL, 'Y', 'Standard', 0),
(2154, 'Leave (khi worker)', '../HR_OPERATIONS/Per_TranLeaves_Process_queeta_workwer.aspx', '', 'pp', 2100, NULL, 'Y', 'Standard', 0),
(2155, 'Leave Delete (khi worker)', '../HR_OPERATIONS/Per_TranLeavesDeletion_Process_queetaworker.aspx', '', 'pp', 2100, NULL, 'Y', 'Standard', 0),
(2156, 'Master Leave (khi worker)', '../HR_OPERATIONS/Per_TranLeaves_Process_queeta_workwer.aspx', '', 'pp', 2100, NULL, 'Y', 'Standard', 0),
(2157, 'Exit Interview Check List', '../Hr_Operations/exit_interview_form_checklist.aspx', '', 'pp', 2100, NULL, 'Y', 'Standard', 0),
(2158, 'Exit and Final Settlement', 'exit.aspx', '', 'M', 2100, NULL, 'Y', 'Standard', 0),
(2159, 'Exit Processing', '../Hr_Operations/Per_TranResignations_Process.aspx?id=10', '', 'aa', 2158, NULL, 'Y', 'Standard', 0),
(2160, 'Final Settlement Process', '../final_settlement/EmployeeFinalSettlement_List.aspx?id=60', '', 'pp', 2158, NULL, 'Y', 'Standard', 0),
(2161, 'Final Settlement Slip Reprint', '../final_settlement/EmployeeFinalSettlement_SlipReprint.aspx?id=60', '', 'zz', 2158, NULL, 'Y', 'Standard', 0),
(2175, 'Retirement', '../HR_Operations/Retirement_List.aspx?id=10', '', 'PP', 2100, NULL, 'Y', 'Standard', 0),
(2176, 'Master Leave (khi)', '../HR_OPERATIONS/Maste_leave_update_balances_request.aspx', '', 'ZZ', 2100, NULL, 'Y', 'Standard', 0),
(2177, 'Salary Hold', '../HR_Operations/PAY_TranPayslip_Salary_Hold_For_HR_List.aspx', '', 'ZZ', 2100, NULL, 'Y', 'Standard', 0),
(2178, 'Change of Retirement Date / Confirmation Due Date', '../HR_Operations/Master_Employees_RetirementDate_List.aspx', '', 'ZZ', 2100, NULL, 'Y', 'Standard', 0),
(2179, 'Upload Employees Bank Accounts', '../HR_Operations/Upload_Employees_Bank_Account.aspx?10', '', 'ZZ', 2100, NULL, 'Y', 'Standard', 0),
(2180, 'Transaction Update', '../Hr_Operations/admin_update_employees_transactions.aspx', '', 'ZZ', 2100, NULL, 'Y', 'Standard', 0),
(2181, 'Upload Transactions', '../Hr_Operations/Upload_Employee_Transactions.aspx?id=10', '', 'ZZ', 2100, NULL, 'Y', 'Standard', 0),
(2182, 'Upload Emergency Contacts', '../Hr_Operations/Upload_Emergency_Contact.aspx?id=10', '', 'ZZ', 2100, NULL, 'Y', 'Standard', 0),
(2183, 'Upload Promotions / Transfer', '../Hr_Operations/Excel_Upload_Yearly_Promotions.aspx?id=10', '', 'ZZ', 2100, NULL, 'Y', 'Standard', 0),
(2184, 'Upload ReDesignations', '../Hr_Operations/Excel_Upload_ReDesignation.aspx?id=10', '', 'ZZ', 2100, NULL, 'Y', 'Standard', 0),
(2185, 'Master Employees Extensio', '../HR_Operations/Master_Employees_Extension.aspx', '', 'ZZ', 2100, NULL, 'Y', 'Standard', 0),
(2186, 'Generate Overtime', '../HR_Operations/Generate_Overtime.aspx', '', 'ZZ', 2100, NULL, 'Y', 'Standard', 0),
(2187, 'DashBoard Uploads', '../Administration/DashBoardUploads.aspx', '', 'ZZ', 2100, NULL, 'Y', 'Standard', 0),
(2200, 'History File Updations', 'HistoryFileUpdations.aspx', '', 'N', 2000, NULL, 'Y', 'Standard', 0),
(2201, 'Confirmatio', '../HR_Operations/Per_HistConfirmations_List.aspx?id=10', '', 'pp', 2200, NULL, 'Y', 'Standard', 0),
(2202, 'Promotions', 'Per_HistPromotions_List.aspx?id=10', '', 'pp', 2200, NULL, 'Y', 'Standard', 0),
(2203, 'Transfers', 'Per_HistTransfer_List.aspx?id=10', '', 'pp', 2200, NULL, 'Y', 'Standard', 0),
(2204, 'Leaves', 'Per_Hist_Leave_List.aspx?id=10', '', 'pp', 2200, NULL, 'Y', 'Standard', 0),
(2205, 'Appointment', 'Per_HistAppointments_List.aspx?id=10', '', 'pp', 2200, NULL, 'Y', 'Standard', 0),
(2206, 'Resignatio', 'Per_HistResignation_List.aspx?id=10', '', 'pp', 2200, NULL, 'Y', 'Standard', 0),
(2300, 'Inquiry/Reports', 'Inquiry/Reports.aspx', '', 'N', 2000, NULL, 'Y', 'Standard', 0),
(2301, 'Employee Encyclopedia', 'Per_Inquiry_Enc_MasterEmployees_Search.aspx?id=10', '', 'pp', 2300, NULL, 'Y', 'Standard', 0),
(2302, 'History Encyclopedia', 'Per_Inquiry_Enc_History_Search.aspx?id=10', '', 'pp', 2300, NULL, 'Y', 'Standard', 0),
(2303, 'Leave Encyclopedia', 'Per_Inquiry_Enc_Leave_Search.aspx?id=10', '', 'pp', 2300, NULL, 'Y', 'Standard', 0),
(2304, 'Resigned Employee Information Report', 'Per_ReportResignedPersonalInfo.aspx?id=10', '', 'pp', 2300, NULL, 'Y', 'Standard', 0),
(2305, 'Employee Information Report', 'Per_ReportEmployeeInformationInfo.aspx?id=10', '', 'pp', 2300, NULL, 'Y', 'Standard', 0),
(2306, 'Dependant Report', 'Per_ReportDependentInfo.aspx?id=10', '', 'pp', 2300, NULL, 'Y', 'Standard', 0),
(2307, 'Staff Strength Location Wise', 'Per_Staff_Strength_loc_Wise.aspx?id=10', '', 'pp', 2300, NULL, 'Y', 'Standard', 0),
(2308, 'Staff Strength Grade Wise', 'Per_Staff_Strength_grade_Wise.aspx?id=10', '', 'pp', 2300, NULL, 'Y', 'Standard', 0),
(2309, 'Staff Strength Grade Wise - HO', 'Per_Staff_Strength_Grade_Wise_HO.aspx?id=10', '', 'pp', 2300, NULL, 'Y', 'Standard', 0),
(2310, 'Staff Strength Dept Wise - HO', 'Per_Staff_Strength_Dept_Wise_HO.aspx?id=10', '', 'pp', 2300, NULL, 'Y', 'Standard', 0),
(2311, 'Staff Strength Grade  - Location Wise', 'Per_Staff_Strength_Grade_Wise_LocWise.aspx?id=10', '', 'pp', 2300, NULL, 'Y', 'Standard', 0),
(2312, 'Staff Strength Grade  - Cader Wise', 'Per_CaderWise_DesignationWise.aspx?id=10', '', 'pp', 2300, NULL, 'Y', 'Standard', 0),
(2313, 'Staff Strength Head Count', 'Per_Staff_Strength_HeadCount.aspx?id=10', '', 'pp', 2300, NULL, 'Y', 'Standard', 0),
(2314, 'Staff Qualification Summary', 'Per_StaffQualification_Summary.aspx?id=10', '', 'pp', 2300, NULL, 'Y', 'Standard', 0),
(2315, 'Exits from Active Populatio', 'Per_ExitsFrom_ActivePopulation.aspx?id=10', '', 'pp', 2300, NULL, 'Y', 'Standard', 0),
(2317, 'Employees hired on contract/regular', 'Per_Employeeshired.aspx?id=10', '', 'pp', 2300, NULL, 'Y', 'Standard', 0),
(2318, 'Employees Transfer', 'Per_EmployeesTransfer.aspx?id=10', '', 'pp', 2300, NULL, 'Y', 'Standard', 0),
(2319, 'Age Wise Employees', 'Per_AgeWiseEmployees.aspx?id=10', '', 'pp', 2300, NULL, 'Y', 'Standard', 0),
(2320, 'Gender Wise Employees', 'Per_GenderWiseEmployees.aspx?id=10', '', 'pp', 2300, NULL, 'Y', 'Standard', 0),
(2321, 'Staff Strength Employees Details', 'Per_Staff_strength_EmplyeesDetails.aspx?id=10', '', 'pp', 2300, NULL, 'Y', 'Standard', 0),
(2322, 'Confirmed/UnConfirmed Employees', 'Per_ConfirmUnConfirm_Employees_Report.aspx?id=10', '', 'pp', 2300, NULL, 'Y', 'Standard', 0),
(2323, 'Increments/Promotions History', 'Per_Promotions_Increments.aspx?id=10', '', 'pp', 2300, NULL, 'Y', 'Standard', 0),
(2324, 'Retired Staff Reports', 'Per_Retired_staff_report.aspx?id=10', '', 'pp', 2300, NULL, 'Y', 'Standard', 0),
(2400, 'Reports', 'Reports.aspx', '', 'N', 2000, NULL, 'Y', 'Standard', 0),
(2401, 'Family Report', 'Per_ReportFamilyInfo.aspx?id=10', '', 'ZZ', 2400, NULL, 'Y', 'Standard', 0),
(2402, 'New Appointment Report', '../HR_Operations/Per_ReportNewAppointmentInfo.aspx?id=10', '', 'pp', 2400, NULL, 'Y', 'Standard', 0),
(2403, 'Due For Confirmatio', '../Hr_Operations/Per_ReportDueForConfirmationInfo.aspx?id=10', '', 'pp', 2400, NULL, 'Y', 'Standard', 0),
(2404, 'Employee Experience Report', '../HR_Operations/Per_Experience_Report.aspx?id=10', '', 'pp', 2400, NULL, 'Y', 'Standard', 0),
(2405, 'Employee Education Report', '../HR_Operations/Per_Education_Report.aspx?id=10', '', 'pp', 2400, NULL, 'Y', 'Standard', 0),
(2406, 'Retirement/Separation Report', '../HR_Operations/Per_ReportResignationHistoryInfo.aspx?ID=10', '', 'pp', 2400, NULL, 'Y', 'Standard', 0),
(2407, 'Service Length Report', '../HR_Operations/Per_ReportServiceLengthInfo.aspx?id=10', '', 'pp', 2400, NULL, 'Y', 'Standard', 0),
(2408, 'Date Of Birth Inquiry Report', '../HR_Operations/Per_ReportDateOfBirthInfo.aspx', '', 'pp', 2400, NULL, 'Y', 'Standard', 0),
(2409, 'Retirement Due Report', '../HR_Operations/Per_ReportRetirementDueInfo.aspx?id=10', '', 'pp', 2400, NULL, 'Y', 'Standard', 0),
(2410, 'Salary On-Hold Report', '../HR_Operations/Per_ReportSalaryOnHoldInfo.aspx?id=10', '', 'pp', 2400, NULL, 'Y', 'Standard', 0),
(2411, 'Gross Salary BreakUp Report', '../Hr_Operations/Per_ReportGrossSalaryBreakUpInfo.aspx?id=10', '', 'pp', 2400, NULL, 'Y', 'Standard', 0),
(2412, 'Organizational Chart Report', 'Per_ReportOrganizationChartInfo1.aspx?id=10', '', 'pp', 2400, NULL, 'Y', 'Standard', 0),
(2413, 'Confirmation Extension Report', '../Hr_Operations/Report_History_ConfirmationsExtend.aspx?id=10', '', 'pp', 2400, NULL, 'Y', 'Standard', 0),
(2414, 'Increment Report', '../Hr_Operations/Per_Increment_Report.aspx?id=10', '', 'pp', 2400, NULL, 'Y', 'Standard', 0),
(2415, 'Antecedents Report', 'Per_Tran_Antecedents_List.aspx?id=10', '', 'pp', 2400, NULL, 'Y', 'Standard', 0),
(2416, 'Contract Expiry Report', '../HR_Operations/Per_Emp_Contract_Expiry_Report.aspx?id=10', '', 'pp', 2400, NULL, 'Y', 'Standard', 0),
(2417, 'Staff Job Descriptio', '../Hr_Operations/Per_Staff_Job_Description_Report.aspx?id=10', '', 'pp', 2400, NULL, 'Y', 'Standard', 0),
(2418, 'Branches List', 'Report_AllBranches.aspx?id=10', '', 'pp', 2400, NULL, 'Y', 'Standard', 0),
(2419, 'Branches List(Consolidated)', 'Report_AllLocationsDetail.aspx?id=10', '', 'pp', 2400, NULL, 'Y', 'Standard', 0),
(2420, 'Branch Wise Staff Contact', 'Per_Branch_StaffContact_Report.aspx?id=10', '', 'pp', 2400, NULL, 'Y', 'Standard', 0),
(2421, 'Branch Wise Cadre Resignatio', 'Per_BranchWise_GradeResignation_Report.aspx?id=10', '', 'pp', 2400, NULL, 'Y', 'Standard', 0),
(2422, 'Branch Wise Employee Resignatio', 'Per_BranchWise_EmployeeResignation_Report.aspx?id=10', '', 'pp', 2400, NULL, 'Y', 'Standard', 0),
(2423, 'Employee Profile', '../Hr_Operations/Employee_Profile_Report.aspx?id=70', '', 'pp', 2400, NULL, 'Y', 'Standard', 0),
(2424, 'Probation Employee Report', '../Hr_Operations/Report_ProbationEmployee.aspx?id=70', '', 'ZZ', 2400, NULL, 'Y', 'Standard', 0),
(2425, 'Employee Bonus Report', '../Hr_Operations/Per_Report_EmployeeBonus.aspx?id=70', '', 'ZZ', 2400, NULL, 'Y', 'Standard', 0),
(2426, 'Employee Bank Account Detail Report', '../Hr_Operations/Report_Bank_Account_Detail.aspx?id=70', '', 'ZZ', 2400, NULL, 'Y', 'Standard', 0),
(2427, 'Employee Bank Account Detail Report', '../Hr_Operations/Report_Bank_Account_Detail.aspx?id=70', '', 'ZZ', 2400, NULL, 'Y', 'Standard', 0),
(2428, 'Employee Bonus Report', '../Hr_Operations/Per_Report_EmployeeBonus.aspx?id=70', '', 'ZZ', 2400, NULL, 'Y', 'Standard', 0),
(2429, 'Long Service Award Report', '../Hr_Operations/Per_ReportLongServiceAward.aspx?id=70', '', 'ZZ', 2400, NULL, 'Y', 'Standard', 0),
(2430, 'History Transfer Report', '../Hr_Operations/Per_ReportHistoryTransfer.aspx?id=70', '', 'ZZ', 2400, NULL, '', 'Un Know', 0),
(2431, 'Probation Employee Report', '../Hr_Operations/Report_ProbationEmployee.aspx?id=70', '', 'ZZ', 2400, NULL, 'Y', 'Standard', 0),
(2432, 'Graphical Reports', '../Hr_Operations/Dashboard_Graphical_Reports.aspx', '', 'AA', 2400, NULL, 'Y', 'Standard', 0),
(2433, 'Organogram Report', '../Administration/Report_Organogram.aspx', '', 'BB', 2400, NULL, 'Y', 'Standard', 0),
(2434, 'Employees Increment', '../Hr_Operations/Per_IncrementalReport.aspx?id=10', '', 'pp', 2400, NULL, 'Y', 'Standard', 0),
(2435, 'Employee Promotio', '../Hr_Operations/Per_EmployeesPromotions.aspx?id=10', '', 'pp', 2400, NULL, '', 'Un Know', 0),
(2436, 'Employee Transfer', '../Hr_Operations/Per_EmployeesTransfer.aspx?id=10', '', 'pp', 2400, NULL, '', 'Un Know', 0),
(2437, 'Organogram', '../Administration/Report_Organogram.aspx', '', 'ZZ', 2400, NULL, '', 'Un Know', 0),
(2438, 'Account Opening Letter', '../HR_Operations/account_opening_letter.aspx', '', 'rr', 2400, NULL, 'Y', 'Standard', 0),
(2500, 'Customized Reports', 'CustomizedReports.aspx', '', 'N', 2000, NULL, 'Y', 'Standard', 0),
(2501, 'Quarterly Staff Strength', 'Report_SPB_StaffStrength.aspx?id=10', '', 'pp', 2500, NULL, 'Y', 'Standard', 0),
(2502, 'SBP Movement Turnover', 'TranserDuration.aspx?id=10', '', 'pp', 2500, NULL, 'Y', 'Standard', 0),
(2503, 'Job Rotatio', 'Per_Transfer_Duration_Report.aspx?id=10', '', 'pp', 2500, NULL, 'Y', 'Standard', 0),
(2504, 'Official Letters Report', 'Pay_Location_Wise_Report_Excel_Letter.aspx?id=10', '', 'pp', 2500, NULL, 'Y', 'Standard', 0),
(2505, 'Functional title wise Cadre Wise', 'Per_Staff_Strength_desig_Wise.aspx?id=10', '', 'pp', 2500, NULL, 'Y', 'Standard', 0),
(2506, 'Final Settlement Report', 'seprationreport.aspx?id=10', '', 'pp', 2500, NULL, 'Y', 'Standard', 0),
(2507, 'Strength Wise Report', 'Per_Staff_Strength_strength_Wise.aspx?id=10', '', 'pp', 2500, NULL, 'Y', 'Standard', 0),
(2508, 'Region Wise Report', 'Per_MasterAllEmployees_DetailDataColumnwise.aspx?id=10', '', 'pp', 2500, NULL, 'Y', 'Standard', 0),
(2509, 'ESS Attendance Report', 'PAY_Brancewise_Attendance_Report.aspx?id=10', '', 'pp', 2500, NULL, 'Y', 'Standard', 0),
(2510, 'Budget Vs Actual Report', 'Report_Budget_for_Transfers.aspx', '', 'ZZ', 2500, NULL, 'Y', 'Standard', 0),
(2511, 'Monthly Changes Report', '../Hr_Operations/DataDownloadMultipleExcelSheets.aspx', '', 'PP', 2500, NULL, 'Y', 'Standard', 0),
(2512, 'History Transaction Report', '../HR_OPERATIONS/TransactionReports.aspx', '', 'PP', 2500, NULL, 'Y', 'Standard', 0),
(2513, 'Monthly Increment Changes Report', '../Hr_Operations/DataDownloadMultipleExcelIncrementSheets.aspx', '', 'PP', 2500, '', 'Y', 'Standard', 0),
(2550, 'Leave Reports', 'LeaveReports.aspx', '', 'N', 2000, NULL, 'Y', 'Standard', 0),
(2551, 'Leave Balance Report (HO)', 'EmployeeLeaveBalanceReportCallingHOConsolidated.aspx?id=10', '', 'pp', 2550, NULL, 'Y', 'Standard', 0),
(2552, 'Leave Balance Report (HO) Consolidated', 'EmployeeLeaveBalanceReportCallingHO.aspx?id=10', '', 'pp', 2550, NULL, 'Y', 'Standard', 0),
(2553, 'Leave Balance Report', 'EmployeeLeaveBalanceReportCalling.aspx?id=10', '', 'pp', 2550, NULL, 'Y', 'Standard', 0),
(2554, 'Leave Balance Report Consolidated', 'EmployeeLeaveBalanceReportCallingConsolidated.aspx?id=10', '', 'pp', 2550, NULL, 'Y', 'Standard', 0),
(2555, 'Leave Balance Report - Pro Rate', 'EmployeeLeaveBalanceReportProRate.aspx?id=10', '', 'pp', 2550, NULL, 'Y', 'Standard', 0),
(2556, 'Leave Status', 'EmployeeLeaveStatusReportCalling.aspx?id=10', '', 'pp', 2550, NULL, 'Y', 'Standard', 0),
(2557, 'Daily Leave Transactio', 'EmployeeDailyLeaveTransactionReportCalling.aspx?id=10', '', 'pp', 2550, NULL, 'Y', 'Standard', 0),
(2558, 'Employee Leave Progress', 'EmployeeLeaveProgressReportCalling.aspx?id=10', '', 'pp', 2550, NULL, 'Y', 'Standard', 0),
(2559, 'Anual Leave Plan (Branch)', 'EmployeeLeaveAnualPlanBranchReportCalling1.aspx?id=10', '', 'pp', 2550, NULL, 'Y', 'Standard', 0),
(2560, 'Anual Leave Plan(Headoffice)', 'EmployeeLeaveAnualPlanHeadofficeReportCalling1.aspx?id=10', '', 'pp', 2550, NULL, 'Y', 'Standard', 0),
(2561, 'Leave Encashtment Status', 'EmployeeLeaveEnchatmentReportCalling1.aspx?id=10', '', 'pp', 2550, NULL, 'Y', 'Standard', 0),
(2562, 'Employee Leave Encashment Report', 'Per_Leave_enchashment_report.aspx?id=10', '', 'pp', 2550, NULL, 'Y', 'Standard', 0),
(2563, 'Leave Plan Report', 'Per_report_Leave_Plan.aspx?id=10', '', 'pp', 2550, NULL, 'Y', 'Standard', 0),
(2564, 'Leave Plan Report-Head Office', 'Per_Leave_Plan_HeadOff_Report.aspx?id=10', '', 'pp', 2550, NULL, 'Y', 'Standard', 0),
(2565, 'Employee Leave Cycle', 'Per_EmployeeLeaveCycle_Report.aspx?id=10', '', 'pp', 2550, NULL, 'Y', 'Standard', 0),
(2566, 'Employee Leaves Hsitory', 'Per_History_Master_Leaves.aspx?id=10', '', 'pp', 2550, NULL, 'Y', 'Standard', 0),
(2600, 'Insurance', 'Insurance.aspx', '', 'N', 2000, NULL, 'Y', 'Standard', 0),
(2601, 'Group Insurance Reports', 'Per_Ins_rep_Cal_Grp.aspx?id=10', '', 'pp', 2600, NULL, 'Y', 'Standard', 0),
(2602, 'Group Insurance Encylopedia', 'PER_Insurance_Search.aspx?id=10', '', 'pp', 2600, NULL, 'Y', 'Standard', 0),
(2603, 'Group Insurance Resined Employees', 'Per_Ins_resined_Employees.aspx?id=10', '', 'pp', 2600, NULL, 'Y', 'Standard', 0),
(2604, 'Life Insurance Report', 'Per_Life_Insurance_report.aspx?id=10', '', 'pp', 2600, NULL, 'Y', 'Standard', 0),
(2640, 'Setups', 'DirectoryMaintenance.aspx', '', 'N', 2000, NULL, 'Y', 'Standard', 0),
(2641, 'Employment Type', '../Hr_Operations/PER_DirEmploymentTypes_List.aspx', '', '1', 2640, NULL, 'Y', 'Standard', 0),
(2642, 'Employee Catery', '../Hr_Operations/PER_DirEmployeeCatery_List.aspx', '', '2', 2640, NULL, 'Y', 'Standard', 0),
(2643, 'Cost Centre', '../Hr_Operations/PER_DirCostCentres_List.aspx?id=10', '', '14', 2640, NULL, 'Y', 'Standard', 0),
(2644, 'Grade', '../Hr_Operations/Per_DirGrades_List.aspx', '', '3', 2640, NULL, 'Y', 'Standard', 0),
(2645, 'Designatio', '../Hr_Operations/PER_DirDesignations_List.aspx', '', '4', 2640, NULL, 'Y', 'Standard', 0),
(2646, 'Education Levels', '../Hr_Operations/Per_DirEducationLevels_List.aspx', '', '21', 2640, NULL, 'Y', 'Standard', 0),
(2647, 'Educatio', '../Hr_Operations/Per_DirEducations_List.aspx', '', '22', 2640, NULL, 'Y', 'Standard', 0),
(2648, 'Previous Employers', '../Hr_Operations/Per_DirPreviousEmployers_List.aspx', '', '99', 2640, NULL, 'Y', 'Standard', 0),
(2649, 'Country', '../Hr_Operations/Per_DirCountries_List.aspx', '', '31', 2640, NULL, 'Y', 'Standard', 0),
(2650, 'Base City', '../Hr_Operations/DirBaseCity.aspx', '', '33', 2640, NULL, 'Y', 'Standard', 0),
(2651, 'Strength Of', '../Hr_Operations/Per_DirTransportations_List.aspx', '', '99', 2640, NULL, 'Y', 'Standard', 0),
(2652, 'Institutio', '../Hr_Operations/PER_DirInstitutions_List.aspx', '', '99', 2640, NULL, 'Y', 'Standard', 0),
(2653, 'Exit', '../Hr_Operations/Per_DirResignations_List.aspx', '', '99', 2640, NULL, 'Y', 'Standard', 0),
(2654, 'Leave Cateries', '../Hr_Operations/Per_DirLeaveCateries_List.aspx', '', '41', 2640, NULL, 'Y', 'Standard', 0),
(2655, 'Leave Types', '../Hr_Operations/Per_DirLeaveTypes_List.aspx', '', '42', 2640, NULL, 'Y', 'Standard', 0),
(2656, 'Religio', '../Hr_Operations/Per_DirReligions_List.aspx', '', '99', 2640, NULL, 'Y', 'Standard', 0),
(2657, 'Holidays', 'Per_DirHolidays.aspx?id=10', '', '99', 2640, NULL, 'Y', 'Standard', 0),
(2658, 'Hospitals', '../Hr_Operations/PER_DirHospitals_List.aspx', '', '99', 2640, NULL, 'Y', 'Standard', 0),
(2659, 'Medical Insurance', 'PER_DirInsurance_List.aspx', '', '99', 2640, NULL, 'Y', 'Standard', 0),
(2660, 'Life Insurance', 'PER_DirLifeInsurance_List.aspx', '', '99', 2640, NULL, 'Y', 'Standard', 0),
(2661, 'Departments', 'PER_DirSections_List.aspx?id=010', '', '99', 2640, NULL, 'Y', 'Standard', 0),
(2662, 'Leave Cycle', 'Per_DirLeaveCycle_List.aspx?id=10', '', '43', 2640, NULL, 'Y', 'Standard', 0),
(2663, 'Download Parameters', '../Hr_Operations/RefreshableData.aspx', '', '99', 2640, NULL, 'Y', 'Standard', 0),
(2664, 'Letter Signing Authorities', 'Per_DirLetterSigningAuthority.aspx?id=10', '', '99', 2640, NULL, 'Y', 'Standard', 0),
(2665, 'Download Parameter Access', '../Hr_Operations/Parameter_Access_List.aspx', '', '99', 2640, NULL, 'Y', 'Standard', 0),
(2666, 'Attendance Authorization Access', '../Hr_Operations/Parameter_Access_Deligation.aspx', '', '99', 2640, NULL, 'Y', 'Standard', 0),
(2667, 'Delegation Of Coordinators for Att', '../Hr_Operations/Parameter_Access_Correlated _Deligation.aspx', '', '99', 2640, NULL, 'Y', 'Standard', 0),
(2668, 'Divisions', '../Hr_Operations/Per_DirDivisions_List.aspx', '', '11', 2640, NULL, 'Y', 'Standard', 0),
(2669, 'Departments', '../Hr_Operations/Per_DirDepartments_List.aspx', '', '12', 2640, NULL, 'Y', 'Standard', 0),
(2670, 'Sections', '../Hr_Operations/Per_DirSections_List.aspx', '', '13', 2640, NULL, 'Y', 'Standard', 0),
(2671, 'Exit Checklist', '../Hr_Operations/dir_checklist_exit.aspx?10', '', '99', 2640, NULL, 'Y', 'Standard', 0),
(2672, 'Transaction Access', '../HR_Operations/Link_Transaction_Type_Access.aspx', '', '99', 2640, NULL, 'Y', 'Standard', 0),
(2673, 'Divisions Leave Access', '../Hr_Operations/Per_DirDivisions_LeaveAccess.aspx', '', 'zz', 2640, NULL, 'Y', 'Standard', 0),
(2674, 'Locations Leave Access', '../Hr_Operations/Per_DirLocations_LeaveAccess.aspx', '', 'zz', 2640, NULL, 'Y', 'Standard', 0),
(2675, 'Upload Letter Formats', '../HR_Operations/Upload_letter_formats.aspx', '', 'ZZ', 2640, NULL, 'Y', 'Standard', 0),
(2676, 'Positions', '../Hr_Operations/Dir_PositionProfiles.aspx', '', 'ZZ', 2640, NULL, 'Y', 'Standard', 0),
(2700, 'Geo Setup', 'GeoSetup.aspx', '', 'N', 2000, NULL, 'Y', 'Standard', 0),
(2701, 'Locatio', '../Hr_Operations/Per_DirLocations_List.aspx', '', '3', 2700, NULL, 'Y', 'Standard', 0),
(2702, 'Area', '../HR_Operations/Dir_Geo_Level_2.aspx', '', '1', 2700, NULL, 'Y', 'Standard', 0),
(2703, 'Branch', '../HR_Operations/Dir_Geo_Level_1.aspx', '', '2', 2700, NULL, 'Y', 'Standard', 0),
(2704, 'Regio', '../HR_Operations/Dir_Geo_Level_3.aspx', '', '0', 2700, NULL, 'Y', 'Standard', 0),
(2740, 'Master Maintenance', 'MasterMaintenance.aspx', '', 'N', 2000, NULL, 'Y', 'Standard', 0),
(2741, 'History Appointment', 'Per_HistoryAppointments_List.aspx?id=10', '', 'pp', 2740, NULL, 'Y', 'Standard', 0),
(2742, 'Employee Master', '../Hr_Operations/Per_MasterEmployees_List.aspx', '', 'pp', 2740, NULL, 'Y', 'Standard', 0),
(2744, 'Calculate Leave Balances', 'CalculateLeaveBalances.aspx', '', 'pp', 2740, NULL, 'Y', 'Standard', 0),
(2745, 'Master Data For Leavers', 'Per_MasterEmployees_MasterDataWithResignDetails.aspx?id=10', '', 'pp', 2740, NULL, 'Y', 'Standard', 0),
(2746, 'Employee List -Active', '../Hr_Operations/Per_MasterEmployees_MasterDataWithColumns.aspx', '', 'pp', 2740, NULL, 'Y', 'Standard', 0),
(2747, 'Employee List -InActive', '../Hr_Operations/Per_MasterAllEmployees_MasterDataWithColumns.aspx', '', 'pp', 2740, NULL, 'Y', 'Standard', 0),
(2748, 'Master Data - Paysheet', 'Per_MasterEmployees_MasterDataPaysheet.aspx?id=10', '', 'pp', 2740, NULL, 'Y', 'Standard', 0),
(2749, 'Appointments', 'Per_TranAppointments_List_Download.aspx?id=10', '', 'pp', 2740, NULL, 'Y', 'Standard', 0),
(2750, 'Advance Salary', 'Per_MasterEmployees_MasterDataAdvanceSalary.aspx?id=10', '', 'pp', 2740, NULL, 'Y', 'Standard', 0),
(2780, 'Internship', 'Internship.aspx', '', 'N', 2000, NULL, 'Y', 'Standard', 0),
(2781, 'Internee List', 'Internee_List.aspx?id=10', '', 'pp', 2780, NULL, 'Y', 'Standard', 0),
(2782, 'Internee Encylopedia', 'Per_Inquiry_Internee.aspx?id=10', '', 'pp', 2780, NULL, 'Y', 'Standard', 0),
(2783, 'Internee Detail', 'Per_InterneeReport.aspx?id=10', '', 'pp', 2780, NULL, 'Y', 'Standard', 0),
(2800, 'Document Management', 'DocumentManagement.aspx', '', 'N', 2000, NULL, 'Y', 'Standard', 0),
(2840, 'History File Updatio', 'historyfileupdation.aspx', '', 'N', 2000, NULL, 'Y', 'Standard', 0),
(2841, 'Confirmation Update', '../hr_operations/Per_HistConfirmations_List.aspx', '', 'N', 2840, NULL, 'Y', 'Standard', 0),
(2842, 'Documents', '../HR_Operations/Per_TranDocuments_List.aspx?id=10', '', 'pp', 2840, NULL, 'Y', 'Standard', 0),
(5000, 'Payroll', 'Payroll.aspx', '', 'MM', 0, NULL, 'Y', 'Standard', 0),
(5100, 'Transactions Posting', 'TransactionsPosting.aspx', '', 'CC', 5000, NULL, 'Y', 'Standard', 0),
(5101, 'Cash Award Allowance', '../Payroll/PAY_TranPayslips_CashAward_List.aspx', '', 'pp', 5100, NULL, 'Y', 'Standard', 0),
(5102, 'Advance Salary', '../Payroll/PAY_TranPayslips_AdvanceSalary_List.aspx', '', 'pp', 5100, NULL, 'Y', 'Standard', 0),
(5103, 'Advance Salary Installment', '../Payroll/PAY_AdvanceSalary_Entry_List.aspx', '', 'pp', 5100, NULL, 'Y', 'Standard', 0),
(5104, 'Salary Projections', '../Payroll/PAY_TranPayslips_Salary_Projections_List.aspx', '', 'pp', 5100, NULL, 'Y', 'Standard', 0),
(5105, 'PF Nominatio', '../Payroll/PAY_TranPayslips_PFNominations_List.aspx', '', 'pp', 5100, NULL, 'Y', 'Standard', 0),
(5106, 'Overtime', 'PAY_TranPayslips_Overtimes_List.aspx?id=60', '', 'pp', 5100, NULL, 'Y', 'Standard', 0),
(5107, 'Late Sitting', 'PAY_TranPayslips_LateSittings_List.aspx?id=60', '', 'pp', 5100, NULL, 'Y', 'Standard', 0),
(5108, 'Tax Adjustments', '../Payroll/PAY_TranPayslips_Tax_Adjustments.aspx?id=60', '', 'pp', 5100, NULL, 'Y', 'Standard', 0),
(5109, 'Salary Hold', '../Payroll/PAY_TranPayslip_Salary_Hold_List.aspx?id=60', '', 'pp', 5100, NULL, 'Y', 'Standard', 0),
(5110, 'Upload - Payroll Data', '../Payroll/pay_tranpayslips_uploadpayrolldata.aspx', '', 'rr', 5100, NULL, 'Y', 'Standard', 0),
(5111, 'Upload Account No', 'Per_TranUploadaccountdata.aspx?id=60', '', 'pp', 5100, NULL, 'Y', 'Standard', 0),
(5112, 'PF Profit Upload', 'Upload_Employee_contribution.aspx?id=60', '', 'zz', 5100, NULL, 'Y', 'Standard', 0),
(5113, 'Payroll Catery Selectio', '../Payroll/HR_Payroll.aspx', '', 'AA', 5100, NULL, 'Y', 'Standard', 0),
(5114, 'Upload Payroll History', '../Payroll/temp_history_increment_data.aspx', '', 'AA', 5100, NULL, 'Y', 'Standard', 0),
(5115, 'Payroll Access', '../HR_Operations/Link_Payroll_Access.aspx', '', 'ZZ', 5100, NULL, 'Y', 'Standard', 0),
(5116, 'Taxable Car For Employees', '../Payroll/Pay_TranLink_Employee_Cars_List.aspx', '', 'ZZ', 5100, NULL, 'Y', 'Standard', 0),
(5117, 'Allowances / Deductions Entry', '../Payroll/PAY_TranPayslips_Allowances_Deduction_List.aspx?id=10', '', 'ZZ', 5100, NULL, 'Y', 'Standard', 0),
(5118, 'Payroll Versions', '../Hr_Operations/insert_payroll_versions.aspx?id=10', '', 'PP', 5100, NULL, 'Y', 'Standard', 0),
(5119, 'Download Basic Salary', '../Payroll/Report_Download_BasicSalary.aspx', '', 'qq', 5100, NULL, 'Y', 'Standard', 0),
(5120, 'Upload Leave Encashment', '../Payroll/PAY_UploadLeaveEncashment.aspx', '', 'qq', 5100, '', 'Y', 'Standard', 0),
(5200, 'Reports - General', 'Reports-General.aspx', '', 'N', 5000, NULL, 'Y', 'Standard', 0),
(5201, 'Range Wise Payslip', '../Payroll/PAY_Report_Salaryslip_EmpWise_1.aspx', '', 'pp', 5200, NULL, 'Y', 'Standard', 0),
(5202, 'PaySlip (Employee Wise)', '../Payroll/PAY_Report_Salaryslip_EmpWise.aspx', '', 'pp', 5200, NULL, 'Y', 'Standard', 0),
(5203, 'PaySlip (Employee Email)', '../Payroll/PAY_Report_SalaryslipEmail_EmpWise.aspx', '', 'pp', 5200, NULL, 'Y', 'Standard', 0),
(5204, 'Paysheet Summary', '../Payroll/PAY_Paysheet_Branch_Summary.aspx', '', 'pp', 5200, NULL, 'Y', 'Standard', 0),
(5205, 'Payroll Payment Report', '../Payroll/Report_Bank_Payment.aspx', '', 'pp', 5200, NULL, 'Y', 'Standard', 0),
(5206, 'Cash Payment Report', 'PAY_CashPaymentReportForm.aspx?id=60', '', 'pp', 5200, NULL, 'Y', 'Standard', 0),
(5207, 'Electronic Payment Report', 'ElectronicPaymentReport.aspx', '', 'pp', 5200, NULL, 'Y', 'Standard', 0),
(5208, 'Advance Salary Information Report', '../Payroll/PAY_LoanInformation.aspx', '', 'pp', 5200, NULL, 'Y', 'Standard', 0),
(5209, 'Cost Centre wise Summary Report', 'CostCentrewiseSummaryReport.aspx', '', 'pp', 5200, NULL, 'Y', 'Standard', 0),
(5210, 'Salary On-Hold Report', '../Payroll/SalaryOn-HoldReport.aspx', '', 'pp', 5200, NULL, 'Y', 'Standard', 0),
(5211, 'Master Payroll Sheet', '../Payroll/PAY_MasterPayrollSheetForm.aspx', '', 'pp', 5200, NULL, 'Y', 'Standard', 0),
(5212, 'PF Monthly Deductio', '../Payroll/PAY_Monthly_PFDeductionForm.aspx', '', 'pp', 5200, NULL, 'Y', 'Standard', 0),
(5213, 'Montly Master Report', '../Payroll/PAY_Monthly_MasterReport.aspx', '', 'pp', 5200, NULL, 'Y', 'Standard', 0),
(5214, 'Account List', '../Payroll/PAY_Report_Account_No.aspx', '', 'pp', 5200, NULL, 'Y', 'Standard', 0),
(5215, 'Audit Trail Report', '../Payroll/Pay_Audit_trail.aspx', '', 'pp', 5200, NULL, 'Y', 'Standard', 0),
(5216, 'Manual Audit Trail Report', '../Payroll/Manual_Pay_Audit_trail.aspx', '', 'pp', 5200, NULL, 'Y', 'Standard', 0),
(5217, 'Audit Trail Advance', '../Payroll/PAY_Audit_Trail_Advance.aspx', '', 'pp', 5200, NULL, 'Y', 'Standard', 0),
(5218, 'Arrears', '../Payroll/PAY_GrossSalaryArrears.aspx', '', 'pp', 5200, NULL, 'Y', 'Standard', 0),
(5219, 'Salary Projectio', '../Payroll/Pay_Salary_Projection.aspx?id=60', '', 'pp', 5200, NULL, 'Y', 'Standard', 0),
(5220, 'Tax Adjustment', 'Pay_Tax_Adjustment.aspx?id=60', '', 'pp', 5200, NULL, 'Y', 'Standard', 0),
(5221, 'Payroll Data With Column Selection (khi)', '../Payroll/Payroll_DataWithColumns.aspx', '', 'pp', 5200, NULL, 'Y', 'Standard', 0),
(5222, 'Dashboard Payroll', '../Payroll/Payroll_Dashboard.aspx?id=10', '', 'ZZ', 5200, NULL, 'Y', 'Standard', 0),
(5223, 'JV Summary Report', '../Payroll/Pay_JV_Summary_Report_SMFBL.aspx', '', 'pp', 5200, NULL, 'Y', 'Standard', 0),
(5224, 'Bank Letter Report', '../Payroll/Report_Bank_Letter.aspx', '', 'ZZ', 5200, NULL, 'Y', 'Standard', 0),
(5225, 'Bank Advance Letter Report', '../Payroll/Report_Bank_Advance_Payment_Letter.aspx', '', 'rr', 5200, NULL, 'Y', 'Standard', 0),
(5226, 'Payroll Excel Report', '../Payroll/Pay_DataDownloadExcel.aspx', '', 'pp', 5200, '', 'Y', 'Standard', 0),
(5230, 'Reports - Regulatory', 'Reports-Regulatory.aspx', '', 'N', 5000, NULL, 'Y', 'Standard', 0),
(5231, 'EOBI Monthly Report', 'Pay_MonthlyEOBIForm.aspx?id=60', '', 'pp', 5230, NULL, 'Y', 'Standard', 0),
(5232, 'EOBI Anual Report', 'Pay_AnnualEOBIForm.aspx?id=60', '', 'pp', 5230, NULL, 'Y', 'Standard', 0),
(5233, 'IncomeTax Report', 'PAY_TaxReportForm.aspx?id=60', '', 'pp', 5230, NULL, 'Y', 'Standard', 0),
(5234, 'EOBI Employee & Employer Contributio', 'PAY_EOBI_Emp_Contribution.aspx?id=60', '', 'pp', 5230, NULL, 'Y', 'Standard', 0),
(5235, 'EOBI PE01', 'PAY_EOBI_PE01.aspx?id=60', '', 'pp', 5230, NULL, 'Y', 'Standard', 0),
(5236, 'Employees Old Age Benefits Institutio', 'PAY_Emp_OldAge_Benifits.aspx?id=60', '', 'pp', 5230, NULL, 'Y', 'Standard', 0),
(5237, 'EOBI PE02', '../Payroll/Pay_eobi_pe02_new.aspx?id=60', '', 'pp', 5230, NULL, 'Y', 'Standard', 0),
(5238, 'Statement of Income and Tax Liability', 'Pay_IncomeTaxStatementForm.aspx?id=60', '', 'pp', 5230, NULL, 'Y', 'Standard', 0),
(5239, 'Tax Liability Report', '../Payroll/Pay_TaxLiability_Report.aspx?id=60', '', 'pp', 5230, NULL, 'Y', 'Standard', 0),
(5240, 'Payroll Reconciliation CostCenter', 'Pay_Report_CostCenter_Reconciliation.aspx?id=60', '', 'pp', 5230, NULL, 'Y', 'Standard', 0),
(5241, 'Salary Reconcilatio', 'Pay_Salary_Reconcilation.aspx?id=60', '', 'pp', 5230, NULL, 'Y', 'Standard', 0),
(5242, 'Tax Certificate', '../Payroll/PAY_Tax_Certificate.aspx?id=60', '', 'pp', 5230, NULL, 'Y', 'Standard', 0),
(5243, 'Master Tax Structure', '../Payroll/PAY_tax_structure.aspx?id=60', '', 'pp', 5230, NULL, 'Y', 'Standard', 0),
(5244, 'Tax Certificate Report', '../Payroll/Report_TaxCertificate_New.aspx', '', 'pp', 5230, NULL, '', 'Un Know', 0),
(5245, 'Cadre/Grade Wise Tax Report', 'PAY_CadreWiseTaxReport.aspx?id=60', '', 'pp', 5230, NULL, 'Y', 'Standard', 0),
(5246, 'Tax Calculator', '../Payroll/Pay_calculate_tax.aspx?id=60', '', 'pp', 5230, NULL, 'Y', 'Standard', 0),
(5247, 'Tax Pay Report', '../Payroll/Pay_Tax_Adjustment.aspx?id=60', '', 'pp', 5230, NULL, 'Y', 'Standard', 0),
(5248, 'Reconciliation Leave WithoutPay', '../Payroll/Report_Reconciliation_Detail_LWP.aspx?id=10', '', 'pp', 5230, NULL, 'Y', 'Standard', 0),
(5249, 'Reconciliation Different Day Joining', '../Payroll/Report_Reconciliation_Detail_NJD.aspx?id=10', '', 'pp', 5230, NULL, 'Y', 'Standard', 0),
(5250, 'HeadCount Reconciliatio', '../Payroll/Report_HeadCount_Reconciliation.aspx?id=10', '', 'pp', 5230, NULL, 'Y', 'Standard', 0),
(5251, 'Reconciliation Summary', '../Payroll/Report_Reconciliation_Summary.aspx?id=10', '', 'pp', 5230, NULL, 'Y', 'Standard', 0),
(5252, 'Reconciliation Summary Payroll', '../Payroll/Pay_Reconciliation_Summary_Payroll.aspx?id=10', '', 'pp', 5230, NULL, 'Y', 'Standard', 0),
(5260, 'Accrual Reports', 'AccrualReports.aspx', '', 'N', 5000, NULL, 'Y', 'Standard', 0),
(5270, 'Reports - Loans', 'Reports-Loans.aspx', '', 'N', 5000, NULL, 'Y', 'Standard', 0),
(5271, 'Month Loan Report', '../Payroll/PAY_Loan_Monthly_Entry_Report.aspx', '', 'N', 5270, NULL, 'Y', 'Standard', 0),
(5272, 'Current Loan Status', '../Payroll/PAY_Loan_Current_Status_Report.aspx', '', 'N', 5270, NULL, 'Y', 'Standard', 0),
(5273, 'Month Wise Loan History Report', '../Payroll/PAY_Loan_history_Report.aspx', '', 'N', 5270, NULL, 'Y', 'Standard', 0),
(5274, 'Month Loan Adjustment Report', '../Payroll/PAY_Loan_Monthly_Entry_Report_adjustment.aspx', '', 'N', 5270, NULL, 'Y', 'Standard', 0),
(5276, 'Loan Register', '../Payroll/Pay_Report_Loan_Register.aspx', '', 'N', 5270, '', 'Y', 'Standard', 0),
(5290, 'Reports - Overtime / Late Sitting', 'Reports-Overtime/LateSitting.aspx', '', 'N', 5000, NULL, 'Y', 'Standard', 0),
(5300, 'Setup', 'DirectoryMaintenance.aspx', '', 'N', 5000, NULL, 'Y', 'Standard', 0),
(5301, 'Mode Of Payments', '../Payroll/PAY_DirModeOfPayments_List.aspx', '', 'pp', 5300, NULL, 'Y', 'Standard', 0),
(5302, 'Payroll Catery/Access', '../Payroll/PAY_DirPayrollCateries_List.aspx', '', 'pp', 5300, NULL, 'Y', 'Standard', 0),
(5303, 'Cost Centre', 'PER_DirCostCentres_List.aspx?id=60', '', 'pp', 5300, NULL, 'Y', 'Standard', 0),
(5304, 'JV Codes', 'JVCodes.aspx', '', 'pp', 5300, NULL, 'Y', 'Standard', 0),
(5305, 'Allowances', '../Payroll/PAY_DirAllowances_List.aspx', '', 'pp', 5300, NULL, 'Y', 'Standard', 0),
(5306, 'IncomeTax Columns', 'PAY_DirIncomeTaxColumns_List.aspx?id=60', '', 'pp', 5300, NULL, 'Y', 'Standard', 0),
(5307, 'Deductions', '../Payroll/PAY_DirDeductions_List.aspx', '', 'pp', 5300, NULL, 'Y', 'Standard', 0),
(5308, 'Employee Grade Earning', '../Payroll/EmployeeLinkGradeEarningForm.aspx', '', 'pp', 5300, NULL, 'Y', 'Standard', 0),
(5309, 'Loans', '../Payroll/PAY_DirLoans_List.aspx', '', 'pp', 5300, NULL, 'Y', 'Standard', 0),
(5310, 'Allowances JV Linkage', 'AllowancesJVLinkage.aspx', '', 'pp', 5300, NULL, 'Y', 'Standard', 0),
(5311, 'Deductions JV Linkage', 'DeductionsJVLinkage.aspx', '', 'pp', 5300, NULL, 'Y', 'Standard', 0),
(5312, 'Gradewise Earning Structure', 'GradewiseEarningStructure.aspx', '', 'pp', 5300, NULL, 'Y', 'Standard', 0),
(5313, 'Income Tax Columns', 'IncomeTaxColumns.aspx', '', 'pp', 5300, NULL, 'Y', 'Standard', 0),
(5314, 'Outstanding Recoveries', 'Pay_DirOutstandingRecoveries_List.aspx?id=60', '', 'pp', 5300, NULL, 'Y', 'Standard', 0),
(5315, 'Bank', '../Payroll/PAY_DirBanks_List.aspx', '', 'pp', 5300, NULL, 'Y', 'Standard', 0),
(5316, 'Bank Branches', '../Payroll/PAY_DirBankBranches_List.aspx', '', 'pp', 5300, NULL, 'Y', 'Standard', 0),
(5317, 'Tax Structure', '../Hr_Operations/dir_tax_structure_directory.aspx?id=10', '', 'PP', 5300, NULL, 'Y', 'Standard', 0),
(5318, 'Mobile Allowance', '../hr_operations/link_grade_mobile.aspx?id=10', '', 'zz', 5300, NULL, 'Y', 'Standard', 0),
(5319, 'Fuel Allowance', '../hr_operations/link_grade_fuel.aspx?id=10', '', 'zz', 5300, NULL, 'Y', 'Standard', 0),
(5350, 'Master Maintenance', 'MasterMaintenance.aspx', '', 'N', 5000, NULL, 'Y', 'Standard', 0),
(5351, 'Payroll Master', '../Payroll/PAY_Master_Payroll_List.aspx?id=60', '', 'pp', 5350, NULL, 'Y', 'Standard', 0),
(5352, 'Loans', 'PAY_Loan_List.aspx?id=60', '', 'pp', 5350, NULL, 'Y', 'Standard', 0),
(5353, 'Loan Adjustments', 'PAY_LoanAdjustment.aspx?id=60', '', 'pp', 5350, NULL, 'Y', 'Standard', 0),
(5354, 'Earning Master', '../Payroll/Per_MasterEarnings_List.aspx?id=60', '', 'pp', 5350, NULL, 'Y', 'Standard', 0),
(5380, 'Income Tax Maintenance', 'IncomeTaxMaintenance.aspx', '', 'N', 5000, NULL, 'Y', 'Standard', 0),
(5381, 'Taxation Structures', 'TaxationStructures.aspx', '', 'pp', 5380, NULL, 'Y', 'Standard', 0),
(5382, 'Rebate Structures', 'RebateStructures.aspx', '', 'pp', 5380, NULL, 'Y', 'Standard', 0),
(5383, 'Car Capacities', 'CarCapacities.aspx', '', 'pp', 5380, NULL, 'Y', 'Standard', 0),
(5384, 'Section 149 Allowances', 'Section149Allowances.aspx', '', 'pp', 5380, NULL, 'Y', 'Standard', 0),
(5385, 'Section 149 Earnings', 'Section149Earnings.aspx', '', 'pp', 5380, NULL, 'Y', 'Standard', 0),
(5400, 'Payroll Processing', 'PayrollProcessing.aspx', '', 'N', 5000, NULL, 'Y', 'Standard', 0),
(5401, 'Stop HR Entry', '../Payroll/PAY_Process_StopHrEntry.aspx', '', 'pp', 5400, NULL, 'Y', 'Standard', 0),
(5402, 'Monthly Payroll Calculatio', '../Payroll/Pay_PayrollCalculation.aspx', '', 'pp', 5400, NULL, 'Y', 'Standard', 0),
(5403, 'Undo Monthly Payroll Calculatio', '../Payroll/Pay_undoPayrollcalculation.aspx', '', 'pp', 5400, NULL, 'Y', 'Standard', 0),
(5404, 'Release HR Entry', '../Payroll/PAY_Process_ReleaseHrEntry.aspx', '', 'pp', 5400, NULL, 'Y', 'Standard', 0),
(5405, 'Closing Payroll Month', '../Payroll/PAY_Process_ClosingPayrollMonth.aspx', '', 'pp', 5400, NULL, 'Y', 'Standard', 0),
(5406, 'Manual Monthly Payroll Process', 'Manual_Pay_PayrollCalculation.aspx?id=60', '', 'pp', 5400, NULL, 'Y', 'Standard', 0),
(5407, 'Otherthen Payroll Data Process', 'Manual_Pay_PayrollCalculation_OtherAllowances.aspx', '', 'pp', 5400, NULL, 'Y', 'Standard', 0),
(5408, 'Fuel Adjustments', '../Hr_Operations/dir_fuel_adjustment.aspx?id=10', '', 'PP', 5400, NULL, 'Y', 'Standard', 0),
(5430, 'Payroll JV Interface', 'PayrollJVInterface.aspx', '', 'N', 5000, NULL, 'Y', 'Standard', 0),
(5431, 'Monthly Payroll JV Posting', 'PAY_JV_Posting.aspx?id=60', '', 'pp', 5430, NULL, 'Y', 'Standard', 0),
(5432, 'Advance Salary JV Posting', 'Pay_Advance_Salary_JV_Posting.aspx?id=60', '', 'pp', 5430, NULL, 'Y', 'Standard', 0),
(5433, 'Monthly Commulative JV Report', 'MonthlyCommulativeJVReport.aspx', '', 'pp', 5430, NULL, 'Y', 'Standard', 0),
(5434, 'Manual Salary JV Posting', 'Pay_manual_Salary_JV_Posting.aspx?id=60', '', 'pp', 5430, NULL, 'Y', 'Standard', 0),
(5435, 'Final Settlement JV Posting', 'Pay_final_Salary_JV_Posting.aspx?id=60', '', 'pp', 5430, NULL, 'Y', 'Standard', 0),
(5460, 'Payroll PF Interface', 'PayrollPFInterface.aspx', '', 'N', 5000, NULL, 'Y', 'Standard', 0),
(5461, 'Loan Deletio', '../Payroll/Master_Loan_Deletion.aspx?10', '', 'ZZ', 5500, NULL, 'Y', 'Standard', 0),
(5462, 'Opening Balance', 'PAY_PF_OpeningBalance_List.aspx?id=60', '', 'pp', 5460, NULL, 'Y', 'Standard', 0),
(5463, 'Administrative Tasks', 'PAY_PF_AdministrativeTasks_List.aspx?id=60', '', 'pp', 5460, NULL, 'Y', 'Standard', 0),
(5464, 'Monthly PF Data Loading from Payroll', 'PAY_PF_MonthlyDataLoading.aspx?id=60', '', 'pp', 5460, NULL, 'Y', 'Standard', 0),
(5465, 'Permanent Withdrawal', 'PAY_PF_PermanentWithdrawl_EmployeeList.aspx?id=60', '', 'pp', 5460, NULL, 'Y', 'Standard', 0),
(5466, 'PF Profit Allocation Calculatio', 'PAY_PF_AnnualPFProfitAllocationCalculation.aspx?id=60', '', 'pp', 5460, NULL, 'Y', 'Standard', 0),
(5467, 'Provident Fund Edit Report', 'PAY_PFeditreportform.aspx?id=60', '', 'pp', 5460, NULL, 'Y', 'Standard', 0),
(5468, 'Provident Fund Accrual Detail Report', 'ProvidentFundAccrualDetailReport.aspx', '', 'pp', 5460, NULL, 'Y', 'Standard', 0),
(5469, 'PF Summary Report(Before Rate)', 'PAY_PF_ReportPFSummaryBeforeRate.aspx?id=60', '', 'pp', 5460, NULL, 'Y', 'Standard', 0),
(5470, 'PF Summary Report(After Rate)', 'PAY_PF_ReportPFSummaryAfterRate.aspx?id=60', '', 'pp', 5460, NULL, 'Y', 'Standard', 0),
(5471, 'PF Certificate', 'PAY_PF_ReportPFCertificate.aspx?id=60', '', 'pp', 5460, NULL, 'Y', 'Standard', 0),
(5472, 'PF Working On Individual Bases', 'Pay_PF_Individual_bases_report.aspx?id=60', '', 'pp', 5460, NULL, 'Y', 'Standard', 0),
(5473, 'PF Working Detail MIS', 'Pay_PF_Detail_MIS_report.aspx?id=60', '', 'pp', 5460, NULL, 'Y', 'Standard', 0),
(5474, 'Refund of Loan Adjusted through JVs.', 'RefundofLoanAdjustedthroughJVs..aspx', '', 'pp', 5460, NULL, 'Y', 'Standard', 0),
(5475, 'Out ing Member Schedule Report', 'OutingMemberScheduleReport.aspx', '', 'pp', 5460, NULL, 'Y', 'Standard', 0),
(5476, 'Provident Fund Certificate', 'ProvidentFundCertificate.aspx', '', 'pp', 5460, NULL, 'Y', 'Standard', 0),
(5477, 'PF Deductio', 'PAY_PF_Deduction.aspx?id=60', '', 'pp', 5460, NULL, 'Y', 'Standard', 0),
(5500, 'Transactions Loans', 'TransactionsPostingloan.aspx', '', 'DD', 5000, NULL, 'Y', 'Standard', 0),
(5501, 'Upload Master Salary', '../Payroll/master_earning_upload.aspx', '', 'AA', 5530, NULL, 'Y', 'Standard', 0),
(5502, 'Upload Loan-Deduction File', 'Per_Upload_Loan_File.aspx?id=60', '', 'pp', 5500, NULL, 'Y', 'Standard', 0),
(5503, 'Loa', '../Payroll/PAY_Loan_Entry.aspx?id=60', '', 'pp', 5500, NULL, 'Y', 'Standard', 0),
(5504, 'Loan Adjustment', '../Payroll/PAY_Loan_Adjustment.aspx?id=60', '', 'pp', 5500, NULL, 'Y', 'Standard', 0),
(5505, 'Loan One Time Stop', '../Payroll/PAY_LoanAdjustment_StopFlag.aspx?id=60', '', 'pp', 5500, NULL, 'Y', 'Standard', 0),
(5506, 'Loan Permanent Stop', '../Payroll/PAY_LoanAdjustment_PermanentStopFlag.aspx?id=60', '', 'pp', 5500, NULL, 'Y', 'Standard', 0),
(5507, 'Loan Installment Adjustment', '../Payroll/PAY_LoanAdjustment_Installment.aspx?id=60', '', 'pp', 5500, NULL, 'Y', 'Standard', 0),
(5530, 'Transactions Upload Salary', 'TransactionsPostingSalary.aspx', '', 'EE', 5000, NULL, 'Y', 'Standard', 0),
(5531, 'Upload Salary Projectio', '../Payroll/PAY_TranPayslips_Salary_Projections_Upload.aspx', '', 'pp', 5530, NULL, 'Y', 'Standard', 0),
(5532, 'Cash Award Upload', 'Cash_award_upload.aspx?id=60', '', 'pp', 5530, NULL, 'Y', 'Standard', 0),
(5533, 'Otherthen Payroll Data Upload', 'PAY_TranPayslips_UploadOtherSalary.aspx', '', 'pp', 5530, NULL, 'Y', 'Standard', 0),
(5534, 'Upload Payroll Increment', '../Payroll/history_increments_data.aspx', '', 'AA', 5530, NULL, 'Y', 'Standard', 0),
(5550, 'Processing Manual Salary', 'TransactionsPostingSalarymanual.aspx', '', 'N', 5000, NULL, 'Y', 'Standard', 0),
(5551, 'Down Load Manual Salary', 'Pay_Download_Manual_Salary.aspx?id=60', '', 'pp', 5550, NULL, 'Y', 'Standard', 0),
(5552, 'Upload Manual Salary', '../Payroll/PAY_TranPayslips_UploadmanualSalary.aspx', '', 'pp', 5550, NULL, 'Y', 'Standard', 0),
(5600, 'Reports Loa', 'TransactionsPostingSalarymanualloan.aspx', '', 'EE', 5000, NULL, 'Y', 'Standard', 0),
(5601, 'Loan Report (khi)', '../Payroll/Report_Loan_For_Queeta.aspx', '', 'pp', 5600, NULL, 'Y', 'Standard', 0),
(5620, 'Reports Reconciliations', 'TransactionsSalaryreconciliation.aspx', '', 'GG', 5000, NULL, 'Y', 'Standard', 0);
INSERT INTO `dirmenus` (`MenuCode`, `MenuLabel`, `Menuurl`, `AllowAll`, `SortKey`, `ParentCode`, `CSSClass`, `ActiveFlag`, `MenuType`, `company_code`) VALUES
(5621, 'Payroll Reconciliation Allowances', '../Payroll/Pay_Payroll_Reconcillation.aspx', '', 'pp', 5620, NULL, 'Y', 'Standard', 0),
(5622, 'Payroll Reconciliation Deductions', '../Payroll/PAY_Reconcillation_DeductionForm.aspx', '', 'pp', 5620, NULL, 'Y', 'Standard', 0),
(5623, 'Payroll Reconciliation AccountNo', '../Payroll/Pay_Report_Accoutn_Reconciliation.aspx', '', 'pp', 5620, NULL, 'Y', 'Standard', 0),
(5624, 'Payroll Reconciliation Head Count', '../Payroll/Pay_Report_HeadCount_Reconciliation.aspx', '', 'pp', 5620, NULL, 'Y', 'Standard', 0),
(5625, 'Reconcilation Summary', '../Payroll/PAY_Reconcilation_Summary.aspx?id=60', '', 'pp', 5620, NULL, 'Y', 'Standard', 0),
(5626, 'Reconciliation Detail - Leave With Out Pay', '../Payroll/PAY_Reconcilation_Details_LWOP.aspx?10', '', 'pp', 5620, NULL, 'Y', 'Standard', 0),
(5627, 'Reconciliation Detail - Different Day Joinings', '../Payroll/PAY_Reconcilation_Details_NJD.aspx?10', '', 'pp', 5620, NULL, 'Y', 'Standard', 0),
(5628, 'Reconciliation Grid View', '../Payroll/view_data.aspx', '', 'pp', 5620, NULL, 'Y', 'Standard', 0),
(5700, 'Inquiry', 'Inquiry.aspx', '', 'N', 5000, NULL, 'Y', 'Standard', 0),
(5771, 'Encyclopedia Payslip', 'EncyclopediaPayslip.aspx', '', 'pp', 5700, NULL, 'Y', 'Standard', 0),
(8000, 'Expense', 'Expense.aspx', '', 'MM', 0, NULL, 'Y', 'Standard', 0),
(8100, 'Setups', 'ExpenseSetup.aspx', '', 'CC', 8000, NULL, 'Y', 'Standard', 0),
(8101, 'Upload - Expense Data', '../Expense/Expense_HistoryTranExpenses_UploadExpensesData.aspx', '', 'N', 8100, NULL, 'Y', 'Standard', 0),
(8102, 'Process - Expense Data', '../Expense/Expense_HistoryTranExpenses_ProcessExpensesData.aspx', '', 'N', 8100, NULL, 'Y', 'Standard', 0),
(8103, 'Expense Sub Head', '../Expense/Expense_DirSubHeads_List.aspx', '', 'N', 8100, NULL, 'Y', 'Standard', 0),
(8104, 'Expense Main Head', '../Expense/Expense_DirMainHeads_List.aspx', '', 'N', 8100, '', 'Y', 'Standard', 0),
(8105, 'Expense Slip (Employee Wise)', '../Expense/Expense_Slip.aspx', '', 'N', 8100, '', 'Y', 'Standard', 0),
(8106, 'Expense Slip (Employee Email)', '../Expense/Expense_SlipEmail.aspx', '', 'N', 8100, '', 'Y', 'Standard', 0),
(12000, 'Leave Management', 'HROperations.aspx', '', 'MM', 0, '', 'Y', 'Standard', 0),
(12100, 'Setups', 'LeaveSetup.aspx', '', 'AA', 12000, '', 'Y', 'Standard', 0),
(12101, 'Leave Cateries', '../Hr_Operations/Per_DirLeaveCateries_List.aspx', '', '41', 12100, NULL, 'Y', 'Standard', 0),
(12102, 'Leave Types', '../Hr_Operations/Per_DirLeaveTypes_List.aspx', '', '42', 12100, NULL, 'Y', 'Standard', 0),
(12200, 'Processing', 'LeaveProcessing.aspx', '', 'BB', 12000, '', 'Y', 'Standard', 0),
(12201, 'Manual Leave Posting', '../HR_OPERATIONS/Per_TranLeaves_List.aspx', '', 'AA', 12200, NULL, 'Y', 'Standard', 0),
(12202, 'Leave Year End', '../HR_Operations/LeaveYearEnd.aspx', '', 'AA', 12200, '', 'Y', 'Standard', 0),
(12203, 'Leave Balance Upload', '../HR_Operations/excel_upload_Leave_Balances.aspx', '', 'AA', 12200, '', 'Y', 'Standard', 0),
(12550, 'Reports', '../hr_operations/LeaveReports.aspx', '', 'N', 12000, NULL, 'Y', 'Standard', 0),
(12567, 'Leave Report – Balance', '../Hr_Operations/Per_LeaveReportBalance.aspx?id=10', '', 'pp', 12550, '', 'Y', 'Standard', 0),
(12568, 'Leave Report – Detail', '../Hr_Operations/Per_LeaveReportDetail.aspx?id=10', '', 'pp', 12550, '', 'Y', 'Standard', 0),
(13000, 'Document Management', 'DocumentManagement.aspx', '', 'MM', 0, '', 'Y', 'Standard', 0),
(13001, 'Scanning Employees File', '../Documents/BulkUploadFiles.aspx', '', '01', 13000, '', 'Y', 'Standard', 0),
(13002, 'Admin Inquiry Employees File', '../Documents/InquiryEmployeesFile.aspx', '', '02', 13000, '', 'Y', 'Standard', 0),
(13003, 'Inquiry Employees Wise File', '../Documents/InquiryEmployeesWiseFile.aspx', '', '03', 13000, '', 'Y', 'Standard', 0),
(13004, 'Scan File User Access', '../Documents/ScanFileUserAccess.aspx', '', '04', 13000, '', 'Y', 'Standard', 0),
(99999, 'Logout', '../Lout.aspx', 'Y', 'ZZ', 0, NULL, 'Y', 'Standard', 0);

-- --------------------------------------------------------

--
-- Table structure for table `dir_allowances`
--

CREATE TABLE `dir_allowances` (
  `Allowance_code` int(11) NOT NULL,
  `Allowance_name` varchar(30) NOT NULL,
  `Allowance_abbr` varchar(6) NOT NULL,
  `Basic_flag` varchar(1) DEFAULT NULL,
  `Appointment_flag` varchar(1) DEFAULT NULL,
  `Increment_flag` varchar(1) DEFAULT NULL,
  `EOBI_flag` varchar(1) DEFAULT NULL,
  `SESSI_flag` varchar(1) DEFAULT NULL,
  `Overtime_flag` varchar(1) DEFAULT NULL,
  `COLA_Flag` varchar(1) DEFAULT NULL,
  `Special_Allowance_Flag` varchar(1) NOT NULL,
  `Union_Cola_Flag` varchar(1) NOT NULL,
  `LFA_flag` varchar(1) DEFAULT NULL,
  `LFA_Default_flag` varchar(1) DEFAULT NULL,
  `Fixed_Transaction_Increment_Flag` char(1) DEFAULT NULL,
  `Advance_Flag` char(1) DEFAULT NULL,
  `Tax_Treatment_Type` varchar(1) DEFAULT NULL,
  `Tax_Exempt_Percentage` decimal(5,2) DEFAULT NULL,
  `Section_149_Column_no` decimal(2,0) DEFAULT NULL,
  `Fix_Sheet_Col_no` decimal(2,0) DEFAULT NULL,
  `One_Sheet_Col_no` decimal(2,0) DEFAULT NULL,
  `JV_Code` varchar(50) DEFAULT NULL,
  `JV_Summary_Code` varchar(50) NOT NULL,
  `Income_Tax_Col` decimal(2,0) DEFAULT NULL,
  `Projection_Flag` varchar(1) DEFAULT NULL,
  `Cash_Salary_Flag` varchar(1) DEFAULT NULL,
  `Sort_key` varchar(2) DEFAULT NULL,
  `Income_Tax_Income_Column` int(11) NOT NULL,
  `Income_Tax_Exemption_Column` int(11) NOT NULL,
  `Perquisite_Flag` varchar(1) NOT NULL,
  `Description` varchar(500) DEFAULT NULL,
  `Bonus_Flag` varchar(1) DEFAULT NULL,
  `Show_On_Letter_Flag` varchar(1) DEFAULT NULL,
  `Gross_Salary_Flag` varchar(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `dir_allowances`
--

INSERT INTO `dir_allowances` (`Allowance_code`, `Allowance_name`, `Allowance_abbr`, `Basic_flag`, `Appointment_flag`, `Increment_flag`, `EOBI_flag`, `SESSI_flag`, `Overtime_flag`, `COLA_Flag`, `Special_Allowance_Flag`, `Union_Cola_Flag`, `LFA_flag`, `LFA_Default_flag`, `Fixed_Transaction_Increment_Flag`, `Advance_Flag`, `Tax_Treatment_Type`, `Tax_Exempt_Percentage`, `Section_149_Column_no`, `Fix_Sheet_Col_no`, `One_Sheet_Col_no`, `JV_Code`, `JV_Summary_Code`, `Income_Tax_Col`, `Projection_Flag`, `Cash_Salary_Flag`, `Sort_key`, `Income_Tax_Income_Column`, `Income_Tax_Exemption_Column`, `Perquisite_Flag`, `Description`, `Bonus_Flag`, `Show_On_Letter_Flag`, `Gross_Salary_Flag`) VALUES
(1, 'BASE SALARY', 'P11', 'Y', 'Y', 'Y', 'N', 'N', 'Y', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'T', 0.00, 0, 1, 0, '41210101', '0', 54, 'N', 'Y', 'AA', 54, 0, 'N', 'Basic', 'N', 'Y', 'Y'),
(2, 'ASSIGNMENT ALLOWANCE', 'na', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'T', 0.00, 0, 6, 0, '41210117', '0', 54, 'N', 'Y', 'ZZ', 54, 0, 'N', 'na', 'N', 'Y', 'N'),
(3, 'AWARD ', 'na', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'T', 0.00, 0, 7, 0, '43190144\r\n', '0', 54, 'N', 'Y', 'ZZ', 54, 0, 'N', 'na', 'N', 'Y', 'N'),
(4, 'CAR ALLOWANCE', 'na', 'N', 'Y', 'Y', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'T', 0.00, 0, 2, 0, '41210117', '0', 54, 'N', 'Y', 'ZZ', 54, 0, 'N', 'na', 'N', 'Y', 'Y'),
(5, 'COMPENSATORY ', 'na', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'T', 0.00, 0, 8, 0, '41210118', '0', 54, 'N', 'Y', 'ZZ', 54, 0, 'N', 'na', 'N', 'Y', 'N'),
(6, 'CONVEYANCE ALLOWANCE', 'na', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'T', 0.00, 0, 3, 0, '41210103\r\n', '0', 54, 'N', 'Y', 'ZZ', 54, 0, 'N', 'na', 'N', 'Y', 'N'),
(7, 'ENTERTAINMENT  ALLOWANCE', 'na', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'T', 0.00, 0, 9, 0, '  41710110', '0', 54, 'N', 'Y', 'ZZ', 54, 0, 'N', 'na', 'N', 'Y', 'N'),
(8, 'EQUIPMENT MAINTENANCE ALLOWANC', 'na', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'T', 0.00, 0, 10, 0, '41240126', '0', 54, 'N', 'Y', 'ZZ', 54, 0, 'N', 'na', 'N', 'Y', 'N'),
(9, 'EX-GRATIA', 'na', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'T', 0.00, 0, 11, 0, '41210115', '0', 54, 'N', 'Y', 'ZZ', 54, 0, 'N', 'na', 'N', 'Y', 'N'),
(10, 'FURNISHING LOAN', 'na', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'E', 100.00, 0, 19, 0, '12111301', '0', 54, 'N', 'Y', 'ZZ', 54, 0, 'N', 'na', 'N', 'Y', 'N'),
(11, 'NOT AVAILABLE', 'NA', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'E', 100.00, 0, 12, 0, '0', '0', 8, 'N', 'Y', 'ZZ', 54, 0, 'N', 'na', 'N', 'Y', 'N'),
(12, 'HOUSING ASSISTANCE LOAN 2ND', 'na', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'E', 100.00, 0, 19, 0, '12111301', '0', 54, 'N', 'Y', 'ZZ', 54, 0, 'N', 'na', 'N', 'Y', 'N'),
(13, 'LEAVE ENCASHMENT', 'na', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'T', 0.00, 0, 14, 0, '41210113', '0', 54, 'N', 'Y', 'ZZ', 54, 0, 'N', 'na', 'N', 'Y', 'N'),
(14, 'LONG SERVICE AWARD', 'na', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'T', 0.00, 0, 15, 0, '41240126', '0', 54, 'N', 'Y', 'ZZ', 54, 0, 'N', 'na', 'N', 'Y', 'N'),
(15, 'MARRIAGE GIFT', 'na', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'T', 0.00, 0, 18, 0, '43190199', '0', 54, 'N', 'Y', 'ZZ', 54, 0, 'N', 'na', 'N', 'Y', 'N'),
(16, 'MEAL CHARGES', 'na', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'T', 0.00, 0, 20, 0, '  43190142', '0', 54, 'N', 'Y', 'ZZ', 54, 0, 'N', 'na', 'N', 'Y', 'N'),
(17, 'MISC DEDUCTIONS', 'na', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'T', 0.00, 0, 20, 0, '  43190199', '0', 54, 'N', 'Y', 'ZZ', 54, 0, 'N', 'na', 'N', 'Y', 'N'),
(18, 'MISC PAYMENT (11220501)', 'na', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'T', 0.00, 0, 20, 0, '0', '0', 54, 'N', 'Y', 'ZZ', 54, 0, 'N', 'na', 'N', 'Y', 'N'),
(19, 'MOBILE ALLOWANCE', 'na', 'N', 'Y', 'Y', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'T', 0.00, 0, 5, 0, '43190602', '0', 54, 'N', 'Y', 'ZZ', 54, 0, 'N', 'na', 'N', 'Y', 'Y'),
(20, 'MOBILE PHONE SET', 'na', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'T', 0.00, 0, 20, 0, '43190602', '0', 54, 'N', 'Y', 'ZZ', 54, 0, 'N', 'na', 'N', 'Y', 'N'),
(21, 'PF CONTRIBUTION EMPLOYEE', 'na', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'T', 0.00, 0, 20, 0, '0', '0', 54, 'N', 'Y', 'ZZ', 54, 0, 'N', 'na', 'N', 'Y', 'N'),
(22, 'RELOCATION / PER DAY ALLOWANCE', 'na', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'T', 0.00, 0, 17, 0, '43190133', '0', 54, 'N', 'Y', 'ZZ', 54, 0, 'N', 'na', 'N', 'Y', 'N'),
(23, 'ROCHE ANNUAL BONUS', 'na', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'T', 0.00, 0, 12, 0, '41210500', '0', 54, 'N', 'Y', 'ZZ', 54, 0, 'N', 'na', 'N', 'Y', 'N'),
(24, 'SALES INCENTIVE', 'na', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'T', 0.00, 0, 13, 0, '41210111', '0', 54, 'N', 'Y', 'ZZ', 54, 0, 'N', 'na', 'N', 'Y', 'N'),
(25, 'SPECIAL ALLOWANCE', 'na', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'T', 0.00, 0, 4, 0, '41210117', '0', 54, 'N', 'Y', 'ZZ', 54, 0, 'N', 'na', 'N', 'Y', 'N'),
(26, 'TRANSFER BENEFITS LOAN', 'na', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'E', 100.00, 0, 19, 0, '12111301', '0', 54, 'N', 'Y', 'ZZ', 54, 0, 'N', 'na', 'N', 'Y', 'N'),
(27, 'VEHICLE LOAN', 'na', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'E', 100.00, 0, 19, 0, '12111301', '0', 54, 'N', 'Y', 'ZZ', 54, 0, 'N', 'na', 'N', 'Y', 'N'),
(28, 'Roche Connect Employer', 'na', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'T', 0.00, 0, 20, 0, '0', '0', 54, 'N', 'Y', 'ZZ', 54, 0, 'N', 'na', 'N', 'Y', 'N'),
(29, 'DC Pension EMployer', 'na', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'E', 100.00, 0, 20, 0, '41230106 ', '0', 54, 'N', 'Y', 'ZZ', 54, 0, 'N', 'NA', 'N', 'N', 'N'),
(30, 'PF for Tax', 'na', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'T', 0.00, 0, 20, 0, '0', '0', 54, 'N', 'Y', 'ZZ', 54, 0, 'N', 'Pf for Tax', 'N', 'Y', 'N'),
(31, 'Gratuity', 'Grt', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'T', 0.00, 0, 20, 0, '41230101', '0', 54, 'N', 'Y', 'ZZ', 54, 0, 'N', 'Gratuity', 'N', 'N', 'N'),
(32, 'Pension', 'pen', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'T', 0.00, 0, 20, 0, '0', '0', 54, 'N', 'Y', 'ZZ', 54, 0, 'N', 'Pension', 'N', 'N', 'N'),
(33, 'Bench Mark', 'BM', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'T', 0.00, 0, 0, 0, '0', '0', 0, 'N', 'N', 'ZZ', 0, 0, 'N', 'BM', 'N', 'N', 'N'),
(34, 'Accolade Club Payment', 'ACP', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'T', 0.00, 0, 20, 0, '43190144', ' 43190144', NULL, 'N', 'N', 'zz', 1, 1, 'N', 'Accolade Club Payment', 'N', 'N', 'N'),
(35, 'TELEPHONE - RESIDENCE         ', 'na', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'T', 0.00, 0, 19, 0, '41240115', '0', 54, 'N', 'Y', 'ZZ', 54, 0, 'N', 'na', 'N', 'Y', 'N'),
(36, 'OTHER EMPLOYEE BENEFITS       ', 'na', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'E', 100.00, 0, 19, 0, '43190144', '0', 54, 'N', 'Y', 'ZZ', 54, 0, 'N', 'na', 'N', 'Y', 'N'),
(37, 'LOCAL CONVEYANCE-REIMBURSEMENT', 'na', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'E', 100.00, 0, 19, 0, '41710108', '0', 54, 'N', 'Y', 'ZZ', 54, 0, 'N', 'na', 'N', 'Y', 'N'),
(38, 'FUEL-VEHICLE ASSIGNED EMPLOYEE', 'na', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'E', 100.00, 0, 19, 0, '41710108', '0', 54, 'N', 'Y', 'ZZ', 54, 0, 'N', 'na', 'N', 'Y', 'N'),
(39, 'nternet Charges               ', 'na', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'E', 100.00, 0, 19, 0, '43190702', '0', 54, 'N', 'Y', 'ZZ', 54, 0, 'N', 'na', 'N', 'Y', 'N'),
(40, 'OPD', 'na', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'E', 100.00, 0, 19, 0, '41240103', '0', 54, 'N', 'Y', 'ZZ', 54, 0, 'N', 'na', 'N', 'Y', 'N'),
(41, 'Dental', 'na', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'E', 100.00, 0, 19, 0, '41240103', '0', 54, 'N', 'Y', 'ZZ', 54, 0, 'N', 'na', 'N', 'Y', 'N'),
(42, 'Maternity', 'na', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'E', 100.00, 0, 19, 0, '41240103', '0', 54, 'N', 'Y', 'ZZ', 54, 0, 'N', 'na', 'N', 'Y', 'N'),
(43, 'Physiotherapy', 'na', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'E', 100.00, 0, 19, 0, '41240103', '0', 54, 'N', 'Y', 'ZZ', 54, 0, 'N', 'na', 'N', 'Y', 'N'),
(44, 'Roche Connect Payment', 'RCP', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'E', 100.00, 0, 12, 0, '41240301', '0', NULL, 'N', 'N', 'ZZ', 0, 0, 'N', 'Roche Connect Payment', 'N', 'N', 'N');

-- --------------------------------------------------------

--
-- Table structure for table `dir_areas_resignation_process`
--

CREATE TABLE `dir_areas_resignation_process` (
  `area_code` int(11) DEFAULT NULL,
  `areahead_code` int(11) DEFAULT NULL,
  `Old_areahead_code` int(11) DEFAULT NULL,
  `Process_Flag` varchar(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dir_banks`
--

CREATE TABLE `dir_banks` (
  `Bank_code` int(11) NOT NULL,
  `Bank_name` varchar(50) NOT NULL,
  `Bank_abbr` varchar(6) NOT NULL,
  `Sort_key` varchar(2) DEFAULT NULL,
  `Bank_Address1` varchar(100) DEFAULT NULL,
  `Bank_Address2` varchar(100) DEFAULT NULL,
  `Bank_Address3` varchar(100) DEFAULT NULL,
  `Current_Account` varchar(100) DEFAULT NULL,
  `IMDCode` varchar(20) DEFAULT NULL,
  `Swift` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dir_bank_branches`
--

CREATE TABLE `dir_bank_branches` (
  `Branch_code` int(11) NOT NULL,
  `Branch_name` varchar(100) NOT NULL,
  `Branch_abbr` varchar(6) NOT NULL,
  `Branch_address_line1` varchar(30) NOT NULL,
  `Branch_address_line2` varchar(30) DEFAULT NULL,
  `Contact` varchar(20) DEFAULT NULL,
  `Bank_Branch_Code` varchar(15) DEFAULT NULL,
  `Bank_Code` int(11) NOT NULL,
  `City_Code` int(11) NOT NULL,
  `Sort_key` varchar(2) DEFAULT NULL,
  `countrycode` int(11) DEFAULT NULL,
  `zonecode` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dir_budget_designations`
--

CREATE TABLE `dir_budget_designations` (
  `code` int(11) DEFAULT NULL,
  `name1` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dir_busineess`
--

CREATE TABLE `dir_busineess` (
  `Business_Code` int(11) NOT NULL,
  `Business_Name` varchar(100) DEFAULT NULL,
  `Sort_Key` varchar(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dir_busineess_sectors`
--

CREATE TABLE `dir_busineess_sectors` (
  `Business_Sector_Code` int(11) NOT NULL,
  `Business_Sector_Name` varchar(100) DEFAULT NULL,
  `Sort_Key` varchar(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dir_car_capacities`
--

CREATE TABLE `dir_car_capacities` (
  `Capacity_code` int(11) NOT NULL,
  `Capacity_name` varchar(30) NOT NULL,
  `Capacity_abbr` varchar(6) NOT NULL,
  `Usage_Type` char(1) DEFAULT NULL,
  `Taxable_Amount` decimal(9,0) DEFAULT NULL,
  `Sort_key` varchar(2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dir_cities`
--

CREATE TABLE `dir_cities` (
  `City_code` int(11) NOT NULL,
  `City_name` varchar(30) NOT NULL,
  `City_abbr` varchar(6) NOT NULL,
  `Region_Code` int(11) DEFAULT NULL,
  `Sort_key` varchar(2) NOT NULL,
  `Province_Code` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dir_companies`
--

CREATE TABLE `dir_companies` (
  `Company_Code` int(11) NOT NULL,
  `Company_Name` varchar(100) DEFAULT NULL,
  `Company_Abbr` varchar(3) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dir_corecompetencies`
--

CREATE TABLE `dir_corecompetencies` (
  `Competency_code` int(11) NOT NULL,
  `Competency_Name` varchar(80) NOT NULL,
  `Sort_key` varchar(2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dir_corecompetencies_old`
--

CREATE TABLE `dir_corecompetencies_old` (
  `Core_Code` int(11) NOT NULL,
  `Core_Name` varchar(30) NOT NULL,
  `Mandatory_Flag` varchar(1) NOT NULL DEFAULT 'N',
  `Experience_Flag` varchar(1) NOT NULL DEFAULT 'N',
  `Description` longtext DEFAULT NULL,
  `Sort_Key` varchar(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dir_cost_centres`
--

CREATE TABLE `dir_cost_centres` (
  `Cost_Centre_code` int(11) NOT NULL,
  `Cost_Centre_name` varchar(100) DEFAULT NULL,
  `Cost_Centre_abbr` varchar(10) DEFAULT NULL,
  `Train_Cost_Budget` decimal(9,0) DEFAULT NULL,
  `Train_Cost_Actual` decimal(9,0) DEFAULT NULL,
  `JV_Code1` varchar(1) DEFAULT NULL,
  `JV_Code` varchar(20) DEFAULT NULL,
  `emp_category_1` int(11) NOT NULL,
  `emp_category_2` int(11) NOT NULL,
  `emp_category_3` int(11) NOT NULL,
  `Functional_Category_code` int(11) NOT NULL,
  `JVCode` varchar(10) DEFAULT NULL,
  `Temporary_JV_Code` varchar(6) NOT NULL,
  `Major_Code_Mgmt` varchar(10) NOT NULL,
  `Major_Code_Union` varchar(10) NOT NULL,
  `Sort_key` varchar(2) DEFAULT NULL,
  `total_cost_budget` decimal(9,0) DEFAULT NULL,
  `Azad_Kashmir_Tax_Flag` varchar(1) DEFAULT NULL,
  `Pay_Grade_Areas_code` int(11) DEFAULT NULL,
  `Business_Sector_Code` int(11) DEFAULT NULL,
  `org_unit_code` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `dir_cost_centres`
--

INSERT INTO `dir_cost_centres` (`Cost_Centre_code`, `Cost_Centre_name`, `Cost_Centre_abbr`, `Train_Cost_Budget`, `Train_Cost_Actual`, `JV_Code1`, `JV_Code`, `emp_category_1`, `emp_category_2`, `emp_category_3`, `Functional_Category_code`, `JVCode`, `Temporary_JV_Code`, `Major_Code_Mgmt`, `Major_Code_Union`, `Sort_key`, `total_cost_budget`, `Azad_Kashmir_Tax_Flag`, `Pay_Grade_Areas_code`, `Business_Sector_Code`, `org_unit_code`) VALUES
(1, '112400111  Human Resources - Head Office', 'na', 0, 0, 'n', '112400111', 0, 0, 0, 0, '0', '0', '0', '0', 'ZZ', 0, 'N', 0, 0, 0),
(2, '112530200  User Services - Shared', 'na', 0, 0, 'n', '112530200', 0, 0, 0, 0, '0', '0', '0', '0', 'ZZ', 0, 'N', 0, 0, 0),
(3, '112600120  GENERAL SERVICES-HEAD OFFICE', 'na', 0, 0, 'n', '112600120', 0, 0, 0, 0, '0', '0', '0', '0', 'ZZ', 0, 'N', 0, 0, 0),
(4, '114100108  FF-ONCOLOGY -1', 'na', 0, 0, 'n', '114100108', 0, 0, 0, 0, '0', '0', '0', '0', 'ZZ', 0, 'N', 0, 0, 0),
(5, '114100109  FF-ONCOLOGY - 2', 'na', 0, 0, 'n', '114100109', 0, 0, 0, 0, '0', '0', '0', '0', 'ZZ', 0, 'N', 0, 0, 0),
(7, '114100116 - CIT FF', 'na', 0, 0, 'n', '114100116', 0, 0, 0, 0, '0', '0', '0', '0', 'ZZ', 0, 'N', 0, 0, 0),
(8, '114100117 - Neurosciences FF', 'na', 0, 0, 'n', '114100117', 0, 0, 0, 0, '0', '0', '0', '0', 'ZZ', 0, 'N', 0, 0, 0),
(9, '114100118 - FMI Field Force', 'na', 0, 0, 'n', '114100118', 0, 0, 0, 0, '0', '0', '0', '0', 'ZZ', 0, 'N', 0, 0, 0),
(10, '114100199  Pharma Speciality', 'na', 0, 0, 'n', '114100199', 0, 0, 0, 0, '0', '0', '0', '0', 'ZZ', 0, 'N', 0, 0, 0),
(11, 'Marketing Support Function', 'na', 0, 0, 'n', '114102009', 0, 0, 0, 0, '0', '0', '0', '0', 'ZZ', 0, 'N', 0, 0, 0),
(12, '114102011  MM & I  - Speciality', 'na', 0, 0, 'n', '114102011', 0, 0, 0, 0, '0', '0', '0', '0', 'ZZ', 0, 'N', 0, 0, 0),
(13, '114102998  Access', 'na', 0, 0, 'n', '114102998', 0, 0, 0, 0, '0', '0', '0', '0', 'ZZ', 0, 'N', 0, 0, 0),
(14, '114102999  GM  - GENERAL MANAGEMENT', 'na', 0, 0, 'n', '114102999', 0, 0, 0, 0, '0', '0', '0', '0', 'ZZ', 0, 'N', 0, 0, 0),
(15, '114500240  Material Management', 'na', 0, 0, 'n', '114500240', 0, 0, 0, 0, '0', '0', '0', '0', 'ZZ', 0, 'N', 0, 0, 0),
(16, '114500300  Pharma Distribution', 'na', 0, 0, 'n', '114500300', 0, 0, 0, 0, '0', '0', '0', '0', 'ZZ', 0, 'N', 0, 0, 0),
(17, '115717101  MM & I MEDICAL AFFAIRS LOCAL', 'na', 0, 0, 'n', '115717101', 0, 0, 0, 0, '0', '0', '0', '0', 'ZZ', 0, 'N', 0, 0, 0),
(19, '115717106  Regulatory Affairs', 'na', 0, 0, 'n', '115717106', 0, 0, 0, 0, '0', '0', '0', '0', 'ZZ', 0, 'N', 0, 0, 0),
(21, 'Local Finance', 'na', 0, 0, 'n', '116400410', 0, 0, 0, 0, '0', '0', '0', '0', 'ZZ', 0, 'N', 0, 0, 0),
(22, '116400420  ACCOUNTING', 'na', 0, 0, 'n', '116400420', 0, 0, 0, 0, '0', '0', '0', '0', 'ZZ', 0, 'N', 0, 0, 0),
(23, '116400430  TREASURY', 'na', 0, 0, 'n', '116400430', 0, 0, 0, 0, '0', '0', '0', '0', 'ZZ', 0, 'N', 0, 0, 0),
(24, '6352410102  PER-KHI DIA OFFICE', 'na', 0, 0, 'n', '6352410102', 0, 0, 0, 0, '0', '0', '0', '0', 'ZZ', 0, 'N', 0, 0, 0),
(25, '6352550104  IT-DIA SHRD.H.O', 'na', 0, 0, 'n', '6352550104', 0, 0, 0, 0, '0', '0', '0', '0', 'ZZ', 0, 'N', 0, 0, 0),
(26, '6352600100  GS-Indirect Purchase', 'na', 0, 0, 'n', '6352600100', 0, 0, 0, 0, '0', '0', '0', '0', 'ZZ', 0, 'N', 0, 0, 0),
(27, '6352600102  General Services-DIA Head Office', 'na', 0, 0, 'n', '6352600102', 0, 0, 0, 0, '0', '0', '0', '0', 'ZZ', 0, 'N', 0, 0, 0),
(28, '6353510100  MATPROC & LOGISTICS DIA', 'na', 0, 0, 'n', '6353510100', 0, 0, 0, 0, '0', '0', '0', '0', 'ZZ', 0, 'N', 0, 0, 0),
(29, '6353800101  T.E.SERV.DIA-ISL.', 'na', 0, 0, 'n', '6353800101', 0, 0, 0, 0, '0', '0', '0', '0', 'ZZ', 0, 'N', 0, 0, 0),
(30, '6353800102  T.E.SERV.DIA-KARACHI', 'na', 0, 0, 'n', '6353800102', 0, 0, 0, 0, '0', '0', '0', '0', 'ZZ', 0, 'N', 0, 0, 0),
(31, '6353800103  T.E.SERV.DIA-LAHORE', 'na', 0, 0, 'n', '6353800103', 0, 0, 0, 0, '0', '0', '0', '0', 'ZZ', 0, 'N', 0, 0, 0),
(32, '6353800200  Technical Services-Shared', 'na', 0, 0, 'n', '6353800200', 0, 0, 0, 0, '0', '0', '0', '0', 'ZZ', 0, 'N', 0, 0, 0),
(33, '6353800300  Technical Services-OE', 'na', 0, 0, 'n', '6353800300', 0, 0, 0, 0, '0', '0', '0', '0', 'ZZ', 0, 'N', 0, 0, 0),
(34, '6353800400  Technical Services-Agility', 'na', 0, 0, 'n', '6353800400', 0, 0, 0, 0, '0', '0', '0', '0', 'ZZ', 0, 'N', 0, 0, 0),
(35, '6354110401  Sales Dia- MD - Islamabad', 'na', 0, 0, 'n', '6354110401', 0, 0, 0, 0, '0', '0', '0', '0', 'ZZ', 0, 'N', 0, 0, 0),
(36, '6354110800  SALES - Key Accounts & Commercial', 'na', 0, 0, 'n', '6354110800', 0, 0, 0, 0, '0', '0', '0', '0', 'ZZ', 0, 'N', 0, 0, 0),
(37, '6354110900  SALES - EM & Afghanistan', 'na', 0, 0, 'n', '6354110900', 0, 0, 0, 0, '0', '0', '0', '0', 'ZZ', 0, 'N', 0, 0, 0),
(38, '6354120104  M.SUP.DIA -SHRD.H.O', 'na', 0, 0, 'n', '6354120104', 0, 0, 0, 0, '0', '0', '0', '0', 'ZZ', 0, 'N', 0, 0, 0),
(39, '6354120300 MARKET SUPPORT CD', 'na', 0, 0, 'n', '6354120300', 0, 0, 0, 0, '0', '0', '0', '0', 'ZZ', 0, 'N', 0, 0, 0),
(40, '6354120301  Marketing', 'na', 0, 0, 'n', '6354120301', 0, 0, 0, 0, '0', '0', '0', '0', 'ZZ', 0, 'N', 0, 0, 0),
(41, '6354120400  MARKET SUPPORT-MD', 'na', 0, 0, 'n', '6354120400', 0, 0, 0, 0, '0', '0', '0', '0', 'ZZ', 0, 'N', 0, 0, 0),
(42, '6354120800  Medical & Scientific Affairs DIA', 'na', 0, 0, 'n', '6354120800', 0, 0, 0, 0, '0', '0', '0', '0', 'ZZ', 0, 'N', 0, 0, 0),
(43, '6354120900  QUALITYREG.& SAFETY AFFRS-DIA', 'na', 0, 0, 'n', '6354120900', 0, 0, 0, 0, '0', '0', '0', '0', 'ZZ', 0, 'N', 0, 0, 0),
(44, '6354500101  Distribution - Islamabad', 'na', 0, 0, 'n', '6354500101', 0, 0, 0, 0, '0', '0', '0', '0', 'ZZ', 0, 'N', 0, 0, 0),
(45, '6354500102  Dia Distribution - Karachi', 'na', 0, 0, 'n', '6354500102', 0, 0, 0, 0, '0', '0', '0', '0', 'ZZ', 0, 'N', 0, 0, 0),
(46, '6354500103  Distribution - Lahore', 'na', 0, 0, 'n', '6354500103', 0, 0, 0, 0, '0', '0', '0', '0', 'ZZ', 0, 'N', 0, 0, 0),
(47, '6354500104  Diagnostic Distribution', 'na', 0, 0, 'n', '6354500104', 0, 0, 0, 0, '0', '0', '0', '0', 'ZZ', 0, 'N', 0, 0, 0),
(48, '6356400100  Fin Acct & Controlling - DIA', 'na', 0, 0, 'n', '6356400100', 0, 0, 0, 0, '0', '0', '0', '0', 'ZZ', 0, 'N', 0, 0, 0),
(49, '6364110201  SALES - DC ISLAMABAD', 'na', 0, 0, 'n', '6364110201', 0, 0, 0, 0, '0', '0', '0', '0', 'ZZ', 0, 'N', 0, 0, 0),
(50, '6364110202  SALES - DC KARACHI', 'na', 0, 0, 'n', '6364110202', 0, 0, 0, 0, '0', '0', '0', '0', 'ZZ', 0, 'N', 0, 0, 0),
(51, '6364110203  SALES - DC LAHORE', 'na', 0, 0, 'n', '6364110203', 0, 0, 0, 0, '0', '0', '0', '0', 'ZZ', 0, 'N', 0, 0, 0),
(52, '6364110204  SALES - DC SHARE.H.O', 'na', 0, 0, 'n', '6364110204', 0, 0, 0, 0, '0', '0', '0', '0', 'ZZ', 0, 'N', 0, 0, 0),
(53, '6364120200  MARKET SUPPORT-DC', 'na', 0, 0, 'n', '6364120200', 0, 0, 0, 0, '0', '0', '0', '0', 'ZZ', 0, 'N', 0, 0, 0),
(54, '6364120800 MEDICAL SUPPORT-DC', '6364120800', 0, 0, 'N', '6364120800', 0, 0, 0, 0, '6364120800', '0', '0', '0', 'ZZ', 0, 'N', 0, 0, 0),
(55, '114102010 MM&I - ONCOLOGY - 2', '114102010', 0, 0, 'N', '114102010', 0, 0, 0, 0, '114102010', '0', '0', '0', 'ZZ', 0, 'N', 0, 0, 0),
(1055, '114102013 MM&I - Ocrevus', '114102013', 0, 0, 'N', '114102013', 0, 0, 0, 0, '114102013', '0', '0', '0', 'ZZ', 0, 'N', 0, 0, 0),
(1056, 'Business Support', '114100', 0, 0, 'N', '114100100', 0, 0, 0, 0, '114100100', '0', '0', '0', 'ZA', 0, 'N', 0, 0, 0),
(1057, 'Capability, Transformation & D', '114102', 0, 0, 'N', '114102000', 0, 0, 0, 0, '114102000', '0', '0', '0', 'ZA', 0, 'N', 0, 0, 0),
(1058, 'Market Access', '6354120700', 0, 0, 'N', '6354120700', 0, 0, 0, 0, '6354120700', '0', '0', '0', 'ZZ', 0, 'N', 0, 0, 0),
(1059, 'Compliance', '6356100102', 0, 0, 'N', '6356100102', 0, 0, 0, 0, '6356100102', '0', '0', '0', 'ZZ', 0, 'N', 0, 0, 0),
(1060, 'PJP - Breast & Hematology', '114100200', 0, 0, 'N', '114100200', 0, 0, 0, 0, '114100200', '0', '0', '0', 'ZZ', 0, 'N', 0, 0, 0),
(1061, 'PJP - CIT & Pan Tumor', '114100201', 0, 0, 'N', '114100201', 0, 0, 0, 0, '114100201', '0', '0', '0', 'ZZ', 0, 'N', 0, 0, 0),
(1062, 'PJP - I2O & Neuro', '114100202', 0, 0, 'N', '114100202', 0, 0, 0, 0, '114100202', '0', '0', '0', 'ZZ', 0, 'N', 0, 0, 0),
(1063, 'P&C', '116100100', 0, 0, 'N', '116100100', 0, 0, 0, 0, '116100100', '0', '0', '0', 'ZZ', 0, 'N', 0, 0, 0),
(1064, 'Global DC Finance', '6366400301', 0, 0, 'N', '6366400301', 0, 0, 0, 0, '6366400301', '0', '0', '0', 'ZZ', 0, 'N', 0, 0, 0),
(1065, 'Global DC Distribution', '6364500301', 0, 0, 'N', '6364500301', 0, 0, 0, 0, '6364500301', '0', '0', '0', 'ZZ', 0, 'N', 0, 0, 0),
(1066, '6364120331 DC Global Marketing', '6364120331', 0, 0, 'N', '6364120331', 0, 0, 0, 0, '6364120331', '0', '0', '0', 'ZZ', 0, 'N', 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `dir_countries`
--

CREATE TABLE `dir_countries` (
  `Country_Code` int(11) NOT NULL,
  `Country_Name` varchar(100) DEFAULT NULL,
  `Country_Abbr` varchar(10) DEFAULT NULL,
  `SortKey` varchar(2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dir_courses`
--

CREATE TABLE `dir_courses` (
  `Course_code` int(11) NOT NULL,
  `Course_name` varchar(50) NOT NULL,
  `Course_abbr` varchar(6) NOT NULL,
  `Course_Catg_code` int(11) NOT NULL,
  `Sort_key` varchar(2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dir_course_categaries`
--

CREATE TABLE `dir_course_categaries` (
  `Course_Catg_code` int(11) NOT NULL,
  `Course_Catg_name` varchar(30) NOT NULL,
  `Course_Catg_abbr` varchar(6) NOT NULL,
  `Sort_key` varchar(2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dir_deductions`
--

CREATE TABLE `dir_deductions` (
  `Deduction_code` int(11) NOT NULL,
  `Deduction_name` varchar(30) DEFAULT NULL,
  `Deduction_abbr` varchar(6) NOT NULL,
  `Fix_Sheet_Col_no` decimal(2,0) DEFAULT NULL,
  `One_Sheet_Col_no` decimal(2,0) DEFAULT NULL,
  `JV_Code` varchar(50) DEFAULT NULL,
  `JV_Summary_Code` varchar(10) NOT NULL,
  `Sort_key` varchar(2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dir_departments`
--

CREATE TABLE `dir_departments` (
  `Dept_code` int(11) NOT NULL,
  `Dept_name` varchar(100) DEFAULT NULL,
  `Dept_abbr` varchar(6) NOT NULL,
  `Div_code` int(11) NOT NULL,
  `Dept_Head` int(11) NOT NULL,
  `Permanent_Budget` int(11) NOT NULL,
  `Temporary_Budget` int(11) NOT NULL,
  `Sort_key` varchar(2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `dir_departments`
--

INSERT INTO `dir_departments` (`Dept_code`, `Dept_name`, `Dept_abbr`, `Div_code`, `Dept_Head`, `Permanent_Budget`, `Temporary_Budget`, `Sort_key`) VALUES
(1, 'NA', 'NA', 0, 0, 0, 0, 'ZZ'),
(10, 'Access', 'NA', 10, 0, 0, 0, 'ZZ'),
(11, 'Administration', 'NA', 11, 0, 0, 0, 'ZZ'),
(12, 'ARKET SUPPORT CD', 'NA', 12, 0, 0, 0, 'ZZ'),
(13, 'BU Onco - I', 'NA', 13, 0, 0, 0, 'ZZ'),
(14, 'BU Onco - II', 'NA', 14, 0, 0, 0, 'ZZ'),
(15, 'CIT Squad', 'NA', 15, 0, 0, 0, 'ZZ'),
(16, 'Communications', 'NA', 16, 0, 0, 0, 'ZZ'),
(17, 'Dia Distribution - Karachi', 'NA', 17, 0, 0, 0, 'ZZ'),
(18, 'Diagnostic Distribution', 'NA', 18, 0, 0, 0, 'ZZ'),
(19, 'Distribution - Islamabad', 'NA', 19, 0, 0, 0, 'ZZ'),
(20, 'Distribution - Karachi', 'NA', 20, 0, 0, 0, 'ZZ'),
(21, 'Distribution - Lahore', 'NA', 21, 0, 0, 0, 'ZZ'),
(22, 'Fin Acct & Controlling - DIA', 'NA', 22, 0, 0, 0, 'ZZ'),
(23, 'Finance', 'NA', 23, 0, 0, 0, 'ZZ'),
(24, 'FMI', 'NA', 24, 0, 0, 0, 'ZZ'),
(25, 'General Services-DIA Head Office', 'NA', 25, 0, 0, 0, 'ZZ'),
(26, 'GS-Indirect Purchase', 'NA', 26, 0, 0, 0, 'ZZ'),
(27, 'P&C', 'NA', 27, 0, 0, 0, 'ZZ'),
(28, 'IT', 'NA', 28, 0, 0, 0, 'ZZ'),
(29, 'IT-DIA SHRD.H.O', 'NA', 29, 0, 0, 0, 'ZZ'),
(30, 'M.SUP.DIA -SHRD.H.O', 'NA', 30, 0, 0, 0, 'ZZ'),
(31, 'MARKET SUPPORT-DC', 'NA', 31, 0, 0, 0, 'ZZ'),
(32, 'MARKET SUPPORT-MD', 'NA', 32, 0, 0, 0, 'ZZ'),
(33, 'Marketing', 'NA', 33, 0, 0, 0, 'ZZ'),
(34, 'Marketing Support Function', 'NA', 34, 0, 0, 0, 'ZZ'),
(35, 'MATPROC & LOGISTICS DIA', 'NA', 35, 0, 0, 0, 'ZZ'),
(36, 'MD', 'NA', 36, 0, 0, 0, 'ZZ'),
(37, 'Medical & Scientific Affairs DIA', 'NA', 37, 0, 0, 0, 'ZZ'),
(38, 'Medical Affairs', 'NA', 38, 0, 0, 0, 'ZZ'),
(39, 'Neurosciences Squad', 'NA', 39, 0, 0, 0, 'ZZ'),
(40, 'PER-KHI DIA OFFICE', 'NA', 40, 0, 0, 0, 'ZZ'),
(41, 'QUALITYREG.& SAFETY AFFRS-DIA', 'NA', 41, 0, 0, 0, 'ZZ'),
(42, 'Regulatory Affairs', 'NA', 42, 0, 0, 0, 'ZZ'),
(43, 'Rheumatology & Anemia', 'NA', 43, 0, 0, 0, 'ZZ'),
(44, 'SALES - DC ISLAMABAD', 'NA', 44, 0, 0, 0, 'ZZ'),
(45, 'SALES - DC KARACHI', 'NA', 45, 0, 0, 0, 'ZZ'),
(46, 'SALES - DC LAHORE', 'NA', 46, 0, 0, 0, 'ZZ'),
(47, 'SALES - DC SHARE.H.O', 'NA', 47, 0, 0, 0, 'ZZ'),
(48, 'SALES - EM & Afghanistan', 'NA', 48, 0, 0, 0, 'ZZ'),
(49, 'SALES - Key Accounts & Commercial', 'NA', 49, 0, 0, 0, 'ZZ'),
(50, 'Sales Dia- MD - Islamabad', 'NA', 50, 0, 0, 0, 'ZZ'),
(51, 'T.E.SERV.DIA-ISL.', 'NA', 51, 0, 0, 0, 'ZZ'),
(52, 'T.E.SERV.DIA-KARACHI', 'NA', 52, 0, 0, 0, 'ZZ'),
(53, 'T.E.SERV.DIA-LAHORE', 'NA', 53, 0, 0, 0, 'ZZ'),
(54, 'Technical Services-Agility', 'NA', 54, 0, 0, 0, 'ZZ'),
(55, 'Technical Services-OE', 'NA', 55, 0, 0, 0, 'ZZ'),
(56, 'Technical Services-Shared', 'NA', 56, 0, 0, 0, 'ZZ'),
(57, 'Compliance', 'CDIA', 57, 1205, 0, 0, 'ZZ'),
(58, 'Specialty', 'Specia', 58, 1192, 0, 0, 'ZA'),
(59, 'Capability, Transformation & D', 'CT&D', 59, 1172, 0, 0, 'ZA'),
(60, 'Business Support', 'BS', 23, 1610, 0, 0, 'ZZ');

-- --------------------------------------------------------

--
-- Table structure for table `dir_designations`
--

CREATE TABLE `dir_designations` (
  `Desig_code` int(11) NOT NULL,
  `Desig_name` varchar(100) NOT NULL,
  `Desig_abbr` varchar(6) NOT NULL,
  `Dept_code` int(11) NOT NULL,
  `Job_Evaluation_Flag` varchar(1) DEFAULT NULL,
  `Sort_key` varchar(2) DEFAULT NULL,
  `SatAllowance` decimal(12,0) DEFAULT NULL,
  `EveAllowance` decimal(12,0) DEFAULT NULL,
  `JD_Desig_Code` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `dir_designations`
--

INSERT INTO `dir_designations` (`Desig_code`, `Desig_name`, `Desig_abbr`, `Dept_code`, `Job_Evaluation_Flag`, `Sort_key`, `SatAllowance`, `EveAllowance`, `JD_Desig_Code`) VALUES
(1, 'N/A', 'N/A', 0, 'N', 'ZZ', 0, 0, 0),
(44, 'Access Director', 'NA', 0, 'N', 'ZZ', 0, 0, 0),
(45, 'Access Manager - North', 'NA', 0, 'N', 'ZZ', 0, 0, 0),
(46, 'Access Operations Lead', 'NA', 0, 'N', 'ZZ', 0, 0, 0),
(47, 'Assistant District Sales Manager', 'NA', 0, 'N', 'ZZ', 0, 0, 0),
(48, 'Assistant Facility Manager', 'NA', 0, 'N', 'ZZ', 0, 0, 0),
(49, 'Assistant Manager Accounts', 'NA', 0, 'N', 'ZZ', 0, 0, 0),
(50, 'Assistant Manager Administration', 'NA', 0, 'N', 'ZZ', 0, 0, 0),
(51, 'Assistant Manager Customer Relations', 'NA', 0, 'N', 'ZZ', 0, 0, 0),
(52, 'Assistant Manager Distribution', 'NA', 0, 'N', 'ZZ', 0, 0, 0),
(53, 'Assistant Manager Finance & Controlling', 'NA', 0, 'N', 'ZZ', 0, 0, 0),
(54, 'Assistant Manager Logistics', 'NA', 0, 'N', 'ZZ', 0, 0, 0),
(55, 'Assistant Manager Regulatory', 'NA', 0, 'N', 'ZZ', 0, 0, 0),
(56, 'Assistant Manager Regulatory Affairs', 'NA', 0, 'N', 'ZZ', 0, 0, 0),
(57, 'Assistant Product Manager', 'NA', 0, 'N', 'ZZ', 0, 0, 0),
(58, 'Assistant Sales Administration Manager', 'NA', 0, 'N', 'ZZ', 0, 0, 0),
(59, 'Asst.Manager Procurement', 'NA', 0, 'N', 'ZZ', 0, 0, 0),
(60, 'Business Unit Director - MS', 'NA', 0, 'N', 'ZZ', 0, 0, 0),
(61, 'Category Marketing Manager', 'NA', 0, 'N', 'ZZ', 0, 0, 0),
(62, 'Chief Transformation Officer', 'NA', 0, 'N', 'ZZ', 0, 0, 0),
(63, 'Country Manager - Pakistan & Afghanistan', 'NA', 0, 'N', 'ZZ', 0, 0, 0),
(64, 'Country Manager Pakistan & Afghanistan - Diagnostics', 'NA', 0, 'N', 'ZZ', 0, 0, 0),
(65, 'Country Study Manager', 'NA', 0, 'N', 'ZZ', 0, 0, 0),
(66, 'Director Sales', 'NA', 0, 'N', 'ZZ', 0, 0, 0),
(67, 'Distribution Manager', 'NA', 0, 'N', 'ZZ', 0, 0, 0),
(68, 'Divisional Director Finance', 'NA', 0, 'N', 'ZZ', 0, 0, 0),
(69, 'E2e Manager', 'NA', 0, 'N', 'ZZ', 0, 0, 0),
(70, 'Executive Assistant', 'NA', 0, 'N', 'ZZ', 0, 0, 0),
(71, 'Executive Manager Finance & Controlling', 'NA', 0, 'N', 'ZZ', 0, 0, 0),
(72, 'Executive Manager Materials & Logistics', 'NA', 0, 'N', 'ZZ', 0, 0, 0),
(73, 'Facilities and Procurement Manager', 'NA', 0, 'N', 'ZZ', 0, 0, 0),
(74, 'Field Manager', 'NA', 0, 'N', 'ZZ', 0, 0, 0),
(75, 'Field Manager - CPS Central', 'NA', 0, 'N', 'ZZ', 0, 0, 0),
(76, 'Field Manager - CPS South', 'NA', 0, 'N', 'ZZ', 0, 0, 0),
(77, 'Field Manager Application', 'NA', 0, 'N', 'ZZ', 0, 0, 0),
(78, 'Field Manager CPS Central', 'NA', 0, 'N', 'ZZ', 0, 0, 0),
(79, 'Field Manager Services', 'NA', 0, 'N', 'ZZ', 0, 0, 0),
(80, 'Finance Director', 'NA', 0, 'N', 'ZZ', 0, 0, 0),
(81, 'FMI Lead', 'NA', 0, 'N', 'ZZ', 0, 0, 0),
(82, 'Government Affairs & Policy Head', 'NA', 0, 'N', 'ZZ', 0, 0, 0),
(83, 'Head of Accounts ', 'NA', 0, 'N', 'ZZ', 0, 0, 0),
(84, 'Head of Diabetes Care', 'NA', 0, 'N', 'ZZ', 0, 0, 0),
(85, 'Head of Distribution', 'NA', 0, 'N', 'ZZ', 0, 0, 0),
(86, 'Head of HR', 'NA', 0, 'N', 'ZZ', 0, 0, 0),
(87, 'Head of Marketing', 'NA', 0, 'N', 'ZZ', 0, 0, 0),
(88, 'Head of Marketing - Oncology', 'NA', 0, 'N', 'ZZ', 0, 0, 0),
(89, 'Head of Medical ', 'NA', 0, 'N', 'ZZ', 0, 0, 0),
(90, 'Head of Professional Services', 'NA', 0, 'N', 'ZZ', 0, 0, 0),
(91, 'Head of Regulatory', 'NA', 0, 'N', 'ZZ', 0, 0, 0),
(92, 'Head of Regulatory Affairs, QA, Compliance & SHE', 'NA', 0, 'N', 'ZZ', 0, 0, 0),
(93, 'Head of Sales', 'NA', 0, 'N', 'ZZ', 0, 0, 0),
(94, 'Head of Supply Chain Management', 'NA', 0, 'N', 'ZZ', 0, 0, 0),
(95, 'Healthcare Innovation Lead', 'NA', 0, 'N', 'ZZ', 0, 0, 0),
(96, 'HR Business Partner', 'NA', 0, 'N', 'ZZ', 0, 0, 0),
(97, 'HR Services Manager', 'NA', 0, 'N', 'ZZ', 0, 0, 0),
(98, 'Institutional Lead', 'NA', 0, 'N', 'ZZ', 0, 0, 0),
(99, 'IT Field Manager', 'NA', 0, 'N', 'ZZ', 0, 0, 0),
(100, 'IT Project Manager', 'NA', 0, 'N', 'ZZ', 0, 0, 0),
(101, 'IT Support Specialist', 'NA', 0, 'N', 'ZZ', 0, 0, 0),
(102, 'Key Account Executive', 'NA', 0, 'N', 'ZZ', 0, 0, 0),
(103, 'Key Account Executive DC', 'NA', 0, 'N', 'ZZ', 0, 0, 0),
(104, 'Key Account Exevutive', 'NA', 0, 'N', 'ZZ', 0, 0, 0),
(105, 'Manager Commercial', 'NA', 0, 'N', 'ZZ', 0, 0, 0),
(106, 'Manager Demand & Planing', 'NA', 0, 'N', 'ZZ', 0, 0, 0),
(107, 'Manager Distribution', 'NA', 0, 'N', 'ZZ', 0, 0, 0),
(108, 'Manager Finance & Controlling', 'NA', 0, 'N', 'ZZ', 0, 0, 0),
(109, 'Manager Medical & Safety', 'NA', 0, 'N', 'ZZ', 0, 0, 0),
(110, 'Manager Medical & Scientific Affairs', 'NA', 0, 'N', 'ZZ', 0, 0, 0),
(111, 'Managing Director', 'NA', 0, 'N', 'ZZ', 0, 0, 0),
(112, 'Marketing Coordinator', 'NA', 0, 'N', 'ZZ', 0, 0, 0),
(113, 'Marketing Services', 'NA', 0, 'N', 'ZZ', 0, 0, 0),
(114, 'Medical & Scientific Affairs Manager', 'NA', 0, 'N', 'ZZ', 0, 0, 0),
(115, 'Medical Compliance Lead', 'NA', 0, 'N', 'ZZ', 0, 0, 0),
(116, 'Medical Manager', 'NA', 0, 'N', 'ZZ', 0, 0, 0),
(117, 'Medical Science Liasion', 'NA', 0, 'N', 'ZZ', 0, 0, 0),
(118, 'Molecular Information Manager', 'NA', 0, 'N', 'ZZ', 0, 0, 0),
(119, 'National Lead – Rheumatology & Anemia Transplant', 'NA', 0, 'N', 'ZZ', 0, 0, 0),
(120, 'National Sales Manager BU I', 'NA', 0, 'N', 'ZZ', 0, 0, 0),
(121, 'National Sales Manager BU II', 'NA', 0, 'N', 'ZZ', 0, 0, 0),
(122, 'National Support Manager', 'NA', 0, 'N', 'ZZ', 0, 0, 0),
(123, 'Product Manager', 'NA', 0, 'N', 'ZZ', 0, 0, 0),
(124, 'Quality Assurance Manager', 'NA', 0, 'N', 'ZZ', 0, 0, 0),
(125, 'Regional Institutional Manager - Central', 'NA', 0, 'N', 'ZZ', 0, 0, 0),
(126, 'Sales Manager', 'NA', 0, 'N', 'ZZ', 0, 0, 0),
(127, 'Sales Manager - DC', 'NA', 0, 'N', 'ZZ', 0, 0, 0),
(128, 'Sales Manager - South', 'NA', 0, 'N', 'ZZ', 0, 0, 0),
(129, 'Sales Manager Central', 'NA', 0, 'N', 'ZZ', 0, 0, 0),
(130, 'Senior Application Specialist', 'NA', 0, 'N', 'ZZ', 0, 0, 0),
(131, 'Senior Executive Assistant', 'NA', 0, 'N', 'ZZ', 0, 0, 0),
(132, 'Senior Field Manager', 'NA', 0, 'N', 'ZZ', 0, 0, 0),
(133, 'Senior Field Manager - CPS South', 'NA', 0, 'N', 'ZZ', 0, 0, 0),
(134, 'Senior Field Manager - Services', 'NA', 0, 'N', 'ZZ', 0, 0, 0),
(135, 'Senior Field Manager Application', 'NA', 0, 'N', 'ZZ', 0, 0, 0),
(136, 'Senior Field Manager Services', 'NA', 0, 'N', 'ZZ', 0, 0, 0),
(137, 'Senior HR Generalist', 'NA', 0, 'N', 'ZZ', 0, 0, 0),
(138, 'Senior IT Specialist', 'NA', 0, 'N', 'ZZ', 0, 0, 0),
(139, 'Senior Key Account Executive', 'NA', 0, 'N', 'ZZ', 0, 0, 0),
(140, 'Senior Key Account Executive - CPS North', 'NA', 0, 'N', 'ZZ', 0, 0, 0),
(141, 'Senior Manager Marketing Serves', 'NA', 0, 'N', 'ZZ', 0, 0, 0),
(142, 'Senior Officer Distribution', 'NA', 0, 'N', 'ZZ', 0, 0, 0),
(143, 'Senior Product Manager', 'NA', 0, 'N', 'ZZ', 0, 0, 0),
(144, 'Senior Sales Manager', 'NA', 0, 'N', 'ZZ', 0, 0, 0),
(145, 'Senior Service Engineer', 'NA', 0, 'N', 'ZZ', 0, 0, 0),
(146, 'Senior Services Engineer', 'NA', 0, 'N', 'ZZ', 0, 0, 0),
(147, 'Service Manager', 'NA', 0, 'N', 'ZZ', 0, 0, 0),
(148, 'Services Manager', 'NA', 0, 'N', 'ZZ', 0, 0, 0),
(149, 'SHE Manager ', 'NA', 0, 'N', 'ZZ', 0, 0, 0),
(150, 'Squad Lead - CIT', 'NA', 0, 'N', 'ZZ', 0, 0, 0),
(151, 'Squad Lead - Neurosciences', 'NA', 0, 'N', 'ZZ', 0, 0, 0),
(152, 'Sr Field Manager Application', 'NA', 0, 'N', 'ZZ', 0, 0, 0),
(153, 'Sr. Business Analyst', 'NA', 0, 'N', 'ZZ', 0, 0, 0),
(154, 'Sr. Communications Manager', 'NA', 0, 'N', 'ZZ', 0, 0, 0),
(155, 'Sr. Field Manager', 'NA', 0, 'N', 'ZZ', 0, 0, 0),
(156, 'Sr. Manager Access', 'NA', 0, 'N', 'ZZ', 0, 0, 0),
(157, 'Sr. Manager Access (Central)', 'NA', 0, 'N', 'ZZ', 0, 0, 0),
(158, 'Sr. Manager Accounts', 'NA', 0, 'N', 'ZZ', 0, 0, 0),
(159, 'Sr. Manager Accounts & Taxation', 'NA', 0, 'N', 'ZZ', 0, 0, 0),
(160, 'Sr. Manager Communications & PAGS', 'NA', 0, 'N', 'ZZ', 0, 0, 0),
(161, 'Sr. Manager Regulatory ', 'NA', 0, 'N', 'ZZ', 0, 0, 0),
(162, 'Sr. Manager Treasury & Planning', 'NA', 0, 'N', 'ZZ', 0, 0, 0),
(163, 'Sr. Product Manager', 'NA', 0, 'N', 'ZZ', 0, 0, 0),
(164, 'Sr. Sales Manager', 'NA', 0, 'N', 'ZZ', 0, 0, 0),
(165, 'Talent Development Manager', 'NA', 0, 'N', 'ZZ', 0, 0, 0),
(166, 'Team Leader - Key Account Management', 'NA', 0, 'N', 'ZZ', 0, 0, 0),
(167, 'Business Financial Analyst', 'BFA', 31, 'N', 'ZZ', 0, 0, 167),
(168, 'Manager Logistics', 'ML', 23, 'N', 'ZZ', 0, 0, 168),
(169, 'Medical Quality and Safety Manager', 'MQ&SM', 38, 'Y', 'ZZ', 0, 0, 89),
(170, 'Head of Health Policy & Government Affairs', 'na', 0, 'N', 'ZZ', 0, 0, 0),
(171, 'Senior Manager Finance & Controlling', 'na', 0, 'N', 'ZZ', 0, 0, 0),
(172, 'Marketing Manager', 'MM', 32, 'Y', 'ZZ', 0, 0, 44),
(173, 'Senior Marketing Officer', 'SMO', 32, 'Y', 'ZZ', 0, 0, 44),
(174, 'Executive Manager Compliance & Audit', 'EMCA', 22, 'Y', 'ZZ', 0, 0, 44),
(176, 'Director Access and Public Policy', 'DAPP', 10, 'Y', 'ZZ', 0, 0, 44),
(177, 'Business Development Manager', 'BDM', 32, 'Y', 'ZZ', 0, 0, 44),
(178, 'Medical Scientific Liaison', 'MSL', 38, 'Y', 'ZZ', 0, 0, 44),
(179, 'Financial Analyst', 'FA', 22, 'Y', 'ZZ', 0, 0, 44),
(180, 'Senior Officer Regulatory', 'SOR', 42, 'N', 'ZZ', 0, 0, 44),
(181, 'Head of Commercial Operations', 'HCO', 18, 'N', 'ZZ', 0, 0, 44),
(182, 'Manager Commercial Operations', 'MCO', 18, 'N', 'ZZ', 0, 0, 44),
(183, 'Assistant Manager Commercial Operations', 'AMCO', 18, 'N', 'ZZ', 0, 0, 44),
(184, 'Senior Officer Commercial Operations', 'SOCO', 18, 'N', 'ZZ', 0, 0, 44),
(185, 'Senior Manager Medical & Scientific Affairs', 'SMMSA', 37, 'Y', 'ZZ', 0, 0, 44),
(186, 'Senior Compliance & Audit Manager', 'SCAM', 42, 'N', 'ZZ', 0, 0, 44),
(187, 'Team Lead', 'TL', 33, 'N', 'ZZ', 0, 0, 44),
(188, 'Manager IT & Workflow', 'MITW', 28, 'N', 'ZZ', 0, 0, 44),
(189, 'Senior Demand Planner Asia', 'SDPA', 23, 'N', 'ZZ', 0, 0, 44),
(190, 'Senior Manager IT', 'SMIT', 28, 'N', 'ZZ', 0, 0, 44),
(191, 'Senior Manager Access & Marketing', 'SMAM', 10, 'N', 'ZZ', 0, 0, 44),
(192, 'Manager Material Planning & Logistics', 'MMPL', 23, 'Y', 'ZZ', 0, 0, 80),
(193, 'Assistant Manager Compliance', 'AMC', 57, 'Y', 'ZZ', 0, 0, 174),
(194, 'Patient Journey Partner', 'PJP', 13, 'N', 'ZZ', 0, 0, 44),
(195, 'Commercial Lead - I2O & Neuro', 'CL', 23, 'N', 'ZZ', 0, 0, 80),
(196, 'Commercial Coordinator', 'CC', 23, 'N', 'ZZ', 0, 0, 195),
(197, 'Allied Specialties Coordinator', 'ASC', 13, 'N', 'ZZ', 0, 0, 66),
(198, 'Pipeline Lead', 'PLL', 38, 'N', 'ZZ', 0, 0, 116),
(199, 'Healthcare Innovation & Pags Lead', 'HIPL', 10, 'N', 'ZZ', 0, 0, 44),
(200, 'Digital Lead', 'DL', 59, 'N', 'ZZ', 0, 0, 44),
(201, 'Capability & Transformation Lead', 'CTL', 59, 'N', 'ZZ', 0, 0, 66),
(202, 'Director Access', 'DA', 10, 'N', 'ZZ', 0, 0, 44),
(203, 'Therapeutic Area Lead', 'TAL', 33, 'N', 'ZZ', 0, 0, 44),
(204, 'Healthcare System Partner', 'HSP', 10, 'N', 'ZZ', 0, 0, 44),
(205, 'Strategic Talent Partner', 'STP', 27, 'N', 'ZZ', 0, 0, 44),
(206, 'People & Culture Business Partner', 'PCBP', 27, 'N', 'ZZ', 0, 0, 44),
(207, 'PSP Manager', 'PSPM', 23, 'Y', 'ZZ', 0, 0, 68),
(208, 'General Manager', 'GM', 36, 'Y', 'ZZ', 0, 0, 0),
(209, 'Compensation & Benefits Manager', 'C&BM', 27, 'Y', 'ZZ', 0, 0, 86),
(210, 'Field Manager Key Account', 'FMKA', 49, 'N', 'ZZ', 0, 0, 44),
(211, 'Sales Executive Key Account', 'SEKA', 49, 'N', 'ZZ', 0, 0, 44),
(212, 'Chapter Member Planning and Reporting', 'CMP&R', 23, 'N', 'ZZ', 0, 0, 84),
(213, 'Finance Business Partner Advisory', 'FBPA', 22, 'N', 'ZZ', 0, 0, 80),
(214, 'Senior Pipeline Lead', 'SPL', 38, 'N', 'ZZ', 0, 0, 89),
(215, 'Head of Diabetes Care Pakistan & Bangladesh', 'HDCPB', 31, 'Y', 'ZZ', 0, 0, 208),
(216, 'IT Onsite User Services Specialist', 'zz', 28, 'N', 'ZZ', 0, 0, 80),
(217, 'Medical Cluster Lead Asia Emerging Markets', 'zz', 38, 'Y', 'ZZ', 0, 0, 208),
(218, 'Cluster AEM Project Management Officer & Marketing Lead Pakistan', 'zz', 10, 'Y', 'ZZ', 0, 0, 208),
(219, 'Country Tax Manager', 'zz', 22, 'Y', 'ZZ', 0, 0, 208),
(220, 'Manager Regulatory Affair', 'zz', 42, 'Y', 'ZZ', 0, 0, 91),
(221, 'Senior Manager Commercial Operations', 'zz', 22, 'Y', 'ZZ', 0, 0, 80),
(222, 'Finance Business Partner - Treasury & Supply Chain', 'zz', 20, 'Y', 'ZZ', 0, 0, 94),
(223, 'Finance Business Partner', 'zz', 22, 'Y', 'ZZ', 0, 0, 80),
(224, 'Market Access Lead AEM Cluster', 'zz', 31, 'Y', 'ZZ', 0, 0, 208),
(225, 'Divisional Director Finance & Operations', 'zz', 22, 'Y', 'ZZ', 0, 0, 63),
(226, 'Business Support Manager', 'zz', 22, 'Y', 'ZZ', 0, 0, 225),
(227, 'Head of RIS & Business Support', 'zz', 22, 'Y', 'ZZ', 0, 0, 225),
(228, 'Team Lead Strategic Business Support', 'zz', 22, 'Y', 'ZZ', 0, 0, 225),
(229, 'Team Lead Business Operations & Support', 'zz', 22, 'Y', 'ZZ', 0, 0, 225),
(230, 'Team Lead Distribution', 'zz', 22, 'Y', 'ZZ', 0, 0, 225);

-- --------------------------------------------------------

--
-- Table structure for table `dir_divisions`
--

CREATE TABLE `dir_divisions` (
  `Div_code` int(11) NOT NULL,
  `Div_name` varchar(100) DEFAULT NULL,
  `Div_abbr` varchar(6) NOT NULL,
  `Div_Head` int(11) NOT NULL,
  `Sort_key` varchar(2) DEFAULT NULL,
  `division_category_code` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `dir_divisions`
--

INSERT INTO `dir_divisions` (`Div_code`, `Div_name`, `Div_abbr`, `Div_Head`, `Sort_key`, `division_category_code`) VALUES
(1, 'NA', 'NA', 0, 'ZZ', 0),
(10, 'Access', 'NA', 0, 'ZZ', 0),
(11, 'Administration', 'NA', 0, 'ZZ', 0),
(12, 'ARKET SUPPORT CD', 'NA', 0, 'ZZ', 0),
(13, 'BU Onco - I', 'NA', 0, 'ZZ', 0),
(14, 'BU Onco - II', 'NA', 0, 'ZZ', 0),
(15, 'CIT Squad', 'NA', 0, 'ZZ', 0),
(16, 'Communications', 'NA', 0, 'ZZ', 0),
(17, 'Dia Distribution - Karachi', 'NA', 0, 'ZZ', 0),
(18, 'Diagnostic Distribution', 'NA', 0, 'ZZ', 0),
(19, 'Distribution - Islamabad', 'NA', 0, 'ZZ', 0),
(20, 'Distribution - Karachi', 'NA', 0, 'ZZ', 0),
(21, 'Distribution - Lahore', 'NA', 0, 'ZZ', 0),
(22, 'Fin Acct & Controlling - DIA', 'NA', 0, 'ZZ', 0),
(23, 'Finance', 'NA', 0, 'ZZ', 0),
(24, 'FMI', 'NA', 0, 'ZZ', 0),
(25, 'General Services-DIA Head Office', 'NA', 0, 'ZZ', 0),
(26, 'GS-Indirect Purchase', 'NA', 0, 'ZZ', 0),
(27, 'P&C', 'NA', 0, 'ZZ', 0),
(28, 'IT', 'NA', 0, 'ZZ', 0),
(29, 'IT-DIA SHRD.H.O', 'NA', 0, 'ZZ', 0),
(30, 'M.SUP.DIA -SHRD.H.O', 'NA', 0, 'ZZ', 0),
(31, 'MARKET SUPPORT-DC', 'NA', 0, 'ZZ', 0),
(32, 'MARKET SUPPORT-MD', 'NA', 0, 'ZZ', 0),
(33, 'Marketing', 'NA', 0, 'ZZ', 0),
(34, 'Marketing Support Function', 'NA', 0, 'ZZ', 0),
(35, 'MATPROC & LOGISTICS DIA', 'NA', 0, 'ZZ', 0),
(36, 'MD', 'NA', 0, 'ZZ', 0),
(37, 'Medical & Scientific Affairs DIA', 'NA', 0, 'ZZ', 0),
(38, 'Medical Affairs', 'NA', 0, 'ZZ', 0),
(39, 'Neurosciences Squad', 'NA', 0, 'ZZ', 0),
(40, 'PER-KHI DIA OFFICE', 'NA', 0, 'ZZ', 0),
(41, 'QUALITYREG.& SAFETY AFFRS-DIA', 'NA', 0, 'ZZ', 0),
(42, 'Regulatory Affairs', 'NA', 0, 'ZZ', 0),
(43, 'Rheumatology & Anemia', 'NA', 0, 'ZZ', 0),
(44, 'SALES - DC ISLAMABAD', 'NA', 0, 'ZZ', 0),
(45, 'SALES - DC KARACHI', 'NA', 0, 'ZZ', 0),
(46, 'SALES - DC LAHORE', 'NA', 0, 'ZZ', 0),
(47, 'SALES - DC SHARE.H.O', 'NA', 0, 'ZZ', 0),
(48, 'SALES - EM & Afghanistan', 'NA', 0, 'ZZ', 0),
(49, 'SALES - Key Accounts & Commercial', 'NA', 0, 'ZZ', 0),
(50, 'Sales Dia- MD - Islamabad', 'NA', 0, 'ZZ', 0),
(51, 'T.E.SERV.DIA-ISL.', 'NA', 0, 'ZZ', 0),
(52, 'T.E.SERV.DIA-KARACHI', 'NA', 0, 'ZZ', 0),
(53, 'T.E.SERV.DIA-LAHORE', 'NA', 0, 'ZZ', 0),
(54, 'Technical Services-Agility', 'NA', 0, 'ZZ', 0),
(55, 'Technical Services-OE', 'NA', 0, 'ZZ', 0),
(56, 'Technical Services-Shared', 'NA', 0, 'ZZ', 0),
(57, 'Compliance - Dia', 'CDIA', 1205, 'ZZ', NULL),
(58, 'Specialty', 'Specia', 1192, 'ZA', NULL),
(59, 'Pharma', 'PHA', 1492, 'ZA', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `dir_division_categories`
--

CREATE TABLE `dir_division_categories` (
  `Division_category_Code` int(11) NOT NULL,
  `Division_category_Name` varchar(100) DEFAULT NULL,
  `Sort_Key` varchar(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dir_educations`
--

CREATE TABLE `dir_educations` (
  `Edu_code` int(11) NOT NULL,
  `Edu_name` varchar(200) NOT NULL,
  `Edu_abbr` varchar(6) NOT NULL,
  `Edu_level_code` int(11) NOT NULL,
  `Sort_key` varchar(2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dir_education_levels`
--

CREATE TABLE `dir_education_levels` (
  `Edu_level_code` int(11) NOT NULL,
  `Edu_level_name` varchar(30) NOT NULL,
  `Edu_level_abbr` varchar(6) NOT NULL,
  `Sort_key` varchar(2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `dir_education_levels`
--

INSERT INTO `dir_education_levels` (`Edu_level_code`, `Edu_level_name`, `Edu_level_abbr`, `Sort_key`) VALUES
(1, 'Graduate', 'Garde', 'ZZ'),
(2, 'Master', 'Mast', 'ZZ'),
(3, 'Inter', 'Inter', 'ZZ'),
(4, 'Matric', 'Mat', 'ZZ'),
(5, 'Professional', 'Profes', 'ZZ');

-- --------------------------------------------------------

--
-- Table structure for table `dir_employees_retirement_age`
--

CREATE TABLE `dir_employees_retirement_age` (
  `Retirement_Age` int(11) DEFAULT NULL,
  `Created_By` int(11) DEFAULT NULL,
  `Created_On` datetime(3) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dir_employee_categories`
--

CREATE TABLE `dir_employee_categories` (
  `Emp_Category_code` int(11) NOT NULL,
  `Emp_Category_name` varchar(30) NOT NULL,
  `Emp_Category_abbr` varchar(6) NOT NULL,
  `Sort_key` varchar(2) DEFAULT NULL,
  `graduity_fund_percentage` decimal(12,3) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `dir_employee_categories`
--

INSERT INTO `dir_employee_categories` (`Emp_Category_code`, `Emp_Category_name`, `Emp_Category_abbr`, `Sort_key`, `graduity_fund_percentage`) VALUES
(1, 'Pharma', 'Pharma', 'ZZ', 5.470),
(2, 'Diagnostics', 'Dia', 'ZZ', 5.470),
(3, 'Diabetic Care', 'DC', 'ZZ', 5.470);

-- --------------------------------------------------------

--
-- Table structure for table `dir_employment_types`
--

CREATE TABLE `dir_employment_types` (
  `Empt_Type_code` int(11) NOT NULL,
  `Empt_Type_name` varchar(30) NOT NULL,
  `Empt_Type_abbr` varchar(6) NOT NULL,
  `Company_Employee_Flag` varchar(1) DEFAULT NULL,
  `Emp_Code_Prefix` varchar(2) DEFAULT NULL,
  `PermanantFlag` char(1) DEFAULT NULL,
  `Retirement_Age` decimal(2,0) DEFAULT NULL,
  `ProbationMonths` int(11) DEFAULT NULL,
  `AllowChangeProbationMonths` char(1) DEFAULT NULL,
  `Appraisal_Start_Date` datetime(3) DEFAULT NULL,
  `Sort_key` varchar(2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `dir_employment_types`
--

INSERT INTO `dir_employment_types` (`Empt_Type_code`, `Empt_Type_name`, `Empt_Type_abbr`, `Company_Employee_Flag`, `Emp_Code_Prefix`, `PermanantFlag`, `Retirement_Age`, `ProbationMonths`, `AllowChangeProbationMonths`, `Appraisal_Start_Date`, `Sort_key`) VALUES
(1, 'Permanent', 'Perm', 'Y', '', 'Y', 60, 3, 'Y', '2020-01-01 00:00:00.000', 'ZZ');

-- --------------------------------------------------------

--
-- Table structure for table `dir_eobi_cities`
--

CREATE TABLE `dir_eobi_cities` (
  `EOBI_City_code` int(11) NOT NULL,
  `EOBI_City_name` varchar(30) NOT NULL,
  `EOBI_City_abbr` varchar(6) NOT NULL,
  `Sort_key` varchar(2) DEFAULT NULL,
  `eobi_amount` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dir_ess_request_type`
--

CREATE TABLE `dir_ess_request_type` (
  `Request_Code` int(11) NOT NULL,
  `Request_Name` varchar(100) DEFAULT NULL,
  `Active_Flag` char(1) DEFAULT NULL,
  `Created_by` int(11) DEFAULT NULL,
  `Created_Date` datetime(3) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dir_grades`
--

CREATE TABLE `dir_grades` (
  `Grade_code` int(11) NOT NULL,
  `Grade_name` varchar(30) NOT NULL,
  `Grade_abbr` varchar(6) DEFAULT NULL,
  `Probation_Months` smallint(6) DEFAULT NULL,
  `Incentive_Hour_Rate` smallint(6) DEFAULT NULL,
  `Incentive_Weekdays_Limit_Hour` smallint(6) DEFAULT NULL,
  `Incentive_Saturday_Limit_Hour` smallint(6) DEFAULT NULL,
  `Medical_Insurance_Amount` mediumint(9) DEFAULT NULL,
  `Meal_Deduction` int(11) DEFAULT NULL,
  `Sort_key` varchar(2) DEFAULT NULL,
  `Litres_for_Petrol` int(11) DEFAULT NULL,
  `Insurance_Category` varchar(1) DEFAULT NULL,
  `Life_Insurance_Category` varchar(5) DEFAULT NULL,
  `Long_Name` varchar(40) DEFAULT NULL,
  `job_description_flag` varchar(1) DEFAULT NULL,
  `next_promotion_grade` int(11) DEFAULT NULL,
  `Assigning_Critaria_For_Next_Promotion` int(11) DEFAULT NULL,
  `Overtime_flag` varchar(10) DEFAULT NULL,
  `mobile_amount` bigint(20) DEFAULT NULL,
  `Car_Amount` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `dir_grades`
--

INSERT INTO `dir_grades` (`Grade_code`, `Grade_name`, `Grade_abbr`, `Probation_Months`, `Incentive_Hour_Rate`, `Incentive_Weekdays_Limit_Hour`, `Incentive_Saturday_Limit_Hour`, `Medical_Insurance_Amount`, `Meal_Deduction`, `Sort_key`, `Litres_for_Petrol`, `Insurance_Category`, `Life_Insurance_Category`, `Long_Name`, `job_description_flag`, `next_promotion_grade`, `Assigning_Critaria_For_Next_Promotion`, `Overtime_flag`, `mobile_amount`, `Car_Amount`) VALUES
(0, 'Not Applicable', 'N/A', 0, 0, 0, 0, 0, 0, 'ZZ', 0, '0', '0', '', 'N', 0, 0, 'N', 0, 0),
(16, 'A1', 'NA', 0, 0, 0, 0, 0, 0, 'ZZ', 0, '0', '0', '', 'N', 0, 0, 'N', 0, 0),
(17, 'A2', 'NA', 0, 0, 0, 0, 0, 0, 'ZZ', 0, '0', '0', '', 'N', 0, 0, 'N', 0, 0),
(18, 'A3', 'NA', 0, 0, 0, 0, 0, 0, 'ZZ', 0, '0', '0', '', 'N', 0, 0, 'N', 0, 0),
(19, 'B1', 'NA', 0, 0, 0, 0, 0, 0, 'ZZ', 0, '0', '0', '', 'N', 0, 0, 'N', 0, 0),
(20, 'B1-Sr. Manager', 'NA', 0, 0, 0, 0, 0, 0, 'ZZ', 0, '0', '0', '', 'N', 0, 0, 'N', 0, 0),
(21, 'B2', 'NA', 0, 0, 0, 0, 0, 0, 'ZZ', 0, '0', '0', '', 'N', 0, 0, 'N', 0, 0),
(22, 'C1', 'NA', 0, 0, 0, 0, 0, 0, 'ZZ', 0, '0', '0', '', 'N', 0, 0, 'N', 0, 0),
(23, 'C2', 'NA', 0, 0, 0, 0, 0, 0, 'ZZ', 0, '0', '0', '', 'N', 0, 0, 'N', 0, 0),
(24, 'C3', 'NA', 0, 0, 0, 0, 0, 0, 'ZZ', 0, '0', '0', '', 'N', 0, 0, 'N', 0, 0),
(25, 'D1', 'NA', 0, 0, 0, 0, 0, 0, 'ZZ', 0, '0', '0', '', 'N', 0, 0, 'N', 0, 0),
(26, 'D2', 'NA', 0, 0, 0, 0, 0, 0, 'ZZ', 0, '0', '0', '', 'N', 0, 0, 'N', 0, 0),
(27, 'E1', 'NA', 0, 0, 0, 0, 0, 0, 'ZZ', 0, '0', '0', '', 'N', 0, 0, 'N', 0, 0),
(28, 'E2', 'NA', 0, 0, 0, 0, 0, 0, 'ZZ', 0, '0', '0', '', 'N', 0, 0, 'N', 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `dir_hiring_checklist`
--

CREATE TABLE `dir_hiring_checklist` (
  `List_no` int(11) NOT NULL,
  `Item_Name` varchar(500) DEFAULT NULL,
  `SortKey` varchar(5) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `dir_hiring_checklist`
--

INSERT INTO `dir_hiring_checklist` (`List_no`, `Item_Name`, `SortKey`) VALUES
(1, 'abc', 'aaa');

-- --------------------------------------------------------

--
-- Table structure for table `dir_hospitals`
--

CREATE TABLE `dir_hospitals` (
  `hospital_code` int(11) DEFAULT NULL,
  `hospital_name` varchar(100) DEFAULT NULL,
  `hospital_address` varchar(150) DEFAULT NULL,
  `hospital_phone_no1` varchar(20) DEFAULT NULL,
  `hospital_phone_no2` varchar(20) DEFAULT NULL,
  `hospital_contact_name` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dir_hr_categories`
--

CREATE TABLE `dir_hr_categories` (
  `HR_Category_code` int(11) NOT NULL,
  `HR_Category_Name` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dir_hr_letter_types`
--

CREATE TABLE `dir_hr_letter_types` (
  `Letter_type_code` int(11) NOT NULL,
  `Letter_type_name` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dir_incometax_columns`
--

CREATE TABLE `dir_incometax_columns` (
  `Column_No` int(11) NOT NULL,
  `Column_name` varchar(50) NOT NULL,
  `Head_Line_01` varchar(20) NOT NULL DEFAULT '',
  `Head_Line_02` varchar(20) NOT NULL DEFAULT '',
  `Head_Line_03` varchar(20) NOT NULL DEFAULT '',
  `Head_Line_04` varchar(20) NOT NULL DEFAULT '',
  `Head_Line_05` varchar(20) NOT NULL DEFAULT '',
  `Head_Line_06` varchar(20) NOT NULL DEFAULT '',
  `Head_Line_07` varchar(20) NOT NULL DEFAULT '',
  `Head_Line_08` varchar(20) NOT NULL DEFAULT '',
  `Sort_key` varchar(2) DEFAULT NULL,
  `Colunm_Type` varchar(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dir_institutions`
--

CREATE TABLE `dir_institutions` (
  `Inst_code` int(11) NOT NULL,
  `Inst_name` varchar(100) NOT NULL,
  `Inst_abbr` varchar(6) NOT NULL,
  `Inst_type` varchar(1) NOT NULL,
  `Inst_address_line1` varchar(40) DEFAULT NULL,
  `Inst_address_line2` varchar(40) DEFAULT NULL,
  `Inst_address_line3` varchar(40) DEFAULT NULL,
  `Inst_phone1` varchar(10) DEFAULT NULL,
  `Inst_phone2` varchar(10) DEFAULT NULL,
  `Inst_fax1` varchar(10) DEFAULT NULL,
  `Inst_fax2` varchar(10) DEFAULT NULL,
  `Inst_email` varchar(100) DEFAULT NULL,
  `Inst_Web_Site` varchar(50) DEFAULT NULL,
  `Sort_key` varchar(2) DEFAULT NULL,
  `Verification_Fee` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dir_jobprofiles`
--

CREATE TABLE `dir_jobprofiles` (
  `JobCode` int(11) NOT NULL,
  `JobDescription` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dir_jv_codes`
--

CREATE TABLE `dir_jv_codes` (
  `JV_Unit` varchar(3) NOT NULL,
  `JV_Currency` varchar(3) NOT NULL,
  `JV_Cost_Centre` varchar(6) NOT NULL,
  `JV_MainAC` varchar(6) NOT NULL,
  `JV_SubAC` varchar(3) NOT NULL,
  `JV_Description` varchar(50) DEFAULT NULL,
  `Sort_key` varchar(2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dir_leave_categories`
--

CREATE TABLE `dir_leave_categories` (
  `Leave_Category_code` int(11) NOT NULL,
  `Leave_Category_name` varchar(30) NOT NULL,
  `Leave_Category_abbr` varchar(6) NOT NULL,
  `Sort_key` varchar(2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `dir_leave_categories`
--

INSERT INTO `dir_leave_categories` (`Leave_Category_code`, `Leave_Category_name`, `Leave_Category_abbr`, `Sort_key`) VALUES
(1, 'N/A', 'N/A', 'ZZ');

-- --------------------------------------------------------

--
-- Table structure for table `dir_leave_types`
--

CREATE TABLE `dir_leave_types` (
  `Leave_type_code` int(11) NOT NULL,
  `Leave_name` varchar(40) NOT NULL,
  `Leave_type_abbr` varchar(6) NOT NULL,
  `Leave_Category_code` int(11) NOT NULL,
  `Start_date` datetime(3) DEFAULT NULL,
  `End_date` datetime(3) DEFAULT NULL,
  `Annual_Credit` decimal(2,0) DEFAULT NULL,
  `Accumulation_limit` decimal(3,0) DEFAULT NULL,
  `Proportionate_flag` varchar(1) DEFAULT NULL,
  `Advance_days` decimal(3,0) DEFAULT NULL,
  `Minimum_days_per_form` decimal(3,0) DEFAULT NULL,
  `Maximum_days_per_form` decimal(3,0) DEFAULT NULL,
  `Life_times` decimal(2,0) DEFAULT NULL,
  `Religion_code` int(11) NOT NULL,
  `Increase_Leave_code` int(11) DEFAULT NULL,
  `Join_Confirm_flag` varchar(1) DEFAULT NULL,
  `Balance_Check_flag` varchar(1) DEFAULT NULL,
  `Meal_flag` varchar(1) DEFAULT NULL,
  `Encashment_flag` varchar(1) DEFAULT NULL,
  `Without_pay_flag` varchar(1) DEFAULT NULL,
  `Medical_Certificate_flag` varchar(1) DEFAULT NULL,
  `Medical_Certificate_days` decimal(2,0) DEFAULT NULL,
  `Special_Approval_flag` varchar(1) DEFAULT NULL,
  `Special_Approval_days` decimal(2,0) DEFAULT NULL,
  `married_flag` varchar(1) DEFAULT NULL,
  `Adjustment_flag` varchar(1) DEFAULT NULL,
  `Adjustment_Leave_code` int(11) DEFAULT NULL,
  `Sort_key` varchar(2) DEFAULT NULL,
  `On_Confirm_Flag` varchar(1) DEFAULT NULL,
  `DaysApplyOn` char(1) DEFAULT NULL,
  `SandwichFlag` char(1) DEFAULT NULL,
  `AttachmentFlag` char(1) DEFAULT NULL,
  `AttachmentDays` decimal(5,1) DEFAULT NULL,
  `HREntryStopFlag` char(1) DEFAULT NULL,
  `RepaymentFlag` char(1) DEFAULT NULL,
  `GenderFlag` char(1) DEFAULT NULL,
  `CompensatoryFlag` char(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `dir_leave_types`
--

INSERT INTO `dir_leave_types` (`Leave_type_code`, `Leave_name`, `Leave_type_abbr`, `Leave_Category_code`, `Start_date`, `End_date`, `Annual_Credit`, `Accumulation_limit`, `Proportionate_flag`, `Advance_days`, `Minimum_days_per_form`, `Maximum_days_per_form`, `Life_times`, `Religion_code`, `Increase_Leave_code`, `Join_Confirm_flag`, `Balance_Check_flag`, `Meal_flag`, `Encashment_flag`, `Without_pay_flag`, `Medical_Certificate_flag`, `Medical_Certificate_days`, `Special_Approval_flag`, `Special_Approval_days`, `married_flag`, `Adjustment_flag`, `Adjustment_Leave_code`, `Sort_key`, `On_Confirm_Flag`, `DaysApplyOn`, `SandwichFlag`, `AttachmentFlag`, `AttachmentDays`, `HREntryStopFlag`, `RepaymentFlag`, `GenderFlag`, `CompensatoryFlag`) VALUES
(0, 'NA', 'NA', 0, '2015-01-01 00:00:00.000', '2022-12-31 00:00:00.000', 0, 0, 'N', 0, 0, 0, 0, 0, 0, 'J', 'N', 'N', 'N', 'N', 'N', 0, 'N', 0, 'B', 'N', 0, 'ZZ', 'Y', 'C', 'Y', 'N', 0.0, 'N', 'N', 'B', 'N'),
(8, 'Leave Encashment', 'HajjR', 1, '2020-01-01 00:00:00.000', '2022-12-31 00:00:00.000', 40, 40, 'N', 40, 1, 40, 99, 0, 0, 'J', 'N', 'N', 'Y', 'N', 'N', 0, 'N', 0, 'B', 'N', 0, 'ZZ', 'N', 'W', 'N', 'N', 0.0, 'N', 'N', 'B', 'N'),
(18, 'Annual', 'HajjR', 1, '2020-01-01 00:00:00.000', '2022-12-31 00:00:00.000', 40, 40, 'N', 40, 1, 40, 99, 0, 0, 'J', 'N', 'N', 'Y', 'N', 'N', 0, 'N', 0, 'B', 'N', 0, 'ZZ', 'N', 'W', 'N', 'N', 0.0, 'N', 'N', 'B', 'N');

-- --------------------------------------------------------

--
-- Table structure for table `dir_letter_types`
--

CREATE TABLE `dir_letter_types` (
  `Letter_Type_code` int(11) NOT NULL,
  `Letter_Type_name` varchar(30) NOT NULL,
  `Letter_Type_abbr` varchar(6) NOT NULL,
  `Positive_Negative_Flag` varchar(1) NOT NULL,
  `Sort_key` varchar(2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dir_locations`
--

CREATE TABLE `dir_locations` (
  `Loc_code` int(11) NOT NULL,
  `Loc_name` varchar(80) NOT NULL,
  `Loc_abbr` varchar(6) NOT NULL,
  `Loc_address_line1` varchar(125) DEFAULT NULL,
  `Loc_address_line2` varchar(100) DEFAULT NULL,
  `Loc_address_contact` varchar(20) DEFAULT NULL,
  `Loc_address_phone` varchar(20) DEFAULT NULL,
  `Loc_address_fax` varchar(20) DEFAULT NULL,
  `City_code` int(11) NOT NULL,
  `Level_1_Code` int(11) DEFAULT NULL,
  `Bank_Code` varchar(4) NOT NULL DEFAULT '0',
  `Sort_key` varchar(2) DEFAULT NULL,
  `eobi_city_code` int(11) DEFAULT NULL,
  `JV_CODE` varchar(10) DEFAULT NULL,
  `Branch_Flag` varchar(1) DEFAULT 'Y',
  `BranchManager_Code` int(11) DEFAULT 0,
  `Branch_Operation_Manager_Code` int(11) DEFAULT NULL,
  `evening_banking_peron_limit` int(11) DEFAULT NULL,
  `Evening_banking_flag` varchar(1) DEFAULT NULL,
  `Saturday_banking_peron_limit` int(11) DEFAULT NULL,
  `Saturday_banking_flag` varchar(1) DEFAULT NULL,
  `SatEveningFlag` varchar(10) DEFAULT NULL,
  `Sunday_banking_peron_limit` int(11) DEFAULT NULL,
  `Sunday_banking_flag` varchar(1) DEFAULT NULL,
  `Saturday_Affactive_Date` datetime(3) DEFAULT NULL,
  `Saturday_InActive_Date` datetime(3) DEFAULT NULL,
  `Evening_Affactive_Date` datetime(3) DEFAULT NULL,
  `Evening_InActive_Date` datetime(3) DEFAULT NULL,
  `Sunday_Affactive_Date` datetime(3) DEFAULT NULL,
  `Sunday_InActive_Date` datetime(3) DEFAULT NULL,
  `Booth_Flag` char(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `dir_locations`
--

INSERT INTO `dir_locations` (`Loc_code`, `Loc_name`, `Loc_abbr`, `Loc_address_line1`, `Loc_address_line2`, `Loc_address_contact`, `Loc_address_phone`, `Loc_address_fax`, `City_code`, `Level_1_Code`, `Bank_Code`, `Sort_key`, `eobi_city_code`, `JV_CODE`, `Branch_Flag`, `BranchManager_Code`, `Branch_Operation_Manager_Code`, `evening_banking_peron_limit`, `Evening_banking_flag`, `Saturday_banking_peron_limit`, `Saturday_banking_flag`, `SatEveningFlag`, `Sunday_banking_peron_limit`, `Sunday_banking_flag`, `Saturday_Affactive_Date`, `Saturday_InActive_Date`, `Evening_Affactive_Date`, `Evening_InActive_Date`, `Sunday_Affactive_Date`, `Sunday_InActive_Date`, `Booth_Flag`) VALUES
(1, 'NA', 'NA', 'NA', 'Na', 'NA', 'NA', 'NA', 0, 0, '0', 'ZZ', 0, '0', 'N', 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(9, 'Islamabad', 'na', 'N', 'N', 'N', 'N', 'N', 6, 0, '0', 'ZZ', 3, '0', 'N', 0, 0, 0, 'N', 0, 'N', 'N', 0, 'N', '2020-05-21 15:28:37.647', '2020-05-21 15:28:37.647', '2020-05-21 15:28:37.647', '2020-05-21 15:28:37.647', '2020-05-21 15:28:37.647', '2020-05-21 15:28:37.647', 'N'),
(10, 'Karachi', 'na', 'N', 'N', 'N', 'N', 'N', 1, 0, '0', 'ZZ', 1, '0', 'N', 0, 0, 0, 'N', 0, 'N', 'N', 0, 'N', '2020-05-21 15:28:37.647', '2020-05-21 15:28:37.647', '2020-05-21 15:28:37.647', '2020-05-21 15:28:37.647', '2020-05-21 15:28:37.647', '2020-05-21 15:28:37.647', 'N'),
(11, 'Lahore', 'na', 'N', 'N', 'N', 'N', 'N', 7, 0, '0', 'ZZ', 2, '0', 'N', 0, 0, 0, 'N', 0, 'N', 'N', 0, 'N', '2020-05-21 15:28:37.647', '2020-05-21 15:28:37.647', '2020-05-21 15:28:37.647', '2020-05-21 15:28:37.647', '2020-05-21 15:28:37.647', '2020-05-21 15:28:37.647', 'N');

-- --------------------------------------------------------

--
-- Table structure for table `dir_meal_structures`
--

CREATE TABLE `dir_meal_structures` (
  `Structure_Code` int(11) NOT NULL,
  `Gross_Salary_From` decimal(10,0) DEFAULT NULL,
  `Gross_Salary_To` decimal(10,0) DEFAULT NULL,
  `Meal_Amount` decimal(9,0) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dir_mode_of_payments`
--

CREATE TABLE `dir_mode_of_payments` (
  `Payment_code` int(11) NOT NULL,
  `Payment_name` varchar(30) NOT NULL,
  `Payment_abbr` varchar(6) NOT NULL,
  `Cash_Bank_Flag` char(1) DEFAULT NULL,
  `Sort_key` varchar(2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dir_months`
--

CREATE TABLE `dir_months` (
  `Month_No` int(11) DEFAULT NULL,
  `Month_Name` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dir_payroll_categories`
--

CREATE TABLE `dir_payroll_categories` (
  `Payroll_Category_code` int(11) NOT NULL,
  `Payroll_Category_name` varchar(30) NOT NULL,
  `Payroll_Category_abbr` varchar(6) NOT NULL,
  `Payroll_Month` decimal(2,0) DEFAULT NULL,
  `Payroll_Year` decimal(4,0) DEFAULT NULL,
  `Payroll_Last_Month` decimal(2,0) DEFAULT NULL,
  `Payroll_Last_Year` decimal(4,0) DEFAULT NULL,
  `Payroll_Undo_Flag` varchar(1) DEFAULT NULL,
  `Loan_Completion_Flag` varchar(1) DEFAULT NULL,
  `Sort_key` varchar(2) DEFAULT NULL,
  `pf_percentage` decimal(10,2) DEFAULT NULL,
  `active_flag` varchar(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `dir_payroll_categories`
--

INSERT INTO `dir_payroll_categories` (`Payroll_Category_code`, `Payroll_Category_name`, `Payroll_Category_abbr`, `Payroll_Month`, `Payroll_Year`, `Payroll_Last_Month`, `Payroll_Last_Year`, `Payroll_Undo_Flag`, `Loan_Completion_Flag`, `Sort_key`, `pf_percentage`, `active_flag`) VALUES
(1, 'Regular Staff', 'All', 5, 2022, 4, 2022, 'N', 'N', 'ZZ', 6.50, 'Y');

-- --------------------------------------------------------

--
-- Table structure for table `dir_pay_grade_areas`
--

CREATE TABLE `dir_pay_grade_areas` (
  `Pay_Grade_Area_Code` int(11) NOT NULL,
  `Pay_Grade_Area_Name` varchar(100) DEFAULT NULL,
  `Sort_Key` varchar(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dir_positions`
--

CREATE TABLE `dir_positions` (
  `Position_Code` int(11) NOT NULL,
  `PositionName` varchar(100) DEFAULT NULL,
  `Position_Active_Flag` char(1) DEFAULT NULL,
  `Position_Active_Date` datetime(6) DEFAULT NULL,
  `PermanentEmp_Code` int(11) DEFAULT NULL,
  `OfficiatingEmp_Code` int(11) DEFAULT NULL,
  `BackupEmp_Code` int(11) DEFAULT NULL,
  `SupervisorPosition_Code` int(11) DEFAULT NULL,
  `Company_Code` int(11) DEFAULT NULL,
  `Desig_code` int(11) DEFAULT NULL,
  `Cost_Centre_Code` int(11) DEFAULT NULL,
  `Section_code` int(11) DEFAULT NULL,
  `Grade_code` int(11) DEFAULT NULL,
  `Loc_Code` int(11) DEFAULT NULL,
  `Default_Workflow_levels_For_Leaves_normal` int(11) DEFAULT NULL,
  `Default_Workflow_levels_For_Leaves_Special` int(11) DEFAULT NULL,
  `Minimum_Salary` int(11) DEFAULT NULL,
  `Maximum_Salary` int(11) DEFAULT NULL,
  `Avg_Salary_in_Market_survey` int(11) DEFAULT NULL,
  `Budgeted_Basic_Salary` int(11) DEFAULT NULL,
  `Budgeted_Other_Salary` int(11) DEFAULT NULL,
  `Assign_Delegation_to_all_subordinate` char(1) DEFAULT NULL,
  `Budgeted_Flag` char(1) DEFAULT NULL,
  `Budget_Type_Name` varchar(100) DEFAULT NULL,
  `Budget_Report_Heading_1` varchar(50) DEFAULT NULL,
  `Budget_Report_Heading_2` varchar(50) DEFAULT NULL,
  `Budget_Report_Heading_3` varchar(50) DEFAULT NULL,
  `Preferable_Gender` char(1) DEFAULT NULL,
  `updated_on` datetime(6) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `SubmitFlag` char(1) DEFAULT NULL,
  `SubmittedOn` datetime(6) DEFAULT NULL,
  `ApprovedFlag` char(1) DEFAULT NULL,
  `ApprovedBy` int(11) DEFAULT NULL,
  `ApprovedOn` datetime(6) DEFAULT NULL,
  `BudgetYear` int(11) DEFAULT NULL,
  `BudgetConfirmFlag` char(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dir_previous_employers`
--

CREATE TABLE `dir_previous_employers` (
  `Employer_Code` int(11) NOT NULL,
  `Employer_Name` varchar(100) DEFAULT NULL,
  `Industry_Flag` varchar(1) DEFAULT NULL,
  `Contact_Name` varchar(50) DEFAULT NULL,
  `Contact_Title` varchar(50) DEFAULT NULL,
  `Address_Line_1` varchar(50) DEFAULT NULL,
  `Address_Line_2` varchar(50) DEFAULT NULL,
  `Telephone_number` varchar(20) DEFAULT NULL,
  `Fax_number` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dir_provinces`
--

CREATE TABLE `dir_provinces` (
  `Province_Code` int(11) DEFAULT NULL,
  `Province_Name` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dir_religions`
--

CREATE TABLE `dir_religions` (
  `Religion_code` int(11) NOT NULL,
  `Religion_name` varchar(30) NOT NULL,
  `Religion_abbr` varchar(6) NOT NULL,
  `Sort_key` varchar(2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `dir_religions`
--

INSERT INTO `dir_religions` (`Religion_code`, `Religion_name`, `Religion_abbr`, `Sort_key`) VALUES
(1, 'ISLAM', 'ISLAM', 'BB'),
(2, 'HINDU', 'HINDU', 'CC'),
(3, 'CHRISTIAN', 'CHRI', 'AA'),
(5, 'Not Applicable', 'NA', 'zz');

-- --------------------------------------------------------

--
-- Table structure for table `dir_resignations`
--

CREATE TABLE `dir_resignations` (
  `Resign_code` int(11) NOT NULL,
  `Resign_reason` varchar(30) NOT NULL,
  `Resign_abbr` varchar(6) NOT NULL,
  `Sort_key` varchar(2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dir_sections`
--

CREATE TABLE `dir_sections` (
  `Section_code` int(11) NOT NULL,
  `Section_name` varchar(100) NOT NULL,
  `Section_abbr` varchar(6) NOT NULL,
  `Dept_code` int(11) NOT NULL,
  `Section_Head` int(11) DEFAULT NULL,
  `Sort_key` varchar(2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `dir_sections`
--

INSERT INTO `dir_sections` (`Section_code`, `Section_name`, `Section_abbr`, `Dept_code`, `Section_Head`, `Sort_key`) VALUES
(1, 'Access', 'NA', 10, 0, 'ZZ'),
(2, 'Administration', 'NA', 11, 0, 'ZZ'),
(3, 'ARKET SUPPORT CD', 'NA', 12, 0, 'ZZ'),
(4, 'BU Onco - I', 'NA', 13, 0, 'ZZ'),
(5, 'BU Onco - II', 'NA', 14, 0, 'ZZ'),
(6, 'CIT Squad', 'NA', 15, 0, 'ZZ'),
(7, 'Communications', 'NA', 16, 0, 'ZZ'),
(8, 'Dia Distribution - Karachi', 'NA', 17, 0, 'ZZ'),
(9, 'Diagnostic Distribution', 'NA', 18, 0, 'ZZ'),
(10, 'Distribution - Islamabad', 'NA', 19, 0, 'ZZ'),
(11, 'Distribution - Karachi', 'NA', 20, 0, 'ZZ'),
(12, 'Distribution - Lahore', 'NA', 21, 0, 'ZZ'),
(13, 'Fin Acct & Controlling - DIA', 'NA', 22, 0, 'ZZ'),
(14, 'Finance', 'NA', 23, 0, 'ZZ'),
(15, 'FMI', 'NA', 24, 0, 'ZZ'),
(16, 'General Services-DIA Head Office', 'NA', 25, 0, 'ZZ'),
(17, 'GS-Indirect Purchase', 'NA', 26, 0, 'ZZ'),
(18, 'P&C', 'NA', 27, 0, 'ZZ'),
(19, 'IT', 'NA', 28, 0, 'ZZ'),
(20, 'IT-DIA SHRD.H.O', 'NA', 29, 0, 'ZZ'),
(21, 'M.SUP.DIA -SHRD.H.O', 'NA', 30, 0, 'ZZ'),
(22, 'MARKET SUPPORT-DC', 'NA', 31, 0, 'ZZ'),
(23, 'MARKET SUPPORT-MD', 'NA', 32, 0, 'ZZ'),
(24, 'Marketing', 'NA', 33, 0, 'ZZ'),
(25, 'Marketing Support Function', 'NA', 34, 0, 'ZZ'),
(26, 'MATPROC & LOGISTICS DIA', 'NA', 35, 0, 'ZZ'),
(27, 'MD', 'NA', 36, 0, 'ZZ'),
(28, 'Medical & Scientific Affairs DIA', 'NA', 37, 0, 'ZZ'),
(29, 'Medical Affairs', 'NA', 38, 0, 'ZZ'),
(30, 'Neurosciences Squad', 'NA', 39, 0, 'ZZ'),
(31, 'PER-KHI DIA OFFICE', 'NA', 40, 0, 'ZZ'),
(32, 'QUALITYREG.& SAFETY AFFRS-DIA', 'NA', 41, 0, 'ZZ'),
(33, 'Regulatory Affairs', 'NA', 42, 0, 'ZZ'),
(34, 'Rheumatology & Anemia', 'NA', 43, 0, 'ZZ'),
(35, 'SALES - DC ISLAMABAD', 'NA', 44, 0, 'ZZ'),
(36, 'SALES - DC KARACHI', 'NA', 45, 0, 'ZZ'),
(37, 'SALES - DC LAHORE', 'NA', 46, 0, 'ZZ'),
(38, 'SALES - DC SHARE.H.O', 'NA', 47, 0, 'ZZ'),
(39, 'SALES - EM & Afghanistan', 'NA', 48, 0, 'ZZ'),
(40, 'SALES - Key Accounts & Commercial', 'NA', 49, 0, 'ZZ'),
(41, 'Sales Dia- MD - Islamabad', 'NA', 50, 0, 'ZZ'),
(42, 'T.E.SERV.DIA-ISL.', 'NA', 51, 0, 'ZZ'),
(43, 'T.E.SERV.DIA-KARACHI', 'NA', 52, 0, 'ZZ'),
(44, 'T.E.SERV.DIA-LAHORE', 'NA', 53, 0, 'ZZ'),
(45, 'Technical Services-Agility', 'NA', 54, 0, 'ZZ'),
(46, 'Technical Services-OE', 'NA', 55, 0, 'ZZ'),
(47, 'Technical Services-Shared', 'NA', 56, 0, 'ZZ'),
(48, 'test', 'test', 23, 0, 'zz'),
(1048, 'Therapeutic Area - I2O & Neuro', 'I2ON', 58, 1192, 'ZZ'),
(1049, 'Therapeutic Area - CIT / Pan T', 'CIT&PT', 14, 1041, 'ZZ'),
(1050, 'Capability, Transformation & D', 'CT&D', 59, 1172, 'ZZ'),
(1051, 'Therapeutic Area - Breast & He', 'B&H', 13, 1192, 'ZZ'),
(1052, 'Compliance', 'Comp', 57, 1205, 'ZZ'),
(1053, 'Business Support', 'BS', 60, 1610, 'ZZ');

-- --------------------------------------------------------

--
-- Table structure for table `dir_setups`
--

CREATE TABLE `dir_setups` (
  `Company_Code` int(11) NOT NULL,
  `Company_name` tinytext DEFAULT NULL,
  `Company_abbr` tinytext DEFAULT NULL,
  `Company_address` text DEFAULT NULL,
  `Company_NTN_no` tinytext DEFAULT NULL,
  `Reporting_Levels` decimal(2,0) DEFAULT NULL,
  `Days_in_month` decimal(2,0) DEFAULT NULL,
  `Hours_in_days` decimal(2,0) DEFAULT NULL,
  `Auto_Emp_Code_Type` tinytext DEFAULT NULL,
  `Payroll_Module_Flag` tinytext DEFAULT NULL,
  `Payroll_Note1` text DEFAULT NULL,
  `Payroll_Note2` text DEFAULT NULL,
  `Payroll_Days_in_month` decimal(2,0) NOT NULL,
  `Payroll_Hours_in_day` decimal(2,0) NOT NULL,
  `Payroll_Overtime_Factor` decimal(4,2) NOT NULL,
  `Payroll_Overtime_Code` int(11) DEFAULT NULL,
  `Payroll_PF_Percentage` decimal(6,3) DEFAULT NULL,
  `Payroll_PF_Code` int(11) DEFAULT NULL,
  `Payroll_IncomeTax_Code` int(11) DEFAULT NULL,
  `Payroll_Meal_Code` int(11) DEFAULT NULL,
  `Overtime_in_Minutes_Flag` tinytext NOT NULL,
  `Leave_in_minutes` decimal(2,0) DEFAULT NULL,
  `Leave_Start_Date` datetime DEFAULT NULL,
  `Leave_End_Date` datetime DEFAULT NULL,
  `Leave_Encashment_code` int(11) DEFAULT NULL,
  `Appraisal_Year` decimal(4,0) DEFAULT NULL,
  `Appraisal_Weight_Use_Flag` tinytext DEFAULT NULL,
  `Appraisal_Increment` decimal(4,2) DEFAULT NULL,
  `Data_Start_Date` datetime DEFAULT NULL,
  `Train_Data_Start_Date` datetime DEFAULT NULL,
  `Sort_key` tinytext DEFAULT NULL,
  `Company_Employee_Code_Limit` int(11) DEFAULT NULL,
  `Leave_Year` decimal(4,0) DEFAULT NULL,
  `Leave_Counter` int(11) DEFAULT NULL,
  `Payroll_Incentive_Code` int(11) DEFAULT NULL,
  `Payroll_EOBI_Code` int(11) DEFAULT NULL,
  `Payroll_Insurance_Code` int(11) DEFAULT NULL,
  `HR_Entry_Stop_Flag` tinytext DEFAULT NULL,
  `PF_Start_Year` decimal(4,0) DEFAULT NULL,
  `PF_Start_Month` decimal(2,0) DEFAULT NULL,
  `JV_Salary_Account` tinytext DEFAULT NULL,
  `Payroll_Sheet_Allow_Col1` tinytext DEFAULT NULL,
  `Payroll_Sheet_Allow_Col2` tinytext DEFAULT NULL,
  `Payroll_Sheet_Allow_Col3` tinytext DEFAULT NULL,
  `Payroll_Sheet_Allow_Col4` tinytext DEFAULT NULL,
  `Payroll_Sheet_Allow_Col5` tinytext DEFAULT NULL,
  `Payroll_Sheet_Allow_Col6` tinytext DEFAULT NULL,
  `Payroll_Sheet_Allow_Col7` tinytext DEFAULT NULL,
  `Payroll_Sheet_Allow_Col8` tinytext DEFAULT NULL,
  `Payroll_Sheet_Allow_Col9` tinytext DEFAULT NULL,
  `Payroll_Sheet_Allow_Col10` tinytext DEFAULT NULL,
  `Payroll_Sheet_Allow_Col11` tinytext DEFAULT NULL,
  `Payroll_Sheet_Allow_Col12` tinytext DEFAULT NULL,
  `Payroll_Sheet_Allow_Col13` tinytext DEFAULT NULL,
  `Payroll_Sheet_Allow_Col14` tinytext DEFAULT NULL,
  `Payroll_Sheet_Allow_Col15` tinytext DEFAULT NULL,
  `Payroll_Sheet_Allow_Col16` tinytext DEFAULT NULL,
  `Payroll_Sheet_Allow_Col17` tinytext DEFAULT NULL,
  `Payroll_Sheet_Allow_Col18` tinytext DEFAULT NULL,
  `Payroll_Sheet_Allow_Col19` tinytext DEFAULT NULL,
  `Payroll_Sheet_Allow_Col20` tinytext DEFAULT NULL,
  `Payroll_Sheet_Allow_Col21` tinytext DEFAULT NULL,
  `Payroll_Sheet_Allow_Col22` tinytext DEFAULT NULL,
  `Payroll_Sheet_Allow_Col23` tinytext DEFAULT NULL,
  `Payroll_Sheet_Allow_Col24` tinytext DEFAULT NULL,
  `Payroll_Sheet_Allow_Col25` tinytext DEFAULT NULL,
  `Payroll_Sheet_Allow_Col26` tinytext DEFAULT NULL,
  `Payroll_Sheet_Allow_Col27` tinytext DEFAULT NULL,
  `Payroll_Sheet_Allow_Col28` tinytext DEFAULT NULL,
  `Payroll_Sheet_Allow_Col29` tinytext DEFAULT NULL,
  `Payroll_Sheet_Allow_Col30` tinytext DEFAULT NULL,
  `Payroll_Sheet_Allow_Col31` tinytext DEFAULT NULL,
  `Payroll_Sheet_Allow_Col32` tinytext DEFAULT NULL,
  `Payroll_Sheet_Allow_Col33` tinytext DEFAULT NULL,
  `Payroll_Sheet_Allow_Col34` tinytext DEFAULT NULL,
  `Payroll_Sheet_Allow_Col35` tinytext DEFAULT NULL,
  `Payroll_Sheet_Allow_Col36` tinytext DEFAULT NULL,
  `Payroll_Sheet_Allow_Col37` tinytext DEFAULT NULL,
  `Payroll_Sheet_Allow_Col38` tinytext DEFAULT NULL,
  `Payroll_Sheet_Allow_Col39` tinytext DEFAULT NULL,
  `Payroll_Sheet_Allow_Col40` tinytext DEFAULT NULL,
  `Payroll_Sheet_Allow_Col41` tinytext DEFAULT NULL,
  `Payroll_Sheet_Allow_Col42` tinytext DEFAULT NULL,
  `Payroll_Sheet_Allow_Col43` tinytext DEFAULT NULL,
  `Payroll_Sheet_Allow_Col44` tinytext DEFAULT NULL,
  `Payroll_Sheet_Allow_Col45` tinytext DEFAULT NULL,
  `Payroll_Sheet_Allow_Col46` tinytext DEFAULT NULL,
  `Payroll_Sheet_Allow_Col47` tinytext DEFAULT NULL,
  `Payroll_Sheet_Allow_Col48` tinytext DEFAULT NULL,
  `Payroll_Sheet_Allow_Col49` tinytext DEFAULT NULL,
  `Payroll_Sheet_Allow_Col50` tinytext DEFAULT NULL,
  `Payroll_Sheet_Ded_Col1` tinytext DEFAULT NULL,
  `Payroll_Sheet_Ded_Col2` tinytext DEFAULT NULL,
  `Payroll_Sheet_Ded_Col3` tinytext DEFAULT NULL,
  `Payroll_Sheet_Ded_Col4` tinytext DEFAULT NULL,
  `Payroll_Sheet_Ded_Col5` tinytext DEFAULT NULL,
  `Payroll_Sheet_Ded_Col6` tinytext DEFAULT NULL,
  `Payroll_Sheet_Ded_Col7` tinytext DEFAULT NULL,
  `Payroll_Sheet_Ded_Col8` tinytext DEFAULT NULL,
  `Payroll_Sheet_Ded_Col9` tinytext DEFAULT NULL,
  `Payroll_Sheet_Ded_Col10` tinytext DEFAULT NULL,
  `Payroll_Sheet_Ded_Col11` tinytext DEFAULT NULL,
  `Payroll_Sheet_Ded_Col12` tinytext DEFAULT NULL,
  `Payroll_Sheet_Ded_Col13` tinytext DEFAULT NULL,
  `Payroll_Sheet_Ded_Col14` tinytext DEFAULT NULL,
  `Payroll_Sheet_Ded_Col15` tinytext DEFAULT NULL,
  `Payroll_Sheet_Ded_Col16` tinytext DEFAULT NULL,
  `Payroll_Sheet_Ded_Col17` tinytext DEFAULT NULL,
  `Payroll_Sheet_Ded_Col18` tinytext DEFAULT NULL,
  `Payroll_Sheet_Ded_Col19` tinytext DEFAULT NULL,
  `Payroll_Sheet_Ded_Col20` tinytext DEFAULT NULL,
  `Payroll_Sheet_Ded_Col21` tinytext DEFAULT NULL,
  `Payroll_Sheet_Ded_Col22` tinytext DEFAULT NULL,
  `Payroll_Sheet_Ded_Col23` tinytext DEFAULT NULL,
  `Payroll_Sheet_Ded_Col24` tinytext DEFAULT NULL,
  `Payroll_Sheet_Ded_Col25` tinytext DEFAULT NULL,
  `Payroll_Sheet_Ded_Col26` tinytext DEFAULT NULL,
  `Payroll_Sheet_Ded_Col27` tinytext DEFAULT NULL,
  `Payroll_Sheet_Ded_Col28` tinytext DEFAULT NULL,
  `Payroll_Sheet_Ded_Col29` tinytext DEFAULT NULL,
  `Payroll_Sheet_Ded_Col30` tinytext DEFAULT NULL,
  `Confirm_Employment_Type_Code` int(11) NOT NULL,
  `MD_Code` int(11) NOT NULL,
  `TM_Code` int(11) DEFAULT NULL,
  `Breakfast_Amount` decimal(4,0) DEFAULT NULL,
  `Lunch_Amount` decimal(4,0) DEFAULT NULL,
  `Dinner_Amount` decimal(4,0) DEFAULT NULL,
  `Payroll_Meal_Overtime_Code` int(11) DEFAULT NULL,
  `Closing_Payroll_Month` int(11) NOT NULL,
  `Closing_Payroll_Year` int(11) DEFAULT NULL,
  `PF_Excess` int(11) NOT NULL,
  `Annual_PF_Percentage` decimal(8,6) DEFAULT NULL,
  `Outgoing_PF_Percentage` decimal(8,6) DEFAULT NULL,
  `TEMP_Entry_Stop_Flag` tinytext NOT NULL,
  `Fuel_Allowance_code` int(11) DEFAULT NULL,
  `Medical_Allowance_code` tinytext DEFAULT NULL,
  `Car_Allowance_code` tinytext DEFAULT NULL,
  `HR_Head` int(11) DEFAULT NULL,
  `Petrol_Code` int(11) DEFAULT NULL,
  `advance_deduction` int(11) DEFAULT NULL,
  `Industry_Name` tinytext DEFAULT NULL,
  `Empr_EOBI_Reg_No` tinytext DEFAULT NULL,
  `SCB_Deposit_date` date DEFAULT NULL,
  `CashAwardCode` int(11) DEFAULT NULL,
  `Emp_Profile_Code` int(11) DEFAULT NULL,
  `Emp_ContractExpiry_Date` datetime DEFAULT NULL,
  `Staff_CadreWise_FromDate` datetime DEFAULT NULL,
  `Retired_to_date` datetime DEFAULT NULL,
  `qualification_date` datetime DEFAULT NULL,
  `resigned_date` datetime DEFAULT NULL,
  `ageWise_date` datetime DEFAULT NULL,
  `from_date_eobi` datetime DEFAULT NULL,
  `to_date_eobi` datetime DEFAULT NULL,
  `to_date_p02` datetime DEFAULT NULL,
  `Confimation_to_date` datetime DEFAULT NULL,
  `dept_wise_loc_code` int(11) DEFAULT NULL,
  `pfdate_individualbasis` date DEFAULT NULL,
  `Profile` tinytext DEFAULT NULL,
  `leave_pro_rate_date` date DEFAULT NULL,
  `final_settlement_emp_code` int(11) DEFAULT NULL,
  `eobi_amount` decimal(18,0) DEFAULT NULL,
  `Wrong_Password_Count` int(11) DEFAULT NULL,
  `Change_Password_Days` int(11) DEFAULT NULL,
  `JV_Flag` tinytext DEFAULT NULL,
  `DateFrom_PerformanceEvaluation` datetime DEFAULT NULL,
  `DateTo_PerformanceEvaluation` datetime DEFAULT NULL,
  `LocationCode_PerformanceEvaluation` int(11) DEFAULT NULL,
  `SectionCode_PerformanceEvaluation` int(11) DEFAULT NULL,
  `AppraisalYearClosedBy` int(11) DEFAULT NULL,
  `AppraisalYearOpenedBy` int(11) DEFAULT NULL,
  `leave_plan_year` int(11) DEFAULT NULL,
  `Emp_Sequence_no` int(11) DEFAULT NULL,
  `ess_block_flag` tinytext DEFAULT NULL,
  `Evening_Allowance_Active_Flag` tinytext DEFAULT NULL,
  `Saturday_Allowance_Active_Flag` tinytext DEFAULT NULL,
  `Sunday_Allowance_Active_Flag` tinytext DEFAULT NULL,
  `latearrivalminutes` int(11) DEFAULT NULL,
  `attendancedate_running` date DEFAULT NULL,
  `Dependents_Attachments_Path` text DEFAULT NULL,
  `MandatoryLeaveYear` int(11) DEFAULT NULL,
  `get_mandatory_leave_note` text DEFAULT NULL,
  `EarlyDeparture` int(11) DEFAULT NULL,
  `Due_confirmation_FromDate` datetime DEFAULT NULL,
  `Due_confirmation_ToDate` datetime DEFAULT NULL,
  `Head_count_report_type` int(11) DEFAULT NULL,
  `Bank_Annexure_slary_hold_flag` tinytext DEFAULT NULL,
  `Mode_Of_Payment` int(11) DEFAULT NULL,
  `Bank_Code` int(11) DEFAULT NULL,
  `Cheque_No` int(11) DEFAULT NULL,
  `countrycode` int(11) DEFAULT NULL,
  `zonecode` int(11) DEFAULT NULL,
  `Current_Account` int(11) DEFAULT NULL,
  `Bank_Address1` tinytext DEFAULT NULL,
  `Bank_Address2` tinytext DEFAULT NULL,
  `Bank_Address3` tinytext DEFAULT NULL,
  `retirementduedate` date DEFAULT NULL,
  `sessi_amount` int(11) DEFAULT NULL,
  `markup` int(11) DEFAULT NULL,
  `BenchMark` int(11) DEFAULT NULL,
  `Govt_Loan_Interest` int(11) DEFAULT NULL,
  `pf_exempted_amount` decimal(12,0) DEFAULT NULL,
  `DashBoard_Year` int(11) DEFAULT NULL,
  `DashBoard_month` int(11) DEFAULT NULL,
  `DashBoard_ProcessFlag` tinytext DEFAULT NULL,
  `current_attendance_uploading_date` datetime DEFAULT NULL,
  `Company_Logo` text DEFAULT NULL,
  `leave_encashment_calculation_Monthly_flag` tinytext DEFAULT NULL,
  `leave_encashment_allowance_code` int(11) DEFAULT NULL,
  `shift_allowance_calculation_Monthly_flag` tinytext DEFAULT NULL,
  `shift_allowance_code` int(11) DEFAULT NULL,
  `mobile_allowance_code` int(11) DEFAULT NULL,
  `Shift_Code_Flag` char(1) DEFAULT NULL,
  `Roster_Group_Flag` char(1) DEFAULT NULL,
  `JV_CostCenter_Flag` char(1) DEFAULT NULL,
  `JV_BalancingCode` tinytext DEFAULT NULL,
  `Leave_code_maternity1` int(11) DEFAULT NULL,
  `Leave_code_maternity2` int(11) DEFAULT NULL,
  `Card_No_Appointment_coloumn` tinytext DEFAULT NULL,
  `PF_Tax_Impact_Flag` tinytext DEFAULT NULL,
  `AutoSalaryBreakupFlag` char(1) DEFAULT NULL,
  `AutoSalaryBreakupBasedOn` char(1) DEFAULT NULL,
  `AutoSalaryBasicToGrossFactor` decimal(3,2) DEFAULT NULL,
  `Geo_Level_1_Lable` tinytext DEFAULT NULL,
  `Geo_Level_2_Lable` tinytext DEFAULT NULL,
  `payroll_overtime_gazitted_holiday_allowance_code` int(11) DEFAULT NULL,
  `Geo_Level_3_Lable` tinytext DEFAULT NULL,
  `GratuityBasedOn` char(1) DEFAULT NULL,
  `GratuityFactor` decimal(3,2) DEFAULT NULL,
  `GratuityEligibiltyYear` int(11) DEFAULT NULL,
  `lfa_union_amount` decimal(12,0) DEFAULT NULL,
  `ESS_GroupCode` int(11) DEFAULT NULL,
  `WebSiteUrl` text DEFAULT NULL,
  `hr_Login_hr_message` text DEFAULT NULL,
  `Hr_Coordinator` int(11) DEFAULT NULL,
  `ESS_ModuleFlag` char(1) DEFAULT NULL,
  `ContractToPermanentNewEmpCodeFlag` char(1) DEFAULT NULL,
  `Tax_City_Name` tinytext DEFAULT NULL,
  `Tax_Date_Of_Issue` datetime DEFAULT NULL,
  `Tax_Company_Issue_Date` datetime DEFAULT NULL,
  `Tax_Authorized_Person` tinytext DEFAULT NULL,
  `Tax_Designation` tinytext DEFAULT NULL,
  `PositionFlag` char(1) DEFAULT NULL,
  `bsc_appraisal_year` int(11) DEFAULT NULL,
  `MultipleCompanyFlag` char(1) DEFAULT NULL,
  `EditionType` char(1) DEFAULT NULL,
  `PF_ModuleFlag` char(1) DEFAULT NULL,
  `LeaveEncashmentFlag` char(1) DEFAULT NULL,
  `LeaveEncashmentCode` int(11) DEFAULT NULL,
  `Gratuity_Code` int(11) DEFAULT NULL,
  `Fleet_PortUrl` tinytext DEFAULT NULL,
  `Travel_PortUrl` tinytext DEFAULT NULL,
  `HRSmart_PortUrl` tinytext DEFAULT NULL,
  `BudgetYear` decimal(4,0) DEFAULT NULL,
  `CompensatoryLeaveFlag` char(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `dir_setups`
--

INSERT INTO `dir_setups` (`Company_Code`, `Company_name`, `Company_abbr`, `Company_address`, `Company_NTN_no`, `Reporting_Levels`, `Days_in_month`, `Hours_in_days`, `Auto_Emp_Code_Type`, `Payroll_Module_Flag`, `Payroll_Note1`, `Payroll_Note2`, `Payroll_Days_in_month`, `Payroll_Hours_in_day`, `Payroll_Overtime_Factor`, `Payroll_Overtime_Code`, `Payroll_PF_Percentage`, `Payroll_PF_Code`, `Payroll_IncomeTax_Code`, `Payroll_Meal_Code`, `Overtime_in_Minutes_Flag`, `Leave_in_minutes`, `Leave_Start_Date`, `Leave_End_Date`, `Leave_Encashment_code`, `Appraisal_Year`, `Appraisal_Weight_Use_Flag`, `Appraisal_Increment`, `Data_Start_Date`, `Train_Data_Start_Date`, `Sort_key`, `Company_Employee_Code_Limit`, `Leave_Year`, `Leave_Counter`, `Payroll_Incentive_Code`, `Payroll_EOBI_Code`, `Payroll_Insurance_Code`, `HR_Entry_Stop_Flag`, `PF_Start_Year`, `PF_Start_Month`, `JV_Salary_Account`, `Payroll_Sheet_Allow_Col1`, `Payroll_Sheet_Allow_Col2`, `Payroll_Sheet_Allow_Col3`, `Payroll_Sheet_Allow_Col4`, `Payroll_Sheet_Allow_Col5`, `Payroll_Sheet_Allow_Col6`, `Payroll_Sheet_Allow_Col7`, `Payroll_Sheet_Allow_Col8`, `Payroll_Sheet_Allow_Col9`, `Payroll_Sheet_Allow_Col10`, `Payroll_Sheet_Allow_Col11`, `Payroll_Sheet_Allow_Col12`, `Payroll_Sheet_Allow_Col13`, `Payroll_Sheet_Allow_Col14`, `Payroll_Sheet_Allow_Col15`, `Payroll_Sheet_Allow_Col16`, `Payroll_Sheet_Allow_Col17`, `Payroll_Sheet_Allow_Col18`, `Payroll_Sheet_Allow_Col19`, `Payroll_Sheet_Allow_Col20`, `Payroll_Sheet_Allow_Col21`, `Payroll_Sheet_Allow_Col22`, `Payroll_Sheet_Allow_Col23`, `Payroll_Sheet_Allow_Col24`, `Payroll_Sheet_Allow_Col25`, `Payroll_Sheet_Allow_Col26`, `Payroll_Sheet_Allow_Col27`, `Payroll_Sheet_Allow_Col28`, `Payroll_Sheet_Allow_Col29`, `Payroll_Sheet_Allow_Col30`, `Payroll_Sheet_Allow_Col31`, `Payroll_Sheet_Allow_Col32`, `Payroll_Sheet_Allow_Col33`, `Payroll_Sheet_Allow_Col34`, `Payroll_Sheet_Allow_Col35`, `Payroll_Sheet_Allow_Col36`, `Payroll_Sheet_Allow_Col37`, `Payroll_Sheet_Allow_Col38`, `Payroll_Sheet_Allow_Col39`, `Payroll_Sheet_Allow_Col40`, `Payroll_Sheet_Allow_Col41`, `Payroll_Sheet_Allow_Col42`, `Payroll_Sheet_Allow_Col43`, `Payroll_Sheet_Allow_Col44`, `Payroll_Sheet_Allow_Col45`, `Payroll_Sheet_Allow_Col46`, `Payroll_Sheet_Allow_Col47`, `Payroll_Sheet_Allow_Col48`, `Payroll_Sheet_Allow_Col49`, `Payroll_Sheet_Allow_Col50`, `Payroll_Sheet_Ded_Col1`, `Payroll_Sheet_Ded_Col2`, `Payroll_Sheet_Ded_Col3`, `Payroll_Sheet_Ded_Col4`, `Payroll_Sheet_Ded_Col5`, `Payroll_Sheet_Ded_Col6`, `Payroll_Sheet_Ded_Col7`, `Payroll_Sheet_Ded_Col8`, `Payroll_Sheet_Ded_Col9`, `Payroll_Sheet_Ded_Col10`, `Payroll_Sheet_Ded_Col11`, `Payroll_Sheet_Ded_Col12`, `Payroll_Sheet_Ded_Col13`, `Payroll_Sheet_Ded_Col14`, `Payroll_Sheet_Ded_Col15`, `Payroll_Sheet_Ded_Col16`, `Payroll_Sheet_Ded_Col17`, `Payroll_Sheet_Ded_Col18`, `Payroll_Sheet_Ded_Col19`, `Payroll_Sheet_Ded_Col20`, `Payroll_Sheet_Ded_Col21`, `Payroll_Sheet_Ded_Col22`, `Payroll_Sheet_Ded_Col23`, `Payroll_Sheet_Ded_Col24`, `Payroll_Sheet_Ded_Col25`, `Payroll_Sheet_Ded_Col26`, `Payroll_Sheet_Ded_Col27`, `Payroll_Sheet_Ded_Col28`, `Payroll_Sheet_Ded_Col29`, `Payroll_Sheet_Ded_Col30`, `Confirm_Employment_Type_Code`, `MD_Code`, `TM_Code`, `Breakfast_Amount`, `Lunch_Amount`, `Dinner_Amount`, `Payroll_Meal_Overtime_Code`, `Closing_Payroll_Month`, `Closing_Payroll_Year`, `PF_Excess`, `Annual_PF_Percentage`, `Outgoing_PF_Percentage`, `TEMP_Entry_Stop_Flag`, `Fuel_Allowance_code`, `Medical_Allowance_code`, `Car_Allowance_code`, `HR_Head`, `Petrol_Code`, `advance_deduction`, `Industry_Name`, `Empr_EOBI_Reg_No`, `SCB_Deposit_date`, `CashAwardCode`, `Emp_Profile_Code`, `Emp_ContractExpiry_Date`, `Staff_CadreWise_FromDate`, `Retired_to_date`, `qualification_date`, `resigned_date`, `ageWise_date`, `from_date_eobi`, `to_date_eobi`, `to_date_p02`, `Confimation_to_date`, `dept_wise_loc_code`, `pfdate_individualbasis`, `Profile`, `leave_pro_rate_date`, `final_settlement_emp_code`, `eobi_amount`, `Wrong_Password_Count`, `Change_Password_Days`, `JV_Flag`, `DateFrom_PerformanceEvaluation`, `DateTo_PerformanceEvaluation`, `LocationCode_PerformanceEvaluation`, `SectionCode_PerformanceEvaluation`, `AppraisalYearClosedBy`, `AppraisalYearOpenedBy`, `leave_plan_year`, `Emp_Sequence_no`, `ess_block_flag`, `Evening_Allowance_Active_Flag`, `Saturday_Allowance_Active_Flag`, `Sunday_Allowance_Active_Flag`, `latearrivalminutes`, `attendancedate_running`, `Dependents_Attachments_Path`, `MandatoryLeaveYear`, `get_mandatory_leave_note`, `EarlyDeparture`, `Due_confirmation_FromDate`, `Due_confirmation_ToDate`, `Head_count_report_type`, `Bank_Annexure_slary_hold_flag`, `Mode_Of_Payment`, `Bank_Code`, `Cheque_No`, `countrycode`, `zonecode`, `Current_Account`, `Bank_Address1`, `Bank_Address2`, `Bank_Address3`, `retirementduedate`, `sessi_amount`, `markup`, `BenchMark`, `Govt_Loan_Interest`, `pf_exempted_amount`, `DashBoard_Year`, `DashBoard_month`, `DashBoard_ProcessFlag`, `current_attendance_uploading_date`, `Company_Logo`, `leave_encashment_calculation_Monthly_flag`, `leave_encashment_allowance_code`, `shift_allowance_calculation_Monthly_flag`, `shift_allowance_code`, `mobile_allowance_code`, `Shift_Code_Flag`, `Roster_Group_Flag`, `JV_CostCenter_Flag`, `JV_BalancingCode`, `Leave_code_maternity1`, `Leave_code_maternity2`, `Card_No_Appointment_coloumn`, `PF_Tax_Impact_Flag`, `AutoSalaryBreakupFlag`, `AutoSalaryBreakupBasedOn`, `AutoSalaryBasicToGrossFactor`, `Geo_Level_1_Lable`, `Geo_Level_2_Lable`, `payroll_overtime_gazitted_holiday_allowance_code`, `Geo_Level_3_Lable`, `GratuityBasedOn`, `GratuityFactor`, `GratuityEligibiltyYear`, `lfa_union_amount`, `ESS_GroupCode`, `WebSiteUrl`, `hr_Login_hr_message`, `Hr_Coordinator`, `ESS_ModuleFlag`, `ContractToPermanentNewEmpCodeFlag`, `Tax_City_Name`, `Tax_Date_Of_Issue`, `Tax_Company_Issue_Date`, `Tax_Authorized_Person`, `Tax_Designation`, `PositionFlag`, `bsc_appraisal_year`, `MultipleCompanyFlag`, `EditionType`, `PF_ModuleFlag`, `LeaveEncashmentFlag`, `LeaveEncashmentCode`, `Gratuity_Code`, `Fleet_PortUrl`, `Travel_PortUrl`, `HRSmart_PortUrl`, `BudgetYear`, `CompensatoryLeaveFlag`) VALUES
(3, 'Roche Pakistan Ltd', 'ROCHE', '1st Floor, 37-B, Block 6, P.E.C.H.S. P.O. Box 20021 Karachi 75400', 'NA', 1, 30, 8, 'M', 'Y', 'NA', 'NA', 30, 8, 2.00, 12, 6.500, 68, 70, 9, 'Y', 5, '2004-01-01 00:00:00', '2004-01-01 00:00:00', 0, 2016, 'Y', 1.00, '2004-01-01 00:00:00', '2004-01-01 00:00:00', 'ZZ', 0, 2022, 2, 0, 76, 0, 'Y', 2005, 1, '', 'BASE SALARY', 'CAR ALLOW.', 'CONVEYANCE  ', 'SPECIAL ALL.', 'MOBILE ALL.', 'ASSIGNMENT ALL', 'AWARD', 'COMPENSATORY', 'ENTERTAINMENT', 'EQUIPMENT MAI', 'EX-GRATIA\r\n', 'ANNUAL BONUS', 'SALES INCENTIVE', 'LEAVE ENCASH', 'LONG SERVICE', '', 'RELOCATION / PER DAY ', 'MARRIAGE GIFT\r\n', 'Loans', 'MISC PAYMENT', '', '', '', '', '', '', '', '', '', '', '', '', '', '          ', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 'PF ', 'PF VOLUNTEER', 'INCOME TAX', 'EOBI', 'DCPF', 'FURNISHING LOA', 'HOUSING ASS.\r\n', 'HOUSEBUILD(I)\r\n', 'HOUSEBUILD(M)\r\n', 'MEAL CHARGES\r\n', 'PENSION CON.\r\n', 'PF LOAN(I)\r\n', 'PF LOAN(M)\r\n', 'ROCHE CON.', 'PROFESSIONTAX\r\n', 'TRANSFER BE', 'VEHICLE LOAN\r\n', 'PENSIO', 'MISC DED.', '', '', '', '', '', '', '', '', '', '', '', 1, 71322, 71484, 40, 65, 65, 22, 4, 2022, 33, 1.220000, 0.000000, '', 124, '0', '0', 1543, 124, 28, 'Total Banking Exp.(Yrs.):', 'AAE-01775', '2017-07-31', 7, 1001, '2019-12-01 00:00:00', '2016-01-01 00:00:00', '2015-12-31 00:00:00', '2019-01-12 00:00:00', '2020-09-01 00:00:00', '2017-02-24 00:00:00', '2012-05-01 00:00:00', '2012-05-31 00:00:00', '2019-04-30 00:00:00', '2015-11-30 00:00:00', -1, '2016-12-31', 'C', '2016-12-31', 5047, 130, 10000, 10000, 'Y', '2016-01-01 00:00:00', '2016-12-31 00:00:00', 1000, 1000, 26, NULL, 2017, NULL, 'Y', 'Y', 'Y', 'Y', 0, '2018-02-13', 'D:SummitBankEmployeesScannedFileTarget_new', 2017, 'mandatory leave notessasdasdasdas', 0, '2019-10-01 00:00:00', '2020-02-28 00:00:00', NULL, NULL, 4, 4, 0, NULL, NULL, NULL, NULL, NULL, NULL, '2030-12-31', 20, 85, 33, 10, 150000, 2020, 1, 'A', '2019-12-26 09:11:52', '?PNG\r\n\Z\n\0\0\0\rIHDR\0\0\0?\0\0\0?\0\0\03蔨\0\0\0rPLTE???\0z?\0r?\0t?\0n??????????\0w?\0u?\0p?\0l???ܓ?ކ?٠?????W????????0??????????????C????????L?̚??i?Ӻ??\Z??x??f??&??\0e?r???^\0\0	?IDATx???ق?8??.????j;??_qZ?!d?xQ??x?`??Ԗ??FAAAAAAAAAAAALc?.???M\"\'l<????%??????dH??q??]??o$_Ù@???ָ?s???\0La\n%?~%???k?C?_?a??M????$???%.`??????ƻ??????<?*?????5؃?<??b???????z?????Q~?p??ݝ9D=z?8??]??=N???[??\Z???????????~<H:?????[?\\a??=??y߁b??D?<H?????s????5D??Z????c???M????}??-?????V=?3-?d??FӾ?\nx? \'\\?=???? (m???:??M??{^?GN?=?w?=d???yk?z2\\=???d-=?2Q^~ؔ?*Aβ?i?K???h? n?@b5g?G????Nk?_?/?HL?Z`??(N???2?g?.?im7?????R՘??w?P??F}W-????zK]?8~??\\I\'?܃?ڔ3c?\Z\n???cA????\rc?F???`?P??E?@?<f?\n=5?\\???????7???B]5rW??A&?G?\ZS??b?y?@??Ʀ!n??T?,i?d\r:%_?5\Z?????vY?\"???\Z?x?????q??<?T!???6?Dp?_??d????Gn?D???/Wb???i????癰p??e????Vhܤ??%?G??ט???a?/?v?6?e???s̒ ~M?(\n\"?K)o??q???h???par???xe!?? ?oc?[????ˆ??qϠ?7|???X??i[?쉋?????XT^?胪o?B+?n??V????7,?Z????}E?m??KE|(?t|-ԯ}??,6?u^C???%??Vrw?ͮ?ܖ?z?㰸.?/Ӗ	m?7?m??????ӫ=y???c?~?؆??A?WT|[?0?3??-?qÿ?n?????6??\nq?Uےt3?,?\r???????gGyOp?????<ńX???&7?#[?\Z????\'?|`????L`?襁/?U?F?BG|????Q? ?U??????p\r???[E9?7|j???<RƯ??h]iK??Fl?U<lpV?7??Zrq??W???9?U>n?&??ƶ[?-+5?3?\"?ΰ?????T\Zׄj\r???5\n?*>8>0zmɾ???c9?S?}?Pâf?n?!??ƳɆ??9??jd???ʶ?J?:*9??????L]Ty???T????u28?Y?\r?\n??\r|????;Ң#?凋?Ac??.??\Z?9??>-m??]]m??????n.j\n??]?7?6?????s[W????????ݭJZ???\r?H??P???m???&?`?^?8?Nֲ??q? ?8{?L#?\0??{?Y	\Z????(???F??C\\???CI#?2W?Q>+?x????J#<Ga??%?tL\\]?X??C??V9kw_9o?e????F??Ϥ???9?ҋWƊ???y(?K?F1G?c??z??eK??i????m???R???:???k\Z??i??<?W?o??CyRS??W?Q??g??/h?_?^u23???q/?2)??$?????5HA???p??-x?zDBָ????#?C,?B?Ƌ??mLk!*Ѽ??Y\"YcE??<?<br??l҈1??wSE?鴛;x??rV??1???7_b^?	Ӷ??l\Za?ʄ???_?Ԉ?\ZҺ?t?8??/ZU7x~ca?Im??@?d?8???`?cM??!????9?i?	???[?(?r?o??/?JBCcԈpAB?#Q?Y?J??(\\ɚƫ8?m?óZ?öݹ?:?\ZobD?)?r??m?\n?? P??+&?:\\e<,?pK????G???:??5????u?x➸???K\r?\n}a???Q??b^#?C??Gvf?7^p\rc?.TZ??:T3?S??q%\Z???Z?(?\Zy5??Lٹ?pY?????L(\"?1??*???6???b?8??˔?M?N??DK???H^?? ?>??b??b?k????|$ai?p?Rc??,Տy???rgU:?ǜh]??]?k??????J??,????????-??{????x???Wq??&????h?????2U???-?55}6I?/?I*m:??9??0?j??$Z?ë?!?҃?????zҩ?g??? 3?Szx??i???A_??ԼS??l+?MC\\??9B??r	&Z??n?tJ?=?\Z?tJ?=?\Z\ZH?:?w?H?tJO????(??cI??a:????֛i?N???h?F??\"?h?[?Sֻy??O?J????h?????????\Z?׷?????\'pw??K?:>+?⑉??#??Dk?-??㰣?&:?Sz>&???N???D??{:??3-/锞OH?<?Sz&\r????tJ?Љ?[?a-?锞A?6?Sm????D^?)=ի?o?-???????ך??~??N?I??@$>~?э?`?M\"AAAAAAAAAAAA???7???\0\0\0\0IEND?B`?', '', 3, '', 8, 9, 'Y', 'Y', '', '8430202-003 SINDH BANK LTD. (MAIN A/C)', NULL, NULL, 'Y', 'Y', '', 'B', 1.65, 'Branch', 'Area', NULL, 'Regio', 'B', 1.50, 3, NULL, NULL, NULL, 'Welcome To Roche Pakistan Limited', 1543, 'Y', '', 'Karachi', '2019-07-15 00:00:00', '2019-07-15 00:00:00', 'Junaid Siddiqui', 'HR Manager', '', 2020, '', 'S', 'Y', 'Y', 13, 31, '', '', '', 2021, '');

-- --------------------------------------------------------

--
-- Table structure for table `dir_shifts`
--

CREATE TABLE `dir_shifts` (
  `Shift_code` int(11) NOT NULL,
  `Shift_Name` varchar(30) NOT NULL,
  `Shift_abbr` varchar(6) NOT NULL,
  `TIME_IN_HH` decimal(2,0) DEFAULT NULL,
  `TIME_IN_MM` decimal(2,0) DEFAULT NULL,
  `TIME_OUT_HH` decimal(2,0) DEFAULT NULL,
  `TIME_OUT_MM` decimal(2,0) DEFAULT NULL,
  `FRI_TIME_IN_HH` decimal(2,0) DEFAULT NULL,
  `FRI_TIME_IN_MM` decimal(2,0) DEFAULT NULL,
  `FRI_TIME_OUT_HH` decimal(2,0) DEFAULT NULL,
  `FRI_TIME_OUT_MM` decimal(2,0) DEFAULT NULL,
  `SAT_TIME_IN_HH` decimal(2,0) DEFAULT NULL,
  `SAT_TIME_IN_MM` decimal(2,0) DEFAULT NULL,
  `SAT_TIME_OUT_HH` decimal(2,0) DEFAULT NULL,
  `SAT_TIME_OUT_MM` decimal(2,0) DEFAULT NULL,
  `SUN_TIME_IN_HH` decimal(2,0) DEFAULT NULL,
  `SUN_TIME_IN_MM` decimal(2,0) DEFAULT NULL,
  `SUN_TIME_OUT_HH` decimal(2,0) DEFAULT NULL,
  `SUN_TIME_OUT_MM` decimal(2,0) DEFAULT NULL,
  `RAMADAN_TIME_IN_HH` decimal(2,0) DEFAULT NULL,
  `RAMADAN_TIME_IN_MM` decimal(2,0) DEFAULT NULL,
  `RAMADAN_TIME_OUT_HH` decimal(2,0) DEFAULT NULL,
  `RAMADAN_TIME_OUT_MM` decimal(2,0) DEFAULT NULL,
  `RAMADAN_FRI_TIME_IN_HH` decimal(2,0) DEFAULT NULL,
  `RAMADAN_FRI_TIME_IN_MM` decimal(2,0) DEFAULT NULL,
  `RAMADAN_FRI_TIME_OUT_HH` decimal(2,0) DEFAULT NULL,
  `RAMADAN_FRI_TIME_OUT_MM` decimal(2,0) DEFAULT NULL,
  `RAMADAN_SAT_TIME_IN_HH` decimal(2,0) DEFAULT NULL,
  `RAMADAN_SAT_TIME_IN_MM` decimal(2,0) DEFAULT NULL,
  `RAMADAN_SAT_TIME_OUT_HH` decimal(2,0) DEFAULT NULL,
  `RAMADAN_SAT_TIME_OUT_MM` decimal(2,0) DEFAULT NULL,
  `RAMADAN_SUN_TIME_IN_HH` decimal(2,0) DEFAULT NULL,
  `RAMADAN_SUN_TIME_IN_MM` decimal(2,0) DEFAULT NULL,
  `RAMADAN_SUN_TIME_OUT_HH` decimal(2,0) DEFAULT NULL,
  `RAMADAN_SUN_TIME_OUT_MM` decimal(2,0) DEFAULT NULL,
  `GRACE_TIME_IUT_MM` decimal(2,0) DEFAULT NULL,
  `GRACE_TIME_OUT_MM` decimal(2,0) DEFAULT NULL,
  `half_day_time_in_hh` decimal(2,0) DEFAULT NULL,
  `half_day_time_in_mm` decimal(2,0) DEFAULT NULL,
  `SORT_KEY` varchar(2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `dir_shifts`
--

INSERT INTO `dir_shifts` (`Shift_code`, `Shift_Name`, `Shift_abbr`, `TIME_IN_HH`, `TIME_IN_MM`, `TIME_OUT_HH`, `TIME_OUT_MM`, `FRI_TIME_IN_HH`, `FRI_TIME_IN_MM`, `FRI_TIME_OUT_HH`, `FRI_TIME_OUT_MM`, `SAT_TIME_IN_HH`, `SAT_TIME_IN_MM`, `SAT_TIME_OUT_HH`, `SAT_TIME_OUT_MM`, `SUN_TIME_IN_HH`, `SUN_TIME_IN_MM`, `SUN_TIME_OUT_HH`, `SUN_TIME_OUT_MM`, `RAMADAN_TIME_IN_HH`, `RAMADAN_TIME_IN_MM`, `RAMADAN_TIME_OUT_HH`, `RAMADAN_TIME_OUT_MM`, `RAMADAN_FRI_TIME_IN_HH`, `RAMADAN_FRI_TIME_IN_MM`, `RAMADAN_FRI_TIME_OUT_HH`, `RAMADAN_FRI_TIME_OUT_MM`, `RAMADAN_SAT_TIME_IN_HH`, `RAMADAN_SAT_TIME_IN_MM`, `RAMADAN_SAT_TIME_OUT_HH`, `RAMADAN_SAT_TIME_OUT_MM`, `RAMADAN_SUN_TIME_IN_HH`, `RAMADAN_SUN_TIME_IN_MM`, `RAMADAN_SUN_TIME_OUT_HH`, `RAMADAN_SUN_TIME_OUT_MM`, `GRACE_TIME_IUT_MM`, `GRACE_TIME_OUT_MM`, `half_day_time_in_hh`, `half_day_time_in_mm`, `SORT_KEY`) VALUES
(1, 'General', 'Gen', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'ZZ');

-- --------------------------------------------------------

--
-- Table structure for table `dir_tax_certificate`
--

CREATE TABLE `dir_tax_certificate` (
  `tax_certificate_id` int(11) NOT NULL,
  `year` int(11) DEFAULT NULL,
  `month` char(10) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `date_of_deposit` datetime(3) DEFAULT NULL,
  `tresury` varchar(20) DEFAULT NULL,
  `challan` varchar(40) DEFAULT NULL,
  `BranchName` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `final_temp_attendances`
--

CREATE TABLE `final_temp_attendances` (
  `Emp_Code` int(11) DEFAULT NULL,
  `emp_id` varchar(20) DEFAULT NULL,
  `Attendance_HH` int(11) DEFAULT NULL,
  `Attendance_MM` int(11) DEFAULT NULL,
  `Attendance_Date` datetime DEFAULT NULL,
  `Time_In_Out_Flag` int(11) DEFAULT NULL,
  `Origional_Data` varchar(40) DEFAULT NULL,
  `Origional_Date` date DEFAULT NULL,
  `id` int(11) NOT NULL,
  `company_code` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `history_appointments`
--

CREATE TABLE `history_appointments` (
  `Emp_Code` int(11) NOT NULL,
  `Transaction_Date` datetime NOT NULL,
  `Emp_name` varchar(30) NOT NULL,
  `Emp_Father_name` varchar(30) NOT NULL,
  `Emp_sex_code` varchar(1) NOT NULL,
  `Emp_marital_status` varchar(1) NOT NULL,
  `Emp_birth_date` datetime NOT NULL,
  `Emp_appointment_date` datetime NOT NULL,
  `Emp_confirm_date` datetime NOT NULL,
  `Emp_Catery` int(11) NOT NULL,
  `Emp_Leave_Catery` int(11) NOT NULL,
  `Emp_address_line1` varchar(200) DEFAULT NULL,
  `Emp_address_line2` varchar(100) DEFAULT NULL,
  `Emp_home_tel1` varchar(15) DEFAULT NULL,
  `Emp_home_tel2` varchar(15) DEFAULT NULL,
  `Emp_office_tel1` varchar(15) DEFAULT NULL,
  `Emp_office_tel2` varchar(15) DEFAULT NULL,
  `Emp_mobile_No` varchar(20) DEFAULT NULL,
  `Emp_nic_no` varchar(30) DEFAULT NULL,
  `Emp_nic_issue_date` date DEFAULT NULL,
  `Emp_nic_expiry_date` date DEFAULT NULL,
  `Emp_retirement_age` int(11) DEFAULT NULL,
  `Emp_ntn_no` varchar(15) DEFAULT NULL,
  `Emp_email` varchar(70) DEFAULT NULL,
  `Confirmation_Flag` varchar(1) NOT NULL,
  `Empt_Type_code` int(11) NOT NULL,
  `Desig_code` int(11) NOT NULL,
  `Grade_code` int(11) NOT NULL,
  `Cost_Centre_code` int(11) NOT NULL,
  `Dept_code` int(11) NOT NULL,
  `Loc_code` int(11) NOT NULL,
  `Edu_code` int(11) NOT NULL,
  `Transport_code` int(11) NOT NULL,
  `Supervisor_Code` int(11) DEFAULT NULL,
  `Religion_Code` int(11) DEFAULT NULL,
  `Section_code` int(11) NOT NULL,
  `Shift_code` int(11) NOT NULL,
  `Deletion_Flag` varchar(1) DEFAULT NULL,
  `Emp_Payroll_Catery` int(11) NOT NULL,
  `Mode_Of_Payment` int(11) NOT NULL,
  `Account_type1` varchar(1) NOT NULL,
  `Bank_Account_No1` varchar(30) NOT NULL,
  `Branch_Code1` int(11) NOT NULL,
  `Bank_Amount_1` decimal(7,0) NOT NULL,
  `Bank_Percent_1` decimal(3,0) NOT NULL,
  `Account_type2` varchar(1) NOT NULL,
  `Bank_Account_No2` varchar(20) NOT NULL,
  `Branch_Code2` int(11) NOT NULL,
  `Bank_Amount_2` decimal(7,0) NOT NULL,
  `Bank_Percent_2` decimal(3,0) NOT NULL,
  `Account_type3` varchar(1) NOT NULL,
  `Bank_Account_No3` varchar(20) NOT NULL,
  `Branch_Code3` int(11) NOT NULL,
  `Bank_Amount_3` decimal(7,0) NOT NULL,
  `Bank_Percent_3` decimal(3,0) NOT NULL,
  `Account_type4` varchar(1) NOT NULL,
  `Bank_Account_No4` varchar(20) NOT NULL,
  `Branch_Code4` int(11) NOT NULL,
  `Bank_Amount_4` decimal(7,0) NOT NULL,
  `Bank_Percent_4` decimal(3,0) NOT NULL,
  `SESSI_Flag` varchar(1) NOT NULL,
  `EOBI_Flag` varchar(1) NOT NULL,
  `Union_Flag` varchar(1) NOT NULL,
  `Recreation_Club_Flag` varchar(1) NOT NULL,
  `Meal_Deduction_Flag` varchar(1) NOT NULL,
  `Overtime_Flag` varchar(1) NOT NULL,
  `Incentive_Flag` varchar(1) NOT NULL,
  `Bonus_Type` varchar(30) DEFAULT NULL,
  `Contact_Person_Name` varchar(30) NOT NULL,
  `Relationship` varchar(15) NOT NULL,
  `Contact_address1` varchar(40) NOT NULL,
  `Contact_address2` varchar(40) NOT NULL,
  `Contact_home_tel1` varchar(20) DEFAULT NULL,
  `Contact_home_tel2` varchar(20) DEFAULT NULL,
  `Emp_Blood_Group` varchar(4) NOT NULL,
  `EOBI_Number` varchar(20) NOT NULL,
  `SESSI_Number` varchar(20) NOT NULL,
  `Vehicle_Registration_Number` varchar(100) NOT NULL,
  `Status` varchar(30) DEFAULT NULL,
  `Interest_Flag` varchar(1) NOT NULL,
  `Zakat_Flag` varchar(1) NOT NULL,
  `Picture_image` text DEFAULT NULL,
  `Emp_id` varchar(50) DEFAULT NULL,
  `Offer_Letter_date` date DEFAULT NULL,
  `Tentative_Joining_date` date DEFAULT NULL,
  `RefferedBy` varchar(50) DEFAULT NULL,
  `Probationary_period_months` int(11) DEFAULT NULL,
  `Notice_period_months` int(11) DEFAULT NULL,
  `Extended_confirmation_days` int(11) DEFAULT NULL,
  `Permanent_address` varchar(200) DEFAULT NULL,
  `Nationality` varchar(50) DEFAULT NULL,
  `roster_group_code` int(11) DEFAULT NULL,
  `card_no` varchar(50) DEFAULT NULL,
  `ContractExpiryDate` datetime DEFAULT NULL,
  `Position_Code` int(11) DEFAULT NULL,
  `Company_Code` int(11) DEFAULT NULL,
  `id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `history_attendances`
--

CREATE TABLE `history_attendances` (
  `Emp_Code` int(11) NOT NULL,
  `Attendance_Date` datetime NOT NULL,
  `Shift_Code` int(11) NOT NULL,
  `Shift_Time_In_HH` int(11) NOT NULL,
  `Shift_Time_In_MM` int(11) NOT NULL,
  `Shift_Time_Out_HH` int(11) NOT NULL,
  `Shift_Time_Out_MM` int(11) NOT NULL,
  `Emp_Time_In_HH` int(11) NOT NULL,
  `Emp_Time_In_MM` int(11) NOT NULL,
  `Emp_Time_Out_HH` int(11) NOT NULL,
  `Emp_Time_Out_MM` int(11) NOT NULL,
  `Emp_Time_In_HH_On_Date` int(11) NOT NULL,
  `Emp_Time_In_MM_On_Date` int(11) NOT NULL,
  `Emp_Time_Out_HH_On_Date` int(11) NOT NULL,
  `Emp_Time_Out_MM_On_Date` int(11) NOT NULL,
  `Manual_Flag` varchar(1) NOT NULL,
  `Manual_Reason` varchar(200) DEFAULT NULL,
  `CreatedBy` int(11) NOT NULL,
  `CreatedOn` datetime NOT NULL,
  `UpdatedBy` int(11) NOT NULL,
  `UpdatedOn` datetime NOT NULL,
  `In_City_FLag` varchar(1) DEFAULT NULL,
  `Compensatory_leave_flag` varchar(1) DEFAULT NULL,
  `leave_type_code` int(11) DEFAULT NULL,
  `ShiftGroupCode` int(11) DEFAULT NULL,
  `Dual_Shift_Flag` varchar(1) DEFAULT NULL,
  `Section_code` int(11) DEFAULT NULL,
  `Dept_code` int(11) DEFAULT NULL,
  `Loc_code` int(11) DEFAULT NULL,
  `Desig_code` int(11) DEFAULT NULL,
  `Grade_code` int(11) DEFAULT NULL,
  `Ramdan_FLag` varchar(1) DEFAULT NULL,
  `Leave_days` decimal(10,3) DEFAULT NULL,
  `Half_day_flag` varchar(1) DEFAULT NULL,
  `Half_day_process_flag` varchar(1) DEFAULT NULL,
  `Half_day_remarks` varchar(200) DEFAULT NULL,
  `Late_arrival_flag` varchar(1) DEFAULT NULL,
  `Late_arrival_process_flag` varchar(1) DEFAULT NULL,
  `Late_arrival_remarks` varchar(200) DEFAULT NULL,
  `Early_departure_flag` varchar(1) DEFAULT NULL,
  `Early_departure_process_flag` varchar(1) DEFAULT NULL,
  `Early_departure_remarks` varchar(200) DEFAULT NULL,
  `System_flag` varchar(1) DEFAULT NULL,
  `Gazited_holiday_flag` varchar(1) DEFAULT NULL,
  `Brachwise_holiday_flag` varchar(1) DEFAULT NULL,
  `Overtime_Flag` varchar(1) DEFAULT NULL,
  `Emp_Orignal_Company_Time_In_HH` int(11) DEFAULT NULL,
  `Emp_Orignal_Company_Time_In_MM` int(11) DEFAULT NULL,
  `Emp_Orignal_Company_Time_Out_HH` int(11) DEFAULT NULL,
  `Emp_Orignal_Company_Time_Out_MM` int(11) DEFAULT NULL,
  `Tran_Code_Late_Arrival` int(11) DEFAULT NULL,
  `Tran_code_Early_Departure` int(11) DEFAULT NULL,
  `Tran_code_Overtime` int(11) DEFAULT NULL,
  `Total_Shift_MM` int(11) DEFAULT NULL,
  `id` int(11) NOT NULL,
  `company_code` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `history_educations`
--

CREATE TABLE `history_educations` (
  `ControlNo` int(11) NOT NULL,
  `Emp_code` int(11) NOT NULL,
  `ESS_Sr_No` int(11) DEFAULT NULL,
  `Edu_code` int(11) NOT NULL,
  `Edu_year` varchar(20) DEFAULT NULL,
  `Edu_Grade` varchar(50) DEFAULT NULL,
  `Top_flag` varchar(1) DEFAULT NULL,
  `Institution_Code` int(11) DEFAULT NULL,
  `Major_OtherSubjects` varchar(50) DEFAULT NULL,
  `FileName` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `history_experiences`
--

CREATE TABLE `history_experiences` (
  `Sr_ExperianceCode` int(11) NOT NULL,
  `Emp_code` int(11) NOT NULL,
  `Sequence_no` int(11) NOT NULL,
  `Designation` varchar(100) NOT NULL,
  `Start_date` datetime(6) NOT NULL,
  `End_date` datetime(6) NOT NULL,
  `Employer_Code` int(11) DEFAULT NULL,
  `Department` varchar(50) DEFAULT NULL,
  `Sent_Flag` varchar(1) DEFAULT NULL,
  `Sent_Date` date DEFAULT NULL,
  `Recieve_Flag` varchar(1) DEFAULT NULL,
  `Recieve_Date` date DEFAULT NULL,
  `No_Of_reminder` int(11) DEFAULT NULL,
  `remarks` varchar(1000) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `linkusermenusaccess`
--

CREATE TABLE `linkusermenusaccess` (
  `usercode` int(11) DEFAULT NULL,
  `menucode` int(11) DEFAULT NULL,
  `id` int(11) NOT NULL,
  `company_code` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `linkusermenusaccess`
--

INSERT INTO `linkusermenusaccess` (`usercode`, `menucode`, `id`, `company_code`) VALUES
(0, 1000, 512, 1),
(0, 1100, 513, 1),
(0, 1101, 514, 1),
(0, 1102, 515, 1),
(0, 1103, 516, 1),
(0, 1104, 517, 1),
(0, 1105, 518, 1),
(0, 1200, 519, 1),
(0, 1300, 520, 1),
(0, 1301, 521, 1),
(0, 1302, 522, 1),
(0, 1303, 523, 1),
(0, 1304, 524, 1),
(0, 1305, 525, 1),
(0, 1306, 526, 1),
(0, 1400, 527, 1),
(0, 1401, 528, 1),
(0, 1403, 529, 1),
(0, 1404, 530, 1),
(0, 1405, 531, 1),
(0, 1500, 532, 1),
(0, 1501, 533, 1),
(0, 1600, 534, 1),
(0, 1601, 535, 1),
(0, 1602, 536, 1),
(0, 1603, 537, 1),
(0, 2000, 538, 1),
(0, 2100, 539, 1),
(0, 2101, 540, 1),
(0, 2102, 541, 1),
(0, 2103, 542, 1),
(0, 2104, 543, 1),
(0, 2105, 544, 1),
(0, 2106, 545, 1),
(0, 2107, 546, 1),
(0, 2109, 547, 1),
(0, 2110, 548, 1),
(0, 2111, 549, 1),
(0, 2112, 550, 1),
(0, 2113, 551, 1),
(0, 2114, 552, 1),
(0, 2115, 553, 1),
(0, 2116, 554, 1),
(0, 2117, 555, 1),
(0, 2118, 556, 1),
(0, 2119, 557, 1),
(0, 2120, 558, 1),
(0, 2121, 559, 1),
(0, 2122, 560, 1),
(0, 2123, 561, 1),
(0, 2124, 562, 1),
(0, 2125, 563, 1),
(0, 2126, 564, 1),
(0, 2127, 565, 1),
(0, 2128, 566, 1),
(0, 2129, 567, 1),
(0, 2130, 568, 1),
(0, 2131, 569, 1),
(0, 2132, 570, 1),
(0, 2133, 571, 1),
(0, 2134, 572, 1),
(0, 2135, 573, 1),
(0, 2136, 574, 1),
(0, 2137, 575, 1),
(0, 2138, 576, 1),
(0, 2139, 577, 1),
(0, 2140, 578, 1),
(0, 2141, 579, 1),
(0, 2142, 580, 1),
(0, 2143, 581, 1),
(0, 2144, 582, 1),
(0, 2145, 583, 1),
(0, 2146, 584, 1),
(0, 2147, 585, 1),
(0, 2148, 586, 1),
(0, 2149, 587, 1),
(0, 2150, 588, 1),
(0, 2151, 589, 1),
(0, 2152, 590, 1),
(0, 2153, 591, 1),
(0, 2154, 592, 1),
(0, 2155, 593, 1),
(0, 2156, 594, 1),
(0, 2157, 595, 1),
(0, 2158, 596, 1),
(0, 2159, 597, 1),
(0, 2160, 598, 1),
(0, 2161, 599, 1),
(0, 2175, 600, 1),
(0, 2176, 601, 1),
(0, 2177, 602, 1),
(0, 2178, 603, 1),
(0, 2179, 604, 1),
(0, 2180, 605, 1),
(0, 2181, 606, 1),
(0, 2182, 607, 1),
(0, 2183, 608, 1),
(0, 2184, 609, 1),
(0, 2185, 610, 1),
(0, 2186, 611, 1),
(0, 2187, 612, 1),
(0, 2200, 613, 1),
(0, 2201, 614, 1),
(0, 2202, 615, 1),
(0, 2203, 616, 1),
(0, 2204, 617, 1),
(0, 2205, 618, 1),
(0, 2206, 619, 1),
(0, 2300, 620, 1),
(0, 2301, 621, 1),
(0, 2302, 622, 1),
(0, 2303, 623, 1),
(0, 2304, 624, 1),
(0, 2305, 625, 1),
(0, 2306, 626, 1),
(0, 2307, 627, 1),
(0, 2308, 628, 1),
(0, 2309, 629, 1),
(0, 2310, 630, 1),
(0, 2311, 631, 1),
(0, 2312, 632, 1),
(0, 2313, 633, 1),
(0, 2314, 634, 1),
(0, 2315, 635, 1),
(0, 2317, 636, 1),
(0, 2318, 637, 1),
(0, 2319, 638, 1),
(0, 2320, 639, 1),
(0, 2321, 640, 1),
(0, 2322, 641, 1),
(0, 2323, 642, 1),
(0, 2324, 643, 1),
(0, 2400, 644, 1),
(0, 2401, 645, 1),
(0, 2402, 646, 1),
(0, 2403, 647, 1),
(0, 2404, 648, 1),
(0, 2405, 649, 1),
(0, 2406, 650, 1),
(0, 2407, 651, 1),
(0, 2408, 652, 1),
(0, 2409, 653, 1),
(0, 2410, 654, 1),
(0, 2411, 655, 1),
(0, 2412, 656, 1),
(0, 2413, 657, 1),
(0, 2414, 658, 1),
(0, 2415, 659, 1),
(0, 2416, 660, 1),
(0, 2417, 661, 1),
(0, 2418, 662, 1),
(0, 2419, 663, 1),
(0, 2420, 664, 1),
(0, 2421, 665, 1),
(0, 2422, 666, 1),
(0, 2423, 667, 1),
(0, 2424, 668, 1),
(0, 2425, 669, 1),
(0, 2426, 670, 1),
(0, 2427, 671, 1),
(0, 2428, 672, 1),
(0, 2429, 673, 1),
(0, 2430, 674, 1),
(0, 2431, 675, 1),
(0, 2432, 676, 1),
(0, 2433, 677, 1),
(0, 2434, 678, 1),
(0, 2435, 679, 1),
(0, 2436, 680, 1),
(0, 2437, 681, 1),
(0, 2438, 682, 1),
(0, 2500, 683, 1),
(0, 2501, 684, 1),
(0, 2502, 685, 1),
(0, 2503, 686, 1),
(0, 2504, 687, 1),
(0, 2505, 688, 1),
(0, 2506, 689, 1),
(0, 2507, 690, 1),
(0, 2508, 691, 1),
(0, 2509, 692, 1),
(0, 2510, 693, 1),
(0, 2511, 694, 1),
(0, 2512, 695, 1),
(0, 2513, 696, 1),
(0, 2550, 697, 1),
(0, 2551, 698, 1),
(0, 2552, 699, 1),
(0, 2553, 700, 1),
(0, 2554, 701, 1),
(0, 2555, 702, 1),
(0, 2556, 703, 1),
(0, 2557, 704, 1),
(0, 2558, 705, 1),
(0, 2559, 706, 1),
(0, 2560, 707, 1),
(0, 2561, 708, 1),
(0, 2562, 709, 1),
(0, 2563, 710, 1),
(0, 2564, 711, 1),
(0, 2565, 712, 1),
(0, 2566, 713, 1),
(0, 2600, 714, 1),
(0, 2601, 715, 1),
(0, 2602, 716, 1),
(0, 2603, 717, 1),
(0, 2604, 718, 1),
(0, 2640, 719, 1),
(0, 2641, 720, 1),
(0, 2642, 721, 1),
(0, 2643, 722, 1),
(0, 2644, 723, 1),
(0, 2645, 724, 1),
(0, 2646, 725, 1),
(0, 2647, 726, 1),
(0, 2648, 727, 1),
(0, 2649, 728, 1),
(0, 2650, 729, 1),
(0, 2651, 730, 1),
(0, 2652, 731, 1),
(0, 2653, 732, 1),
(0, 2654, 733, 1),
(0, 2655, 734, 1),
(0, 2656, 735, 1),
(0, 2657, 736, 1),
(0, 2658, 737, 1),
(0, 2659, 738, 1),
(0, 2660, 739, 1),
(0, 2661, 740, 1),
(0, 2662, 741, 1),
(0, 2663, 742, 1),
(0, 2664, 743, 1),
(0, 2665, 744, 1),
(0, 2666, 745, 1),
(0, 2667, 746, 1),
(0, 2668, 747, 1),
(0, 2669, 748, 1),
(0, 2670, 749, 1),
(0, 2671, 750, 1),
(0, 2672, 751, 1),
(0, 2673, 752, 1),
(0, 2674, 753, 1),
(0, 2675, 754, 1),
(0, 2676, 755, 1),
(0, 2700, 756, 1),
(0, 2701, 757, 1),
(0, 2702, 758, 1),
(0, 2703, 759, 1),
(0, 2704, 760, 1),
(0, 2740, 761, 1),
(0, 2741, 762, 1),
(0, 2742, 763, 1),
(0, 2744, 764, 1),
(0, 2745, 765, 1),
(0, 2746, 766, 1),
(0, 2747, 767, 1),
(0, 2748, 768, 1),
(0, 2749, 769, 1),
(0, 2750, 770, 1),
(0, 2780, 771, 1),
(0, 2781, 772, 1),
(0, 2782, 773, 1),
(0, 2783, 774, 1),
(0, 2800, 775, 1),
(0, 2840, 776, 1),
(0, 2841, 777, 1),
(0, 2842, 778, 1),
(0, 5000, 779, 1),
(0, 5100, 780, 1),
(0, 5101, 781, 1),
(0, 5102, 782, 1),
(0, 5103, 783, 1),
(0, 5104, 784, 1),
(0, 5105, 785, 1),
(0, 5106, 786, 1),
(0, 5107, 787, 1),
(0, 5108, 788, 1),
(0, 5109, 789, 1),
(0, 5110, 790, 1),
(0, 5111, 791, 1),
(0, 5112, 792, 1),
(0, 5113, 793, 1),
(0, 5114, 794, 1),
(0, 5115, 795, 1),
(0, 5116, 796, 1),
(0, 5117, 797, 1),
(0, 5118, 798, 1),
(0, 5119, 799, 1),
(0, 5120, 800, 1),
(0, 5200, 801, 1),
(0, 5201, 802, 1),
(0, 5202, 803, 1),
(0, 5203, 804, 1),
(0, 5204, 805, 1),
(0, 5205, 806, 1),
(0, 5206, 807, 1),
(0, 5207, 808, 1),
(0, 5208, 809, 1),
(0, 5209, 810, 1),
(0, 5210, 811, 1),
(0, 5211, 812, 1),
(0, 5212, 813, 1),
(0, 5213, 814, 1),
(0, 5214, 815, 1),
(0, 5215, 816, 1),
(0, 5216, 817, 1),
(0, 5217, 818, 1),
(0, 5218, 819, 1),
(0, 5219, 820, 1),
(0, 5220, 821, 1),
(0, 5221, 822, 1),
(0, 5222, 823, 1),
(0, 5223, 824, 1),
(0, 5224, 825, 1),
(0, 5225, 826, 1),
(0, 5226, 827, 1),
(0, 5230, 828, 1),
(0, 5231, 829, 1),
(0, 5232, 830, 1),
(0, 5233, 831, 1),
(0, 5234, 832, 1),
(0, 5235, 833, 1),
(0, 5236, 834, 1),
(0, 5237, 835, 1),
(0, 5238, 836, 1),
(0, 5239, 837, 1),
(0, 5240, 838, 1),
(0, 5241, 839, 1),
(0, 5242, 840, 1),
(0, 5243, 841, 1),
(0, 5244, 842, 1),
(0, 5245, 843, 1),
(0, 5246, 844, 1),
(0, 5247, 845, 1),
(0, 5248, 846, 1),
(0, 5249, 847, 1),
(0, 5250, 848, 1),
(0, 5251, 849, 1),
(0, 5252, 850, 1),
(0, 5260, 851, 1),
(0, 5270, 852, 1),
(0, 5271, 853, 1),
(0, 5272, 854, 1),
(0, 5273, 855, 1),
(0, 5274, 856, 1),
(0, 5276, 857, 1),
(0, 5290, 858, 1),
(0, 5300, 859, 1),
(0, 5301, 860, 1),
(0, 5302, 861, 1),
(0, 5303, 862, 1),
(0, 5304, 863, 1),
(0, 5305, 864, 1),
(0, 5306, 865, 1),
(0, 5307, 866, 1),
(0, 5308, 867, 1),
(0, 5309, 868, 1),
(0, 5310, 869, 1),
(0, 5311, 870, 1),
(0, 5312, 871, 1),
(0, 5313, 872, 1),
(0, 5314, 873, 1),
(0, 5315, 874, 1),
(0, 5316, 875, 1),
(0, 5317, 876, 1),
(0, 5318, 877, 1),
(0, 5319, 878, 1),
(0, 5350, 879, 1),
(0, 5351, 880, 1),
(0, 5352, 881, 1),
(0, 5353, 882, 1),
(0, 5354, 883, 1),
(0, 5380, 884, 1),
(0, 5381, 885, 1),
(0, 5382, 886, 1),
(0, 5383, 887, 1),
(0, 5384, 888, 1),
(0, 5385, 889, 1),
(0, 5400, 890, 1),
(0, 5401, 891, 1),
(0, 5402, 892, 1),
(0, 5403, 893, 1),
(0, 5404, 894, 1),
(0, 5405, 895, 1),
(0, 5406, 896, 1),
(0, 5407, 897, 1),
(0, 5408, 898, 1),
(0, 5430, 899, 1),
(0, 5431, 900, 1),
(0, 5432, 901, 1),
(0, 5433, 902, 1),
(0, 5434, 903, 1),
(0, 5435, 904, 1),
(0, 5460, 905, 1),
(0, 5461, 906, 1),
(0, 5462, 907, 1),
(0, 5463, 908, 1),
(0, 5464, 909, 1),
(0, 5465, 910, 1),
(0, 5466, 911, 1),
(0, 5467, 912, 1),
(0, 5468, 913, 1),
(0, 5469, 914, 1),
(0, 5470, 915, 1),
(0, 5471, 916, 1),
(0, 5472, 917, 1),
(0, 5473, 918, 1),
(0, 5474, 919, 1),
(0, 5475, 920, 1),
(0, 5476, 921, 1),
(0, 5477, 922, 1),
(0, 5500, 923, 1),
(0, 5501, 924, 1),
(0, 5502, 925, 1),
(0, 5503, 926, 1),
(0, 5504, 927, 1),
(0, 5505, 928, 1),
(0, 5506, 929, 1),
(0, 5507, 930, 1),
(0, 5530, 931, 1),
(0, 5531, 932, 1),
(0, 5532, 933, 1),
(0, 5533, 934, 1),
(0, 5534, 935, 1),
(0, 5550, 936, 1),
(0, 5551, 937, 1),
(0, 5552, 938, 1),
(0, 5600, 939, 1),
(0, 5601, 940, 1),
(0, 5620, 941, 1),
(0, 5621, 942, 1),
(0, 5622, 943, 1),
(0, 5623, 944, 1),
(0, 5624, 945, 1),
(0, 5625, 946, 1),
(0, 5626, 947, 1),
(0, 5627, 948, 1),
(0, 5628, 949, 1),
(0, 5700, 950, 1),
(0, 5771, 951, 1),
(0, 8000, 952, 1),
(0, 8100, 953, 1),
(0, 8101, 954, 1),
(0, 8102, 955, 1),
(0, 8103, 956, 1),
(0, 8104, 957, 1),
(0, 8105, 958, 1),
(0, 8106, 959, 1),
(0, 12000, 960, 1),
(0, 12100, 961, 1),
(0, 12101, 962, 1),
(0, 12102, 963, 1),
(0, 12200, 964, 1),
(0, 12201, 965, 1),
(0, 12202, 966, 1),
(0, 12203, 967, 1),
(0, 12550, 968, 1),
(0, 12567, 969, 1),
(0, 12568, 970, 1),
(0, 13000, 971, 1),
(0, 13001, 972, 1),
(0, 13002, 973, 1),
(0, 13003, 974, 1),
(0, 13004, 975, 1),
(0, 99999, 976, 1),
(1, 1000, 1023, 2),
(1, 1100, 1024, 2),
(1, 1101, 1025, 2),
(1, 1102, 1026, 2),
(1, 1103, 1027, 2),
(1, 1104, 1028, 2),
(1, 1105, 1029, 2),
(1, 1200, 1030, 2),
(1, 1300, 1031, 2),
(1, 1301, 1032, 2),
(1, 1302, 1033, 2),
(1, 1303, 1034, 2),
(1, 1304, 1035, 2),
(1, 1305, 1036, 2),
(1, 1306, 1037, 2),
(1, 1400, 1038, 2),
(1, 1401, 1039, 2),
(1, 1403, 1040, 2),
(1, 1404, 1041, 2),
(1, 1405, 1042, 2),
(1, 1500, 1043, 2),
(1, 1501, 1044, 2),
(1, 1600, 1045, 2),
(1, 1601, 1046, 2),
(1, 1602, 1047, 2),
(1, 1603, 1048, 2),
(1, 2000, 1049, 2),
(1, 2100, 1050, 2),
(1, 2101, 1051, 2),
(1, 2102, 1052, 2),
(1, 2103, 1053, 2),
(1, 2104, 1054, 2),
(1, 2105, 1055, 2),
(1, 2106, 1056, 2),
(1, 2107, 1057, 2),
(1, 2109, 1058, 2),
(1, 2110, 1059, 2),
(1, 2111, 1060, 2),
(1, 2112, 1061, 2),
(1, 2113, 1062, 2),
(1, 2114, 1063, 2),
(1, 2115, 1064, 2),
(1, 2116, 1065, 2),
(1, 2117, 1066, 2),
(1, 2118, 1067, 2),
(1, 2119, 1068, 2),
(1, 2120, 1069, 2),
(1, 2121, 1070, 2),
(1, 2122, 1071, 2),
(1, 2123, 1072, 2),
(1, 2124, 1073, 2),
(1, 2125, 1074, 2),
(1, 2126, 1075, 2),
(1, 2127, 1076, 2),
(1, 2128, 1077, 2),
(1, 2129, 1078, 2),
(1, 2130, 1079, 2),
(1, 2131, 1080, 2),
(1, 2132, 1081, 2),
(1, 2133, 1082, 2),
(1, 2134, 1083, 2),
(1, 2135, 1084, 2),
(1, 2136, 1085, 2),
(1, 2137, 1086, 2),
(1, 2138, 1087, 2),
(1, 2139, 1088, 2),
(1, 2140, 1089, 2),
(1, 2141, 1090, 2),
(1, 2142, 1091, 2),
(1, 2143, 1092, 2),
(1, 2144, 1093, 2),
(1, 2145, 1094, 2),
(1, 2146, 1095, 2),
(1, 2147, 1096, 2),
(1, 2148, 1097, 2),
(1, 2149, 1098, 2),
(1, 2150, 1099, 2),
(1, 2151, 1100, 2),
(1, 2152, 1101, 2),
(1, 2153, 1102, 2),
(1, 2154, 1103, 2),
(1, 2155, 1104, 2),
(1, 2156, 1105, 2),
(1, 2157, 1106, 2),
(1, 2158, 1107, 2),
(1, 2159, 1108, 2),
(1, 2160, 1109, 2),
(1, 2161, 1110, 2),
(1, 2175, 1111, 2),
(1, 2176, 1112, 2),
(1, 2177, 1113, 2),
(1, 2178, 1114, 2),
(1, 2179, 1115, 2),
(1, 2180, 1116, 2),
(1, 2181, 1117, 2),
(1, 2182, 1118, 2),
(1, 2183, 1119, 2),
(1, 2184, 1120, 2),
(1, 2185, 1121, 2),
(1, 2186, 1122, 2),
(1, 2187, 1123, 2),
(1, 2200, 1124, 2),
(1, 2201, 1125, 2),
(1, 2202, 1126, 2),
(1, 2203, 1127, 2),
(1, 2204, 1128, 2),
(1, 2205, 1129, 2),
(1, 2206, 1130, 2),
(1, 2300, 1131, 2),
(1, 2301, 1132, 2),
(1, 2302, 1133, 2),
(1, 2303, 1134, 2),
(1, 2304, 1135, 2),
(1, 2305, 1136, 2),
(1, 2306, 1137, 2),
(1, 2307, 1138, 2),
(1, 2308, 1139, 2),
(1, 2309, 1140, 2),
(1, 2310, 1141, 2),
(1, 2311, 1142, 2),
(1, 2312, 1143, 2),
(1, 2313, 1144, 2),
(1, 2314, 1145, 2),
(1, 2315, 1146, 2),
(1, 2317, 1147, 2),
(1, 2318, 1148, 2),
(1, 2319, 1149, 2),
(1, 2320, 1150, 2),
(1, 2321, 1151, 2),
(1, 2322, 1152, 2),
(1, 2323, 1153, 2),
(1, 2324, 1154, 2),
(1, 2400, 1155, 2),
(1, 2401, 1156, 2),
(1, 2402, 1157, 2),
(1, 2403, 1158, 2),
(1, 2404, 1159, 2),
(1, 2405, 1160, 2),
(1, 2406, 1161, 2),
(1, 2407, 1162, 2),
(1, 2408, 1163, 2),
(1, 2409, 1164, 2),
(1, 2410, 1165, 2),
(1, 2411, 1166, 2),
(1, 2412, 1167, 2),
(1, 2413, 1168, 2),
(1, 2414, 1169, 2),
(1, 2415, 1170, 2),
(1, 2416, 1171, 2),
(1, 2417, 1172, 2),
(1, 2418, 1173, 2),
(1, 2419, 1174, 2),
(1, 2420, 1175, 2),
(1, 2421, 1176, 2),
(1, 2422, 1177, 2),
(1, 2423, 1178, 2),
(1, 2424, 1179, 2),
(1, 2425, 1180, 2),
(1, 2426, 1181, 2),
(1, 2427, 1182, 2),
(1, 2428, 1183, 2),
(1, 2429, 1184, 2),
(1, 2430, 1185, 2),
(1, 2431, 1186, 2),
(1, 2432, 1187, 2),
(1, 2433, 1188, 2),
(1, 2434, 1189, 2),
(1, 2435, 1190, 2),
(1, 2436, 1191, 2),
(1, 2437, 1192, 2),
(1, 2438, 1193, 2),
(1, 2500, 1194, 2),
(1, 2501, 1195, 2),
(1, 2502, 1196, 2),
(1, 2503, 1197, 2),
(1, 2504, 1198, 2),
(1, 2505, 1199, 2),
(1, 2506, 1200, 2),
(1, 2507, 1201, 2),
(1, 2508, 1202, 2),
(1, 2509, 1203, 2),
(1, 2510, 1204, 2),
(1, 2511, 1205, 2),
(1, 2512, 1206, 2),
(1, 2513, 1207, 2),
(1, 2550, 1208, 2),
(1, 2551, 1209, 2),
(1, 2552, 1210, 2),
(1, 2553, 1211, 2),
(1, 2554, 1212, 2),
(1, 2555, 1213, 2),
(1, 2556, 1214, 2),
(1, 2557, 1215, 2),
(1, 2558, 1216, 2),
(1, 2559, 1217, 2),
(1, 2560, 1218, 2),
(1, 2561, 1219, 2),
(1, 2562, 1220, 2),
(1, 2563, 1221, 2),
(1, 2564, 1222, 2),
(1, 2565, 1223, 2),
(1, 2566, 1224, 2),
(1, 2600, 1225, 2),
(1, 2601, 1226, 2),
(1, 2602, 1227, 2),
(1, 2603, 1228, 2),
(1, 2604, 1229, 2),
(1, 2640, 1230, 2),
(1, 2641, 1231, 2),
(1, 2642, 1232, 2),
(1, 2643, 1233, 2),
(1, 2644, 1234, 2),
(1, 2645, 1235, 2),
(1, 2646, 1236, 2),
(1, 2647, 1237, 2),
(1, 2648, 1238, 2),
(1, 2649, 1239, 2),
(1, 2650, 1240, 2),
(1, 2651, 1241, 2),
(1, 2652, 1242, 2),
(1, 2653, 1243, 2),
(1, 2654, 1244, 2),
(1, 2655, 1245, 2),
(1, 2656, 1246, 2),
(1, 2657, 1247, 2),
(1, 2658, 1248, 2),
(1, 2659, 1249, 2),
(1, 2660, 1250, 2),
(1, 2661, 1251, 2),
(1, 2662, 1252, 2),
(1, 2663, 1253, 2),
(1, 2664, 1254, 2),
(1, 2665, 1255, 2),
(1, 2666, 1256, 2),
(1, 2667, 1257, 2),
(1, 2668, 1258, 2),
(1, 2669, 1259, 2),
(1, 2670, 1260, 2),
(1, 2671, 1261, 2),
(1, 2672, 1262, 2),
(1, 2673, 1263, 2),
(1, 2674, 1264, 2),
(1, 2675, 1265, 2),
(1, 2676, 1266, 2),
(1, 2700, 1267, 2),
(1, 2701, 1268, 2),
(1, 2702, 1269, 2),
(1, 2703, 1270, 2),
(1, 2704, 1271, 2),
(1, 2740, 1272, 2),
(1, 2741, 1273, 2),
(1, 2742, 1274, 2),
(1, 2744, 1275, 2),
(1, 2745, 1276, 2),
(1, 2746, 1277, 2),
(1, 2747, 1278, 2),
(1, 2748, 1279, 2),
(1, 2749, 1280, 2),
(1, 2750, 1281, 2),
(1, 2780, 1282, 2),
(1, 2781, 1283, 2),
(1, 2782, 1284, 2),
(1, 2783, 1285, 2),
(1, 2800, 1286, 2),
(1, 2840, 1287, 2),
(1, 2841, 1288, 2),
(1, 2842, 1289, 2),
(1, 5000, 1290, 2),
(1, 5100, 1291, 2),
(1, 5101, 1292, 2),
(1, 5102, 1293, 2),
(1, 5103, 1294, 2),
(1, 5104, 1295, 2),
(1, 5105, 1296, 2),
(1, 5106, 1297, 2),
(1, 5107, 1298, 2),
(1, 5108, 1299, 2),
(1, 5109, 1300, 2),
(1, 5110, 1301, 2),
(1, 5111, 1302, 2),
(1, 5112, 1303, 2),
(1, 5113, 1304, 2),
(1, 5114, 1305, 2),
(1, 5115, 1306, 2),
(1, 5116, 1307, 2),
(1, 5117, 1308, 2),
(1, 5118, 1309, 2),
(1, 5119, 1310, 2),
(1, 5120, 1311, 2),
(1, 5200, 1312, 2),
(1, 5201, 1313, 2),
(1, 5202, 1314, 2),
(1, 5203, 1315, 2),
(1, 5204, 1316, 2),
(1, 5205, 1317, 2),
(1, 5206, 1318, 2),
(1, 5207, 1319, 2),
(1, 5208, 1320, 2),
(1, 5209, 1321, 2),
(1, 5210, 1322, 2),
(1, 5211, 1323, 2),
(1, 5212, 1324, 2),
(1, 5213, 1325, 2),
(1, 5214, 1326, 2),
(1, 5215, 1327, 2),
(1, 5216, 1328, 2),
(1, 5217, 1329, 2),
(1, 5218, 1330, 2),
(1, 5219, 1331, 2),
(1, 5220, 1332, 2),
(1, 5221, 1333, 2),
(1, 5222, 1334, 2),
(1, 5223, 1335, 2),
(1, 5224, 1336, 2),
(1, 5225, 1337, 2),
(1, 5226, 1338, 2),
(1, 5230, 1339, 2),
(1, 5231, 1340, 2),
(1, 5232, 1341, 2),
(1, 5233, 1342, 2),
(1, 5234, 1343, 2),
(1, 5235, 1344, 2),
(1, 5236, 1345, 2),
(1, 5237, 1346, 2),
(1, 5238, 1347, 2),
(1, 5239, 1348, 2),
(1, 5240, 1349, 2),
(1, 5241, 1350, 2),
(1, 5242, 1351, 2),
(1, 5243, 1352, 2),
(1, 5244, 1353, 2),
(1, 5245, 1354, 2),
(1, 5246, 1355, 2),
(1, 5247, 1356, 2),
(1, 5248, 1357, 2),
(1, 5249, 1358, 2),
(1, 5250, 1359, 2),
(1, 5251, 1360, 2),
(1, 5252, 1361, 2),
(1, 5260, 1362, 2),
(1, 5270, 1363, 2),
(1, 5271, 1364, 2),
(1, 5272, 1365, 2),
(1, 5273, 1366, 2),
(1, 5274, 1367, 2),
(1, 5276, 1368, 2),
(1, 5290, 1369, 2),
(1, 5300, 1370, 2),
(1, 5301, 1371, 2),
(1, 5302, 1372, 2),
(1, 5303, 1373, 2),
(1, 5304, 1374, 2),
(1, 5305, 1375, 2),
(1, 5306, 1376, 2),
(1, 5307, 1377, 2),
(1, 5308, 1378, 2),
(1, 5309, 1379, 2),
(1, 5310, 1380, 2),
(1, 5311, 1381, 2),
(1, 5312, 1382, 2),
(1, 5313, 1383, 2),
(1, 5314, 1384, 2),
(1, 5315, 1385, 2),
(1, 5316, 1386, 2),
(1, 5317, 1387, 2),
(1, 5318, 1388, 2),
(1, 5319, 1389, 2),
(1, 5350, 1390, 2),
(1, 5351, 1391, 2),
(1, 5352, 1392, 2),
(1, 5353, 1393, 2),
(1, 5354, 1394, 2),
(1, 5380, 1395, 2),
(1, 5381, 1396, 2),
(1, 5382, 1397, 2),
(1, 5383, 1398, 2),
(1, 5384, 1399, 2),
(1, 5385, 1400, 2),
(1, 5400, 1401, 2),
(1, 5401, 1402, 2),
(1, 5402, 1403, 2),
(1, 5403, 1404, 2),
(1, 5404, 1405, 2),
(1, 5405, 1406, 2),
(1, 5406, 1407, 2),
(1, 5407, 1408, 2),
(1, 5408, 1409, 2),
(1, 5430, 1410, 2),
(1, 5431, 1411, 2),
(1, 5432, 1412, 2),
(1, 5433, 1413, 2),
(1, 5434, 1414, 2),
(1, 5435, 1415, 2),
(1, 5460, 1416, 2),
(1, 5461, 1417, 2),
(1, 5462, 1418, 2),
(1, 5463, 1419, 2),
(1, 5464, 1420, 2),
(1, 5465, 1421, 2),
(1, 5466, 1422, 2),
(1, 5467, 1423, 2),
(1, 5468, 1424, 2),
(1, 5469, 1425, 2),
(1, 5470, 1426, 2),
(1, 5471, 1427, 2),
(1, 5472, 1428, 2),
(1, 5473, 1429, 2),
(1, 5474, 1430, 2),
(1, 5475, 1431, 2),
(1, 5476, 1432, 2),
(1, 5477, 1433, 2),
(1, 5500, 1434, 2),
(1, 5501, 1435, 2),
(1, 5502, 1436, 2),
(1, 5503, 1437, 2),
(1, 5504, 1438, 2),
(1, 5505, 1439, 2),
(1, 5506, 1440, 2),
(1, 5507, 1441, 2),
(1, 5530, 1442, 2),
(1, 5531, 1443, 2),
(1, 5532, 1444, 2),
(1, 5533, 1445, 2),
(1, 5534, 1446, 2),
(1, 5550, 1447, 2),
(1, 5551, 1448, 2),
(1, 5552, 1449, 2),
(1, 5600, 1450, 2),
(1, 5601, 1451, 2),
(1, 5620, 1452, 2),
(1, 5621, 1453, 2),
(1, 5622, 1454, 2),
(1, 5623, 1455, 2),
(1, 5624, 1456, 2),
(1, 5625, 1457, 2),
(1, 5626, 1458, 2),
(1, 5627, 1459, 2),
(1, 5628, 1460, 2),
(1, 5700, 1461, 2),
(1, 5771, 1462, 2),
(1, 8000, 1463, 2),
(1, 8100, 1464, 2),
(1, 8101, 1465, 2),
(1, 8102, 1466, 2),
(1, 8103, 1467, 2),
(1, 8104, 1468, 2),
(1, 8105, 1469, 2),
(1, 8106, 1470, 2),
(1, 12000, 1471, 2),
(1, 12100, 1472, 2),
(1, 12101, 1473, 2),
(1, 12102, 1474, 2),
(1, 12200, 1475, 2),
(1, 12201, 1476, 2),
(1, 12202, 1477, 2),
(1, 12203, 1478, 2),
(1, 12550, 1479, 2),
(1, 12567, 1480, 2),
(1, 12568, 1481, 2),
(1, 13000, 1482, 2),
(1, 13001, 1483, 2),
(1, 13002, 1484, 2),
(1, 13003, 1485, 2),
(1, 13004, 1486, 2),
(1, 99999, 1487, 2),
(2, 1000, 1534, 3),
(2, 1100, 1535, 3),
(2, 1101, 1536, 3),
(2, 1102, 1537, 3),
(2, 1103, 1538, 3),
(2, 1104, 1539, 3),
(2, 1105, 1540, 3),
(2, 1200, 1541, 3),
(2, 1300, 1542, 3),
(2, 1301, 1543, 3),
(2, 1302, 1544, 3),
(2, 1303, 1545, 3),
(2, 1304, 1546, 3),
(2, 1305, 1547, 3),
(2, 1306, 1548, 3),
(2, 1400, 1549, 3),
(2, 1401, 1550, 3),
(2, 1403, 1551, 3),
(2, 1404, 1552, 3),
(2, 1405, 1553, 3),
(2, 1500, 1554, 3),
(2, 1501, 1555, 3),
(2, 1600, 1556, 3),
(2, 1601, 1557, 3),
(2, 1602, 1558, 3),
(2, 1603, 1559, 3),
(2, 2000, 1560, 3),
(2, 2100, 1561, 3),
(2, 2101, 1562, 3),
(2, 2102, 1563, 3),
(2, 2103, 1564, 3),
(2, 2104, 1565, 3),
(2, 2105, 1566, 3),
(2, 2106, 1567, 3),
(2, 2107, 1568, 3),
(2, 2109, 1569, 3),
(2, 2110, 1570, 3),
(2, 2111, 1571, 3),
(2, 2112, 1572, 3),
(2, 2113, 1573, 3),
(2, 2114, 1574, 3),
(2, 2115, 1575, 3),
(2, 2116, 1576, 3),
(2, 2117, 1577, 3),
(2, 2118, 1578, 3),
(2, 2119, 1579, 3),
(2, 2120, 1580, 3),
(2, 2121, 1581, 3),
(2, 2122, 1582, 3),
(2, 2123, 1583, 3),
(2, 2124, 1584, 3),
(2, 2125, 1585, 3),
(2, 2126, 1586, 3),
(2, 2127, 1587, 3),
(2, 2128, 1588, 3),
(2, 2129, 1589, 3),
(2, 2130, 1590, 3),
(2, 2131, 1591, 3),
(2, 2132, 1592, 3),
(2, 2133, 1593, 3),
(2, 2134, 1594, 3),
(2, 2135, 1595, 3),
(2, 2136, 1596, 3),
(2, 2137, 1597, 3),
(2, 2138, 1598, 3),
(2, 2139, 1599, 3),
(2, 2140, 1600, 3),
(2, 2141, 1601, 3),
(2, 2142, 1602, 3),
(2, 2143, 1603, 3),
(2, 2144, 1604, 3),
(2, 2145, 1605, 3),
(2, 2146, 1606, 3),
(2, 2147, 1607, 3),
(2, 2148, 1608, 3),
(2, 2149, 1609, 3),
(2, 2150, 1610, 3),
(2, 2151, 1611, 3),
(2, 2152, 1612, 3),
(2, 2153, 1613, 3),
(2, 2154, 1614, 3),
(2, 2155, 1615, 3),
(2, 2156, 1616, 3),
(2, 2157, 1617, 3),
(2, 2158, 1618, 3),
(2, 2159, 1619, 3),
(2, 2160, 1620, 3),
(2, 2161, 1621, 3),
(2, 2175, 1622, 3),
(2, 2176, 1623, 3),
(2, 2177, 1624, 3),
(2, 2178, 1625, 3),
(2, 2179, 1626, 3),
(2, 2180, 1627, 3),
(2, 2181, 1628, 3),
(2, 2182, 1629, 3),
(2, 2183, 1630, 3),
(2, 2184, 1631, 3),
(2, 2185, 1632, 3),
(2, 2186, 1633, 3),
(2, 2187, 1634, 3),
(2, 2200, 1635, 3),
(2, 2201, 1636, 3),
(2, 2202, 1637, 3),
(2, 2203, 1638, 3),
(2, 2204, 1639, 3),
(2, 2205, 1640, 3),
(2, 2206, 1641, 3),
(2, 2300, 1642, 3),
(2, 2301, 1643, 3),
(2, 2302, 1644, 3),
(2, 2303, 1645, 3),
(2, 2304, 1646, 3),
(2, 2305, 1647, 3),
(2, 2306, 1648, 3),
(2, 2307, 1649, 3),
(2, 2308, 1650, 3),
(2, 2309, 1651, 3),
(2, 2310, 1652, 3),
(2, 2311, 1653, 3),
(2, 2312, 1654, 3),
(2, 2313, 1655, 3),
(2, 2314, 1656, 3),
(2, 2315, 1657, 3),
(2, 2317, 1658, 3),
(2, 2318, 1659, 3),
(2, 2319, 1660, 3),
(2, 2320, 1661, 3),
(2, 2321, 1662, 3),
(2, 2322, 1663, 3),
(2, 2323, 1664, 3),
(2, 2324, 1665, 3),
(2, 2400, 1666, 3),
(2, 2401, 1667, 3),
(2, 2402, 1668, 3),
(2, 2403, 1669, 3),
(2, 2404, 1670, 3),
(2, 2405, 1671, 3),
(2, 2406, 1672, 3),
(2, 2407, 1673, 3),
(2, 2408, 1674, 3),
(2, 2409, 1675, 3),
(2, 2410, 1676, 3),
(2, 2411, 1677, 3),
(2, 2412, 1678, 3),
(2, 2413, 1679, 3),
(2, 2414, 1680, 3),
(2, 2415, 1681, 3),
(2, 2416, 1682, 3),
(2, 2417, 1683, 3),
(2, 2418, 1684, 3),
(2, 2419, 1685, 3),
(2, 2420, 1686, 3),
(2, 2421, 1687, 3),
(2, 2422, 1688, 3),
(2, 2423, 1689, 3),
(2, 2424, 1690, 3),
(2, 2425, 1691, 3),
(2, 2426, 1692, 3),
(2, 2427, 1693, 3),
(2, 2428, 1694, 3),
(2, 2429, 1695, 3),
(2, 2430, 1696, 3),
(2, 2431, 1697, 3),
(2, 2432, 1698, 3),
(2, 2433, 1699, 3),
(2, 2434, 1700, 3),
(2, 2435, 1701, 3),
(2, 2436, 1702, 3),
(2, 2437, 1703, 3),
(2, 2438, 1704, 3),
(2, 2500, 1705, 3),
(2, 2501, 1706, 3),
(2, 2502, 1707, 3),
(2, 2503, 1708, 3),
(2, 2504, 1709, 3),
(2, 2505, 1710, 3),
(2, 2506, 1711, 3),
(2, 2507, 1712, 3),
(2, 2508, 1713, 3),
(2, 2509, 1714, 3),
(2, 2510, 1715, 3),
(2, 2511, 1716, 3),
(2, 2512, 1717, 3),
(2, 2513, 1718, 3),
(2, 2550, 1719, 3),
(2, 2551, 1720, 3),
(2, 2552, 1721, 3),
(2, 2553, 1722, 3),
(2, 2554, 1723, 3),
(2, 2555, 1724, 3),
(2, 2556, 1725, 3),
(2, 2557, 1726, 3),
(2, 2558, 1727, 3),
(2, 2559, 1728, 3),
(2, 2560, 1729, 3),
(2, 2561, 1730, 3),
(2, 2562, 1731, 3),
(2, 2563, 1732, 3),
(2, 2564, 1733, 3),
(2, 2565, 1734, 3),
(2, 2566, 1735, 3),
(2, 2600, 1736, 3),
(2, 2601, 1737, 3),
(2, 2602, 1738, 3),
(2, 2603, 1739, 3),
(2, 2604, 1740, 3),
(2, 2640, 1741, 3),
(2, 2641, 1742, 3),
(2, 2642, 1743, 3),
(2, 2643, 1744, 3),
(2, 2644, 1745, 3),
(2, 2645, 1746, 3),
(2, 2646, 1747, 3),
(2, 2647, 1748, 3),
(2, 2648, 1749, 3),
(2, 2649, 1750, 3),
(2, 2650, 1751, 3),
(2, 2651, 1752, 3),
(2, 2652, 1753, 3),
(2, 2653, 1754, 3),
(2, 2654, 1755, 3),
(2, 2655, 1756, 3),
(2, 2656, 1757, 3),
(2, 2657, 1758, 3),
(2, 2658, 1759, 3),
(2, 2659, 1760, 3),
(2, 2660, 1761, 3),
(2, 2661, 1762, 3),
(2, 2662, 1763, 3),
(2, 2663, 1764, 3),
(2, 2664, 1765, 3),
(2, 2665, 1766, 3),
(2, 2666, 1767, 3),
(2, 2667, 1768, 3),
(2, 2668, 1769, 3),
(2, 2669, 1770, 3),
(2, 2670, 1771, 3),
(2, 2671, 1772, 3),
(2, 2672, 1773, 3),
(2, 2673, 1774, 3),
(2, 2674, 1775, 3),
(2, 2675, 1776, 3),
(2, 2676, 1777, 3),
(2, 2700, 1778, 3),
(2, 2701, 1779, 3),
(2, 2702, 1780, 3),
(2, 2703, 1781, 3),
(2, 2704, 1782, 3),
(2, 2740, 1783, 3),
(2, 2741, 1784, 3),
(2, 2742, 1785, 3),
(2, 2744, 1786, 3),
(2, 2745, 1787, 3),
(2, 2746, 1788, 3),
(2, 2747, 1789, 3),
(2, 2748, 1790, 3),
(2, 2749, 1791, 3),
(2, 2750, 1792, 3),
(2, 2780, 1793, 3),
(2, 2781, 1794, 3),
(2, 2782, 1795, 3),
(2, 2783, 1796, 3),
(2, 2800, 1797, 3),
(2, 2840, 1798, 3),
(2, 2841, 1799, 3),
(2, 2842, 1800, 3),
(2, 5000, 1801, 3),
(2, 5100, 1802, 3),
(2, 5101, 1803, 3),
(2, 5102, 1804, 3),
(2, 5103, 1805, 3),
(2, 5104, 1806, 3),
(2, 5105, 1807, 3),
(2, 5106, 1808, 3),
(2, 5107, 1809, 3),
(2, 5108, 1810, 3),
(2, 5109, 1811, 3),
(2, 5110, 1812, 3),
(2, 5111, 1813, 3),
(2, 5112, 1814, 3),
(2, 5113, 1815, 3),
(2, 5114, 1816, 3),
(2, 5115, 1817, 3),
(2, 5116, 1818, 3),
(2, 5117, 1819, 3),
(2, 5118, 1820, 3),
(2, 5119, 1821, 3),
(2, 5120, 1822, 3),
(2, 5200, 1823, 3),
(2, 5201, 1824, 3),
(2, 5202, 1825, 3),
(2, 5203, 1826, 3),
(2, 5204, 1827, 3),
(2, 5205, 1828, 3),
(2, 5206, 1829, 3),
(2, 5207, 1830, 3),
(2, 5208, 1831, 3),
(2, 5209, 1832, 3),
(2, 5210, 1833, 3),
(2, 5211, 1834, 3),
(2, 5212, 1835, 3),
(2, 5213, 1836, 3),
(2, 5214, 1837, 3),
(2, 5215, 1838, 3),
(2, 5216, 1839, 3),
(2, 5217, 1840, 3),
(2, 5218, 1841, 3),
(2, 5219, 1842, 3),
(2, 5220, 1843, 3),
(2, 5221, 1844, 3),
(2, 5222, 1845, 3),
(2, 5223, 1846, 3),
(2, 5224, 1847, 3),
(2, 5225, 1848, 3),
(2, 5226, 1849, 3),
(2, 5230, 1850, 3),
(2, 5231, 1851, 3),
(2, 5232, 1852, 3),
(2, 5233, 1853, 3),
(2, 5234, 1854, 3),
(2, 5235, 1855, 3),
(2, 5236, 1856, 3),
(2, 5237, 1857, 3),
(2, 5238, 1858, 3),
(2, 5239, 1859, 3),
(2, 5240, 1860, 3),
(2, 5241, 1861, 3),
(2, 5242, 1862, 3),
(2, 5243, 1863, 3),
(2, 5244, 1864, 3),
(2, 5245, 1865, 3),
(2, 5246, 1866, 3),
(2, 5247, 1867, 3),
(2, 5248, 1868, 3),
(2, 5249, 1869, 3),
(2, 5250, 1870, 3),
(2, 5251, 1871, 3),
(2, 5252, 1872, 3),
(2, 5260, 1873, 3),
(2, 5270, 1874, 3),
(2, 5271, 1875, 3),
(2, 5272, 1876, 3),
(2, 5273, 1877, 3),
(2, 5274, 1878, 3),
(2, 5276, 1879, 3),
(2, 5290, 1880, 3),
(2, 5300, 1881, 3),
(2, 5301, 1882, 3),
(2, 5302, 1883, 3),
(2, 5303, 1884, 3),
(2, 5304, 1885, 3),
(2, 5305, 1886, 3),
(2, 5306, 1887, 3),
(2, 5307, 1888, 3),
(2, 5308, 1889, 3),
(2, 5309, 1890, 3),
(2, 5310, 1891, 3),
(2, 5311, 1892, 3),
(2, 5312, 1893, 3),
(2, 5313, 1894, 3),
(2, 5314, 1895, 3),
(2, 5315, 1896, 3),
(2, 5316, 1897, 3),
(2, 5317, 1898, 3),
(2, 5318, 1899, 3),
(2, 5319, 1900, 3),
(2, 5350, 1901, 3),
(2, 5351, 1902, 3),
(2, 5352, 1903, 3),
(2, 5353, 1904, 3),
(2, 5354, 1905, 3),
(2, 5380, 1906, 3),
(2, 5381, 1907, 3),
(2, 5382, 1908, 3),
(2, 5383, 1909, 3),
(2, 5384, 1910, 3),
(2, 5385, 1911, 3),
(2, 5400, 1912, 3),
(2, 5401, 1913, 3),
(2, 5402, 1914, 3),
(2, 5403, 1915, 3),
(2, 5404, 1916, 3),
(2, 5405, 1917, 3),
(2, 5406, 1918, 3),
(2, 5407, 1919, 3),
(2, 5408, 1920, 3),
(2, 5430, 1921, 3),
(2, 5431, 1922, 3),
(2, 5432, 1923, 3),
(2, 5433, 1924, 3),
(2, 5434, 1925, 3),
(2, 5435, 1926, 3),
(2, 5460, 1927, 3),
(2, 5461, 1928, 3),
(2, 5462, 1929, 3),
(2, 5463, 1930, 3),
(2, 5464, 1931, 3),
(2, 5465, 1932, 3),
(2, 5466, 1933, 3),
(2, 5467, 1934, 3),
(2, 5468, 1935, 3),
(2, 5469, 1936, 3),
(2, 5470, 1937, 3),
(2, 5471, 1938, 3),
(2, 5472, 1939, 3),
(2, 5473, 1940, 3),
(2, 5474, 1941, 3),
(2, 5475, 1942, 3),
(2, 5476, 1943, 3),
(2, 5477, 1944, 3),
(2, 5500, 1945, 3),
(2, 5501, 1946, 3),
(2, 5502, 1947, 3),
(2, 5503, 1948, 3),
(2, 5504, 1949, 3),
(2, 5505, 1950, 3),
(2, 5506, 1951, 3),
(2, 5507, 1952, 3),
(2, 5530, 1953, 3),
(2, 5531, 1954, 3),
(2, 5532, 1955, 3),
(2, 5533, 1956, 3),
(2, 5534, 1957, 3),
(2, 5550, 1958, 3),
(2, 5551, 1959, 3),
(2, 5552, 1960, 3),
(2, 5600, 1961, 3),
(2, 5601, 1962, 3),
(2, 5620, 1963, 3),
(2, 5621, 1964, 3),
(2, 5622, 1965, 3),
(2, 5623, 1966, 3),
(2, 5624, 1967, 3),
(2, 5625, 1968, 3),
(2, 5626, 1969, 3),
(2, 5627, 1970, 3),
(2, 5628, 1971, 3),
(2, 5700, 1972, 3),
(2, 5771, 1973, 3),
(2, 8000, 1974, 3),
(2, 8100, 1975, 3),
(2, 8101, 1976, 3),
(2, 8102, 1977, 3),
(2, 8103, 1978, 3),
(2, 8104, 1979, 3),
(2, 8105, 1980, 3),
(2, 8106, 1981, 3),
(2, 12000, 1982, 3),
(2, 12100, 1983, 3),
(2, 12101, 1984, 3),
(2, 12102, 1985, 3),
(2, 12200, 1986, 3),
(2, 12201, 1987, 3),
(2, 12202, 1988, 3),
(2, 12203, 1989, 3),
(2, 12550, 1990, 3),
(2, 12567, 1991, 3),
(2, 12568, 1992, 3),
(2, 13000, 1993, 3),
(2, 13001, 1994, 3),
(2, 13002, 1995, 3),
(2, 13003, 1996, 3),
(2, 13004, 1997, 3),
(2, 99999, 1998, 3);

-- --------------------------------------------------------

--
-- Table structure for table `link_options_access`
--

CREATE TABLE `link_options_access` (
  `Emp_code` int(11) NOT NULL,
  `Module_Item` int(11) NOT NULL,
  `Menu_Item` int(11) NOT NULL,
  `Option_Item` int(11) NOT NULL,
  `SaveButton` bit(1) DEFAULT NULL,
  `ProcessButton` bit(1) DEFAULT NULL,
  `id` int(11) NOT NULL,
  `company_code` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `loghrsystem`
--

CREATE TABLE `loghrsystem` (
  `IdentityColumn` int(11) NOT NULL,
  `Module_item` int(11) DEFAULT NULL,
  `Menu_Item` int(11) DEFAULT NULL,
  `Menu_Option` int(11) DEFAULT NULL,
  `ACtion_On_Button` varchar(50) DEFAULT NULL,
  `ACtion_date` date DEFAULT NULL,
  `User_code` int(11) DEFAULT NULL,
  `remarks` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `loghrsystem`
--

INSERT INTO `loghrsystem` (`IdentityColumn`, `Module_item`, `Menu_Item`, `Menu_Option`, `ACtion_On_Button`, `ACtion_date`, `User_code`, `remarks`) VALUES
(1, 10, 10, 10, 'SavePayroll', '2023-07-05', 0, 'log_tran_appointments');

-- --------------------------------------------------------

--
-- Table structure for table `log_tran_appointments`
--

CREATE TABLE `log_tran_appointments` (
  `Sequence_no` int(11) NOT NULL,
  `Transaction_Date` datetime(6) NOT NULL,
  `Emp_name` varchar(30) NOT NULL,
  `Emp_Father_name` varchar(30) NOT NULL,
  `Emp_sex_code` varchar(1) NOT NULL,
  `Emp_marital_status` varchar(1) NOT NULL,
  `Emp_birth_date` datetime(6) NOT NULL,
  `Emp_appointment_date` datetime(6) NOT NULL,
  `Emp_confirm_date` datetime(6) NOT NULL,
  `Emp_category` int(11) NOT NULL,
  `Emp_Leave_category` int(11) NOT NULL,
  `Emp_address_line1` varchar(200) NOT NULL,
  `Emp_address_line2` varchar(40) DEFAULT NULL,
  `Emp_home_tel1` varchar(15) DEFAULT NULL,
  `Emp_home_tel2` varchar(15) DEFAULT NULL,
  `Emp_office_tel1` varchar(15) DEFAULT NULL,
  `Emp_office_tel2` varchar(15) DEFAULT NULL,
  `Emp_mobile_No` varchar(20) DEFAULT NULL,
  `Emp_nic_no` varchar(30) DEFAULT NULL,
  `Emp_nic_issue_date` date DEFAULT NULL,
  `Emp_nic_expiry_date` date DEFAULT NULL,
  `Emp_retirement_age` int(11) DEFAULT NULL,
  `Emp_ntn_no` varchar(15) DEFAULT NULL,
  `Emp_email` varchar(70) DEFAULT NULL,
  `Confirmation_Flag` varchar(1) NOT NULL,
  `Empt_Type_code` int(11) NOT NULL,
  `Desig_code` int(11) NOT NULL,
  `Grade_code` int(11) NOT NULL,
  `Cost_Centre_code` int(11) NOT NULL,
  `Dept_code` int(11) NOT NULL,
  `Loc_code` int(11) NOT NULL,
  `Edu_code` int(11) NOT NULL,
  `Transport_code` int(11) NOT NULL,
  `Supervisor_Code` int(11) DEFAULT NULL,
  `Religion_Code` int(11) DEFAULT NULL,
  `Section_code` int(11) NOT NULL,
  `Shift_code` int(11) NOT NULL,
  `Deletion_Flag` varchar(1) DEFAULT NULL,
  `Emp_Payroll_category` int(11) NOT NULL,
  `Mode_Of_Payment` int(11) NOT NULL,
  `Bank_Account_No1` varchar(30) NOT NULL,
  `Branch_Code1` int(11) NOT NULL,
  `Bank_Amount_1` int(11) NOT NULL,
  `Bank_Percent_1` smallint(6) NOT NULL,
  `Bank_Account_No2` varchar(30) NOT NULL,
  `Branch_Code2` int(11) NOT NULL,
  `Bank_Amount_2` int(11) NOT NULL,
  `Bank_Percent_2` smallint(6) NOT NULL,
  `Bank_Account_No3` varchar(30) NOT NULL,
  `Branch_Code3` int(11) NOT NULL,
  `Bank_Amount_3` int(11) NOT NULL,
  `Bank_Percent_3` smallint(6) NOT NULL,
  `Bank_Account_No4` varchar(30) NOT NULL,
  `Branch_Code4` int(11) NOT NULL,
  `Bank_Amount_4` int(11) NOT NULL,
  `Bank_Percent_4` smallint(6) NOT NULL,
  `SESSI_Flag` varchar(1) NOT NULL,
  `EOBI_Flag` varchar(1) NOT NULL,
  `Union_Flag` varchar(1) NOT NULL,
  `Recreation_Club_Flag` varchar(1) NOT NULL,
  `Meal_Deduction_Flag` varchar(1) NOT NULL,
  `Overtime_Flag` varchar(1) NOT NULL,
  `Incentive_Flag` varchar(1) NOT NULL,
  `Bonus_Type` varchar(30) DEFAULT NULL,
  `Contact_Person_Name` varchar(30) NOT NULL,
  `Relationship` varchar(15) NOT NULL,
  `Contact_address1` varchar(40) NOT NULL,
  `Contact_address2` varchar(40) NOT NULL,
  `Contact_home_tel1` varchar(20) DEFAULT NULL,
  `Contact_home_tel2` varchar(20) DEFAULT NULL,
  `Emp_Blood_Group` varchar(4) NOT NULL,
  `EOBI_Number` varchar(20) NOT NULL,
  `SESSI_Number` varchar(20) NOT NULL,
  `Vehicle_Registration_Number` varchar(100) NOT NULL,
  `Status` varchar(30) DEFAULT NULL,
  `Interest_Flag` varchar(1) NOT NULL,
  `Zakat_Flag` varchar(1) NOT NULL,
  `Account_Type1` varchar(20) DEFAULT NULL,
  `Account_Type2` varchar(20) DEFAULT NULL,
  `Account_Type3` varchar(20) DEFAULT NULL,
  `Account_Type4` varchar(20) DEFAULT NULL,
  `Picture` longblob DEFAULT NULL,
  `Emp_id` varchar(50) DEFAULT NULL,
  `Offer_Letter_date` date DEFAULT NULL,
  `Tentative_Joining_date` date DEFAULT NULL,
  `RefferedBy` varchar(50) DEFAULT NULL,
  `Probationary_period_months` int(11) DEFAULT NULL,
  `Notice_period_months` int(11) DEFAULT NULL,
  `Extended_confirmation_days` int(11) DEFAULT NULL,
  `Permanent_address` varchar(200) DEFAULT NULL,
  `Nationality` varchar(50) DEFAULT NULL,
  `PosteddBY` int(11) DEFAULT NULL,
  `PostedOn` datetime(6) DEFAULT NULL,
  `roster_group_code` int(11) DEFAULT NULL,
  `card_no` varchar(50) DEFAULT NULL,
  `ContractExpiryDate` datetime(6) DEFAULT NULL,
  `Position_Code` int(11) DEFAULT NULL,
  `Company_Code` int(11) DEFAULT NULL,
  `UserCode` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `log_tran_appointments`
--

INSERT INTO `log_tran_appointments` (`Sequence_no`, `Transaction_Date`, `Emp_name`, `Emp_Father_name`, `Emp_sex_code`, `Emp_marital_status`, `Emp_birth_date`, `Emp_appointment_date`, `Emp_confirm_date`, `Emp_category`, `Emp_Leave_category`, `Emp_address_line1`, `Emp_address_line2`, `Emp_home_tel1`, `Emp_home_tel2`, `Emp_office_tel1`, `Emp_office_tel2`, `Emp_mobile_No`, `Emp_nic_no`, `Emp_nic_issue_date`, `Emp_nic_expiry_date`, `Emp_retirement_age`, `Emp_ntn_no`, `Emp_email`, `Confirmation_Flag`, `Empt_Type_code`, `Desig_code`, `Grade_code`, `Cost_Centre_code`, `Dept_code`, `Loc_code`, `Edu_code`, `Transport_code`, `Supervisor_Code`, `Religion_Code`, `Section_code`, `Shift_code`, `Deletion_Flag`, `Emp_Payroll_category`, `Mode_Of_Payment`, `Bank_Account_No1`, `Branch_Code1`, `Bank_Amount_1`, `Bank_Percent_1`, `Bank_Account_No2`, `Branch_Code2`, `Bank_Amount_2`, `Bank_Percent_2`, `Bank_Account_No3`, `Branch_Code3`, `Bank_Amount_3`, `Bank_Percent_3`, `Bank_Account_No4`, `Branch_Code4`, `Bank_Amount_4`, `Bank_Percent_4`, `SESSI_Flag`, `EOBI_Flag`, `Union_Flag`, `Recreation_Club_Flag`, `Meal_Deduction_Flag`, `Overtime_Flag`, `Incentive_Flag`, `Bonus_Type`, `Contact_Person_Name`, `Relationship`, `Contact_address1`, `Contact_address2`, `Contact_home_tel1`, `Contact_home_tel2`, `Emp_Blood_Group`, `EOBI_Number`, `SESSI_Number`, `Vehicle_Registration_Number`, `Status`, `Interest_Flag`, `Zakat_Flag`, `Account_Type1`, `Account_Type2`, `Account_Type3`, `Account_Type4`, `Picture`, `Emp_id`, `Offer_Letter_date`, `Tentative_Joining_date`, `RefferedBy`, `Probationary_period_months`, `Notice_period_months`, `Extended_confirmation_days`, `Permanent_address`, `Nationality`, `PosteddBY`, `PostedOn`, `roster_group_code`, `card_no`, `ContractExpiryDate`, `Position_Code`, `Company_Code`, `UserCode`) VALUES
(6, '2020-08-21 00:00:00.000000', 'Dania Hassan Ansari', 'Muhammad Usman Ali Ansari', 'F', 'S', '1992-12-03 00:00:00.000000', '2020-08-17 00:00:00.000000', '2020-08-17 00:00:00.000000', 1, 1, 'A 180 Block 17, Gulistan e Jauhar Karachi', 'N/A', '', 'N/A', 'N/A', 'N/A', '03341343709', '42201-3181541-0', '2020-08-21', '2025-08-21', 60, 'N/A', 'dania.ansari@roche.com', 'N', 1, 116, 19, 17, 38, 10, 51, 0, 1474, 1, 29, 1, 'N', 1, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'NotApplicable', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', '0', 'N/A', 'Personnel Done', 'N', 'N', 'N', 'N', 'N', 'N', 0x0000, '', '2020-08-17', '2020-08-17', 'N/A', 6, 1, 0, 'N/A', 'Pakistani', 1543, '2020-08-21 12:19:29.517000', 1, 'NA', '2020-10-21 11:03:31.837000', 0, 0, 0),
(6, '2020-08-21 00:00:00.000000', 'Dania Hassan Ansari', 'Muhammad Usman Ali Ansari', 'F', 'S', '1992-12-03 00:00:00.000000', '2020-08-17 00:00:00.000000', '2020-08-17 00:00:00.000000', 1, 1, 'A 180 Block 17, Gulistan e Jauhar Karachi', 'N/A', '', 'N/A', 'N/A', 'N/A', '03341343709', '42201-3181541-0', '2020-08-21', '2025-08-21', 60, 'N/A', 'dania.ansari@roche.com', 'N', 1, 116, 19, 17, 38, 10, 51, 0, 1474, 1, 29, 1, 'N', 1, 1, 'Pk48HABB0008577901327103', 1, 0, 100, '0', 2, 0, 0, '0', 2, 0, 0, '0', 2, 0, 0, 'N', 'Y', 'N', 'N', 'N', 'N', 'N', 'NotApplicable', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', 'N/A', 'Payroll Done', 'N', 'N', 'C', '', '', '', 0x0000, '', '2020-08-17', '2020-08-17', 'N/A', 6, 1, 0, 'N/A', 'Pakistani', 1543, '2020-08-21 12:22:32.337000', 1, 'NA', '2020-10-21 11:03:31.837000', 0, 0, 0),
(6, '2020-08-21 00:00:00.000000', 'Dania Hassan Ansari', 'Muhammad Usman Ali Ansari', 'F', 'S', '1992-12-03 00:00:00.000000', '2020-08-17 00:00:00.000000', '2020-08-17 00:00:00.000000', 1, 1, 'A 180 Block 17, Gulistan e Jauhar Karachi', 'N/A', '', 'N/A', 'N/A', 'N/A', '03341343709', '42201-3181541-0', '2020-08-21', '2025-08-21', 60, 'N/A', 'dania.ansari@roche.com', 'N', 1, 116, 19, 17, 38, 10, 51, 0, 1474, 1, 29, 1, 'N', 1, 1, 'Pk48HABB0008577901327103', 1, 0, 100, '0', 2, 0, 0, '0', 2, 0, 0, '0', 2, 0, 0, 'N', 'Y', 'N', 'N', 'N', 'N', 'N', 'NotApplicable', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', 'N/A', 'Payroll Done', 'N', 'N', 'C', '', '', '', 0x0000, '', '2020-08-17', '2020-08-17', 'N/A', 6, 1, 0, 'N/A', 'Pakistani', 1543, '2020-08-21 12:22:32.343000', 1, 'NA', '2020-10-21 11:03:31.837000', 0, 0, 0),
(6, '2020-08-21 00:00:00.000000', 'Dania Hassan Ansari', 'Muhammad Usman Ali Ansari', 'F', 'S', '1992-12-03 00:00:00.000000', '2020-08-17 00:00:00.000000', '2020-08-17 00:00:00.000000', 1, 1, 'A 180 Block 17, Gulistan e Jauhar Karachi', 'N/A', '', 'N/A', 'N/A', 'N/A', '03341343709', '42201-3181541-0', '2020-08-21', '2025-08-21', 60, 'N/A', 'dania.ansari@roche.com', 'N', 1, 116, 19, 17, 38, 10, 51, 0, 1474, 1, 29, 1, 'N', 1, 1, '0', 1, 100, 100, '0', 2, 0, 0, '0', 2, 0, 0, '0', 2, 0, 0, 'N', 'Y', 'N', 'N', 'N', 'N', 'N', 'NotApplicable', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', 'N/A', 'Payroll Done', 'N', 'N', 'C', '', '', '', 0x0000, '', '2020-08-17', '2020-08-17', 'N/A', 6, 1, 0, 'N/A', 'Pakistani', 1543, '2020-08-21 16:54:26.430000', 1, 'NA', '2020-10-21 11:03:31.837000', 0, 0, 0),
(6, '2020-08-21 00:00:00.000000', 'Dania Hassan Ansari', 'Muhammad Usman Ali Ansari', 'F', 'S', '1992-12-03 00:00:00.000000', '2020-08-17 00:00:00.000000', '2020-08-17 00:00:00.000000', 1, 1, 'A 180 Block 17, Gulistan e Jauhar Karachi', 'N/A', '', 'N/A', 'N/A', 'N/A', '03341343709', '42201-3181541-0', '2020-08-21', '2025-08-21', 60, 'N/A', 'dania.ansari@roche.com', 'N', 1, 116, 19, 17, 38, 10, 51, 0, 1474, 1, 29, 1, 'N', 1, 1, '0', 1, 100, 100, '0', 2, 0, 0, '0', 2, 0, 0, '0', 2, 0, 0, 'N', 'Y', 'N', 'N', 'N', 'N', 'N', 'NotApplicable', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', 'N/A', 'Payroll Done', 'N', 'N', 'C', '', '', '', 0x0000, '', '2020-08-17', '2020-08-17', 'N/A', 6, 1, 0, 'N/A', 'Pakistani', 1543, '2020-08-21 16:54:26.440000', 1, 'NA', '2020-10-21 11:03:31.837000', 0, 0, 0),
(7, '2020-11-19 00:00:00.000000', 'Madiha Batool', 'Abdul Qayyum Tahir', 'F', 'S', '1989-07-21 00:00:00.000000', '2020-11-16 00:00:00.000000', '2020-11-16 00:00:00.000000', 1, 1, 'S2 Marfani Cottages, 62 A, P.E.C.H.S., Block-2, Karachi', 'S2 Marfani Cottages, 62 A, P.E.C.H.S., B', '', 'N/A', 'N/A', 'N/A', '0345-3392689', '42201-0290288-8', '2020-11-19', '2025-01-04', 60, 'N/A', 'madiha.batool@roche.com', 'N', 1, 44, 21, 17, 38, 10, 51, 0, 1474, 1, 29, 1, 'N', 1, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'NotApplicable', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', '0', 'N/A', 'Personnel Done', 'N', 'N', 'N', 'N', 'N', 'N', 0x0000, '', '2020-11-16', '2020-11-16', 'N/A', 6, 1, 0, 'N/A', 'Pakistani', 1543, '2020-11-19 15:22:14.247000', 1, 'NA', '2020-11-19 00:00:00.000000', 0, 0, 0),
(7, '2020-11-19 00:00:00.000000', 'Madiha Batool', 'Abdul Qayyum Tahir', 'F', 'S', '1989-07-21 00:00:00.000000', '2020-11-16 00:00:00.000000', '2020-11-16 00:00:00.000000', 1, 1, 'S2 Marfani Cottages, 62 A, P.E.C.H.S., Block-2, Karachi', 'S2 Marfani Cottages, 62 A, P.E.C.H.S., B', '', 'N/A', 'N/A', 'N/A', '0345-3392689', '42201-0290288-8', '2020-11-19', '2025-01-04', 60, 'N/A', 'madiha.batool@roche.com', 'N', 1, 169, 21, 17, 38, 10, 51, 0, 1474, 1, 29, 1, 'N', 1, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'NotApplicable', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', '0', 'N/A', 'Personnel Done', 'N', 'N', 'N', 'N', 'N', 'N', 0x0000, '', '2020-11-16', '2020-11-16', 'N/A', 6, 1, 0, 'N/A', 'Pakistani', 1543, '2020-11-19 15:25:09.840000', 1, 'NA', '2020-11-19 00:00:00.000000', 0, 0, 0),
(7, '2020-11-19 00:00:00.000000', 'Madiha Batool', 'Abdul Qayyum Tahir', 'F', 'S', '1989-07-21 00:00:00.000000', '2020-11-16 00:00:00.000000', '2020-11-16 00:00:00.000000', 1, 1, 'S2 Marfani Cottages, 62 A, P.E.C.H.S., Block-2, Karachi', 'S2 Marfani Cottages, 62 A, P.E.C.H.S., B', '', 'N/A', 'N/A', 'N/A', '0345-3392689', '42201-0290288-8', '2020-11-19', '2025-01-04', 60, 'N/A', 'madiha.batool@roche.com', 'N', 1, 169, 21, 17, 38, 10, 51, 0, 1474, 1, 29, 1, 'N', 1, 1, 'PK19MPBL0112357140357148', 4, 100, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'Y', 'N', 'N', 'N', 'N', 'N', 'NotApplicable', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', 'N/A', 'Payroll Done', 'N', 'N', 'C', 'N', 'N', 'N', 0x0000, '', '2020-11-16', '2020-11-16', 'N/A', 6, 1, 0, 'N/A', 'Pakistani', 1543, '2020-11-19 15:28:48.463000', 1, 'NA', '2020-11-19 00:00:00.000000', 0, 0, 0),
(7, '2020-11-19 00:00:00.000000', 'Madiha Batool', 'Abdul Qayyum Tahir', 'F', 'S', '1989-07-21 00:00:00.000000', '2020-11-16 00:00:00.000000', '2020-11-16 00:00:00.000000', 1, 1, 'S2 Marfani Cottages, 62 A, P.E.C.H.S., Block-2, Karachi', 'S2 Marfani Cottages, 62 A, P.E.C.H.S., B', '', 'N/A', 'N/A', 'N/A', '0345-3392689', '42201-0290288-8', '2020-11-19', '2025-01-04', 60, 'N/A', 'madiha.batool@roche.com', 'N', 1, 169, 21, 17, 38, 10, 51, 0, 1474, 1, 29, 1, 'N', 1, 1, 'PK19MPBL0112357140357148', 4, 100, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'Y', 'N', 'N', 'N', 'N', 'N', 'NotApplicable', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', 'N/A', 'Payroll Done', 'N', 'N', 'C', 'N', 'N', 'N', 0x0000, '', '2020-11-16', '2020-11-16', 'N/A', 6, 1, 0, 'N/A', 'Pakistani', 1543, '2020-11-19 15:28:48.470000', 1, 'NA', '2020-11-19 00:00:00.000000', 0, 0, 0),
(8, '2020-12-21 00:00:00.000000', 'Bilal Butt', 'Ghulam Nabi', 'M', 'S', '1988-02-22 00:00:00.000000', '2020-11-30 00:00:00.000000', '2020-11-30 00:00:00.000000', 3, 1, 'KH1110, St # 02, Darbar Road, Girja Road, Rawalpindi', 'KH1110, St # 02, Darbar Road, Girja Road', '', 'N/A', 'N/A', 'N/A', '03335989892', '37405-9110913-9', '2020-07-01', '2021-01-31', 60, 'N/A', 'bilal.butt@roche.com', 'N', 1, 139, 22, 49, 44, 9, 8, 0, 222, 1, 35, 1, 'N', 1, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'NotApplicable', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', '0', 'N/A', 'Personnel Done', 'N', 'N', 'N', 'N', 'N', 'N', 0x0000, '', '2020-11-30', '2020-11-30', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 1543, '2020-12-21 14:26:50.167000', 1, 'NA', '2020-12-21 00:00:00.000000', 0, 0, 0),
(8, '2020-12-21 00:00:00.000000', 'Bilal Butt', 'Ghulam Nabi', 'M', 'S', '1988-02-22 00:00:00.000000', '2020-11-30 00:00:00.000000', '2020-11-30 00:00:00.000000', 3, 1, 'KH1110, St # 02, Darbar Road, Girja Road, Rawalpindi', 'KH1110, St # 02, Darbar Road, Girja Road', 'N/A', 'N/A', 'N/A', 'N/A', '03335989892', '37405-9110913-9', '2020-07-01', '2025-01-31', 60, 'N/A', 'bilal.butt@roche.com', 'N', 1, 139, 22, 49, 44, 9, 8, 0, 222, 1, 35, 1, 'N', 1, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'NotApplicable', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', '0', 'N/A', 'Personnel Done', 'N', 'N', 'N', 'N', 'N', 'N', 0x0000, '', '2020-11-30', '2020-11-30', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 1543, '2020-12-21 14:48:29.780000', 1, 'NA', '2020-12-21 00:00:00.000000', 0, 0, 0),
(8, '2020-12-21 00:00:00.000000', 'Bilal Butt', 'Ghulam Nabi', 'M', 'S', '1988-02-22 00:00:00.000000', '2020-11-30 00:00:00.000000', '2020-11-30 00:00:00.000000', 3, 1, 'KH1110, St # 02, Darbar Road, Girja Road, Rawalpindi', 'KH1110, St # 02, Darbar Road, Girja Road', 'N/A', 'N/A', 'N/A', 'N/A', '03335989892', '37405-9110913-9', '2020-07-01', '2025-01-31', 60, 'N/A', 'bilal.butt@roche.com', 'N', 1, 139, 22, 49, 44, 9, 8, 0, 222, 1, 35, 1, 'N', 1, 1, 'PK78SCBL0000001705389501', 7, 100, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'Y', 'N', 'N', 'N', 'N', 'Y', 'NotApplicable', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', 'N/A', 'Payroll Done', 'N', 'N', '', 'N', 'N', 'N', 0x0000, '', '2020-11-30', '2020-11-30', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 1543, '2020-12-21 14:50:33.533000', 1, 'NA', '2020-12-21 00:00:00.000000', 0, 0, 0),
(8, '2020-12-21 00:00:00.000000', 'Bilal Butt', 'Ghulam Nabi', 'M', 'S', '1988-02-22 00:00:00.000000', '2020-11-30 00:00:00.000000', '2020-11-30 00:00:00.000000', 3, 1, 'KH1110, St # 02, Darbar Road, Girja Road, Rawalpindi', 'KH1110, St # 02, Darbar Road, Girja Road', 'N/A', 'N/A', 'N/A', 'N/A', '03335989892', '37405-9110913-9', '2020-07-01', '2025-01-31', 60, 'N/A', 'bilal.butt@roche.com', 'N', 1, 139, 22, 49, 44, 9, 8, 0, 222, 1, 35, 1, 'N', 1, 1, 'PK78SCBL0000001705389501', 7, 100, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'Y', 'N', 'N', 'N', 'N', 'Y', 'NotApplicable', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', 'N/A', 'Payroll Done', 'N', 'N', '', 'N', 'N', 'N', 0x0000, '', '2020-11-30', '2020-11-30', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 1543, '2020-12-21 14:50:33.540000', 1, 'NA', '2020-12-21 00:00:00.000000', 0, 0, 0),
(9, '2020-12-21 00:00:00.000000', 'Rida Shaikh', 'Muhammad Arshad Shaikh', 'F', 'M', '1994-04-06 00:00:00.000000', '2020-11-30 00:00:00.000000', '2020-11-30 00:00:00.000000', 3, 1, 'House # 35/2 M. Street Phase 4, DHA Karachi', 'House # 35/2 M. Street Phase 4, DHA Kara', 'N/A', 'N/A', 'N/A', 'N/A', '03233336627', '42000-6626917-2', '2020-07-01', '2025-12-31', 60, 'N/A', 'rida.shaikh@roche.com', 'N', 1, 57, 19, 53, 31, 10, 7, 0, 222, 1, 22, 1, 'N', 1, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'NotApplicable', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', '0', 'N/A', 'Personnel Done', 'N', 'N', 'N', 'N', 'N', 'N', 0x0000, '', '2020-11-30', '2020-11-30', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 1543, '2020-12-21 14:56:33.267000', 1, 'NA', '2020-12-21 00:00:00.000000', 0, 0, 0),
(9, '2020-12-21 00:00:00.000000', 'Rida Shaikh', 'Muhammad Arshad Shaikh', 'F', 'M', '1994-04-06 00:00:00.000000', '2020-11-30 00:00:00.000000', '2020-11-30 00:00:00.000000', 3, 1, 'House # 35/2 M. Street Phase 4, DHA Karachi', 'House # 35/2 M. Street Phase 4, DHA Kara', 'N/A', 'N/A', 'N/A', 'N/A', '03233336627', '42000-6626917-2', '2020-07-01', '2025-12-31', 60, 'N/A', 'rida.shaikh@roche.com', 'N', 1, 57, 19, 53, 31, 10, 7, 0, 222, 1, 22, 1, 'N', 1, 1, 'PK72BAHL1055007800427150', 2, 100, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'Y', 'N', 'N', 'N', 'N', 'N', 'Fixed', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', 'N/A', 'Payroll Done', 'N', 'N', 'C', 'N', 'N', 'N', 0x0000, '', '2020-11-30', '2020-11-30', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 1543, '2020-12-21 14:58:39.673000', 1, 'NA', '2020-12-21 00:00:00.000000', 0, 0, 0),
(9, '2020-12-21 00:00:00.000000', 'Rida Shaikh', 'Muhammad Arshad Shaikh', 'F', 'M', '1994-04-06 00:00:00.000000', '2020-11-30 00:00:00.000000', '2020-11-30 00:00:00.000000', 3, 1, 'House # 35/2 M. Street Phase 4, DHA Karachi', 'House # 35/2 M. Street Phase 4, DHA Kara', 'N/A', 'N/A', 'N/A', 'N/A', '03233336627', '42000-6626917-2', '2020-07-01', '2025-12-31', 60, 'N/A', 'rida.shaikh@roche.com', 'N', 1, 57, 19, 53, 31, 10, 7, 0, 222, 1, 22, 1, 'N', 1, 1, 'PK72BAHL1055007800427150', 2, 100, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'Y', 'N', 'N', 'N', 'N', 'N', 'Fixed', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', 'N/A', 'Payroll Done', 'N', 'N', 'C', 'N', 'N', 'N', 0x0000, '', '2020-11-30', '2020-11-30', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 1543, '2020-12-21 14:58:39.680000', 1, 'NA', '2020-12-21 00:00:00.000000', 0, 0, 0),
(10, '2020-12-21 00:00:00.000000', 'Nouman Khalid', 'Khalid Rasheed Mirza', 'M', 'S', '1994-09-10 00:00:00.000000', '2020-12-14 00:00:00.000000', '2020-12-14 00:00:00.000000', 2, 1, '414-B, Johar Town Lahore', '414-B, Johar Town Lahore', 'N/A', 'N/A', 'N/A', 'N/A', '03343368496', '35202-5401671-3', '2020-07-01', '2025-12-31', 60, 'N/A', 'nouman.khalid@roche.com', 'N', 1, 139, 22, 33, 55, 10, 13, 0, 222, 1, 46, 1, 'N', 1, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'NotApplicable', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', '0', 'N/A', 'Personnel Done', 'N', 'N', 'N', 'N', 'N', 'N', 0x0000, '', '2020-12-14', '2020-12-14', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 1543, '2020-12-21 15:05:04.843000', 1, 'NA', '2020-12-21 00:00:00.000000', 0, 0, 0),
(11, '2021-01-22 00:00:00.000000', 'Muhammad Bilal', 'Muhammad Mumtaz Sajid', 'M', 'M', '1988-07-09 00:00:00.000000', '2020-12-30 00:00:00.000000', '2020-12-30 00:00:00.000000', 1, 1, 'CB 105, Alam Sher Colony, Behind Christian Hospital, Taxila District Rawalpindi', 'CB 105, Alam Sher Colony, Behind Christi', 'N/A', 'N/A', 'N/A', 'N/A', '00923347074707', '37406-4057004-3', '2020-11-17', '2025-12-25', 60, 'N/A', 'muhammad.bilal.mb2@roche.com', 'N', 1, 74, 23, 10, 43, 9, 52, 0, 950, 1, 34, 1, 'N', 1, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'NotApplicable', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', '0', 'N/A', 'Personnel Done', 'N', 'N', 'N', 'N', 'N', 'N', 0x0000, '', '2020-12-30', '2020-12-30', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 1543, '2021-01-22 10:43:12.100000', 1, 'NA', '2021-01-22 00:00:00.000000', 0, 0, 0),
(11, '2021-01-22 00:00:00.000000', 'Muhammad Bilal', 'Muhammad Mumtaz Sajid', 'M', 'M', '1988-07-09 00:00:00.000000', '2020-12-30 00:00:00.000000', '2020-12-30 00:00:00.000000', 1, 1, 'CB 105, Alam Sher Colony, Behind Christian Hospital, Taxila District Rawalpindi', 'CB 105, Alam Sher Colony, Behind Christi', 'N/A', 'N/A', 'N/A', 'N/A', '00923347074707', '37406-4057004-3', '2020-11-17', '2025-12-25', 60, 'N/A', 'muhammad.bilal.mb2@roche.com', 'N', 1, 74, 23, 10, 43, 9, 52, 0, 950, 1, 34, 1, 'N', 1, 1, 'PK42SCBL0000001273576801', 7, 0, 100, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'N', 'N', 'N', 'N', 'N', 'Y', 'NotApplicable', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', '0', 'N/A', 'Payroll Done', 'N', 'N', 'C', 'N', 'N', 'N', 0x0000, '', '2020-12-30', '2020-12-30', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 1543, '2021-01-22 10:48:44.073000', 1, 'NA', '2021-01-22 00:00:00.000000', 0, 0, 0),
(11, '2021-01-22 00:00:00.000000', 'Muhammad Bilal', 'Muhammad Mumtaz Sajid', 'M', 'M', '1988-07-09 00:00:00.000000', '2020-12-30 00:00:00.000000', '2020-12-30 00:00:00.000000', 1, 1, 'CB 105, Alam Sher Colony, Behind Christian Hospital, Taxila District Rawalpindi', 'CB 105, Alam Sher Colony, Behind Christi', 'N/A', 'N/A', 'N/A', 'N/A', '00923347074707', '37406-4057004-3', '2020-11-17', '2025-12-25', 60, 'N/A', 'muhammad.bilal.mb2@roche.com', 'N', 1, 74, 23, 10, 43, 9, 52, 0, 950, 1, 34, 1, 'N', 1, 1, 'PK42SCBL0000001273576801', 7, 0, 100, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'N', 'N', 'N', 'N', 'N', 'Y', 'NotApplicable', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', '0', 'N/A', 'Payroll Done', 'N', 'N', 'C', 'N', 'N', 'N', 0x0000, '', '2020-12-30', '2020-12-30', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 1543, '2021-01-22 10:48:44.083000', 1, 'NA', '2021-01-22 00:00:00.000000', 0, 0, 0),
(12, '2021-01-22 00:00:00.000000', 'Ali Saleem Manghi', 'Saleem Manghi', 'M', 'S', '1990-02-22 00:00:00.000000', '2021-01-01 00:00:00.000000', '2021-01-01 00:00:00.000000', 1, 1, 'D 42-1  Block 1, Clifton Karachi', 'D 42-1  Block 1, Clifton Karachi', 'N/A', 'N/A', 'N/A', 'N/A', '00923003543070', '42201-5774466-8', '2020-07-01', '2025-12-25', 60, 'N/A', 'ali.manghi@roche.com', 'N', 1, 116, 19, 17, 38, 10, 34, 0, 1474, 1, 29, 1, 'N', 1, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'NotApplicable', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', '0', 'N/A', 'Personnel Done', 'N', 'N', 'N', 'N', 'N', 'N', 0x0000, '', '2021-01-01', '2021-01-01', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 1543, '2021-01-22 10:56:34.500000', 1, 'NA', '2021-01-22 00:00:00.000000', 0, 0, 0),
(10, '2020-12-21 00:00:00.000000', 'Nouman Khalid', 'Khalid Rasheed Mirza', 'M', 'S', '1994-09-10 00:00:00.000000', '2020-12-14 00:00:00.000000', '2020-12-14 00:00:00.000000', 2, 1, '414-B, Johar Town Lahore', '414-B, Johar Town Lahore', 'N/A', 'N/A', 'N/A', 'N/A', '03343368496', '35202-5401671-3', '2020-07-01', '2025-12-31', 60, 'N/A', 'nouman.khalid@roche.com', 'N', 1, 139, 22, 33, 55, 10, 13, 0, 222, 1, 46, 1, 'N', 1, 1, 'PK49SCBL0000001706464201', 7, 100, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'Y', 'N', 'N', 'N', 'N', 'N', 'Fixed', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', 'N/A', 'Payroll Done', 'N', 'N', 'C', 'N', 'N', 'N', 0x0000, '', '2020-12-14', '2020-12-14', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 1543, '2020-12-21 15:20:46.757000', 1, 'NA', '2020-12-21 00:00:00.000000', 0, 0, 0),
(10, '2020-12-21 00:00:00.000000', 'Nouman Khalid', 'Khalid Rasheed Mirza', 'M', 'S', '1994-09-10 00:00:00.000000', '2020-12-14 00:00:00.000000', '2020-12-14 00:00:00.000000', 2, 1, '414-B, Johar Town Lahore', '414-B, Johar Town Lahore', 'N/A', 'N/A', 'N/A', 'N/A', '03343368496', '35202-5401671-3', '2020-07-01', '2025-12-31', 60, 'N/A', 'nouman.khalid@roche.com', 'N', 1, 139, 22, 33, 55, 10, 13, 0, 222, 1, 46, 1, 'N', 1, 1, 'PK49SCBL0000001706464201', 7, 100, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'Y', 'N', 'N', 'N', 'N', 'N', 'Fixed', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', 'N/A', 'Payroll Done', 'N', 'N', 'C', 'N', 'N', 'N', 0x0000, '', '2020-12-14', '2020-12-14', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 1543, '2020-12-21 15:20:46.760000', 1, 'NA', '2020-12-21 00:00:00.000000', 0, 0, 0),
(12, '2021-01-22 00:00:00.000000', 'Ali Saleem Manghi', 'Saleem Manghi', 'M', 'S', '1990-02-22 00:00:00.000000', '2021-01-01 00:00:00.000000', '2021-01-01 00:00:00.000000', 1, 1, 'D 42-1  Block 1, Clifton Karachi', 'D 42-1  Block 1, Clifton Karachi', 'N/A', 'N/A', 'N/A', 'N/A', '00923003543070', '42201-5774466-8', '2020-07-01', '2025-12-25', 60, 'N/A', 'ali.manghi@roche.com', 'N', 1, 116, 19, 17, 38, 10, 34, 0, 1474, 1, 29, 1, 'N', 1, 1, 'PK25HABB0024857900531303', 1, 0, 100, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'Performance', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', '0', 'N/A', 'Payroll Done', 'N', 'N', 'C', 'N', 'N', 'N', 0x0000, '', '2021-01-01', '2021-01-01', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 1543, '2021-01-22 11:00:08.573000', 1, 'NA', '2021-01-22 00:00:00.000000', 0, 0, 0),
(12, '2021-01-22 00:00:00.000000', 'Ali Saleem Manghi', 'Saleem Manghi', 'M', 'S', '1990-02-22 00:00:00.000000', '2021-01-01 00:00:00.000000', '2021-01-01 00:00:00.000000', 1, 1, 'D 42-1  Block 1, Clifton Karachi', 'D 42-1  Block 1, Clifton Karachi', 'N/A', 'N/A', 'N/A', 'N/A', '00923003543070', '42201-5774466-8', '2020-07-01', '2025-12-25', 60, 'N/A', 'ali.manghi@roche.com', 'N', 1, 116, 19, 17, 38, 10, 34, 0, 1474, 1, 29, 1, 'N', 1, 1, 'PK25HABB0024857900531303', 1, 0, 100, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'Performance', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', '0', 'N/A', 'Payroll Done', 'N', 'N', 'C', 'N', 'N', 'N', 0x0000, '', '2021-01-01', '2021-01-01', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 1543, '2021-01-22 11:00:08.580000', 1, 'NA', '2021-01-22 00:00:00.000000', 0, 0, 0),
(13, '2021-03-19 00:00:00.000000', 'Hafiz Syed Muhammad Ibrahim Sh', 'Syed Muhammad Shahab Ilyas', 'M', 'M', '1993-04-26 00:00:00.000000', '2021-03-01 00:00:00.000000', '2021-03-01 00:00:00.000000', 2, 1, 'House A2/4, Sector 15 A, Scheme 33, Rufi Rose Petal, Gulzar e Hijri, Karachi', 'House A2/4, Sector 15 A, Scheme 33, Rufi', '', 'N/A', 'N/A', 'N/A', '02133268958', '42201-3653415-9', '2020-07-01', '2025-07-31', 60, 'N/A', 'hafiz_syed.shahab@roche.com', 'N', 1, 139, 22, 36, 48, 10, 11, 0, 729, 1, 39, 1, 'N', 1, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'NotApplicable', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', '0', 'N/A', 'Personnel Done', 'N', 'N', 'N', 'N', 'N', 'N', 0x0000, '', '2021-03-01', '2021-03-01', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 1543, '2021-03-19 11:43:23.213000', 1, 'NA', '2021-03-19 00:00:00.000000', 0, 0, 0),
(13, '2021-03-19 00:00:00.000000', 'Hafiz Syed Muhammad Ibrahim Sh', 'Syed Muhammad Shahab Ilyas', 'M', 'M', '1993-04-26 00:00:00.000000', '2021-03-01 00:00:00.000000', '2021-03-01 00:00:00.000000', 2, 1, 'House A2/4, Sector 15 A, Scheme 33, Rufi Rose Petal, Gulzar e Hijri, Karachi', 'House A2/4, Sector 15 A, Scheme 33, Rufi', '', 'N/A', 'N/A', 'N/A', '02133268958', '42201-3653415-9', '2020-07-01', '2025-07-31', 60, 'N/A', 'hafiz_syed.shahab@roche.com', 'N', 1, 139, 22, 36, 48, 10, 11, 0, 729, 1, 39, 1, 'N', 1, 1, 'PK39MEZN0001040103164302', 6, 0, 100, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'Y', 'N', 'N', 'N', 'N', 'N', 'Fixed', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', 'N/A', 'Payroll Done', 'N', 'N', 'C', 'N', 'N', 'N', 0x0000, '', '2021-03-01', '2021-03-01', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 1543, '2021-03-19 11:45:42.140000', 1, 'NA', '2021-03-19 00:00:00.000000', 0, 0, 0),
(13, '2021-03-19 00:00:00.000000', 'Hafiz Syed Muhammad Ibrahim Sh', 'Syed Muhammad Shahab Ilyas', 'M', 'M', '1993-04-26 00:00:00.000000', '2021-03-01 00:00:00.000000', '2021-03-01 00:00:00.000000', 2, 1, 'House A2/4, Sector 15 A, Scheme 33, Rufi Rose Petal, Gulzar e Hijri, Karachi', 'House A2/4, Sector 15 A, Scheme 33, Rufi', '', 'N/A', 'N/A', 'N/A', '02133268958', '42201-3653415-9', '2020-07-01', '2025-07-31', 60, 'N/A', 'hafiz_syed.shahab@roche.com', 'N', 1, 139, 22, 36, 48, 10, 11, 0, 729, 1, 39, 1, 'N', 1, 1, 'PK39MEZN0001040103164302', 6, 0, 100, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'Y', 'N', 'N', 'N', 'N', 'N', 'Fixed', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', 'N/A', 'Payroll Done', 'N', 'N', 'C', 'N', 'N', 'N', 0x0000, '', '2021-03-01', '2021-03-01', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 1543, '2021-03-19 11:45:42.147000', 1, 'NA', '2021-03-19 00:00:00.000000', 0, 0, 0),
(14, '2021-04-20 00:00:00.000000', 'Hamas', 'Jawed Kaparia', 'M', 'M', '1994-08-31 00:00:00.000000', '2021-04-01 00:00:00.000000', '2021-04-01 00:00:00.000000', 2, 1, 'Flat # 406, Crystal Home, 63/111, BMCHS, Bahadurabad, Karachi.', 'Flat # 406, Crystal Home, 63/111, BMCHS,', 'N/A', 'N/A', 'N/A', 'N/A', '0342-5779655', '42301-8290208-5', '2020-07-01', '2029-07-31', 60, 'N/A', 'hamas.kapadia@roche.com', 'N', 1, 126, 22, 43, 42, 10, 51, 0, 722, 1, 33, 1, 'N', 1, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'NotApplicable', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', '0', 'N/A', 'Personnel Done', 'N', 'N', 'N', 'N', 'N', 'N', 0x0000, '', '2021-04-01', '2021-04-01', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 1543, '2021-04-20 12:42:07.680000', 1, 'NA', '2021-04-20 00:00:00.000000', 0, 0, 0),
(14, '2021-04-20 00:00:00.000000', 'Hamas', 'Jawed Kaparia', 'M', 'M', '1994-08-31 00:00:00.000000', '2021-04-01 00:00:00.000000', '2021-04-01 00:00:00.000000', 2, 1, 'Flat # 406, Crystal Home, 63/111, BMCHS, Bahadurabad, Karachi.', 'Flat # 406, Crystal Home, 63/111, BMCHS,', 'N/A', 'N/A', 'N/A', 'N/A', '0342-5779655', '42301-8290208-5', '2020-07-01', '2029-07-31', 60, 'N/A', 'hamas.kapadia@roche.com', 'N', 1, 180, 22, 43, 42, 10, 51, 0, 722, 1, 33, 1, 'N', 1, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'NotApplicable', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', '0', 'N/A', 'Personnel Done', 'N', 'N', 'N', 'N', 'N', 'N', 0x0000, '', '2021-04-01', '2021-04-01', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 1543, '2021-04-20 12:45:19.363000', 1, 'NA', '2021-04-20 00:00:00.000000', 0, 0, 0),
(14, '2021-04-20 00:00:00.000000', 'Hamas', 'Jawed Kaparia', 'M', 'M', '1994-08-31 00:00:00.000000', '2021-04-01 00:00:00.000000', '2021-04-01 00:00:00.000000', 2, 1, 'Flat # 406, Crystal Home, 63/111, BMCHS, Bahadurabad, Karachi.', 'Flat # 406, Crystal Home, 63/111, BMCHS,', 'N/A', 'N/A', 'N/A', 'N/A', '0342-5779655', '42301-8290208-5', '2020-07-01', '2029-07-31', 60, 'N/A', 'hamas.kapadia@roche.com', 'N', 1, 180, 22, 43, 42, 10, 51, 0, 722, 1, 33, 1, 'N', 1, 1, 'PK37MEZN0001590104476284', 2, 100, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'Y', 'N', 'N', 'N', 'N', 'N', 'Fixed', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', 'N/A', 'Payroll Done', 'N', 'N', 'C', 'N', 'N', 'N', 0x0000, '', '2021-04-01', '2021-04-01', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 1543, '2021-04-20 12:49:27.413000', 1, 'NA', '2021-04-20 00:00:00.000000', 0, 0, 0),
(14, '2021-04-20 00:00:00.000000', 'Hamas', 'Jawed Kaparia', 'M', 'M', '1994-08-31 00:00:00.000000', '2021-04-01 00:00:00.000000', '2021-04-01 00:00:00.000000', 2, 1, 'Flat # 406, Crystal Home, 63/111, BMCHS, Bahadurabad, Karachi.', 'Flat # 406, Crystal Home, 63/111, BMCHS,', 'N/A', 'N/A', 'N/A', 'N/A', '0342-5779655', '42301-8290208-5', '2020-07-01', '2029-07-31', 60, 'N/A', 'hamas.kapadia@roche.com', 'N', 1, 180, 22, 43, 42, 10, 51, 0, 722, 1, 33, 1, 'N', 1, 1, 'PK37MEZN0001590104476284', 2, 100, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'Y', 'N', 'N', 'N', 'N', 'N', 'Fixed', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', 'N/A', 'Payroll Done', 'N', 'N', 'C', 'N', 'N', 'N', 0x0000, '', '2021-04-01', '2021-04-01', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 1543, '2021-04-20 12:49:27.423000', 1, 'NA', '2021-04-20 00:00:00.000000', 0, 0, 0),
(15, '2021-04-20 00:00:00.000000', 'Muhammad Ammad Salman', 'Muhammad Salman', 'M', 'S', '1992-12-03 00:00:00.000000', '2021-04-12 00:00:00.000000', '2021-04-12 00:00:00.000000', 2, 1, 'Flat # A-107, Block A, Karachi Center Apartment, PIB Colony, Near University Road, Karachi.', 'Flat # A-107, Block A, Karachi Center Ap', 'N/A', 'N/A', 'N/A', 'N/A', '0315-0236573', '42201-0244904-9', '2020-07-01', '2029-07-31', 60, 'N/A', 'muhammad_ammad.salman@roche.com', 'N', 1, 145, 22, 33, 55, 10, 19, 0, 722, 1, 46, 1, 'N', 1, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'NotApplicable', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', '0', 'N/A', 'Personnel Done', 'N', 'N', 'N', 'N', 'N', 'N', 0x0000, '', '2021-04-12', '2021-04-12', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 1543, '2021-04-20 12:57:21.600000', 1, 'NA', '2021-04-20 00:00:00.000000', 0, 0, 0),
(15, '2021-04-20 00:00:00.000000', 'Muhammad Ammad Salman', 'Muhammad Salman', 'M', 'S', '1992-12-03 00:00:00.000000', '2021-04-12 00:00:00.000000', '2021-04-12 00:00:00.000000', 2, 1, 'Flat # A-107, Block A, Karachi Center Apartment, PIB Colony, Near University Road, Karachi.', 'Flat # A-107, Block A, Karachi Center Ap', 'N/A', 'N/A', 'N/A', 'N/A', '0315-0236573', '42201-0244904-9', '2020-07-01', '2029-07-31', 60, 'N/A', 'muhammad_ammad.salman@roche.com', 'N', 1, 145, 22, 33, 55, 10, 19, 0, 722, 1, 46, 1, 'N', 1, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'NotApplicable', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', '0', 'N/A', 'Personnel Done', 'N', 'N', 'N', 'N', 'N', 'N', 0x0000, '', '2021-04-12', '2021-04-12', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 1543, '2021-04-20 12:58:17.713000', 1, 'NA', '2021-04-20 00:00:00.000000', 0, 0, 0),
(15, '2021-04-20 00:00:00.000000', 'Muhammad Ammad Salman', 'Muhammad Salman', 'M', 'S', '1992-12-03 00:00:00.000000', '2021-04-12 00:00:00.000000', '2021-04-12 00:00:00.000000', 2, 1, 'Flat # A-107, Block A, Karachi Center Apartment, PIB Colony, Near University Road, Karachi.', 'Flat # A-107, Block A, Karachi Center Ap', 'N/A', 'N/A', 'N/A', 'N/A', '0315-0236573', '42201-0244904-9', '2020-07-01', '2029-07-31', 60, 'N/A', 'muhammad_ammad.salman@roche.com', 'N', 1, 145, 22, 33, 55, 10, 19, 0, 722, 1, 46, 1, 'N', 1, 1, 'PK84MEZN0001650101831603', 6, 100, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'Y', 'N', 'N', 'N', 'N', 'N', 'Fixed', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', 'N/A', 'Payroll Done', 'N', 'N', 'C', 'N', 'N', 'N', 0x0000, '', '2021-04-12', '2021-04-12', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 1543, '2021-04-20 13:00:06.843000', 1, 'NA', '2021-04-20 00:00:00.000000', 0, 0, 0),
(15, '2021-04-20 00:00:00.000000', 'Muhammad Ammad Salman', 'Muhammad Salman', 'M', 'S', '1992-12-03 00:00:00.000000', '2021-04-12 00:00:00.000000', '2021-04-12 00:00:00.000000', 2, 1, 'Flat # A-107, Block A, Karachi Center Apartment, PIB Colony, Near University Road, Karachi.', 'Flat # A-107, Block A, Karachi Center Ap', 'N/A', 'N/A', 'N/A', 'N/A', '0315-0236573', '42201-0244904-9', '2020-07-01', '2029-07-31', 60, 'N/A', 'muhammad_ammad.salman@roche.com', 'N', 1, 145, 22, 33, 55, 10, 19, 0, 722, 1, 46, 1, 'N', 1, 1, 'PK84MEZN0001650101831603', 6, 100, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'Y', 'N', 'N', 'N', 'N', 'N', 'Fixed', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', 'N/A', 'Payroll Done', 'N', 'N', 'C', 'N', 'N', 'N', 0x0000, '', '2021-04-12', '2021-04-12', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 1543, '2021-04-20 13:00:06.850000', 1, 'NA', '2021-04-20 00:00:00.000000', 0, 0, 0),
(16, '2021-05-20 00:00:00.000000', 'Rabeea Sarwar', 'Muhammad Sarwar', 'F', 'M', '1994-03-05 00:00:00.000000', '2021-04-19 00:00:00.000000', '2021-04-19 00:00:00.000000', 2, 1, '292, Hunza Block, Allama Iqbal Town, Lahore', '292, Hunza Block, Allama Iqbal Town, Lah', 'N/A', 'N/A', 'N/A', 'N/A', '03184075918', '33401-0658737-4', '2020-07-01', '2025-12-31', 60, 'N/A', 'rabeea.sarwar@roche.com', 'N', 1, 178, 22, 42, 37, 11, 51, 0, 722, 1, 28, 1, 'N', 1, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'NotApplicable', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', '0', 'N/A', 'Personnel Done', 'N', 'N', 'N', 'N', 'N', 'N', 0x0000, '', '2021-04-19', '2021-04-19', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 1543, '2021-05-20 09:48:50.320000', 1, 'NA', '2021-05-20 00:00:00.000000', 0, 0, 0),
(16, '2021-05-20 00:00:00.000000', 'Rabeea Sarwar', 'Muhammad Sarwar', 'F', 'M', '1994-03-05 00:00:00.000000', '2021-04-19 00:00:00.000000', '2021-04-19 00:00:00.000000', 2, 1, '292, Hunza Block, Allama Iqbal Town, Lahore', '292, Hunza Block, Allama Iqbal Town, Lah', 'N/A', 'N/A', 'N/A', 'N/A', '03184075918', '33401-0658737-4', '2020-07-01', '2025-12-31', 60, 'N/A', 'rabeea.sarwar@roche.com', 'N', 1, 178, 22, 42, 37, 11, 51, 0, 722, 1, 28, 1, 'N', 1, 1, 'PK93HABB0012487902323403', 1, 0, 100, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'Y', 'N', 'N', 'N', 'N', 'N', 'Fixed', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', 'N/A', 'Payroll Done', 'N', 'N', 'C', 'N', 'N', 'N', 0x0000, '', '2021-04-19', '2021-04-19', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 1543, '2021-05-20 09:51:26.760000', 1, 'NA', '2021-05-20 00:00:00.000000', 0, 0, 0),
(16, '2021-05-20 00:00:00.000000', 'Rabeea Sarwar', 'Muhammad Sarwar', 'F', 'M', '1994-03-05 00:00:00.000000', '2021-04-19 00:00:00.000000', '2021-04-19 00:00:00.000000', 2, 1, '292, Hunza Block, Allama Iqbal Town, Lahore', '292, Hunza Block, Allama Iqbal Town, Lah', 'N/A', 'N/A', 'N/A', 'N/A', '03184075918', '33401-0658737-4', '2020-07-01', '2025-12-31', 60, 'N/A', 'rabeea.sarwar@roche.com', 'N', 1, 178, 22, 42, 37, 11, 51, 0, 722, 1, 28, 1, 'N', 1, 1, 'PK93HABB0012487902323403', 1, 0, 100, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'Y', 'N', 'N', 'N', 'N', 'N', 'Fixed', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', 'N/A', 'Payroll Done', 'N', 'N', 'C', 'N', 'N', 'N', 0x0000, '', '2021-04-19', '2021-04-19', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 1543, '2021-05-20 09:51:26.767000', 1, 'NA', '2021-05-20 00:00:00.000000', 0, 0, 0),
(17, '2021-06-21 00:00:00.000000', 'Syed Usman Jawaid Bukhari', 'Syed Jawaid Habib Bukhari', 'M', 'M', '1989-08-02 00:00:00.000000', '2021-06-07 00:00:00.000000', '2021-06-07 00:00:00.000000', 2, 1, 'A-83, Govt. Teachers Housing Society, Sector 16-A, Gulzar-e-Hijri, Karachi', 'A-83, Govt. Teachers Housing Society, Se', 'N/A', 'N/A', 'N/A', 'N/A', '03452501130', '42201-1157483-7', '2020-07-01', '2029-12-31', 60, 'N/A', 'syed.usman_jawaid_bukhari@roche.com', 'N', 1, 168, 19, 28, 23, 10, 42, 0, 845, 1, 14, 1, 'N', 1, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'NotApplicable', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', '0', 'N/A', 'Personnel Done', 'N', 'N', 'N', 'N', 'N', 'N', 0x0000, '', '2021-06-07', '2021-06-07', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 1543, '2021-06-21 13:44:37.970000', 1, 'NA', '2021-06-21 00:00:00.000000', 0, 0, 0),
(17, '2021-06-21 00:00:00.000000', 'Syed Usman Jawaid Bukhari', 'Syed Jawaid Habib Bukhari', 'M', 'M', '1989-08-02 00:00:00.000000', '2021-06-07 00:00:00.000000', '2021-06-07 00:00:00.000000', 2, 1, 'A-83, Govt. Teachers Housing Society, Sector 16-A, Gulzar-e-Hijri, Karachi', 'A-83, Govt. Teachers Housing Society, Se', 'N/A', 'N/A', 'N/A', 'N/A', '03452501130', '42201-1157483-7', '2020-07-01', '2029-12-31', 60, 'N/A', 'syed.usman_jawaid_bukhari@roche.com', 'N', 1, 192, 19, 28, 23, 10, 42, 0, 845, 1, 14, 1, 'N', 1, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'NotApplicable', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', '0', 'N/A', 'Personnel Done', 'N', 'N', 'N', 'N', 'N', 'N', 0x0000, '', '2021-06-07', '2021-06-07', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 1543, '2021-06-21 13:54:37.537000', 1, 'NA', '2021-06-21 00:00:00.000000', 0, 0, 0),
(17, '2021-06-21 00:00:00.000000', 'Syed Usman Jawaid Bukhari', 'Syed Jawaid Habib Bukhari', 'M', 'M', '1989-08-02 00:00:00.000000', '2021-06-07 00:00:00.000000', '2021-06-07 00:00:00.000000', 2, 1, 'A-83, Govt. Teachers Housing Society, Sector 16-A, Gulzar-e-Hijri, Karachi', 'A-83, Govt. Teachers Housing Society, Se', 'N/A', 'N/A', 'N/A', 'N/A', '03452501130', '42201-1157483-7', '2020-07-01', '2029-12-31', 60, 'N/A', 'syed.usman_jawaid_bukhari@roche.com', 'N', 1, 192, 19, 28, 23, 10, 42, 0, 845, 1, 14, 1, 'N', 1, 1, 'PK65 HABB 23807000286003PK65 H', 0, 100, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'Y', 'N', 'N', 'N', 'N', 'N', 'Fixed', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', 'N/A', 'Payroll Done', 'N', 'N', 'C', 'N', 'N', 'N', 0x0000, '', '2021-06-07', '2021-06-07', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 1543, '2021-06-21 13:58:03.920000', 1, 'NA', '2021-06-21 00:00:00.000000', 0, 0, 0),
(17, '2021-06-21 00:00:00.000000', 'Syed Usman Jawaid Bukhari', 'Syed Jawaid Habib Bukhari', 'M', 'M', '1989-08-02 00:00:00.000000', '2021-06-07 00:00:00.000000', '2021-06-07 00:00:00.000000', 2, 1, 'A-83, Govt. Teachers Housing Society, Sector 16-A, Gulzar-e-Hijri, Karachi', 'A-83, Govt. Teachers Housing Society, Se', 'N/A', 'N/A', 'N/A', 'N/A', '03452501130', '42201-1157483-7', '2020-07-01', '2029-12-31', 60, 'N/A', 'syed.usman_jawaid_bukhari@roche.com', 'N', 1, 192, 19, 28, 23, 10, 42, 0, 845, 1, 14, 1, 'N', 1, 1, 'PK65 HABB 23807000286003PK65 H', 0, 100, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'Y', 'N', 'N', 'N', 'N', 'N', 'Fixed', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', 'N/A', 'Payroll Done', 'N', 'N', 'C', 'N', 'N', 'N', 0x0000, '', '2021-06-07', '2021-06-07', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 1543, '2021-06-21 13:58:03.923000', 1, 'NA', '2021-06-21 00:00:00.000000', 0, 0, 0),
(22, '2021-09-21 00:00:00.000000', 'Ghulam Mustafa', 'Ali Sher', 'M', 'S', '1995-03-20 00:00:00.000000', '2021-09-01 00:00:00.000000', '2021-09-01 00:00:00.000000', 2, 1, 'House No: 1280, St # 05, Memon Mohalla, P.O & Tehsil Gambat District Khairpur', 'House No: 1280, St # 05, Memon Mohalla, ', 'N/A', 'N/A', 'N/A', 'N/A', '03073708810', '45202-4054827-7', '2021-07-08', '2030-11-20', 60, 'N/A', 'ghulam.memon@roche.com', 'N', 1, 145, 22, 33, 56, 10, 10, 0, 722, 1, 47, 1, 'N', 1, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'NotApplicable', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', '0', 'N/A', 'Personnel Done', 'N', 'N', 'N', 'N', 'N', 'N', 0x0000, '', '2021-09-01', '2021-09-01', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 1543, '2021-09-21 09:23:20.893000', 1, 'NA', '2021-09-21 00:00:00.000000', 0, 0, 0),
(22, '2021-09-21 00:00:00.000000', 'Ghulam Mustafa', 'Ali Sher', 'M', 'S', '1995-03-20 00:00:00.000000', '2021-09-01 00:00:00.000000', '2021-09-01 00:00:00.000000', 2, 1, 'House No: 1280, St # 05, Memon Mohalla, P.O & Tehsil Gambat District Khairpur', 'House No: 1280, St # 05, Memon Mohalla, ', 'N/A', 'N/A', 'N/A', 'N/A', '03073708810', '45202-4054827-7', '2021-07-08', '2030-11-20', 60, 'N/A', 'ghulam.memon@roche.com', 'N', 1, 145, 22, 33, 56, 10, 10, 0, 722, 1, 47, 1, 'N', 1, 1, 'PK65HABB0014957935375903', 1, 100, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'Y', 'N', 'N', 'N', 'N', 'N', 'Performance', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', 'N/A', 'Payroll Done', 'N', 'N', 'C', 'N', 'N', 'N', 0x0000, '', '2021-09-01', '2021-09-01', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 1543, '2021-09-21 09:25:03.587000', 1, 'NA', '2021-09-21 00:00:00.000000', 0, 0, 0),
(22, '2021-09-21 00:00:00.000000', 'Ghulam Mustafa', 'Ali Sher', 'M', 'S', '1995-03-20 00:00:00.000000', '2021-09-01 00:00:00.000000', '2021-09-01 00:00:00.000000', 2, 1, 'House No: 1280, St # 05, Memon Mohalla, P.O & Tehsil Gambat District Khairpur', 'House No: 1280, St # 05, Memon Mohalla, ', 'N/A', 'N/A', 'N/A', 'N/A', '03073708810', '45202-4054827-7', '2021-07-08', '2030-11-20', 60, 'N/A', 'ghulam.memon@roche.com', 'N', 1, 145, 22, 33, 56, 10, 10, 0, 722, 1, 47, 1, 'N', 1, 1, 'PK65HABB0014957935375903', 1, 100, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'Y', 'N', 'N', 'N', 'N', 'N', 'Performance', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', 'N/A', 'Payroll Done', 'N', 'N', 'C', 'N', 'N', 'N', 0x0000, '', '2021-09-01', '2021-09-01', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 1543, '2021-09-21 09:25:03.593000', 1, 'NA', '2021-09-21 00:00:00.000000', 0, 0, 0),
(23, '2021-09-21 00:00:00.000000', 'Muhammad Anus Khan', 'Amir Kaleem Khan', 'M', 'S', '1996-10-04 00:00:00.000000', '2021-09-01 00:00:00.000000', '2021-09-01 00:00:00.000000', 2, 1, 'House No:118-B Block:3-A Gulistan-e-Johar Karachi', 'House No:48/C, Block-E, Unit:8 Latifabad', 'N/A', 'N/A', 'N/A', 'N/A', '03063082795', '41304-3752965-7', '2021-07-01', '2030-11-12', 60, 'N/A', 'muhammad.anus@roche.com', 'N', 1, 145, 22, 33, 55, 10, 10, 0, 722, 1, 46, 1, 'N', 1, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'NotApplicable', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', '0', 'N/A', 'Personnel Done', 'N', 'N', 'N', 'N', 'N', 'N', 0x0000, '', '2021-09-01', '2021-09-01', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 1543, '2021-09-21 09:32:02.220000', 1, 'NA', '2021-09-21 00:00:00.000000', 0, 0, 0),
(23, '2021-09-21 00:00:00.000000', 'Muhammad Anus Khan', 'Amir Kaleem Khan', 'M', 'S', '1996-10-04 00:00:00.000000', '2021-09-01 00:00:00.000000', '2021-09-01 00:00:00.000000', 2, 1, 'House No:118-B Block:3-A Gulistan-e-Johar Karachi', 'House No:48/C, Block-E, Unit:8 Latifabad', 'N/A', 'N/A', 'N/A', 'N/A', '03063082795', '41304-3752965-7', '2021-07-01', '2030-11-12', 60, 'N/A', 'muhammad.anus@roche.com', 'N', 1, 145, 22, 33, 55, 10, 10, 0, 722, 1, 46, 1, 'N', 1, 1, 'PK95UNIL0109000225857371', 2, 100, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'Y', 'N', 'N', 'N', 'N', 'N', 'Performance', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', 'N/A', 'Payroll Done', 'N', 'N', 'C', 'N', 'N', 'N', 0x0000, '', '2021-09-01', '2021-09-01', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 1543, '2021-09-21 09:33:19.983000', 1, 'NA', '2021-09-21 00:00:00.000000', 0, 0, 0),
(23, '2021-09-21 00:00:00.000000', 'Muhammad Anus Khan', 'Amir Kaleem Khan', 'M', 'S', '1996-10-04 00:00:00.000000', '2021-09-01 00:00:00.000000', '2021-09-01 00:00:00.000000', 2, 1, 'House No:118-B Block:3-A Gulistan-e-Johar Karachi', 'House No:48/C, Block-E, Unit:8 Latifabad', 'N/A', 'N/A', 'N/A', 'N/A', '03063082795', '41304-3752965-7', '2021-07-01', '2030-11-12', 60, 'N/A', 'muhammad.anus@roche.com', 'N', 1, 145, 22, 33, 55, 10, 10, 0, 722, 1, 46, 1, 'N', 1, 1, 'PK95UNIL0109000225857371', 2, 100, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'Y', 'N', 'N', 'N', 'N', 'N', 'Performance', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', 'N/A', 'Payroll Done', 'N', 'N', 'C', 'N', 'N', 'N', 0x0000, '', '2021-09-01', '2021-09-01', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 1543, '2021-09-21 09:33:19.990000', 1, 'NA', '2021-09-21 00:00:00.000000', 0, 0, 0),
(24, '2021-09-21 00:00:00.000000', 'Babar Saddique', 'Muhammad Saddique', 'M', 'M', '1987-10-01 00:00:00.000000', '2021-09-01 00:00:00.000000', '2021-09-01 00:00:00.000000', 2, 1, '3/8 Temple Road Lahore', '3/8 Temple Road Lahore', '03344376480', 'N/A', 'N/A', 'N/A', '03204018997', '35202-9114496-1', '2021-07-08', '2030-07-17', 60, 'N/A', 'babar.saddique@roche.com', 'N', 1, 145, 22, 33, 55, 11, 10, 0, 722, 1, 46, 1, 'N', 1, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'NotApplicable', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', '0', 'engr.babar@yahoo.com', 'Personnel Done', 'N', 'N', 'N', 'N', 'N', 'N', 0x0000, '', '2021-09-01', '2021-09-01', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 1543, '2021-09-21 09:46:39.293000', 1, 'NA', '2021-09-21 00:00:00.000000', 0, 0, 0),
(24, '2021-09-21 00:00:00.000000', 'Babar Saddique', 'Muhammad Saddique', 'M', 'M', '1987-10-01 00:00:00.000000', '2021-09-01 00:00:00.000000', '2021-09-01 00:00:00.000000', 2, 1, '3/8 Temple Road Lahore', '3/8 Temple Road Lahore', '03344376480', 'N/A', 'N/A', 'N/A', '03204018997', '35202-9114496-1', '2021-07-08', '2030-07-17', 60, 'N/A', 'babar.saddique@roche.com', 'N', 1, 145, 22, 33, 55, 11, 10, 0, 722, 1, 46, 1, 'N', 1, 1, 'PK91HABB0010607900543001', 1, 100, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'Y', 'N', 'N', 'N', 'N', 'N', 'Performance', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', 'engr.babar@yahoo.com', 'Payroll Done', 'N', 'N', 'C', 'N', 'N', 'N', 0x0000, '', '2021-09-01', '2021-09-01', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 1543, '2021-09-21 09:49:43.900000', 1, 'NA', '2021-09-21 00:00:00.000000', 0, 0, 0),
(18, '2021-07-19 00:00:00.000000', 'Neha Khan', 'Ihsan Muhammad Ali Khan', 'F', 'M', '1992-08-17 00:00:00.000000', '2021-07-05 00:00:00.000000', '2021-07-05 00:00:00.000000', 1, 1, 'House No. A3, Block 15, Gulshan-e-Iqbal, Karachi', 'House No. A3, Block 15, Gulshan-e-Iqbal,', 'N/A', 'N/A', 'N/A', 'N/A', '03202304181', '42201-7498948-8', '2021-07-01', '2029-06-06', 60, 'N/A', 'neha.khan@roche.com', 'N', 1, 206, 18, 1, 27, 10, 7, 0, 1492, 1, 18, 1, 'N', 1, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'NotApplicable', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', '0', 'N/A', 'Personnel Done', 'N', 'N', 'N', 'N', 'N', 'N', 0x0000, '', '2021-07-05', '2021-07-05', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 1543, '2021-07-19 16:14:30.320000', 1, 'NA', '2021-07-19 00:00:00.000000', 0, 0, 0),
(18, '2021-07-19 00:00:00.000000', 'Neha Khan', 'Ihsan Muhammad Ali Khan', 'F', 'M', '1992-08-17 00:00:00.000000', '2021-07-05 00:00:00.000000', '2021-07-05 00:00:00.000000', 1, 1, 'House No. A3, Block 15, Gulshan-e-Iqbal, Karachi', 'House No. A3, Block 15, Gulshan-e-Iqbal,', 'N/A', 'N/A', 'N/A', 'N/A', '03202304181', '42201-7498948-8', '2021-07-01', '2029-06-06', 60, 'N/A', 'neha.khan@roche.com', 'N', 1, 206, 18, 1, 27, 10, 7, 0, 1492, 1, 18, 1, 'N', 1, 1, 'PK96FAYS0210006900103221', 2, 100, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'Y', 'N', 'N', 'N', 'N', 'N', 'Performance', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', 'N/A', 'Payroll Done', 'N', 'N', 'C', 'N', 'N', 'N', 0x0000, '', '2021-07-05', '2021-07-05', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 1543, '2021-07-19 16:20:23.217000', 1, 'NA', '2021-07-19 00:00:00.000000', 0, 0, 0),
(18, '2021-07-19 00:00:00.000000', 'Neha Khan', 'Ihsan Muhammad Ali Khan', 'F', 'M', '1992-08-17 00:00:00.000000', '2021-07-05 00:00:00.000000', '2021-07-05 00:00:00.000000', 1, 1, 'House No. A3, Block 15, Gulshan-e-Iqbal, Karachi', 'House No. A3, Block 15, Gulshan-e-Iqbal,', 'N/A', 'N/A', 'N/A', 'N/A', '03202304181', '42201-7498948-8', '2021-07-01', '2029-06-06', 60, 'N/A', 'neha.khan@roche.com', 'N', 1, 206, 18, 1, 27, 10, 7, 0, 1492, 1, 18, 1, 'N', 1, 1, 'PK96FAYS0210006900103221', 2, 100, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'Y', 'N', 'N', 'N', 'N', 'N', 'Performance', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', 'N/A', 'Payroll Done', 'N', 'N', 'C', 'N', 'N', 'N', 0x0000, '', '2021-07-05', '2021-07-05', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 1543, '2021-07-19 16:20:23.220000', 1, 'NA', '2021-07-19 00:00:00.000000', 0, 0, 0),
(19, '2021-07-19 00:00:00.000000', 'Daniyal Ali Khan', 'Ahmad Ali Khan', 'M', 'S', '1993-07-11 00:00:00.000000', '2021-07-01 00:00:00.000000', '2021-07-01 00:00:00.000000', 1, 1, 'H54/9 Malir Colony, Near Jinnah Square, Karachi', 'H54/9 Malir Colony, Near Jinnah Square, ', 'N/A', 'N/A', 'N/A', 'N/A', '03312667639', '42000-5748709-1', '2021-07-08', '2029-11-24', 60, 'N/A', 'daniyal_ali.khan@roche.com', 'N', 1, 196, 21, 10, 23, 10, 51, 0, 1249, 1, 14, 1, 'N', 1, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'NotApplicable', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', '0', 'N/A', 'Personnel Done', 'N', 'N', 'N', 'N', 'N', 'N', 0x0000, '', '2021-07-01', '2021-07-01', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 1543, '2021-07-19 16:35:23.563000', 1, 'NA', '2021-07-19 00:00:00.000000', 0, 0, 0);
INSERT INTO `log_tran_appointments` (`Sequence_no`, `Transaction_Date`, `Emp_name`, `Emp_Father_name`, `Emp_sex_code`, `Emp_marital_status`, `Emp_birth_date`, `Emp_appointment_date`, `Emp_confirm_date`, `Emp_category`, `Emp_Leave_category`, `Emp_address_line1`, `Emp_address_line2`, `Emp_home_tel1`, `Emp_home_tel2`, `Emp_office_tel1`, `Emp_office_tel2`, `Emp_mobile_No`, `Emp_nic_no`, `Emp_nic_issue_date`, `Emp_nic_expiry_date`, `Emp_retirement_age`, `Emp_ntn_no`, `Emp_email`, `Confirmation_Flag`, `Empt_Type_code`, `Desig_code`, `Grade_code`, `Cost_Centre_code`, `Dept_code`, `Loc_code`, `Edu_code`, `Transport_code`, `Supervisor_Code`, `Religion_Code`, `Section_code`, `Shift_code`, `Deletion_Flag`, `Emp_Payroll_category`, `Mode_Of_Payment`, `Bank_Account_No1`, `Branch_Code1`, `Bank_Amount_1`, `Bank_Percent_1`, `Bank_Account_No2`, `Branch_Code2`, `Bank_Amount_2`, `Bank_Percent_2`, `Bank_Account_No3`, `Branch_Code3`, `Bank_Amount_3`, `Bank_Percent_3`, `Bank_Account_No4`, `Branch_Code4`, `Bank_Amount_4`, `Bank_Percent_4`, `SESSI_Flag`, `EOBI_Flag`, `Union_Flag`, `Recreation_Club_Flag`, `Meal_Deduction_Flag`, `Overtime_Flag`, `Incentive_Flag`, `Bonus_Type`, `Contact_Person_Name`, `Relationship`, `Contact_address1`, `Contact_address2`, `Contact_home_tel1`, `Contact_home_tel2`, `Emp_Blood_Group`, `EOBI_Number`, `SESSI_Number`, `Vehicle_Registration_Number`, `Status`, `Interest_Flag`, `Zakat_Flag`, `Account_Type1`, `Account_Type2`, `Account_Type3`, `Account_Type4`, `Picture`, `Emp_id`, `Offer_Letter_date`, `Tentative_Joining_date`, `RefferedBy`, `Probationary_period_months`, `Notice_period_months`, `Extended_confirmation_days`, `Permanent_address`, `Nationality`, `PosteddBY`, `PostedOn`, `roster_group_code`, `card_no`, `ContractExpiryDate`, `Position_Code`, `Company_Code`, `UserCode`) VALUES
(19, '2021-07-19 00:00:00.000000', 'Daniyal Ali Khan', 'Ahmad Ali Khan', 'M', 'S', '1993-07-11 00:00:00.000000', '2021-07-01 00:00:00.000000', '2021-07-01 00:00:00.000000', 1, 1, 'H54/9 Malir Colony, Near Jinnah Square, Karachi', 'H54/9 Malir Colony, Near Jinnah Square, ', 'N/A', 'N/A', 'N/A', 'N/A', '03312667639', '42000-5748709-1', '2021-07-08', '2029-11-24', 60, 'N/A', 'daniyal_ali.khan@roche.com', 'N', 1, 196, 21, 10, 23, 10, 51, 0, 1249, 1, 14, 1, 'N', 1, 1, '00277901480703', 1, 100, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'Y', 'N', 'N', 'N', 'N', 'N', 'Performance', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', 'N/A', 'Payroll Done', 'N', 'N', 'C', 'N', 'N', 'N', 0x0000, '', '2021-07-01', '2021-07-01', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 1543, '2021-07-19 16:42:14.190000', 1, 'NA', '2021-07-19 00:00:00.000000', 0, 0, 0),
(19, '2021-07-19 00:00:00.000000', 'Daniyal Ali Khan', 'Ahmad Ali Khan', 'M', 'S', '1993-07-11 00:00:00.000000', '2021-07-01 00:00:00.000000', '2021-07-01 00:00:00.000000', 1, 1, 'H54/9 Malir Colony, Near Jinnah Square, Karachi', 'H54/9 Malir Colony, Near Jinnah Square, ', 'N/A', 'N/A', 'N/A', 'N/A', '03312667639', '42000-5748709-1', '2021-07-08', '2029-11-24', 60, 'N/A', 'daniyal_ali.khan@roche.com', 'N', 1, 196, 21, 10, 23, 10, 51, 0, 1249, 1, 14, 1, 'N', 1, 1, '00277901480703', 1, 100, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'Y', 'N', 'N', 'N', 'N', 'N', 'Performance', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', 'N/A', 'Payroll Done', 'N', 'N', 'C', 'N', 'N', 'N', 0x0000, '', '2021-07-01', '2021-07-01', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 1543, '2021-07-19 16:42:14.197000', 1, 'NA', '2021-07-19 00:00:00.000000', 0, 0, 0),
(20, '2021-07-20 00:00:00.000000', 'Usama Baig', 'Arshad Azhar', 'M', 'M', '1986-01-17 00:00:00.000000', '2021-07-01 00:00:00.000000', '2021-07-01 00:00:00.000000', 1, 1, 'House # 6C, Street # 22 Empress Park, Empress Road, Lahore', 'House # 6C, Street # 22 Empress Park, Em', 'N/A', 'N/A', 'N/A', 'N/A', '03214712199', '35202-9912928-7', '2021-07-08', '2029-07-09', 60, 'N/A', 'Usama.baig@roche.com', 'N', 1, 196, 21, 1056, 23, 11, 13, 0, 1249, 1, 14, 1, 'N', 1, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'NotApplicable', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', '0', 'N/A', 'Personnel Done', 'N', 'N', 'N', 'N', 'N', 'N', 0x0000, '', '2021-07-01', '2021-07-01', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 1543, '2021-07-20 11:23:06.937000', 1, 'NA', '2021-07-20 00:00:00.000000', 0, 0, 0),
(20, '2021-07-20 00:00:00.000000', 'Usama Baig', 'Arshad Azhar', 'M', 'M', '1986-01-17 00:00:00.000000', '2021-07-01 00:00:00.000000', '2021-07-01 00:00:00.000000', 1, 1, 'House # 6C, Street # 22 Empress Park, Empress Road, Lahore', 'House # 6C, Street # 22 Empress Park, Em', 'N/A', 'N/A', 'N/A', 'N/A', '03214712199', '35202-9912928-7', '2021-07-08', '2029-07-09', 60, 'N/A', 'Usama.baig@roche.com', 'N', 1, 196, 21, 1056, 23, 11, 13, 0, 1249, 1, 14, 1, 'N', 1, 1, 'PK37UNIL0112059002114701', 8, 100, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'Y', 'N', 'N', 'N', 'N', 'N', 'Performance', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', 'N/A', 'Payroll Done', 'N', 'N', 'C', 'N', 'N', 'N', 0x0000, '', '2021-07-01', '2021-07-01', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 1543, '2021-07-20 11:25:29.297000', 1, 'NA', '2021-07-20 00:00:00.000000', 0, 0, 0),
(20, '2021-07-20 00:00:00.000000', 'Usama Baig', 'Arshad Azhar', 'M', 'M', '1986-01-17 00:00:00.000000', '2021-07-01 00:00:00.000000', '2021-07-01 00:00:00.000000', 1, 1, 'House # 6C, Street # 22 Empress Park, Empress Road, Lahore', 'House # 6C, Street # 22 Empress Park, Em', 'N/A', 'N/A', 'N/A', 'N/A', '03214712199', '35202-9912928-7', '2021-07-08', '2029-07-09', 60, 'N/A', 'Usama.baig@roche.com', 'N', 1, 196, 21, 1056, 23, 11, 13, 0, 1249, 1, 14, 1, 'N', 1, 1, 'PK37UNIL0112059002114701', 8, 100, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'Y', 'N', 'N', 'N', 'N', 'N', 'Performance', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', 'N/A', 'Payroll Done', 'N', 'N', 'C', 'N', 'N', 'N', 0x0000, '', '2021-07-01', '2021-07-01', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 1543, '2021-07-20 11:25:29.300000', 1, 'NA', '2021-07-20 00:00:00.000000', 0, 0, 0),
(21, '2021-07-20 00:00:00.000000', 'Muhammad Ehtisham Shafique', 'Muhammad Shafique', 'M', 'S', '1992-01-10 00:00:00.000000', '2021-07-01 00:00:00.000000', '2021-07-01 00:00:00.000000', 1, 1, 'H# 12 Street 1/4 Lane 16 Quaid e azam Colony, Chakri road Rawalpindi', 'H# 12 Street 1/4 Lane 16 Quaid e azam Co', 'N/A', 'N/A', 'N/A', 'N/A', '03109466698', '37406-5708669-9', '2021-07-08', '2029-07-09', 60, 'N/A', 'muhammad_ehtisham.shafique@roche.com', 'N', 1, 197, 21, 4, 13, 9, 36, 0, 1192, 1, 4, 1, 'N', 1, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'NotApplicable', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', '0', 'N/A', 'Personnel Done', 'N', 'N', 'N', 'N', 'N', 'N', 0x0000, '', '2021-07-01', '2021-07-01', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 1543, '2021-07-20 11:31:24.660000', 1, 'NA', '2021-07-20 00:00:00.000000', 0, 0, 0),
(21, '2021-07-20 00:00:00.000000', 'Muhammad Ehtisham Shafique', 'Muhammad Shafique', 'M', 'S', '1992-01-10 00:00:00.000000', '2021-07-01 00:00:00.000000', '2021-07-01 00:00:00.000000', 1, 1, 'H# 12 Street 1/4 Lane 16 Quaid e azam Colony, Chakri road Rawalpindi', 'H# 12 Street 1/4 Lane 16 Quaid e azam Co', 'N/A', 'N/A', 'N/A', 'N/A', '03109466698', '37406-5708669-9', '2021-07-08', '2029-07-09', 60, 'N/A', 'muhammad_ehtisham.shafique@roche.com', 'N', 1, 197, 21, 4, 13, 9, 36, 0, 1192, 1, 4, 1, 'N', 1, 1, '04877900941903', 1, 100, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'Y', 'N', 'N', 'N', 'N', 'N', 'Performance', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', 'N/A', 'Payroll Done', 'N', 'N', 'C', 'N', 'N', 'N', 0x0000, '', '2021-07-01', '2021-07-01', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 1543, '2021-07-20 11:32:35.697000', 1, 'NA', '2021-07-20 00:00:00.000000', 0, 0, 0),
(21, '2021-07-20 00:00:00.000000', 'Muhammad Ehtisham Shafique', 'Muhammad Shafique', 'M', 'S', '1992-01-10 00:00:00.000000', '2021-07-01 00:00:00.000000', '2021-07-01 00:00:00.000000', 1, 1, 'H# 12 Street 1/4 Lane 16 Quaid e azam Colony, Chakri road Rawalpindi', 'H# 12 Street 1/4 Lane 16 Quaid e azam Co', 'N/A', 'N/A', 'N/A', 'N/A', '03109466698', '37406-5708669-9', '2021-07-08', '2029-07-09', 60, 'N/A', 'muhammad_ehtisham.shafique@roche.com', 'N', 1, 197, 21, 4, 13, 9, 36, 0, 1192, 1, 4, 1, 'N', 1, 1, '04877900941903', 1, 100, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'Y', 'N', 'N', 'N', 'N', 'N', 'Performance', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', 'N/A', 'Payroll Done', 'N', 'N', 'C', 'N', 'N', 'N', 0x0000, '', '2021-07-01', '2021-07-01', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 1543, '2021-07-20 11:32:35.700000', 1, 'NA', '2021-07-20 00:00:00.000000', 0, 0, 0),
(24, '2021-09-21 00:00:00.000000', 'Babar Saddique', 'Muhammad Saddique', 'M', 'M', '1987-10-01 00:00:00.000000', '2021-09-01 00:00:00.000000', '2021-09-01 00:00:00.000000', 2, 1, '3/8 Temple Road Lahore', '3/8 Temple Road Lahore', '03344376480', 'N/A', 'N/A', 'N/A', '03204018997', '35202-9114496-1', '2021-07-08', '2030-07-17', 60, 'N/A', 'babar.saddique@roche.com', 'N', 1, 145, 22, 33, 55, 11, 10, 0, 722, 1, 46, 1, 'N', 1, 1, 'PK91HABB0010607900543001', 1, 100, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'Y', 'N', 'N', 'N', 'N', 'N', 'Performance', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', 'engr.babar@yahoo.com', 'Payroll Done', 'N', 'N', 'C', 'N', 'N', 'N', 0x0000, '', '2021-09-01', '2021-09-01', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 1543, '2021-09-21 09:49:43.903000', 1, 'NA', '2021-09-21 00:00:00.000000', 0, 0, 0),
(25, '2021-09-21 00:00:00.000000', 'Husaifa Atique', 'Atique ur Rehman', 'M', 'M', '1991-12-18 00:00:00.000000', '2021-09-01 00:00:00.000000', '2021-09-01 00:00:00.000000', 2, 1, 'House No.C-1, Landi Road, PAF Base, Peshawar, KPK', 'House No.C-1, Landi Road, PAF Base, Pesh', 'N/A', 'N/A', 'N/A', 'N/A', '03368008191', '42201-6419603-7', '2021-07-08', '2030-12-18', 60, 'N/A', 'huziafa.atique@roche.com', 'N', 1, 145, 22, 33, 55, 9, 21, 0, 722, 1, 46, 1, 'N', 1, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'NotApplicable', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', '0', 'N/A', 'Personnel Done', 'N', 'N', 'N', 'N', 'N', 'N', 0x0000, '', '2021-09-01', '2021-09-01', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 1543, '2021-09-21 09:56:39.230000', 1, 'NA', '2021-09-21 00:00:00.000000', 0, 0, 0),
(25, '2021-09-21 00:00:00.000000', 'Husaifa Atique', 'Atique ur Rehman', 'M', 'M', '1991-12-18 00:00:00.000000', '2021-09-01 00:00:00.000000', '2021-09-01 00:00:00.000000', 2, 1, 'House No.C-1, Landi Road, PAF Base, Peshawar, KPK', 'House No.C-1, Landi Road, PAF Base, Pesh', 'N/A', 'N/A', 'N/A', 'N/A', '03368008191', '42201-6419603-7', '2021-07-08', '2030-12-18', 60, 'N/A', 'huziafa.atique@roche.com', 'N', 1, 145, 22, 33, 55, 9, 21, 0, 722, 1, 46, 1, 'N', 1, 1, 'PK56HABB0009107902018203', 1, 100, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'Y', 'N', 'N', 'N', 'N', 'N', 'Performance', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', 'N/A', 'Payroll Done', 'N', 'N', 'C', 'N', 'N', 'N', 0x0000, '', '2021-09-01', '2021-09-01', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 1543, '2021-09-21 09:57:32.670000', 1, 'NA', '2021-09-21 00:00:00.000000', 0, 0, 0),
(25, '2021-09-21 00:00:00.000000', 'Husaifa Atique', 'Atique ur Rehman', 'M', 'M', '1991-12-18 00:00:00.000000', '2021-09-01 00:00:00.000000', '2021-09-01 00:00:00.000000', 2, 1, 'House No.C-1, Landi Road, PAF Base, Peshawar, KPK', 'House No.C-1, Landi Road, PAF Base, Pesh', 'N/A', 'N/A', 'N/A', 'N/A', '03368008191', '42201-6419603-7', '2021-07-08', '2030-12-18', 60, 'N/A', 'huziafa.atique@roche.com', 'N', 1, 145, 22, 33, 55, 9, 21, 0, 722, 1, 46, 1, 'N', 1, 1, 'PK56HABB0009107902018203', 1, 100, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'Y', 'N', 'N', 'N', 'N', 'N', 'Performance', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', 'N/A', 'Payroll Done', 'N', 'N', 'C', 'N', 'N', 'N', 0x0000, '', '2021-09-01', '2021-09-01', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 1543, '2021-09-21 09:57:32.673000', 1, 'NA', '2021-09-21 00:00:00.000000', 0, 0, 0),
(25, '2021-09-21 00:00:00.000000', 'Husaifa Atique', 'Atique ur Rehman', 'M', 'M', '1991-12-18 00:00:00.000000', '2021-09-01 00:00:00.000000', '2021-09-01 00:00:00.000000', 2, 1, 'House No.C-1, Landi Road, PAF Base, Peshawar, KPK', 'House No.C-1, Landi Road, PAF Base, Pesh', 'N/A', 'N/A', 'N/A', 'N/A', '03368008191', '42201-6419603-7', '2021-07-08', '2030-12-18', 60, 'N/A', 'huziafa.atique@roche.com', 'N', 1, 145, 22, 33, 55, 9, 21, 0, 722, 1, 46, 1, 'N', 1, 1, 'PK56HABB0009107902018203', 1, 100, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'Y', 'N', 'N', 'N', 'N', 'N', 'Performance', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', 'N/A', 'Payroll Done', 'N', 'N', 'C', 'N', 'N', 'N', 0x0000, '', '2021-09-01', '2021-09-01', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 1543, '2021-09-21 09:57:39.763000', 1, 'NA', '2021-09-21 00:00:00.000000', 0, 0, 0),
(25, '2021-09-21 00:00:00.000000', 'Husaifa Atique', 'Atique ur Rehman', 'M', 'M', '1991-12-18 00:00:00.000000', '2021-09-01 00:00:00.000000', '2021-09-01 00:00:00.000000', 2, 1, 'House No.C-1, Landi Road, PAF Base, Peshawar, KPK', 'House No.C-1, Landi Road, PAF Base, Pesh', 'N/A', 'N/A', 'N/A', 'N/A', '03368008191', '42201-6419603-7', '2021-07-08', '2030-12-18', 60, 'N/A', 'huziafa.atique@roche.com', 'N', 1, 145, 22, 33, 55, 9, 21, 0, 722, 1, 46, 1, 'N', 1, 1, 'PK56HABB0009107902018203', 1, 100, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'Y', 'N', 'N', 'N', 'N', 'N', 'Performance', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', 'N/A', 'Payroll Done', 'N', 'N', 'C', 'N', 'N', 'N', 0x0000, '', '2021-09-01', '2021-09-01', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 1543, '2021-09-21 09:57:39.770000', 1, 'NA', '2021-09-21 00:00:00.000000', 0, 0, 0),
(26, '2021-09-21 00:00:00.000000', 'Muhammad Mobin', 'Abdul Jabbar', 'M', 'S', '1989-04-12 00:00:00.000000', '2021-08-25 00:00:00.000000', '2021-08-25 00:00:00.000000', 1, 1, 'House # D-15/A1, Block 9, Gulshan-e-Iqbal, Karachi', 'House # D-15/A1, Block 9, Gulshan-e-Iqba', 'N/A', 'N/A', 'N/A', 'N/A', '03008258365', '42000-2420212-3', '2021-07-01', '2030-12-12', 60, 'N/A', 'muhammad.mobin@roche.com', 'N', 1, 203, 20, 21, 23, 10, 42, 0, 1610, 1, 14, 1, 'N', 1, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'NotApplicable', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', '0', 'N/A', 'Personnel Done', 'N', 'N', 'N', 'N', 'N', 'N', 0x0000, '', '2021-08-25', '2021-08-25', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 1543, '2021-09-21 10:03:45.043000', 1, 'NA', '2021-09-21 00:00:00.000000', 0, 0, 0),
(26, '2021-09-21 00:00:00.000000', 'Muhammad Mobin', 'Abdul Jabbar', 'M', 'S', '1989-04-12 00:00:00.000000', '2021-08-25 00:00:00.000000', '2021-08-25 00:00:00.000000', 1, 1, 'House # D-15/A1, Block 9, Gulshan-e-Iqbal, Karachi', 'House # D-15/A1, Block 9, Gulshan-e-Iqba', 'N/A', 'N/A', 'N/A', 'N/A', '03008258365', '42000-2420212-3', '2021-07-01', '2030-12-12', 60, 'N/A', 'muhammad.mobin@roche.com', 'N', 1, 207, 20, 21, 23, 10, 42, 0, 1610, 1, 14, 1, 'N', 1, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'NotApplicable', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', '0', 'N/A', 'Personnel Done', 'N', 'N', 'N', 'N', 'N', 'N', 0x0000, '', '2021-08-25', '2021-08-25', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 1543, '2021-09-21 10:06:47.427000', 1, 'NA', '2021-09-21 00:00:00.000000', 0, 0, 0),
(26, '2021-09-21 00:00:00.000000', 'Muhammad Mobin', 'Abdul Jabbar', 'M', 'S', '1989-04-12 00:00:00.000000', '2021-08-25 00:00:00.000000', '2021-08-25 00:00:00.000000', 1, 1, 'House # D-15/A1, Block 9, Gulshan-e-Iqbal, Karachi', 'House # D-15/A1, Block 9, Gulshan-e-Iqba', 'N/A', 'N/A', 'N/A', 'N/A', '03008258365', '42000-2420212-3', '2021-07-01', '2030-12-12', 60, 'N/A', 'muhammad.mobin@roche.com', 'N', 1, 207, 20, 21, 23, 10, 42, 0, 1610, 1, 14, 1, 'N', 1, 1, 'PK11SCBL0000001712365201', 7, 100, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'Y', 'N', 'N', 'N', 'N', 'N', 'Performance', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', 'N/A', 'Payroll Done', 'N', 'N', 'C', 'N', 'N', 'N', 0x0000, '', '2021-08-25', '2021-08-25', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 1543, '2021-09-21 10:08:02.410000', 1, 'NA', '2021-09-21 00:00:00.000000', 0, 0, 0),
(26, '2021-09-21 00:00:00.000000', 'Muhammad Mobin', 'Abdul Jabbar', 'M', 'S', '1989-04-12 00:00:00.000000', '2021-08-25 00:00:00.000000', '2021-08-25 00:00:00.000000', 1, 1, 'House # D-15/A1, Block 9, Gulshan-e-Iqbal, Karachi', 'House # D-15/A1, Block 9, Gulshan-e-Iqba', 'N/A', 'N/A', 'N/A', 'N/A', '03008258365', '42000-2420212-3', '2021-07-01', '2030-12-12', 60, 'N/A', 'muhammad.mobin@roche.com', 'N', 1, 207, 20, 21, 23, 10, 42, 0, 1610, 1, 14, 1, 'N', 1, 1, 'PK11SCBL0000001712365201', 7, 100, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'Y', 'N', 'N', 'N', 'N', 'N', 'Performance', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', 'N/A', 'Payroll Done', 'N', 'N', 'C', 'N', 'N', 'N', 0x0000, '', '2021-08-25', '2021-08-25', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 1543, '2021-09-21 10:08:02.417000', 1, 'NA', '2021-09-21 00:00:00.000000', 0, 0, 0),
(27, '2021-09-21 00:00:00.000000', 'Hafsa Shamsie', 'Syed Makhdoom Hussain', 'F', 'M', '1970-09-11 00:00:00.000000', '2021-09-01 00:00:00.000000', '2021-09-01 00:00:00.000000', 1, 1, '14-B, 11th Central Street Phase II DHA.', '14-B, 11th Central Street Phase II DHA.', 'N/A', 'N/A', 'N/A', 'N/A', '923008228897', '42301-2377433-4', '2021-07-01', '2030-11-21', 60, 'N/A', 'hafsa.shamsie@roche.com', 'N', 1, 174, 25, 14, 36, 10, 33, 0, 0, 1, 27, 1, 'N', 1, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'NotApplicable', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', '0', 'N/A', 'Personnel Done', 'N', 'N', 'N', 'N', 'N', 'N', 0x0000, '', '2021-09-01', '2021-09-01', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 1543, '2021-09-21 10:13:34.810000', 1, 'NA', '2021-09-21 00:00:00.000000', 0, 0, 0),
(27, '2021-09-21 00:00:00.000000', 'Hafsa Shamsie', 'Syed Makhdoom Hussain', 'F', 'M', '1970-09-11 00:00:00.000000', '2021-09-01 00:00:00.000000', '2021-09-01 00:00:00.000000', 1, 1, '14-B, 11th Central Street Phase II DHA.', '14-B, 11th Central Street Phase II DHA.', 'N/A', 'N/A', 'N/A', 'N/A', '923008228897', '42301-2377433-4', '2021-07-01', '2030-11-21', 60, 'N/A', 'hafsa.shamsie@roche.com', 'N', 1, 208, 25, 14, 36, 10, 33, 0, 0, 1, 27, 1, 'N', 1, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'NotApplicable', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', '0', 'N/A', 'Personnel Done', 'N', 'N', 'N', 'N', 'N', 'N', 0x0000, '', '2021-09-01', '2021-09-01', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 1543, '2021-09-21 10:14:41.547000', 1, 'NA', '2021-09-21 00:00:00.000000', 0, 0, 0),
(27, '2021-09-21 00:00:00.000000', 'Hafsa Shamsie', 'Syed Makhdoom Hussain', 'F', 'M', '1970-09-11 00:00:00.000000', '2021-09-01 00:00:00.000000', '2021-09-01 00:00:00.000000', 1, 1, '14-B, 11th Central Street Phase II DHA.', '14-B, 11th Central Street Phase II DHA.', 'N/A', 'N/A', 'N/A', 'N/A', '923008228897', '42301-2377433-4', '2021-07-01', '2030-11-21', 60, 'N/A', 'hafsa.shamsie@roche.com', 'N', 1, 208, 25, 14, 36, 10, 33, 0, 0, 1, 27, 1, 'N', 1, 1, 'PK23HABB0024410097009401', 1, 100, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'Y', 'N', 'N', 'N', 'N', 'N', 'Performance', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', 'N/A', 'Payroll Done', 'N', 'N', 'C', 'N', 'N', 'N', 0x0000, '', '2021-09-01', '2021-09-01', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 1543, '2021-09-21 10:17:01.517000', 1, 'NA', '2021-09-21 00:00:00.000000', 0, 0, 0),
(27, '2021-09-21 00:00:00.000000', 'Hafsa Shamsie', 'Syed Makhdoom Hussain', 'F', 'M', '1970-09-11 00:00:00.000000', '2021-09-01 00:00:00.000000', '2021-09-01 00:00:00.000000', 1, 1, '14-B, 11th Central Street Phase II DHA.', '14-B, 11th Central Street Phase II DHA.', 'N/A', 'N/A', 'N/A', 'N/A', '923008228897', '42301-2377433-4', '2021-07-01', '2030-11-21', 60, 'N/A', 'hafsa.shamsie@roche.com', 'N', 1, 208, 25, 14, 36, 10, 33, 0, 0, 1, 27, 1, 'N', 1, 1, 'PK23HABB0024410097009401', 1, 100, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'Y', 'N', 'N', 'N', 'N', 'N', 'Performance', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', 'N/A', 'Payroll Done', 'N', 'N', 'C', 'N', 'N', 'N', 0x0000, '', '2021-09-01', '2021-09-01', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 1543, '2021-09-21 10:17:01.520000', 1, 'NA', '2021-09-21 00:00:00.000000', 0, 0, 0),
(28, '2021-12-20 00:00:00.000000', 'Osama Ali Ghouri', 'Muhammad Asrar Ullah', 'M', 'S', '1994-02-27 00:00:00.000000', '2021-11-15 00:00:00.000000', '2021-11-15 00:00:00.000000', 2, 1, 'R-515 Block 19 Al-Noor Society, Federal B, Area, Karachi', 'R-515 Block 19 Al-Noor Society, Federal ', 'N/A', 'N/A', 'N/A', 'N/A', '03312180490', '42101-4130852-7', '2021-07-08', '2030-06-19', 60, 'N/A', 'osama_ali.ghouri@roche.com', 'N', 1, 146, 0, 33, 55, 10, 19, 0, 722, 1, 46, 1, 'N', 1, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'NotApplicable', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', '0', 'N/A', 'Personnel Done', 'N', 'N', 'N', 'N', 'N', 'N', 0x0000, '', '2021-11-15', '2021-11-15', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 1543, '2021-12-20 12:45:03.713000', 1, 'NA', '2021-12-20 00:00:00.000000', 0, 0, 0),
(28, '2021-12-20 00:00:00.000000', 'Osama Ali Ghouri', 'Muhammad Asrar Ullah', 'M', 'S', '1994-02-27 00:00:00.000000', '2021-11-15 00:00:00.000000', '2021-11-15 00:00:00.000000', 2, 1, 'R-515 Block 19 Al-Noor Society, Federal B, Area, Karachi', 'R-515 Block 19 Al-Noor Society, Federal ', 'N/A', 'N/A', 'N/A', 'N/A', '03312180490', '42101-4130852-7', '2021-07-08', '2030-06-19', 60, 'N/A', 'osama_ali.ghouri@roche.com', 'N', 1, 146, 0, 33, 55, 10, 19, 0, 722, 1, 46, 1, 'N', 1, 1, 'PK58BAHL1016009501791601', 2, 100, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'Y', 'N', 'N', 'N', 'N', 'N', 'Performance', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', 'N/A', 'Payroll Done', 'N', 'N', 'C', 'N', 'N', 'N', 0x0000, '', '2021-11-15', '2021-11-15', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 1543, '2021-12-20 12:47:08.037000', 1, 'NA', '2021-12-20 00:00:00.000000', 0, 0, 0),
(28, '2021-12-20 00:00:00.000000', 'Osama Ali Ghouri', 'Muhammad Asrar Ullah', 'M', 'S', '1994-02-27 00:00:00.000000', '2021-11-15 00:00:00.000000', '2021-11-15 00:00:00.000000', 2, 1, 'R-515 Block 19 Al-Noor Society, Federal B, Area, Karachi', 'R-515 Block 19 Al-Noor Society, Federal ', 'N/A', 'N/A', 'N/A', 'N/A', '03312180490', '42101-4130852-7', '2021-07-08', '2030-06-19', 60, 'N/A', 'osama_ali.ghouri@roche.com', 'N', 1, 146, 0, 33, 55, 10, 19, 0, 722, 1, 46, 1, 'N', 1, 1, 'PK58BAHL1016009501791601', 2, 100, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'Y', 'N', 'N', 'N', 'N', 'N', 'Performance', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', 'N/A', 'Payroll Done', 'N', 'N', 'C', 'N', 'N', 'N', 0x0000, '', '2021-11-15', '2021-11-15', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 1543, '2021-12-20 12:47:08.043000', 1, 'NA', '2021-12-20 00:00:00.000000', 0, 0, 0),
(30, '2021-12-20 00:00:00.000000', 'Muhammad Talha Azam', 'Muhammad Azam', 'M', 'S', '1995-03-25 00:00:00.000000', '2021-12-13 00:00:00.000000', '2021-12-13 00:00:00.000000', 2, 1, 'MC 980 Green Town Shah Faisal Colony, Karachi', 'MC 980 Green Town Shah Faisal Colony, Ka', 'N/A', 'N/A', 'N/A', 'N/A', '03100446627', '42201-7343780-5', '2021-07-08', '2029-06-20', 60, 'N/A', 'muhammad_talha.azam@roche.com', 'N', 1, 180, 0, 43, 41, 10, 51, 0, 722, 1, 32, 1, 'N', 1, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'NotApplicable', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', '0', 'N/A', 'Personnel Done', 'N', 'N', 'N', 'N', 'N', 'N', 0x0000, '', '2021-12-13', '2021-12-13', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 1543, '2021-12-20 13:27:33.413000', 1, 'NA', '2021-12-20 00:00:00.000000', 0, 0, 0),
(29, '2021-12-20 00:00:00.000000', 'Shabbir Hussain', 'Muhammad Hanif', 'M', 'M', '1990-05-17 00:00:00.000000', '2021-12-13 00:00:00.000000', '2021-12-13 00:00:00.000000', 2, 1, 'House No. 697, Sabazar Multan Road, Lahore', 'House No. 697, Sabazar Multan Road, Laho', 'N/A', 'N/A', 'N/A', 'N/A', '03084436177', '35202-3166365-5', '2021-07-08', '2029-06-14', 60, 'N/A', 'shabbir.hussain@roche.com', 'N', 1, 130, 0, 33, 55, 11, 36, 0, 722, 1, 46, 1, 'N', 1, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'NotApplicable', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', '0', 'N/A', 'Personnel Done', 'N', 'N', 'N', 'N', 'N', 'N', 0x0000, '', '2021-12-13', '2021-12-13', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 1543, '2021-12-20 13:18:26.950000', 1, 'NA', '2021-12-20 00:00:00.000000', 0, 0, 0),
(29, '2021-12-20 00:00:00.000000', 'Shabbir Hussain', 'Muhammad Hanif', 'M', 'M', '1990-05-17 00:00:00.000000', '2021-12-13 00:00:00.000000', '2021-12-13 00:00:00.000000', 2, 1, 'House No. 697, Sabazar Multan Road, Lahore', 'House No. 697, Sabazar Multan Road, Laho', 'N/A', 'N/A', 'N/A', 'N/A', '03084436177', '35202-3166365-5', '2021-07-08', '2029-06-14', 60, 'N/A', 'shabbir.hussain@roche.com', 'N', 1, 130, 0, 33, 55, 11, 36, 0, 722, 1, 46, 1, 'N', 1, 1, 'PK65MEZN0002090103119501', 6, 100, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'Y', 'N', 'N', 'N', 'N', 'N', 'Performance', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', 'N/A', 'Payroll Done', 'N', 'N', 'C', 'N', 'N', 'N', 0x0000, '', '2021-12-13', '2021-12-13', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 1543, '2021-12-20 13:19:51.743000', 1, 'NA', '2021-12-20 00:00:00.000000', 0, 0, 0),
(29, '2021-12-20 00:00:00.000000', 'Shabbir Hussain', 'Muhammad Hanif', 'M', 'M', '1990-05-17 00:00:00.000000', '2021-12-13 00:00:00.000000', '2021-12-13 00:00:00.000000', 2, 1, 'House No. 697, Sabazar Multan Road, Lahore', 'House No. 697, Sabazar Multan Road, Laho', 'N/A', 'N/A', 'N/A', 'N/A', '03084436177', '35202-3166365-5', '2021-07-08', '2029-06-14', 60, 'N/A', 'shabbir.hussain@roche.com', 'N', 1, 130, 0, 33, 55, 11, 36, 0, 722, 1, 46, 1, 'N', 1, 1, 'PK65MEZN0002090103119501', 6, 100, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'Y', 'N', 'N', 'N', 'N', 'N', 'Performance', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', 'N/A', 'Payroll Done', 'N', 'N', 'C', 'N', 'N', 'N', 0x0000, '', '2021-12-13', '2021-12-13', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 1543, '2021-12-20 13:19:51.757000', 1, 'NA', '2021-12-20 00:00:00.000000', 0, 0, 0),
(30, '2021-12-20 00:00:00.000000', 'Muhammad Talha Azam', 'Muhammad Azam', 'M', 'S', '1995-03-25 00:00:00.000000', '2021-12-13 00:00:00.000000', '2021-12-13 00:00:00.000000', 2, 1, 'MC 980 Green Town Shah Faisal Colony, Karachi', 'MC 980 Green Town Shah Faisal Colony, Ka', 'N/A', 'N/A', 'N/A', 'N/A', '03100446627', '42201-7343780-5', '2021-07-08', '2029-06-20', 60, 'N/A', 'muhammad_talha.azam@roche.com', 'N', 1, 180, 0, 43, 41, 10, 51, 0, 722, 1, 32, 1, 'N', 1, 1, 'PK68UNIL0109000266503088', 8, 100, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'Y', 'N', 'N', 'N', 'N', 'N', 'NotApplicable', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', 'N/A', 'Payroll Done', 'N', 'N', 'C', 'N', 'N', 'N', 0x0000, '', '2021-12-13', '2021-12-13', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 1543, '2021-12-20 13:28:50.550000', 1, 'NA', '2021-12-20 00:00:00.000000', 0, 0, 0),
(30, '2021-12-20 00:00:00.000000', 'Muhammad Talha Azam', 'Muhammad Azam', 'M', 'S', '1995-03-25 00:00:00.000000', '2021-12-13 00:00:00.000000', '2021-12-13 00:00:00.000000', 2, 1, 'MC 980 Green Town Shah Faisal Colony, Karachi', 'MC 980 Green Town Shah Faisal Colony, Ka', 'N/A', 'N/A', 'N/A', 'N/A', '03100446627', '42201-7343780-5', '2021-07-08', '2029-06-20', 60, 'N/A', 'muhammad_talha.azam@roche.com', 'N', 1, 180, 0, 43, 41, 10, 51, 0, 722, 1, 32, 1, 'N', 1, 1, 'PK68UNIL0109000266503088', 8, 100, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'Y', 'N', 'N', 'N', 'N', 'N', 'NotApplicable', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', 'N/A', 'Payroll Done', 'N', 'N', 'C', 'N', 'N', 'N', 0x0000, '', '2021-12-13', '2021-12-13', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 1543, '2021-12-20 13:28:50.557000', 1, 'NA', '2021-12-20 00:00:00.000000', 0, 0, 0),
(28, '2021-12-20 00:00:00.000000', 'Osama Ali Ghouri', 'Muhammad Asrar Ullah', 'M', 'S', '1994-02-27 00:00:00.000000', '2021-11-15 00:00:00.000000', '2021-11-15 00:00:00.000000', 2, 1, 'R-515 Block 19 Al-Noor Society, Federal B, Area, Karachi', 'R-515 Block 19 Al-Noor Society, Federal ', 'N/A', 'N/A', 'N/A', 'N/A', '03312180490', '42101-4130852-7', '2021-07-08', '2030-06-19', 60, 'N/A', 'osama_ali.ghouri@roche.com', 'N', 1, 146, 22, 33, 55, 10, 19, 0, 722, 1, 46, 1, 'N', 1, 1, 'PK58BAHL1016009501791601', 2, 100, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'Y', 'N', 'N', 'N', 'N', 'N', 'Performance', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', 'N/A', 'Payroll Done', 'N', 'N', 'C', 'N', 'N', 'N', 0x0000, '', '2021-11-15', '2021-11-15', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 1543, '2021-12-21 16:06:54.180000', 1, 'NA', '2021-12-20 00:00:00.000000', 0, 0, 0),
(31, '2022-01-19 00:00:00.000000', 'Rao M. Arsalan Toheed', 'Toheed Pervez', 'M', 'M', '1995-01-01 00:00:00.000000', '2021-12-20 00:00:00.000000', '2021-12-20 00:00:00.000000', 2, 1, 'Farooqia Street, Gulgasht, Sikanderabad,Tehsil Shujabad Dist Multan, Multan', 'Farooqia Street, Gulgasht, Sikanderabad,', 'N/A', 'N/A', 'N/A', 'N/A', '0307-2469897', '36304-5045273-9', '2013-03-08', '2029-07-07', 60, 'N/A', 'arsalan.rao@roche.com', 'N', 1, 145, 22, 33, 55, 11, 23, 0, 722, 1, 46, 1, 'N', 1, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'NotApplicable', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', '0', 'N/A', 'Personnel Done', 'N', 'N', 'N', 'N', 'N', 'N', 0x0000, '', '2021-12-20', '2021-12-20', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 1543, '2022-01-19 14:10:45.427000', 1, 'NA', '2022-01-19 00:00:00.000000', 0, 0, 0),
(31, '2022-01-19 00:00:00.000000', 'Rao M. Arsalan Toheed', 'Toheed Pervez', 'M', 'M', '1995-01-01 00:00:00.000000', '2021-12-20 00:00:00.000000', '2021-12-20 00:00:00.000000', 2, 1, 'Farooqia Street, Gulgasht, Sikanderabad,Tehsil Shujabad Dist Multan, Multan', 'Farooqia Street, Gulgasht, Sikanderabad,', 'N/A', 'N/A', 'N/A', 'N/A', '0307-2469897', '36304-5045273-9', '2013-03-08', '2029-07-07', 60, 'N/A', 'arsalan.rao@roche.com', 'N', 1, 145, 22, 33, 55, 11, 23, 0, 722, 1, 46, 1, 'N', 1, 1, 'PK84MEZN0005010103528159', 6, 100, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'Y', 'N', 'N', 'N', 'N', 'N', 'Performance', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', 'N/A', 'Payroll Done', 'N', 'N', 'C', 'N', 'N', 'N', 0x0000, '', '2021-12-20', '2021-12-20', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 1543, '2022-01-19 14:12:46.623000', 1, 'NA', '2022-01-19 00:00:00.000000', 0, 0, 0),
(31, '2022-01-19 00:00:00.000000', 'Rao M. Arsalan Toheed', 'Toheed Pervez', 'M', 'M', '1995-01-01 00:00:00.000000', '2021-12-20 00:00:00.000000', '2021-12-20 00:00:00.000000', 2, 1, 'Farooqia Street, Gulgasht, Sikanderabad,Tehsil Shujabad Dist Multan, Multan', 'Farooqia Street, Gulgasht, Sikanderabad,', 'N/A', 'N/A', 'N/A', 'N/A', '0307-2469897', '36304-5045273-9', '2013-03-08', '2029-07-07', 60, 'N/A', 'arsalan.rao@roche.com', 'N', 1, 145, 22, 33, 55, 11, 23, 0, 722, 1, 46, 1, 'N', 1, 1, 'PK84MEZN0005010103528159', 6, 100, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'Y', 'N', 'N', 'N', 'N', 'N', 'Performance', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', 'N/A', 'Payroll Done', 'N', 'N', 'C', 'N', 'N', 'N', 0x0000, '', '2021-12-20', '2021-12-20', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 1543, '2022-01-19 14:12:46.637000', 1, 'NA', '2022-01-19 00:00:00.000000', 0, 0, 0),
(32, '2022-01-19 00:00:00.000000', 'Hafiz Muhammad Shahbaz Sheikh', 'Muhammad Saleem', 'M', 'M', '1995-09-02 00:00:00.000000', '2021-12-27 00:00:00.000000', '2021-12-27 00:00:00.000000', 2, 1, 'Flat A-1, RS-6 (ST-7), Sector 5A4, North Karachi', 'Flat A-1, RS-6 (ST-7), Sector 5A4, North', 'N/A', 'N/A', 'N/A', 'N/A', '0336-3017352', '42101-3933260-3', '2018-02-03', '2029-07-02', 60, 'N/A', 'shahbaz_sheikh.hafiz_muhammad_shahbaz_sheikh@roche.com', 'N', 1, 139, 22, 36, 49, 10, 38, 0, 722, 1, 40, 1, 'N', 1, 1, 'PK19SCBL000000172724 0201', 7, 100, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'Y', 'N', 'N', 'N', 'N', 'N', 'Performance', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', 'N/A', 'Payroll Done', 'N', 'N', 'C', 'N', 'N', 'N', 0x0000, '', '2021-12-27', '2021-12-27', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 1543, '2022-01-19 14:22:53.370000', 1, 'NA', '2022-01-19 00:00:00.000000', 0, 0, 0),
(30, '2021-12-20 00:00:00.000000', 'Muhammad Talha Azam', 'Muhammad Azam', 'M', 'S', '1995-03-25 00:00:00.000000', '2021-12-13 00:00:00.000000', '2021-12-13 00:00:00.000000', 2, 1, 'MC 980 Green Town Shah Faisal Colony, Karachi', 'MC 980 Green Town Shah Faisal Colony, Ka', 'N/A', 'N/A', 'N/A', 'N/A', '03100446627', '42201-7343780-5', '2021-07-08', '2029-06-20', 60, 'N/A', 'muhammad_talha.azam@roche.com', 'N', 1, 180, 22, 43, 41, 10, 51, 0, 722, 1, 32, 1, 'N', 1, 1, 'PK68UNIL0109000266503088', 8, 100, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'Y', 'N', 'N', 'N', 'N', 'N', 'NotApplicable', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', 'N/A', 'Payroll Done', 'N', 'N', 'C', 'N', 'N', 'N', 0x0000, '', '2021-12-13', '2021-12-13', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 1543, '2021-12-21 14:21:28.820000', 1, 'NA', '2021-12-20 00:00:00.000000', 0, 0, 0),
(29, '2021-12-20 00:00:00.000000', 'Shabbir Hussain', 'Muhammad Hanif', 'M', 'M', '1990-05-17 00:00:00.000000', '2021-12-13 00:00:00.000000', '2021-12-13 00:00:00.000000', 2, 1, 'House No. 697, Sabazar Multan Road, Lahore', 'House No. 697, Sabazar Multan Road, Laho', 'N/A', 'N/A', 'N/A', 'N/A', '03084436177', '35202-3166365-5', '2021-07-08', '2029-06-14', 60, 'N/A', 'shabbir.hussain@roche.com', 'N', 1, 130, 22, 33, 55, 11, 36, 0, 722, 1, 46, 1, 'N', 1, 1, 'PK65MEZN0002090103119501', 6, 100, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'Y', 'N', 'N', 'N', 'N', 'N', 'Performance', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', 'N/A', 'Payroll Done', 'N', 'N', 'C', 'N', 'N', 'N', 0x0000, '', '2021-12-13', '2021-12-13', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 1543, '2021-12-21 14:21:38.440000', 1, 'NA', '2021-12-20 00:00:00.000000', 0, 0, 0),
(28, '2021-12-20 00:00:00.000000', 'Osama Ali Ghouri', 'Muhammad Asrar Ullah', 'M', 'S', '1994-02-27 00:00:00.000000', '2021-11-15 00:00:00.000000', '2021-11-15 00:00:00.000000', 2, 1, 'R-515 Block 19 Al-Noor Society, Federal B, Area, Karachi', 'R-515 Block 19 Al-Noor Society, Federal ', 'N/A', 'N/A', 'N/A', 'N/A', '03312180490', '42101-4130852-7', '2021-07-08', '2030-06-19', 60, 'N/A', 'osama_ali.ghouri@roche.com', 'N', 1, 146, 22, 33, 55, 10, 19, 0, 722, 1, 46, 1, 'N', 1, 1, 'PK58BAHL1016009501791601', 2, 100, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'Y', 'N', 'N', 'N', 'N', 'N', 'Performance', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', 'N/A', 'Payroll Done', 'N', 'N', 'C', 'N', 'N', 'N', 0x0000, '', '2021-11-15', '2021-11-15', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 1543, '2021-12-21 14:21:47.063000', 1, 'NA', '2021-12-20 00:00:00.000000', 0, 0, 0),
(32, '2022-01-19 00:00:00.000000', 'Hafiz Muhammad Shahbaz Sheikh', 'Muhammad Saleem', 'M', 'M', '1995-09-02 00:00:00.000000', '2021-12-27 00:00:00.000000', '2021-12-27 00:00:00.000000', 2, 1, 'Flat A-1, RS-6 (ST-7), Sector 5A4, North Karachi', 'Flat A-1, RS-6 (ST-7), Sector 5A4, North', 'N/A', 'N/A', 'N/A', 'N/A', '0336-3017352', '42101-3933260-3', '2018-02-03', '2029-07-02', 60, 'N/A', 'shahbaz_sheikh.hafiz_muhammad_shahbaz_sheikh@roche.com', 'N', 1, 139, 22, 36, 49, 10, 38, 0, 722, 1, 40, 1, 'N', 1, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'NotApplicable', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', '0', 'N/A', 'Personnel Done', 'N', 'N', 'N', 'N', 'N', 'N', 0x0000, '', '2021-12-27', '2021-12-27', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 1543, '2022-01-19 14:21:32.050000', 1, 'NA', '2022-01-19 00:00:00.000000', 0, 0, 0),
(32, '2022-01-19 00:00:00.000000', 'Hafiz Muhammad Shahbaz Sheikh', 'Muhammad Saleem', 'M', 'M', '1995-09-02 00:00:00.000000', '2021-12-27 00:00:00.000000', '2021-12-27 00:00:00.000000', 2, 1, 'Flat A-1, RS-6 (ST-7), Sector 5A4, North Karachi', 'Flat A-1, RS-6 (ST-7), Sector 5A4, North', 'N/A', 'N/A', 'N/A', 'N/A', '0336-3017352', '42101-3933260-3', '2018-02-03', '2029-07-02', 60, 'N/A', 'shahbaz_sheikh.hafiz_muhammad_shahbaz_sheikh@roche.com', 'N', 1, 139, 22, 36, 49, 10, 38, 0, 722, 1, 40, 1, 'N', 1, 1, 'PK19SCBL000000172724 0201', 7, 100, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'Y', 'N', 'N', 'N', 'N', 'N', 'Performance', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', 'N/A', 'Payroll Done', 'N', 'N', 'C', 'N', 'N', 'N', 0x0000, '', '2021-12-27', '2021-12-27', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 1543, '2022-01-19 14:22:53.380000', 1, 'NA', '2022-01-19 00:00:00.000000', 0, 0, 0),
(33, '2022-01-19 00:00:00.000000', 'Aqib Hameed', 'Abdul Hamid', 'M', 'M', '1992-10-15 00:00:00.000000', '2021-12-31 00:00:00.000000', '2021-12-31 00:00:00.000000', 2, 1, '251-Neelam Block Allama Iqbal Town Lahore', '251-Neelam Block Allama Iqbal Town Lahor', 'N/A', 'N/A', 'N/A', 'N/A', '0331-6466290', '35200-9493996-9', '2020-03-24', '2029-07-23', 60, 'N/A', 'aqibhameed9292@gmail.com', 'N', 1, 139, 22, 36, 48, 11, 33, 0, 722, 1, 39, 1, 'N', 1, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'NotApplicable', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', '0', 'aqibhameed9292@gmail.com', 'Personnel Done', 'N', 'N', 'N', 'N', 'N', 'N', 0x0000, '', '2021-12-31', '2021-12-31', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 1543, '2022-01-19 14:30:22.910000', 1, 'NA', '2022-01-19 00:00:00.000000', 0, 0, 0),
(33, '2022-01-19 00:00:00.000000', 'Aqib Hameed', 'Abdul Hamid', 'M', 'M', '1992-10-15 00:00:00.000000', '2021-12-31 00:00:00.000000', '2021-12-31 00:00:00.000000', 2, 1, '251-Neelam Block Allama Iqbal Town Lahore', '251-Neelam Block Allama Iqbal Town Lahor', 'N/A', 'N/A', 'N/A', 'N/A', '0331-6466290', '35200-9493996-9', '2020-03-24', '2029-07-23', 60, 'N/A', 'aqibhameed9292@gmail.com', 'N', 1, 139, 22, 36, 48, 11, 33, 0, 722, 1, 39, 1, 'N', 1, 1, 'PK60ALFH0028001004694545', 0, 100, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'Y', 'N', 'N', 'N', 'N', 'N', 'Performance', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', 'aqibhameed9292@gmail.com', 'Payroll Done', 'N', 'N', 'C', 'N', 'N', 'N', 0x0000, '', '2021-12-31', '2021-12-31', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 1543, '2022-01-19 14:31:39.323000', 1, 'NA', '2022-01-19 00:00:00.000000', 0, 0, 0),
(33, '2022-01-19 00:00:00.000000', 'Aqib Hameed', 'Abdul Hamid', 'M', 'M', '1992-10-15 00:00:00.000000', '2021-12-31 00:00:00.000000', '2021-12-31 00:00:00.000000', 2, 1, '251-Neelam Block Allama Iqbal Town Lahore', '251-Neelam Block Allama Iqbal Town Lahor', 'N/A', 'N/A', 'N/A', 'N/A', '0331-6466290', '35200-9493996-9', '2020-03-24', '2029-07-23', 60, 'N/A', 'aqibhameed9292@gmail.com', 'N', 1, 139, 22, 36, 48, 11, 33, 0, 722, 1, 39, 1, 'N', 1, 1, 'PK60ALFH0028001004694545', 0, 100, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'Y', 'N', 'N', 'N', 'N', 'N', 'Performance', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', 'aqibhameed9292@gmail.com', 'Payroll Done', 'N', 'N', 'C', 'N', 'N', 'N', 0x0000, '', '2021-12-31', '2021-12-31', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 1543, '2022-01-19 14:31:39.337000', 1, 'NA', '2022-01-19 00:00:00.000000', 0, 0, 0),
(34, '2022-01-19 00:00:00.000000', 'Ghulam Anbia Madni', 'Muhammad Aslam', 'M', 'S', '1996-07-04 00:00:00.000000', '2022-01-04 00:00:00.000000', '2022-01-04 00:00:00.000000', 1, 1, 'LSC-04, Near Maymar Square, Gulshan- e-Iqbal, Block 14, Karachi', 'LSC-04, Near Maymar Square, Gulshan- e-I', 'N/A', 'N/A', 'N/A', 'N/A', '0306-0556617', '37405-7372260-1', '2021-04-21', '2029-04-20', 60, 'N/A', 'ghulam_anbia.madni@roche.com', 'N', 1, 194, 20, 1060, 13, 10, 33, 0, 1192, 1, 1051, 1, 'N', 1, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'NotApplicable', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', '0', 'N/A', 'Personnel Done', 'N', 'N', 'N', 'N', 'N', 'N', 0x0000, '', '2022-01-04', '2022-01-04', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 1543, '2022-01-19 14:53:02.350000', 1, 'NA', '2022-01-19 00:00:00.000000', 0, 0, 0),
(34, '2022-01-19 00:00:00.000000', 'Ghulam Anbia Madni', 'Muhammad Aslam', 'M', 'S', '1996-07-04 00:00:00.000000', '2022-01-04 00:00:00.000000', '2022-01-04 00:00:00.000000', 1, 1, 'LSC-04, Near Maymar Square, Gulshan- e-Iqbal, Block 14, Karachi', 'LSC-04, Near Maymar Square, Gulshan- e-I', 'N/A', 'N/A', 'N/A', 'N/A', '0306-0556617', '37405-7372260-1', '2021-04-21', '2029-04-20', 60, 'N/A', 'ghulam_anbia.madni@roche.com', 'N', 1, 194, 20, 1060, 13, 10, 33, 0, 1192, 1, 1051, 1, 'N', 1, 1, 'PK23HABB0006407992029403', 1, 100, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'Y', 'N', 'N', 'N', 'N', 'N', 'Performance', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', 'N/A', 'Payroll Done', 'N', 'N', 'C', 'N', 'N', 'N', 0x0000, '', '2022-01-04', '2022-01-04', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 1543, '2022-01-19 14:54:18.380000', 1, 'NA', '2022-01-19 00:00:00.000000', 0, 0, 0),
(34, '2022-01-19 00:00:00.000000', 'Ghulam Anbia Madni', 'Muhammad Aslam', 'M', 'S', '1996-07-04 00:00:00.000000', '2022-01-04 00:00:00.000000', '2022-01-04 00:00:00.000000', 1, 1, 'LSC-04, Near Maymar Square, Gulshan- e-Iqbal, Block 14, Karachi', 'LSC-04, Near Maymar Square, Gulshan- e-I', 'N/A', 'N/A', 'N/A', 'N/A', '0306-0556617', '37405-7372260-1', '2021-04-21', '2029-04-20', 60, 'N/A', 'ghulam_anbia.madni@roche.com', 'N', 1, 194, 20, 1060, 13, 10, 33, 0, 1192, 1, 1051, 1, 'N', 1, 1, 'PK23HABB0006407992029403', 1, 100, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'Y', 'N', 'N', 'N', 'N', 'N', 'Performance', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', 'N/A', 'Payroll Done', 'N', 'N', 'C', 'N', 'N', 'N', 0x0000, '', '2022-01-04', '2022-01-04', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 1543, '2022-01-19 14:54:18.393000', 1, 'NA', '2022-01-19 00:00:00.000000', 0, 0, 0),
(35, '2022-02-21 00:00:00.000000', 'Asadullah Mir', 'Tahir Jamil Mir', 'M', 'M', '1993-09-14 00:00:00.000000', '2022-01-19 00:00:00.000000', '2022-01-19 00:00:00.000000', 1, 1, 'Plot # 56/0, Block 6, PECHS, Karachi', 'Plot # 56/0, Block 6, PECHS, Karachi', 'N/A', 'N/A', 'N/A', 'N/A', '\'0347-2936723', '42301-0953962-3', '2016-01-25', '2029-01-26', 60, 'N/A', 'asadullah.mir@roche.com', 'N', 1, 116, 20, 17, 38, 10, 34, 0, 1507, 1, 29, 1, 'N', 1, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'NotApplicable', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', '0', 'N/A', 'Personnel Done', 'N', 'N', 'N', 'N', 'N', 'N', 0x0000, '', '2022-01-19', '2022-01-19', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 1543, '2022-02-21 10:09:34.733000', 1, 'NA', '2022-02-21 00:00:00.000000', 0, 0, 0),
(35, '2022-02-21 00:00:00.000000', 'Asadullah Mir', 'Tahir Jamil Mir', 'M', 'M', '1993-09-14 00:00:00.000000', '2022-01-19 00:00:00.000000', '2022-01-19 00:00:00.000000', 1, 1, 'Plot # 56/0, Block 6, PECHS, Karachi', 'Plot # 56/0, Block 6, PECHS, Karachi', 'N/A', 'N/A', 'N/A', 'N/A', '\'0347-2936723', '42301-0953962-3', '2016-01-25', '2029-01-26', 60, 'N/A', 'asadullah.mir@roche.com', 'N', 1, 116, 20, 17, 38, 10, 34, 0, 1507, 1, 29, 1, 'N', 1, 1, 'PK95SBCL0000001726913301', 7, 100, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'Y', 'N', 'N', 'N', 'N', 'N', 'Performance', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', 'N/A', 'Payroll Done', 'N', 'N', 'C', 'N', 'N', 'N', 0x0000, '', '2022-01-19', '2022-01-19', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 1543, '2022-02-21 10:10:53.623000', 1, 'NA', '2022-02-21 00:00:00.000000', 0, 0, 0),
(35, '2022-02-21 00:00:00.000000', 'Asadullah Mir', 'Tahir Jamil Mir', 'M', 'M', '1993-09-14 00:00:00.000000', '2022-01-19 00:00:00.000000', '2022-01-19 00:00:00.000000', 1, 1, 'Plot # 56/0, Block 6, PECHS, Karachi', 'Plot # 56/0, Block 6, PECHS, Karachi', 'N/A', 'N/A', 'N/A', 'N/A', '\'0347-2936723', '42301-0953962-3', '2016-01-25', '2029-01-26', 60, 'N/A', 'asadullah.mir@roche.com', 'N', 1, 116, 20, 17, 38, 10, 34, 0, 1507, 1, 29, 1, 'N', 1, 1, 'PK95SBCL0000001726913301', 7, 100, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'Y', 'N', 'N', 'N', 'N', 'N', 'Performance', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', 'N/A', 'Payroll Done', 'N', 'N', 'C', 'N', 'N', 'N', 0x0000, '', '2022-01-19', '2022-01-19', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 1543, '2022-02-21 10:10:53.630000', 1, 'NA', '2022-02-21 00:00:00.000000', 0, 0, 0),
(36, '2022-02-21 00:00:00.000000', 'Hafiz M. Nasir Arslan', 'Muhammad Ashraf', 'M', 'S', '1994-07-11 00:00:00.000000', '2022-01-24 00:00:00.000000', '2022-01-24 00:00:00.000000', 2, 1, '1st Floor Shop#07 Eden Garden, Nawab Block Deawoo Road Faisalabad.', '1st Floor Shop#07 Eden Garden, Nawab Blo', 'N/A', 'N/A', 'N/A', 'N/A', '\'0304-1076313', '31202-6887677-7', '2021-12-06', '2029-12-07', 60, 'N/A', 'hafiz_muhammad.nasir_arslan@roche.com', 'N', 1, 145, 21, 33, 55, 11, 24, 0, 722, 1, 46, 1, 'N', 1, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'NotApplicable', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', '0', 'N/A', 'Personnel Done', 'N', 'N', 'N', 'N', 'N', 'N', 0x0000, '', '2022-01-24', '2022-01-24', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 1543, '2022-02-21 10:30:14.643000', 1, 'NA', '2022-02-21 00:00:00.000000', 0, 0, 0),
(36, '2022-02-21 00:00:00.000000', 'Hafiz M. Nasir Arslan', 'Muhammad Ashraf', 'M', 'S', '1994-07-11 00:00:00.000000', '2022-01-24 00:00:00.000000', '2022-01-24 00:00:00.000000', 2, 1, '1st Floor Shop#07 Eden Garden, Nawab Block Deawoo Road Faisalabad.', '1st Floor Shop#07 Eden Garden, Nawab Blo', 'N/A', 'N/A', 'N/A', 'N/A', '\'0304-1076313', '31202-6887677-7', '2021-12-06', '2029-12-07', 60, 'N/A', 'hafiz_muhammad.nasir_arslan@roche.com', 'N', 1, 145, 21, 33, 55, 11, 24, 0, 722, 1, 46, 1, 'N', 1, 1, 'PK11MEZN0002090104210656', 6, 100, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'Y', 'N', 'N', 'N', 'N', 'N', 'Performance', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', 'N/A', 'Payroll Done', 'N', 'N', 'C', 'N', 'N', 'N', 0x0000, '', '2022-01-24', '2022-01-24', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 1543, '2022-02-21 10:31:21.190000', 1, 'NA', '2022-02-21 00:00:00.000000', 0, 0, 0),
(36, '2022-02-21 00:00:00.000000', 'Hafiz M. Nasir Arslan', 'Muhammad Ashraf', 'M', 'S', '1994-07-11 00:00:00.000000', '2022-01-24 00:00:00.000000', '2022-01-24 00:00:00.000000', 2, 1, '1st Floor Shop#07 Eden Garden, Nawab Block Deawoo Road Faisalabad.', '1st Floor Shop#07 Eden Garden, Nawab Blo', 'N/A', 'N/A', 'N/A', 'N/A', '\'0304-1076313', '31202-6887677-7', '2021-12-06', '2029-12-07', 60, 'N/A', 'hafiz_muhammad.nasir_arslan@roche.com', 'N', 1, 145, 21, 33, 55, 11, 24, 0, 722, 1, 46, 1, 'N', 1, 1, 'PK11MEZN0002090104210656', 6, 100, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'Y', 'N', 'N', 'N', 'N', 'N', 'Performance', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', 'N/A', 'Payroll Done', 'N', 'N', 'C', 'N', 'N', 'N', 0x0000, '', '2022-01-24', '2022-01-24', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 1543, '2022-02-21 10:31:21.197000', 1, 'NA', '2022-02-21 00:00:00.000000', 0, 0, 0),
(37, '2022-03-21 00:00:00.000000', 'Khurram Riaz', 'Muhammad Riaz', 'M', 'M', '1976-08-04 00:00:00.000000', '2022-03-04 00:00:00.000000', '2022-03-04 00:00:00.000000', 1, 1, 'E-2, 4th Floor, Mahir Terrace, Pir Ghazi Road, Lahore', 'E-2, 4th Floor, Mahir Terrace, Pir Ghazi', 'N/A', 'N/A', 'N/A', 'N/A', '0333-4374207', '35202-2998613-9', '2021-02-21', '2027-02-20', 60, 'N/A', 'khurram.riaz@roche.com', 'N', 1, 194, 20, 1060, 13, 11, 33, 0, 729, 1, 1051, 1, 'N', 1, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'NotApplicable', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', '0', 'N/A', 'Personnel Done', 'N', 'N', 'N', 'N', 'N', 'N', 0x0000, '', '2022-03-04', '2022-03-04', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 1543, '2022-03-21 15:24:02.383000', 1, 'NA', '2022-03-21 00:00:00.000000', 0, 0, 0),
(38, '2022-03-21 00:00:00.000000', 'Ali Murad Dhamani', 'Muhammad Hanif Dhamani', 'M', 'S', '1998-05-26 00:00:00.000000', '2022-03-14 00:00:00.000000', '2022-03-14 00:00:00.000000', 2, 1, 'Flat No. O-398, Karimabad Colony, F.B Area Block 3, Karachi', 'Flat No. O-398, Karimabad Colony, F.B Ar', 'N/A', 'N/A', 'N/A', 'N/A', '03343933024', '42101-6278229-9', '2016-07-29', '2026-07-30', 60, 'N/A', 'ali_murad.dhamani@roche.com', 'N', 1, 130, 22, 33, 55, 10, 20, 0, 722, 1, 46, 1, 'N', 1, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'NotApplicable', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', '0', 'N/A', 'Personnel Done', 'N', 'N', 'N', 'N', 'N', 'N', 0x0000, '', '2022-03-14', '2022-03-14', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 1543, '2022-03-21 15:38:08.097000', 1, 'NA', '2022-03-21 00:00:00.000000', 0, 0, 0);
INSERT INTO `log_tran_appointments` (`Sequence_no`, `Transaction_Date`, `Emp_name`, `Emp_Father_name`, `Emp_sex_code`, `Emp_marital_status`, `Emp_birth_date`, `Emp_appointment_date`, `Emp_confirm_date`, `Emp_category`, `Emp_Leave_category`, `Emp_address_line1`, `Emp_address_line2`, `Emp_home_tel1`, `Emp_home_tel2`, `Emp_office_tel1`, `Emp_office_tel2`, `Emp_mobile_No`, `Emp_nic_no`, `Emp_nic_issue_date`, `Emp_nic_expiry_date`, `Emp_retirement_age`, `Emp_ntn_no`, `Emp_email`, `Confirmation_Flag`, `Empt_Type_code`, `Desig_code`, `Grade_code`, `Cost_Centre_code`, `Dept_code`, `Loc_code`, `Edu_code`, `Transport_code`, `Supervisor_Code`, `Religion_Code`, `Section_code`, `Shift_code`, `Deletion_Flag`, `Emp_Payroll_category`, `Mode_Of_Payment`, `Bank_Account_No1`, `Branch_Code1`, `Bank_Amount_1`, `Bank_Percent_1`, `Bank_Account_No2`, `Branch_Code2`, `Bank_Amount_2`, `Bank_Percent_2`, `Bank_Account_No3`, `Branch_Code3`, `Bank_Amount_3`, `Bank_Percent_3`, `Bank_Account_No4`, `Branch_Code4`, `Bank_Amount_4`, `Bank_Percent_4`, `SESSI_Flag`, `EOBI_Flag`, `Union_Flag`, `Recreation_Club_Flag`, `Meal_Deduction_Flag`, `Overtime_Flag`, `Incentive_Flag`, `Bonus_Type`, `Contact_Person_Name`, `Relationship`, `Contact_address1`, `Contact_address2`, `Contact_home_tel1`, `Contact_home_tel2`, `Emp_Blood_Group`, `EOBI_Number`, `SESSI_Number`, `Vehicle_Registration_Number`, `Status`, `Interest_Flag`, `Zakat_Flag`, `Account_Type1`, `Account_Type2`, `Account_Type3`, `Account_Type4`, `Picture`, `Emp_id`, `Offer_Letter_date`, `Tentative_Joining_date`, `RefferedBy`, `Probationary_period_months`, `Notice_period_months`, `Extended_confirmation_days`, `Permanent_address`, `Nationality`, `PosteddBY`, `PostedOn`, `roster_group_code`, `card_no`, `ContractExpiryDate`, `Position_Code`, `Company_Code`, `UserCode`) VALUES
(38, '2022-03-21 00:00:00.000000', 'Ali Murad Dhamani', 'Muhammad Hanif Dhamani', 'M', 'S', '1998-05-26 00:00:00.000000', '2022-03-14 00:00:00.000000', '2022-03-14 00:00:00.000000', 2, 1, 'Flat No. O-398, Karimabad Colony, F.B Area Block 3, Karachi', 'Flat No. O-398, Karimabad Colony, F.B Ar', 'N/A', 'N/A', 'N/A', 'N/A', '03343933024', '42101-6278229-9', '2016-07-29', '2026-07-30', 60, 'N/A', 'ali_murad.dhamani@roche.com', 'N', 1, 130, 22, 33, 55, 10, 54, 0, 722, 1, 46, 1, 'N', 1, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'NotApplicable', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', '0', 'N/A', 'Personnel Done', 'N', 'N', 'N', 'N', 'N', 'N', 0x0000, '', '2022-03-14', '2022-03-14', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 1543, '2022-03-21 15:39:57.483000', 1, 'NA', '2022-03-21 00:00:00.000000', 0, 0, 0),
(40, '2022-04-20 00:00:00.000000', 'Faisal Ahmed Abro', 'Ahmed Ali Abro', 'M', 'S', '1994-02-04 00:00:00.000000', '2022-04-14 00:00:00.000000', '2022-04-14 00:00:00.000000', 1, 1, 'Maryam House, Mehran University Co-operative Housing Society, Jamshoro, Sindh', 'Maryam House, Mehran University Co-opera', 'N/A', 'N/A', 'N/A', 'N/A', '0333-7198959', '43203-7481230-1', '2017-10-17', '2027-10-16', 60, 'N/A', 'ahmed_faisal.ahmed_faisal@roche.com', 'N', 1, 194, 20, 1060, 13, 10, 51, 0, 1192, 1, 1051, 1, 'N', 1, 1, 'PK63HABB0050977917B60303', 1, 100, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'Y', 'N', 'N', 'N', 'N', 'N', 'Performance', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', 'N/A', 'Payroll Done', 'N', 'N', 'C', 'N', 'N', 'N', 0x0000, '', '2022-04-14', '2022-04-14', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 1543, '2022-04-20 10:17:16.120000', 1, 'NA', '2022-04-20 00:00:00.000000', 0, 0, 0),
(41, '2022-05-20 00:00:00.000000', 'Yasir Adnan', 'Badr Uddin Ishaque', 'M', 'M', '1981-02-04 00:00:00.000000', '2022-05-09 00:00:00.000000', '2022-05-09 00:00:00.000000', 1, 1, 'A 1/409, Madina Blessings, Gulshan-e-Iqbal, Block 10-A, Karachi.', 'A 1/409, Madina Blessings, Gulshan-e-Iqb', 'N/A', 'N/A', 'N/A', 'N/A', '03333035005', '42501-3097996-5', '2016-07-29', '2029-07-12', 60, 'N/A', 'yasir.adnan@roche.com', 'N', 1, 89, 17, 17, 38, 10, 34, 0, 1507, 1, 29, 1, 'N', 1, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'NotApplicable', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', '0', 'N/A', 'Personnel Done', 'N', 'N', 'N', 'N', 'N', 'N', 0x0000, '', '2022-05-09', '2022-05-09', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 1543, '2022-05-20 09:25:12.133000', 1, 'NA', '2022-05-20 00:00:00.000000', 0, 0, 0),
(41, '2022-05-20 00:00:00.000000', 'Yasir Adnan', 'Badr Uddin Ishaque', 'M', 'M', '1981-02-04 00:00:00.000000', '2022-05-09 00:00:00.000000', '2022-05-09 00:00:00.000000', 1, 1, 'A 1/409, Madina Blessings, Gulshan-e-Iqbal, Block 10-A, Karachi.', 'A 1/409, Madina Blessings, Gulshan-e-Iqb', 'N/A', 'N/A', 'N/A', 'N/A', '03333035005', '42501-3097996-5', '2016-07-29', '2029-07-12', 60, 'N/A', 'yasir.adnan@roche.com', 'N', 1, 89, 17, 17, 38, 10, 34, 0, 1507, 1, 29, 1, 'N', 1, 1, 'PK83SCBL0000001303690101', 7, 100, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'Y', 'N', 'N', 'N', 'N', 'N', 'Performance', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', 'N/A', 'Payroll Done', 'N', 'N', 'C', 'N', 'N', 'N', 0x0000, '', '2022-05-09', '2022-05-09', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 1543, '2022-05-20 09:27:08.480000', 1, 'NA', '2022-05-20 00:00:00.000000', 0, 0, 0),
(41, '2022-05-20 00:00:00.000000', 'Yasir Adnan', 'Badr Uddin Ishaque', 'M', 'M', '1981-02-04 00:00:00.000000', '2022-05-09 00:00:00.000000', '2022-05-09 00:00:00.000000', 1, 1, 'A 1/409, Madina Blessings, Gulshan-e-Iqbal, Block 10-A, Karachi.', 'A 1/409, Madina Blessings, Gulshan-e-Iqb', 'N/A', 'N/A', 'N/A', 'N/A', '03333035005', '42501-3097996-5', '2016-07-29', '2029-07-12', 60, 'N/A', 'yasir.adnan@roche.com', 'N', 1, 89, 17, 17, 38, 10, 34, 0, 1507, 1, 29, 1, 'N', 1, 1, 'PK83SCBL0000001303690101', 7, 100, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'Y', 'N', 'N', 'N', 'N', 'N', 'Performance', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', 'N/A', 'Payroll Done', 'N', 'N', 'C', 'N', 'N', 'N', 0x0000, '', '2022-05-09', '2022-05-09', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 1543, '2022-05-20 09:27:08.483000', 1, 'NA', '2022-05-20 00:00:00.000000', 0, 0, 0),
(42, '2023-06-22 00:00:00.000000', 'testa', 'testb', 'M', 'S', '2023-06-22 00:00:00.000000', '2023-06-22 00:00:00.000000', '2023-06-22 00:00:00.000000', 3, 1, 'asasas', 'asas', '777', '777', '777', '777', '777', '42101-8646544-9', '2023-06-22', '2023-06-22', 60, '6667', 's@s.com', 'N', 1, 57, 16, 16, 10, 9, 1, 0, 737, 1, 1, 1, 'N', 1, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'NotApplicable', 'jjj', 'jjj', 'jjj', 'jjjj', '8878', '8878', 'b+', '0', '0', '7767', 'Personnel Done', 'N', 'N', 'N', 'N', 'N', 'N', 0x00, 'testsa', '2023-06-22', '2023-06-22', 'kkk', 3, 3, 0, 'asvjhasvh', 'p', 1543, '2023-06-22 18:26:24.527000', 1, '2222', '2023-06-22 18:26:24.000000', 0, 0, 0),
(37, '2022-03-21 00:00:00.000000', 'Khurram Riaz', 'Muhammad Riaz', 'M', 'M', '1976-08-04 00:00:00.000000', '2022-03-04 00:00:00.000000', '2022-03-04 00:00:00.000000', 1, 1, 'E-2, 4th Floor, Mahir Terrace, Pir Ghazi Road, Lahore', 'E-2, 4th Floor, Mahir Terrace, Pir Ghazi', 'N/A', 'N/A', 'N/A', 'N/A', '0333-4374207', '35202-2998613-9', '2021-02-21', '2027-02-20', 60, 'N/A', 'khurram.riaz@roche.com', 'N', 1, 194, 20, 1060, 13, 11, 53, 0, 729, 1, 1051, 1, 'N', 1, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'NotApplicable', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', '0', 'N/A', 'Salary Done', 'N', 'N', 'N', 'N', 'N', 'N', 0x0000, '', '2022-03-04', '2022-03-04', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 1543, '2022-03-21 15:40:07.733000', 1, 'NA', '2022-03-21 00:00:00.000000', 0, 0, 0),
(38, '2022-03-21 00:00:00.000000', 'Ali Murad Dhamani', 'Muhammad Hanif Dhamani', 'M', 'S', '1998-05-26 00:00:00.000000', '2022-03-14 00:00:00.000000', '2022-03-14 00:00:00.000000', 2, 1, 'Flat No. O-398, Karimabad Colony, F.B Area Block 3, Karachi', 'Flat No. O-398, Karimabad Colony, F.B Ar', 'N/A', 'N/A', 'N/A', 'N/A', '03343933024', '42101-6278229-9', '2016-07-29', '2026-07-30', 60, 'N/A', 'ali_murad.dhamani@roche.com', 'N', 1, 130, 22, 33, 55, 10, 54, 0, 722, 1, 46, 1, 'N', 1, 1, 'PK24BAHL1121007800615901', 2, 100, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'Y', 'N', 'N', 'N', 'N', 'N', 'Performance', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', 'N/A', 'Payroll Done', 'N', 'N', 'C', 'N', 'N', 'N', 0x0000, '', '2022-03-14', '2022-03-14', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 1543, '2022-03-21 15:41:22.730000', 1, 'NA', '2022-03-21 00:00:00.000000', 0, 0, 0),
(38, '2022-03-21 00:00:00.000000', 'Ali Murad Dhamani', 'Muhammad Hanif Dhamani', 'M', 'S', '1998-05-26 00:00:00.000000', '2022-03-14 00:00:00.000000', '2022-03-14 00:00:00.000000', 2, 1, 'Flat No. O-398, Karimabad Colony, F.B Area Block 3, Karachi', 'Flat No. O-398, Karimabad Colony, F.B Ar', 'N/A', 'N/A', 'N/A', 'N/A', '03343933024', '42101-6278229-9', '2016-07-29', '2026-07-30', 60, 'N/A', 'ali_murad.dhamani@roche.com', 'N', 1, 130, 22, 33, 55, 10, 54, 0, 722, 1, 46, 1, 'N', 1, 1, 'PK24BAHL1121007800615901', 2, 100, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'Y', 'N', 'N', 'N', 'N', 'N', 'Performance', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', 'N/A', 'Payroll Done', 'N', 'N', 'C', 'N', 'N', 'N', 0x0000, '', '2022-03-14', '2022-03-14', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 1543, '2022-03-21 15:41:22.750000', 1, 'NA', '2022-03-21 00:00:00.000000', 0, 0, 0),
(37, '2022-03-21 00:00:00.000000', 'Khurram Riaz', 'Muhammad Riaz', 'M', 'M', '1976-08-04 00:00:00.000000', '2022-03-04 00:00:00.000000', '2022-03-04 00:00:00.000000', 1, 1, 'E-2, 4th Floor, Mahir Terrace, Pir Ghazi Road, Lahore', 'E-2, 4th Floor, Mahir Terrace, Pir Ghazi', 'N/A', 'N/A', 'N/A', 'N/A', '0333-4374207', '35202-2998613-9', '2021-02-21', '2027-02-20', 60, 'N/A', 'khurram.riaz@roche.com', 'N', 1, 194, 20, 1060, 13, 11, 53, 0, 729, 1, 1051, 1, 'N', 1, 1, '10767901095003', 1, 100, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'Y', 'N', 'N', 'N', 'N', 'N', 'Performance', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', 'N/A', 'Payroll Done', 'N', 'N', 'C', 'N', 'N', 'N', 0x0000, '', '2022-03-04', '2022-03-04', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 1543, '2022-03-21 15:42:52.763000', 1, 'NA', '2022-03-21 00:00:00.000000', 0, 0, 0),
(37, '2022-03-21 00:00:00.000000', 'Khurram Riaz', 'Muhammad Riaz', 'M', 'M', '1976-08-04 00:00:00.000000', '2022-03-04 00:00:00.000000', '2022-03-04 00:00:00.000000', 1, 1, 'E-2, 4th Floor, Mahir Terrace, Pir Ghazi Road, Lahore', 'E-2, 4th Floor, Mahir Terrace, Pir Ghazi', 'N/A', 'N/A', 'N/A', 'N/A', '0333-4374207', '35202-2998613-9', '2021-02-21', '2027-02-20', 60, 'N/A', 'khurram.riaz@roche.com', 'N', 1, 194, 20, 1060, 13, 11, 53, 0, 729, 1, 1051, 1, 'N', 1, 1, '10767901095003', 1, 100, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'Y', 'N', 'N', 'N', 'N', 'N', 'Performance', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', 'N/A', 'Payroll Done', 'N', 'N', 'C', 'N', 'N', 'N', 0x0000, '', '2022-03-04', '2022-03-04', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 1543, '2022-03-21 15:42:52.780000', 1, 'NA', '2022-03-21 00:00:00.000000', 0, 0, 0),
(39, '2022-04-20 00:00:00.000000', 'Abdul Mateen Khan', 'Muhammad Wali Ullah', 'M', 'M', '1986-04-02 00:00:00.000000', '2022-04-13 00:00:00.000000', '2022-04-13 00:00:00.000000', 1, 1, 'House 8, Street 8, Chatha Bakhtawar, Chak Shehzad, Islamabad', 'House 8, Street 8, Chatha Bakhtawar, Cha', 'N/A', 'N/A', 'N/A', 'N/A', '0300-5274140', '61101-0255290-1', '2016-01-25', '2030-12-31', 60, 'N/A', 'abdul_mateen.khan@roche.com', 'N', 1, 206, 18, 1063, 27, 10, 33, 0, 1507, 1, 18, 1, 'N', 1, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'NotApplicable', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', '0', 'N/A', 'Personnel Done', 'N', 'N', 'N', 'N', 'N', 'N', 0x0000, '', '2022-04-13', '2022-04-13', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 1543, '2022-04-20 10:07:21.177000', 1, 'NA', '2022-04-20 00:00:00.000000', 0, 0, 0),
(39, '2022-04-20 00:00:00.000000', 'Abdul Mateen Khan', 'Muhammad Wali Ullah', 'M', 'M', '1986-04-02 00:00:00.000000', '2022-04-13 00:00:00.000000', '2022-04-13 00:00:00.000000', 1, 1, 'House 8, Street 8, Chatha Bakhtawar, Chak Shehzad, Islamabad', 'House 8, Street 8, Chatha Bakhtawar, Cha', 'N/A', 'N/A', 'N/A', 'N/A', '0300-5274140', '61101-0255290-1', '2016-01-25', '2030-12-31', 60, 'N/A', 'abdul_mateen.khan@roche.com', 'N', 1, 206, 18, 1063, 27, 10, 33, 0, 1507, 1, 18, 1, 'N', 1, 1, 'PK70SCBL0000001708391601', 7, 100, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'Y', 'N', 'N', 'N', 'N', 'N', 'Performance', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', 'N/A', 'Payroll Done', 'N', 'N', 'C', 'N', 'N', 'N', 0x0000, '', '2022-04-13', '2022-04-13', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 1543, '2022-04-20 10:09:14.777000', 1, 'NA', '2022-04-20 00:00:00.000000', 0, 0, 0),
(39, '2022-04-20 00:00:00.000000', 'Abdul Mateen Khan', 'Muhammad Wali Ullah', 'M', 'M', '1986-04-02 00:00:00.000000', '2022-04-13 00:00:00.000000', '2022-04-13 00:00:00.000000', 1, 1, 'House 8, Street 8, Chatha Bakhtawar, Chak Shehzad, Islamabad', 'House 8, Street 8, Chatha Bakhtawar, Cha', 'N/A', 'N/A', 'N/A', 'N/A', '0300-5274140', '61101-0255290-1', '2016-01-25', '2030-12-31', 60, 'N/A', 'abdul_mateen.khan@roche.com', 'N', 1, 206, 18, 1063, 27, 10, 33, 0, 1507, 1, 18, 1, 'N', 1, 1, 'PK70SCBL0000001708391601', 7, 100, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'Y', 'N', 'N', 'N', 'N', 'N', 'Performance', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', 'N/A', 'Payroll Done', 'N', 'N', 'C', 'N', 'N', 'N', 0x0000, '', '2022-04-13', '2022-04-13', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 1543, '2022-04-20 10:09:14.780000', 1, 'NA', '2022-04-20 00:00:00.000000', 0, 0, 0),
(40, '2022-04-20 00:00:00.000000', 'Faisal Ahmed Abro', 'Ahmed Ali Abro', 'M', 'S', '1994-02-04 00:00:00.000000', '2022-04-14 00:00:00.000000', '2022-04-14 00:00:00.000000', 1, 1, 'Maryam House, Mehran University Co-operative Housing Society, Jamshoro, Sindh', 'Maryam House, Mehran University Co-opera', 'N/A', 'N/A', 'N/A', 'N/A', '0333-7198959', '43203-7481230-1', '2017-10-17', '2027-10-16', 60, 'N/A', 'ahmed_faisal.ahmed_faisal@roche.com', 'N', 1, 194, 20, 1060, 13, 10, 51, 0, 1192, 1, 1051, 1, 'N', 1, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'NotApplicable', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', '0', 'N/A', 'Personnel Done', 'N', 'N', 'N', 'N', 'N', 'N', 0x0000, '', '2022-04-14', '2022-04-14', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 1543, '2022-04-20 10:15:26.070000', 1, 'NA', '2022-04-20 00:00:00.000000', 0, 0, 0),
(40, '2022-04-20 00:00:00.000000', 'Faisal Ahmed Abro', 'Ahmed Ali Abro', 'M', 'S', '1994-02-04 00:00:00.000000', '2022-04-14 00:00:00.000000', '2022-04-14 00:00:00.000000', 1, 1, 'Maryam House, Mehran University Co-operative Housing Society, Jamshoro, Sindh', 'Maryam House, Mehran University Co-opera', 'N/A', 'N/A', 'N/A', 'N/A', '0333-7198959', '43203-7481230-1', '2017-10-17', '2027-10-16', 60, 'N/A', 'ahmed_faisal.ahmed_faisal@roche.com', 'N', 1, 194, 20, 1060, 13, 10, 51, 0, 1192, 1, 1051, 1, 'N', 1, 1, 'PK63HABB0050977917B60303', 1, 100, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'Y', 'N', 'N', 'N', 'N', 'N', 'Performance', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', 'N/A', 'Payroll Done', 'N', 'N', 'C', 'N', 'N', 'N', 0x0000, '', '2022-04-14', '2022-04-14', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 1543, '2022-04-20 10:17:16.117000', 1, 'NA', '2022-04-20 00:00:00.000000', 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `log_tran_appointment_earnings`
--

CREATE TABLE `log_tran_appointment_earnings` (
  `Sequence_no` int(11) NOT NULL,
  `Transaction_Date` datetime(6) NOT NULL,
  `Allowance_code` int(11) NOT NULL,
  `Increment_Date` datetime(6) NOT NULL,
  `Amount` int(11) NOT NULL,
  `Posting_date` datetime(6) DEFAULT NULL,
  `Posted_by` int(11) NOT NULL,
  `company_code` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `log_tran_appointment_earnings`
--

INSERT INTO `log_tran_appointment_earnings` (`Sequence_no`, `Transaction_Date`, `Allowance_code`, `Increment_Date`, `Amount`, `Posting_date`, `Posted_by`, `company_code`) VALUES
(45, '2023-07-05 14:47:44.000000', 1, '2023-07-05 10:47:44.102000', 34, '2023-07-05 14:47:44.000000', 0, 1),
(45, '2023-07-05 14:47:44.000000', 4, '2023-07-05 10:47:44.109000', 45, '2023-07-05 14:47:44.000000', 0, 1),
(45, '2023-07-05 14:49:23.000000', 1, '2023-07-05 10:49:23.486000', 34, '2023-07-05 14:49:23.000000', 0, 1),
(45, '2023-07-05 14:49:23.000000', 4, '2023-07-05 10:49:23.490000', 45, '2023-07-05 14:49:23.000000', 0, 1),
(45, '2023-07-05 14:49:52.000000', 1, '2023-07-05 10:49:52.650000', 34, '2023-07-05 14:49:52.000000', 0, 1),
(45, '2023-07-05 14:51:00.000000', 1, '2023-07-05 10:51:00.608000', 34, '2023-07-05 14:51:00.000000', 0, 1),
(45, '2023-07-05 14:51:00.000000', 4, '2023-07-05 10:51:00.613000', 45, '2023-07-05 14:51:00.000000', 0, 1),
(45, '2023-07-05 14:52:45.000000', 1, '2023-07-05 10:52:45.661000', 34, '2023-07-05 14:52:45.000000', 0, 1),
(45, '2023-07-05 14:52:45.000000', 4, '2023-07-05 10:52:45.667000', 45, '2023-07-05 14:52:45.000000', 0, 1),
(45, '2023-07-05 14:55:14.000000', 1, '2023-07-05 10:55:14.661000', 34, '2023-07-05 14:55:14.000000', 0, 1),
(45, '2023-07-05 14:55:14.000000', 4, '2023-07-05 10:55:14.665000', 45, '2023-07-05 14:55:14.000000', 0, 1);

-- --------------------------------------------------------

--
-- Table structure for table `master_all_employees`
--

CREATE TABLE `master_all_employees` (
  `Emp_code` int(11) NOT NULL,
  `Transaction_Date` datetime NOT NULL,
  `Emp_name` varchar(50) NOT NULL,
  `Emp_Father_name` varchar(50) DEFAULT NULL,
  `Emp_sex_code` varchar(1) NOT NULL,
  `Emp_marital_status` varchar(1) NOT NULL,
  `Emp_birth_date` datetime NOT NULL,
  `Emp_appointment_date` datetime NOT NULL,
  `Emp_Confirm_date` datetime NOT NULL,
  `Emp_catery` int(11) NOT NULL,
  `Emp_Leave_catery` int(11) NOT NULL,
  `Emp_address_line1` varchar(500) DEFAULT NULL,
  `Emp_address_line2` varchar(100) DEFAULT NULL,
  `Emp_home_tel1` varchar(100) DEFAULT NULL,
  `Emp_home_tel2` varchar(15) DEFAULT NULL,
  `Emp_office_tel1` varchar(15) DEFAULT NULL,
  `Emp_office_tel2` varchar(15) DEFAULT NULL,
  `Emp_mobile_No` varchar(30) DEFAULT NULL,
  `Emp_nic_no` varchar(30) DEFAULT NULL,
  `Emp_nic_issue_date` date DEFAULT NULL,
  `Emp_nic_expiry_date` date DEFAULT NULL,
  `Emp_retirement_age` int(11) DEFAULT NULL,
  `Emp_ntn_no` varchar(15) DEFAULT NULL,
  `Emp_email` varchar(100) DEFAULT NULL,
  `Confirmation_Flag` varchar(1) NOT NULL,
  `Employment_Type_code` int(11) NOT NULL,
  `Desig_code` int(11) NOT NULL,
  `Grade_code` int(11) NOT NULL,
  `Cost_Centre_code` int(11) NOT NULL,
  `Dept_code` int(11) NOT NULL,
  `Section_code` int(11) NOT NULL,
  `Shift_code` int(11) NOT NULL,
  `Loc_code` int(11) NOT NULL,
  `Edu_code` int(11) NOT NULL,
  `Transport_code` int(11) NOT NULL,
  `Supervisor_Code` int(11) DEFAULT NULL,
  `Religion_Code` int(11) DEFAULT NULL,
  `Deletion_Flag` varchar(1) DEFAULT NULL,
  `Contact_Person_Name` varchar(30) NOT NULL,
  `Relationship` varchar(15) NOT NULL,
  `Contact_address1` varchar(500) DEFAULT NULL,
  `Contact_address2` varchar(200) NOT NULL,
  `Contact_home_tel1` varchar(20) DEFAULT NULL,
  `Contact_home_tel2` varchar(20) DEFAULT NULL,
  `Emp_Blood_Group` varchar(4) NOT NULL,
  `Vehicle_Registration_Number` varchar(100) NOT NULL,
  `Emp_Payroll_catery` int(11) NOT NULL,
  `Mode_Of_Payment` int(11) NOT NULL,
  `Bank_Account_No1` varchar(30) NOT NULL,
  `Branch_Code1` int(11) NOT NULL,
  `Bank_Amount_1` decimal(7,0) NOT NULL,
  `Bank_Percent_1` decimal(3,0) NOT NULL,
  `Bank_Account_No2` varchar(20) NOT NULL,
  `Branch_Code2` int(11) NOT NULL,
  `Bank_Amount_2` decimal(7,0) NOT NULL,
  `Bank_Percent_2` decimal(3,0) NOT NULL,
  `Bank_Account_No3` varchar(20) NOT NULL,
  `Branch_Code3` int(11) NOT NULL,
  `Bank_Amount_3` decimal(7,0) NOT NULL,
  `Bank_Percent_3` decimal(3,0) NOT NULL,
  `Bank_Account_No4` varchar(20) NOT NULL,
  `Branch_Code4` int(11) NOT NULL,
  `Bank_Amount_4` decimal(7,0) NOT NULL,
  `Bank_Percent_4` decimal(3,0) NOT NULL,
  `SESSI_Flag` varchar(1) NOT NULL,
  `EOBI_Flag` varchar(1) NOT NULL,
  `Union_Flag` varchar(1) NOT NULL,
  `Recreation_Club_Flag` varchar(1) NOT NULL,
  `Meal_Deduction_Flag` varchar(1) NOT NULL,
  `Overtime_Flag` varchar(1) NOT NULL,
  `Incentive_Flag` varchar(1) NOT NULL,
  `Bonus_Type` varchar(30) DEFAULT NULL,
  `Salary_Hold_Flag` varchar(1) NOT NULL,
  `Salary_Hold_Date` datetime NOT NULL,
  `Salary_Hold_Description` varchar(30) NOT NULL,
  `Tax_Exemption_Flag` varchar(1) DEFAULT NULL,
  `EOBI_Number` varchar(20) NOT NULL,
  `SESSI_Number` varchar(20) NOT NULL,
  `ACCOUNT_TYPE1` varchar(1) NOT NULL,
  `ACCOUNT_TYPE2` varchar(1) NOT NULL,
  `ACCOUNT_TYPE3` varchar(1) NOT NULL,
  `ACCOUNT_TYPE4` varchar(1) NOT NULL,
  `Interest_Flag` varchar(1) NOT NULL,
  `Zakat_Flag` varchar(1) NOT NULL,
  `PF_Nomination_Flag` varchar(1) DEFAULT NULL,
  `PF_Nomination_Date` datetime DEFAULT NULL,
  `car_date` datetime DEFAULT NULL,
  `car_value` int(11) DEFAULT NULL,
  `Bonus_Factor` int(11) DEFAULT NULL,
  `Fuel_Card_Flag` varchar(1) DEFAULT NULL,
  `Picture_image` text DEFAULT NULL,
  `emp_hr_catery` int(11) DEFAULT NULL,
  `Emp_OldNIC` varchar(25) DEFAULT NULL,
  `reffrence_leter_date` date DEFAULT NULL,
  `Emp_id` int(11) DEFAULT NULL,
  `Offer_Letter_date` date DEFAULT NULL,
  `Tentative_Joining_date` date DEFAULT NULL,
  `RefferedBy` varchar(50) DEFAULT NULL,
  `Probationary_period_months` int(11) DEFAULT NULL,
  `Notice_period_months` int(11) DEFAULT NULL,
  `Extended_confirmation_days` int(11) DEFAULT NULL,
  `Permanent_address` varchar(200) DEFAULT NULL,
  `Nationality` varchar(50) DEFAULT NULL,
  `sub_company_code` int(11) DEFAULT NULL,
  `roster_group_code` int(11) DEFAULT NULL,
  `card_no` varchar(50) DEFAULT NULL,
  `Sharia_Flag` char(1) DEFAULT NULL,
  `Company_Code` int(11) DEFAULT NULL,
  `Old_Emp_code` varchar(50) DEFAULT NULL,
  `Old_Company_Code` int(11) DEFAULT NULL,
  `id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `master_employees`
--

CREATE TABLE `master_employees` (
  `Emp_code` int(11) NOT NULL,
  `Transaction_Date` datetime NOT NULL,
  `Emp_name` varchar(50) NOT NULL,
  `Emp_Father_name` varchar(50) DEFAULT NULL,
  `Emp_sex_code` varchar(1) NOT NULL,
  `Emp_marital_status` varchar(1) NOT NULL,
  `Emp_birth_date` datetime NOT NULL,
  `Emp_appointment_date` datetime NOT NULL,
  `Emp_Confirm_date` datetime NOT NULL,
  `Emp_catery` int(11) NOT NULL,
  `Emp_Leave_catery` int(11) NOT NULL,
  `Emp_address_line1` varchar(500) NOT NULL,
  `Emp_address_line2` varchar(100) DEFAULT NULL,
  `Emp_home_tel1` varchar(30) DEFAULT NULL,
  `Emp_home_tel2` varchar(15) DEFAULT NULL,
  `Emp_office_tel1` varchar(15) DEFAULT NULL,
  `Emp_office_tel2` varchar(15) DEFAULT NULL,
  `Emp_mobile_No` varchar(30) DEFAULT NULL,
  `Emp_nic_no` varchar(30) DEFAULT NULL,
  `Emp_nic_issue_date` date DEFAULT NULL,
  `Emp_nic_expiry_date` date DEFAULT NULL,
  `Emp_retirement_age` int(11) DEFAULT NULL,
  `Emp_ntn_no` varchar(15) DEFAULT NULL,
  `Emp_email` varchar(100) DEFAULT NULL,
  `Confirmation_Flag` varchar(1) NOT NULL,
  `Employment_Type_code` int(11) NOT NULL,
  `Desig_code` int(11) NOT NULL,
  `Grade_code` int(11) NOT NULL,
  `Cost_Centre_code` bigint(20) NOT NULL,
  `Dept_code` int(11) NOT NULL,
  `Section_code` int(11) NOT NULL,
  `Shift_code` int(11) NOT NULL,
  `Loc_code` int(11) NOT NULL,
  `Edu_code` int(11) NOT NULL,
  `Transport_code` int(11) NOT NULL,
  `Supervisor_Code` int(11) DEFAULT NULL,
  `Religion_Code` int(11) DEFAULT NULL,
  `Deletion_Flag` varchar(1) DEFAULT NULL,
  `Contact_Person_Name` varchar(100) NOT NULL,
  `Relationship` varchar(50) NOT NULL,
  `Contact_address1` varchar(500) NOT NULL,
  `Contact_address2` varchar(40) NOT NULL,
  `Contact_home_tel1` varchar(20) DEFAULT NULL,
  `Contact_home_tel2` varchar(20) DEFAULT NULL,
  `Emp_Blood_Group` varchar(20) NOT NULL,
  `Vehicle_Registration_Number` varchar(100) NOT NULL,
  `Emp_Payroll_catery` int(11) NOT NULL,
  `Mode_Of_Payment` int(11) NOT NULL,
  `Bank_Account_No1` varchar(30) NOT NULL,
  `Branch_Code1` int(11) NOT NULL,
  `Bank_Amount_1` decimal(7,0) NOT NULL,
  `Bank_Percent_1` decimal(3,0) NOT NULL,
  `Bank_Account_No2` varchar(20) NOT NULL,
  `Branch_Code2` int(11) NOT NULL,
  `Bank_Amount_2` decimal(7,0) NOT NULL,
  `Bank_Percent_2` decimal(3,0) NOT NULL,
  `Bank_Account_No3` varchar(20) NOT NULL,
  `Branch_Code3` int(11) NOT NULL,
  `Bank_Amount_3` decimal(7,0) NOT NULL,
  `Bank_Percent_3` decimal(3,0) NOT NULL,
  `Bank_Account_No4` varchar(20) NOT NULL,
  `Branch_Code4` int(11) NOT NULL,
  `Bank_Amount_4` decimal(7,0) NOT NULL,
  `Bank_Percent_4` decimal(3,0) NOT NULL,
  `SESSI_Flag` varchar(1) NOT NULL,
  `EOBI_Flag` varchar(1) NOT NULL,
  `Union_Flag` varchar(1) NOT NULL,
  `Recreation_Club_Flag` varchar(1) NOT NULL,
  `Meal_Deduction_Flag` varchar(1) NOT NULL,
  `Overtime_Flag` varchar(1) NOT NULL,
  `Incentive_Flag` varchar(1) NOT NULL,
  `Bonus_Type` varchar(30) DEFAULT NULL,
  `Salary_Hold_Flag` varchar(1) NOT NULL,
  `Salary_Hold_Date` datetime NOT NULL,
  `Salary_Hold_Description` varchar(30) NOT NULL,
  `Tax_Exemption_Flag` varchar(1) DEFAULT NULL,
  `EOBI_Number` varchar(20) NOT NULL,
  `SESSI_Number` varchar(20) NOT NULL,
  `ACCOUNT_TYPE1` varchar(1) DEFAULT NULL,
  `ACCOUNT_TYPE2` varchar(1) DEFAULT NULL,
  `ACCOUNT_TYPE3` varchar(1) DEFAULT NULL,
  `ACCOUNT_TYPE4` varchar(1) DEFAULT NULL,
  `Interest_Flag` varchar(1) NOT NULL,
  `Zakat_Flag` varchar(1) NOT NULL,
  `PF_Nomination_Flag` varchar(1) DEFAULT NULL,
  `PF_Nomination_Date` datetime DEFAULT NULL,
  `car_date` datetime DEFAULT NULL,
  `car_value` int(11) DEFAULT NULL,
  `Bonus_Factor` int(11) DEFAULT NULL,
  `Fuel_Card_Flag` varchar(1) DEFAULT NULL,
  `Picture_image` text DEFAULT NULL,
  `emp_hr_catery` int(11) DEFAULT NULL,
  `Emp_OldNIC` varchar(25) DEFAULT NULL,
  `reffrence_leter_date` date DEFAULT NULL,
  `Emp_id` int(11) DEFAULT NULL,
  `Offer_Letter_date` date DEFAULT NULL,
  `Tentative_Joining_date` date DEFAULT NULL,
  `RefferedBy` varchar(200) DEFAULT NULL,
  `Probationary_period_months` int(11) DEFAULT NULL,
  `Notice_period_months` int(11) DEFAULT NULL,
  `Extended_confirmation_days` int(11) DEFAULT NULL,
  `Permanent_address` varchar(500) DEFAULT NULL,
  `Nationality` varchar(50) DEFAULT NULL,
  `sub_company_code` int(11) DEFAULT NULL,
  `roster_group_code` int(11) DEFAULT NULL,
  `card_no` varchar(50) DEFAULT NULL,
  `Sharia_Flag` char(1) DEFAULT NULL,
  `Company_Code` int(11) DEFAULT NULL,
  `Old_Emp_code` varchar(50) DEFAULT NULL,
  `Old_Company_Code` int(11) DEFAULT NULL,
  `id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rawattendancedata`
--

CREATE TABLE `rawattendancedata` (
  `Sno` int(11) NOT NULL,
  `data` varchar(50) NOT NULL,
  `flag` bit(1) NOT NULL,
  `insertdatetime` datetime NOT NULL,
  `company_code` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sys_employees`
--

CREATE TABLE `sys_employees` (
  `Emp_code` int(11) NOT NULL,
  `Emp_name` varchar(100) NOT NULL,
  `Emp_password` text DEFAULT NULL,
  `HR_security_level` varchar(1) DEFAULT NULL,
  `Payroll_security_level` varchar(1) DEFAULT NULL,
  `Allow_Calculate_Button` char(1) DEFAULT NULL,
  `Show_Own_Appraisal_Form` char(1) DEFAULT NULL,
  `Show_Earning_Form` char(1) DEFAULT NULL,
  `Show_Increment_Form` char(1) DEFAULT NULL,
  `Emp_User_ID` varchar(50) DEFAULT NULL,
  `Sort_key` varchar(2) DEFAULT NULL,
  `password_Change_flag` varchar(1) DEFAULT NULL,
  `Wrong_Password_Count` int(11) DEFAULT NULL,
  `Password_Change_Date` datetime DEFAULT NULL,
  `Report_Salary_Option_View_Flag` varchar(1) DEFAULT NULL,
  `Role_Code` int(11) DEFAULT NULL,
  `id` int(11) NOT NULL,
  `company_code` int(11) NOT NULL,
  `access_token` text NOT NULL,
  `refresh_token` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sys_employees`
--

INSERT INTO `sys_employees` (`Emp_code`, `Emp_name`, `Emp_password`, `HR_security_level`, `Payroll_security_level`, `Allow_Calculate_Button`, `Show_Own_Appraisal_Form`, `Show_Earning_Form`, `Show_Increment_Form`, `Emp_User_ID`, `Sort_key`, `password_Change_flag`, `Wrong_Password_Count`, `Password_Change_Date`, `Report_Salary_Option_View_Flag`, `Role_Code`, `id`, `company_code`, `access_token`, `refresh_token`) VALUES
(0, 'admin', '$2y$10$V25AkNL2THEkhTqoQkXRjuLPfc/0uEOW6TI3fIgS0bTQszrX.hOPu', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJFbXBfY29kZSI6MCwiRW1wX25hbWUiOiJhZG1pbiIsIkhSX3NlY3VyaXR5X2xldmVsIjpudWxsLCJQYXlyb2xsX3NlY3VyaXR5X2xldmVsIjpudWxsLCJBbGxvd19DYWxjdWxhdGVfQnV0dG9uIjpudWxsLCJTaG93X093bl9BcHByYWlzYWxfRm9ybSI6bnVsbCwiU2hvd19FYXJuaW5nX0Zvcm0iOm51bGwsIkVtcF9Vc2VyX0lEIjpudWxsLCJTb3J0X2tleSI6bnVsbCwicGFzc3dvcmRfQ2hhbmdlX2ZsYWciOm51bGwsIldyb25nX1Bhc3N3b3JkX0NvdW50IjpudWxsLCJQYXNzd29yZF9DaGFuZ2VfRGF0ZSI6bnVsbCwiUmVwb3J0X1NhbGFyeV9PcHRpb25fVmlld19GbGFnIjpudWxsLCJSb2xlX0NvZGUiOm51bGwsImlkIjoxLCJjb21wYW55X2NvZGUiOjEsImlhdCI6MTY4ODY0MDUyNiwiZXhwIjoxNjg4NjQ0MTI2fQ.80VI8LhhlHdOFX-8A1HYKbvtA1_pb6eZW1rORrd7zQw', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJFbXBfY29kZSI6MCwiRW1wX25hbWUiOiJhZG1pbiIsIkhSX3NlY3VyaXR5X2xldmVsIjpudWxsLCJQYXlyb2xsX3NlY3VyaXR5X2xldmVsIjpudWxsLCJBbGxvd19DYWxjdWxhdGVfQnV0dG9uIjpudWxsLCJTaG93X093bl9BcHByYWlzYWxfRm9ybSI6bnVsbCwiU2hvd19FYXJuaW5nX0Zvcm0iOm51bGwsIkVtcF9Vc2VyX0lEIjpudWxsLCJTb3J0X2tleSI6bnVsbCwicGFzc3dvcmRfQ2hhbmdlX2ZsYWciOm51bGwsIldyb25nX1Bhc3N3b3JkX0NvdW50IjpudWxsLCJQYXNzd29yZF9DaGFuZ2VfRGF0ZSI6bnVsbCwiUmVwb3J0X1NhbGFyeV9PcHRpb25fVmlld19GbGFnIjpudWxsLCJSb2xlX0NvZGUiOm51bGwsImlkIjoxLCJjb21wYW55X2NvZGUiOjEsImlhdCI6MTY4ODY0MDUyNiwiZXhwIjoxNjg4NjQ1MzI2fQ.QryoWphFzU4svFOB03hYm6GKVic3qO3tdzEcwromjDY'),
(1, 'admin', '$2y$10$V25AkNL2THEkhTqoQkXRjuLPfc/0uEOW6TI3fIgS0bTQszrX.hOPu', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJFbXBfY29kZSI6MSwiRW1wX25hbWUiOiJhZG1pbiIsIkhSX3NlY3VyaXR5X2xldmVsIjpudWxsLCJQYXlyb2xsX3NlY3VyaXR5X2xldmVsIjpudWxsLCJBbGxvd19DYWxjdWxhdGVfQnV0dG9uIjpudWxsLCJTaG93X093bl9BcHByYWlzYWxfRm9ybSI6bnVsbCwiU2hvd19FYXJuaW5nX0Zvcm0iOm51bGwsIkVtcF9Vc2VyX0lEIjpudWxsLCJTb3J0X2tleSI6bnVsbCwicGFzc3dvcmRfQ2hhbmdlX2ZsYWciOm51bGwsIldyb25nX1Bhc3N3b3JkX0NvdW50IjpudWxsLCJQYXNzd29yZF9DaGFuZ2VfRGF0ZSI6bnVsbCwiUmVwb3J0X1NhbGFyeV9PcHRpb25fVmlld19GbGFnIjpudWxsLCJSb2xlX0NvZGUiOm51bGwsImlkIjoyLCJjb21wYW55X2NvZGUiOjIsImlhdCI6MTY4ODY0NTIyNywiZXhwIjoxNjg4NjQ4ODI3fQ.ihW9bShlMxg557K8-_6wBuA-VtK2HQxv2R5rfa-ntuw', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJFbXBfY29kZSI6MSwiRW1wX25hbWUiOiJhZG1pbiIsIkhSX3NlY3VyaXR5X2xldmVsIjpudWxsLCJQYXlyb2xsX3NlY3VyaXR5X2xldmVsIjpudWxsLCJBbGxvd19DYWxjdWxhdGVfQnV0dG9uIjpudWxsLCJTaG93X093bl9BcHByYWlzYWxfRm9ybSI6bnVsbCwiU2hvd19FYXJuaW5nX0Zvcm0iOm51bGwsIkVtcF9Vc2VyX0lEIjpudWxsLCJTb3J0X2tleSI6bnVsbCwicGFzc3dvcmRfQ2hhbmdlX2ZsYWciOm51bGwsIldyb25nX1Bhc3N3b3JkX0NvdW50IjpudWxsLCJQYXNzd29yZF9DaGFuZ2VfRGF0ZSI6bnVsbCwiUmVwb3J0X1NhbGFyeV9PcHRpb25fVmlld19GbGFnIjpudWxsLCJSb2xlX0NvZGUiOm51bGwsImlkIjoyLCJjb21wYW55X2NvZGUiOjIsImlhdCI6MTY4ODY0NTIyNywiZXhwIjoxNjg4NjUwMDI3fQ.fJLMOrUdF04EBXaP2vVbOGn1hHv4d0eroNqacEsSYiw'),
(2, 'admin', '$2y$10$V25AkNL2THEkhTqoQkXRjuLPfc/0uEOW6TI3fIgS0bTQszrX.hOPu', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3, 3, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJFbXBfY29kZSI6MCwiRW1wX25hbWUiOiJhZG1pbiIsIkhSX3NlY3VyaXR5X2xldmVsIjpudWxsLCJQYXlyb2xsX3NlY3VyaXR5X2xldmVsIjpudWxsLCJBbGxvd19DYWxjdWxhdGVfQnV0dG9uIjpudWxsLCJTaG93X093bl9BcHByYWlzYWxfRm9ybSI6bnVsbCwiU2hvd19FYXJuaW5nX0Zvcm0iOm51bGwsIkVtcF9Vc2VyX0lEIjpudWxsLCJTb3J0X2tleSI6bnVsbCwicGFzc3dvcmRfQ2hhbmdlX2ZsYWciOm51bGwsIldyb25nX1Bhc3N3b3JkX0NvdW50IjpudWxsLCJQYXNzd29yZF9DaGFuZ2VfRGF0ZSI6bnVsbCwiUmVwb3J0X1NhbGFyeV9PcHRpb25fVmlld19GbGFnIjpudWxsLCJSb2xlX0NvZGUiOm51bGwsImlkIjoxLCJjb21wYW55X2NvZGUiOjEsImlhdCI6MTY4ODYzNDg0NywiZXhwIjoxNjg4NjM4NDQ3fQ.lDk-ZBGvtKR8lNeTHxmTWe5Xj-28Ys7Cklt2ZFa9AFU', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJFbXBfY29kZSI6MCwiRW1wX25hbWUiOiJhZG1pbiIsIkhSX3NlY3VyaXR5X2xldmVsIjpudWxsLCJQYXlyb2xsX3NlY3VyaXR5X2xldmVsIjpudWxsLCJBbGxvd19DYWxjdWxhdGVfQnV0dG9uIjpudWxsLCJTaG93X093bl9BcHByYWlzYWxfRm9ybSI6bnVsbCwiU2hvd19FYXJuaW5nX0Zvcm0iOm51bGwsIkVtcF9Vc2VyX0lEIjpudWxsLCJTb3J0X2tleSI6bnVsbCwicGFzc3dvcmRfQ2hhbmdlX2ZsYWciOm51bGwsIldyb25nX1Bhc3N3b3JkX0NvdW50IjpudWxsLCJQYXNzd29yZF9DaGFuZ2VfRGF0ZSI6bnVsbCwiUmVwb3J0X1NhbGFyeV9PcHRpb25fVmlld19GbGFnIjpudWxsLCJSb2xlX0NvZGUiOm51bGwsImlkIjoxLCJjb21wYW55X2NvZGUiOjEsImlhdCI6MTY4ODYzNDg0NywiZXhwIjoxNjg4NjM5NjQ3fQ.fkryO6V3limT-nmO6Nol0Grc1Utu2-x0udVfl6tMRBo');

-- --------------------------------------------------------

--
-- Table structure for table `temp_attendances`
--

CREATE TABLE `temp_attendances` (
  `Emp_Code` int(11) DEFAULT NULL,
  `emp_id` varchar(20) DEFAULT NULL,
  `Attendance_HH` int(11) DEFAULT NULL,
  `Attendance_MM` int(11) DEFAULT NULL,
  `Attendance_Date` datetime DEFAULT NULL,
  `Time_In_Out_Flag` int(11) DEFAULT NULL,
  `Origional_Data` varchar(40) DEFAULT NULL,
  `Origional_Date` date DEFAULT NULL,
  `id` int(11) NOT NULL,
  `company_code` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tran_appointments`
--

CREATE TABLE `tran_appointments` (
  `Sequence_no` int(11) NOT NULL,
  `Transaction_Date` text NOT NULL,
  `Emp_name` varchar(30) NOT NULL,
  `Emp_Father_name` varchar(30) NOT NULL,
  `Emp_sex_code` varchar(1) NOT NULL,
  `Emp_marital_status` varchar(1) NOT NULL,
  `Emp_birth_date` text NOT NULL,
  `Emp_appointment_date` text NOT NULL,
  `Emp_confirm_date` text NOT NULL,
  `Emp_category` int(11) NOT NULL,
  `Emp_Leave_category` int(11) NOT NULL,
  `Emp_address_line1` varchar(200) NOT NULL,
  `Emp_address_line2` varchar(100) DEFAULT NULL,
  `Emp_home_tel1` varchar(15) DEFAULT NULL,
  `Emp_home_tel2` varchar(15) DEFAULT NULL,
  `Emp_office_tel1` varchar(15) DEFAULT NULL,
  `Emp_office_tel2` varchar(15) DEFAULT NULL,
  `Emp_mobile_No` varchar(20) DEFAULT NULL,
  `Emp_nic_no` varchar(30) DEFAULT NULL,
  `Emp_nic_issue_date` text DEFAULT NULL,
  `Emp_nic_expiry_date` text DEFAULT NULL,
  `Emp_retirement_age` int(11) DEFAULT NULL,
  `Emp_ntn_no` varchar(15) DEFAULT NULL,
  `Emp_email` varchar(70) DEFAULT NULL,
  `Confirmation_Flag` varchar(1) NOT NULL,
  `Empt_Type_code` int(11) NOT NULL,
  `Desig_code` int(11) NOT NULL,
  `Grade_code` int(11) NOT NULL,
  `Cost_Centre_code` int(11) NOT NULL,
  `Dept_code` int(11) NOT NULL,
  `Loc_code` int(11) NOT NULL,
  `Edu_code` int(11) NOT NULL,
  `Transport_code` int(11) NOT NULL,
  `Supervisor_Code` int(11) DEFAULT NULL,
  `Religion_Code` int(11) DEFAULT NULL,
  `Section_code` int(11) NOT NULL,
  `Shift_code` int(11) NOT NULL,
  `Deletion_Flag` varchar(1) DEFAULT NULL,
  `Emp_Payroll_category` int(11) NOT NULL DEFAULT 0,
  `Mode_Of_Payment` int(11) NOT NULL DEFAULT 0,
  `Bank_Account_No1` varchar(30) NOT NULL DEFAULT '1',
  `Branch_Code1` int(11) NOT NULL DEFAULT 0,
  `Bank_Amount_1` int(11) NOT NULL DEFAULT 0,
  `Bank_Percent_1` smallint(6) NOT NULL DEFAULT 0,
  `Bank_Account_No2` varchar(30) NOT NULL DEFAULT '0',
  `Branch_Code2` int(11) NOT NULL DEFAULT 0,
  `Bank_Amount_2` int(11) NOT NULL DEFAULT 0,
  `Bank_Percent_2` smallint(6) NOT NULL DEFAULT 0,
  `Bank_Account_No3` varchar(30) NOT NULL DEFAULT '0',
  `Branch_Code3` int(11) NOT NULL DEFAULT 0,
  `Bank_Amount_3` int(11) NOT NULL DEFAULT 0,
  `Bank_Percent_3` smallint(6) NOT NULL DEFAULT 0,
  `Bank_Account_No4` varchar(30) NOT NULL DEFAULT '0',
  `Branch_Code4` int(11) NOT NULL DEFAULT 0,
  `Bank_Amount_4` int(11) NOT NULL DEFAULT 0,
  `Bank_Percent_4` smallint(6) NOT NULL DEFAULT 0,
  `SESSI_Flag` varchar(1) NOT NULL DEFAULT 'N',
  `EOBI_Flag` varchar(1) NOT NULL DEFAULT 'N',
  `Union_Flag` varchar(1) NOT NULL DEFAULT 'N',
  `Recreation_Club_Flag` varchar(1) NOT NULL DEFAULT 'N',
  `Meal_Deduction_Flag` varchar(1) NOT NULL DEFAULT 'N',
  `Overtime_Flag` varchar(1) NOT NULL DEFAULT 'N',
  `Incentive_Flag` varchar(1) NOT NULL DEFAULT 'N',
  `Bonus_Type` varchar(30) DEFAULT NULL,
  `Contact_Person_Name` varchar(30) NOT NULL,
  `Relationship` varchar(15) NOT NULL,
  `Contact_address1` varchar(40) NOT NULL,
  `Contact_address2` varchar(40) NOT NULL,
  `Contact_home_tel1` varchar(20) DEFAULT NULL,
  `Contact_home_tel2` varchar(20) DEFAULT NULL,
  `Emp_Blood_Group` varchar(4) NOT NULL,
  `EOBI_Number` varchar(20) NOT NULL DEFAULT '0',
  `SESSI_Number` varchar(20) NOT NULL DEFAULT '0',
  `Vehicle_Registration_Number` varchar(100) NOT NULL DEFAULT '0',
  `Status` varchar(30) DEFAULT NULL,
  `Interest_Flag` varchar(1) NOT NULL DEFAULT 'N',
  `Zakat_Flag` varchar(1) NOT NULL DEFAULT 'N',
  `Account_Type1` varchar(20) DEFAULT NULL,
  `Account_Type2` varchar(20) DEFAULT NULL,
  `Account_Type3` varchar(20) DEFAULT NULL,
  `Account_Type4` varchar(20) DEFAULT NULL,
  `Picture` text DEFAULT NULL,
  `Emp_id` varchar(50) DEFAULT NULL,
  `Offer_Letter_date` text DEFAULT NULL,
  `Tentative_Joining_date` text DEFAULT NULL,
  `RefferedBy` varchar(50) DEFAULT NULL,
  `Probationary_period_months` int(11) DEFAULT NULL,
  `Notice_period_months` int(11) DEFAULT NULL,
  `Extended_confirmation_days` int(11) DEFAULT NULL,
  `Permanent_address` varchar(200) DEFAULT NULL,
  `Nationality` varchar(50) DEFAULT NULL,
  `Process_Flag` varchar(1) DEFAULT NULL,
  `Created_By` int(11) DEFAULT NULL,
  `Created_On` text DEFAULT NULL,
  `Updated_By` int(11) DEFAULT NULL,
  `Updated_On` text DEFAULT NULL,
  `roster_group_code` int(11) DEFAULT NULL,
  `card_no` varchar(50) DEFAULT NULL,
  `ContractExpiryDate` text DEFAULT NULL,
  `Position_Code` int(11) DEFAULT NULL,
  `Company_Code` int(11) DEFAULT NULL,
  `UserCode` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tran_appointments`
--

INSERT INTO `tran_appointments` (`Sequence_no`, `Transaction_Date`, `Emp_name`, `Emp_Father_name`, `Emp_sex_code`, `Emp_marital_status`, `Emp_birth_date`, `Emp_appointment_date`, `Emp_confirm_date`, `Emp_category`, `Emp_Leave_category`, `Emp_address_line1`, `Emp_address_line2`, `Emp_home_tel1`, `Emp_home_tel2`, `Emp_office_tel1`, `Emp_office_tel2`, `Emp_mobile_No`, `Emp_nic_no`, `Emp_nic_issue_date`, `Emp_nic_expiry_date`, `Emp_retirement_age`, `Emp_ntn_no`, `Emp_email`, `Confirmation_Flag`, `Empt_Type_code`, `Desig_code`, `Grade_code`, `Cost_Centre_code`, `Dept_code`, `Loc_code`, `Edu_code`, `Transport_code`, `Supervisor_Code`, `Religion_Code`, `Section_code`, `Shift_code`, `Deletion_Flag`, `Emp_Payroll_category`, `Mode_Of_Payment`, `Bank_Account_No1`, `Branch_Code1`, `Bank_Amount_1`, `Bank_Percent_1`, `Bank_Account_No2`, `Branch_Code2`, `Bank_Amount_2`, `Bank_Percent_2`, `Bank_Account_No3`, `Branch_Code3`, `Bank_Amount_3`, `Bank_Percent_3`, `Bank_Account_No4`, `Branch_Code4`, `Bank_Amount_4`, `Bank_Percent_4`, `SESSI_Flag`, `EOBI_Flag`, `Union_Flag`, `Recreation_Club_Flag`, `Meal_Deduction_Flag`, `Overtime_Flag`, `Incentive_Flag`, `Bonus_Type`, `Contact_Person_Name`, `Relationship`, `Contact_address1`, `Contact_address2`, `Contact_home_tel1`, `Contact_home_tel2`, `Emp_Blood_Group`, `EOBI_Number`, `SESSI_Number`, `Vehicle_Registration_Number`, `Status`, `Interest_Flag`, `Zakat_Flag`, `Account_Type1`, `Account_Type2`, `Account_Type3`, `Account_Type4`, `Picture`, `Emp_id`, `Offer_Letter_date`, `Tentative_Joining_date`, `RefferedBy`, `Probationary_period_months`, `Notice_period_months`, `Extended_confirmation_days`, `Permanent_address`, `Nationality`, `Process_Flag`, `Created_By`, `Created_On`, `Updated_By`, `Updated_On`, `roster_group_code`, `card_no`, `ContractExpiryDate`, `Position_Code`, `Company_Code`, `UserCode`) VALUES
(1, '2020-06-19 00:00:00.000000', 'Azeem Khan', 'Maqsood Khan', 'M', 'M', '1990-01-08 00:00:00.000000', '2020-06-01 00:00:00.000000', '2020-06-01 00:00:00.000000', 1, 1, '714 Anum Estate Shahr-e-faisal Karachi ', 'N/A', '', 'N/A', 'N/A', 'N/A', '03212413391', '422014567890124', '2020-06-19', '2025-12-31', 60, 'N/A', 'N/A', 'N', 1, 50, 16, 1, 11, 10, 39, 0, 222, 3, 2, 1, 'N', 1, 1, '1122334455', 1, 100, 100, '0', 1, 0, 0, '0', 1, 0, 0, '0', 1, 0, 0, 'N', 'Y', 'N', 'N', 'N', 'N', 'N', 'NotApplicable', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'Azeem-001', '0', 'N/A', 'Payroll Done', 'N', 'N', 'C', '', '', '', '\0', '', '2020-06-01', '2020-06-01', 'N/A', 3, 3, 0, 'N/A', 'Pakistani', 'Y', 1543, '2020-06-19 15:24:15.033000', 1543, '2020-06-19 15:38:01.367000', 1, 'NA', '2020-10-21 11:03:31.807000', 0, 0, 0),
(2, '2020-06-19 00:00:00.000000', 'Salima Khan', 'Ahmed Khan', 'F', 'S', '1997-02-14 00:00:00.000000', '2020-05-01 00:00:00.000000', '2020-05-01 00:00:00.000000', 1, 1, 'House no R-5 Row no 10 Block 10 A National Cement Society Karachi', 'N/A', '', 'N/A', 'N/A', 'N/A', '03122908656', '42201-9845133-5', '2020-06-19', '2025-06-24', 60, 'N/A', 'salima@gmail.com', 'N', 1, 116, 17, 10, 13, 10, 15, 0, 222, 3, 4, 1, 'N', 1, 1, '000527', 1, 100, 0, '0', 1, 0, 0, '0', 1, 0, 0, '0', 1, 0, 0, 'N', 'Y', 'N', 'N', 'N', 'N', 'N', 'NotApplicable', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'Salima_90002', '0', 'N/A', 'Payroll Done', 'N', 'N', 'C', '', '', '', '\0', '', '2019-06-10', '2019-06-10', 'N/A', 3, 3, 0, 'N/A', 'N/A', 'Y', 1543, '2020-06-19 15:56:39.820000', 1543, '2020-06-19 15:56:39.820000', 1, 'NA', '2020-10-21 11:03:31.807000', 0, 0, 0),
(3, '2020-06-19 00:00:00.000000', 'Shahrukh Khan', 'Zubair Khan', 'M', 'S', '1994-01-08 00:00:00.000000', '2020-01-01 00:00:00.000000', '2020-01-01 00:00:00.000000', 1, 1, 'E-14 Hasan Center Block -16 Gulshan-e-Iqbal Karachi', 'N/A', '', 'N/A', 'N/A', 'N/A', ' 0301 8274072', '422014567890127', '2020-06-19', '2025-06-11', 60, 'N/A', 'N/A', 'N', 1, 74, 18, 16, 19, 10, 15, 0, 421, 3, 10, 1, 'N', 1, 1, '000527', 1, 100, 0, '0', 1, 0, 0, '0', 1, 0, 0, '0', 1, 0, 0, 'N', 'Y', 'N', 'N', 'N', 'N', 'N', 'NotApplicable', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'Shahrukh_90003', '0', 'N/A', 'Payroll Done', 'N', 'N', 'C', '', '', '', '\0', '', '2020-01-01', '2020-01-01', 'N/A', 3, 3, 0, 'N/A', 'N/A', 'Y', 1543, '2020-06-19 16:05:17.353000', 1543, '2020-06-19 16:05:17.353000', 1, 'NA', '2020-10-21 11:03:31.807000', 0, 0, 0),
(4, '2020-06-30 00:00:00.000000', 'Mohammed Ehsan Hingora', 'Muhammad Saleem', 'M', 'S', '1991-08-23 00:00:00.000000', '2020-06-01 00:00:00.000000', '2020-06-01 00:00:00.000000', 1, 1, '402 Adam Plaza Plot No JM 396 6', '402 Adam Plaza Plot No JM 396 6', 'na', 'ha', 'ha', 'ha', '3228237177', '42201-3584747-1', '2020-06-03', '2020-06-30', 60, 'na', 'na', 'N', 1, 128, 18, 48, 23, 10, 2, 0, 0, 3, 14, 1, 'N', 1, 0, '0', 1, 0, 0, '0', 1, 0, 0, '0', 1, 0, 0, '0', 1, 0, 0, 'N', 'Y', 'N', 'N', 'N', 'N', 'N', 'NotApplicable', 'na', 'na', 'na', 'na', 'na', 'na', 'N/A', 'na', '0', 'na', 'Payroll Done', 'N', 'N', '', '', '', '', '\0', '', '2020-06-01', '2020-06-01', 'nz', 3, 60, 0, 'N/A', 'Pakistani', 'Y', 1543, '2020-06-30 11:04:17.397000', 1543, '2020-06-30 11:04:17.397000', 1, 'NA', '2020-10-21 11:03:31.807000', 0, 0, 0),
(5, '2020-06-30 00:00:00.000000', 'Nida Khan', 'Muhammad Akhter Yar Khan', 'F', 'S', '1993-01-22 00:00:00.000000', '2020-06-08 00:00:00.000000', '2020-06-08 00:00:00.000000', 1, 1, 'Flat No 1 Building No 6 Pakistan Housing Authority', 'Flat No 1 Building No 6 Pakistan Housing', 'na', 'na', 'na', 'na', 'na', '42201-8643209-0', '2020-06-14', '2020-06-14', 0, 'N/A', 'na', 'N', 1, 123, 19, 53, 33, 10, 44, 0, 0, 3, 24, 1, 'N', 1, 0, '0', 1, 0, 0, '0', 1, 0, 0, '0', 1, 0, 0, '0', 1, 0, 0, 'N', 'Y', 'N', 'N', 'N', 'N', 'N', 'NotApplicable', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'na', '0', 'na', 'Payroll Done', 'N', 'N', '', '', '', '', '\0', '', '2020-06-17', '2020-06-15', 'nz', 3, 60, 0, 'N/A', 'N/A', 'Y', 1543, '2020-06-30 11:15:32.060000', 1543, '2020-06-30 11:15:32.060000', 1, 'NA', '2020-10-21 11:03:31.807000', 0, 0, 0),
(6, '2020-08-21 00:00:00.000000', 'Dania Hassan Ansari', 'Muhammad Usman Ali Ansari', 'F', 'S', '1992-12-03 00:00:00.000000', '2020-08-17 00:00:00.000000', '2020-08-17 00:00:00.000000', 1, 1, 'A 180 Block 17, Gulistan e Jauhar Karachi', 'N/A', '', 'N/A', 'N/A', 'N/A', '03341343709', '42201-3181541-0', '2020-08-21', '2025-08-21', 60, 'N/A', 'dania.ansari@roche.com', 'N', 1, 116, 19, 17, 38, 10, 51, 0, 1474, 1, 29, 1, 'N', 1, 1, '0', 1, 100, 100, '0', 2, 0, 0, '0', 2, 0, 0, '0', 2, 0, 0, 'N', 'Y', 'N', 'N', 'N', 'N', 'N', 'NotApplicable', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', 'N/A', 'Payroll Done', 'N', 'N', 'C', '', '', '', '\0\0', '', '2020-08-17', '2020-08-17', 'N/A', 6, 1, 0, 'N/A', 'Pakistani', 'Y', 1543, '2020-08-21 12:19:29.490000', 1543, '2020-08-21 12:19:29.490000', 1, 'NA', '2020-10-21 11:03:31.807000', 0, 0, 0),
(7, '2020-11-19 00:00:00.000000', 'Madiha Batool', 'Abdul Qayyum Tahir', 'F', 'S', '1989-07-21 00:00:00.000000', '2020-11-16 00:00:00.000000', '2020-11-16 00:00:00.000000', 1, 1, 'S2 Marfani Cottages, 62 A, P.E.C.H.S., Block-2, Karachi', 'S2 Marfani Cottages, 62 A, P.E.C.H.S., B', '', 'N/A', 'N/A', 'N/A', '0345-3392689', '42201-0290288-8', '2020-11-19', '2025-01-04', 60, 'N/A', 'madiha.batool@roche.com', 'N', 1, 169, 21, 17, 38, 10, 51, 0, 1474, 1, 29, 1, 'N', 1, 1, 'PK19MPBL0112357140357148', 4, 100, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'Y', 'N', 'N', 'N', 'N', 'N', 'NotApplicable', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', 'N/A', 'Payroll Done', 'N', 'N', 'C', 'N', 'N', 'N', '\0\0', '', '2020-11-16', '2020-11-16', 'N/A', 6, 1, 0, 'N/A', 'Pakistani', 'Y', 1543, '2020-11-19 15:22:14.233000', 1543, '2020-11-19 15:25:09.840000', 1, 'NA', '2020-11-19 00:00:00.000000', 0, 0, 0),
(8, '2020-12-21 00:00:00.000000', 'Bilal Butt', 'Ghulam Nabi', 'M', 'S', '1988-02-22 00:00:00.000000', '2020-11-30 00:00:00.000000', '2020-11-30 00:00:00.000000', 3, 1, 'KH1110, St # 02, Darbar Road, Girja Road, Rawalpindi', 'KH1110, St # 02, Darbar Road, Girja Road', 'N/A', 'N/A', 'N/A', 'N/A', '03335989892', '37405-9110913-9', '2020-07-01', '2025-01-31', 60, 'N/A', 'bilal.butt@roche.com', 'N', 1, 139, 22, 49, 44, 9, 8, 0, 222, 1, 35, 1, 'N', 1, 1, 'PK78SCBL0000001705389501', 7, 100, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'Y', 'N', 'N', 'N', 'N', 'Y', 'NotApplicable', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', 'N/A', 'Payroll Done', 'N', 'N', '', 'N', 'N', 'N', '\0\0', '', '2020-11-30', '2020-11-30', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 'Y', 1543, '2020-12-21 14:26:50.167000', 1543, '2020-12-21 14:48:29.780000', 1, 'NA', '2020-12-21 00:00:00.000000', 0, 0, 0),
(9, '2020-12-21 00:00:00.000000', 'Rida Shaikh', 'Muhammad Arshad Shaikh', 'F', 'M', '1994-04-06 00:00:00.000000', '2020-11-30 00:00:00.000000', '2020-11-30 00:00:00.000000', 3, 1, 'House # 35/2 M. Street Phase 4, DHA Karachi', 'House # 35/2 M. Street Phase 4, DHA Kara', 'N/A', 'N/A', 'N/A', 'N/A', '03233336627', '42000-6626917-2', '2020-07-01', '2025-12-31', 60, 'N/A', 'rida.shaikh@roche.com', 'N', 1, 57, 19, 53, 31, 10, 7, 0, 222, 1, 22, 1, 'N', 1, 1, 'PK72BAHL1055007800427150', 2, 100, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'Y', 'N', 'N', 'N', 'N', 'N', 'Fixed', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', 'N/A', 'Payroll Done', 'N', 'N', 'C', 'N', 'N', 'N', '\0\0', '', '2020-11-30', '2020-11-30', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 'Y', 1543, '2020-12-21 14:56:33.267000', 1543, '2020-12-21 14:56:33.267000', 1, 'NA', '2020-12-21 00:00:00.000000', 0, 0, 0),
(10, '2020-12-21 00:00:00.000000', 'Nouman Khalid', 'Khalid Rasheed Mirza', 'M', 'S', '1994-09-10 00:00:00.000000', '2020-12-14 00:00:00.000000', '2020-12-14 00:00:00.000000', 2, 1, '414-B, Johar Town Lahore', '414-B, Johar Town Lahore', 'N/A', 'N/A', 'N/A', 'N/A', '03343368496', '35202-5401671-3', '2020-07-01', '2025-12-31', 60, 'N/A', 'nouman.khalid@roche.com', 'N', 1, 139, 22, 33, 55, 10, 13, 0, 222, 1, 46, 1, 'N', 1, 1, 'PK49SCBL0000001706464201', 7, 100, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'Y', 'N', 'N', 'N', 'N', 'N', 'Fixed', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', 'N/A', 'Payroll Done', 'N', 'N', 'C', 'N', 'N', 'N', '\0\0', '', '2020-12-14', '2020-12-14', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 'Y', 1543, '2020-12-21 15:05:04.840000', 1543, '2020-12-21 15:05:04.840000', 1, 'NA', '2020-12-21 00:00:00.000000', 0, 0, 0),
(11, '2021-01-22 00:00:00.000000', 'Muhammad Bilal', 'Muhammad Mumtaz Sajid', 'M', 'M', '1988-07-09 00:00:00.000000', '2020-12-30 00:00:00.000000', '2020-12-30 00:00:00.000000', 1, 1, 'CB 105, Alam Sher Colony, Behind Christian Hospital, Taxila District Rawalpindi', 'CB 105, Alam Sher Colony, Behind Christi', 'N/A', 'N/A', 'N/A', 'N/A', '00923347074707', '37406-4057004-3', '2020-11-17', '2025-12-25', 60, 'N/A', 'muhammad.bilal.mb2@roche.com', 'N', 1, 74, 23, 10, 43, 9, 52, 0, 950, 1, 34, 1, 'N', 1, 1, 'PK42SCBL0000001273576801', 7, 0, 100, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'N', 'N', 'N', 'N', 'N', 'Y', 'NotApplicable', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', '0', 'N/A', 'Payroll Done', 'N', 'N', 'C', 'N', 'N', 'N', '\0\0', '1648', '2020-12-30', '2020-12-30', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 'Y', 1543, '2021-01-22 10:43:12.100000', 1543, '2021-01-22 10:43:12.100000', 1, 'NA', '2021-01-22 00:00:00.000000', 0, 0, 0),
(12, '2021-01-22 00:00:00.000000', 'Ali Saleem Manghi', 'Saleem Manghi', 'M', 'S', '1990-02-22 00:00:00.000000', '2021-01-01 00:00:00.000000', '2021-01-01 00:00:00.000000', 1, 1, 'D 42-1  Block 1, Clifton Karachi', 'D 42-1  Block 1, Clifton Karachi', 'N/A', 'N/A', 'N/A', 'N/A', '00923003543070', '42201-5774466-8', '2020-07-01', '2025-12-25', 60, 'N/A', 'ali.manghi@roche.com', 'N', 1, 116, 19, 17, 38, 10, 34, 0, 1474, 1, 29, 1, 'N', 1, 1, 'PK25HABB0024857900531303', 1, 0, 100, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'Performance', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', '0', 'N/A', 'Payroll Done', 'N', 'N', 'C', 'N', 'N', 'N', '\0\0', '1649', '2021-01-01', '2021-01-01', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 'Y', 1543, '2021-01-22 10:56:34.500000', 1543, '2021-01-22 10:56:34.500000', 1, 'NA', '2021-01-22 00:00:00.000000', 0, 0, 0),
(13, '2021-03-19 00:00:00.000000', 'Hafiz Syed Muhammad Ibrahim Sh', 'Syed Muhammad Shahab Ilyas', 'M', 'M', '1993-04-26 00:00:00.000000', '2021-03-01 00:00:00.000000', '2021-03-01 00:00:00.000000', 2, 1, 'House A2/4, Sector 15 A, Scheme 33, Rufi Rose Petal, Gulzar e Hijri, Karachi', 'House A2/4, Sector 15 A, Scheme 33, Rufi', '', 'N/A', 'N/A', 'N/A', '02133268958', '42201-3653415-9', '2020-07-01', '2025-07-31', 60, 'N/A', 'hafiz_syed.shahab@roche.com', 'N', 1, 139, 22, 36, 48, 10, 11, 0, 729, 1, 39, 1, 'N', 1, 1, 'PK39MEZN0001040103164302', 6, 0, 100, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'Y', 'N', 'N', 'N', 'N', 'N', 'Fixed', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', 'N/A', 'Payroll Done', 'N', 'N', 'C', 'N', 'N', 'N', '\0\0', '1650', '2021-03-01', '2021-03-01', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 'Y', 1543, '2021-03-19 11:43:23.200000', 1543, '2021-03-19 11:43:23.200000', 1, 'NA', '2021-03-19 00:00:00.000000', 0, 0, 0),
(14, '2021-04-20 00:00:00.000000', 'Hamas', 'Jawed Kaparia', 'M', 'M', '1994-08-31 00:00:00.000000', '2021-04-01 00:00:00.000000', '2021-04-01 00:00:00.000000', 2, 1, 'Flat # 406, Crystal Home, 63/111, BMCHS, Bahadurabad, Karachi.', 'Flat # 406, Crystal Home, 63/111, BMCHS,', 'N/A', 'N/A', 'N/A', 'N/A', '0342-5779655', '42301-8290208-5', '2020-07-01', '2029-07-31', 60, 'N/A', 'hamas.kapadia@roche.com', 'N', 1, 180, 22, 43, 42, 10, 51, 0, 722, 1, 33, 1, 'N', 1, 1, 'PK37MEZN0001590104476284', 2, 100, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'Y', 'N', 'N', 'N', 'N', 'N', 'Fixed', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', 'N/A', 'Payroll Done', 'N', 'N', 'C', 'N', 'N', 'N', '\0\0', '1651', '2021-04-01', '2021-04-01', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 'Y', 1543, '2021-04-20 12:42:07.650000', 1543, '2021-04-20 12:45:19.363000', 1, 'NA', '2021-04-20 00:00:00.000000', 0, 0, 0),
(15, '2021-04-20 00:00:00.000000', 'Muhammad Ammad Salman', 'Muhammad Salman', 'M', 'S', '1992-12-03 00:00:00.000000', '2021-04-12 00:00:00.000000', '2021-04-12 00:00:00.000000', 2, 1, 'Flat # A-107, Block A, Karachi Center Apartment, PIB Colony, Near University Road, Karachi.', 'Flat # A-107, Block A, Karachi Center Ap', 'N/A', 'N/A', 'N/A', 'N/A', '0315-0236573', '42201-0244904-9', '2020-07-01', '2029-07-31', 60, 'N/A', 'muhammad_ammad.salman@roche.com', 'N', 1, 145, 22, 33, 55, 10, 19, 0, 722, 1, 46, 1, 'N', 1, 1, 'PK84MEZN0001650101831603', 6, 100, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'Y', 'N', 'N', 'N', 'N', 'N', 'Fixed', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', 'N/A', 'Payroll Done', 'N', 'N', 'C', 'N', 'N', 'N', '\0\0', '1652', '2021-04-12', '2021-04-12', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 'Y', 1543, '2021-04-20 12:57:21.600000', 1543, '2021-04-20 12:58:17.713000', 1, 'NA', '2021-04-20 00:00:00.000000', 0, 0, 0),
(16, '2021-05-20 00:00:00.000000', 'Rabeea Sarwar', 'Muhammad Sarwar', 'F', 'M', '1994-03-05 00:00:00.000000', '2021-04-19 00:00:00.000000', '2021-04-19 00:00:00.000000', 2, 1, '292, Hunza Block, Allama Iqbal Town, Lahore', '292, Hunza Block, Allama Iqbal Town, Lah', 'N/A', 'N/A', 'N/A', 'N/A', '03184075918', '33401-0658737-4', '2020-07-01', '2025-12-31', 60, 'N/A', 'rabeea.sarwar@roche.com', 'N', 1, 178, 22, 42, 37, 11, 51, 0, 722, 1, 28, 1, 'N', 1, 1, 'PK93HABB0012487902323403', 1, 0, 100, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'Y', 'N', 'N', 'N', 'N', 'N', 'Fixed', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', 'N/A', 'Payroll Done', 'N', 'N', 'C', 'N', 'N', 'N', '\0\0', '1653', '2021-04-19', '2021-04-19', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 'Y', 1543, '2021-05-20 09:48:50.307000', 1543, '2021-05-20 09:48:50.307000', 1, 'NA', '2021-05-20 00:00:00.000000', 0, 0, 0),
(17, '2021-06-21 00:00:00.000000', 'Syed Usman Jawaid Bukhari', 'Syed Jawaid Habib Bukhari', 'M', 'M', '1989-08-02 00:00:00.000000', '2021-06-07 00:00:00.000000', '2021-06-07 00:00:00.000000', 2, 1, 'A-83, Govt. Teachers Housing Society, Sector 16-A, Gulzar-e-Hijri, Karachi', 'A-83, Govt. Teachers Housing Society, Se', 'N/A', 'N/A', 'N/A', 'N/A', '03452501130', '42201-1157483-7', '2020-07-01', '2029-12-31', 60, 'N/A', 'syed.usman_jawaid_bukhari@roche.com', 'N', 1, 192, 19, 28, 23, 10, 42, 0, 845, 1, 14, 1, 'N', 1, 1, 'PK65 HABB 23807000286003PK65 H', 0, 100, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'Y', 'N', 'N', 'N', 'N', 'N', 'Fixed', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', 'N/A', 'Payroll Done', 'N', 'N', 'C', 'N', 'N', 'N', '\0\0', '1654', '2021-06-07', '2021-06-07', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 'Y', 1543, '2021-06-21 13:44:37.937000', 1543, '2021-06-21 13:54:37.533000', 1, 'NA', '2021-06-21 00:00:00.000000', 0, 0, 0),
(18, '2021-07-19 00:00:00.000000', 'Neha Khan', 'Ihsan Muhammad Ali Khan', 'F', 'M', '1992-08-17 00:00:00.000000', '2021-07-05 00:00:00.000000', '2021-07-05 00:00:00.000000', 1, 1, 'House No. A3, Block 15, Gulshan-e-Iqbal, Karachi', 'House No. A3, Block 15, Gulshan-e-Iqbal,', 'N/A', 'N/A', 'N/A', 'N/A', '03202304181', '42201-7498948-8', '2021-07-01', '2029-06-06', 60, 'N/A', 'neha.khan@roche.com', 'N', 1, 206, 18, 1, 27, 10, 7, 0, 1492, 1, 18, 1, 'N', 1, 1, 'PK96FAYS0210006900103221', 2, 100, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'Y', 'N', 'N', 'N', 'N', 'N', 'Performance', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', 'N/A', 'Payroll Done', 'N', 'N', 'C', 'N', 'N', 'N', '\0\0', '1655', '2021-07-05', '2021-07-05', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 'Y', 1543, '2021-07-19 16:14:30.303000', 1543, '2021-07-19 16:14:30.303000', 1, 'NA', '2021-07-19 00:00:00.000000', 0, 0, 0),
(19, '2021-07-19 00:00:00.000000', 'Daniyal Ali Khan', 'Ahmad Ali Khan', 'M', 'S', '1993-07-11 00:00:00.000000', '2021-07-01 00:00:00.000000', '2021-07-01 00:00:00.000000', 1, 1, 'H54/9 Malir Colony, Near Jinnah Square, Karachi', 'H54/9 Malir Colony, Near Jinnah Square, ', 'N/A', 'N/A', 'N/A', 'N/A', '03312667639', '42000-5748709-1', '2021-07-08', '2029-11-24', 60, 'N/A', 'daniyal_ali.khan@roche.com', 'N', 1, 196, 21, 10, 23, 10, 51, 0, 1249, 1, 14, 1, 'N', 1, 1, '00277901480703', 1, 100, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'Y', 'N', 'N', 'N', 'N', 'N', 'Performance', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', 'N/A', 'Payroll Done', 'N', 'N', 'C', 'N', 'N', 'N', '\0\0', '1656', '2021-07-01', '2021-07-01', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 'Y', 1543, '2021-07-19 16:35:23.560000', 1543, '2021-07-19 16:35:23.560000', 1, 'NA', '2021-07-19 00:00:00.000000', 0, 0, 0),
(20, '2021-07-20 00:00:00.000000', 'Usama Baig', 'Arshad Azhar', 'M', 'M', '1986-01-17 00:00:00.000000', '2021-07-01 00:00:00.000000', '2021-07-01 00:00:00.000000', 1, 1, 'House # 6C, Street # 22 Empress Park, Empress Road, Lahore', 'House # 6C, Street # 22 Empress Park, Em', 'N/A', 'N/A', 'N/A', 'N/A', '03214712199', '35202-9912928-7', '2021-07-08', '2029-07-09', 60, 'N/A', 'Usama.baig@roche.com', 'N', 1, 196, 21, 1056, 23, 11, 13, 0, 1249, 1, 14, 1, 'N', 1, 1, 'PK37UNIL0112059002114701', 8, 100, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'Y', 'N', 'N', 'N', 'N', 'N', 'Performance', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', 'N/A', 'Payroll Done', 'N', 'N', 'C', 'N', 'N', 'N', '\0\0', '1657', '2021-07-01', '2021-07-01', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 'Y', 1543, '2021-07-20 11:23:06.937000', 1543, '2021-07-20 11:23:06.937000', 1, 'NA', '2021-07-20 00:00:00.000000', 0, 0, 0),
(21, '2021-07-20 00:00:00.000000', 'Muhammad Ehtisham Shafique', 'Muhammad Shafique', 'M', 'S', '1992-01-10 00:00:00.000000', '2021-07-01 00:00:00.000000', '2021-07-01 00:00:00.000000', 1, 1, 'H# 12 Street 1/4 Lane 16 Quaid e azam Colony, Chakri road Rawalpindi', 'H# 12 Street 1/4 Lane 16 Quaid e azam Co', 'N/A', 'N/A', 'N/A', 'N/A', '03109466698', '37406-5708669-9', '2021-07-08', '2029-07-09', 60, 'N/A', 'muhammad_ehtisham.shafique@roche.com', 'N', 1, 197, 21, 4, 13, 9, 36, 0, 1192, 1, 4, 1, 'N', 1, 1, '04877900941903', 1, 100, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'Y', 'N', 'N', 'N', 'N', 'N', 'Performance', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', 'N/A', 'Payroll Done', 'N', 'N', 'C', 'N', 'N', 'N', '\0\0', '1658', '2021-07-01', '2021-07-01', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 'Y', 1543, '2021-07-20 11:31:24.657000', 1543, '2021-07-20 11:31:24.657000', 1, 'NA', '2021-07-20 00:00:00.000000', 0, 0, 0),
(22, '2021-09-21 00:00:00.000000', 'Ghulam Mustafa', 'Ali Sher', 'M', 'S', '1995-03-20 00:00:00.000000', '2021-09-01 00:00:00.000000', '2021-09-01 00:00:00.000000', 2, 1, 'House No: 1280, St # 05, Memon Mohalla, P.O & Tehsil Gambat District Khairpur', 'House No: 1280, St # 05, Memon Mohalla, ', 'N/A', 'N/A', 'N/A', 'N/A', '03073708810', '45202-4054827-7', '2021-07-08', '2030-11-20', 60, 'N/A', 'ghulam.memon@roche.com', 'N', 1, 145, 22, 33, 56, 10, 10, 0, 722, 1, 47, 1, 'N', 1, 1, 'PK65HABB0014957935375903', 1, 100, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'Y', 'N', 'N', 'N', 'N', 'N', 'Performance', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', 'N/A', 'Payroll Done', 'N', 'N', 'C', 'N', 'N', 'N', '\0\0', '1659', '2021-09-01', '2021-09-01', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 'Y', 1543, '2021-09-21 09:23:20.867000', 1543, '2021-09-21 09:23:20.867000', 1, 'NA', '2021-09-21 00:00:00.000000', 0, 0, 0),
(23, '2021-09-21 00:00:00.000000', 'Muhammad Anus Khan', 'Amir Kaleem Khan', 'M', 'S', '1996-10-04 00:00:00.000000', '2021-09-01 00:00:00.000000', '2021-09-01 00:00:00.000000', 2, 1, 'House No:118-B Block:3-A Gulistan-e-Johar Karachi', 'House No:48/C, Block-E, Unit:8 Latifabad', 'N/A', 'N/A', 'N/A', 'N/A', '03063082795', '41304-3752965-7', '2021-07-01', '2030-11-12', 60, 'N/A', 'muhammad.anus@roche.com', 'N', 1, 145, 22, 33, 55, 10, 10, 0, 722, 1, 46, 1, 'N', 1, 1, 'PK95UNIL0109000225857371', 2, 100, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'Y', 'N', 'N', 'N', 'N', 'N', 'Performance', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', 'N/A', 'Payroll Done', 'N', 'N', 'C', 'N', 'N', 'N', '\0\0', '1660', '2021-09-01', '2021-09-01', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 'Y', 1543, '2021-09-21 09:32:02.217000', 1543, '2021-09-21 09:32:02.217000', 1, 'NA', '2021-09-21 00:00:00.000000', 0, 0, 0),
(24, '2021-09-21 00:00:00.000000', 'Babar Saddique', 'Muhammad Saddique', 'M', 'M', '1987-10-01 00:00:00.000000', '2021-09-01 00:00:00.000000', '2021-09-01 00:00:00.000000', 2, 1, '3/8 Temple Road Lahore', '3/8 Temple Road Lahore', '03344376480', 'N/A', 'N/A', 'N/A', '03204018997', '35202-9114496-1', '2021-07-08', '2030-07-17', 60, 'N/A', 'babar.saddique@roche.com', 'N', 1, 145, 22, 33, 55, 11, 10, 0, 722, 1, 46, 1, 'N', 1, 1, 'PK91HABB0010607900543001', 1, 100, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'Y', 'N', 'N', 'N', 'N', 'N', 'Performance', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', 'engr.babar@yahoo.com', 'Payroll Done', 'N', 'N', 'C', 'N', 'N', 'N', '\0\0', '1661', '2021-09-01', '2021-09-01', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 'Y', 1543, '2021-09-21 09:46:39.283000', 1543, '2021-09-21 09:46:39.283000', 1, 'NA', '2021-09-21 00:00:00.000000', 0, 0, 0),
(25, '2021-09-21 00:00:00.000000', 'Husaifa Atique', 'Atique ur Rehman', 'M', 'M', '1991-12-18 00:00:00.000000', '2021-09-01 00:00:00.000000', '2021-09-01 00:00:00.000000', 2, 1, 'House No.C-1, Landi Road, PAF Base, Peshawar, KPK', 'House No.C-1, Landi Road, PAF Base, Pesh', 'N/A', 'N/A', 'N/A', 'N/A', '03368008191', '42201-6419603-7', '2021-07-08', '2030-12-18', 60, 'N/A', 'huziafa.atique@roche.com', 'N', 1, 145, 22, 33, 55, 9, 21, 0, 722, 1, 46, 1, 'N', 1, 1, 'PK56HABB0009107902018203', 1, 100, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'Y', 'N', 'N', 'N', 'N', 'N', 'Performance', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', 'N/A', 'Payroll Done', 'N', 'N', 'C', 'N', 'N', 'N', '\0\0', '1662', '2021-09-01', '2021-09-01', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 'Y', 1543, '2021-09-21 09:56:39.230000', 1543, '2021-09-21 09:56:39.230000', 1, 'NA', '2021-09-21 00:00:00.000000', 0, 0, 0),
(26, '2021-09-21 00:00:00.000000', 'Muhammad Mobin', 'Abdul Jabbar', 'M', 'S', '1989-04-12 00:00:00.000000', '2021-08-25 00:00:00.000000', '2021-08-25 00:00:00.000000', 1, 1, 'House # D-15/A1, Block 9, Gulshan-e-Iqbal, Karachi', 'House # D-15/A1, Block 9, Gulshan-e-Iqba', 'N/A', 'N/A', 'N/A', 'N/A', '03008258365', '42000-2420212-3', '2021-07-01', '2030-12-12', 60, 'N/A', 'muhammad.mobin@roche.com', 'N', 1, 207, 20, 21, 23, 10, 42, 0, 1610, 1, 14, 1, 'N', 1, 1, 'PK11SCBL0000001712365201', 7, 100, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'Y', 'N', 'N', 'N', 'N', 'N', 'Performance', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', 'N/A', 'Payroll Done', 'N', 'N', 'C', 'N', 'N', 'N', '\0\0', '1663', '2021-08-25', '2021-08-25', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 'Y', 1543, '2021-09-21 10:03:45.040000', 1543, '2021-09-21 10:06:47.427000', 1, 'NA', '2021-09-21 00:00:00.000000', 0, 0, 0),
(27, '2021-09-21 00:00:00.000000', 'Hafsa Shamsie', 'Syed Makhdoom Hussain', 'F', 'M', '1970-09-11 00:00:00.000000', '2021-09-01 00:00:00.000000', '2021-09-01 00:00:00.000000', 1, 1, '14-B, 11th Central Street Phase II DHA.', '14-B, 11th Central Street Phase II DHA.', 'N/A', 'N/A', 'N/A', 'N/A', '923008228897', '42301-2377433-4', '2021-07-01', '2030-11-21', 60, 'N/A', 'hafsa.shamsie@roche.com', 'N', 1, 208, 25, 14, 36, 10, 33, 0, 0, 1, 27, 1, 'N', 1, 1, 'PK23HABB0024410097009401', 1, 100, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'Y', 'N', 'N', 'N', 'N', 'N', 'Performance', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', 'N/A', 'Payroll Done', 'N', 'N', 'C', 'N', 'N', 'N', '\0\0', '1664', '2021-09-01', '2021-09-01', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 'Y', 1543, '2021-09-21 10:13:34.803000', 1543, '2021-09-21 10:14:41.547000', 1, 'NA', '2021-09-21 00:00:00.000000', 0, 0, 0),
(28, '2021-12-20 00:00:00.000000', 'Osama Ali Ghouri', 'Muhammad Asrar Ullah', 'M', 'S', '1994-02-27 00:00:00.000000', '2021-11-15 00:00:00.000000', '2021-11-15 00:00:00.000000', 2, 1, 'R-515 Block 19 Al-Noor Society, Federal B, Area, Karachi', 'R-515 Block 19 Al-Noor Society, Federal ', 'N/A', 'N/A', 'N/A', 'N/A', '03312180490', '42101-4130852-7', '2021-07-08', '2030-06-19', 60, 'N/A', 'osama_ali.ghouri@roche.com', 'N', 1, 146, 22, 33, 55, 10, 19, 0, 722, 1, 46, 1, 'N', 1, 1, 'PK58BAHL1016009501791601', 2, 100, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'Y', 'N', 'N', 'N', 'N', 'N', 'Performance', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', 'N/A', 'Payroll Done', 'N', 'N', 'C', 'N', 'N', 'N', '\0\0', '1664', '2021-11-15', '2021-11-15', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 'Y', 1543, '2021-12-20 12:45:03.703000', 1543, '2021-12-21 16:06:54.180000', 1, 'NA', '2021-12-20 00:00:00.000000', 0, 0, 0),
(29, '2021-12-20 00:00:00.000000', 'Shabbir Hussain', 'Muhammad Hanif', 'M', 'M', '1990-05-17 00:00:00.000000', '2021-12-13 00:00:00.000000', '2021-12-13 00:00:00.000000', 2, 1, 'House No. 697, Sabazar Multan Road, Lahore', 'House No. 697, Sabazar Multan Road, Laho', 'N/A', 'N/A', 'N/A', 'N/A', '03084436177', '35202-3166365-5', '2021-07-08', '2029-06-14', 60, 'N/A', 'shabbir.hussain@roche.com', 'N', 1, 130, 22, 33, 55, 11, 36, 0, 722, 1, 46, 1, 'N', 1, 1, 'PK65MEZN0002090103119501', 6, 100, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'Y', 'N', 'N', 'N', 'N', 'N', 'Performance', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', 'N/A', 'Payroll Done', 'N', 'N', 'C', 'N', 'N', 'N', '\0\0', '1665', '2021-12-13', '2021-12-13', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 'Y', 1543, '2021-12-20 13:18:26.950000', 1543, '2021-12-21 14:21:38.437000', 1, 'NA', '2021-12-20 00:00:00.000000', 0, 0, 0),
(30, '2021-12-20 00:00:00.000000', 'Muhammad Talha Azam', 'Muhammad Azam', 'M', 'S', '1995-03-25 00:00:00.000000', '2021-12-13 00:00:00.000000', '2021-12-13 00:00:00.000000', 2, 1, 'MC 980 Green Town Shah Faisal Colony, Karachi', 'MC 980 Green Town Shah Faisal Colony, Ka', 'N/A', 'N/A', 'N/A', 'N/A', '03100446627', '42201-7343780-5', '2021-07-08', '2029-06-20', 60, 'N/A', 'muhammad_talha.azam@roche.com', 'N', 1, 180, 22, 43, 41, 10, 51, 0, 722, 1, 32, 1, 'N', 1, 1, 'PK68UNIL0109000266503088', 8, 100, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'Y', 'N', 'N', 'N', 'N', 'N', 'NotApplicable', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', 'N/A', 'Payroll Done', 'N', 'N', 'C', 'N', 'N', 'N', '\0\0', '1666', '2021-12-13', '2021-12-13', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 'Y', 1543, '2021-12-20 13:27:33.410000', 1543, '2021-12-21 14:21:28.820000', 1, 'NA', '2021-12-20 00:00:00.000000', 0, 0, 0),
(31, '2022-01-19 00:00:00.000000', 'Rao M. Arsalan Toheed', 'Toheed Pervez', 'M', 'M', '1995-01-01 00:00:00.000000', '2021-12-20 00:00:00.000000', '2021-12-20 00:00:00.000000', 2, 1, 'Farooqia Street, Gulgasht, Sikanderabad,Tehsil Shujabad Dist Multan, Multan', 'Farooqia Street, Gulgasht, Sikanderabad,', 'N/A', 'N/A', 'N/A', 'N/A', '0307-2469897', '36304-5045273-9', '2013-03-08', '2029-07-07', 60, 'N/A', 'arsalan.rao@roche.com', 'N', 1, 145, 22, 33, 55, 11, 23, 0, 722, 1, 46, 1, 'N', 1, 1, 'PK84MEZN0005010103528159', 6, 100, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'Y', 'N', 'N', 'N', 'N', 'N', 'Performance', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', 'N/A', 'Payroll Done', 'N', 'N', 'C', 'N', 'N', 'N', '\0\0', '1667', '2021-12-20', '2021-12-20', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 'Y', 1543, '2022-01-19 14:10:45.403000', 1543, '2022-01-19 14:10:45.403000', 1, 'NA', '2022-01-19 00:00:00.000000', 0, 0, 0),
(32, '2022-01-19 00:00:00.000000', 'Hafiz Muhammad Shahbaz Sheikh', 'Muhammad Saleem', 'M', 'M', '1995-09-02 00:00:00.000000', '2021-12-27 00:00:00.000000', '2021-12-27 00:00:00.000000', 2, 1, 'Flat A-1, RS-6 (ST-7), Sector 5A4, North Karachi', 'Flat A-1, RS-6 (ST-7), Sector 5A4, North', 'N/A', 'N/A', 'N/A', 'N/A', '0336-3017352', '42101-3933260-3', '2018-02-03', '2029-07-02', 60, 'N/A', 'shahbaz_sheikh.hafiz_muhammad_shahbaz_sheikh@roche.com', 'N', 1, 139, 22, 36, 49, 10, 38, 0, 722, 1, 40, 1, 'N', 1, 1, 'PK19SCBL000000172724 0201', 7, 100, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'Y', 'N', 'N', 'N', 'N', 'N', 'Performance', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', 'N/A', 'Payroll Done', 'N', 'N', 'C', 'N', 'N', 'N', '\0\0', '1668', '2021-12-27', '2021-12-27', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 'Y', 1543, '2022-01-19 14:21:32.040000', 1543, '2022-01-19 14:21:32.040000', 1, 'NA', '2022-01-19 00:00:00.000000', 0, 0, 0),
(33, '2022-01-19 00:00:00.000000', 'Aqib Hameed', 'Abdul Hamid', 'M', 'M', '1992-10-15 00:00:00.000000', '2021-12-31 00:00:00.000000', '2021-12-31 00:00:00.000000', 2, 1, '251-Neelam Block Allama Iqbal Town Lahore', '251-Neelam Block Allama Iqbal Town Lahor', 'N/A', 'N/A', 'N/A', 'N/A', '0331-6466290', '35200-9493996-9', '2020-03-24', '2029-07-23', 60, 'N/A', 'aqibhameed9292@gmail.com', 'N', 1, 139, 22, 36, 48, 11, 33, 0, 722, 1, 39, 1, 'N', 1, 1, 'PK60ALFH0028001004694545', 0, 100, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'Y', 'N', 'N', 'N', 'N', 'N', 'Performance', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', 'aqibhameed9292@gmail.com', 'Payroll Done', 'N', 'N', 'C', 'N', 'N', 'N', '\0\0', '1669', '2021-12-31', '2021-12-31', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 'Y', 1543, '2022-01-19 14:30:22.900000', 1543, '2022-01-19 14:30:22.900000', 1, 'NA', '2022-01-19 00:00:00.000000', 0, 0, 0),
(34, '2022-01-19 00:00:00.000000', 'Ghulam Anbia Madni', 'Muhammad Aslam', 'M', 'S', '1996-07-04 00:00:00.000000', '2022-01-04 00:00:00.000000', '2022-01-04 00:00:00.000000', 1, 1, 'LSC-04, Near Maymar Square, Gulshan- e-Iqbal, Block 14, Karachi', 'LSC-04, Near Maymar Square, Gulshan- e-I', 'N/A', 'N/A', 'N/A', 'N/A', '0306-0556617', '37405-7372260-1', '2021-04-21', '2029-04-20', 60, 'N/A', 'ghulam_anbia.madni@roche.com', 'N', 1, 194, 20, 1060, 13, 10, 33, 0, 1192, 1, 1051, 1, 'N', 1, 1, 'PK23HABB0006407992029403', 1, 100, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'Y', 'N', 'N', 'N', 'N', 'N', 'Performance', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', 'N/A', 'Payroll Done', 'N', 'N', 'C', 'N', 'N', 'N', '\0\0', '1670', '2022-01-04', '2022-01-04', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 'Y', 1543, '2022-01-19 14:53:02.340000', 1543, '2022-01-19 14:53:02.340000', 1, 'NA', '2022-01-19 00:00:00.000000', 0, 0, 0),
(35, '2022-02-21 00:00:00.000000', 'Asadullah Mir', 'Tahir Jamil Mir', 'M', 'M', '1993-09-14 00:00:00.000000', '2022-01-19 00:00:00.000000', '2022-01-19 00:00:00.000000', 1, 1, 'Plot # 56/0, Block 6, PECHS, Karachi', 'Plot # 56/0, Block 6, PECHS, Karachi', 'N/A', 'N/A', 'N/A', 'N/A', '\'0347-2936723', '42301-0953962-3', '2016-01-25', '2029-01-26', 60, 'N/A', 'asadullah.mir@roche.com', 'N', 1, 116, 20, 17, 38, 10, 34, 0, 1507, 1, 29, 1, 'N', 1, 1, 'PK95SBCL0000001726913301', 7, 100, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'Y', 'N', 'N', 'N', 'N', 'N', 'Performance', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', 'N/A', 'Payroll Done', 'N', 'N', 'C', 'N', 'N', 'N', '\0\0', '1671', '2022-01-19', '2022-01-19', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 'Y', 1543, '2022-02-21 10:09:34.700000', 1543, '2022-02-21 10:09:34.700000', 1, 'NA', '2022-02-21 00:00:00.000000', 0, 0, 0),
(36, '2022-02-21 00:00:00.000000', 'Hafiz M. Nasir Arslan', 'Muhammad Ashraf', 'M', 'S', '1994-07-11 00:00:00.000000', '2022-01-24 00:00:00.000000', '2022-01-24 00:00:00.000000', 2, 1, '1st Floor Shop#07 Eden Garden, Nawab Block Deawoo Road Faisalabad.', '1st Floor Shop#07 Eden Garden, Nawab Blo', 'N/A', 'N/A', 'N/A', 'N/A', '\'0304-1076313', '31202-6887677-7', '2021-12-06', '2029-12-07', 60, 'N/A', 'hafiz_muhammad.nasir_arslan@roche.com', 'N', 1, 145, 21, 33, 55, 11, 24, 0, 722, 1, 46, 1, 'N', 1, 1, 'PK11MEZN0002090104210656', 6, 100, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'Y', 'N', 'N', 'N', 'N', 'N', 'Performance', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', 'N/A', 'Payroll Done', 'N', 'N', 'C', 'N', 'N', 'N', '\0\0', '1672', '2022-01-24', '2022-01-24', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 'Y', 1543, '2022-02-21 10:30:14.643000', 1543, '2022-02-21 10:30:14.643000', 1, 'NA', '2022-02-21 00:00:00.000000', 0, 0, 0),
(37, '2022-03-21 00:00:00.000000', 'Khurram Riaz', 'Muhammad Riaz', 'M', 'M', '1976-08-04 00:00:00.000000', '2022-03-04 00:00:00.000000', '2022-03-04 00:00:00.000000', 1, 1, 'E-2, 4th Floor, Mahir Terrace, Pir Ghazi Road, Lahore', 'E-2, 4th Floor, Mahir Terrace, Pir Ghazi', 'N/A', 'N/A', 'N/A', 'N/A', '0333-4374207', '35202-2998613-9', '2021-02-21', '2027-02-20', 60, 'N/A', 'khurram.riaz@roche.com', 'N', 1, 194, 20, 1060, 13, 11, 53, 0, 729, 1, 1051, 1, 'N', 1, 1, '10767901095003', 1, 100, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'Y', 'N', 'N', 'N', 'N', 'N', 'Performance', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', 'N/A', 'Payroll Done', 'N', 'N', 'C', 'N', 'N', 'N', '\0\0', '1673', '2022-03-04', '2022-03-04', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 'Y', 1543, '2022-03-21 15:24:02.360000', 1543, '2022-03-21 15:40:07.727000', 1, 'NA', '2022-03-21 00:00:00.000000', 0, 0, 0),
(38, '2022-03-21 00:00:00.000000', 'Ali Murad Dhamani', 'Muhammad Hanif Dhamani', 'M', 'S', '1998-05-26 00:00:00.000000', '2022-03-14 00:00:00.000000', '2022-03-14 00:00:00.000000', 2, 1, 'Flat No. O-398, Karimabad Colony, F.B Area Block 3, Karachi', 'Flat No. O-398, Karimabad Colony, F.B Ar', 'N/A', 'N/A', 'N/A', 'N/A', '03343933024', '42101-6278229-9', '2016-07-29', '2026-07-30', 60, 'N/A', 'ali_murad.dhamani@roche.com', 'N', 1, 130, 22, 33, 55, 10, 54, 0, 722, 1, 46, 1, 'N', 1, 1, 'PK24BAHL1121007800615901', 2, 100, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'Y', 'N', 'N', 'N', 'N', 'N', 'Performance', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', 'N/A', 'Payroll Done', 'N', 'N', 'C', 'N', 'N', 'N', '\0\0', '1674', '2022-03-14', '2022-03-14', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 'Y', 1543, '2022-03-21 15:38:08.090000', 1543, '2022-03-21 15:39:57.477000', 1, 'NA', '2022-03-21 00:00:00.000000', 0, 0, 0),
(39, '2022-04-20 00:00:00.000000', 'Abdul Mateen Khan', 'Muhammad Wali Ullah', 'M', 'M', '1986-04-02 00:00:00.000000', '2022-04-13 00:00:00.000000', '2022-04-13 00:00:00.000000', 1, 1, 'House 8, Street 8, Chatha Bakhtawar, Chak Shehzad, Islamabad', 'House 8, Street 8, Chatha Bakhtawar, Cha', 'N/A', 'N/A', 'N/A', 'N/A', '0300-5274140', '61101-0255290-1', '2016-01-25', '2030-12-31', 60, 'N/A', 'abdul_mateen.khan@roche.com', 'N', 1, 206, 18, 1063, 27, 10, 33, 0, 1507, 1, 18, 1, 'N', 1, 1, 'PK70SCBL0000001708391601', 7, 100, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'Y', 'N', 'N', 'N', 'N', 'N', 'Performance', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', 'N/A', 'Payroll Done', 'N', 'N', 'C', 'N', 'N', 'N', '\0\0', '1675', '2022-04-13', '2022-04-13', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 'Y', 1543, '2022-04-20 10:07:21.167000', 1543, '2022-04-20 10:07:21.167000', 1, 'NA', '2022-04-20 00:00:00.000000', 0, 0, 0),
(40, '2022-04-20 00:00:00.000000', 'Faisal Ahmed Abro', 'Ahmed Ali Abro', 'M', 'S', '1994-02-04 00:00:00.000000', '2022-04-14 00:00:00.000000', '2022-04-14 00:00:00.000000', 1, 1, 'Maryam House, Mehran University Co-operative Housing Society, Jamshoro, Sindh', 'Maryam House, Mehran University Co-opera', 'N/A', 'N/A', 'N/A', 'N/A', '0333-7198959', '43203-7481230-1', '2017-10-17', '2027-10-16', 60, 'N/A', 'ahmed_faisal.ahmed_faisal@roche.com', 'N', 1, 194, 20, 1060, 13, 10, 51, 0, 1192, 1, 1051, 1, 'N', 1, 1, 'PK63HABB0050977917B60303', 1, 100, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'Y', 'N', 'N', 'N', 'N', 'N', 'Performance', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', 'N/A', 'Payroll Done', 'N', 'N', 'C', 'N', 'N', 'N', '\0\0', '1676', '2022-04-14', '2022-04-14', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 'Y', 1543, '2022-04-20 10:15:26.070000', 1543, '2022-04-20 10:15:26.070000', 1, 'NA', '2022-04-20 00:00:00.000000', 0, 0, 0),
(41, '2022-05-20 00:00:00.000000', 'Yasir Adnan', 'Badr Uddin Ishaque', 'M', 'M', '1981-02-04 00:00:00.000000', '2022-05-09 00:00:00.000000', '2022-05-09 00:00:00.000000', 1, 1, 'A 1/409, Madina Blessings, Gulshan-e-Iqbal, Block 10-A, Karachi.', 'A 1/409, Madina Blessings, Gulshan-e-Iqb', 'N/A', 'N/A', 'N/A', 'N/A', '03333035005', '42501-3097996-5', '2016-07-29', '2029-07-12', 60, 'N/A', 'yasir.adnan@roche.com', 'N', 1, 89, 17, 17, 38, 10, 34, 0, 1507, 1, 29, 1, 'N', 1, 1, 'PK83SCBL0000001303690101', 7, 100, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'Y', 'N', 'N', 'N', 'N', 'N', 'Performance', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '0', 'N/A', 'Payroll Done', 'N', 'N', 'C', 'N', 'N', 'N', '\0\0', '1677', '2022-05-09', '2022-05-09', 'N/A', 3, 1, 0, 'N/A', 'Pakistani', 'Y', 1543, '2022-05-20 09:25:12.123000', 1543, '2022-05-20 09:25:12.123000', 1, 'NA', '2022-05-20 00:00:00.000000', 0, 0, 0),
(42, '2023-06-22 00:00:00.000000', 'testa', 'testb', 'M', 'S', '2023-06-22 00:00:00.000000', '2023-06-22 00:00:00.000000', '2023-06-22 00:00:00.000000', 3, 1, 'asasas', 'asas', '777', '777', '777', '777', '777', '42101-8646544-9', '2023-06-22', '2023-06-22', 60, '6667', 's@s.com', 'N', 1, 57, 16, 16, 10, 9, 1, 0, 737, 1, 1, 1, 'N', 1, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'NotApplicable', 'jjj', 'jjj', 'jjj', 'jjjj', '8878', '8878', 'b+', '0', '0', '7767', 'Salary Done', 'N', 'N', 'N', 'N', 'N', 'N', '\0', 'testsa', '2023-06-22', '2023-06-22', 'kkk', 3, 3, 0, 'asvjhasvh', 'p', 'N', 1543, '2023-06-22 18:26:24.520000', 1543, '2023-06-22 18:26:24.520000', 1, '2222', '2023-06-22 18:26:24.000000', 0, 0, 0),
(43, '0000-00-00 00:00:00.000000', 'aqib', 'rehman', '1', 'm', '2001-05-10 00:00:00.000000', '0000-00-00 00:00:00.000000', '0000-00-00 00:00:00.000000', 1, 1, 'Karachi,Pakistan', 'Karachi,Pakistan', '12345', '67890', '11111', '2222', '032123232', '42101-23332-1', '2023-05-20', '2028-05-12', 55, '00', 'aqibrehman13@gmail.com', '', 0, 2, 1, 988, 0, 889, 222, 0, 76, 3434, 2121221, 1, NULL, 0, 0, '1', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'N', 'N', 'N', 'N', 'N', 'N', NULL, '', '', '', '', NULL, NULL, 'posi', '0', '0', '0', NULL, 'N', 'N', NULL, NULL, NULL, NULL, '/resources/static/assets/uploads/appointments/userProfileIco.webp', '1', '2023-02-23', '2023-08-20', 'Aqib Rehman', 12, 6, 45, 'house no 6/6 sector 12-D Fb area ', 'Pakistani', NULL, NULL, NULL, NULL, NULL, 12, '0', '2023-12-09 00:00:00.000000', 0, 1, 0),
(44, '0000-00-00 00:00:00.000000', 'aqib', 'rehman', '1', 'm', '2001-05-10 00:00:00.000000', '0000-00-00 00:00:00.000000', '0000-00-00 00:00:00.000000', 1, 1, 'Karachi,Pakistan', 'Karachi,Pakistan', '12345', '67890', '11111', '2222', '032123232', '42101-23332-1', '2023-05-20', '2028-05-12', 55, '00', 'aqibrehman13@gmail.com', '', 0, 2, 1, 988, 0, 889, 222, 0, 76, 3434, 2121221, 1, NULL, 0, 0, '1', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'N', 'N', 'N', 'N', 'N', 'N', NULL, '', '', '', '', NULL, NULL, 'posi', '0', '0', '0', NULL, 'N', 'N', NULL, NULL, NULL, NULL, '/resources/static/assets/uploads/appointments/login.png', '1', '2023-02-23', '2023-08-20', 'Aqib Rehman', 12, 6, 45, 'house no 6/6 sector 12-D Fb area ', 'Pakistani', NULL, NULL, NULL, NULL, NULL, 12, '0', '2023-12-09 00:00:00.000000', 0, 3, 0),
(45, '2023-07-04 15:48:04', 'aqib', 'rehman', '1', 'm', '2001-05-10 00:00:00', '2023-07-04 15:48:04', '', 1, 1, 'Karachi,Pakistan', 'Karachi,Pakistan', '12345', '67890', '11111', '2222', '032123232', '42101-23332-1', '2023-05-20', '2028-05-12', 55, '00', 'aqibrehman13@gmail.com', '', 0, 2, 1, 988, 0, 889, 222, 0, 76, 3434, 2121221, 1, NULL, 0, 0, '1', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'N', 'N', 'N', 'N', 'N', 'N', NULL, '', '', '', '', NULL, NULL, 'posi', '0', '0', '0', 'Salary Done', 'N', 'N', NULL, NULL, NULL, NULL, '/resources/static/assets/uploads/appointments/paypal.webp', '1', '2023-02-23 00:00:00', '2023-08-20 00:00:00', 'Aqib Rehman', 12, 6, 45, 'house no 6/6 sector 12-D Fb area ', 'Pakistani', NULL, NULL, NULL, NULL, NULL, 12, '0', '2023-12-09 00:00:00', 0, 3, 0),
(46, '2023-07-06 09:57:38', 'aqib', 'rehman', '1', 'm', '2001-05-10 00:00:00', '2023-07-06 09:57:38', '', 1, 1, 'Karachi,Pakistan', 'Karachi,Pakistan', '12345', '67890', '11111', '2222', '032123232', '42101-23332-1', '2023-05-20', '2028-05-12', 55, '00', 'aqibrehman13@gmail.com', '', 0, 2, 1, 988, 0, 889, 222, 0, 76, 3434, 2121221, 1, NULL, 0, 0, '1', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'N', 'N', 'N', 'N', 'N', 'N', NULL, '', '', '', '', NULL, NULL, 'posi', '0', '0', '0', NULL, 'N', 'N', NULL, NULL, NULL, NULL, '/resources/static/assets/uploads/appointments/userIco.png', '1', '2023-02-23 00:00:00', '2023-08-20 00:00:00', 'Aqib Rehman', 12, 6, 45, 'house no 6/6 sector 12-D Fb area ', 'Pakistani', NULL, NULL, NULL, NULL, NULL, 12, '0', '2023-12-09 00:00:00', 0, 1, 0),
(47, '2023-07-06 09:58:25', 'hamzu', 'rehman', '1', 'm', '2001-05-10 00:00:00', '2023-07-06 09:58:25', '', 1, 1, 'Karachi,Pakistan', 'Karachi,Pakistan', '12345', '67890', '11111', '2222', '032123232', '42101-23332-1', '2023-05-20', '2028-05-12', 55, '00', 'aqibrehman13@gmail.com', '', 0, 2, 1, 988, 0, 889, 222, 0, 76, 3434, 2121221, 1, NULL, 0, 0, '1', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, '0', 0, 0, 0, 'N', 'N', 'N', 'N', 'N', 'N', 'N', NULL, '', '', '', '', NULL, NULL, 'posi', '0', '0', '0', NULL, 'N', 'N', NULL, NULL, NULL, NULL, '/resources/static/assets/uploads/appointments/wordIco.webp', '1', '2023-02-23 00:00:00', '2023-08-20 00:00:00', 'Aqib Rehman', 12, 6, 45, 'house no 6/6 sector 12-D Fb area ', 'Pakistani', NULL, NULL, NULL, NULL, NULL, 12, '0', '2023-12-09 00:00:00', 0, 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `tran_appointment_dependents`
--

CREATE TABLE `tran_appointment_dependents` (
  `Sequence_no` int(11) NOT NULL,
  `S_no` int(11) NOT NULL,
  `Dependent_type` varchar(1) NOT NULL,
  `Dependent_name` varchar(30) NOT NULL,
  `Dependent_DOB` datetime(6) DEFAULT NULL,
  `company_code` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tran_appointment_earnings`
--

CREATE TABLE `tran_appointment_earnings` (
  `Sequence_no` int(11) NOT NULL,
  `Transaction_Date` text NOT NULL,
  `Allowance_code` int(11) NOT NULL,
  `Increment_Date` text NOT NULL,
  `Amount` int(11) NOT NULL,
  `Posting_date` date DEFAULT NULL,
  `Posted_by` int(11) NOT NULL,
  `company_code` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tran_appointment_earnings`
--

INSERT INTO `tran_appointment_earnings` (`Sequence_no`, `Transaction_Date`, `Allowance_code`, `Increment_Date`, `Amount`, `Posting_date`, `Posted_by`, `company_code`) VALUES
(1, '2020-06-19 00:00:00.000000', 1, '2020-06-01 00:00:00.000000', 30000, '2020-06-19', 1543, 0),
(1, '2020-06-19 00:00:00.000000', 4, '2020-06-01 00:00:00.000000', 20000, '2020-06-19', 1543, 0),
(2, '2020-06-19 00:00:00.000000', 1, '2020-05-01 00:00:00.000000', 80000, '2020-06-19', 1543, 0),
(2, '2020-06-19 00:00:00.000000', 4, '2020-05-01 00:00:00.000000', 25000, '2020-06-19', 1543, 0),
(3, '2020-06-19 00:00:00.000000', 1, '2020-01-01 00:00:00.000000', 125000, '2020-06-19', 1543, 0),
(3, '2020-06-19 00:00:00.000000', 4, '2020-01-01 00:00:00.000000', 15000, '2020-06-19', 1543, 0),
(4, '2020-06-30 00:00:00.000000', 1, '2020-06-01 00:00:00.000000', 250000, '2020-06-30', 1543, 0),
(4, '2020-06-30 00:00:00.000000', 4, '2020-06-01 00:00:00.000000', 24600, '2020-06-30', 1543, 0),
(5, '2020-06-30 00:00:00.000000', 1, '2020-06-08 00:00:00.000000', 49500, '2020-06-30', 1543, 0),
(5, '2020-06-30 00:00:00.000000', 4, '2020-06-08 00:00:00.000000', 15500, '2020-06-30', 1543, 0),
(5, '2020-06-30 00:00:00.000000', 19, '2020-06-08 00:00:00.000000', 0, '2020-06-30', 1543, 0),
(6, '2020-08-21 00:00:00.000000', 1, '2020-08-17 00:00:00.000000', 100000, '2020-08-21', 1543, 0),
(6, '2020-08-21 00:00:00.000000', 4, '2020-08-17 00:00:00.000000', 13150, '2020-08-21', 1543, 0),
(6, '2020-08-21 00:00:00.000000', 19, '2020-08-17 00:00:00.000000', 5000, '2020-08-21', 1543, 0),
(7, '2020-11-19 00:00:00.000000', 1, '2020-11-16 00:00:00.000000', 85000, '2020-11-19', 1543, 0),
(7, '2020-11-19 00:00:00.000000', 4, '2020-11-16 00:00:00.000000', 8200, '2020-11-19', 1543, 0),
(7, '2020-11-19 00:00:00.000000', 19, '2020-11-16 00:00:00.000000', 5000, '2020-11-19', 1543, 0),
(8, '2020-12-21 00:00:00.000000', 1, '2020-11-30 00:00:00.000000', 40000, '2020-12-21', 1543, 0),
(8, '2020-12-21 00:00:00.000000', 4, '2020-11-30 00:00:00.000000', 10000, '2020-12-21', 1543, 0),
(8, '2020-12-21 00:00:00.000000', 19, '2020-11-30 00:00:00.000000', 0, '2020-12-21', 1543, 0),
(9, '2020-12-21 00:00:00.000000', 1, '2020-11-30 00:00:00.000000', 50000, '2020-12-21', 1543, 0),
(9, '2020-12-21 00:00:00.000000', 4, '2020-11-30 00:00:00.000000', 10000, '2020-12-21', 1543, 0),
(9, '2020-12-21 00:00:00.000000', 19, '2020-11-30 00:00:00.000000', 0, '2020-12-21', 1543, 0),
(10, '2020-12-21 00:00:00.000000', 1, '2020-12-14 00:00:00.000000', 48500, '2020-12-21', 1543, 0),
(10, '2020-12-21 00:00:00.000000', 4, '2020-12-14 00:00:00.000000', 10000, '2020-12-21', 1543, 0),
(10, '2020-12-21 00:00:00.000000', 19, '2020-12-14 00:00:00.000000', 0, '2020-12-21', 1543, 0),
(11, '2021-01-22 00:00:00.000000', 1, '2020-12-30 00:00:00.000000', 43000, '2021-01-22', 1543, 0),
(11, '2021-01-22 00:00:00.000000', 4, '2020-12-30 00:00:00.000000', 8200, '2021-01-22', 1543, 0),
(11, '2021-01-22 00:00:00.000000', 19, '2020-12-30 00:00:00.000000', 0, '2021-01-22', 1543, 0),
(12, '2021-01-22 00:00:00.000000', 1, '2021-01-01 00:00:00.000000', 150000, '2021-01-22', 1543, 0),
(12, '2021-01-22 00:00:00.000000', 4, '2021-01-01 00:00:00.000000', 13150, '2021-01-22', 1543, 0),
(12, '2021-01-22 00:00:00.000000', 19, '2021-01-01 00:00:00.000000', 5000, '2021-01-22', 1543, 0),
(13, '2021-03-19 00:00:00.000000', 1, '2021-03-01 00:00:00.000000', 78000, '2021-03-19', 1543, 0),
(13, '2021-03-19 00:00:00.000000', 4, '2021-03-01 00:00:00.000000', 10000, '2021-03-19', 1543, 0),
(13, '2021-03-19 00:00:00.000000', 19, '2021-03-01 00:00:00.000000', 0, '2021-03-19', 1543, 0),
(14, '2021-04-20 00:00:00.000000', 1, '2021-04-01 00:00:00.000000', 66400, '2021-04-20', 1543, 0),
(14, '2021-04-20 00:00:00.000000', 4, '2021-04-01 00:00:00.000000', 4316, '2021-04-20', 1543, 0),
(14, '2021-04-20 00:00:00.000000', 19, '2021-04-01 00:00:00.000000', 1000, '2021-04-20', 1543, 0),
(15, '2021-04-20 00:00:00.000000', 1, '2021-04-12 00:00:00.000000', 45000, '2021-04-20', 1543, 0),
(15, '2021-04-20 00:00:00.000000', 4, '2021-04-12 00:00:00.000000', 16400, '2021-04-20', 1543, 0),
(15, '2021-04-20 00:00:00.000000', 19, '2021-04-12 00:00:00.000000', 0, '2021-04-20', 1543, 0),
(16, '2021-05-20 00:00:00.000000', 1, '2021-04-19 00:00:00.000000', 46200, '2021-05-20', 1543, 0),
(16, '2021-05-20 00:00:00.000000', 4, '2021-04-19 00:00:00.000000', 16400, '2021-05-20', 1543, 0),
(16, '2021-05-20 00:00:00.000000', 19, '2021-04-19 00:00:00.000000', 0, '2021-05-20', 1543, 0),
(17, '2021-06-21 00:00:00.000000', 1, '2021-06-07 00:00:00.000000', 203500, '2021-06-21', 1543, 0),
(17, '2021-06-21 00:00:00.000000', 4, '2021-06-07 00:00:00.000000', 23300, '2021-06-21', 1543, 0),
(17, '2021-06-21 00:00:00.000000', 19, '2021-06-07 00:00:00.000000', 1500, '2021-06-21', 1543, 0),
(18, '2021-07-19 00:00:00.000000', 1, '2021-07-05 00:00:00.000000', 251700, '2021-07-19', 1543, 0),
(18, '2021-07-19 00:00:00.000000', 4, '2021-07-05 00:00:00.000000', 32400, '2021-07-19', 1543, 0),
(18, '2021-07-19 00:00:00.000000', 19, '2021-07-05 00:00:00.000000', 3000, '2021-07-19', 1543, 0),
(19, '2021-07-19 00:00:00.000000', 1, '2021-07-01 00:00:00.000000', 81187, '2021-07-19', 1543, 0),
(19, '2021-07-19 00:00:00.000000', 4, '2021-07-01 00:00:00.000000', 16400, '2021-07-19', 1543, 0),
(19, '2021-07-19 00:00:00.000000', 19, '2021-07-01 00:00:00.000000', 2500, '2021-07-19', 1543, 0),
(20, '2021-07-20 00:00:00.000000', 1, '2021-07-01 00:00:00.000000', 74337, '2021-07-20', 1543, 0),
(20, '2021-07-20 00:00:00.000000', 4, '2021-07-01 00:00:00.000000', 16400, '2021-07-20', 1543, 0),
(20, '2021-07-20 00:00:00.000000', 19, '2021-07-01 00:00:00.000000', 2500, '2021-07-20', 1543, 0),
(21, '2021-07-20 00:00:00.000000', 1, '2021-07-01 00:00:00.000000', 77473, '2021-07-20', 1543, 0),
(21, '2021-07-20 00:00:00.000000', 4, '2021-07-01 00:00:00.000000', 16400, '2021-07-20', 1543, 0),
(21, '2021-07-20 00:00:00.000000', 19, '2021-07-01 00:00:00.000000', 2500, '2021-07-20', 1543, 0),
(22, '2021-09-21 00:00:00.000000', 1, '2021-09-01 00:00:00.000000', 65000, '2021-09-21', 1543, 0),
(22, '2021-09-21 00:00:00.000000', 4, '2021-09-01 00:00:00.000000', 16400, '2021-09-21', 1543, 0),
(22, '2021-09-21 00:00:00.000000', 19, '2021-09-01 00:00:00.000000', 1000, '2021-09-21', 1543, 0),
(23, '2021-09-21 00:00:00.000000', 1, '2021-09-01 00:00:00.000000', 65000, '2021-09-21', 1543, 0),
(23, '2021-09-21 00:00:00.000000', 4, '2021-09-01 00:00:00.000000', 16400, '2021-09-21', 1543, 0),
(23, '2021-09-21 00:00:00.000000', 19, '2021-09-01 00:00:00.000000', 1000, '2021-09-21', 1543, 0),
(24, '2021-09-21 00:00:00.000000', 1, '2021-09-01 00:00:00.000000', 75000, '2021-09-21', 1543, 0),
(24, '2021-09-21 00:00:00.000000', 4, '2021-09-01 00:00:00.000000', 16400, '2021-09-21', 1543, 0),
(24, '2021-09-21 00:00:00.000000', 19, '2021-09-01 00:00:00.000000', 1000, '2021-09-21', 1543, 0),
(25, '2021-09-21 00:00:00.000000', 1, '2021-09-01 00:00:00.000000', 70000, '2021-09-21', 1543, 0),
(25, '2021-09-21 00:00:00.000000', 4, '2021-09-01 00:00:00.000000', 16400, '2021-09-21', 1543, 0),
(25, '2021-09-21 00:00:00.000000', 19, '2021-09-01 00:00:00.000000', 1000, '2021-09-21', 1543, 0),
(26, '2021-09-21 00:00:00.000000', 1, '2021-08-25 00:00:00.000000', 240000, '2021-09-21', 1543, 0),
(26, '2021-09-21 00:00:00.000000', 4, '2021-08-25 00:00:00.000000', 25000, '2021-09-21', 1543, 0),
(26, '2021-09-21 00:00:00.000000', 19, '2021-08-25 00:00:00.000000', 2500, '2021-09-21', 1543, 0),
(27, '2021-09-21 00:00:00.000000', 1, '2021-09-01 00:00:00.000000', 1658333, '2021-09-21', 1543, 0),
(27, '2021-09-21 00:00:00.000000', 4, '2021-09-01 00:00:00.000000', 0, '2021-09-21', 1543, 0),
(27, '2021-09-21 00:00:00.000000', 19, '2021-09-01 00:00:00.000000', 0, '2021-09-21', 1543, 0),
(28, '2021-12-20 00:00:00.000000', 1, '2021-11-15 00:00:00.000000', 85000, '2021-12-20', 1543, 0),
(28, '2021-12-20 00:00:00.000000', 4, '2021-11-15 00:00:00.000000', 16400, '2021-12-20', 1543, 0),
(28, '2021-12-20 00:00:00.000000', 19, '2021-11-15 00:00:00.000000', 1000, '2021-12-20', 1543, 0),
(29, '2021-12-20 00:00:00.000000', 1, '2021-12-13 00:00:00.000000', 84775, '2021-12-20', 1543, 0),
(29, '2021-12-20 00:00:00.000000', 4, '2021-12-13 00:00:00.000000', 16400, '2021-12-20', 1543, 0),
(29, '2021-12-20 00:00:00.000000', 19, '2021-12-13 00:00:00.000000', 1000, '2021-12-20', 1543, 0),
(30, '2021-12-20 00:00:00.000000', 1, '2021-12-13 00:00:00.000000', 62000, '2021-12-20', 1543, 0),
(30, '2021-12-20 00:00:00.000000', 4, '2021-12-13 00:00:00.000000', 8000, '2021-12-20', 1543, 0),
(30, '2021-12-20 00:00:00.000000', 19, '2021-12-13 00:00:00.000000', 1000, '2021-12-20', 1543, 0),
(31, '2022-01-19 00:00:00.000000', 1, '2021-12-20 00:00:00.000000', 85000, '2022-01-19', 1543, 0),
(31, '2022-01-19 00:00:00.000000', 4, '2021-12-20 00:00:00.000000', 16400, '2022-01-19', 1543, 0),
(31, '2022-01-19 00:00:00.000000', 19, '2021-12-20 00:00:00.000000', 0, '2022-01-19', 1543, 0),
(32, '2022-01-19 00:00:00.000000', 1, '2021-12-27 00:00:00.000000', 95000, '2022-01-19', 1543, 0),
(32, '2022-01-19 00:00:00.000000', 4, '2021-12-27 00:00:00.000000', 16400, '2022-01-19', 1543, 0),
(32, '2022-01-19 00:00:00.000000', 19, '2021-12-27 00:00:00.000000', 0, '2022-01-19', 1543, 0),
(33, '2022-01-19 00:00:00.000000', 1, '2021-12-31 00:00:00.000000', 95000, '2022-01-19', 1543, 0),
(33, '2022-01-19 00:00:00.000000', 4, '2021-12-31 00:00:00.000000', 16400, '2022-01-19', 1543, 0),
(33, '2022-01-19 00:00:00.000000', 19, '2021-12-31 00:00:00.000000', 0, '2022-01-19', 1543, 0),
(34, '2022-01-19 00:00:00.000000', 1, '2022-01-04 00:00:00.000000', 100000, '2022-01-19', 1543, 0),
(34, '2022-01-19 00:00:00.000000', 4, '2022-01-04 00:00:00.000000', 25000, '2022-01-19', 1543, 0),
(34, '2022-01-19 00:00:00.000000', 19, '2022-01-04 00:00:00.000000', 5000, '2022-01-19', 1543, 0),
(35, '2022-02-21 00:00:00.000000', 1, '2022-01-19 00:00:00.000000', 205000, '2022-02-21', 1543, 0),
(35, '2022-02-21 00:00:00.000000', 4, '2022-01-19 00:00:00.000000', 25000, '2022-02-21', 1543, 0),
(35, '2022-02-21 00:00:00.000000', 19, '2022-01-19 00:00:00.000000', 5000, '2022-02-21', 1543, 0),
(36, '2022-02-21 00:00:00.000000', 1, '2022-01-24 00:00:00.000000', 85000, '2022-02-21', 1543, 0),
(36, '2022-02-21 00:00:00.000000', 4, '2022-01-24 00:00:00.000000', 16400, '2022-02-21', 1543, 0),
(36, '2022-02-21 00:00:00.000000', 19, '2022-01-24 00:00:00.000000', 0, '2022-02-21', 1543, 0),
(37, '2022-03-21 00:00:00.000000', 1, '2022-03-04 00:00:00.000000', 115000, '2022-03-21', 1543, 0),
(37, '2022-03-21 00:00:00.000000', 4, '2022-03-04 00:00:00.000000', 25000, '2022-03-21', 1543, 0),
(37, '2022-03-21 00:00:00.000000', 19, '2022-03-04 00:00:00.000000', 5000, '2022-03-21', 1543, 0),
(38, '2022-03-21 00:00:00.000000', 1, '2022-03-14 00:00:00.000000', 85000, '2022-03-21', 1543, 0),
(38, '2022-03-21 00:00:00.000000', 4, '2022-03-14 00:00:00.000000', 16400, '2022-03-21', 1543, 0),
(38, '2022-03-21 00:00:00.000000', 19, '2022-03-14 00:00:00.000000', 0, '2022-03-21', 1543, 0),
(39, '2022-04-20 00:00:00.000000', 1, '2022-04-13 00:00:00.000000', 435000, '2022-04-20', 1543, 0),
(39, '2022-04-20 00:00:00.000000', 4, '2022-04-13 00:00:00.000000', 32400, '2022-04-20', 1543, 0),
(39, '2022-04-20 00:00:00.000000', 19, '2022-04-13 00:00:00.000000', 0, '2022-04-20', 1543, 0),
(40, '2022-04-20 00:00:00.000000', 1, '2022-04-14 00:00:00.000000', 80000, '2022-04-20', 1543, 0),
(40, '2022-04-20 00:00:00.000000', 4, '2022-04-14 00:00:00.000000', 25000, '2022-04-20', 1543, 0),
(40, '2022-04-20 00:00:00.000000', 19, '2022-04-14 00:00:00.000000', 2500, '2022-04-20', 1543, 0),
(41, '2022-05-20 00:00:00.000000', 1, '2022-05-09 00:00:00.000000', 548000, '2022-05-20', 1543, 0),
(41, '2022-05-20 00:00:00.000000', 4, '2022-05-09 00:00:00.000000', 41500, '2022-05-20', 1543, 0),
(41, '2022-05-20 00:00:00.000000', 19, '2022-05-09 00:00:00.000000', 0, '2022-05-20', 1543, 0),
(42, '2023-06-22 00:00:00.000000', 1, '2023-06-22 00:00:00.000000', 2000, '2023-06-22', 1543, 0),
(42, '2023-06-22 00:00:00.000000', 4, '2023-06-22 00:00:00.000000', 2000, '2023-06-22', 1543, 0),
(42, '2023-06-22 00:00:00.000000', 19, '2023-06-22 00:00:00.000000', 2000, '2023-06-22', 1543, 0),
(45, '2023-07-05T10:55:14.661Z', 1, '2023-07-05T10:55:14.661Z', 34, '2023-07-05', 0, 1),
(45, '2023-07-05T10:55:14.665Z', 4, '2023-07-05T10:55:14.665Z', 45, '2023-07-05', 0, 1);

-- --------------------------------------------------------

--
-- Table structure for table `tran_appointment_families`
--

CREATE TABLE `tran_appointment_families` (
  `Sequence_no` int(11) DEFAULT NULL,
  `S_no` int(11) DEFAULT NULL,
  `Fam_Member_Type` varchar(1) DEFAULT NULL,
  `Fam_Member_Name` varchar(60) DEFAULT NULL,
  `Fam_Member_DOB` text DEFAULT NULL,
  `CNIC_No` varchar(16) DEFAULT NULL,
  `company_code` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tran_appointment_families`
--

INSERT INTO `tran_appointment_families` (`Sequence_no`, `S_no`, `Fam_Member_Type`, `Fam_Member_Name`, `Fam_Member_DOB`, `CNIC_No`, `company_code`) VALUES
(45, 1, 'D', 'hamzua', '2023-05-05', '312321312312312', 2);

-- --------------------------------------------------------

--
-- Table structure for table `tran_appointment_marriages`
--

CREATE TABLE `tran_appointment_marriages` (
  `Sequence_no` int(11) NOT NULL,
  `Transaction_Date` text NOT NULL,
  `Marriage_Date` text NOT NULL,
  `Spause_name` varchar(30) NOT NULL,
  `Spause_DOB` text NOT NULL,
  `Posting_date` text DEFAULT NULL,
  `Posted_by` int(11) NOT NULL,
  `company_code` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tran_appointment_marriages`
--

INSERT INTO `tran_appointment_marriages` (`Sequence_no`, `Transaction_Date`, `Marriage_Date`, `Spause_name`, `Spause_DOB`, `Posting_date`, `Posted_by`, `company_code`) VALUES
(45, '2023-07-06T09:20:04.596Z', '2023-05-05', 'asdsaa', '2023-06-06', '2023-07-06T09:20:04.596Z', 0, 1);

-- --------------------------------------------------------

--
-- Table structure for table `tran_appointment_references`
--

CREATE TABLE `tran_appointment_references` (
  `Sequence_no` int(11) NOT NULL,
  `S_no` int(11) NOT NULL,
  `ReferencePerson_name` varchar(100) NOT NULL,
  `ReferencePerson_company` varchar(100) NOT NULL,
  `ReferencePerson_Designation` varchar(50) NOT NULL,
  `ReferencePerson_ContactNbr` varchar(50) NOT NULL,
  `ReferencePerson_Address` varchar(500) DEFAULT NULL,
  `company_code` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tran_educations`
--

CREATE TABLE `tran_educations` (
  `Sr_No` int(11) NOT NULL,
  `Emp_Code` int(11) DEFAULT NULL,
  `Edu_Code` int(11) DEFAULT NULL,
  `Edu_Year` int(11) DEFAULT NULL,
  `Edu_Grade` varchar(50) DEFAULT NULL,
  `Top_flag` char(1) DEFAULT NULL,
  `institute_code` int(11) DEFAULT NULL,
  `Major_OtherSubjects` varchar(50) DEFAULT NULL,
  `postedby` int(11) DEFAULT NULL,
  `posteddate` text DEFAULT NULL,
  `postedflag` varchar(1) DEFAULT NULL,
  `Initiatedby` int(11) DEFAULT NULL,
  `Initiatedon` text DEFAULT NULL,
  `StatusCode` int(11) DEFAULT NULL,
  `PendingWith` int(11) DEFAULT NULL,
  `StepNo` int(11) DEFAULT NULL,
  `Posting_date` date DEFAULT NULL,
  `FileName` varchar(30) DEFAULT NULL,
  `StepbackReason` varchar(150) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tran_educations`
--

INSERT INTO `tran_educations` (`Sr_No`, `Emp_Code`, `Edu_Code`, `Edu_Year`, `Edu_Grade`, `Top_flag`, `institute_code`, `Major_OtherSubjects`, `postedby`, `posteddate`, `postedflag`, `Initiatedby`, `Initiatedon`, `StatusCode`, `PendingWith`, `StepNo`, `Posting_date`, `FileName`, `StepbackReason`) VALUES
(1, 2, 0, 2020, '12', '9', 223, NULL, 0, '2023-07-04T12:27:17.375Z', NULL, 0, '2023-07-04T12:27:17.375Z', NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `tran_experiences`
--

CREATE TABLE `tran_experiences` (
  `ID` int(11) NOT NULL,
  `Emp_Code` int(11) DEFAULT NULL,
  `Employer_Code` int(11) DEFAULT NULL,
  `Designation` varchar(100) DEFAULT NULL,
  `Department` varchar(100) DEFAULT NULL,
  `StartDate` text DEFAULT NULL,
  `EndDate` text DEFAULT NULL,
  `Remarks` varchar(1000) DEFAULT NULL,
  `Submit_Flag` char(1) DEFAULT NULL,
  `Submit_By` int(11) DEFAULT NULL,
  `Submit_On` text DEFAULT NULL,
  `Approve_Flag` char(1) DEFAULT NULL,
  `Approve_By` int(11) DEFAULT NULL,
  `Approve_On` text DEFAULT NULL,
  `Created_by` int(11) DEFAULT NULL,
  `Created_on` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tran_experiences`
--

INSERT INTO `tran_experiences` (`ID`, `Emp_Code`, `Employer_Code`, `Designation`, `Department`, `StartDate`, `EndDate`, `Remarks`, `Submit_Flag`, `Submit_By`, `Submit_On`, `Approve_Flag`, `Approve_By`, `Approve_On`, `Created_by`, `Created_on`) VALUES
(1, 2, 2, 'dadasd', 'dssadsad', '2023/04/04', '2023/05/05', NULL, 'y', 0, '2023-07-04T14:08:33.486Z', NULL, 0, '2023-07-04T14:08:33.486Z', 0, '2023-07-04T14:08:33.486Z');

-- --------------------------------------------------------

--
-- Table structure for table `tran_hiring_checklist`
--

CREATE TABLE `tran_hiring_checklist` (
  `SeqNo` int(11) DEFAULT NULL,
  `List_No` int(11) DEFAULT NULL,
  `userCode` int(11) NOT NULL,
  `company_code` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tran_hiring_checklist`
--

INSERT INTO `tran_hiring_checklist` (`SeqNo`, `List_No`, `userCode`, `company_code`) VALUES
(45, 1, 0, 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `companies`
--
ALTER TABLE `companies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `dirmenus`
--
ALTER TABLE `dirmenus`
  ADD PRIMARY KEY (`MenuCode`);

--
-- Indexes for table `dir_allowances`
--
ALTER TABLE `dir_allowances`
  ADD PRIMARY KEY (`Allowance_code`);

--
-- Indexes for table `dir_banks`
--
ALTER TABLE `dir_banks`
  ADD PRIMARY KEY (`Bank_code`);

--
-- Indexes for table `dir_bank_branches`
--
ALTER TABLE `dir_bank_branches`
  ADD PRIMARY KEY (`Branch_code`);

--
-- Indexes for table `dir_busineess`
--
ALTER TABLE `dir_busineess`
  ADD PRIMARY KEY (`Business_Code`);

--
-- Indexes for table `dir_busineess_sectors`
--
ALTER TABLE `dir_busineess_sectors`
  ADD PRIMARY KEY (`Business_Sector_Code`);

--
-- Indexes for table `dir_car_capacities`
--
ALTER TABLE `dir_car_capacities`
  ADD PRIMARY KEY (`Capacity_code`);

--
-- Indexes for table `dir_cities`
--
ALTER TABLE `dir_cities`
  ADD PRIMARY KEY (`City_code`);

--
-- Indexes for table `dir_companies`
--
ALTER TABLE `dir_companies`
  ADD PRIMARY KEY (`Company_Code`);

--
-- Indexes for table `dir_corecompetencies`
--
ALTER TABLE `dir_corecompetencies`
  ADD PRIMARY KEY (`Competency_code`);

--
-- Indexes for table `dir_corecompetencies_old`
--
ALTER TABLE `dir_corecompetencies_old`
  ADD PRIMARY KEY (`Core_Code`);

--
-- Indexes for table `dir_cost_centres`
--
ALTER TABLE `dir_cost_centres`
  ADD PRIMARY KEY (`Cost_Centre_code`);

--
-- Indexes for table `dir_countries`
--
ALTER TABLE `dir_countries`
  ADD PRIMARY KEY (`Country_Code`);

--
-- Indexes for table `dir_courses`
--
ALTER TABLE `dir_courses`
  ADD PRIMARY KEY (`Course_code`);

--
-- Indexes for table `dir_course_categaries`
--
ALTER TABLE `dir_course_categaries`
  ADD PRIMARY KEY (`Course_Catg_code`);

--
-- Indexes for table `dir_deductions`
--
ALTER TABLE `dir_deductions`
  ADD PRIMARY KEY (`Deduction_code`);

--
-- Indexes for table `dir_departments`
--
ALTER TABLE `dir_departments`
  ADD PRIMARY KEY (`Dept_code`);

--
-- Indexes for table `dir_designations`
--
ALTER TABLE `dir_designations`
  ADD PRIMARY KEY (`Desig_code`);

--
-- Indexes for table `dir_divisions`
--
ALTER TABLE `dir_divisions`
  ADD PRIMARY KEY (`Div_code`);

--
-- Indexes for table `dir_division_categories`
--
ALTER TABLE `dir_division_categories`
  ADD PRIMARY KEY (`Division_category_Code`);

--
-- Indexes for table `dir_educations`
--
ALTER TABLE `dir_educations`
  ADD PRIMARY KEY (`Edu_code`);

--
-- Indexes for table `dir_education_levels`
--
ALTER TABLE `dir_education_levels`
  ADD PRIMARY KEY (`Edu_level_code`);

--
-- Indexes for table `dir_employee_categories`
--
ALTER TABLE `dir_employee_categories`
  ADD PRIMARY KEY (`Emp_Category_code`);

--
-- Indexes for table `dir_employment_types`
--
ALTER TABLE `dir_employment_types`
  ADD PRIMARY KEY (`Empt_Type_code`);

--
-- Indexes for table `dir_eobi_cities`
--
ALTER TABLE `dir_eobi_cities`
  ADD PRIMARY KEY (`EOBI_City_code`);

--
-- Indexes for table `dir_ess_request_type`
--
ALTER TABLE `dir_ess_request_type`
  ADD PRIMARY KEY (`Request_Code`);

--
-- Indexes for table `dir_grades`
--
ALTER TABLE `dir_grades`
  ADD PRIMARY KEY (`Grade_code`),
  ADD UNIQUE KEY `UQ_Grade_name` (`Grade_name`);

--
-- Indexes for table `dir_hiring_checklist`
--
ALTER TABLE `dir_hiring_checklist`
  ADD PRIMARY KEY (`List_no`);

--
-- Indexes for table `dir_hr_letter_types`
--
ALTER TABLE `dir_hr_letter_types`
  ADD PRIMARY KEY (`Letter_type_code`);

--
-- Indexes for table `dir_institutions`
--
ALTER TABLE `dir_institutions`
  ADD PRIMARY KEY (`Inst_code`);

--
-- Indexes for table `dir_jobprofiles`
--
ALTER TABLE `dir_jobprofiles`
  ADD PRIMARY KEY (`JobCode`);

--
-- Indexes for table `dir_leave_categories`
--
ALTER TABLE `dir_leave_categories`
  ADD PRIMARY KEY (`Leave_Category_code`);

--
-- Indexes for table `dir_leave_types`
--
ALTER TABLE `dir_leave_types`
  ADD PRIMARY KEY (`Leave_type_code`);

--
-- Indexes for table `dir_letter_types`
--
ALTER TABLE `dir_letter_types`
  ADD PRIMARY KEY (`Letter_Type_code`);

--
-- Indexes for table `dir_locations`
--
ALTER TABLE `dir_locations`
  ADD PRIMARY KEY (`Loc_code`);

--
-- Indexes for table `dir_meal_structures`
--
ALTER TABLE `dir_meal_structures`
  ADD PRIMARY KEY (`Structure_Code`);

--
-- Indexes for table `dir_mode_of_payments`
--
ALTER TABLE `dir_mode_of_payments`
  ADD PRIMARY KEY (`Payment_code`);

--
-- Indexes for table `dir_payroll_categories`
--
ALTER TABLE `dir_payroll_categories`
  ADD PRIMARY KEY (`Payroll_Category_code`);

--
-- Indexes for table `dir_pay_grade_areas`
--
ALTER TABLE `dir_pay_grade_areas`
  ADD PRIMARY KEY (`Pay_Grade_Area_Code`);

--
-- Indexes for table `dir_positions`
--
ALTER TABLE `dir_positions`
  ADD PRIMARY KEY (`Position_Code`);

--
-- Indexes for table `dir_previous_employers`
--
ALTER TABLE `dir_previous_employers`
  ADD PRIMARY KEY (`Employer_Code`);

--
-- Indexes for table `dir_religions`
--
ALTER TABLE `dir_religions`
  ADD PRIMARY KEY (`Religion_code`);

--
-- Indexes for table `dir_resignations`
--
ALTER TABLE `dir_resignations`
  ADD PRIMARY KEY (`Resign_code`);

--
-- Indexes for table `dir_sections`
--
ALTER TABLE `dir_sections`
  ADD PRIMARY KEY (`Section_code`);

--
-- Indexes for table `dir_shifts`
--
ALTER TABLE `dir_shifts`
  ADD PRIMARY KEY (`Shift_code`);

--
-- Indexes for table `dir_tax_certificate`
--
ALTER TABLE `dir_tax_certificate`
  ADD PRIMARY KEY (`tax_certificate_id`);

--
-- Indexes for table `final_temp_attendances`
--
ALTER TABLE `final_temp_attendances`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `history_appointments`
--
ALTER TABLE `history_appointments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `history_attendances`
--
ALTER TABLE `history_attendances`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `linkusermenusaccess`
--
ALTER TABLE `linkusermenusaccess`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `link_options_access`
--
ALTER TABLE `link_options_access`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `loghrsystem`
--
ALTER TABLE `loghrsystem`
  ADD PRIMARY KEY (`IdentityColumn`);

--
-- Indexes for table `master_all_employees`
--
ALTER TABLE `master_all_employees`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `master_employees`
--
ALTER TABLE `master_employees`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rawattendancedata`
--
ALTER TABLE `rawattendancedata`
  ADD PRIMARY KEY (`Sno`);

--
-- Indexes for table `sys_employees`
--
ALTER TABLE `sys_employees`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `temp_attendances`
--
ALTER TABLE `temp_attendances`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tran_appointments`
--
ALTER TABLE `tran_appointments`
  ADD PRIMARY KEY (`Sequence_no`),
  ADD KEY `FK_Tran_Appointment_Cost_Centre_code` (`Cost_Centre_code`),
  ADD KEY `FK_Tran_Appointment_Dept_code` (`Dept_code`),
  ADD KEY `FK_Tran_Appointment_Desig_code` (`Desig_code`),
  ADD KEY `FK_Tran_Appointment_Edu_code` (`Edu_code`),
  ADD KEY `FK_Tran_Appointment_Emp_category_code` (`Emp_category`),
  ADD KEY `FK_Tran_Appointment_Empt_Type_code` (`Empt_Type_code`),
  ADD KEY `FK_Tran_Appointment_Grade_code` (`Grade_code`),
  ADD KEY `FK_Tran_Appointment_Religion_Code` (`Religion_Code`),
  ADD KEY `FK_Tran_Appointment_Section_code` (`Section_code`),
  ADD KEY `FK_Tran_Mode_Of_Payment` (`Mode_Of_Payment`),
  ADD KEY `FK_TranApp_Leave_category` (`Emp_Leave_category`),
  ADD KEY `FK_TranBank_Branch_Code1` (`Branch_Code1`),
  ADD KEY `FK_TranBank_Branch_Code2` (`Branch_Code2`),
  ADD KEY `FK_TranBank_Branch_Code3` (`Branch_Code3`),
  ADD KEY `FK_TranBank_Branch_Code4` (`Branch_Code4`),
  ADD KEY `FK_TranEmp_Pcatgcode` (`Emp_Payroll_category`);

--
-- Indexes for table `tran_appointment_earnings`
--
ALTER TABLE `tran_appointment_earnings`
  ADD PRIMARY KEY (`Sequence_no`,`Allowance_code`),
  ADD KEY `FK_Tran_Appointment_Earnings_Allownace_code` (`Allowance_code`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `companies`
--
ALTER TABLE `companies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `dirmenus`
--
ALTER TABLE `dirmenus`
  MODIFY `MenuCode` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=100000;

--
-- AUTO_INCREMENT for table `dir_allowances`
--
ALTER TABLE `dir_allowances`
  MODIFY `Allowance_code` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- AUTO_INCREMENT for table `dir_banks`
--
ALTER TABLE `dir_banks`
  MODIFY `Bank_code` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dir_bank_branches`
--
ALTER TABLE `dir_bank_branches`
  MODIFY `Branch_code` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dir_busineess`
--
ALTER TABLE `dir_busineess`
  MODIFY `Business_Code` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dir_busineess_sectors`
--
ALTER TABLE `dir_busineess_sectors`
  MODIFY `Business_Sector_Code` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dir_cities`
--
ALTER TABLE `dir_cities`
  MODIFY `City_code` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dir_corecompetencies`
--
ALTER TABLE `dir_corecompetencies`
  MODIFY `Competency_code` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dir_corecompetencies_old`
--
ALTER TABLE `dir_corecompetencies_old`
  MODIFY `Core_Code` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dir_cost_centres`
--
ALTER TABLE `dir_cost_centres`
  MODIFY `Cost_Centre_code` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1067;

--
-- AUTO_INCREMENT for table `dir_countries`
--
ALTER TABLE `dir_countries`
  MODIFY `Country_Code` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dir_courses`
--
ALTER TABLE `dir_courses`
  MODIFY `Course_code` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dir_course_categaries`
--
ALTER TABLE `dir_course_categaries`
  MODIFY `Course_Catg_code` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dir_deductions`
--
ALTER TABLE `dir_deductions`
  MODIFY `Deduction_code` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dir_departments`
--
ALTER TABLE `dir_departments`
  MODIFY `Dept_code` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;

--
-- AUTO_INCREMENT for table `dir_designations`
--
ALTER TABLE `dir_designations`
  MODIFY `Desig_code` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=231;

--
-- AUTO_INCREMENT for table `dir_divisions`
--
ALTER TABLE `dir_divisions`
  MODIFY `Div_code` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=60;

--
-- AUTO_INCREMENT for table `dir_division_categories`
--
ALTER TABLE `dir_division_categories`
  MODIFY `Division_category_Code` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dir_educations`
--
ALTER TABLE `dir_educations`
  MODIFY `Edu_code` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dir_education_levels`
--
ALTER TABLE `dir_education_levels`
  MODIFY `Edu_level_code` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `dir_employee_categories`
--
ALTER TABLE `dir_employee_categories`
  MODIFY `Emp_Category_code` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `dir_employment_types`
--
ALTER TABLE `dir_employment_types`
  MODIFY `Empt_Type_code` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `dir_eobi_cities`
--
ALTER TABLE `dir_eobi_cities`
  MODIFY `EOBI_City_code` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dir_ess_request_type`
--
ALTER TABLE `dir_ess_request_type`
  MODIFY `Request_Code` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dir_hiring_checklist`
--
ALTER TABLE `dir_hiring_checklist`
  MODIFY `List_no` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `dir_hr_letter_types`
--
ALTER TABLE `dir_hr_letter_types`
  MODIFY `Letter_type_code` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dir_jobprofiles`
--
ALTER TABLE `dir_jobprofiles`
  MODIFY `JobCode` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dir_leave_categories`
--
ALTER TABLE `dir_leave_categories`
  MODIFY `Leave_Category_code` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `dir_locations`
--
ALTER TABLE `dir_locations`
  MODIFY `Loc_code` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `dir_mode_of_payments`
--
ALTER TABLE `dir_mode_of_payments`
  MODIFY `Payment_code` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dir_payroll_categories`
--
ALTER TABLE `dir_payroll_categories`
  MODIFY `Payroll_Category_code` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `dir_pay_grade_areas`
--
ALTER TABLE `dir_pay_grade_areas`
  MODIFY `Pay_Grade_Area_Code` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dir_religions`
--
ALTER TABLE `dir_religions`
  MODIFY `Religion_code` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `dir_resignations`
--
ALTER TABLE `dir_resignations`
  MODIFY `Resign_code` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dir_sections`
--
ALTER TABLE `dir_sections`
  MODIFY `Section_code` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1054;

--
-- AUTO_INCREMENT for table `dir_shifts`
--
ALTER TABLE `dir_shifts`
  MODIFY `Shift_code` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `dir_tax_certificate`
--
ALTER TABLE `dir_tax_certificate`
  MODIFY `tax_certificate_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `final_temp_attendances`
--
ALTER TABLE `final_temp_attendances`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `history_appointments`
--
ALTER TABLE `history_appointments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `history_attendances`
--
ALTER TABLE `history_attendances`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `linkusermenusaccess`
--
ALTER TABLE `linkusermenusaccess`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1999;

--
-- AUTO_INCREMENT for table `link_options_access`
--
ALTER TABLE `link_options_access`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `loghrsystem`
--
ALTER TABLE `loghrsystem`
  MODIFY `IdentityColumn` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `master_all_employees`
--
ALTER TABLE `master_all_employees`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `master_employees`
--
ALTER TABLE `master_employees`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rawattendancedata`
--
ALTER TABLE `rawattendancedata`
  MODIFY `Sno` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sys_employees`
--
ALTER TABLE `sys_employees`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `temp_attendances`
--
ALTER TABLE `temp_attendances`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
