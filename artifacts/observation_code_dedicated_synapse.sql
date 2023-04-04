IF NOT EXISTS (SELECT * FROM sys.objects O JOIN sys.schemas S ON O.schema_id = S.schema_id WHERE O.NAME = 'observation_code' AND O.TYPE = 'U' AND S.NAME = 'fhir')
CREATE TABLE fhir.observation_code
	(
	 [observation_id] nvarchar(4000),
	 [code_text] nvarchar(4000),
	 [code_coding_code] nvarchar(4000),
	 [code_coding_display] nvarchar(4000),
	 [code_coding_system] nvarchar(4000)
	)
WITH
	(
	DISTRIBUTION = HASH([observation_id]),
	 CLUSTERED COLUMNSTORE INDEX
	 -- HEAP
	)
GO

--Uncomment the 4 lines below to create a stored procedure for data pipeline orchestration​
--CREATE PROC bulk_load_observation_code
--AS
--BEGIN
EXECUTE AS USER = 'LoaderRC20';
COPY INTO fhir.observation_code
(observation_id 1, code_text 2, code_coding_code 3, code_coding_display 4, code_coding_system 5)
FROM 'https://prsynapselab.dfs.core.windows.net/silver/observation_code'
WITH
(
	FILE_TYPE = 'PARQUET'
	,MAXERRORS = 0
)
--END
GO

SELECT TOP 100 * FROM fhir.observation_code
GO