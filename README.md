# База данных по продаже железнодорожных билетов по России 🚂💚
![rjd_db](https://github.com/entonekryzhovnik/rjd_db/assets/141041122/fa0879af-346f-488b-b711-193d3fa7bb89)


### 🚆 Trains 🚆
**Описание**: Содержит информацию о поездах, включая номер поезда и количество мест в различных классах.
- **TrainID** (PK) - уникальный идентификатор поезда.
- **TrainNumber** - номер поезда.
- **TotalSeatsPlatzkart** - количество мест в плацкартных вагонах.
- **TotalSeatsCoupe** - количество мест в купейных вагонах.
- **TotalSeatsSV** - количество мест в вагонах СВ.

**Пример записи**:

```sql
INSERT INTO Trains (TrainNumber, TotalSeatsPlatzkart, TotalSeatsCoupe, TotalSeatsSV)
VALUES ('123A', 100, 50, 20);
```

**Изменения**: Записи добавляются при вводе нового поезда. Изменения происходят при обновлении информации о поезде, например, при изменении количества мест.

### 🚉 Stations 🚉
**Описание**: Содержит информацию о станциях, включая название и местоположение.
- **StationID** (PK) - уникальный идентификатор станции.
- **StationName** - название станции.
- **Location** - местоположение станции.

**Пример записи**:

```sql
INSERT INTO Stations (StationName, Location)
VALUES ('Москва', 'Москва, Россия');
```

**Изменения**: Записи добавляются при добавлении новой станции. Изменения происходят при обновлении названия или местоположения станции.

### 🛤️ Routes 🛤️
**Описание**: Содержит информацию о маршрутах поездов, включая станции отправления и прибытия, время отправления и прибытия, дату поездки и доступные места.
- **RouteID** (PK) - уникальный идентификатор маршрута.
- **TrainID** (FK) - идентификатор поезда.
- **DepartureStationID** (FK) - идентификатор станции отправления.
- **ArrivalStationID** (FK) - идентификатор станции прибытия.
- **DepartureTime** - время отправления.
- **ArrivalTime** - время прибытия.
- **TravelDate** - дата поездки.
- **AvailableSeatsPlatzkart** - доступные места в плацкартных вагонах.
- **AvailableSeatsCoupe** - доступные места в купейных вагонах.
- **AvailableSeatsSV** - доступные места в вагонах СВ.

**Пример записи**:

```sql
INSERT INTO Routes (TrainID, DepartureStationID, ArrivalStationID, DepartureTime, ArrivalTime, TravelDate, AvailableSeatsPlatzkart, AvailableSeatsCoupe, AvailableSeatsSV)
VALUES (1, 1, 2, '10:00', '14:00', '2024-06-10', 100, 50, 20);
```

**Изменения**: Записи добавляются при создании нового маршрута. Изменения происходят при обновлении расписания, доступных мест или другой информации о маршруте.

🗂️**Индексы**: 

   **DepartureStationID**
     ```sql
    CREATE INDEX idx_route_departure_station ON Routes(DepartureStationID);
     ```
-  **Почему?**: Этот индекс нужен для ускорения поиска маршрутов, которые начинаются с определенной станции. Частые запросы могут включать:
     ```sql
      SELECT * FROM Routes WHERE DepartureStationID = ?;
     ```
-  **Пример использования**: Когда кассир или система ищет рейсы, отправляющиеся из конкретного пункта, чтобы предложить пассажирам доступные варианты.

   **ArrivalStationID**
     ```sql
    CREATE INDEX idx_route_arrival_station ON Routes(ArrivalStationID);
     ```
-  **Почему?**: Этот индекс ускоряет поиск маршрутов, которые заканчиваются на определенной станции. Частые запросы могут включать:
     ```sql
      SELECT * FROM Routes WHERE ArrivalStationID = ?;
     ```
-  **Пример использования**: Когда кассир или система ищет рейсы, прибывающие в конкретный пункт.

   **TrainID**
     ```sql
    CREATE INDEX idx_route_train ON Routes(TrainID);
     ```
-  **Почему?**: Этот индекс нужен для ускорения поиска маршрутов, связанных с определенным поездом. Частые запросы могут включать:
     ```sql
      SELECT * FROM Routes WHERE TrainID = ?;
     ```
-  **Пример использования**: Когда необходимо найти все маршруты, обслуживаемые конкретным поездом.


### 🏙️ RouteStops 🏙️
**Описание**: Содержит информацию об остановках на маршруте, включая станцию остановки, порядок остановки, время прибытия и отправления, а также статус отмены остановки.
- **RouteStopID** (PK) - уникальный идентификатор остановки на маршруте.
- **RouteID** (FK) - идентификатор маршрута.
- **StationID** (FK) - идентификатор станции.
- **StopOrder** - порядок остановки.
- **ArrivalTime** - время прибытия на остановку.
- **DepartureTime** - время отправления с остановки.
- **IsCancelled** - флаг отмены остановки.

**Пример записи**:

```sql
INSERT INTO RouteStops (RouteID, StationID, StopOrder, ArrivalTime, DepartureTime, IsCancelled)
VALUES (1, 1, 1, '10:00', '10:10', FALSE);
```

**Изменения**: Записи добавляются при добавлении новой остановки на маршрут. Изменения происходят при обновлении времени остановки или при отмене остановки.

🗂️**Индексы**: 

 - **RouteID**
    ```sql
    CREATE INDEX idx_routestop_route ON RouteStops(RouteID);
    ```
    - **Почему?**: Этот индекс ускоряет поиск остановок по маршруту. Частые запросы могут включать:
    ```sql
      SELECT * FROM RouteStops WHERE RouteID = ?;
    ```
    - **Пример использования**: Когда необходимо найти все остановки на маршруте, чтобы показать полное расписание.

  **StationID**
    ```sql
    CREATE INDEX idx_routestop_station ON RouteStops(StationID);
     ```
- **Почему?**: Этот индекс ускоряет поиск остановок на конкретной станции. Частые запросы могут включать:
    ```sql
      SELECT * FROM RouteStops WHERE StationID = ?;
    ```
- **Пример использования**: Когда необходимо найти все маршруты, проходящие через конкретную станцию.

### 🛠️ ScheduleChanges 🛠️
**Описание**: Содержит информацию об изменениях в расписании маршрутов, включая тип и описание изменения, а также дату изменения.
- **ChangeID** (PK) - уникальный идентификатор изменения.
- **RouteID** (FK) - идентификатор маршрута.
- **ChangeType** - тип изменения (например, отмена остановки, изменение времени).
- **ChangeDescription** - описание изменения.
- **ChangeDate** - дата изменения.

**Пример записи**:

```sql
INSERT INTO ScheduleChanges (RouteID, ChangeType, ChangeDescription, ChangeDate)
VALUES (1, 'Отмена остановки', 'Отмена остановки на станции ID 1', '2024-06-01 10:00:00');
```

**Изменения**: Записи добавляются при любом изменении расписания маршрута.

🗂️**Индексы**: 

  **RouteID**
    ```sql
    CREATE INDEX idx_schedulechange_route ON ScheduleChanges(RouteID);
    ```
- **Почему?**: Этот индекс ускоряет поиск изменений расписания по маршруту. Частые запросы могут включать:
    ```sql
      SELECT * FROM ScheduleChanges WHERE RouteID = ?;
    ```
- **Пример использования**: Когда необходимо отобразить все изменения в расписании для конкретного маршрута, например, для информирования пассажиров о задержках или отменах.




### 👬 Passengers 👬
**Описание**: Содержит информацию о пассажирах, включая имя пассажира.
- **PassengerID** (PK) - уникальный идентификатор пассажира.
- **PassengerName** - имя пассажира.

**Пример записи**:

```sql
INSERT INTO Passengers (PassengerName)
VALUES ('Иван Иванов');
```

**Изменения**: Записи добавляются при регистрации нового пассажира. Изменения происходят при обновлении информации о пассажире.

### 🎫 Tickets 🎫
**Описание**: Содержит информацию о билетах, включая маршрут, номер места, класс билета, пассажира и статус билета.
- **TicketID** (PK) - уникальный идентификатор билета.
- **RouteID** (FK) - идентификатор маршрута.
- **SeatNumber** - номер места.
- **Class** - класс места (плацкарт, купе, СВ).
- **PassengerID** (FK) - идентификатор пассажира.
- **Status** - статус билета (свободен, продан).

**Пример записи**:

```sql
INSERT INTO Tickets (RouteID, SeatNumber, Class, PassengerID, Status)
VALUES (1, 1, 'плацкарт', NULL, 'свободен');
```

**Изменения**: Записи добавляются при создании нового билета. Изменения происходят при покупке или возврате билета, а также при изменении статуса билета.

🗂️**Индексы**: 

  **RouteID**
     ```sql
    CREATE INDEX idx_ticket_route ON Tickets(RouteID);
    ```
- **Почему?**: Этот индекс ускоряет поиск билетов по маршруту. Частые запросы могут включать:
    ```sql
      SELECT * FROM Tickets WHERE RouteID = ?;
    ```
- **Пример использования**: Когда необходимо найти все билеты для конкретного маршрута, например, чтобы проверить занятость мест на рейсе.

  **PassengerID**
    ```sql
    CREATE INDEX idx_ticket_passenger ON Tickets(PassengerID);
    ```
- **Почему?**: Этот индекс ускоряет поиск билетов, связанных с конкретным пассажиром. Частые запросы могут включать:
    ```sql
      SELECT * FROM Tickets WHERE PassengerID = ?;
    ```
- **Пример использования**: Когда необходимо найти все билеты, купленные конкретным пассажиром, например, для истории покупок или для обработки возвратов.


### 👤 Users 👤
**Описание**: Содержит информацию о пользователях системы, включая тип пользователя, имя и пароль.
- **UserID** (PK) - уникальный идентификатор пользователя.
- **UserType** - тип пользователя (кассир, администратор).
- **UserName** - имя пользователя.
- **Password** - пароль пользователя.

**Пример записи**:

```sql
INSERT INTO Users (UserType, UserName, Password)
VALUES ('кассир', 'kassir1', 'password1');
```

**Изменения**: Записи добавляются при создании нового пользователя. Изменения происходят при обновлении информации о пользователе или смене пароля.

## Связи между объектами

- **Routes**:
    - Связь с **Trains** через `TrainID` (многие к одному).
    - Связь с **Stations** через `DepartureStationID` и `ArrivalStationID` (многие к одному).
    - Связь с **RouteStops** через `RouteID` (один ко многим).
    - Связь с **ScheduleChanges** через `RouteID` (один ко многим).
    - Связь с **Tickets** через `RouteID` (один ко многим).
- **RouteStops**:
    - Связь с **Routes** через `RouteID` (многие к одному).
    - Связь с **Stations** через `StationID` (многие к одному).
- **ScheduleChanges**:
    - Связь с **Routes** через `RouteID` (многие к одному).
- **Tickets**:
    - Связь с **Routes** через `RouteID` (многие к одному).
    - Связь с **Passengers** через `PassengerID` (многие к одному).

##  Ключевые атрибуты (PK/FK)

| Первичные ключи (PK): | Внешние ключи (FK): |
| --- | --- |
| • TrainID в Trains |  • TrainID в Routes ссылается на TrainID в Trains |
|• StationID в Stations | • DepartureStationID в Routes ссылается на StationID в Stations |
|• RouteID в Routes |  • ArrivalStationID в Routes ссылается на StationID в Stations |
|• RouteStopID в RouteStops | • RouteID в RouteStops ссылается на RouteID в Routes |
|• ChangeID в ScheduleChanges | • StationID в RouteStops ссылается на StationID в Stations |
|• PassengerID в Passengers | • RouteID в ScheduleChanges ссылается на RouteID в Routes |
|• TicketID в Tickets | • RouteID в Tickets ссылается на RouteID в Routes |
|• UserID в Users | • PassengerID в Tickets ссылается на PassengerID в Passengers |
