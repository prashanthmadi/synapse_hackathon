IF NOT EXISTS (SELECT * FROM sys.objects O JOIN sys.schemas S ON O.schema_id = S.schema_id WHERE O.NAME = 'observation_main' AND O.TYPE = 'U' AND S.NAME = 'fhir')
CREATE TABLE fhir.observation_main
	(
	 [observation_id] nvarchar(4000),
	 [resourceType] nvarchar(4000),
	 [status] nvarchar(4000),
	 [issued] nvarchar(4000),
	 [effectiveDateTime] nvarchar(4000),
	 [valueString] nvarchar(4000),
	 [patient_reference] nvarchar(4000),
	 [encounter_reference] nvarchar(4000),
	 [valueQuantity_code] nvarchar(4000),
	 [valueQuantity_system] nvarchar(4000),
	 [valueQuantity_unit] nvarchar(4000),
	 [valueQuantity_value] float
	)
WITH
	(
	DISTRIBUTION = HASH([patient_reference]),
	 CLUSTERED COLUMNSTORE INDEX
	 -- HEAP
	)
GO

--Uncomment the 4 lines below to create a stored procedure for data pipeline orchestration​
--CREATE PROC bulk_load_observation_main
--AS
--BEGIN
EXECUTE AS USER = 'LoaderRC20';
COPY INTO fhir.observation_main
(observation_id 1, resourceType 2, status 3, issued 4, effectiveDateTime 5, valueString 6, patient_reference 7, encounter_reference 8, valueQuantity_code 9, valueQuantity_system 10, valueQuantity_unit 11, valueQuantity_value 12)
FROM 'https://prsynapselab.dfs.core.windows.net/silver/observation_main'
WITH
(
	FILE_TYPE = 'PARQUET'
	,MAXERRORS = 0
)
--END
GO

SELECT TOP 100 * FROM fhir.observation_main
GO