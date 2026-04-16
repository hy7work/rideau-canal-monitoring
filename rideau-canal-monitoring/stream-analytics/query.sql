WITH AggregatedReadings AS (
    SELECT
        input.location,
        System.Timestamp() AS windowEnd,
        AVG(CAST(input.iceThicknessCm AS float)) AS avgIceThicknessCm,
        MIN(CAST(input.iceThicknessCm AS float)) AS minIceThicknessCm,
        MAX(CAST(input.iceThicknessCm AS float)) AS maxIceThicknessCm,
        AVG(CAST(input.surfaceTemperatureC AS float)) AS avgSurfaceTemperatureC,
        MIN(CAST(input.surfaceTemperatureC AS float)) AS minSurfaceTemperatureC,
        MAX(CAST(input.surfaceTemperatureC AS float)) AS maxSurfaceTemperatureC,
        MAX(CAST(input.snowAccumulationCm AS float)) AS maxSnowAccumulationCm,
        AVG(CAST(input.externalTemperatureC AS float)) AS avgExternalTemperatureC,
        COUNT(*) AS readingCount
    FROM iothubinput input
    TIMESTAMP BY input.timestamp
    GROUP BY
        input.location,
        TumblingWindow(minute, 5)
)

SELECT
    CONCAT(location, '-', FORMATDATETIME(windowEnd, 'yyyyMMddHHmmss')) AS id,
    location,
    windowEnd,
    avgIceThicknessCm,
    minIceThicknessCm,
    maxIceThicknessCm,
    avgSurfaceTemperatureC,
    minSurfaceTemperatureC,
    maxSurfaceTemperatureC,
    maxSnowAccumulationCm,
    avgExternalTemperatureC,
    readingCount,
    CASE
        WHEN avgIceThicknessCm >= 30 AND avgSurfaceTemperatureC <= -2 THEN 'Safe'
        WHEN avgIceThicknessCm >= 25 AND avgSurfaceTemperatureC <= 0 THEN 'Caution'
        ELSE 'Unsafe'
    END AS safetyStatus
INTO cosmosoutput
FROM AggregatedReadings;

SELECT *
INTO bloboutput
FROM AggregatedReadings;
