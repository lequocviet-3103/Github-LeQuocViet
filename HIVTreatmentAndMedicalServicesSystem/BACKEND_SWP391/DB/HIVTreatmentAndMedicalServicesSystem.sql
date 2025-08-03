USE master;
GO
-------------------------------
-- Kiểm tra nếu database HIVCareDB đã tồn tại
IF EXISTS (SELECT name FROM sys.databases WHERE name = 'HIVTreatmentAndMedicalServicesSystem')
BEGIN
    -- Nếu tồn tại thì hủy tất cả kết nối và xóa
    ALTER DATABASE HIVTreatmentAndMedicalServicesSystem SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE HIVTreatmentAndMedicalServicesSystem;
    PRINT 'Database HIVTreatmentAndMedicalServicesSystem đã tồn tại và đã được xóa.';
END

-- Tạo database mới
CREATE DATABASE HIVTreatmentAndMedicalServicesSystem;
GO

PRINT 'Database HIVTreatmentAndMedicalServicesSystem đã được tạo mới.';
GO

-- Chuyển sang sử dụng database vừa tạo
USE HIVTreatmentAndMedicalServicesSystem

go
set dateformat dmy


CREATE TABLE [Roles] (
  [RoleID] varchar(5) PRIMARY KEY, --R001
  [RoleName] nvarchar(30) NOT NULL
)
GO

CREATE TABLE [Users] (
  [UserID] varchar(8) PRIMARY KEY, --UI000001
  [RoleID] varchar(5) NOT NULL,
  [Fullname] nvarchar(100) NOT NULL,
  [Password] varchar(255) NOT NULL,
  [Email] varchar(100) UNIQUE NOT NULL,
  [Address] nvarchar(200),
  [Image] varchar(200)
)
GO

CREATE TABLE [Patients] ( 
  [PatientID] varchar(8) PRIMARY KEY, --PT000001
  [UserID] varchar(8) NOT NULL,
  [DateOfBirth] date,
  [Gender] nvarchar(20),
  [Phone] varchar(20),
  [BloodType] varchar(10),
  [Allergy] nvarchar(200)
)
GO

CREATE TABLE [Doctors] (
  [DoctorID] varchar(8) PRIMARY KEY, --DT000001
  [UserID] varchar(8) NOT NULL,
  [Specialization] nvarchar(100),
  [LicenseNumber] nvarchar(50) UNIQUE,
  [ExperienceYears] int
)
GO

CREATE TABLE [Slot] (
  [SlotID] varchar(8) PRIMARY KEY, --SL001
  [SlotNumber] int,
  [StartTime] time NOT NULL,
  [EndTime] time NOT NULL
)
GO

CREATE TABLE [DoctorWorkSchedule] (
  [ScheduleID] varchar(8) PRIMARY KEY, --DW000001
  [DoctorID] varchar(8) NOT NULL,
  [SlotID] varchar(8) NOT NULL,
  [DateWork] datetime
)
GO

CREATE TABLE [Booking] (
  [BookID] varchar(8) PRIMARY KEY, --BK000001
  [PatientID] varchar(8) NOT NULL,
  [DoctorID] varchar(8),
  [BookingType] nvarchar(50),
  [LabRequest] nvarchar(50),
  [BookDate] datetime NOT NULL,
  [Status] nvarchar(20) DEFAULT N'Thành công' CHECK (Status IN (N'Thành công', N'Đã hủy', N'Đã xác nhận', N'Đã khám')),
  [Note] nvarchar(255)
)
GO

CREATE TABLE [TreatmentPlan] (
  [TreatmentPlanID] varchar(8) PRIMARY KEY, --TP000001
  [PatientID] varchar(8) NOT NULL,
  [DoctorID] varchar(8) NOT NULL,
  [ARVProtocol] varchar(8) NOT NULL,
  [TreatmentLine] int,
  [Diagnosis] nvarchar(255),
  [TreatmentResult] nvarchar(255),
  [CreatedDate] datetime DEFAULT (CURRENT_TIMESTAMP)
)
GO

CREATE TABLE [Medication] (
  [MedicationID] varchar(8) PRIMARY KEY, --MD000001
  [MedicationName] nvarchar(100) NOT NULL,
  [DosageForm] nvarchar(50),
  [Strength] nvarchar(50),
  [TargetGroup] nvarchar(50),
  Advantage nvarchar(100),
  [Use] nvarchar(100),
  [Note] nvarchar(255),
  [CreatedAt] datetime DEFAULT (CURRENT_TIMESTAMP)
)
GO

CREATE TABLE [Prescription] (
  [PrescriptionID] varchar(8) PRIMARY KEY, --PR000001
  [MedicalRecordID] varchar(8) NOT NULL,
  [MedicationID] varchar(8) NOT NULL,
  [DoctorID] varchar(8) NOT NULL,
  [StartDate] date NOT NULL,
  [EndDate] date,
  [Dosage] nvarchar(100),
  [LineOfTreatment] nvarchar(50),
  [CreatedAt] datetime DEFAULT (CURRENT_TIMESTAMP)
)
GO

CREATE TABLE [ARVProtocol] (
  [ARVID] varchar(8) PRIMARY KEY, --AP000001
  [ARVCode] nvarchar(50),
  [ARVName] nvarchar(100),
  [Description] nvarchar(255),
  [AgeRange] nvarchar(50),
  [ForGroup] nvarchar(50),
  [CreatedAt] datetime DEFAULT (CURRENT_TIMESTAMP)
)
GO

CREATE TABLE [Reminder] (
  [ReminderCheckID] varchar(8) PRIMARY KEY, --RM000001
  [PatientID] varchar(8) NOT NULL,
  [TreatmentPlantID] varchar(8) NOT NULL,
  [PrescriptionID] varchar(8) NOT NULL,
  [ReminderType] nvarchar(50),
  [ReminderTime] datetime NOT NULL,
  [Message] nvarchar(255)
)
GO

CREATE TABLE [LabTests] (
  [LabTestID] varchar(8) PRIMARY KEY,--LT000001
  [RequestID] varchar(8) NOT NULL,
  [TestName] nvarchar(100) NOT NULL,
  --[TestCode] nvarchar(50) UNIQUE,
  [TestType] nvarchar(50),
  [ResultValue] nvarchar(100),
  [CD4Initial] int,
  [ViralLoadInitial] int,
  [Status] nvarchar(20) DEFAULT N'Đang xử lý' CHECK (Status IN (N'Đang xử lý', N'Hoàn thành')),
  [Description] nvarchar(255)
)
GO
/*
CREATE TABLE [Payment] (
  [PaymentID] varchar(8) PRIMARY KEY, -- PM000001
  [BookID] varchar(8) NOT NULL,
  [Amount] decimal(10,2) NOT NULL,
  [PaymentDate] datetime NOT NULL,
  [PaymentMethod] nvarchar(50) NOT NULL, -- Phương thức thanh toán, không phải status
  [Status] nvarchar(20) DEFAULT N'Đang chờ' CHECK (Status IN (N'Đang chờ', N'Thành công', N'Thất bại')),
  [Description] nvarchar(255),
  [CreatedAt] datetime DEFAULT (CURRENT_TIMESTAMP)
)
GO*/

ALTER TABLE [Users] ADD FOREIGN KEY ([RoleID]) REFERENCES [Roles] ([RoleID])
GO

ALTER TABLE [Patients] ADD FOREIGN KEY ([UserID]) REFERENCES [Users] ([UserID])
GO

ALTER TABLE [Doctors] ADD FOREIGN KEY ([UserID]) REFERENCES [Users] ([UserID])
GO

ALTER TABLE [DoctorWorkSchedule] ADD FOREIGN KEY ([DoctorID]) REFERENCES [Doctors] ([DoctorID])
GO

ALTER TABLE [DoctorWorkSchedule] ADD FOREIGN KEY ([SlotID]) REFERENCES [Slot] ([SlotID])
GO

ALTER TABLE [Booking] ADD FOREIGN KEY ([PatientID]) REFERENCES [Patients] ([PatientID])
GO

ALTER TABLE [Booking] ADD FOREIGN KEY ([DoctorID]) REFERENCES [Doctors] ([DoctorID])
GO

ALTER TABLE [TreatmentPlan] ADD FOREIGN KEY ([PatientID]) REFERENCES [Patients] ([PatientID])
GO

ALTER TABLE [TreatmentPlan] ADD FOREIGN KEY ([DoctorID]) REFERENCES [Doctors] ([DoctorID])
GO

ALTER TABLE [TreatmentPlan] ADD FOREIGN KEY ([ARVProtocol]) REFERENCES [ARVProtocol] ([ARVID])
GO

ALTER TABLE [Prescription] ADD FOREIGN KEY ([MedicalRecordID]) REFERENCES [TreatmentPlan] ([TreatmentPlanID])
GO

ALTER TABLE [Prescription] ADD FOREIGN KEY ([MedicationID]) REFERENCES [Medication] ([MedicationID])
GO

ALTER TABLE [Prescription] ADD FOREIGN KEY ([DoctorID]) REFERENCES [Doctors] ([DoctorID])
GO

ALTER TABLE [Reminder] ADD FOREIGN KEY ([PatientID]) REFERENCES [Patients] ([PatientID])
GO

ALTER TABLE [Reminder] ADD FOREIGN KEY ([TreatmentPlantID]) REFERENCES [TreatmentPlan] ([TreatmentPlanID])
GO

ALTER TABLE [Reminder] ADD FOREIGN KEY ([PrescriptionID]) REFERENCES [Prescription] ([PrescriptionID])
GO

	
GO


--ALTER TABLE [Payment] ADD FOREIGN KEY ([BookID]) REFERENCES [Booking] ([BookID])
--GO
-- Roles
insert into Roles values ('R001', 'Admin');
insert into Roles values ('R002', 'Manager');
insert into Roles values ('R003', 'Doctor');
insert into Roles values ('R004', 'Staff');
insert into Roles values ('R005', 'Patient');

-- Admin
INSERT INTO Users VALUES ('UI000001', 'R001', N'Lê Quốc Việt', '123', 'lequocviet@gmail.com', N'Hà Nội', 'admin1.png');
INSERT INTO Users VALUES ('UI000002', 'R001', N'Nguyễn Văn Nguyên', '123', 'nguyenvannguyen@gmail.com', N'Hồ Chí Minh', 'admin2.png');
INSERT INTO Users VALUES ('UI000003', 'R001', N'Hoàng Anh Tuấn', '123', 'hoanganhtuan@gmail.com', N'Lâm Đồng', 'admin3.jpg');
INSERT INTO Users VALUES ('UI000004', 'R001', N'Võ Việt Dũng', '123', 'vovietdung@gmail.com', N'Hồ Chí Minh', 'admin4.jpg');
INSERT INTO Users VALUES ('UI000005', 'R001', N'Nguyễn Ngọc Tín', '123', 'nguyenngoctin@gmail.com', N'Hồ Chí Minh', 'admin5.jpg');
INSERT INTO Users VALUES ('UI000006', 'R001', N'Đỗ Thị Nhung', '123', 'dothinhung@gmail.com', N'Hà Nội', 'admin6.jpg');
INSERT INTO Users VALUES ('UI000007', 'R001', N'Vũ Văn Thái', '123', 'vuvanthai7@gmail.com', N'Hà Nội', 'admin7.jpg');
INSERT INTO Users VALUES ('UI000008', 'R001', N'Đặng Thị Xuân', '123', 'dothixuan@gmail.com', N'Hồ Chí Minh', 'admin8.jpg');
INSERT INTO Users VALUES ('UI000009', 'R001', N'Mai Văn Tuyền', '123', 'maivantuyen@gmail.com', N'Hồ Chí Minh', 'admin9.jpg');
INSERT INTO Users VALUES ('UI000010', 'R001', N'Trịnh Thị Yến', '123', 'trinhthiyen@gmail.com', N'Hà Nội', 'admin10.jpg');

