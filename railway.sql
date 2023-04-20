create database Project;
use project

create table Account 
(
    Username varchar(15) NOT NULL, 
    Password varchar(20) NOT NULL,
    email_ID varchar(35) NOT NULL,
    Address varchar(50) DEFAULT NULL,
    PRIMARY KEY(Username)
);

create table Contact
(
    Username varchar(15) NOT NULL DEFAULT '',
    Contact_Number char(10) NOT NULL DEFAULT '',
    PRIMARY KEY(Username,Contact_Number),
    CONSTRAINT Contact_ibfk_1 FOREIGN KEY (Username) REFERENCES Account(Username) ON DELETE CASCADE
);

create table Train 
(
    Train_Number char(6) NOT NULL DEFAULT '0',
    Train_Name varchar(25) NOT NULL,
    Seat_Sleeper char(4) NOT NULL,
    Seat_First_Class char(4) NOT NULL,
    Seat_Second_Class char(4) NOT NULL,
    Seat_Third_Class char(4) NOT NULL,
    WiFi char(3) NOT NULL,
    Food char(3) NOT NULL,
    Run_On_Sunday char(3) NOT NULL,
    Run_On_Monday char(3) NOT NULL,
    Run_On_Tuesday char(3) NOT NULL,
    Run_On_Wednesday char(3) NOT NULL,
    Run_On_Thursday char(3) NOT NULL,
    Run_On_Friday char(3) NOT NULL,
    Run_On_Saturday char(3) NOT NULL,
    PRIMARY KEY (Train_Number)
);

create table Ticket 
(
    Ticket_Number char(10) NOT NULL,
    Train_Number char(6) NOT NULL,
    Date_Of_Journey DATE NOT NULL,
    Username varchar(15) NOT NULL
    PRIMARY KEY (Ticket_Number),
    CONSTRAINT Ticket_ibfk_1 FOREIGN KEY (Username) REFERENCES Account(Username) ON DELETE CASCADE,
    CONSTRAINT Ticket_ibfk_2 FOREIGN KEY (Train_Number) REFERENCES Train(Train_Number) ON UPDATE CASCADE 
);

create table Passenger 
(
    Passenger_id varchar(12) NOT NULL,
    First_Name varchar(15) NOT NULL,
    Last_Name varchar(15) NOT NULL,
    Date_Of_Birth DATE NOT NULL,
    Gender varchar(1) NOT NULL,
    Contact_Number char(10) DEFAULT NULL,
    Ticket_Number char(10) NULL,
    Class varchar(10) NOT NULL,
    PRIMARY KEY (Passenger_id),
    CONSTRAINT Passenger_ibfk_1 FOREIGN KEY (Ticket_Number) REFERENCES Ticket(Ticket_Number) ON DELETE CASCADE
);

create table Station 
(
    Station_Code varchar(5) NOT NULL DEFAULT '',
    Station_Name varchar(25) NOT NULL,
    PRIMARY KEY (Station_Code)
);


create table Departure
(
    Station_Code varchar(5) NOT NULL DEFAULT '',
    Train_Number char(6) NOT NULL DEFAULT '0',
    Arrival_Time TIME DEFAULT NULL,
    Departure_Time TIME DEFAULT NULL,
    PRIMARY KEY (Station_Code,Train_Number),
    CONSTRAINT Departure_ibfk_1 FOREIGN KEY (Train_Number) REFERENCES Train (Train_Number) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT Departure_ibfk_2 FOREIGN KEY (Station_Code) REFERENCES Station (Station_Code) ON DELETE CASCADE ON UPDATE CASCADE
); 

insert into Account values 
('akhil55','agfndjgkynsb','akhil@gmail.com','Airport Road,Shamshabad'),
('vikky24','ehgjdhnmjh','vikky@gmail.com','NGOs Colony,Warangal'),
('aasiya41','fdhsfnkgnk','aasiya@gmail.com','HBS Colony,Warangal'),
('prathima33','fghsgnnbg','prathima@gmail.com','VNR Colony,Hyderabad'),
('rajesh12','kghjgfbfh8nn','rajesh@gmail.com','SVS Mall Road,Chennai'),
('gokul','rebjbmmss','gokul@gmail.com','Uppal Hyderabad');

