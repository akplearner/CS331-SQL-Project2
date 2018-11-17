USE [BIClass]
GO
/****** Object:  StoredProcedure [Project1].[Load_DimOccupation]    Script Date: 11/16/2018 8:33:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		YourName Hangjin Chen
-- Create date: 11/16/2018 8:33:22 PM
-- Description:	
-- =============================================
ALTER PROCEDURE [Project1].[Load_DimOccupation]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	INSERT INTO [CH01-01-Dimension].[DimOccupation]
		([OccupationKey], [Occupation])

SELECT DISTINCT OccupationKey, Occupation
FROM [FileUpload].[OriginallyLoadedData];
PRINT 'Load_DimOccupation done'

END
