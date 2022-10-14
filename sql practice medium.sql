/* 1)Show unique birth years from patients and order them by ascending.*/
select distinct year(birth_date) from patients order by year(birth_date);

/* 2) Show unique first names from the patients table which only occurs once in the list. */
select distinct(first_name) from patients group by first_name having count(first_name)=1;

/* 3) Show patient_id and first_name from patients where their first_name start and ends with 's' and is at least 6 characters long. */
select patient_id,first_name from patients where first_name like "s____%s";

/* 4) Show patient_id, first_name, last_name from patients whos diagnosis is 'Dementia'. */
select patients.patient_id, first_name,last_name from patients
join admissions on patients.patient_id = admissions.patient_id 
where diagnosis = 'Dementia';

/* 5) Display every patient's first_name. Order the list by the length of each name and then by alphbetically*/
select first_name from patients order by len(first_name), first_name;

/* 6) Show the total amount of male patients and the total amount of female patients in the patients table. Display the two results in the same row. */
select
(select count(*) from patients where gender = 'M') as male_count,
(select count(*) from patients where gender = 'F') as female_count;

/* 7) Show first and last name, allergies from patients which have allergies to either 'Penicillin' or 'Morphine'. Show results ordered ascending by allergies then by first_name then by last_name. */
select first_name, last_name, allergies from patients where allergies in ('Penicillin','Morphine')
order by allergies, first_name, last_name;

/* 8) Show patient_id, diagnosis from admissions. Find patients admitted multiple times for the same diagnosis. */
select patient_id, diagnosis from admissions group by patient_id ,diagnosis having count(*) > 1;

/* 9)Show the city and the total number of patients in the city. Order from most to least patients and then by city name ascending */
select city, count(*) as num_patients from patients group by city
order by num_patients desc, city asc;

/* 10) Show first name, last name and role of every person that is either patient or physician. The roles are either "Patient" or "Physician" */
select first_name,last_name,'patient' as role from patients 
union
select first_name, last_name, 'physician' as role from physicians;

/* 11) Show all allergies ordered by popularity. Remove NULL values from query. */
select allergies, count(allergies) as total_diagnosis from patients
where allergies not null group by allergies 
order by total_diagnosis desc;

/* 12) Show all patient's first_name, last_name, and birth_date who were born in the 1970s decade. Sort the list starting from the earliest birth_date.*/
select first_name,last_name,birth_date from patients 
where birth_date between '1970-01-01' and '1979-12-31'
order by birth_date;

/* 13) Show the province_id(s), sum of height; where the total sum of its patient's height is greater than or equal to 7,000. */
select province_id, ceil(sum(height)) as sum_height from patients
group by province_id having sum_height >= 7000;

/* 14) Show the difference between the largest weight and smallest weight for patients with the last name 'Maroni'*/
select max(weight) - min(weight) from patients where last_name = 'Maroni';

/* 15)Show all of the days of the month (1-31) and how many admission_dates occurred on that day. Sort by the day with most admissions to least admissions.*/
select day(admission_date) as day_number ,count(*) as number_of_admissions
from admissions 
group by day_number order by number_of_admissions desc;

/* 16) Show all columns for patient_id 542's most recent admission_date.*/
select * from admissions where patient_id = 542 group by patient_id having max(admission_date);

/* 17) Show patient_id, attending_physician_id, and diagnosis for admissions that match one of the two criteria:
1. patient_id is an odd number and attending_physician_id is either 1, 5, or 19.
2. attending_physician_id contains a 2 and the length of patient_id is 3 characters. */
select patient_id, attending_physician_id, diagnosis from admissions
where (attending_physician_id in (1,5,19) and patient_id % 2 != 0)
or 
( attending_physician_id like '%2%' and len(patient_id) = 3);

/* 18) Show first_name, last_name, and the total number of admissions attended for each physician. Every admission has been attended by a physician. */
SELECT first_name, last_name, count(*) as admissions_total
from admissions a
join physicians ph on ph.physician_id = a.attending_physician_id
group by attending_physician_id

/* 19) For each physicain, display their id, full name, and the first and last admission date they attended.*/
select physician_id, concat(first_name,' ', last_name) as full_name,
min(admission_date) as first_admission_date, max(admission_date) as last_admission_date 
from admissions a join physicians ph on 
ph.physician_id = a.attending_physician_id group by physician_id; 

/* 20) Display the total amount of patients for each province. Order by descending. */
select province_name ,count(*) as patient_count from patients pa join province_names pr 
on pa.province_id = pr.province_id group by  province_name 
order by patient_count desc;

/* 21) We want to display each patient's full name in a single column. 
Their last_name in all upper letters must appear first, then first_name in all lower case letters.
Separate the last_name and first_name with a comma. Order the list by the first_name in decending order */
