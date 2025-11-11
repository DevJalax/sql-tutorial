CREATE OR REPLACE PROCEDURE GET_EMP_DETAILS(
    p_emp_id IN NUMBER,
    p_name OUT VARCHAR2,
    p_salary OUT NUMBER
) AS
BEGIN
    SELECT name, salary INTO p_name, p_salary FROM employees WHERE emp_id = p_emp_id;
END;
/



SQL> SET SERVEROUTPUT ON;
 
SQL> DECLARE
      
     -- taking input for variable a
     a integer := &a ; 
      
     -- taking input for variable b
     b integer := &b ; 
     c integer ;
 
  BEGIN
     c := a + b ;
     dbms_output.put_line('Sum of '||a||' and '||b||' is = '||c);
 
  END;
