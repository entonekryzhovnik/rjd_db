-- В какое время прибывает рейс №Х на станции А?

SELECT RouteStops.ArrivalTime
FROM Routes
JOIN RouteStops ON Routes.RouteID = RouteStops.RouteID
WHERE Routes.TrainID = (SELECT TrainID FROM Trains WHERE TrainNumber = 'X')
  AND RouteStops.StationID = (SELECT StationID FROM Stations WHERE StationName = 'A');
