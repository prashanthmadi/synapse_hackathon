CREATE SCHEMA fhir

IF NOT EXISTS (SELECT * FROM sys.objects O JOIN sys.schemas S ON O.schema_id = S.schema_id WHERE O.NAME = 'Claim_main_hash' AND O.TYPE = 'U' AND S.NAME = 'fhir')
CREATE TABLE fhir.Claim_main_hash
	(
	 [claim_id] nvarchar(4000),
	 [resourceType] nvarchar(4000),
	 [status] nvarchar(4000),
	 [created] nvarchar(4000),
	 [isuse] nvarchar(4000),
	 [billablePeriod_end] nvarchar(4000),
	 [billablePeriod_start] nvarchar(4000),
	 [patient_display] nvarchar(4000),
	 [patient_reference] nvarchar(4000),
	 [prescription_reference] nvarchar(4000),
	 [provider_display] nvarchar(4000),
	 [provider_reference] nvarchar(4000),
	 [total_currency] nvarchar(4000),
	 [total_value] float
	)
WITH
	(
	DISTRIBUTION = HASH([patient_reference]),
	 CLUSTERED COLUMNSTORE INDEX
	 -- HEAP
	)
GO


CREATE  TABLE fhir.claim_diagnosis_hash (
	[claim_id] nvarchar(4000),
	[diagnosis_sequence] bigint,
	[diagnosis_diagnosisReference_reference] nvarchar(4000)
	)
	WITH (
	DISTRIBUTION = HASH([claim_id]),
	 CLUSTERED COLUMNSTORE INDEX
	)
GO


CREATE  TABLE fhir.claim_insurance_hash (
	[claim_id] nvarchar(4000),
	[insurance_focal] bit,
	[insurance_sequence] bigint,
	[insurance_coverage_display] nvarchar(4000)
	)
	WITH (
	DISTRIBUTION = HASH([claim_id]),
	 CLUSTERED COLUMNSTORE INDEX
	)
GO


CREATE  TABLE fhir.claim_procedure_hash (
	[claim_id] nvarchar(4000),
	[procedure_sequence] bigint,
	[procedure_procedureReference_reference] nvarchar(4000)
	)
	WITH (
	DISTRIBUTION = HASH([claim_id]),
	 CLUSTERED COLUMNSTORE INDEX
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
	DISTRIBUTION = ROUND_ROBIN,
	 CLUSTERED COLUMNSTORE INDEX
	 -- HEAP
	)
GO