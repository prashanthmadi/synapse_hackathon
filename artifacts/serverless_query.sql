SELECT TOP(10) created, YEAR(created)  FROM [fhir].[dbo].[claim_main_hash]

SELECT TOP(1000) * FROM [fhir].[dbo].[patientidentifier] as patient
where patient.gender = 'male' and ((YEAR(GETDATE()) - YEAR(CONVERT(date,patient.birthDate))) > 18 and (YEAR(GETDATE()) - YEAR(CONVERT(date,patient.birthDate)))< 25)



SELECT patient_reference as patient_id, count(patient_reference) as count_claims FROM [fhir].[dbo].[claim_main_hash]  as claims
LEFT join [fhir].[dbo].[patientidentifier] as patient 
on claims.patient_reference = patient.patient_id
where patient.gender = 'male' and ((YEAR(GETDATE()) - YEAR(CONVERT(date,patient.birthDate))) > 18 and (YEAR(GETDATE()) - YEAR(CONVERT(date,patient.birthDate)))< 25) and YEAR(claims.created) > 2020
group by patient_reference
-- took 4 minutes