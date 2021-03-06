USE [BIClass]
GO
/****** Object:  StoredProcedure [Project1].[Load_DimGender]    Script Date: 11/16/2018 10:02:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		YourName Hangjin Chen
-- Create date: 11/15/2018 13:20
-- Description:	Load_DimGender
-- =============================================
if OBJECT_ID('[Project1].[Load_DimGender]','p') is not null
	drop proc [Project1].[Load_DimGender];
go

create PROCEDURE [Project1].[Load_DimGender]
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;
	 exec [Project1].[TruncateStarSchemaData]
	 exec [Project1].[DropForeignKeysFromStarSchemaData]

	 alter table [CH01-01-Dimension].[DimGender] add ClassTime varchar(5) null default '09:15';
	 alter table [CH01-01-Dimension].[DimGender] add LastName  varchar(30) null default 'Chen';
	 alter table [CH01-01-Dimension].[DimGender] add FirstName   varchar(30) null default 'Hangjin';
	 alter table [CH01-01-Dimension].[DimGender] add DateAdded datetime2 null default sysdatetime();

	 exec [Project1].AddForeignKeysToStarSchemaData

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
