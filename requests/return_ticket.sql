-- Возврат билета

-- Обновление статуса билета и удаление привязки пассажира
UPDATE Tickets
SET Status = 'свободен', PassengerID = NULL
WHERE TicketID = [ticket_id];

-- Обновление количества доступных мест в маршруте
WITH TicketInfo AS (
    SELECT RouteID, Class
    FROM Tickets
    WHERE TicketID = [ticket_id]
)
UPDATE Routes
SET AvailableSeatsPlatzkart = CASE WHEN TicketInfo.Class = 'плацкарт' THEN AvailableSeatsPlatzkart + 1 ELSE AvailableSeatsPlatzkart END,
    AvailableSeatsCoupe = CASE WHEN TicketInfo.Class = 'купе' THEN AvailableSeatsCoupe + 1 ELSE AvailableSeatsCoupe END,
    AvailableSeatsSV = CASE WHEN TicketInfo.Class = 'СВ' THEN AvailableSeatsSV + 1 ELSE AvailableSeatsSV END
FROM TicketInfo
WHERE Routes.RouteID = TicketInfo.RouteID;
