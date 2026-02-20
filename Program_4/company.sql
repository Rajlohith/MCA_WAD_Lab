-- 1. Department Table (Created first, but foreign key added later to avoid circular dependency)
CREATE TABLE DEPARTMENT (
    Dnumber INT PRIMARY KEY,
    Dname VARCHAR(50) UNIQUE,
    Mgr_ssn CHAR(9),
    Mgr_start_date DATE
);

-- 2. Employee Table
CREATE TABLE EMPLOYEE (
    Ssn CHAR(9) PRIMARY KEY,
    Fname VARCHAR(15) NOT NULL,
    Lname VARCHAR(15) NOT NULL,
    Address VARCHAR(30),
    Sex CHAR(1),
    Salary DECIMAL(10, 2),
    Super_ssn CHAR(9),
    Dno INT,
    Bdate DATE,
    FOREIGN KEY (Dno) REFERENCES DEPARTMENT(Dnumber)
);

-- Now add the Foreign Key for Department Manager pointing to Employee
ALTER TABLE DEPARTMENT
ADD FOREIGN KEY (Mgr_ssn) REFERENCES EMPLOYEE(Ssn);

-- Add Self-Referencing Foreign Key for Supervisor
ALTER TABLE EMPLOYEE
ADD FOREIGN KEY (Super_ssn) REFERENCES EMPLOYEE(Ssn);

-- 3. Department Locations
CREATE TABLE DEPT_LOCATIONS (
    Dnumber INT,
    Dlocation VARCHAR(15),
    PRIMARY KEY (Dnumber, Dlocation),
    FOREIGN KEY (Dnumber) REFERENCES DEPARTMENT(Dnumber)
);

-- 4. Project Table
-- Added 'Worth' for Query 5 and 'End_date' for Query 3
CREATE TABLE PROJECT (
    Pnumber INT PRIMARY KEY,
    Pname VARCHAR(25) UNIQUE,
    Plocation VARCHAR(15),
    Dnum INT,
    Worth DECIMAL(12,2), 
    End_date DATE,
    FOREIGN KEY (Dnum) REFERENCES DEPARTMENT(Dnumber)
);

-- 5. Works_On Table
CREATE TABLE WORKS_ON (
    Essn CHAR(9),
    Pno INT,
    Hours DECIMAL(3, 1),
    PRIMARY KEY (Essn, Pno),
    FOREIGN KEY (Essn) REFERENCES EMPLOYEE(Ssn),
    FOREIGN KEY (Pno) REFERENCES PROJECT(Pnumber)
);

-- 6. Dependent Table
CREATE TABLE DEPENDENT (
    Essn CHAR(9),
    Dependent_name VARCHAR(15),
    Sex CHAR(1),
    Bdate DATE,
    Relationship VARCHAR(8),
    PRIMARY KEY (Essn, Dependent_name),
    FOREIGN KEY (Essn) REFERENCES EMPLOYEE(Ssn)
);



-- Insert Departments (Managers are NULL initially)
INSERT INTO DEPARTMENT VALUES (1, 'Headquarters', NULL, '2018-06-19');
INSERT INTO DEPARTMENT VALUES (4, 'Administration', NULL, '2017-01-01');
INSERT INTO DEPARTMENT VALUES (5, 'R&D', NULL, '2015-05-22');
INSERT INTO DEPARTMENT VALUES (6, 'Finance', NULL, '2019-03-01');

