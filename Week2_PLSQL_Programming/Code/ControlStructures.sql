--Customers table creation
CREATE TABLE Customers (
    CustomerID NUMBER PRIMARY KEY,
    Name VARCHAR2(100),
    DOB DATE,
    Balance NUMBER,
    LastModified DATE
);


INSERT INTO Customers (CustomerID, Name, DOB, Balance, LastModified)
VALUES (1, 'John Doe', TO_DATE('1985-05-15', 'YYYY-MM-DD'), 10000, SYSDATE);

INSERT INTO Customers (CustomerID, Name, DOB, Balance, LastModified)
VALUES (2, 'Jane Smith', TO_DATE('1990-07-20', 'YYYY-MM-DD'), 15000, SYSDATE);

INSERT INTO Customers VALUES (3, 'Charlie',TO_DATE('1940-11-05','YYYY-MM-DD'), 5000,  SYSDATE);

INSERT INTO Customers (CustomerID, Name, DOB, Balance, LastModified)
VALUES (4, 'Alice', TO_DATE('1985-07-22', 'YYYY-MM-DD'), 8500, SYSDATE);

INSERT INTO Customers (CustomerID, Name, DOB, Balance, LastModified)
VALUES (5, 'Bob', TO_DATE('1970-07-20', 'YYYY-MM-DD'), 15000, SYSDATE);

INSERT INTO Customers (CustomerID, Name, DOB, Balance, LastModified)
VALUES (6, 'Jack', TO_DATE('1997-06-10', 'YYYY-MM-DD'), 15000, SYSDATE);

INSERT INTO Customers (CustomerID, Name, DOB, Balance, LastModified)
VALUES (7, 'Mary', TO_DATE('1977-05-04', 'YYYY-MM-DD'), 65000, SYSDATE);

Select * FROM Customers;


--Loans table creation
CREATE TABLE Loans (
    LoanID NUMBER PRIMARY KEY,
    CustomerID NUMBER,
    LoanAmount NUMBER,
    InterestRate NUMBER,
    StartDate DATE,
    EndDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

INSERT INTO Loans (LoanID, CustomerID, LoanAmount, InterestRate, StartDate, EndDate)
VALUES (1, 1, 5000, 5, SYSDATE, ADD_MONTHS(SYSDATE, 60));

INSERT INTO Loans (LoanID, CustomerID, LoanAmount, InterestRate, StartDate, EndDate)
VALUES (2, 1, 1500, 6.5, SYSDATE - 100, ADD_MONTHS(SYSDATE, 24));

INSERT INTO Loans (LoanID, CustomerID, LoanAmount, InterestRate, StartDate, EndDate)
VALUES (3, 2, 2500, 7.2, SYSDATE - 200, ADD_MONTHS(SYSDATE, 36));

INSERT INTO Loans (LoanID, CustomerID, LoanAmount, InterestRate, StartDate, EndDate)
VALUES (4, 3, 3000, 8.0, SYSDATE - 400, ADD_MONTHS(SYSDATE, 12));

INSERT INTO Loans (LoanID, CustomerID, LoanAmount, InterestRate, StartDate, EndDate)
VALUES (5, 2, 10000, 5.5, SYSDATE - 50, ADD_MONTHS(SYSDATE, 6));

INSERT INTO Loans (LoanID, CustomerID, LoanAmount, InterestRate, StartDate, EndDate)
VALUES (6, 1, 12000, 6.0, SYSDATE - 20, SYSDATE + 10);

INSERT INTO Loans (LoanID, CustomerID, LoanAmount, InterestRate, StartDate, EndDate)
VALUES (7, 2, 15000, 6.5, SYSDATE - 5, SYSDATE + 7);

--SCENARIO 1
SET SERVEROUTPUT ON;

DECLARE
    CURSOR customer_cursor IS
        SELECT l.LoanID, l.InterestRate
        FROM Loans l
        JOIN Customers c ON l.CustomerID = c.CustomerID
        WHERE TRUNC(MONTHS_BETWEEN(SYSDATE, c.DOB) / 12) > 60;

BEGIN
    FOR rec IN customer_cursor LOOP
        UPDATE Loans
        SET InterestRate = rec.InterestRate - (rec.InterestRate * 0.01)
        WHERE LoanID = rec.LoanID;
    END LOOP;

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Discount applied to eligible customers.');
END;
/
--Testing SCENARIO 1
SELECT LoanID, CustomerID, LoanAmount, InterestRate
FROM Loans
ORDER BY LoanID;

--Modifying the table Customers to add a IsVIP attribute
Alter TABLE Customers ADD (IsVIP varchar2(5) Default 'FALSE');

--SCENARIO 2
SET SERVEROUTPUT ON;

DECLARE
CURSOR cust IS
SELECT CustomerID,Balance FROM Customers;

BEGIN 
    for rec in cust LOOP
        if rec.Balance>10000 then
            UPDATE Customers SET IsVIP='TRUE' WHERE CustomerID=rec.CustomerID;
        else
            UPDATE Customers SET IsVIP='FALSE' WHERE CustomerID=rec.CustomerID;
        end if;
    END LOOP;

    COMMIT;
    dbms_output.put_line('VIP status updated for eligible people');
END;
--Testing SCENARIO 2
SELECT CustomerID, Name, Balance, IsVIP FROM Customers;  --for showing output

--SCENARIO 3
SET SERVEROUTPUT ON;

DECLARE 
CURSOR loan IS
SELECT l.CustomerID,l.EndDate,c.Name FROM Loans l JOIN Customers c
ON l.CustomerID=c.customerID WHERE l.EndDate BETWEEN SYSDATE AND (SYSDATE+30);

BEGIN
    for rec in loan LOOP
    dbms_output.put_line('Reminder:'||rec.Name||' has a loan due on '||TO_CHAR(rec.EndDate,'DD-MON-YYYY'));
    end LOOP;
END;



