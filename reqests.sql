-- 1. Сколько денег у каждого клиента? Отсортировать по имени клиента по алфавиту
SELECT P.PPL_NAME as Client_Name, COALESCE(SUM(B.BLNC_OSTATOK), 0) as Total_Money
FROM PROG_TEST_PEOPLE P
LEFT JOIN PROG_TEST_ACCNT A ON P.PPL_PPL_CODE = A.ACCNT_PPL_CODE
LEFT JOIN PROG_TEST_BLNC B ON A.ACCNT_CODE = B.BLNC_ACCNT_CODE
GROUP BY P.PPL_NAME
ORDER BY P.PPL_NAME;
/*
Client_Name | Total_Money 
----------------------------------------
            |
*/



-- 2. Список клиентов без паспорта?
SELECT PPL_NAME
FROM PROG_TEST_PEOPLE
WHERE PPL_CODE NOT IN (SELECT DOC_PPL_CODE FROM PROG_TEST_DOCS);
/*
PPL_NAME 
----------------------------------------
*/


-- 3. Сколько денег у поручителя человека с конкретным номером паспортом? (сделать номер паспорта бинд-переменной)
DECLARE @PassportNumber varchar(30);
SET @PassportNumber = 'YOUR_PASSPORT_NUMBER_HERE';

SELECT COALESCE(SUM(B.BLNC_OSTATOK), 0) as Total_Money
FROM PROG_TEST_PEOPLE P
LEFT JOIN PROG_TEST_ACCNT A ON P.PPL_PPL_CODE = A.ACCNT_PPL_CODE
LEFT JOIN PROG_TEST_BLNC B ON A.ACCNT_CODE = B.BLNC_ACCNT_CODE
WHERE P.PPL_CODE IN (SELECT DOC_PPL_CODE FROM PROG_TEST_DOCS WHERE DOC_NUM = @PassportNumber);
/*
Total_Money                             
----------------------------------------
                                       0
*/

-- 4. Где живет самый богатый человек?
SELECT ADDR_CITY
FROM PROG_TEST_ADDRESS
WHERE ADDR_PPL_CODE = (
  SELECT ACCNT_PPL_CODE
  FROM PROG_TEST_ACCNT
  WHERE ACCNT_CODE = (
    SELECT BLNC_ACCNT_CODE
    FROM PROG_TEST_BLNC
    WHERE BLNC_OSTATOK = (
      SELECT MAX(BLNC_OSTATOK)
      FROM PROG_TEST_BLNC
    )
  )
);

/*
ADDR_CITY                             
----------------------------------------
                                       
*/
*/