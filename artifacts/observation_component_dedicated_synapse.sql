IF NOT EXISTS (SELECT * FROM sys.objects O JOIN sys.schemas S ON O.schema_id = S.schema_id WHERE O.NAME = 'observation_component' AND O.TYPE = 'U' AND S.NAME = 'fhir')
CREATE TABLE fhir.observation_component
	(
	 [observation_id] nvarchar(4000),
	 [component_code_text] nvarchar(4000),
	 [component_valueQuantity_code] nvarchar(4000),
	 [component_valueQuantity_system] nvarchar(4000),
	 [component_valueQuantity_unit] nvarchar(4000),
	 [component_valueQuantity_value] float,
	 [component_code_coding_code] nvarchar(4000),
	 [component_code_coding_display] nvarchar(4000),
	 [component_code_coding_system] nvarchar(4000)
	)
WITH
	(
	DISTRIBUTION = HASH([observation_id]),
	 CLUSTERED COLUMNSTORE INDEX
	 -- HEAP
	)
GO

--Uncomment the 4 lines below to create a stored procedure for data pipeline orchestration​
--CREATE PROC bulk_load_observation_component
--AS
--BEGIN
EXECUTE AS USER = 'LoaderRC20';
COPY INTO fhir.observation_component
(observation_id 1, component_code_text 2, component_valueQuantity_code 3, component_valueQuantity_system 4, component_valueQuantity_unit 5, component_valueQuantity_value 6, component_code_coding_code 7, component_code_coding_display 8, component_code_coding_system 9)
FROM 'https://prsynapselab.dfs.core.windows.net/silver/observation_component'
WITH
(
	FILE_TYPE = 'PARQUET'
	,MAXERRORS = 0
)
--END
GO

SELECT TOP 100 * FROM fhir.observation_component
GO