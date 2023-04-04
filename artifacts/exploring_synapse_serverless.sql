SELECT   TOP 100 *
FROM
    OPENROWSET(
        BULK 'abfss://bronze@prsynapselab.dfs.core.windows.net/historic_data/observation/year=2016/*.json',
        FORMAT = 'CSV',
        FIELDQUOTE = '0x0b',
        FIELDTERMINATOR ='0x0b'
    )
    WITH (
        line varchar(max)
    ) AS [result]


/* refreence: https://diangermishuizen.com/query-json-data-in-sql-server-and-synapse-analytics/ */
SELECT top 10
    JSON_VALUE(line, '$.resourceType') AS resourceType,
    JSON_VALUE(line, '$.id') AS id,
    JSON_VALUE(line, '$.status') AS status,
    JSON_query(line, '$.insurance') AS insurance_string ,
    JSON_query(line, '$.type') AS code_type_string
FROM
    OPENROWSET(
        BULK 'abfss://bronze@prsynapselab.dfs.core.windows.net/historic_data/claim/year=2016/*.json',
        FORMAT = 'CSV',
        FIELDQUOTE = '0x0b',
        FIELDTERMINATOR ='0x0b'
    )
    WITH (
        line varchar(max)
    ) AS [result]



SELECT top 10
    JSON_VALUE(line, '$.resourceType') AS resourceType,
    JSON_VALUE(line, '$.id') AS id,
    JSON_VALUE(line, '$.status') AS status,
    JSON_query(line, '$.insurance') AS insurance_string ,
    JSON_query(line, '$.type') AS code_type_string,
    display
FROM
    OPENROWSET(
        BULK 'abfss://bronze@prsynapselab.dfs.core.windows.net/historic_data/claim/year=2016/*.json',
        FORMAT = 'CSV',
        FIELDQUOTE = '0x0b',
        FIELDTERMINATOR ='0x0b'
    )
    WITH (
        line varchar(max)
    ) AS [result]
CROSS APPLY OPENJSON
(JSON_Query([line],'$.insurance'))  -- spent 30mins on insurance typo
WITH(
    [display] varchar(255) '$.coverage.display'
) AS [coverage_array]