-- Manager
INSERT INTO Users VALUES ('UI000011', 'R002', N'Nguyễn Văn Nguyên', '123', 'nguyenmanager@gmail.com', N'Hà Nội', 'manager1.jpg');
INSERT INTO Users VALUES ('UI000012', 'R002', N'Trần Thị Hạnh', '123', 'tranthihanh@gmail.com', N'Hồ Chí Minh', 'manager2.jpg');
INSERT INTO Users VALUES ('UI000013', 'R002', N'Lê Quốc Hùng', '123', 'lequochung@gmail.com', N'Đà Nẵng', 'manager3.jpg');
INSERT INTO Users VALUES ('UI000014', 'R002', N'Phạm Thị Duyên', '123', 'phamthiduyen@gmail.com', N'Cần Thơ', 'manager4.jpg');
INSERT INTO Users VALUES ('UI000015', 'R002', N'Hoàng Văn Thái', '123', 'hoangvanthai@gmail.com', N'Hải Phòng', 'manager5.jpg');
INSERT INTO Users VALUES ('UI000016', 'R002', N'Đỗ Thị Hạnh', '123', 'dithihanh@gmail.com', N'Nha Trang', 'manager6.jpg');
INSERT INTO Users VALUES ('UI000017', 'R002', N'Vũ Văn Tuyền', '123', 'levantuyen@gmail.com', N'Đà Lạt', 'manager7.jpg');
INSERT INTO Users VALUES ('UI000018', 'R002', N'Đặng Thị Thu', '123', 'dangthithu@gmail.com', N'Huế', 'manager8.jpg');
INSERT INTO Users VALUES ('UI000019', 'R002', N'Mai Quốc Khánh', '123', 'maiquockhanh9@gmail.com', N'Quảng Ninh', 'manager9.jpg');
INSERT INTO Users VALUES ('UI000020', 'R002', N'Trịnh Thị Hồng', '123', 'trinhthihong@gmail.com', N'Bắc Ninh', 'manager10.jpg');

-- Doctor
INSERT INTO Users VALUES ('UI000021', 'R003', N'Nguyễn Văn An', '123', 'nguyenvanan@gmail.com', N'Hà Nội', 'doctor21.png');
INSERT INTO Users VALUES ('UI000022', 'R003', N'Trần Bình An', '123', 'tranbinhan@gmail.com', N'Hồ Chí Minh', 'doctor22.png');
INSERT INTO Users VALUES ('UI000023', 'R003', N'Lê Văn Cường', '123', 'levancuong@gmail.com', N'Đà Nẵng', 'doctor23.png');
INSERT INTO Users VALUES ('UI000024', 'R003', N'Phạm Thị Dung', '123', 'phamthidung@gmail.com', N'Cần Thơ', 'doctor24.png');
INSERT INTO Users VALUES ('UI000025', 'R003', N'Hoàng Văn Anh', '123', 'hoangvananh@gmail.com', N'Hải Phòng', 'doctor25.png');
INSERT INTO Users VALUES ('UI000026', 'R003', N'Đỗ Thị Phương', '123', 'dothiphuong@gmail.com', N'Nha Trang', 'doctor26.png');
INSERT INTO Users VALUES ('UI000027', 'R003', N'Vũ Văn Giang', '123', 'vuvangiang@gmail.com', N'Đà Lạt', 'doctor27.png');
INSERT INTO Users VALUES ('UI000028', 'R003', N'Đặng Thị Hương', '123', 'dangthihuong@gmail.com', N'Huế', 'doctor28.png');
INSERT INTO Users VALUES ('UI000029', 'R003', N'Mai Văn Khoa', '123', 'maivankhoa@gmail.com', N'Quảng Ninh', 'doctor29.png');
INSERT INTO Users VALUES ('UI000030', 'R003', N'Trịnh Thị Linh', '123', 'trinhthilinh@gmail.com', N'Bắc Ninh', 'doctor30.png');

INSERT INTO Users VALUES ('UI000031', 'R003', N'Lê Minh Tuấn', '123', 'leminhtuan@gmail.com', N'Hà Nội', 'doctor31.png');
INSERT INTO Users VALUES ('UI000032', 'R003', N'Phạm Thu Hằng', '123', 'phamthuhang@gmail.com', N'Hồ Chí Minh', 'doctor32.png');
INSERT INTO Users VALUES ('UI000033', 'R003', N'Ngô Văn Huy', '123', 'ngovanhuy@gmail.com', N'Đà Nẵng', 'doctor33.png');
INSERT INTO Users VALUES ('UI000034', 'R003', N'Trần Hải Yến', '123', 'tranhaiyen@gmail.com', N'Hải Phòng', 'doctor34.png');
INSERT INTO Users VALUES ('UI000035', 'R003', N'Hoàng Đức Anh', '123', 'hoangducanh@gmail.com', N'Cần Thơ', 'doctor35.png');
INSERT INTO Users VALUES ('UI000036', 'R003', N'Đỗ Thị Mai', '123', 'dothimai@gmail.com', N'Nghệ An', 'doctor36.png');
INSERT INTO Users VALUES ('UI000037', 'R003', N'Vũ Ngọc Long', '123', 'vungoclong@gmail.com', N'Thái Bình', 'doctor37.png');
INSERT INTO Users VALUES ('UI000038', 'R003', N'Bùi Thanh Hương', '123', 'buithanhhuong@gmail.com', N'Hưng Yên', 'doctor38.png');
INSERT INTO Users VALUES ('UI000039', 'R003', N'Tạ Quang Dũng', '123', 'taquangdung@gmail.com', N'Lâm Đồng', 'doctor39.png');
INSERT INTO Users VALUES ('UI000040', 'R003', N'Nguyễn Thị Kim', '123', 'nguyenthikim@gmail.com', N'Bình Dương', 'doctor40.png');


-- Staff
INSERT INTO Users VALUES ('UI000041', 'R004', N'Nguyễn Văn Nam', '123', 'nguyenvannam@gmail.com', N'Hà Nội', 'staff.png');
INSERT INTO Users VALUES ('UI000042', 'R004', N'Trần Thị Oanh', '123', 'tranthioanh@gmail.com', N'Hồ Chí Minh', 'staff.png');
INSERT INTO Users VALUES ('UI000043', 'R004', N'Lê Văn Phong', '123', 'levanphong@gmail.com', N'Đà Nẵng', 'staff.png');
INSERT INTO Users VALUES ('UI000044', 'R004', N'Phạm Thị Quỳnh', '123', 'phamthiquynh@gmail.com', N'Cần Thơ', 'staff.png');
INSERT INTO Users VALUES ('UI000045', 'R004', N'Hoàng Văn Phong', '123', 'hoangvanphong@gmail.com', N'Hải Phòng', 'staff.png');
INSERT INTO Users VALUES ('UI000046', 'R004', N'Đỗ Thị Sương', '123', 'dothisuong@gmail.com', N'Nha Trang', 'staff.png');
INSERT INTO Users VALUES ('UI000047', 'R004', N'Vũ Văn Toàn', '123', 'vuvantoan@gmail.com', N'Đà Lạt', 'staff.png');
INSERT INTO Users VALUES ('UI000048', 'R004', N'Đặng Thị Uyên', '123', 'dangthiuyen@gmail.com', N'Huế', 'staff.png');
INSERT INTO Users VALUES ('UI000049', 'R004', N'Mai Văn Vinh', '123', 'maivanvinh@gmail.com', N'Quảng Ninh', 'staff.png');
INSERT INTO Users VALUES ('UI000050', 'R004', N'Trịnh Trần Xuân', '123', 'trinhtranxuan@gmail.com', N'Bắc Ninh', 'staff.png');

-- Patient
INSERT INTO Users VALUES ('UI000051', 'R005', N'Trịnh Bá khá', '123', 'trinhbakha@gmail.com', N'Hà Nội', 'patient.png');
INSERT INTO Users VALUES ('UI000052', 'R005', N'Trần Thị Thắm', '123', 'tranthitham@gmail.com', N'Hồ Chí Minh', 'patient.png');
INSERT INTO Users VALUES ('UI000053', 'R005', N'Lê Văn Anh', '123', 'levananh@gmail.com', N'Đà Nẵng', 'patient.png');
INSERT INTO Users VALUES ('UI000054', 'R005', N'Phạm Thị Bích', '123', 'phamthibich@gmail.com', N'Cần Thơ', 'patient.png');
INSERT INTO Users VALUES ('UI000055', 'R005', N'Hoàng Văn Cảnh', '123', 'hoangvancanh@gmail.com', N'Hải Phòng', 'patient.png');
INSERT INTO Users VALUES ('UI000056', 'R005', N'Đỗ Thị Diệp', '123', 'dothihiep@gmail.com', N'Nha Trang', 'patient.png');
INSERT INTO Users VALUES ('UI000057', 'R005', N'Vũ Văn Em', '123', 'vuvanem@gmail.com', N'Đà Lạt', 'patient.png');
INSERT INTO Users VALUES ('UI000058', 'R005', N'Đặng Thị Phúc', '123', 'phamthiphuc@gmail.com', N'Huế', 'patient.png');
INSERT INTO Users VALUES ('UI000059', 'R005', N'Mai Văn Giáp', '123', 'maivangiap@gmail.com', N'Quảng Ninh', 'patient.png');
INSERT INTO Users VALUES ('UI000060', 'R005', N'Trịnh Thị Hòa', '123', 'trinhthihoa@gmail.com', N'Bắc Ninh', 'patient.png');

INSERT INTO Users VALUES ('UI000061', 'R005', N'Nguyễn Thị Hồng', '123', 'nguyenthihong@gmail.com', N'Hồ Chí Minh', 'patient.png');
INSERT INTO Users VALUES ('UI000062', 'R005', N'Phạm Văn Cường', '123', 'phamvancuong@gmail.com', N'Đà Nẵng', 'patient.png');
INSERT INTO Users VALUES ('UI000063', 'R005', N'Lê Thị Mai', '123', 'lethimai@gmail.com', N'Hải Phòng', 'patient.png');
INSERT INTO Users VALUES ('UI000064', 'R005', N'Đỗ Mạnh Hùng', '123', 'domanhhung@gmail.com', N'Cần Thơ', 'patient.png');
INSERT INTO Users VALUES ('UI000065', 'R005', N'Trần Văn Bình', '123', 'tranvanbinh@gmail.com', N'Khánh Hòa', 'patient.png');
INSERT INTO Users VALUES ('UI000066', 'R005', N'Huỳnh Thị Ngọc', '123', 'huynhthingoc@gmail.com', N'Nghệ An', 'patient.png');
INSERT INTO Users VALUES ('UI000067', 'R005', N'Bùi Văn Long', '123', 'buivanlong@gmail.com', N'Lâm Đồng', 'patient.png');
INSERT INTO Users VALUES ('UI000068', 'R005', N'Võ Thị Lan', '123', 'vothilan@gmail.com', N'Quảng Ninh', 'patient.png');
INSERT INTO Users VALUES ('UI000069', 'R005', N'Tạ Minh Đức', '123', 'taminhduc@gmail.com', N'An Giang', 'patient.png');
INSERT INTO Users VALUES ('UI000070', 'R005', N'Ngô Quỳnh Anh', '123', 'ngoquynhanh@gmail.com', N'Thừa Thiên Huế', 'patient.png');



