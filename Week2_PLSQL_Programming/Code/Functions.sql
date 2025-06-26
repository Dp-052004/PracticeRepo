--Scenario 1
CREATE OR REPLACE FUNCTION CalculateAge(p_dob DATE)
RETURN number IS v_age NUMBER;
BEGIN
    v_age:=TRUNC(MONTHS_BETWEEN(SYSDATE,p_dob)/12);
    RETURN v_age;
END;
--Function call
SELECT CalculateAge(DOB) AS Age FROM Customers WHERE CustomerID=3;


--Scenario 2
CREATE OR REPLACE FUNCTION CalculateMonthlyInstallment(
    p_loanAmt NUMBER,
    p_rate NUMBER,
    p_years NUMBER
) RETURN NUMBER
IS
v_rate NUMBER;
v_months NUMBER;
v_installment NUMBER;

BEGIN 
    --Monthly interest rate calculation
    v_rate:=p_rate/(12*100);
    --Total months calculation
    v_months:=p_years*12;

    --Installment calculation
    v_installment := (p_loanAmt * v_rate * POWER(1 + v_rate, v_months))
                     / (POWER(1 + v_rate, v_months) - 1);
    RETURN v_installment;
END;

--Function call
SET SERVEROUTPUT ON
DECLARE
amount NUMBER;
rate NUMBER;
years NUMBER;
installments NUMBER;

BEGIN
    amount:=&amount;
    rate:=&rate;
    years:=&years;

    installments:=CalculateMonthlyInstallment(amount,rate,years);
    dbms_output.put_line('The monthly installment for Rs '||amount||' at the interest rate '||rate||'for '||years||' years is:'||installments);
END;


--Scenario 3
CREATE OR REPLACE FUNCTION HasSufficientBalance(
    p_acc_id NUMBER,
    p_amt NUMBER
) RETURN BOOLEAN
IS 
v_balance NUMBER;
BEGIN
    SELECT Balance into v_balance FROM Accounts WHERE AccountID=p_acc_id;
    RETURN v_balance>=p_amt;
EXCEPTION
WHEN NO_DATA_FOUND THEN
RETURN FALSE;
END;


--Function call
SET SERVEROUTPUT ON
DECLARE
acc_id NUMBER;
amount NUMBER;
result BOOLEAN;
BEGIN
    acc_id:=&acc_id;
    amount:=&amount;
    result:=HasSufficientBalance(acc_id,amount);
    if result then
    dbms_output.put_line('Sufficient balance');
    else 
    dbms_output.put_line('Insufficient balance');
    end if;
END;