-- Insert Employees
-- '888665555' is the top boss (no supervisor)
INSERT INTO EMPLOYEE VALUES ('888665555', 'James', 'Borg', '450 Stone, Houston, TX', 'M', 55000, NULL, 1, '1957-11-10');
-- Supervisor for Query 4 (Needs >3 employees under him)
INSERT INTO EMPLOYEE VALUES ('333445555', 'Franklin', 'Wong', '638 Voss, Houston, TX', 'M', 40000, '888665555', 5, '1965-12-08');
-- Employees under Franklin (R&D)
INSERT INTO EMPLOYEE VALUES ('123456789', 'John', 'Smith', '731 Fondren, Houston, TX', 'M', 30000, '333445555', 5, '1975-01-09');
INSERT INTO EMPLOYEE VALUES ('666884444', 'Ramesh', 'Narayan', '975 Fire Oak, Humble, TX', 'M', 38000, '333445555', 5, '1972-09-15');
INSERT INTO EMPLOYEE VALUES ('453453453', 'Joyce', 'English', '5631 Rice, Houston, TX', 'F', 25000, '333445555', 5, '1982-07-31');
INSERT INTO EMPLOYEE VALUES ('987654321', 'Jennifer', 'Wallace', '291 Berry, Bellaire, TX', 'F', 43000, '333445555', 5, '1951-06-20');
-- Finance Employees (For Query 1)
INSERT INTO EMPLOYEE VALUES ('999887777', 'Alicia', 'Zelaya', '3321 Castle, Spring, TX', 'F', 25000, '987654321', 6, '1978-01-19');
INSERT INTO EMPLOYEE VALUES ('987987987', 'Ahmad', 'Jabbar', '980 Dallas, Houston, TX', 'M', 22000, '987654321', 6, '1979-03-29');

-- Update Departments with Managers
UPDATE DEPARTMENT SET Mgr_ssn = '888665555' WHERE Dnumber = 1;
UPDATE DEPARTMENT SET Mgr_ssn = '987654321' WHERE Dnumber = 4;
UPDATE DEPARTMENT SET Mgr_ssn = '333445555' WHERE Dnumber = 5;
UPDATE DEPARTMENT SET Mgr_ssn = '999887777' WHERE Dnumber = 6;

-- Insert Projects (Using R&D and Finance, setting Worth > 10L for Query 5)
-- Projects 1, 2, 3 are R&D. Project 10, 20 are Finance.
INSERT INTO PROJECT VALUES (1, 'ProductX', 'Bellaire', 5, 2000000.00, '2023-12-31');
INSERT INTO PROJECT VALUES (2, 'ProductY', 'Sugarland', 5, 500000.00, '2024-05-15');
INSERT INTO PROJECT VALUES (3, 'ProductZ', 'Houston', 5, 1200000.00, NULL); -- Ongoing
INSERT INTO PROJECT VALUES (10, 'Computerization', 'Stafford', 4, 800000.00, '2022-01-01');
INSERT INTO PROJECT VALUES (20, 'NewBenefits', 'Stafford', 6, 100000.00, NULL); -- Ongoing
INSERT INTO PROJECT VALUES (30, 'Automation', 'Houston', 5, 500000.00, '2023-01-01');

-- Insert Works_On
-- John Smith (123456789) works on 3 R&D projects (Matches Query 2)
INSERT INTO WORKS_ON VALUES ('123456789', 1, 32.5);
INSERT INTO WORKS_ON VALUES ('123456789', 2, 7.5);
INSERT INTO WORKS_ON VALUES ('123456789', 3, 10.0);
-- Others
INSERT INTO WORKS_ON VALUES ('453453453', 1, 20.0);
INSERT INTO WORKS_ON VALUES ('453453453', 2, 20.0);
INSERT INTO WORKS_ON VALUES ('333445555', 2, 10.0);
INSERT INTO WORKS_ON VALUES ('333445555', 3, 10.0);
INSERT INTO WORKS_ON VALUES ('333445555', 10, 10.0);
INSERT INTO WORKS_ON VALUES ('999887777', 30, 30.0);
INSERT INTO WORKS_ON VALUES ('987987987', 10, 35.0);
INSERT INTO WORKS_ON VALUES ('987987987', 30, 5.0);

-- Insert Dependents
-- John Smith has a daughter (Matches Query 5 criteria if he has high worth projects)
INSERT INTO DEPENDENT VALUES ('123456789', 'Alice', 'F', '2008-12-30', 'Daughter');
INSERT INTO DEPENDENT VALUES ('123456789', 'Theodore', 'M', '2010-10-25', 'Son');
INSERT INTO DEPENDENT VALUES ('333445555', 'Joy', 'F', '1998-05-03', 'Spouse');
INSERT INTO DEPENDENT VALUES ('987654321', 'Abner', 'M', '1990-02-28', 'Spouse');


