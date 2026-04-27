------------------------------------------------------------
-- ?? XÓA DATABASE C? (n?u có) & T?O L?I
------------------------------------------------------------
IF DB_ID('MarathonPRJ') IS NOT NULL
BEGIN
    ALTER DATABASE MarathonPRJ SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE MarathonPRJ;
END;
GO

CREATE DATABASE MarathonPRJ;
GO

USE MarathonPRJ;
GO

------------------------------------------------------------
-- 1?? B?NG ROLE
------------------------------------------------------------
CREATE TABLE [Role] (
    RoleID   INT IDENTITY(1,1) PRIMARY KEY,
    RoleName NVARCHAR(50) NOT NULL
);
GO

------------------------------------------------------------
-- 2?? B?NG ACCOUNT
------------------------------------------------------------
CREATE TABLE [Account] (
    uID            INT IDENTITY(1,1) PRIMARY KEY,
    FullName       NVARCHAR(100) NOT NULL,
    Gender         NVARCHAR(10) CHECK (Gender IN (N'Nam', N'N?', N'Khác')),
    Username       NVARCHAR(50) UNIQUE NOT NULL,
    [Password]     NVARCHAR(100) NOT NULL,
    Age            INT,
    HealthStatus   NVARCHAR(100),
    Email          NVARCHAR(100),
    Phone          NVARCHAR(20),
    RoleID         INT NOT NULL,
    TotalDistance  FLOAT DEFAULT 0,
    CreatedAt      DATETIME DEFAULT (GETDATE()),
    FOREIGN KEY (RoleID) REFERENCES [Role](RoleID)
);
GO

------------------------------------------------------------
-- 3?? B?NG MARATHON TYPE
------------------------------------------------------------
CREATE TABLE MarathonType (
    TypeID   INT IDENTITY(1,1) PRIMARY KEY,
    TypeName NVARCHAR(50) NOT NULL,
    Distance FLOAT NOT NULL
);
GO

------------------------------------------------------------
-- 4?? B?NG SPONSOR
------------------------------------------------------------
CREATE TABLE Sponsor (
    SponsorID   INT IDENTITY(1,1) PRIMARY KEY,
    SponsorName NVARCHAR(100) NOT NULL,
    ContactInfo NVARCHAR(200),
    Image       NVARCHAR(255)
);
GO

------------------------------------------------------------
-- 5?? B?NG MARATHON EVENT
------------------------------------------------------------
CREATE TABLE MarathonEvent (
    EventID          INT IDENTITY(1,1) PRIMARY KEY,
    EventName        NVARCHAR(200) NOT NULL,
    Location         NVARCHAR(200),
    StartDate        DATE,
    Description      NVARCHAR(MAX),
    Fee              MONEY,
    SponsorID        INT,
    Purpose          NVARCHAR(200),
    HealthRequirement NVARCHAR(200),
    ImagePath        NVARCHAR(500),
    TypeID           INT,
    CreatedBy        INT,
    CreatedAt        DATETIME DEFAULT (GETDATE()),
    FOREIGN KEY (TypeID)    REFERENCES MarathonType(TypeID),
    FOREIGN KEY (SponsorID) REFERENCES Sponsor(SponsorID),
    FOREIGN KEY (CreatedBy) REFERENCES [Account](uID)
);
GO

------------------------------------------------------------
-- 6?? B?NG REGISTRATION
------------------------------------------------------------
CREATE TABLE Registration (
    RegID         INT IDENTITY(1,1) PRIMARY KEY,
    EventID       INT NOT NULL,
    RunnerID      INT NOT NULL,
    RegisterDate  DATETIME DEFAULT (GETDATE()),
    PaymentStatus NVARCHAR(50) DEFAULT N'Pending',
    FOREIGN KEY (EventID)  REFERENCES MarathonEvent(EventID),
    FOREIGN KEY (RunnerID) REFERENCES [Account](uID)
);
GO

------------------------------------------------------------
-- 7?? B?NG PAYMENT
------------------------------------------------------------
CREATE TABLE Payment (
    PaymentID     INT IDENTITY(1,1) PRIMARY KEY,
    RegID         INT NOT NULL,
    Amount        MONEY NOT NULL,
    PaymentDate   DATETIME DEFAULT (GETDATE()),
    PaymentMethod NVARCHAR(50),
    FOREIGN KEY (RegID) REFERENCES Registration(RegID)
);
GO

