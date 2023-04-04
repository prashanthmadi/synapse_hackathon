IF NOT EXISTS (SELECT * FROM sys.objects O JOIN sys.schemas S ON O.schema_id = S.schema_id WHERE O.NAME = 'observation_category_hash' AND O.TYPE = 'U' AND S.NAME = 'fhir')
CREATE TABLE fhir.observation_category_hash
	(
	 [observation_id] nvarchar(4000),
	 [category_coding_code] nvarchar(4000),
	 [category_coding_display] nvarchar(4000),
	 [category_coding_system] nvarchar(4000)
	)
WITH
	(
	DISTRIBUTION = HASH([observation_id]),
	 CLUSTERED COLUMNSTORE INDEX
	 -- HEAP
	)
GO

--Uncomment the 4 lines below to create a stored procedure for data pipeline orchestration​
--CREATE PROC bulk_load_observation_category_hash
--AS
--BEGIN
EXECUTE AS USER = 'LoaderRC20';
COPY INTO fhir.observation_category_hash
(observation_id 1, category_coding_code 2, category_coding_display 3, category_coding_system 4)
FROM 'https://prsynapselab.dfs.core.windows.net/silver/observation_category'
WITH
(
	FILE_TYPE = 'PARQUET'
	,MAXERRORS = 0
)
--END
GO

SELECT TOP 100 * FROM fhir.observation_category_hash
GO