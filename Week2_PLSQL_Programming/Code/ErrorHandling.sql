--Scenario 1
CREATE TABLE Accounts (
    AccountID NUMBER PRIMARY KEY,
    CustomerID NUMBER,
    AccountType VARCHAR2(20),
    Balance NUMBER,
    LastModified DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

INSERT INTO Accounts (AccountID, CustomerID, AccountType, Balance, LastModified)
VALUES (1, 1, 'Savings', 1000, SYSDATE);

INSERT INTO Accounts (AccountID, CustomerID, AccountType, Balance, LastModified)
VALUES (2, 2, 'Checking', 1500, SYSDATE);

INSERT INTO Accounts (AccountID, CustomerID, AccountType, Balance, LastModified)
VALUES (3, 3, 'Savings', 2500, SYSDATE);

INSERT INTO Accounts (AccountID, CustomerID, AccountType, Balance, LastModified)
VALUES (4, 4, 'Checking', 3000, SYSDATE);

INSERT INTO Accounts (AccountID, CustomerID, AccountType, Balance, LastModified)
VALUES (5, 5, 'Savings', 500, SYSDATE);

INSERT INTO Accounts (AccountID, CustomerID, AccountType, Balance, LastModified)
VALUES (6, 6, 'Checking', 4000, SYSDATE);

INSERT INTO Accounts (AccountID, CustomerID, AccountType, Balance, LastModified)
VALUES (7, 7, 'Savings', 1200, SYSDATE);

INSERT INTO Accounts (AccountID, CustomerID, AccountType, Balance, LastModified)
VALUES (8, 8, 'Checking', 3500, SYSDATE);

--Procedure part
CREATE OR REPLACE PROCEDURE SafeTransferFunds(
    p_fromID IN NUMBER,
    p_toID IN NUMBER,
    p_amt IN NUMBER
) IS currBal Accounts.Balance%TYPE;

BEGIN
    --Getting the balance of trnasferring account
    Select Balance into currBal FROM Accounts WHERE AccountID=p_fromID;

    --Checking the balance 
    if currBal<p_amt THEN
    RAISE_APPLICATION_ERROR(-20001,'Insufficient funds in source account');
    end if;

    --Updating balance for successful transaction
    UPDATE Accounts SET Balance=Balance-p_amt,LastModified=SYSDATE WHERE AccountID=p_fromID;
    UPDATE Accounts SET Balance=Balance+p_amt,LastModified=SYSDATE WHERE AccountID=p_toID;

    COMMIT;
    dbms_output.put_line('Transfer sucessful');

EXCEPTION
WHEN NO_DATA_FOUND THEN
ROLLBACK;
dbms_output.put_line('One of the accounts is missing');
WHEN OTHERS THEN
ROLLBACK;
dbms_output.put_line('Error during fund transfer:'||SQLERRM);
END;

--Testing Scenario 1
SET SERVEROUTPUT ON
BEGIN
    SafeTransferFunds(1, 2, 500);  -- Transfer 500 from AccountID 1 → AccountID 2
END;

BEGIN
    SafeTransferFunds(5, 2, 5000);  -- Try to transfer 5000 from AccountID 5 (only 500 balance)
END;

SELECT * FROM Accounts WHERE AccountID IN(1,2);
SELECT * FROM Accounts WHERE AccountID IN(5,2);


--Scenario 2
CREATE TABLE Employees (
    EmployeeID NUMBER PRIMARY KEY,
    Name VARCHAR2(100),
    Position VARCHAR2(50),
    Salary NUMBER,
    Department VARCHAR2(50),
    HireDate DATE
);

INSERT INTO Employees (EmployeeID, Name, Position, Salary, Department, HireDate)
VALUES (1, 'Alice Johnson', 'Manager', 70000, 'HR', TO_DATE('2015-06-15', 'YYYY-MM-DD'));

INSERT INTO Employees (EmployeeID, Name, Position, Salary, Department, HireDate)
VALUES (2, 'Bob Brown', 'Developer', 60000, 'IT', TO_DATE('2017-03-20', 'YYYY-MM-DD'));

INSERT INTO Employees (EmployeeID, Name, Position, Salary, Department, HireDate)
VALUES (3, 'Catherine Lee', 'Analyst', 55000, 'Finance', TO_DATE('2018-11-10', 'YYYY-MM-DD'));

INSERT INTO Employees (EmployeeID, Name, Position, Salary, Department, HireDate)
VALUES (4, 'David Smith', 'Designer', 58000, 'Marketing', TO_DATE('2019-08-25', 'YYYY-MM-DD'));

INSERT INTO Employees (EmployeeID, Name, Position, Salary, Department, HireDate)
VALUES (5, 'Evelyn White', 'Support Engineer', 52000, 'IT', TO_DATE('2020-01-05', 'YYYY-MM-DD'));

Select * from Employees;

CREATE OR REPLACE PROCEDURE UpdateSalary(
    p_EmpID IN NUMBER,
    p_Inc IN NUMBER
) IS currSal Employees.Salary%TYPE;
BEGIN

    --Getting current salary
    SELECT Salary into currSal FROM Employees WHERE EmployeeID=p_EmpID;

    --Updating salary
    UPDATE Employees 
    SET Salary=Salary+(currSal*p_Inc/100) WHERE EmployeeID=p_EmpID;

    COMMIT;
    dbms_output.put_line('Salary Updated Successfully');

EXCEPTION
WHEN NO_DATA_FOUND THEN
dbms_output.put_line('Error: Employee with ID:'||p_EmpID||' not found');
WHEN OTHERS THEN
dbms_output.put_line('Error updating salary:'||SQLERRM);
END;

--Testing Scenario 2
SET SERVEROUTPUT ON
BEGIN
    UpdateSalary(1,5);
END;

BEGIN
    UpdateSalary(9999,10);
END;


--Scenario 3
Create or replace PROCEDURE AddNewCustomer(
    p_id In NUMBER,
    p_Name IN VARCHAR2,
    p_DOB IN DATE,
    p_Bal IN NUMBER
)  IS
BEGIN
    INSERT into Customers(CustomerID,Name,DOB,Balance,LastModified)
    VALUES(p_id,p_Name,p_DOB,p_Bal,SYSDATE);
    COMMIT;
    dbms_output.put_line('New Customer added successfully');

EXCEPTION
WHEN DUP_VAL_ON_INDEX THEN
dbms_output.put_line('Error: Customer with ID:'||p_id||' already exists');
WHEN OTHERS THEN
dbms_output.put_line('Error adding new customer:'||SQLERRM);
END;


--Testing Scenario 3
SET SERVEROUTPUT ON;
BEGIN
    AddNewCustomer(5,'Robert',TO_DATE('1985-12-10','YYYY-MM-DD'),6000);
END;

BEGIN
    AddNewCustomer(8,'Andrew',TO_DATE('1994-04-25','YYYY-MM-DD'),6744);
END;