IF NOT EXISTS (SELECT * FROM sys.external_file_formats WHERE name = 'SynapseParquetFormat') 
	CREATE EXTERNAL FILE FORMAT [SynapseParquetFormat] 
	WITH ( FORMAT_TYPE = PARQUET)
GO

IF NOT EXISTS (SELECT * FROM sys.external_data_sources WHERE name = 'silver_prsynapselab_dfs_core_windows_net') 
	CREATE EXTERNAL DATA SOURCE [silver_prsynapselab_dfs_core_windows_net] 
	WITH (
		LOCATION = 'abfss://silver@prsynapselab.dfs.core.windows.net' 
	)
GO

CREATE TABLE fhir.patientIdentifier (
	[patient_id] nvarchar(4000),
	[birthDate] nvarchar(4000),
	[deceasedDateTime] nvarchar(4000),
	[gender] nvarchar(4000),
	[multipleBirthBoolean] bit,
	[multipleBirthInteger] bigint,
	[resourceType] nvarchar(4000),
	[div] nvarchar(4000),
	[status] nvarchar(4000),
	[text_div] nvarchar(4000),
	[text_status] nvarchar(4000),
	[identifier_system] nvarchar(4000),
	[identifier_value] nvarchar(4000),
	[identifier_type_text] nvarchar(4000),
	[identifier_type_coding_code] nvarchar(4000),
	[identifier_type_coding_display] nvarchar(4000),
	[identifier_type_coding_system] nvarchar(4000)
	)
	WITH (
	LOCATION = 'PatientIdentifier',
	DATA_SOURCE = [silver_prsynapselab_dfs_core_windows_net],
	FILE_FORMAT = [SynapseParquetFormat]
	)
GO


SELECT TOP 100 * FROM fhir.patientIdentifier
GO