-- 3. Bảng Patients

INSERT INTO Patients VALUES ('PT000001', 'UI000051', '15-05-1985', N'Nam', '0907123495', 'A+', N'Không có dị ứng');
INSERT INTO Patients VALUES ('PT000002', 'UI000052', '20-08-1990', N'Nữ', '0918457230', 'O+', N'Dị ứng với Penicillin');
INSERT INTO Patients VALUES ('PT000003', 'UI000053', '10-03-1978', N'Nam', '0939421785', 'B+', N'Dị ứng với hải sản');
INSERT INTO Patients VALUES ('PT000004', 'UI000054', '25-11-1995', N'Nữ', '0943167298', 'AB+', N'Không có dị ứng');
INSERT INTO Patients VALUES ('PT000005', 'UI000055', '08-07-1982', N'Nam', '0967843201', 'A-', N'Dị ứng với mật ong');
INSERT INTO Patients VALUES ('PT000006', 'UI000056', '14-02-1998', N'Nữ', '0971957432', 'O-', N'Dị ứng với phấn hoa');
INSERT INTO Patients VALUES ('PT000007', 'UI000057', '30-09-1975', N'Nam', '0984279516', 'B-', N'Không có dị ứng');
INSERT INTO Patients VALUES ('PT000008', 'UI000058', '18-04-1993', N'Nữ', '0916237490', 'AB-', N'Dị ứng với thịt bò');
INSERT INTO Patients VALUES ('PT000009', 'UI000059', '05-12-1980', N'Nam', '0902849173', 'A+', N'Dị ứng với đậu phộng');
INSERT INTO Patients VALUES ('PT000010', 'UI000060', '22-06-1988', N'Nữ', '0939146825', 'O+', N'Không có dị ứng');

INSERT INTO Patients VALUES ('PT000011', 'UI000061', '12-11-1982', N'Nam', '0905123486', 'O+', N'Không có dị ứng');
INSERT INTO Patients VALUES ('PT000012', 'UI000062', '07-07-1995', N'Nữ', '0396234571', 'A-', N'Dị ứng với phấn hoa');
INSERT INTO Patients VALUES ('PT000013', 'UI000063', '03-01-1980', N'Nam', '0937345693', 'B+', N'Không có dị ứng');
INSERT INTO Patients VALUES ('PT000014', 'UI000064', '25-04-1988', N'Nữ', '0388456728', 'AB+', N'Dị ứng với Penicillin');
INSERT INTO Patients VALUES ('PT000015', 'UI000065', '18-09-1992', N'Nam', '0909567891', 'O-', N'Dị ứng với hải sản');
INSERT INTO Patients VALUES ('PT000016', 'UI000066', '30-12-1983', N'Nữ', '0370678942', 'A+', N'Không có dị ứng');
INSERT INTO Patients VALUES ('PT000017', 'UI000067', '14-06-1979', N'Nam', '0911789063', 'B-', N'Dị ứng với bụi nhà');
INSERT INTO Patients VALUES ('PT000018', 'UI000068', '09-10-1991', N'Nữ', '0362890174', 'AB-', N'Không có dị ứng');
INSERT INTO Patients VALUES ('PT000019', 'UI000069', '22-02-1987', N'Nam', '0393901295', 'O+', N'Dị ứng với trứng');
INSERT INTO Patients VALUES ('PT000020', 'UI000070', '11-08-1993', N'Nữ', '0904012366', 'A-', N'Dị ứng với động vật có lông');



 --4. Bảng Doctors

INSERT INTO Doctors VALUES ('DT000001', 'UI000021', N'HIV Treatment Specialist', 'LN12345', 8);
INSERT INTO Doctors VALUES ('DT000002', 'UI000022', N'HIV Clinical Management', 'LN23456', 10);
INSERT INTO Doctors VALUES ('DT000003', 'UI000023', N'HIV Immunotherapy', 'LN34567', 12);
INSERT INTO Doctors VALUES ('DT000004', 'UI000024', N'HIV Internal Medicine', 'LN45678', 15);
INSERT INTO Doctors VALUES ('DT000005', 'UI000025', N'HIV Prevention Specialist', 'LN56789', 14);
INSERT INTO Doctors VALUES ('DT000006', 'UI000026', N'HIV Virology Expert', 'LN67890', 16);
INSERT INTO Doctors VALUES ('DT000007', 'UI000027', N'ARV Therapy Consultant', 'LN78901', 11);
INSERT INTO Doctors VALUES ('DT000008', 'UI000028', N'Primary Care for HIV Patients', 'LN89012', 5);
INSERT INTO Doctors VALUES ('DT000009', 'UI000029', N'Pediatric HIV Specialist', 'LN90123', 13);
INSERT INTO Doctors VALUES ('DT000010', 'UI000030', N'HIV Research and Innovation', 'LN01234', 16);

INSERT INTO Doctors VALUES ('DT000011', 'UI000031', N'HIV Treatment Counseling', 'LN13511', 10);
INSERT INTO Doctors VALUES ('DT000012', 'UI000032', N'Specialized ARV Pharmacist', 'LN24532', 12);
INSERT INTO Doctors VALUES ('DT000013', 'UI000033', N'HIV Viral Load Monitoring', 'LN31287', 8);
INSERT INTO Doctors VALUES ('DT000014', 'UI000034', N'Psychological Counseling for HIV Patients', 'LN47891', 15);
INSERT INTO Doctors VALUES ('DT000015', 'UI000035', N'HIV Prevention & Immunization', 'LN58902', 9);
INSERT INTO Doctors VALUES ('DT000016', 'UI000036', N'Initial ARV Treatment Counseling', 'LN62455', 7);
INSERT INTO Doctors VALUES ('DT000017', 'UI000037', N'Treatment Adherence Monitoring', 'LN73841', 11);
INSERT INTO Doctors VALUES ('DT000018', 'UI000038', N'HIV Counseling for High-Risk Groups', 'LN81234', 14);
INSERT INTO Doctors VALUES ('DT000019', 'UI000039', N'HIV Pediatric Treatment Counseling', 'LN93472', 13);
INSERT INTO Doctors VALUES ('DT000020', 'UI000040', N'Advanced ARV Protocol Counseling', 'LN10483', 6);


--5. Bảng Slot

INSERT INTO Slot VALUES ('SL000001', 1, '08:00:00', '10:00:00');
INSERT INTO Slot VALUES ('SL000002', 2, '10:00:00', '12:00:00');
INSERT INTO Slot VALUES ('SL000003', 3, '12:00:00', '14:00:00');
INSERT INTO Slot VALUES ('SL000004', 4, '14:00:00', '16:00:00');
INSERT INTO Slot VALUES ('SL000005', 5, '16:00:00', '18:00:00');


-- 6. Bảng DoctorWorkSchedule