------------------------------------------------------------
-- 8?? B?NG ADVICE
------------------------------------------------------------
CREATE TABLE Advice (
    AdviceID  INT IDENTITY(1,1) PRIMARY KEY,
    RunnerID  INT NOT NULL,
    Title     NVARCHAR(200),
    Message   NVARCHAR(MAX),
    CreatedAt DATETIME DEFAULT (GETDATE()),
    FOREIGN KEY (RunnerID) REFERENCES [Account](uID)
);
GO

------------------------------------------------------------
-- ? KI?M TRA
------------------------------------------------------------
SELECT N'? T?o database MarathonPRJ thành công!' AS Status;
GO

------------------------------------------------------------
-- 1?? ROLE
------------------------------------------------------------
INSERT INTO [Role] (RoleName)
VALUES
(N'Admin'),
(N'Staff'),
(N'Runner');
GO

------------------------------------------------------------
-- 2?? ACCOUNT
------------------------------------------------------------
INSERT INTO [Account] (FullName, Gender, Username, [Password], Age, HealthStatus, Email, Phone, RoleID)
VALUES
(N'Nguy?n V?n A', N'Nam', 'admin',  '123', 35, N'Kh?e m?nh', 'admin@gmail.com',  '0909000001', 1),
(N'Lê Th? B',     N'N?',  'staff1', '123', 28, N'T?t',       'staff1@gmail.com', '0909000002', 2),
(N'Tr?n V?n C',   N'Nam', 'runner1','123', 22, N'Trung bình','runner1@gmail.com','0909000003', 3),
(N'Ph?m Th? D',   N'N?',  'runner2','123', 25, N'T?t',       'runner2@gmail.com','0909000004', 3),
(N'Võ Minh E',    N'Nam', 'runner3','123', 30, N'T?t',       'runner3@gmail.com','0909000005', 3),
(N'Lý Thu F',     N'N?',  'staff2', '123', 29, N'Kh?e m?nh', 'staff2@gmail.com', '0909000006', 2);
GO

------------------------------------------------------------
-- 3?? MARATHON TYPE
------------------------------------------------------------
INSERT INTO MarathonType (TypeName, Distance)
VALUES
(N'5K Fun Run',       5),
(N'10K City Race',   10),
(N'Half Marathon',   21.1),
(N'Full Marathon',   42.195),
(N'Ultra Marathon',  60),
(N'Charity Walk',     3);
GO

------------------------------------------------------------
-- 4?? SPONSOR
------------------------------------------------------------
INSERT INTO Sponsor (SponsorName, ContactInfo, Image)
VALUES
(N'Nike Vi?t Nam',      N'nikevn@gmail.com',  'https://upload.wikimedia.org/wikipedia/commons/a/a6/Logo_NIKE.svg'),
(N'Adidas Vi?t Nam',    N'adidasvn@gmail.com','https://upload.wikimedia.org/wikipedia/commons/2/20/Adidas_Logo.svg'),
(N'VNG Corporation',    N'contact@vng.com.vn','https://upload.wikimedia.org/wikipedia/commons/8/87/VNG_Corporation_Logo.png'),
(N'Grab Vi?t Nam',      N'grab@gmail.com',    'https://upload.wikimedia.org/wikipedia/commons/6/6c/Grab_logo.svg'),
(N'Samsung Vi?t Nam',   N'samsungvn@gmail.com','https://upload.wikimedia.org/wikipedia/commons/2/24/Samsung_Logo.svg'),
(N'Vinamilk',           N'support@vinamilk.com.vn','https://upload.wikimedia.org/wikipedia/commons/d/d9/Vinamilk_logo.svg');
GO

------------------------------------------------------------
-- 5?? MARATHON EVENT ()
------------------------------------------------------------
INSERT INTO MarathonEvent (EventName, Location, StartDate, Description, Fee, SponsorID, Purpose, HealthRequirement, ImagePath, TypeID, CreatedBy)
VALUES
(N'HCMC Marathon 2025',       N'TP. H? Chí Minh', '2025-12-15', N'Gi?i ch?y th??ng niên quy mô l?n t?i TP.HCM', 500000, 1, N'Khuy?n khích l?i s?ng n?ng ??ng', N'T?t',                
N'https://content.r9cdn.net/rimg/dimg/f0/b1/54455949-city-18144-167c85df43f.jpg?width=1366&height=768&xhint=1159&yhint=754&crop=true', 
4, 2),

