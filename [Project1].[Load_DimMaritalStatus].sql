USE [BIClass]
GO
/****** Object:  StoredProcedure [Project1].[Load_DimMaritalStatus]    Script Date: 11/16/2018 8:33:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		YourName Hangjin Chen
-- Create date: 11/16/2018 3:15PM
-- Description:	
-- =============================================
ALTER PROCEDURE [Project1].[Load_DimMaritalStatus]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	INSERT INTO [CH01-01-Dimension].[DimMaritalStatus]
	([MaritalStatus], [MaritalStatusDescription])

SELECT DISTINCT [MaritalStatus],
	   CASE
			WHEN MaritalStatus = 'S' THEN 'Single'
			ELSE 'Married' END
	   AS [MaritalStatusDescription]
FROM [FileUpload].[OriginallyLoadedData]
PRINT 'Load_DimMaritalStatus done'

END
