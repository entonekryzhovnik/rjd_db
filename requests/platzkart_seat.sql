-- Есть ли плацкартное место на рейс №Х из пункта А в пункт В на хх.хх число?

SELECT *
FROM Routes
WHERE TrainID = (SELECT TrainID FROM Trains WHERE TrainNumber = 'X')
  AND DepartureStationID = (SELECT StationID FROM Stations WHERE StationName = 'A')
  AND ArrivalStationID = (SELECT StationID FROM Stations WHERE StationName = 'B')
  AND TravelDate = 'yyyy-mm-dd'
  AND AvailableSeatsPlatzkart > 0;
