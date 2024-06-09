-- Какие изменения в расписании для рейса №Х на хх.хх число?

SELECT *
FROM ScheduleChanges
WHERE RouteID IN (
    SELECT RouteID
    FROM Routes
    WHERE TrainID = (SELECT TrainID FROM Trains WHERE TrainNumber = 'X')
      AND TravelDate = 'yyyy-mm-dd'
);
