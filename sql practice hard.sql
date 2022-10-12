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
select 
case when patient_id % 2 = 0 then 
    'Yes'
else
    'No'
end as has_insurance,
sum(case when patient_id%2 = 0 then 
    10
    
/* 5) Show the provinces that has more patients identified as 'M' than 'F'. Must only show full province_name */
SELECT pr.province_name
FROM patients AS pa
  JOIN province_names AS pr ON pa.province_id = pr.province_id
GROUP BY pr.province_name
HAVING
  COUNT( CASE WHEN gender = 'M' THEN 1 END) > COUNT( CASE WHEN gender = 'F' THEN 1 END);

    /* 6) We are looking for a specific patient. Pull all columns for the patient who matches the following criteria:
- First_name contains an 'r' after the first two letters.
- Identifies their gender as 'F'
- Born in February, May, or December
- Their weight would be between 60kg and 80kg
- Their patient_id is an odd number
- They are from the city 'Kingston' 
else
    50
end) as cost_after_insurance
from admissions
group by has_insurance;*/ 
 SELECT *
FROM patients
WHERE
  first_name LIKE '__r%'
  AND gender = 'F'
  AND MONTH(birth_date) IN (2, 5, 12)
  AND weight BETWEEN 60 AND 80
  AND patient_id % 2 = 1
  AND city = 'Kingston';

 /* 7) Show the percent of patients that have 'M' as their gender. Round the answer to the nearest hundreth number and in percent form. */