INSERT INTO DoctorWorkSchedule VALUES ('DW000471', 'DT000001', 'SL000001', '29-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000472', 'DT000001', 'SL000002', '29-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000473', 'DT000001', 'SL000003', '29-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000474', 'DT000001', 'SL000004', '29-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000475', 'DT000002', 'SL000001', '29-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000476', 'DT000002', 'SL000002', '29-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000477', 'DT000002', 'SL000003', '29-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000478', 'DT000002', 'SL000004', '29-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000479', 'DT000002', 'SL000005', '29-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000480', 'DT000003', 'SL000001', '29-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000481', 'DT000003', 'SL000002', '29-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000482', 'DT000003', 'SL000003', '29-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000483', 'DT000003', 'SL000004', '29-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000484', 'DT000004', 'SL000001', '29-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000485', 'DT000004', 'SL000002', '29-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000486', 'DT000004', 'SL000003', '29-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000487', 'DT000004', 'SL000004', '29-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000488', 'DT000004', 'SL000005', '29-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000489', 'DT000005', 'SL000001', '29-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000490', 'DT000005', 'SL000002', '29-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000491', 'DT000005', 'SL000003', '29-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000492', 'DT000005', 'SL000004', '29-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000493', 'DT000006', 'SL000001', '29-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000494', 'DT000006', 'SL000002', '29-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000495', 'DT000006', 'SL000003', '29-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000496', 'DT000006', 'SL000004', '29-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000497', 'DT000006', 'SL000005', '29-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000498', 'DT000007', 'SL000001', '29-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000499', 'DT000007', 'SL000002', '29-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000500', 'DT000007', 'SL000003', '29-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000501', 'DT000007', 'SL000004', '29-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000502', 'DT000008', 'SL000001', '29-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000503', 'DT000008', 'SL000002', '29-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000504', 'DT000008', 'SL000003', '29-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000505', 'DT000008', 'SL000004', '29-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000506', 'DT000008', 'SL000005', '29-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000507', 'DT000009', 'SL000001', '29-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000508', 'DT000009', 'SL000002', '29-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000509', 'DT000009', 'SL000003', '29-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000510', 'DT000009', 'SL000004', '29-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000511', 'DT000010', 'SL000001', '29-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000512', 'DT000010', 'SL000002', '29-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000513', 'DT000010', 'SL000003', '29-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000514', 'DT000010', 'SL000004', '29-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000515', 'DT000010', 'SL000005', '29-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000516', 'DT000011', 'SL000001', '29-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000517', 'DT000011', 'SL000002', '29-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000518', 'DT000011', 'SL000003', '29-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000519', 'DT000011', 'SL000004', '29-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000520', 'DT000012', 'SL000001', '29-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000521', 'DT000012', 'SL000002', '29-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000522', 'DT000012', 'SL000003', '29-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000523', 'DT000012', 'SL000004', '29-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000524', 'DT000012', 'SL000005', '29-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000525', 'DT000013', 'SL000001', '29-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000526', 'DT000013', 'SL000002', '29-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000527', 'DT000013', 'SL000003', '29-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000528', 'DT000013', 'SL000004', '29-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000529', 'DT000014', 'SL000001', '29-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000530', 'DT000014', 'SL000002', '29-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000531', 'DT000014', 'SL000003', '29-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000532', 'DT000014', 'SL000004', '29-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000533', 'DT000014', 'SL000005', '29-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000534', 'DT000015', 'SL000001', '29-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000535', 'DT000015', 'SL000002', '29-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000536', 'DT000015', 'SL000003', '29-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000537', 'DT000015', 'SL000004', '29-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000538', 'DT000016', 'SL000001', '29-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000539', 'DT000016', 'SL000002', '29-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000540', 'DT000016', 'SL000003', '29-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000541', 'DT000016', 'SL000004', '29-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000542', 'DT000016', 'SL000005', '29-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000543', 'DT000017', 'SL000001', '29-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000544', 'DT000017', 'SL000002', '29-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000545', 'DT000017', 'SL000003', '29-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000546', 'DT000017', 'SL000004', '29-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000547', 'DT000018', 'SL000001', '29-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000548', 'DT000018', 'SL000002', '29-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000549', 'DT000018', 'SL000003', '29-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000550', 'DT000018', 'SL000004', '29-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000551', 'DT000018', 'SL000005', '29-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000552', 'DT000019', 'SL000001', '29-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000553', 'DT000019', 'SL000002', '29-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000554', 'DT000019', 'SL000003', '29-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000555', 'DT000019', 'SL000004', '29-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000556', 'DT000020', 'SL000001', '29-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000557', 'DT000020', 'SL000002', '29-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000558', 'DT000020', 'SL000003', '29-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000559', 'DT000020', 'SL000004', '29-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000560', 'DT000020', 'SL000005', '29-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000561', 'DT000001', 'SL000001', '30-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000562', 'DT000001', 'SL000002', '30-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000563', 'DT000001', 'SL000003', '30-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000564', 'DT000001', 'SL000004', '30-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000565', 'DT000001', 'SL000005', '30-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000566', 'DT000002', 'SL000001', '30-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000567', 'DT000002', 'SL000002', '30-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000568', 'DT000002', 'SL000003', '30-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000569', 'DT000002', 'SL000004', '30-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000570', 'DT000003', 'SL000001', '30-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000571', 'DT000003', 'SL000002', '30-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000572', 'DT000003', 'SL000003', '30-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000573', 'DT000003', 'SL000004', '30-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000574', 'DT000003', 'SL000005', '30-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000575', 'DT000004', 'SL000001', '30-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000576', 'DT000004', 'SL000002', '30-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000577', 'DT000004', 'SL000003', '30-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000578', 'DT000004', 'SL000004', '30-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000579', 'DT000005', 'SL000001', '30-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000580', 'DT000005', 'SL000002', '30-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000581', 'DT000005', 'SL000003', '30-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000582', 'DT000005', 'SL000004', '30-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000583', 'DT000005', 'SL000005', '30-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000584', 'DT000006', 'SL000001', '30-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000585', 'DT000006', 'SL000002', '30-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000586', 'DT000006', 'SL000003', '30-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000587', 'DT000006', 'SL000004', '30-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000588', 'DT000007', 'SL000001', '30-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000589', 'DT000007', 'SL000002', '30-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000590', 'DT000007', 'SL000003', '30-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000591', 'DT000007', 'SL000004', '30-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000592', 'DT000007', 'SL000005', '30-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000593', 'DT000008', 'SL000001', '30-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000594', 'DT000008', 'SL000002', '30-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000595', 'DT000008', 'SL000003', '30-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000596', 'DT000008', 'SL000004', '30-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000597', 'DT000009', 'SL000001', '30-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000598', 'DT000009', 'SL000002', '30-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000599', 'DT000009', 'SL000003', '30-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000600', 'DT000009', 'SL000004', '30-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000601', 'DT000009', 'SL000005', '30-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000602', 'DT000010', 'SL000001', '30-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000603', 'DT000010', 'SL000002', '30-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000604', 'DT000010', 'SL000003', '30-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000605', 'DT000010', 'SL000004', '30-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000606', 'DT000011', 'SL000001', '30-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000607', 'DT000011', 'SL000002', '30-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000608', 'DT000011', 'SL000003', '30-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000609', 'DT000011', 'SL000004', '30-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000610', 'DT000011', 'SL000005', '30-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000611', 'DT000012', 'SL000001', '30-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000612', 'DT000012', 'SL000002', '30-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000613', 'DT000012', 'SL000003', '30-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000614', 'DT000012', 'SL000004', '30-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000615', 'DT000013', 'SL000001', '30-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000616', 'DT000013', 'SL000002', '30-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000617', 'DT000013', 'SL000003', '30-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000618', 'DT000013', 'SL000004', '30-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000619', 'DT000013', 'SL000005', '30-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000620', 'DT000014', 'SL000001', '30-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000621', 'DT000014', 'SL000002', '30-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000622', 'DT000014', 'SL000003', '30-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000623', 'DT000014', 'SL000004', '30-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000624', 'DT000015', 'SL000001', '30-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000625', 'DT000015', 'SL000002', '30-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000626', 'DT000015', 'SL000003', '30-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000627', 'DT000015', 'SL000004', '30-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000628', 'DT000015', 'SL000005', '30-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000629', 'DT000016', 'SL000001', '30-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000630', 'DT000016', 'SL000002', '30-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000631', 'DT000016', 'SL000003', '30-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000632', 'DT000016', 'SL000004', '30-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000633', 'DT000017', 'SL000001', '30-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000634', 'DT000017', 'SL000002', '30-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000635', 'DT000017', 'SL000003', '30-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000636', 'DT000017', 'SL000004', '30-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000637', 'DT000017', 'SL000005', '30-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000638', 'DT000018', 'SL000001', '30-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000639', 'DT000018', 'SL000002', '30-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000640', 'DT000018', 'SL000003', '30-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000641', 'DT000018', 'SL000004', '30-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000642', 'DT000019', 'SL000001', '30-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000643', 'DT000019', 'SL000002', '30-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000644', 'DT000019', 'SL000003', '30-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000645', 'DT000019', 'SL000004', '30-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000646', 'DT000019', 'SL000005', '30-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000647', 'DT000020', 'SL000001', '30-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000648', 'DT000020', 'SL000002', '30-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000649', 'DT000020', 'SL000003', '30-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000650', 'DT000020', 'SL000004', '30-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000651', 'DT000001', 'SL000001', '31-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000652', 'DT000001', 'SL000002', '31-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000653', 'DT000001', 'SL000003', '31-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000654', 'DT000001', 'SL000004', '31-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000655', 'DT000002', 'SL000001', '31-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000656', 'DT000002', 'SL000002', '31-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000657', 'DT000002', 'SL000003', '31-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000658', 'DT000002', 'SL000004', '31-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000659', 'DT000002', 'SL000005', '31-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000660', 'DT000003', 'SL000001', '31-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000661', 'DT000003', 'SL000002', '31-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000662', 'DT000003', 'SL000003', '31-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000663', 'DT000003', 'SL000004', '31-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000664', 'DT000004', 'SL000001', '31-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000665', 'DT000004', 'SL000002', '31-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000666', 'DT000004', 'SL000003', '31-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000667', 'DT000004', 'SL000004', '31-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000668', 'DT000004', 'SL000005', '31-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000669', 'DT000005', 'SL000001', '31-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000670', 'DT000005', 'SL000002', '31-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000671', 'DT000005', 'SL000003', '31-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000672', 'DT000005', 'SL000004', '31-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000673', 'DT000006', 'SL000001', '31-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000674', 'DT000006', 'SL000002', '31-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000675', 'DT000006', 'SL000003', '31-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000676', 'DT000006', 'SL000004', '31-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000677', 'DT000006', 'SL000005', '31-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000678', 'DT000007', 'SL000001', '31-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000679', 'DT000007', 'SL000002', '31-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000680', 'DT000007', 'SL000003', '31-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000681', 'DT000007', 'SL000004', '31-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000682', 'DT000008', 'SL000001', '31-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000683', 'DT000008', 'SL000002', '31-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000684', 'DT000008', 'SL000003', '31-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000685', 'DT000008', 'SL000004', '31-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000686', 'DT000008', 'SL000005', '31-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000687', 'DT000009', 'SL000001', '31-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000688', 'DT000009', 'SL000002', '31-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000689', 'DT000009', 'SL000003', '31-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000690', 'DT000009', 'SL000004', '31-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000691', 'DT000010', 'SL000001', '31-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000692', 'DT000010', 'SL000002', '31-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000693', 'DT000010', 'SL000003', '31-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000694', 'DT000010', 'SL000004', '31-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000695', 'DT000010', 'SL000005', '31-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000696', 'DT000011', 'SL000001', '31-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000697', 'DT000011', 'SL000002', '31-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000698', 'DT000011', 'SL000003', '31-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000699', 'DT000011', 'SL000004', '31-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000700', 'DT000012', 'SL000001', '31-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000701', 'DT000012', 'SL000002', '31-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000702', 'DT000012', 'SL000003', '31-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000703', 'DT000012', 'SL000004', '31-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000704', 'DT000012', 'SL000005', '31-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000705', 'DT000013', 'SL000001', '31-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000706', 'DT000013', 'SL000002', '31-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000707', 'DT000013', 'SL000003', '31-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000708', 'DT000013', 'SL000004', '31-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000709', 'DT000014', 'SL000001', '31-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000710', 'DT000014', 'SL000002', '31-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000711', 'DT000014', 'SL000003', '31-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000712', 'DT000014', 'SL000004', '31-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000713', 'DT000014', 'SL000005', '31-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000714', 'DT000015', 'SL000001', '31-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000715', 'DT000015', 'SL000002', '31-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000716', 'DT000015', 'SL000003', '31-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000717', 'DT000015', 'SL000004', '31-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000718', 'DT000016', 'SL000001', '31-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000719', 'DT000016', 'SL000002', '31-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000720', 'DT000016', 'SL000003', '31-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000721', 'DT000016', 'SL000004', '31-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000722', 'DT000016', 'SL000005', '31-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000723', 'DT000017', 'SL000001', '31-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000724', 'DT000017', 'SL000002', '31-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000725', 'DT000017', 'SL000003', '31-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000726', 'DT000017', 'SL000004', '31-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000727', 'DT000018', 'SL000001', '31-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000728', 'DT000018', 'SL000002', '31-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000729', 'DT000018', 'SL000003', '31-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000730', 'DT000018', 'SL000004', '31-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000731', 'DT000018', 'SL000005', '31-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000732', 'DT000019', 'SL000001', '31-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000733', 'DT000019', 'SL000002', '31-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000734', 'DT000019', 'SL000003', '31-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000735', 'DT000019', 'SL000004', '31-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000736', 'DT000020', 'SL000001', '31-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000737', 'DT000020', 'SL000002', '31-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000738', 'DT000020', 'SL000003', '31-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000739', 'DT000020', 'SL000004', '31-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000740', 'DT000020', 'SL000005', '31-07-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000741', 'DT000001', 'SL000001', '01-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000742', 'DT000001', 'SL000002', '01-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000743', 'DT000001', 'SL000003', '01-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000744', 'DT000001', 'SL000004', '01-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000745', 'DT000002', 'SL000001', '01-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000746', 'DT000002', 'SL000002', '01-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000747', 'DT000002', 'SL000003', '01-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000748', 'DT000002', 'SL000004', '01-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000749', 'DT000002', 'SL000005', '01-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000750', 'DT000003', 'SL000001', '01-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000751', 'DT000003', 'SL000002', '01-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000752', 'DT000003', 'SL000003', '01-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000753', 'DT000003', 'SL000004', '01-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000754', 'DT000004', 'SL000001', '01-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000755', 'DT000004', 'SL000002', '01-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000756', 'DT000004', 'SL000003', '01-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000757', 'DT000004', 'SL000004', '01-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000758', 'DT000004', 'SL000005', '01-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000759', 'DT000005', 'SL000001', '01-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000760', 'DT000005', 'SL000002', '01-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000761', 'DT000005', 'SL000003', '01-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000762', 'DT000005', 'SL000004', '01-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000763', 'DT000006', 'SL000001', '01-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000764', 'DT000006', 'SL000002', '01-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000765', 'DT000006', 'SL000003', '01-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000766', 'DT000006', 'SL000004', '01-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000767', 'DT000006', 'SL000005', '01-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000768', 'DT000007', 'SL000001', '01-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000769', 'DT000007', 'SL000002', '01-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000770', 'DT000007', 'SL000003', '01-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000771', 'DT000007', 'SL000004', '01-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000772', 'DT000008', 'SL000001', '01-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000773', 'DT000008', 'SL000002', '01-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000774', 'DT000008', 'SL000003', '01-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000775', 'DT000008', 'SL000004', '01-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000776', 'DT000008', 'SL000005', '01-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000777', 'DT000009', 'SL000001', '01-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000778', 'DT000009', 'SL000002', '01-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000779', 'DT000009', 'SL000003', '01-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000780', 'DT000009', 'SL000004', '01-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000781', 'DT000010', 'SL000001', '01-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000782', 'DT000010', 'SL000002', '01-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000783', 'DT000010', 'SL000003', '01-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000784', 'DT000010', 'SL000004', '01-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000785', 'DT000010', 'SL000005', '01-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000786', 'DT000011', 'SL000001', '01-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000787', 'DT000011', 'SL000002', '01-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000788', 'DT000011', 'SL000003', '01-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000789', 'DT000011', 'SL000004', '01-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000790', 'DT000012', 'SL000001', '01-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000791', 'DT000012', 'SL000002', '01-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000792', 'DT000012', 'SL000003', '01-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000793', 'DT000012', 'SL000004', '01-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000794', 'DT000012', 'SL000005', '01-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000795', 'DT000013', 'SL000001', '01-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000796', 'DT000013', 'SL000002', '01-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000797', 'DT000013', 'SL000003', '01-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000798', 'DT000013', 'SL000004', '01-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000799', 'DT000014', 'SL000001', '01-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000800', 'DT000014', 'SL000002', '01-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000801', 'DT000014', 'SL000003', '01-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000802', 'DT000014', 'SL000004', '01-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000803', 'DT000014', 'SL000005', '01-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000804', 'DT000015', 'SL000001', '01-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000805', 'DT000015', 'SL000002', '01-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000806', 'DT000015', 'SL000003', '01-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000807', 'DT000015', 'SL000004', '01-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000808', 'DT000016', 'SL000001', '01-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000809', 'DT000016', 'SL000002', '01-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000810', 'DT000016', 'SL000003', '01-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000811', 'DT000016', 'SL000004', '01-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000812', 'DT000016', 'SL000005', '01-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000813', 'DT000017', 'SL000001', '01-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000814', 'DT000017', 'SL000002', '01-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000815', 'DT000017', 'SL000003', '01-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000816', 'DT000017', 'SL000004', '01-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000817', 'DT000018', 'SL000001', '01-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000818', 'DT000018', 'SL000002', '01-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000819', 'DT000018', 'SL000003', '01-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000820', 'DT000018', 'SL000004', '01-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000821', 'DT000018', 'SL000005', '01-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000822', 'DT000019', 'SL000001', '01-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000823', 'DT000019', 'SL000002', '01-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000824', 'DT000019', 'SL000003', '01-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000825', 'DT000019', 'SL000004', '01-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000826', 'DT000020', 'SL000001', '01-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000827', 'DT000020', 'SL000002', '01-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000828', 'DT000020', 'SL000003', '01-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000829', 'DT000020', 'SL000004', '01-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000830', 'DT000020', 'SL000005', '01-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000831', 'DT000001', 'SL000001', '02-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000832', 'DT000001', 'SL000002', '02-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000833', 'DT000001', 'SL000003', '02-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000834', 'DT000001', 'SL000004', '02-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000835', 'DT000001', 'SL000005', '02-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000836', 'DT000002', 'SL000001', '02-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000837', 'DT000002', 'SL000002', '02-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000838', 'DT000002', 'SL000003', '02-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000839', 'DT000002', 'SL000004', '02-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000840', 'DT000003', 'SL000001', '02-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000841', 'DT000003', 'SL000002', '02-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000842', 'DT000003', 'SL000003', '02-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000843', 'DT000003', 'SL000004', '02-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000844', 'DT000003', 'SL000005', '02-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000845', 'DT000004', 'SL000001', '02-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000846', 'DT000004', 'SL000002', '02-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000847', 'DT000004', 'SL000003', '02-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000848', 'DT000004', 'SL000004', '02-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000849', 'DT000005', 'SL000001', '02-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000850', 'DT000005', 'SL000002', '02-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000851', 'DT000005', 'SL000003', '02-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000852', 'DT000005', 'SL000004', '02-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000853', 'DT000005', 'SL000005', '02-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000854', 'DT000006', 'SL000001', '02-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000855', 'DT000006', 'SL000002', '02-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000856', 'DT000006', 'SL000003', '02-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000857', 'DT000006', 'SL000004', '02-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000858', 'DT000007', 'SL000001', '02-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000859', 'DT000007', 'SL000002', '02-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000860', 'DT000007', 'SL000003', '02-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000861', 'DT000007', 'SL000004', '02-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000862', 'DT000007', 'SL000005', '02-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000863', 'DT000008', 'SL000001', '02-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000864', 'DT000008', 'SL000002', '02-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000865', 'DT000008', 'SL000003', '02-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000866', 'DT000008', 'SL000004', '02-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000867', 'DT000009', 'SL000001', '02-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000868', 'DT000009', 'SL000002', '02-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000869', 'DT000009', 'SL000003', '02-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000870', 'DT000009', 'SL000004', '02-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000871', 'DT000009', 'SL000005', '02-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000872', 'DT000010', 'SL000001', '02-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000873', 'DT000010', 'SL000002', '02-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000874', 'DT000010', 'SL000003', '02-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000875', 'DT000010', 'SL000004', '02-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000876', 'DT000011', 'SL000001', '02-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000877', 'DT000011', 'SL000002', '02-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000878', 'DT000011', 'SL000003', '02-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000879', 'DT000011', 'SL000004', '02-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000880', 'DT000011', 'SL000005', '02-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000881', 'DT000012', 'SL000001', '02-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000882', 'DT000012', 'SL000002', '02-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000883', 'DT000012', 'SL000003', '02-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000884', 'DT000012', 'SL000004', '02-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000885', 'DT000013', 'SL000001', '02-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000886', 'DT000013', 'SL000002', '02-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000887', 'DT000013', 'SL000003', '02-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000888', 'DT000013', 'SL000004', '02-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000889', 'DT000013', 'SL000005', '02-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000890', 'DT000014', 'SL000001', '02-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000891', 'DT000014', 'SL000002', '02-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000892', 'DT000014', 'SL000003', '02-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000893', 'DT000014', 'SL000004', '02-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000894', 'DT000015', 'SL000001', '02-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000895', 'DT000015', 'SL000002', '02-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000896', 'DT000015', 'SL000003', '02-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000897', 'DT000015', 'SL000004', '02-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000898', 'DT000015', 'SL000005', '02-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000899', 'DT000016', 'SL000001', '02-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000900', 'DT000016', 'SL000002', '02-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000901', 'DT000016', 'SL000003', '02-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000902', 'DT000016', 'SL000004', '02-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000903', 'DT000017', 'SL000001', '02-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000904', 'DT000017', 'SL000002', '02-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000905', 'DT000017', 'SL000003', '02-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000906', 'DT000017', 'SL000004', '02-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000907', 'DT000017', 'SL000005', '02-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000908', 'DT000018', 'SL000001', '02-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000909', 'DT000018', 'SL000002', '02-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000910', 'DT000018', 'SL000003', '02-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000911', 'DT000018', 'SL000004', '02-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000912', 'DT000019', 'SL000001', '02-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000913', 'DT000019', 'SL000002', '02-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000914', 'DT000019', 'SL000003', '02-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000915', 'DT000019', 'SL000004', '02-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000916', 'DT000019', 'SL000005', '02-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000917', 'DT000020', 'SL000001', '02-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000918', 'DT000020', 'SL000002', '02-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000919', 'DT000020', 'SL000003', '02-08-2025');
INSERT INTO DoctorWorkSchedule VALUES ('DW000920', 'DT000020', 'SL000004', '02-08-2025');

