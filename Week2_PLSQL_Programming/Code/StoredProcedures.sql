--Scenario 1
CREATE OR REPLACE PROCEDURE ProcessMonthlyInterest IS
BEGIN
    UPDATE Accounts SET Balance=Balance+(Balance*0.01) WHERE AccountType='Savings';
    COMMIT;
    dbms_output.put_line('Interest processed for all savings account');
EXCEPTION
WHEN OTHERS THEN
ROLLBACK;
dbms_output.put_line('Error occurred while processing:'||SQLERRM);
END;


--Testing Scenario 1
SELECT AccountID, CustomerID, AccountType, Balance
FROM Accounts
WHERE AccountType = 'Savings';

BEGIN
    ProcessMonthlyInterest;
END;


--Scenario 2
CREATE OR REPLACE PROCEDURE UpdateEmployeeBonus(
    dept IN VARCHAR2,
    bonus IN NUMBER
) IS 
BEGIN
    UPDATE Employees SET Salary=Salary+(Salary*(bonus/100)) WHERE Department=dept;
    COMMIT;
    dbms_output.put_line('Added bonus for the department:'||dept);
EXCEPTION
WHEN OTHERS THEN
ROLLBACK;
dbms_output.put_line('Error updating salaries:'||SQLERRM);
END;

--Testing Scenario 2
SELECT EmployeeID, Name, Department, Salary
FROM Employees
WHERE Department = 'IT';

BEGIN
    UpdateEmployeeBonus('IT',10);
END;


--Scenario 3
CREATE OR REPLACE PROCEDURE TransferFunds(
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

--Testing Scenario 3
SET SERVEROUTPUT ON
BEGIN
    TransferFunds(2, 3, 500);  -- Transfer 500 from AccountID 1 → AccountID 2
END;

BEGIN
    TransferFunds(5, 2, 5000);  -- Try to transfer 5000 from AccountID 5 (only 500 balance)
END;

SELECT * FROM Accounts WHERE AccountID IN(2,3);
SELECT * FROM Accounts WHERE AccountID IN(5,2);