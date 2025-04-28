--1.	Retrieve all the columns for the first 10 records in the dataset.
use HelthyCare
select top 10 * from visits
--2.	Count the total number of visits recorded in the dataset.
select COUNT(*) from visits
--3.	List all distinct departments (Department ID) available in the dataset.
select distinct v.department_id ,d.Department
from visits v join departments d 
on v.Department_ID =d.Department_ID

--4.	Retrieve the total treatment cost for all patients.
select sum(Treatment_Cost) from visits
--5.	Get the average patient satisfaction score.
select avg(patient_Satisfaction_Score)
from visits
--6.	List all patient IDs and their corresponding provider IDs.
select Patient_id ,provider_id
from visits
--7.	Count how many patients visited the emergency department (Emergency Visit = 'Yes').
select count(Patient_id)
from visits
where Emergency_Visit = 1
--8.	Find the most common Service Type in the dataset.
select top 10 Service_Type, count (Service_Type) As 'No. Service'
from visits
group by Service_Type
order by count (Service_Type) desc

--9.	Retrieve the total medication cost for each department.
select d.Department,sum(v.Medication_Cost) As'total medication cost'
from visits v join departments d
on v.Department_ID=d.Department_ID
group by d.Department
--10.	Find the top 5 most expensive procedures in terms of Treatment Cost.
select top 5 p.Procedures ,v.Treatment_Cost
from procedures p join visits v
on p.Procedure_ID=v.Procedure_ID
order by v.Treatment_Cost desc
--11.	Retrieve the number of visits per Provider ID, sorted in descending order.
select provider_id ,count(*) As 'No. of visits'
from visits
group by provider_id
order by count(*) desc
--12.	Find the number of patients who were admitted and discharged on the same day.
 select count(*)
 from visits
 where Admitted_Date=Discharge_Date

--13.	Get the highest and lowest treatment costs for each Service Type.
 select Service_Type ,min(Treatment_Cost) as 'lowest treatment costs',max(Treatment_Cost) as'Highest treatment cost'
 from visits
 group by Service_type
--14.	Find the total revenue generated from room charges.
 select sum(Room_Charges_daily_rate)
 from visits
 --15.	Identify how many follow-up visits happened in a specific month (e.g., February 2024).
 select count(*)
 from visits
 where month(Follow_Up_Visit_Date) = 2
--16.	Calculate the percentage of visits covered by insurance (Insurance Coverage = 'Yes').
select ( (insurance_Coverage / (treatment_cost+Medication_Cost))*100 )
from visits
--17.	Retrieve the average length of stay for admitted patients (Discharge Date - Admitted Date).
SELECT 
    AVG(DATEDIFF(day, Admitted_Date, Discharge_Date)) AS AverageLengthOfStay
FROM visits
WHERE Discharge_Date IS NOT NULL;

--18.Rank the departments by total revenue generated (treatment cost + medication cost + room charges).
	SELECT d.department,sum(v.Treatment_Cost + v.Medication_Cost + v.Room_Charges_daily_rate) 
	from departments d join visits v
	on d.Department_ID=v.Department_ID
	group by d.Department

--19.Find the patient with the highest total hospital cost (sum of treatment, medication, and room charges).
select patient_id,max(v.Treatment_Cost + v.Medication_Cost + v.Room_Charges_daily_rate)
from visits v
group by Patient_ID
order by max(v.Treatment_Cost + v.Medication_Cost + v.Room_Charges_daily_rate) desc
select max(v.Treatment_Cost + v.Medication_Cost + v.Room_Charges_daily_rate)
from visits v
--20.Identify which insurance provider covered the most procedures and their total costs.
select Provider_ID ,count(Procedure_ID) As 'No. Procedures',sum(v.Treatment_Cost + v.Medication_Cost + v.Room_Charges_daily_rate)
from visits v
group by Provider_ID
order by count(Procedure_ID) desc

--21.Find the top 3 providers with the highest average patient satisfaction scores.
select top 3 Provider_ID,AVG(Patient_Satisfaction_Score)
from visits
group by Provider_ID
order by AVG(Patient_Satisfaction_Score) desc



