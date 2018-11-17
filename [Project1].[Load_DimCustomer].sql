USE [BIClass]
GO
/****** Object:  StoredProcedure [Project1].[Load_DimCustomer]    Script Date: 11/16/2018 8:33:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		YourName Hangjin Chen
-- Create date: 11/16/2018 11:44 AM
-- Description:	
-- =============================================
ALTER PROCEDURE [Project1].[Load_DimCustomer]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	INSERT INTO [CH01-01-Dimension].[DimCustomer] ([CustomerName])
	SELECT DISTINCT CustomerName
	FROM [FileUpload].[OriginallyLoadedData];
PRINT 'Load_DimCustomer done'

END
