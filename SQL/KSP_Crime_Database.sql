Create Database ksp_crime_db;
USE ksp_crime_db;
SHOW DATABASES;

CREATE TABLE District (
    DistrictID INT AUTO_INCREMENT PRIMARY KEY,
    DistrictName VARCHAR(100) NOT NULL
);

CREATE TABLE Unit (
    UnitID INT AUTO_INCREMENT PRIMARY KEY,
    UnitName VARCHAR(150) NOT NULL,
    DistrictID INT,
    FOREIGN KEY (DistrictID)
    REFERENCES District(DistrictID)
);

CREATE TABLE CrimeHead (
    CrimeHeadID INT AUTO_INCREMENT PRIMARY KEY,
    CrimeGroupName VARCHAR(150),
    CrimeHeadName VARCHAR(200)
);

CREATE TABLE CaseMaster (
    CaseID INT AUTO_INCREMENT PRIMARY KEY,
    
    FIR_YEAR INT,
    FIR_MONTH VARCHAR(20),
    FIR_Type VARCHAR(100),
    FIR_Stage VARCHAR(100),
    Complaint_Mode VARCHAR(100),
    
    Place_of_Offence VARCHAR(255),
    Distance_from_PS DECIMAL(10,2),
    Beat_Name VARCHAR(150),
    Village_Area_Name VARCHAR(150),
    
    CrimeSeverity VARCHAR(20),
    
    DistrictID INT,
    UnitID INT,
    CrimeHeadID INT,
    
    FOREIGN KEY (DistrictID)
        REFERENCES District(DistrictID),
        
    FOREIGN KEY (UnitID)
        REFERENCES Unit(UnitID),
        
    FOREIGN KEY (CrimeHeadID)
        REFERENCES CrimeHead(CrimeHeadID)
);

SHOW TABLES;

CREATE TABLE VictimSummary (
    VictimSummaryID INT AUTO_INCREMENT PRIMARY KEY,
    
    CaseID INT,
    
    Male INT,
    Female INT,
    Boy INT,
    Girl INT,
    
    Victim_Count INT,
    
    FOREIGN KEY (CaseID)
        REFERENCES CaseMaster(CaseID)
);

CREATE TABLE AccusedSummary (
    AccusedSummaryID INT AUTO_INCREMENT PRIMARY KEY,
    
    CaseID INT,
    
    Accused_Count INT,
    
    FOREIGN KEY (CaseID)
        REFERENCES CaseMaster(CaseID)
);

CREATE TABLE ArrestSummary (
    ArrestID INT AUTO_INCREMENT PRIMARY KEY,
    
    CaseID INT,
    
    Arrested_Male INT,
    Arrested_Female INT,
    Arrested_Count INT,
    
    Arrest_Rate DECIMAL(10,4),
    
    FOREIGN KEY (CaseID)
        REFERENCES CaseMaster(CaseID)
);

CREATE TABLE ConvictionSummary (
    ConvictionID INT AUTO_INCREMENT PRIMARY KEY,
    
    CaseID INT,
    
    Conviction_Count INT,
    
    Conviction_Rate DECIMAL(10,4),
    
    FOREIGN KEY (CaseID)
        REFERENCES CaseMaster(CaseID)
);

DROP TABLE IF EXISTS CrimeRecords_Raw;

CREATE TABLE CrimeRecords_Raw (
District_Name TEXT,
Unit_Name TEXT,
FIR_YEAR TEXT,
FIR_MONTH TEXT,
Offence_Duration TEXT,
FIR_Day TEXT,
FIR_Type TEXT,
FIR_Stage TEXT,
Complaint_Mode TEXT,
CrimeGroup_Name TEXT,
CrimeHead_Name TEXT,
Act_Section LONGTEXT,
IO_Name TEXT,
KGID TEXT,
Internal_IO TEXT,
Place_of_Offence LONGTEXT,
Distance_from_PS TEXT,
Beat_Name TEXT,
Village_Area_Name TEXT,
Male TEXT,
Female TEXT,
Boy TEXT,
Girl TEXT,
`Age 0` TEXT,
Victim_Count TEXT,
Accused_Count TEXT,
Arrested_Male TEXT,
Arrested_Female TEXT,
Arrested_Count TEXT,
`Accused_ChargeSheeted Count` TEXT,
Conviction_Count TEXT,
Unit_ID TEXT,
Arrest_Rate TEXT,
Conviction_Rate TEXT,
Crime_Severity TEXT
);


LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/KSP_Crime_95K.csv'
INTO TABLE CrimeRecords_Sampled
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'


IGNORE 1 LINES;

INSERT INTO District (DistrictName)
SELECT DISTINCT District_Name
FROM CrimeRecords_Sampled
WHERE District_Name IS NOT NULL
AND District_Name <> '';

INSERT INTO CrimeHead (CrimeGroupName, CrimeHeadName)
SELECT DISTINCT
CrimeGroup_Name,
CrimeHead_Name
FROM CrimeRecords_Sampled
WHERE CrimeGroup_Name IS NOT NULL
AND CrimeHead_Name IS NOT NULL;

INSERT INTO Unit (UnitName, DistrictID)
SELECT DISTINCT
c.Unit_Name,
d.DistrictID
FROM CrimeRecords_Sampled c
JOIN District d
ON c.District_Name = d.DistrictName
WHERE c.Unit_Name IS NOT NULL;

