USE [BIClass]
GO
/****** Object:  StoredProcedure [Project1].[Load_DimGender]    Script Date: 11/16/2018 8:33:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		YourName Hangjin Chen
-- Create date: 11/16/2018 13:12 PM
-- Description:	
-- =============================================
ALTER PROCEDURE [Project1].[Load_DimGender]
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;
INSERT INTO [CH01-01-Dimension].[DimGender]
		(Gender, GenderDescription)
	
SELECT DISTINCT Gender,
	CASE 
		 WHEN GENDER = 'M' THEN 'Male'
		 ELSE 'Female' END 
	AS GenderDescription

FROM [FileUpload].[OriginallyLoadedData]

PRINT 'Load_DimGender done'
END;