-- Department 1 (Headquarters) is in Houston
INSERT INTO DEPT_LOCATIONS VALUES (1, 'Houston');

-- Department 4 (Administration) is in Stafford
INSERT INTO DEPT_LOCATIONS VALUES (4, 'Stafford');

-- Department 5 (R&D) has multiple locations (Bellaire, Sugarland, Houston)
INSERT INTO DEPT_LOCATIONS VALUES (5, 'Bellaire');
INSERT INTO DEPT_LOCATIONS VALUES (5, 'Sugarland');
INSERT INTO DEPT_LOCATIONS VALUES (5, 'Houston');

-- Department 6 (Finance) is in Houston and Stafford
INSERT INTO DEPT_LOCATIONS VALUES (6, 'Houston');
INSERT INTO DEPT_LOCATIONS VALUES (6, 'Stafford');



/* ============================================================
   QUERY 1
   List the f_Name, l_Name, dept_Name of the employee 
   who draws a salary greater than the average salary 
   of employees working for Finance department.
   ============================================================ */

SELECT e.Fname, e.Lname, d.Dname, e.Salary FROM employee e, department d WHERE e.Dno = d.Dnumber AND e.Salary > (SELECT AVG(e2.Salary) FROM employee e2, department d2 WHERE e2.Dno = d2.Dnumber AND d2.Dname = 'Finance');

/* ============================================================
   QUERY 2
   List the name and department of the employee who is 
   currently working on more than two projects 
   controlled by R&D department.
   ============================================================ */
SELECT e.Fname, e.Lname, d.Dname, counts.cnt AS "No of Projects"FROM employee e, department d,(SELECT w.Essn, COUNT(w.Essn) AS cnt FROM works_on w, project p, department d2 WHERE w.Pno = p.Pnumber AND p.Dnum = d2.Dnumber AND d2.Dname = 'R&D' GROUP BY w.Essn) AS counts WHERE e.Dno = d.Dnumber AND e.Ssn = counts.Essn AND counts.cnt > 2;

/* ============================================================
   QUERY 3
   List all the ongoing projects controlled by 
   all the departments.
   ============================================================ */

SELECT p.Pnumber, p.Pname, d.Dname FROM project p, department d WHERE p.Dnum = d.Dnumber AND (p.End_date IS NULL OR p.End_date >= CURRENT_DATE);



/* ============================================================
   QUERY 4
   Give the details of the supervisor who is supervising 
   more than 3 employees who have completed at least one project.
   ============================================================ */

SELECT e.Ssn, e.Fname, e.Lname FROM employee e, (SELECT Super_ssn, COUNT(e2.Ssn) AS cnt FROM employee e2, project p, works_on w WHERE e2.Ssn = w.Essn AND p.Pnumber = w.Pno AND Super_ssn IS NOT NULL GROUP BY Super_ssn) AS counts WHERE counts.Super_ssn = e.Ssn AND counts.cnt > 3;

/* ============================================================
   QUERY 5
   List the name of the dependents of employee who has 
   completed total projects worth 10 Lakhs (10,00,000) or more.
   ============================================================ */

SELECT DISTINCT e.Ssn, e.Fname, p.Worth, d.Dependent_name FROM works_on w, project p, dependent d, employee e WHERE d.Essn = e.Ssn AND e.Ssn = w.Essn AND w.Pno = p.Pnumber AND p.Worth > 1000000;

/* ============================================================
   QUERY 6
   List the department and employee details whose project 
   is in more than one city.
   ============================================================ */

SELECT e.Ssn, d.Dnumber, p.Pnumber, p.Plocation FROM employee e, project p, department d WHERE e.Dno = d.Dnumber AND p.Dnum = d.Dnumber;
