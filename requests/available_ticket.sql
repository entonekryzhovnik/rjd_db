-- Есть ли билет из пункта А в пункт В на хх.хх число?

SELECT *
FROM Tickets
WHERE RouteID IN (
    SELECT RouteID
    FROM Routes
    WHERE DepartureStationID = (SELECT StationID FROM Stations WHERE StationName = 'A')
      AND ArrivalStationID = (SELECT StationID FROM Stations WHERE StationName = 'B')
      AND TravelDate = 'yyyy-mm-dd'
)
  AND Status = 'свободен';