(N'Hà N?i Half Marathon 2025',N'Hà N?i',          '2025-11-10', N'S? ki?n ch?y b? mùa thu Hà N?i',                 300000, 2, N'Nâng cao s?c kh?e c?ng ??ng',   N'Trung bình tr? lên', 
N'https://cdn.nhandan.vn/images/4b48513cd86044f4f2ddb9f7f02544764798ba8ae4373179162fce7cfe3897c47d65dc4f9166e015ce7d6455435b3369a6ba73aaadbcfe91f457965bcb050724db70072c5f1796db177f89a5dd17bcfe5cfacd5ee898d181029010948d9846a0/xuat-phat-cu-li-10km-va-5km20230930085405-224.jpg', 
3, 2),

(N'?à N?ng City Run',         N'?à N?ng',         '2025-10-05', N'Gi?i ch?y ven bi?n ?à N?ng tuy?t ??p',          250000, 3, N'Thúc ??y du l?ch và th? thao', N'T?t',                
N'https://ariyanacentre.com/wp-content/uploads/2019/11/Developing-Night-Entertainment-In-Danang-In-2020.jpg',    
2, 2),

(N'H? Long Charity Walk',     N'Qu?ng Ninh',      '2025-09-20', N'Ch?y b? gây qu? t? thi?n giúp tr? em nghèo',    100000, 4, N'T? thi?n và c?ng ??ng',         N'Không yêu c?u',      
N'https://xdcs.cdnchinhphu.vn/446259493575335936/2025/10/9/quang-ninh-pt-16819611650471186998509-17600056032581787261919.jpg', 
6, 2),

(N'Sapa Mountain Ultra',      N'Lào Cai',         '2025-08-10', N'Chinh ph?c ??a hình ??i núi Sapa',              700000, 5, N'Th? thách s?c b?n',             N'R?t kh?e',           
N'https://vufo.org.vn/data/data/quynhhoa/2023/03/laocai(1).jpg', 
5, 2),

(N'C?n Th? Fun Run',          N'C?n Th?',         '2025-07-30', N'S? ki?n th? thao c?ng ??ng mi?n Tây',           150000, 6, N'Lan t?a tinh th?n th? thao',     N'T?t',                
N'https://irace-web.s3.ap-southeast-1.amazonaws.com/photos/events/2023/12/16/event-can-tho-marathon-heritage-race-banner.png?v=120244', 
1, 2);
GO

------------------------------------------------------------
-- 6?? REGISTRATION
------------------------------------------------------------
INSERT INTO Registration (EventID, RunnerID, PaymentStatus)
VALUES
(1, 3, N'Paid'),
(2, 4, N'Pending'),
(3, 5, N'Paid'),
(4, 3, N'Paid'),
(5, 4, N'Pending'),
(6, 5, N'Paid');
GO

------------------------------------------------------------
-- 7?? PAYMENT
------------------------------------------------------------
INSERT INTO Payment (RegID, Amount, PaymentMethod)
VALUES
(1, 500000, N'Momo'),
(2, 300000, N'Bank'),
(3, 250000, N'ZaloPay'),
(4, 100000, N'Momo'),
(5, 700000, N'Bank'),
(6, 150000, N'Momo');
GO

------------------------------------------------------------
-- 8?? ADVICE
------------------------------------------------------------
INSERT INTO Advice (RunnerID, Title, Message)
VALUES
(3, N'Gi? s?c b?n khi ch?y dài', N'Hãy b?t ??u ch?m và duy trì nh?p th? ??u.'),
(4, N'Dinh d??ng tr??c gi?i ch?y', N'Nên ?n nh? tr??c khi ch?y 2 ti?ng.'),
(5, N'Ch?y bu?i sáng hi?u qu?', N'Hít th? sâu và kh?i ??ng k? tr??c khi ch?y.'),
(3, N'Cách tránh ch?n th??ng', N'T?p giãn c? tr??c và sau khi ch?y.'),
(4, N'Ch?n giày phù h?p', N'Hãy ??u t? giày có ?? ?àn h?i t?t.'),
(5, N'T?p luy?n hàng ngày', N'Ch?y ng?n 3 l?n/tu?n ?? duy trì th? l?c.');
GO

------------------------------------------------------------
-- ? KI?M TRA
------------------------------------------------------------
SELECT N'? D? li?u ?ã thêm thành công cho t?t c? b?ng!' AS Status;
GO

------------------------------------------------------------
-- Thêm c?t IsDeleted
------------------------------------------------------------
ALTER TABLE [Account]
ADD IsDeleted BIT NOT NULL DEFAULT 0;
GO






