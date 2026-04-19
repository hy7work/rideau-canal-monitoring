SELECT
    location,
    System.Timestamp() AS windowEnd,
    AVG(iceThicknessCm) AS avgIceThicknessCm,
    MIN(iceThicknessCm) AS minIceThicknessCm,
    MAX(iceThicknessCm) AS maxIceThicknessCm,
    AVG(surfaceTemperatureC) AS avgSurfaceTemperatureC,
    MIN(surfaceTemperatureC) AS minSurfaceTemperatureC,
    MAX(surfaceTemperatureC) AS maxSurfaceTemperatureC,
    MAX(snowAccumulationCm) AS maxSnowAccumulationCm,
    AVG(externalTemperatureC) AS avgExternalTemperatureC,
    COUNT(*) AS readingCount,
    CASE
        WHEN AVG(iceThicknessCm) >= 30 AND AVG(surfaceTemperatureC) <= -5 THEN 'Safe'
        WHEN AVG(iceThicknessCm) >= 25 AND AVG(surfaceTemperatureC) <= -2 THEN 'Caution'
        ELSE 'Unsafe'
    END AS safetyStatus
INTO SensorAggregations
FROM iothub8916
GROUP BY
    location,
    TumblingWindow(minute, 5);


SELECT *
INTO historicaldata
FROM iothub8916
