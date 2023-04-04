CREATE LOGIN LoaderRC20 WITH PASSWORD = 'a123STRONGpassword!';
CREATE USER LoaderRC20 FOR LOGIN LoaderRC20;

CREATE USER LoaderRC20 FOR LOGIN LoaderRC20;
GRANT CONTROL ON DATABASE::[prdedicatedsql] to LoaderRC20;
EXEC sp_addrolemember 'largerc', 'LoaderRC20';
-- Using largerc reduced it to 7min for claim_main_hash from unknown/over-night thing

EXECUTE AS USER = 'LoaderRC20';
COPY INTO fhir.Claim_main_hash
(claim_id 1, resourceType 2, status 3, created 4, isuse 5, billablePeriod_end 6, billablePeriod_start 7, patient_display 8, patient_reference 9, prescription_reference 10, provider_display 11, provider_reference 12, total_currency 13, total_value 14)
FROM 'https://prsynapselab.dfs.core.windows.net/silver/claim_main'
WITH
(
	FILE_TYPE = 'PARQUET'
	,MAXERRORS = 0
	,COMPRESSION = 'snappy'
)
--END
GO

EXECUTE AS USER = 'LoaderRC20';
COPY INTO fhir.claim_diagnosis_hash
(claim_id 1, diagnosis_sequence 2, diagnosis_diagnosisReference_reference 3)
FROM 'https://prsynapselab.dfs.core.windows.net/silver/claim_diagnosis'
WITH
(
	FILE_TYPE = 'PARQUET'
	,MAXERRORS = 0
)


EXECUTE AS USER = 'LoaderRC20';
COPY INTO fhir.claim_insurance_hash
(claim_id 1, insurance_focal 2, insurance_sequence 3, insurance_coverage_display 4)
FROM 'https://prsynapselab.dfs.core.windows.net/silver/claim_insurance'
WITH
(
	FILE_TYPE = 'PARQUET'
	,MAXERRORS = 0
)
--END
GO

EXECUTE AS USER = 'LoaderRC20';
COPY INTO fhir.claim_procedure_hash
(claim_id 1, procedure_sequence 2, procedure_procedureReference_reference 3)
FROM 'https://prsynapselab.dfs.core.windows.net/silver/claim_procedure'
WITH
(
	FILE_TYPE = 'PARQUET'
	,MAXERRORS = 0
)
--END
GO