-- 7. Bảng ARVProtocol

INSERT INTO ARVProtocol VALUES 
('AP000001', 'TDF + 3TC (or FTC) +DTG1', 'Tenofovir-Lamivudine(or Emtricitabine)-Dolutegravir', 
 'Adults including pregnant or breastfeeding women and children aged 10 years and older(first line ARV Protocol)', '10+', 'Adults', CURRENT_TIMESTAMP);
INSERT INTO ARVProtocol VALUES 
('AP000002', 'TDF + 3TC + EFV 400mg', 'Tenofovir-Lamivudine-Efavirenz', 
 'Adults including pregnant or breastfeeding women and children aged 10 years and older (Alternative first line ARV Protocol)', '10+', 'Adults', CURRENT_TIMESTAMP);
INSERT INTO ARVProtocol VALUES 
('AP000003', 'ABC + 3TC + DTG3', 'Abacavir-Lamivudine-Dolutegravir', 
 'Children under 10 years old (first line ARV Protocol)', '10-', 'Children', CURRENT_TIMESTAMP);
INSERT INTO ARVProtocol VALUES 
('AP000004', 'ABC+3TC+ LPV/r', 'Abacavir-Lamivudine-Lopinavir/Ritonavir', 
 'Children under 10 years old (Alternative first line ARV Protocol)', '10-', 'Children', CURRENT_TIMESTAMP);
INSERT INTO ARVProtocol VALUES 
('AP000005', 'AZT (or ABC) + 3TC + RAL6', 'Zidovudine(or Abacavir)-Lamivudine-Raltegravir', 
 'Newborns (under 4 weeks of age first line ARV Protocol)', 'under 4 weeks', 'Babies', CURRENT_TIMESTAMP);
INSERT INTO ARVProtocol VALUES 
('AP000006', 'AZT+3TC+NVP', 'Zidovudine-Lamivudine-Nevirapine', 
 'Newborns (under 4 weeks of age, alternative first line ARV Protocol)', 'under 4 weeks','Babies', CURRENT_TIMESTAMP);
INSERT INTO ARVProtocol VALUES 
('AP000007', 'TDF + 3TC (or FTC) +PI/r', 'Tenofovir-Lamivudine(or Emtricitabine)-Protease inhibitor/Ritonavir', 
 'Adults including pregnant or breastfeeding women and children aged 10 years and older (Special regimen, first line ARV Protocol)', '10+', 'Adults', CURRENT_TIMESTAMP);
INSERT INTO ARVProtocol VALUES 
('AP000008', 'ABC + 3TC + EFV5 (or NVP)', 'Abacavir-Lamivudine-Efavirenz(or Nevirapine)', 
 'Children under 10 years old (Special regimen, first line ARV Protocol)', '10-', 'Children', CURRENT_TIMESTAMP);
INSERT INTO ARVProtocol VALUES 
('AP000009', 'AZT+3TC+LPV/r7', 'Zidovudine-Lamivudine-Lopinavir/Ritonavir', 
 'Newborns (under 4 weeks of age, special regimen, first line ARV Protocol)', 'under 4 weeks', 'Babies', CURRENT_TIMESTAMP);
