-- Есть ли рейс из пункта А в пункт В на хх.хх число?

SELECT *
FROM Routes
WHERE DepartureStationID = (SELECT StationID FROM Stations WHERE StationName = 'A')
  AND ArrivalStationID = (SELECT StationID FROM Stations WHERE StationName = 'B')
  AND TravelDate = 'yyyy-mm-dd';
