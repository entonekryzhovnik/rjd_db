-- Отмена поезда

-- Обновление записи в таблице RouteStops
UPDATE RouteStops
SET IsCancelled = TRUE
WHERE RouteID = [route_id];

-- Добавление записи в таблицу ScheduleChanges
INSERT INTO ScheduleChanges (RouteID, ChangeType, ChangeDescription)
VALUES ([route_id], 'Отмена поезда', 'Поезд отменен на всем маршруте');


-- Отмена остановки на станции

-- Обновление записи в таблице RouteStops
UPDATE RouteStops
SET IsCancelled = TRUE
WHERE RouteID = [route_id] AND StationID = [station_id];

-- Добавление записи в таблицу ScheduleChanges
INSERT INTO ScheduleChanges (RouteID, ChangeType, ChangeDescription)
VALUES ([route_id], 'Отмена остановки', 'Отмена остановки на станции ');


-- Изменение даты/времени

-- Обновление записи в таблице Routes
UPDATE Routes
SET DepartureTime = '[new_departure_time]', ArrivalTime = '[new_arrival_time]'
WHERE RouteID = [route_id];

-- Добавление записи в таблицу ScheduleChanges
INSERT INTO ScheduleChanges (RouteID, ChangeType, ChangeDescription)
VALUES ([route_id], 'Изменение времени', 'Изменение времени отправления и прибытия');