INSERT INTO ARVProtocol VALUES ('AP000010', 'AZT + 3TC + LPV/r', 'Zidovudine + Lamivudine + Lopinavir/ritonavir', 'Adults and children aged 10 years and older (Preferred second-line regimen)', '10+', 'Adults and children aged 10 years and above', CURRENT_TIMESTAMP);
INSERT INTO ARVProtocol VALUES ('AP000011', 'AZT + 3TC + DTG', 'Zidovudine + Lamivudine + Dolutegravir', 'Adults and children aged 10 years and older (Preferred second-line regimen)', '10+', 'Adults and children aged 10 years and above', CURRENT_TIMESTAMP);
INSERT INTO ARVProtocol VALUES ('AP000012', 'TDF + 3TC (or FTC) + DTG', 'Tenofovir disoproxil fumarate + Lamivudine (or Emtricitabine) + Dolutegravir', 'Adults and children aged 10 years and older (Preferred second-line regimen)', '10+', 'Adults and children aged 10 years and above', CURRENT_TIMESTAMP);
INSERT INTO ARVProtocol VALUES ('AP000013', 'AZT+ 3TC + LPV/r', 'Zidovudine (AZT) + Lamivudine (3TC) + Lopinavir/ritonavir (LPV/r)', 'Children under 10 years old(Preferred second-line regimen)', '10-', 'Children under 10 years old', CURRENT_TIMESTAMP);
INSERT INTO ARVProtocol VALUES ('AP000014', 'ABC + 3TC + DTG', 'Abacavir (ABC) + Lamivudine (3TC) + Dolutegravir (DTG)', 'Children under 10 years old(Preferred second-line regimen)', '10-', 'Children under 10 years old', CURRENT_TIMESTAMP);
INSERT INTO ARVProtocol VALUES ('AP000015', 'AZT (or ABC) + 3TC + DTG', 'Zidovudine (or Abacavir) + Lamivudine + Dolutegravir', 'Children under 10 years old(Preferred second-line regimen)', '10-', 'Children under 10 years old', CURRENT_TIMESTAMP);
INSERT INTO ARVProtocol VALUES ('AP000016', 'DRV/r1 + 1-2 NRTIs ± DTG2', 'Darunavir/Ritonavir + 1-2 Nucleoside Reverse Transcriptase Inhibitors ± Dolutegravir', 'Adults including pregnant or breastfeeding women and children aged 10 years and older(three line ARV Protocol)', '10+', 'Adults', CURRENT_TIMESTAMP);
INSERT INTO ARVProtocol VALUES ('AP000017', 'DRV/r1,3 + 1-2 NRTIs ± DTG2,4', 'Darunavir/Ritonavir + 1-2 Nucleoside Reverse Transcriptase Inhibitors ± Dolutegravir', 'Children under 10 years old(three line ARV Protocol)', '10-', 'Children', CURRENT_TIMESTAMP);

-- 8. Bảng TreatmentPlan

INSERT INTO TreatmentPlan VALUES ('TP000001', 'PT000001', 'DT000001', 'AP000001', 1, 'HIV stage 1', N'Đang điều trị', CURRENT_TIMESTAMP);
INSERT INTO TreatmentPlan VALUES ('TP000002', 'PT000002', 'DT000002', 'AP000002', 1, 'HIV stage 2', N'Đang điều trị', CURRENT_TIMESTAMP);
INSERT INTO TreatmentPlan VALUES ('TP000003', 'PT000003', 'DT000003', 'AP000003', 2, 'HIV stage 3', N'Đang điều trị', CURRENT_TIMESTAMP);
INSERT INTO TreatmentPlan VALUES ('TP000004', 'PT000004', 'DT000004', 'AP000004', 1, 'HIV stage 1', N'Đang điều trị', CURRENT_TIMESTAMP);
INSERT INTO TreatmentPlan VALUES ('TP000005', 'PT000005', 'DT000005', 'AP000005', 2, 'HIV stage 2', N'Đang điều trị', CURRENT_TIMESTAMP);
INSERT INTO TreatmentPlan VALUES ('TP000006', 'PT000006', 'DT000006', 'AP000006', 1, 'HIV stage 1', N'Đang điều trị', CURRENT_TIMESTAMP);
INSERT INTO TreatmentPlan VALUES ('TP000007', 'PT000007', 'DT000007', 'AP000007', 3, 'HIV stage 3', N'Đang điều trị', CURRENT_TIMESTAMP);
INSERT INTO TreatmentPlan VALUES ('TP000008', 'PT000008', 'DT000008', 'AP000008', 2, 'HIV stage 2', N'Đang điều trị', CURRENT_TIMESTAMP);
INSERT INTO TreatmentPlan VALUES ('TP000009', 'PT000009', 'DT000009', 'AP000009', 1, 'HIV stage 1', N'Đang điều trị', CURRENT_TIMESTAMP);
INSERT INTO TreatmentPlan VALUES ('TP000010', 'PT000010', 'DT000010', 'AP000010', 2, 'HIV stage 2', N'Đang điều trị', CURRENT_TIMESTAMP);

INSERT INTO TreatmentPlan VALUES ('TP000011', 'PT000011', 'DT000011', 'AP000011', 1, 'HIV stage 1', N'Đang điều trị', CURRENT_TIMESTAMP);
INSERT INTO TreatmentPlan VALUES ('TP000012', 'PT000012', 'DT000012', 'AP000012', 2, 'HIV stage 2', N'Cải thiện tích cực', CURRENT_TIMESTAMP);
INSERT INTO TreatmentPlan VALUES ('TP000013', 'PT000013', 'DT000013', 'AP000013', 1, 'HIV stage 2', N'Đã bắt đầu ARV', CURRENT_TIMESTAMP);
INSERT INTO TreatmentPlan VALUES ('TP000014', 'PT000014', 'DT000014', 'AP000014', 2, 'HIV stage 2', N'Theo dõi sát sao', CURRENT_TIMESTAMP);
INSERT INTO TreatmentPlan VALUES ('TP000015', 'PT000015', 'DT000015', 'AP000015', 1, 'HIV stage 1', N'Tiến triển chậm', CURRENT_TIMESTAMP);
INSERT INTO TreatmentPlan VALUES ('TP000016', 'PT000016', 'DT000016', 'AP000016', 3, 'HIV stage 3', N'Điều trị kháng thuốc', CURRENT_TIMESTAMP);
INSERT INTO TreatmentPlan VALUES ('TP000017', 'PT000017', 'DT000017', 'AP000017', 2, 'HIV stage 2', N'Ổn định sau điều trị', CURRENT_TIMESTAMP);
INSERT INTO TreatmentPlan VALUES ('TP000018', 'PT000018', 'DT000018', 'AP000011', 1, 'HIV stage 2', N'Trung bình, cần theo dõi', CURRENT_TIMESTAMP);
INSERT INTO TreatmentPlan VALUES ('TP000019', 'PT000019', 'DT000019', 'AP000012', 2, 'HIV stage 2', N'Đã đạt tải lượng virus không phát hiện', CURRENT_TIMESTAMP);
INSERT INTO TreatmentPlan VALUES ('TP000020', 'PT000020', 'DT000020', 'AP000013', 3, 'HIV stage 2', N'Tiến hành điều trị phối hợp', CURRENT_TIMESTAMP);



-- 9. Bảng Medication
/*
INSERT INTO Medication VALUES ('MD000001', 'Tenofovir-Lamivudine(or Emtricitabine)-Dolutegravir', 'Tablet', '300mg', 'aldults', 'a', 'a', 'a',CURRENT_TIMESTAMP);
INSERT INTO Medication VALUES ('MD000002', 'Tenofovir-Lamivudine-Efavirenz', 'Tablet', '150mg', 'Aldults','a', 'a', 'a', CURRENT_TIMESTAMP);
INSERT INTO Medication VALUES ('MD000003', 'Abacavir-Lamivudine-Dolutegravir', 'Tablet', '50mg', 'Children under 10 years old', 'a', 'a', 'a',CURRENT_TIMESTAMP);
INSERT INTO Medication VALUES ('MD000004', 'Abacavir-Lamivudine-Lopinavir/Ritonavir', 'Tablet', '200mg', 'Children', 'a', 'a', 'a',CURRENT_TIMESTAMP);
INSERT INTO Medication VALUES ('MD000005', 'Zidovudine(or Abacavir)-Lamivudine-Raltegravir', 'Capsule', '10mg', 'Babies','a', 'a', 'a', CURRENT_TIMESTAMP);
INSERT INTO Medication VALUES ('MD000006', 'Zidovudine-Lamivudine-Nevirapine', 'Tablet', '10mg', 'Babies','a', 'a', 'a', CURRENT_TIMESTAMP);
INSERT INTO Medication VALUES ('MD000007', 'Tenofovir-Lamivudine(or Emtricitabine)-Protease inhibitor/Ritonavir', 'Tablet', '300mg', 'Children', 'a', 'a', 'a',CURRENT_TIMESTAMP);
INSERT INTO Medication VALUES ('MD000008', 'Abacavir-Lamivudine-Efavirenz(or Nevirapine)', 'Tablet', '400mg', 'Children','a', 'a', 'a', CURRENT_TIMESTAMP);
INSERT INTO Medication VALUES ('MD000009', 'Zidovudine-Lamivudine-Lopinavir/Ritonavir', 'Tablet', '10mg', 'Babies','a', 'a', 'a', CURRENT_TIMESTAMP);
INSERT INTO Medication VALUES ('MD000010', 'Zidovudine + Lamivudine + Lopinavir/ritonavir', 'Tablet', '100mg', 'Adults and children aged 10 years and above', 'a', 'a', 'a',CURRENT_TIMESTAMP);
*/
INSERT INTO Medication VALUES ('MD000001', 'Tenofovir-Lamivudine(or Emtricitabine)-Dolutegravir', 'Tablet', '300mg', 'Adults', N'Effective first-line treatment', N'Take once daily', N'Monitor kidney function', CURRENT_TIMESTAMP);
INSERT INTO Medication VALUES ('MD000002', 'Tenofovir-Lamivudine-Efavirenz', 'Tablet', '150mg', 'Adults', N'Widely used and available', N'Take at bedtime', N'Can cause vivid dreams', CURRENT_TIMESTAMP);
INSERT INTO Medication VALUES ('MD000003', 'Abacavir-Lamivudine-Dolutegravir', 'Tablet', '50mg', 'Children under 10 years old', N'Good resistance profile', N'Take once daily', N'Test for HLA-B*5701', CURRENT_TIMESTAMP);
INSERT INTO Medication VALUES ('MD000004', 'Abacavir-Lamivudine-Lopinavir/Ritonavir', 'Tablet', '200mg', 'Children', N'Effective pediatric option', N'Take with food', N'May cause diarrhea', CURRENT_TIMESTAMP);
INSERT INTO Medication VALUES ('MD000005', 'Zidovudine(or Abacavir)-Lamivudine-Raltegravir', 'Capsule', '10mg', 'Babies', N'Used in neonates', N'Twice daily dosing', N'Monitor anemia', CURRENT_TIMESTAMP);
INSERT INTO Medication VALUES ('MD000006', 'Zidovudine-Lamivudine-Nevirapine', 'Tablet', '10mg', 'Babies', N'Used in infants', N'Give after birth', N'Monitor liver function', CURRENT_TIMESTAMP);
INSERT INTO Medication VALUES ('MD000007', 'Tenofovir-Lamivudine(or Emtricitabine)-Protease inhibitor/Ritonavir', 'Tablet', '300mg', 'Children', N'Strong viral suppression', N'Take with food', N'Monitor cholesterol', CURRENT_TIMESTAMP);
INSERT INTO Medication VALUES ('MD000008', 'Abacavir-Lamivudine-Efavirenz(or Nevirapine)', 'Tablet', '400mg', 'Children', N'Alternative regimen', N'Take at bedtime', N'Monitor for rash', CURRENT_TIMESTAMP);
INSERT INTO Medication VALUES ('MD000009', 'Zidovudine-Lamivudine-Lopinavir/Ritonavir', 'Tablet', '10mg', 'Babies', N'Commonly used for babies', N'Oral option available', N'Store properly', CURRENT_TIMESTAMP);
INSERT INTO Medication VALUES ('MD000010', 'Zidovudine + Lamivudine + Lopinavir/ritonavir', 'Tablet', '100mg', 'Adults and children aged 10 years and above', N'Fixed-dose combination', N'Take with food', N'Monitor blood count', CURRENT_TIMESTAMP);

