
-- Таблица для хранения информации о поездах
CREATE TABLE Trains (
    TrainID SERIAL PRIMARY KEY,
    TrainNumber VARCHAR(10) NOT NULL,
    TotalSeatsPlatzkart INT NOT NULL,
    TotalSeatsCoupe INT NOT NULL,
    TotalSeatsSV INT NOT NULL
);

-- Таблица для хранения информации о станциях
CREATE TABLE Stations (
    StationID SERIAL PRIMARY KEY,
    StationName VARCHAR(50) NOT NULL,
    Location VARCHAR(100) NOT NULL
);

-- Таблица для хранения информации о маршрутах
CREATE TABLE Routes (
    RouteID SERIAL PRIMARY KEY,
    TrainID INT REFERENCES Trains(TrainID),
    DepartureStationID INT REFERENCES Stations(StationID),
    ArrivalStationID INT REFERENCES Stations(StationID),
    DepartureTime TIME NOT NULL,
    ArrivalTime TIME NOT NULL,
    TravelDate DATE NOT NULL,
    AvailableSeatsPlatzkart INT NOT NULL,
    AvailableSeatsCoupe INT NOT NULL,
    AvailableSeatsSV INT NOT NULL
);

-- Таблица для хранения информации об остановках на маршруте
CREATE TABLE RouteStops (
    RouteStopID SERIAL PRIMARY KEY,
    RouteID INT REFERENCES Routes(RouteID),
    StationID INT REFERENCES Stations(StationID),
    StopOrder INT NOT NULL,
    ArrivalTime TIME,
    DepartureTime TIME,
    IsCancelled BOOLEAN DEFAULT FALSE
);

-- Таблица для хранения информации об изменениях в расписании
CREATE TABLE ScheduleChanges (
    ChangeID SERIAL PRIMARY KEY,
    RouteID INT REFERENCES Routes(RouteID),
    ChangeType VARCHAR(50) NOT NULL,
    ChangeDescription TEXT,
    ChangeDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Таблица для хранения информации о пассажирах
CREATE TABLE Passengers (
    PassengerID SERIAL PRIMARY KEY,
    PassengerName VARCHAR(100) NOT NULL
);

-- Таблица для хранения информации о билетах
CREATE TABLE Tickets (
    TicketID SERIAL PRIMARY KEY,
    RouteID INT REFERENCES Routes(RouteID),
    SeatNumber INT NOT NULL,
    Class VARCHAR(20) NOT NULL,
    PassengerID INT REFERENCES Passengers(PassengerID),
    Status VARCHAR(20) NOT NULL
);

-- Таблица для хранения информации о пользователях
CREATE TABLE Users (
    UserID SERIAL PRIMARY KEY,
    UserType VARCHAR(20) NOT NULL,
    UserName VARCHAR(50) NOT NULL,
    Password VARCHAR(100) NOT NULL
);

-- Создание индексов для ускорения работы системы
CREATE INDEX idx_route_departure_station ON Routes(DepartureStationID);
CREATE INDEX idx_route_arrival_station ON Routes(ArrivalStationID);
CREATE INDEX idx_route_train ON Routes(TrainID);
CREATE INDEX idx_ticket_route ON Tickets(RouteID);
CREATE INDEX idx_ticket_passenger ON Tickets(PassengerID);
CREATE INDEX idx_routestop_route ON RouteStops(RouteID);
CREATE INDEX idx_routestop_station ON RouteStops(StationID);
CREATE INDEX idx_schedulechange_route ON ScheduleChanges(RouteID);
