/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Title:  School Messenger Student Roster File
# Author: Robert Caretta, Applications Support Lead, Racine Unified School District
# Date:   6/18/2015
# Status: DEV
# Version: 0.1
# Description: T-SQL Query to pull a student roster file for School Messenger. The format here is specific to the RUSD use case. 
We generate a CSV file nightly and upload into School Messenger. The columns here are mapped to internal School Messenger fields. 
# Disclaimer: Use at your own risk. :)
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */

-- SELECT ==========================================================================================
SELECT  DISTINCT
--STU.*,
--STU.personID, 
LTRIM(RTRIM(STU.studentNumber)) AS [Student Number],
LTRIM(RTRIM(STU.lastName)) AS [Student Last Name],
LTRIM(RTRIM(STU.firstName)) AS [Student First Name],
--vCCS.householdID,
--vCCS.guardian,
vCCS.householdPhone AS [Primary Phone],
--STU.serviceType,
RIGHT(LTRIM(RTRIM(SCH.number)),3) AS [Ent],
--LTRIM(RTRIM(SCH.name)) AS [SchoolName],
STU.homePrimaryLanguage AS [Lng Cde],
LTRIM(RTRIM(STU.grade)) AS [GradeLevel],
'???' AS [Team ID]
--vCCS.relatedBy
--vCCS.relationship
--vCCS.contactPersonID


-- FROM ===========================================================================================
FROM dbo.student AS STU
INNER JOIN dbo.School AS SCH ON STU.schoolID = SCH.schoolID
LEFT OUTER JOIN [dbo].[v_CensusContactSummary] AS vCCS ON STU.personID = vCCS.personID


-- WHERE ==========================================================================================
WHERE
STU.activeYear = 1
AND serviceType = 'P'
AND STU.endDate is NULL
AND vCCS.relatedBy = 'household'


-- ORDER =========================================================================================
ORDER BY [Student Number] ASC