-- 10. Bảng Prescription

INSERT INTO Prescription VALUES ('PR000001', 'TP000001', 'MD000001', 'DT000001', '10-04-2025', '10-07-2025', N'1 viên mỗi ngày', 'First-line', CURRENT_TIMESTAMP);
INSERT INTO Prescription VALUES ('PR000002', 'TP000002', 'MD000002', 'DT000002', '15-05-2025', '15-08-2025', N'1 viên 2 lần mỗi ngày', 'First-line', CURRENT_TIMESTAMP);
INSERT INTO Prescription VALUES ('PR000003', 'TP000003', 'MD000003', 'DT000003', '20-06-2025', '20-09-2025', N'1 viên mỗi ngày', 'Second-line', CURRENT_TIMESTAMP);
INSERT INTO Prescription VALUES ('PR000004', 'TP000004', 'MD000004', 'DT000004', '25-04-2025', '25-10-2025', N'1 viên mỗi tối', 'First-line', CURRENT_TIMESTAMP);
INSERT INTO Prescription VALUES ('PR000005', 'TP000005', 'MD000005', 'DT000005', '05-05-2025', '05-11-2025', N'1 viên 2 lần mỗi ngày', 'Second-line', CURRENT_TIMESTAMP);
INSERT INTO Prescription VALUES ('PR000006', 'TP000006', 'MD000006', 'DT000006', '10-06-2025', '10-12-2025', N'1 viên 2 lần mỗi ngày', 'First-line', CURRENT_TIMESTAMP);
INSERT INTO Prescription VALUES ('PR000007', 'TP000007', 'MD000007', 'DT000007', '15-04-2025', '15-06-2025', N'1 viên 2 lần mỗi ngày', 'Third-line', CURRENT_TIMESTAMP);
INSERT INTO Prescription VALUES ('PR000008', 'TP000008', 'MD000008', 'DT000008', '20-05-2025', '20-08-2025', N'1 viên 2 lần mỗi ngày', 'Second-line', CURRENT_TIMESTAMP);
INSERT INTO Prescription VALUES ('PR000009', 'TP000009', 'MD000009', 'DT000009', '25-04-2025', '25-09-2025', N'1 viên 2 lần mỗi ngày', 'First-line', CURRENT_TIMESTAMP);
INSERT INTO Prescription VALUES ('PR000010', 'TP000010', 'MD000010', 'DT000010', '30-04-2025', '30-09-2025', N'1 viên mỗi ngày với thức ăn', 'Second-line', CURRENT_TIMESTAMP);

INSERT INTO Prescription VALUES ('PR000011', 'TP000011', 'MD000001', 'DT000011', '11-04-2025', '11-07-2025', N'1 viên mỗi ngày', 'First-line', CURRENT_TIMESTAMP);
INSERT INTO Prescription VALUES ('PR000012', 'TP000012', 'MD000002', 'DT000012', '12-04-2025', '12-07-2025', N'1 viên mỗi sáng', 'Second-line', CURRENT_TIMESTAMP);
INSERT INTO Prescription VALUES ('PR000013', 'TP000013', 'MD000003', 'DT000013', '13-04-2025', '13-07-2025', N'1 viên 2 lần mỗi ngày', 'Third-line', CURRENT_TIMESTAMP);
INSERT INTO Prescription VALUES ('PR000014', 'TP000014', 'MD000004', 'DT000014', '14-04-2025', '14-07-2025', N'1 viên sau ăn', 'First-line', CURRENT_TIMESTAMP);
INSERT INTO Prescription VALUES ('PR000015', 'TP000015', 'MD000005', 'DT000015', '15-04-2025', '15-07-2025', N'1 viên mỗi tối', 'Second-line', CURRENT_TIMESTAMP);
INSERT INTO Prescription VALUES ('PR000016', 'TP000016', 'MD000006', 'DT000016', '16-04-2025', '16-07-2025', N'1 viên mỗi ngày', 'First-line', CURRENT_TIMESTAMP);
INSERT INTO Prescription VALUES ('PR000017', 'TP000017', 'MD000007', 'DT000017', '17-04-2025', '17-07-2025', N'1 viên 3 lần mỗi ngày', 'Third-line', CURRENT_TIMESTAMP);
INSERT INTO Prescription VALUES ('PR000018', 'TP000018', 'MD000008', 'DT000018', '18-04-2025', '18-07-2025', N'1 viên buổi trưa', 'Second-line', CURRENT_TIMESTAMP);
INSERT INTO Prescription VALUES ('PR000019', 'TP000019', 'MD000009', 'DT000019', '19-04-2025', '19-07-2025', N'1 viên mỗi ngày với nước ấm', 'First-line', CURRENT_TIMESTAMP);
INSERT INTO Prescription VALUES ('PR000020', 'TP000020', 'MD000010', 'DT000020', '20-04-2025', '20-07-2025', N'1 viên mỗi ngày với thức ăn', 'Second-line', CURRENT_TIMESTAMP);



-- 11. Bảng Booking
INSERT INTO Booking VALUES ('BK000001', 'PT000001', 'DT000001', N'Tư vấn', 'CD4, Viral Load', '10-01-2025 09:00:00', N'Thành công', N'Tái khám định kỳ');
INSERT INTO Booking VALUES ('BK000002', 'PT000002', 'DT000002', N'Khám mới', 'None', '18-01-2025 10:00:00', N'Thành công',  N'Khám lần đầu');
INSERT INTO Booking VALUES ('BK000003', 'PT000003', 'DT000003', N'Tái khám', 'CD4', '25-02-2025 11:00:00', N'Thành công', N'Đánh giá sau 3 tháng');
INSERT INTO Booking VALUES ('BK000004', 'PT000004', 'DT000004', N'Cấp cứu', 'Full Panel', '03-03-2025 08:00:00', N'Thành công',  N'Sốt cao, khó thở');
INSERT INTO Booking VALUES ('BK000005', 'PT000005', 'DT000005', N'Tư vấn', 'None', '12-03-2025 14:00:00', N'Đã hủy',  N'Tư vấn dinh dưỡng');
INSERT INTO Booking VALUES ('BK000006', 'PT000006', 'DT000006', N'Tái khám', 'Viral Load', '26-04-2025 15:00:00', N'Thành công', N'Đánh giá sau 6 tháng');
INSERT INTO Booking VALUES ('BK000007', 'PT000007', 'DT000007', N'Khám mới', 'CD4, Viral Load', '08-05-2025 16:00:00', N'Thành công',  N'Chuyển từ cơ sở khác');
INSERT INTO Booking VALUES ('BK000008', 'PT000008', 'DT000008', N'Theo dõi', 'CD4', '14-05-2025 11:00:00', N'Thành công',  N'Theo dõi tác dụng phụ');
INSERT INTO Booking VALUES ('BK000009', 'PT000009', 'DT000009', N'Tư vấn', 'None', '05-06-2025 09:00:00', N'Thành công', N'Tư vấn tâm lý');
INSERT INTO Booking VALUES ('BK000010', 'PT000010', 'DT000010', N'Tái khám', 'Full Panel', '20-06-2025 10:00:00', N'Thành công',  N'Đánh giá toàn diện sau 1 năm');

INSERT INTO Booking VALUES ('BK000011', 'PT000011', 'DT000011', N'Tư vấn', 'CD4', '06-01-2025 09:00:00', N'Thành công',  N'Tư vấn kết quả xét nghiệm');
INSERT INTO Booking VALUES ('BK000012', 'PT000012', 'DT000012', N'Tái khám', 'Viral Load', '13-01-2025 10:00:00', N'Thành công',N'Tái khám theo lịch');
INSERT INTO Booking VALUES ('BK000013', 'PT000013', 'DT000013', N'Khám mới', 'None', '22-02-2025 14:00:00', N'Thành công', N'Khám lần đầu tại cơ sở');
INSERT INTO Booking VALUES ('BK000014', 'PT000014', 'DT000014', N'Cấp cứu', 'Full Panel', '01-03-2025 08:30:00', N'Thành công',  N'Bệnh nhân sốt cao');
INSERT INTO Booking VALUES ('BK000015', 'PT000015', 'DT000015', N'Theo dõi', 'CD4', '17-03-2025 15:45:00', N'Thành công', N'Theo dõi tác dụng phụ thuốc');
INSERT INTO Booking VALUES ('BK000016', 'PT000016', 'DT000016', N'Tư vấn', 'None', '28-03-2025 13:15:00', N'Thành công',  N'Tư vấn chăm sóc sức khỏe');
INSERT INTO Booking VALUES ('BK000017', 'PT000017', 'DT000017', N'Tái khám', 'CD4, Viral Load', '04-04-2025 11:00:00', N'Thành công', N'Tái khám định kỳ');
INSERT INTO Booking VALUES ('BK000018', 'PT000018', 'DT000018', N'Khám mới', 'None', '19-04-2025 10:00:00', N'Đã hủy',  N'Bệnh nhân tự hủy lịch');
INSERT INTO Booking VALUES ('BK000019', 'PT000019', 'DT000019', N'Tư vấn', 'None', '02-05-2025 09:00:00', N'Thành công',  N'Hỗ trợ tâm lý');
INSERT INTO Booking VALUES ('BK000020', 'PT000020', 'DT000020', N'Tái khám', 'Full Panel', '16-06-2025 14:30:00', N'Thành công', N'Tổng kiểm tra giữa năm');
--12. Bảng LabTests

INSERT INTO LabTests VALUES ('LT000001', 'BK000001', 'CD4 Count', 'Immunology', '450 cells/mm³', 350, 10000, N'Hoàn thành', N'Cần theo dõi');
INSERT INTO LabTests VALUES ('LT000002', 'BK000002', 'Viral Load', 'Virology', 'Undetectable <20 copies/ml', 350, 100000, N'Hoàn thành', N'Kết quả tốt');
INSERT INTO LabTests VALUES ('LT000003', 'BK000003', 'Complete Blood Count', 'Hematology', 'Normal', 400, 9000, N'Hoàn thành', N'Đang xử lý kết quả');
INSERT INTO LabTests VALUES ('LT000004', 'BK000004', 'Liver Function Test', 'Biochemistry', 'ALT: 45, AST: 42', 350, 10000, N'Hoàn thành', N'Chức năng gan bình thường');
INSERT INTO LabTests VALUES ('LT000005', 'BK000005', 'Kidney Function Test', 'Biochemistry', 'Creatinine: 0.9', 350, 8000, N'Hoàn thành', N'Đang xử lý kết quả');
INSERT INTO LabTests VALUES ('LT000006', 'BK000006', 'CD4 Count', 'Immunology', '650 cells/mm³', 600, 7000, N'Hoàn thành', N'Kết quả tốt');
INSERT INTO LabTests VALUES ('LT000007', 'BK000007', 'HIV Resistance Test', 'Molecular', 'No resistance detected', 400, 8000, N'Hoàn thành', N'Không phát hiện kháng thuốc');
INSERT INTO LabTests VALUES ('LT000008', 'BK000008', 'Tuberculosis Test', 'Microbiology', 'Negative', 500, 10000, N'Hoàn thành', N'Cần thực hiện lại');
INSERT INTO LabTests VALUES ('LT000009', 'BK000009', 'Viral Load', 'Virology', '<50 copies/ml', 400, 5000, N'Hoàn thành', N'Kiểm soát virus tốt');
INSERT INTO LabTests VALUES ('LT000010', 'BK000010', 'Hepatitis Co-infection', 'Serology', 'Negative for Hep B and C', 400, 10000, N'Hoàn thành', N'Đang chờ kết quả');