insert into Contact values 
('aasiya41','1234567890'),
('akhil55','2345678901'),
('gokul','3456789012'),
('prathima33','4567890123'),
('rajesh12','5678901234'),
('vikky24','6789012345');


insert into Train values 
('17406','Krishna Express','432','49','98','185','No','Yes',
'Yes','Yes','Yes','Yes','Yes','Yes','Yes'),
('17405','Krishna Express','432','49','98','185','No','Yes',
'Yes','Yes','Yes','Yes','Yes','Yes','Yes'),
('12764','Padmavathi SF Express','425','47','95','194','No','No',
'Yes','Yes','Yes','No','Yes','Yes','No'),
('12763','Padmavathi SF Express','425','47','95','194','No','No',
'Yes','Yes','Yes','No','Yes','Yes','No');



insert into Station values 
('SC','Secunderabad Junction'),
('ALER','Aler'),
('ZN','Jangaon'),
('KZJ','Kazipet Junction'),
('WL','Warangal'),
('MABD','Mahbubabad'),
('KMT','Khammam'),
('BZA','Vijayawada Junction'),
('OGL','Ongole'),
('NLR','Nellore'),
('GDR','Gudur Junction'),
('RU','Renigunta Junction'),
('TPTY','Tirupati');

insert into Departure values 
('TPTY','12763','16:00:00','17:00:00'),
('RU','12763','17:18:00','17:20:00'),
('OGL','12763','21:03:00','21:05:00'),
('BZA','12763','23:15:00','23:20:00'),
('WL','12763','02:28:00','02:30:00'),
('KZJ','12763','02:43:00','02:45:00'),
('SC','12763','05:45:00','05:50:00'),

('TPTY','17405','05:00:00','05:50:00'),
('NLR','17405','07:54:00','07:55:00'),
('BZA','17405','13:00:00','13:10:00'),
('MABD','17405','15:44:00','15:45:00'),
('WL','17405','16:41:00','16:42:00'),
('KZJ','17405','16:56:00','16:58:00'),
('SC','17405','20:25:00','20:30:00'),

('SC','17406','05:40:00','06:00:00'),
('KZJ','17406','08:10:00','08:13:00'),
('WL','17406','08:32:00','08:34:00'),
('BZA','17406','12:50:00','13:00:00'),
('TPTY','17406','21:45:00','21:50:00'),

('SC','12764','18:00:00','18:40:00'),
('WL','12764','20:43:00','20:45:00'),
('BZA','12764','00:10:00','00:20:00'),
('RU','12764','06:58:00','06:00:00'),
('TPTY','12764','06:45:00','17:55:00');


select a.Train_Number from Departure as a join Departure as b on a.Train_Number = b.Train_Number
where a.Station_Code = 'WL' and b.Station_Code = 'RU' ;

drop trigger cancellation;
insert into Passenger values ('1','user','admin','1988-11-25','M','9854123670','10','First ');

delimeter //
create trigger cancellation
  before delete on ticket
  for each row 
BEGIN 
  set @TrainNumber=old.Train_Number;
  set @TicketNumber=old.Ticket_Number;
  set @Class=(select p.class from Passenger p where p.Ticket_Number=@ticketNumber);
  if @Class='First' THEN
    UPDATE Train set Seat_First_Class=Seat_First_Class+1 where Train_Number=@TrainNumber;
  elseif @class='Sleeper' then        
    UPDATE Train set Seat_Sleeper = Seat_Sleeper+1 WHERE Train_Number = @TrainNumber;   
  elseif @class='Second' then       
    UPDATE Train set Seat_Second_Class = Seat_Second_Class+1 WHERE Train_Number = @TrainNumber ;    
  elseif @class='Third' then        
    UPDATE Train set Third_Class = Seat_Third_Class+1 WHERE Train_Number = @TrainNumber ;      
  end if;
END //
delimeter;