INSERT INTO CaseMaster (
FIR_YEAR,
FIR_MONTH,
FIR_Type,
FIR_Stage,
Complaint_Mode,
Place_of_Offence,
Distance_from_PS,
Beat_Name,
Village_Area_Name,
CrimeSeverity,
DistrictID,
UnitID,
CrimeHeadID
)
SELECT
c.FIR_YEAR,
c.FIR_MONTH,
c.FIR_Type,
c.FIR_Stage,
c.Complaint_Mode,
c.Place_of_Offence,
NULL,
c.Beat_Name,
c.Village_Area_Name,
c.Crime_Severity,
d.DistrictID,
u.UnitID,
ch.CrimeHeadID
FROM CrimeRecords_Sampled c
LEFT JOIN District d
ON c.District_Name = d.DistrictName
LEFT JOIN Unit u
ON c.Unit_Name = u.UnitName
LEFT JOIN CrimeHead ch
ON c.CrimeGroup_Name = ch.CrimeGroupName
AND c.CrimeHead_Name = ch.CrimeHeadName;

INSERT INTO Unit (UnitName, DistrictID)
SELECT
    Unit_Name,
    MIN(d.DistrictID)
FROM CrimeRecords_Sampled c
JOIN District d
ON c.District_Name = d.DistrictName
WHERE c.Unit_Name IS NOT NULL
GROUP BY Unit_Name;

SELECT UnitName, COUNT(*)
FROM Unit
GROUP BY UnitName
HAVING COUNT(*) > 1;

INSERT INTO CaseMaster (
FIR_YEAR,
FIR_MONTH,
FIR_Type,
FIR_Stage,
Complaint_Mode,
Place_of_Offence,
Distance_from_PS,
Beat_Name,
Village_Area_Name,
CrimeSeverity,
DistrictID,
UnitID,
CrimeHeadID
)
SELECT
c.FIR_YEAR,
c.FIR_MONTH,
c.FIR_Type,
c.FIR_Stage,
c.Complaint_Mode,
c.Place_of_Offence,
NULL,
c.Beat_Name,
c.Village_Area_Name,
c.Crime_Severity,
d.DistrictID,
u.UnitID,
ch.CrimeHeadID
FROM CrimeRecords_Sampled c
LEFT JOIN District d
ON c.District_Name = d.DistrictName
LEFT JOIN Unit u
ON c.Unit_Name = u.UnitName
LEFT JOIN CrimeHead ch
ON c.CrimeGroup_Name = ch.CrimeGroupName
AND c.CrimeHead_Name = ch.CrimeHeadName;

DESCRIBE VictimSummary;
DESCRIBE AccusedSummary;
DESCRIBE ArrestSummary;
DESCRIBE ConvictionSummary;

DELETE FROM VictimSummary;

INSERT INTO VictimSummary
(
CaseID,
Male,
Female,
Boy,
Girl,
Victim_Count
)
SELECT
cm.CaseID,
c.Male,
c.Female,
c.Boy,
c.Girl,
c.Victim_Count
FROM CaseMaster cm
JOIN CrimeRecords_Sampled c
ON cm.FIR_YEAR = c.FIR_YEAR
AND cm.FIR_MONTH = c.FIR_MONTH;

CREATE VIEW vw_TopDistrictCrimes AS
SELECT
District_Name,
COUNT(*) AS Total_Crimes
FROM CrimeRecords_Sampled
GROUP BY District_Name;

CREATE VIEW vw_CrimeTrend AS
SELECT
FIR_YEAR,
COUNT(*) AS Total_Crimes
FROM CrimeRecords_Sampled
GROUP BY FIR_YEAR;

CREATE VIEW vw_CrimeSeverity AS
SELECT
Crime_Severity,
COUNT(*) AS Total_Crimes
FROM CrimeRecords_Sampled
GROUP BY Crime_Severity;

SELECT
District_Name,
COUNT(*) AS Total_Crimes
FROM CrimeRecords_Sampled
GROUP BY District_Name
ORDER BY Total_Crimes DESC
LIMIT 10;

SELECT
FIR_YEAR,
COUNT(*) AS Total_Crimes
FROM CrimeRecords_Sampled
GROUP BY FIR_YEAR
ORDER BY FIR_YEAR;

SELECT
CrimeHead_Name,
COUNT(*) AS Total_Cases
FROM CrimeRecords_Sampled
GROUP BY CrimeHead_Name
ORDER BY Total_Cases DESC
LIMIT 10;

SELECT
Crime_Severity,
COUNT(*) AS Total_Cases
FROM CrimeRecords_Sampled
GROUP BY Crime_Severity;

SELECT
CrimeGroup_Name,
AVG(REPLACE(Arrest_Rate,'%','')) AS Avg_Arrest_Rate
FROM CrimeRecords_Sampled
GROUP BY CrimeGroup_Name
ORDER BY Avg_Arrest_Rate DESC
LIMIT 10;

SELECT
CrimeGroup_Name,
AVG(REPLACE(Conviction_Rate,'%','')) AS Avg_Conviction_Rate
FROM CrimeRecords_Sampled
GROUP BY CrimeGroup_Name
ORDER BY Avg_Conviction_Rate DESC
LIMIT 10;