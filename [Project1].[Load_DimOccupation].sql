USE [BIClass]
GO
/****** Object:  StoredProcedure [Project1].[Load_DimOccupation]    Script Date: 11/16/2018 8:33:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		YourName Hangjin Chen
-- Create date: 11/16/2018 5:12 PM
-- Description:	Load_DimOccupation
-- =============================================
if OBJECT_ID('[Project1].[Load_DimOccupation]','p') is not null
	drop proc [Project1].[Load_DimOccupation];
go

create PROCEDURE [Project1].[Load_DimOccupation]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	 exec [Project1].[TruncateStarSchemaData]
	 exec [Project1].[DropForeignKeysFromStarSchemaData]

	 alter table [CH01-01-Dimension].[DimOccupation] add ClassTime varchar(5) null default '09:15';
	 alter table [CH01-01-Dimension].[DimOccupation] add LastName  varchar(30) null default 'Chen';
	 alter table [CH01-01-Dimension].[DimOccupation] add FirstName   varchar(30) null default 'Hangjin';
	 alter table [CH01-01-Dimension].[DimOccupation] add DateAdded datetime2 null default sysdatetime();

	 exec [Project1].AddForeignKeysToStarSchemaData

	INSERT INTO [CH01-01-Dimension].[DimOccupation]
		([OccupationKey], [Occupation])

SELECT DISTINCT OccupationKey, Occupation
FROM [FileUpload].[OriginallyLoadedData];
PRINT 'Load_DimOccupation done'

END
