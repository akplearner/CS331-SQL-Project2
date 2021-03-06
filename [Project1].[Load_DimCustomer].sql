USE [BIClass]
GO
/****** Object:  StoredProcedure [Project1].[Load_DimCustomer]    Script Date: 11/16/2018 9:48:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		YourName Hangjin Chen
-- Create date: 11/15/2018  11:34AM
-- Description:	load customer
-- =============================================
if OBJECT_ID('[Project1].[Load_DimCustomer]','p') is not null
	drop proc [Project1].[Load_DimCustomer];
go

create PROCEDURE [Project1].[Load_DimCustomer]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	exec [Project1].[TruncateStarSchemaData]
	exec [Project1].[DropForeignKeysFromStarSchemaData]

	 alter table [CH01-01-Dimension].[DimCustomer] add ClassTime varchar(5) null default '09:15';
	 alter table [CH01-01-Dimension].[DimCustomer] add LastName  varchar(30) null default 'Chen';
	 alter table [CH01-01-Dimension].[DimCustomer] add FirstName   varchar(30) null default 'Hangjin';
	 alter table [CH01-01-Dimension].[DimCustomer] add DateAdded datetime2 null default sysdatetime();

	exec [Project1].AddForeignKeysToStarSchemaData

	INSERT INTO [CH01-01-Dimension].[DimCustomer] ([CustomerName])
	SELECT DISTINCT CustomerName
	FROM [FileUpload].[OriginallyLoadedData];
PRINT 'Load_DimCustomer done'

END
