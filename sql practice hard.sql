/* 1)Show all of the patients grouped into weight groups. Show the total amount of patients in each weight group. Order the list by the weight group decending. */
SELECT
  COUNT(*) AS patients_in_group,
  FLOOR(weight / 10) * 10 AS weight_group
FROM patients GROUP BY weight_group ORDER BY weight_group DESC;

/*2) Show patient_id, weight, height, isObese from the patients table. Display isObese as a boolean 0 or 1. Obese is defined as weight(kg)/(height(m)2) >= 30. */
select patient_id, weight, height,
(case
when weight/power(height/100.0,2) >= 30 then 1
else 0
end) as isObese
from patients;