INSERT INTO LabTests VALUES ('LT000011', 'BK000011', 'CD4 Count', 'Immunology', '480 cells/mm³', 400, 800, N'Hoàn thành', N'Theo dõi định kỳ');
INSERT INTO LabTests VALUES ('LT000012', 'BK000012', 'Viral Load', 'Virology', 'Undetectable <20 copies/ml', 400, 80000, N'Hoàn thành', N'Kết quả rất tốt');
INSERT INTO LabTests VALUES ('LT000013', 'BK000013', 'Liver Function Test', 'Biochemistry', 'ALT: 39, AST: 36', 450, 1000, N'Hoàn thành', N'Chức năng gan ổn');
INSERT INTO LabTests VALUES ('LT000014', 'BK000014', 'Complete Blood Count', 'Hematology', 'Normal', 400, 2000, N'Hoàn thành', N'Huyết học ổn định');
INSERT INTO LabTests VALUES ('LT000015', 'BK000015', 'HIV Resistance Test', 'Molecular', 'No resistance detected', 400, 700, N'Hoàn thành', N'Không có kháng thuốc');
INSERT INTO LabTests VALUES ('LT000016', 'BK000016', 'Tuberculosis Test', 'Microbiology', 'Negative', 450, 800, N'Hoàn thành', N'Không phát hiện lao');
INSERT INTO LabTests VALUES ('LT000017', 'BK000017', 'CD4 Count', 'Immunology', '510 cells/mm³', 450, 700, N'Hoàn thành', N'CD4 ổn định');
INSERT INTO LabTests VALUES ('LT000018', 'BK000018', 'Kidney Function Test', 'Biochemistry', 'Creatinine: 1.0', 350, 900, N'Hoàn thành', N'Đang kiểm tra thêm');


--13. Bảng Reminder

INSERT INTO Reminder VALUES ('RM000001', 'PT000001', 'TP000001', 'PR000001', 'Medication', '25-06-2025 08:00:00', N'Nhắc uống thuốc Tenofovir');
INSERT INTO Reminder VALUES ('RM000002', 'PT000002', 'TP000002', 'PR000002', 'Appointment', '15-06-2025 20:00:00', N'Nhắc lịch hẹn ngày mai lúc 10:00');
INSERT INTO Reminder VALUES ('RM000003', 'PT000003', 'TP000003', 'PR000003', 'Medication', '25-06-2025 08:00:00', N'Nhắc uống thuốc Dolutegravir');
INSERT INTO Reminder VALUES ('RM000004', 'PT000004', 'TP000004', 'PR000004', 'Lab Test', '16-06-2025 14:00:00', N'Nhắc xét nghiệm CD4 vào ngày 18/06');
INSERT INTO Reminder VALUES ('RM000005', 'PT000005', 'TP000005', 'PR000005', 'Medication', '25-06-2025 08:00:00', N'Nhắc uống thuốc Zidovudine');
INSERT INTO Reminder VALUES ('RM000006', 'PT000006', 'TP000006', 'PR000006', 'Appointment', '19-06-2025 16:00:00', N'Nhắc lịch hẹn ngày mai lúc 15:00');
INSERT INTO Reminder VALUES ('RM000007', 'PT000007', 'TP000007', 'PR000007', 'Medication', '25-06-2025 08:00:00', N'Nhắc uống thuốc Abacavir');
INSERT INTO Reminder VALUES ('RM000008', 'PT000008', 'TP000008', 'PR000008', 'Lab Test', '20-06-2025 18:00:00', N'Nhắc xét nghiệm CD4 vào ngày 22/06');
INSERT INTO Reminder VALUES ('RM000009', 'PT000009', 'TP000009', 'PR000009', 'Medication', '25-06-2025 08:00:00', N'Nhắc uống thuốc Darunavir');
INSERT INTO Reminder VALUES ('RM000010', 'PT000010', 'TP000010', 'PR000010', 'Appointment', '23-06-2025 15:00:00', N'Nhắc lịch hẹn ngày mai lúc 10:00');

INSERT INTO Reminder VALUES ('RM000011', 'PT000011', 'TP000011', 'PR000011', 'Medication', '26-06-2025 08:30:00', N'Nhắc uống thuốc Lamivudine');
INSERT INTO Reminder VALUES ('RM000012', 'PT000012', 'TP000012', 'PR000012', 'Appointment', '27-06-2025 09:45:00', N'Nhắc lịch hẹn khám tổng quát lúc 10:00');
--INSERT INTO Reminder VALUES ('RM000013', 'PT000013', 'TP000013', 'PR000013', 'Lab Test', '28-06-2025 10:15:00', N'Nhắc xét nghiệm máu định kỳ');
--INSERT INTO Reminder VALUES ('RM000014', 'PT000014', 'TP000014', 'PR000014', 'Medication', '29-06-2025 11:00:00', N'Nhắc uống thuốc Efavirenz');
INSERT INTO Reminder VALUES ('RM000015', 'PT000015', 'TP000015', 'PR000015', 'Lab Test', '30-06-2025 13:30:00', N'Nhắc xét nghiệm chức năng gan');
INSERT INTO Reminder VALUES ('RM000016', 'PT000016', 'TP000016', 'PR000016', 'Appointment', '01-07-2025 14:45:00', N'Nhắc lịch hẹn tư vấn lúc 15:00');
INSERT INTO Reminder VALUES ('RM000017', 'PT000017', 'TP000017', 'PR000017', 'Medication', '02-07-2025 15:00:00', N'Nhắc uống thuốc Emtricitabine');
INSERT INTO Reminder VALUES ('RM000018', 'PT000018', 'TP000018', 'PR000018', 'Lab Test', '03-07-2025 16:20:00', N'Nhắc kiểm tra tải lượng virus');
INSERT INTO Reminder VALUES ('RM000019', 'PT000019', 'TP000019', 'PR000019', 'Medication', '04-07-2025 17:00:00', N'Nhắc uống thuốc Rilpivirine');
--INSERT INTO Reminder VALUES ('RM000020', 'PT000020', 'TP000020', 'PR000020', 'Appointment', '05-07-2025 17:45:00', N'Nhắc lịch tái khám lúc 14:00 ngày mai');



--14. Bảng Payment
/*
INSERT INTO Payment VALUES ('PM000001', 'BK000001', 500000, '15-06-2025 10:00:00', N'Tiền mặt', N'Thành công', N'Thanh toán đầy đủ', CURRENT_TIMESTAMP);
INSERT INTO Payment VALUES ('PM000002', 'BK000002', 750000, '16-06-2025 11:30:00', N'Chuyển khoản', N'Đang chờ', N'Chờ xác nhận từ ngân hàng', CURRENT_TIMESTAMP);
INSERT INTO Payment VALUES ('PM000003', 'BK000003', 450000, '17-06-2025 12:00:00', N'Thẻ tín dụng', N'Thành công', N'Thanh toán đầy đủ', CURRENT_TIMESTAMP);
INSERT INTO Payment VALUES ('PM000004', 'BK000004', 1200000, '18-06-2025 09:30:00', N'Bảo hiểm', N'Thành công', N'Bảo hiểm chi trả 80%', CURRENT_TIMESTAMP);
INSERT INTO Payment VALUES ('PM000005', 'BK000005', 300000, '19-06-2025 15:30:00', N'Tiền mặt', N'Thành công', N'Hủy lịch hẹn', CURRENT_TIMESTAMP);
INSERT INTO Payment VALUES ('PM000006', 'BK000006', 600000, '20-06-2025 16:30:00', N'Chuyển khoản', N'Đang chờ', N'Chờ xác nhận từ ngân hàng', CURRENT_TIMESTAMP);
INSERT INTO Payment VALUES ('PM000007', 'BK000007', 800000, '21-06-2025 17:30:00', N'Thẻ tín dụng', N'Thành công', N'Thanh toán đầy đủ', CURRENT_TIMESTAMP);
INSERT INTO Payment VALUES ('PM000008', 'BK000008', 550000, '22-06-2025 12:30:00', N'Tiền mặt', N'Đang chờ', N'Thanh toán một phần', CURRENT_TIMESTAMP);
INSERT INTO Payment VALUES ('PM000009', 'BK000009', 250000, '23-06-2025 10:30:00', N'Chuyển khoản', N'Thất bại', N'Thanh toán đầy đủ', CURRENT_TIMESTAMP);
INSERT INTO Payment VALUES ('PM000010', 'BK000010', 900000, '24-06-2025 11:30:00', N'Bảo hiểm', N'Đang chờ', N'Chờ xác nhận từ bảo hiểm', CURRENT_TIMESTAMP);

INSERT INTO Payment VALUES ('PM000011', 'BK000011', 650000, '25-06-2025 08:45:00', N'Tiền mặt', N'Thành công', N'Thanh toán đầy đủ', CURRENT_TIMESTAMP);
INSERT INTO Payment VALUES ('PM000012', 'BK000012', 720000, '26-06-2025 09:30:00', N'Chuyển khoản', N'Đang chờ', N'Chờ xác nhận từ ngân hàng', CURRENT_TIMESTAMP);
INSERT INTO Payment VALUES ('PM000013', 'BK000013', 480000, '27-06-2025 11:15:00', N'Thẻ tín dụng', N'Thành công', N'Thanh toán đầy đủ', CURRENT_TIMESTAMP);
INSERT INTO Payment VALUES ('PM000014', 'BK000014', 1050000, '28-06-2025 14:00:00', N'Bảo hiểm', N'Thành công', N'Bảo hiểm chi trả 80%', CURRENT_TIMESTAMP);
INSERT INTO Payment VALUES ('PM000015', 'BK000015', 310000, '29-06-2025 10:20:00', N'Tiền mặt', N'Thành công', N'Hủy lịch hẹn', CURRENT_TIMESTAMP);
INSERT INTO Payment VALUES ('PM000016', 'BK000016', 580000, '30-06-2025 13:10:00', N'Chuyển khoản', N'Đang chờ', N'Chờ xác nhận từ ngân hàng', CURRENT_TIMESTAMP);
INSERT INTO Payment VALUES ('PM000017', 'BK000017', 820000, '01-07-2025 16:25:00', N'Thẻ tín dụng', N'Thành công', N'Thanh toán đầy đủ', CURRENT_TIMESTAMP);
INSERT INTO Payment VALUES ('PM000018', 'BK000018', 530000, '02-07-2025 12:45:00', N'Tiền mặt', N'Đang chờ', N'Thanh toán một phần', CURRENT_TIMESTAMP);
INSERT INTO Payment VALUES ('PM000019', 'BK000019', 260000, '03-07-2025 09:55:00', N'Chuyển khoản', N'Thất bại', N'Thanh toán đầy đủ', CURRENT_TIMESTAMP);
INSERT INTO Payment VALUES ('PM000020', 'BK000020', 910000, '04-07-2025 17:40:00', N'Bảo hiểm', N'Đang chờ', N'Chờ xác nhận từ bảo hiểm', CURRENT_TIMESTAMP);

*/