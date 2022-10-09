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

/* 3)Show patient_id, first_name, last_name, and attending physician's specialty. Show only the patients who has a diagnosis as 'Epilepsy' 
and the physician's first name is 'Lisa'. */
select p.patient_id,
p.first_name as patient_first_name,
p.last_name as patient_last_name,
specialty as attending_physician_specialty
from patients p  
join admissions a on a.patient_id = p.patient_id
join physicians ph on ph.physician_id = a.attending_physician_id
where diagnosis = 'Epilepsy' and ph.first_name = 'Lisa';

/* 4) Each admission costs $50 for patients without insurance, and $10 for patients with insurance. All patients with an even patient_id have insurance.
Give each patient a 'Yes' if they have insurance, and a 'No' if they don't have insurance. Add up the admission_total cost for each has_insurance group. */
