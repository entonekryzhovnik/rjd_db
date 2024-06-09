-- Вставка записей в таблицу Trains
INSERT INTO Trains (TrainNumber, TotalSeatsPlatzkart, TotalSeatsCoupe, TotalSeatsSV) 
VALUES 
('123A', 100, 50, 20),
('456B', 80, 40, 10),
('789C', 120, 60, 30);

-- Вставка записей в таблицу Stations
INSERT INTO Stations (StationName, Location) 
VALUES 
('Москва', 'Москва, Россия'),
('Санкт-Петербург', 'Санкт-Петербург, Россия'),
('Нижний Новгород', 'Нижний Новгород, Россия'),
('Казань', 'Казань, Россия'),
('Екатеринбург', 'Екатеринбург, Россия');

-- Вставка записей в таблицу Routes
INSERT INTO Routes (TrainID, DepartureStationID, ArrivalStationID, DepartureTime, ArrivalTime, TravelDate, AvailableSeatsPlatzkart, AvailableSeatsCoupe, AvailableSeatsSV) 
VALUES 
(1, 1, 2, '10:00', '14:00', '2024-06-10', 100, 50, 20),
(1, 1, 3, '08:00', '12:00', '2024-06-10', 100, 50, 20),
(2, 2, 3, '15:00', '19:00', '2024-06-11', 80, 40, 10),
(2, 1, 4, '09:00', '17:00', '2024-06-12', 80, 40, 10),
(3, 4, 5, '06:00', '18:00', '2024-06-13', 120, 60, 30);

-- Вставка записей в таблицу RouteStops
INSERT INTO RouteStops (RouteID, StationID, StopOrder, ArrivalTime, DepartureTime, IsCancelled) 
VALUES 
(1, 1, 1, '10:00', '10:10', FALSE),
(1, 3, 2, '12:00', '12:10', FALSE),
(1, 2, 3, '14:00', '14:10', FALSE),
(2, 1, 1, '08:00', '08:10', FALSE),
(2, 3, 2, '11:00', '11:10', FALSE),
(2, 2, 3, '13:00', '13:10', FALSE),
(3, 1, 1, '15:00', '15:10', FALSE),
(3, 4, 2, '16:00', '16:10', FALSE),
(4, 1, 1, '09:00', '09:10', FALSE),
(4, 2, 2, '11:00', '11:10', FALSE),
(4, 4, 3, '13:00', '13:10', FALSE),
(5, 4, 1, '06:00', '06:10', FALSE),
(5, 5, 2, '12:00', '12:10', FALSE);

-- Вставка записей в таблицу Passengers
INSERT INTO Passengers (PassengerName) 
VALUES 
('Иван Иванов'),
('Петр Петров'),
('Сергей Сергеев'),
('Алексей Алексеев'),
('Мария Смирнова');

-- Вставка записей в таблицу Tickets
INSERT INTO Tickets (RouteID, SeatNumber, Class, PassengerID, Status) 
VALUES 
(1, 1, 'плацкарт', NULL, 'свободен'),
(1, 2, 'купе', 2, 'продан'),
(2, 1, 'СВ', NULL, 'свободен'),
(3, 1, 'плацкарт', 3, 'продан'),
(4, 5, 'купе', 4, 'продан'),
(5, 10, 'плацкарт', 5, 'продан');

-- Вставка записей в таблицу Users
INSERT INTO Users (UserType, UserName, Password) 
VALUES 
('кассир', 'kassir1', 'password1'),
('администратор', 'admin1', 'password2');
