USE [BIClass]
GO
/****** Object:  StoredProcedure [Project1].[Load_Data]    Script Date: 11/16/2018 8:37:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		YourName Hangjin Chen
-- Create date: 11/16/2018 10:21 PM
-- Description:	Load_Data
-- =============================================
if OBJECT_ID('[Project1].[Load_Data]','p') is not null
	drop proc [Project1].[Load_Data];
go

create PROCEDURE [Project1].[Load_Data]
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

	 exec [Project1].[TruncateStarSchemaData]
	 exec [Project1].[DropForeignKeysFromStarSchemaData]

	 alter table [CH01-01-Fact].[Data] add ClassTime varchar(5) null default '09:15';
	 alter table [CH01-01-Fact].[Data] add LastName  varchar(30) null default 'Chen';
	 alter table [CH01-01-Fact].[Data] add FirstName   varchar(30) null default 'Hangjin';
	 alter table [CH01-01-Fact].[Data] add DateAdded datetime2 null default sysdatetime();

	 exec [Project1].AddForeignKeysToStarSchemaData
    /****** Script for SelectTopNRows command from SSMS  ******/
	INSERT INTO [CH01-01-Fact].[Data]
    (
        SalesManagerKey, OccupationKey, TerritoryKey, ProductKey, CustomerKey, ProductCategory, SalesManager,
        ProductSubcategory, ProductCode, ProductName, Color, ModelName, OrderQuantity, UnitPrice, ProductStandardCost,
        SalesAmount, OrderDate, MonthName, MonthNumber, Year, CustomerName, MaritalStatus, Gender, Education,
        Occupation, TerritoryRegion, TerritoryCountry, TerritoryGroup
    )
    SELECT 
		OLD.SalesManagerKey, OLD.OccupationKey, DT.TerritoryKey, DP.ProductKey, DC.CustomerKey, OLD.ProductCategory, OLD.SalesManager,
        OLD.ProductSubcategory, OLD.ProductCode, OLD.ProductName, OLD.Color, OLD.ModelName, OLD.OrderQuantity, OLD.UnitPrice, OLD.ProductStandardCost,
        OLD.SalesAmount, OLD.OrderDate, OLD.MonthName, OLD.MonthNumber,  OLD.Year, OLD.CustomerName, OLD.MaritalStatus, OLD.Gender, OLD.Education,
        OLD.Occupation, OLD.TerritoryRegion, OLD.TerritoryCountry, OLD.TerritoryGroup
    FROM FileUpload.OriginallyLoadedData AS OLD
        INNER JOIN [CH01-01-Dimension].DimProduct AS DP
            ON DP.ProductName = OLD.ProductName
        INNER JOIN [CH01-01-Dimension].DimTerritory AS DT
            ON DT.TerritoryCountry = OLD.TerritoryCountry
               AND DT.TerritoryGroup = OLD.TerritoryGroup
               AND DT.TerritoryRegion = OLD.TerritoryRegion
        INNER JOIN [CH01-01-Dimension].DimCustomer AS DC
            ON DC.CustomerName = OLD.CustomerName;
PRINT 'Load_Data done'
END;
