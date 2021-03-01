SET QUOTED_IDENTIFIER ON
GO
PRINT 'Unit tests for search functions' 
PRINT '-----------------------------------------------------------------------------------------------------------------------------' 
-- database may not be empty
----------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestGWTFailedResult
    declare @test_name sysname = N'TestGWTFailedResult [GetWaterType] single abstract word'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test
-- 2. execute unit test   

declare @result int = (SELECT dbo.GetWaterType( N'abstract') )


END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

IF  @result IS NOT NULL
   RAISERROR ('FAILED: %s must be null result %d', 16, -1, @test_name, @result ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestGWTFailedResult
GO
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestGWTLakeOny
    declare @test_name sysname = N'TestGWTLakeOny [GetWaterType] pure water type without name'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test
-- 2. execute unit test   

declare @result int = (SELECT dbo.GetWaterType( N'Lake') )


END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

IF  @result <> 1
   RAISERROR ('FAILED: %s must be lake type %d', 16, -1, @test_name, @result ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestGWTLakeOny
GO
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestGWTRiverOny
    declare @test_name sysname = N'TestGWTRiverOny [GetWaterType] pure water type without name'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test
-- 2. execute unit test   

declare @result int = (SELECT dbo.GetWaterType( N'River') )


END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

IF  @result <> 2
   RAISERROR ('FAILED: %s must be river type %d', 16, -1, @test_name, @result ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestGWTRiverOny
GO
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestGWTLakeHuron
    declare @test_name sysname = N'TestGWTLakeHuron [GetWaterType] Lake Huron'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test
-- 2. execute unit test   

declare @result int = (SELECT dbo.GetWaterType( N'Lake Huron') )


END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

IF  @result <> 1
   RAISERROR ('FAILED: %s must be lake type %d', 16, -1, @test_name, @result ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestGWTLakeHuron
GO
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestGWTLakeHuronF
    declare @test_name sysname = N'TestGWTLakeHuronF [GetWaterType] Lac Huron'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test
-- 2. execute unit test   

declare @result int = (SELECT dbo.GetWaterType( N'Lac Huron') )


END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

IF  @result <> 1
   RAISERROR ('FAILED: %s must be lake type %d', 16, -1, @test_name, @result ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestGWTLakeHuronF
GO
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestGWTGrandRiver
    declare @test_name sysname = N'TestGWTGrandRiver [GetWaterType] Grand River'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test
-- 2. execute unit test   

declare @result int = (SELECT dbo.GetWaterType( N'Grand River') )


END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

IF  @result <> 2
   RAISERROR ('FAILED: %s must be river type %d', 16, -1, @test_name, @result ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestGWTGrandRiver
GO
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestGWTGrandRiverF
    declare @test_name sysname = N'TestGWTGrandRiverF [GetWaterType] Grand Riviere'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test
-- 2. execute unit test   

declare @result int = (SELECT dbo.GetWaterType( N'Grand ' + N'Rivi'+nchar(233)+N're') )


END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

IF  @result <> 2
   RAISERROR ('FAILED: %s must be river type %d', 16, -1, @test_name, @result ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestGWTGrandRiverF
GO
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestGWTBiverBrook
    declare @test_name sysname = N'TestGWTBiverBrook [GetWaterType] Biver Brook'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test
-- 2. execute unit test   

declare @result int = (SELECT dbo.GetWaterType( N'Biver Brook') )


END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

IF  @result <> 64
   RAISERROR ('FAILED: %s must be brook type %d', 16, -1, @test_name, @result ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestGWTBiverBrook
GO
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestGWTBiverBrookF
    declare @test_name sysname = N'TestGWTBiverBrookF [GetWaterType] Biver Ruisseau'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test
-- 2. execute unit test   

declare @result int = (SELECT dbo.GetWaterType( N'Biver Ruisseau') )


END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

IF  @result <> 64
   RAISERROR ('FAILED: %s must be brook type %d', 16, -1, @test_name, @result ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestGWTBiverBrookF
GO
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestGWTBigRes
    declare @test_name sysname = N'TestGWTBigRes [GetWaterType] Big Reservoir'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test
-- 2. execute unit test   

declare @result int = (SELECT dbo.GetWaterType( N'Big Reservoir') )

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

IF  @result <> 8192
   RAISERROR ('FAILED: %s must be Reservoir type %d', 16, -1, @test_name, @result ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestGWTBigRes
GO
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestGWTBigResF
    declare @test_name sysname = N'TestGWTBigResF [GetWaterType] Big Reservoir'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test
-- 2. execute unit test   

declare @result int = (SELECT dbo.GetWaterType( N'Big R'+nchar(233)+N'servoir') )

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

IF  @result <> 8192
   RAISERROR ('FAILED: %s must be Reservoir type %d', 16, -1, @test_name, @result ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestGWTBigResF
GO
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestGWTSandBay
    declare @test_name sysname = N'TestGWTBigResF [GetWaterType] Sand Bay'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test
-- 2. execute unit test   

declare @result int = (SELECT dbo.GetWaterType( N'Sand Bay') )

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

IF  @result <> 1
   RAISERROR ('FAILED: %s must be Bay type %d', 16, -1, @test_name, @result ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestGWTSandBay
GO
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestGWTSandBayF
    declare @test_name sysname = N'TestGWTSandBayF [GetWaterType] Sand Baie'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test
-- 2. execute unit test   

declare @result int = (SELECT dbo.GetWaterType( N'Sand Baie') )

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

IF  @result <> 1
   RAISERROR ('FAILED: %s must be Baie type %d', 16, -1, @test_name, @result ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestGWTSandBayF
GO
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestGWTSideBurn
    declare @test_name sysname = N'TestGWTSideBurn [GetWaterType] Side Burn'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test
-- 2. execute unit test   

declare @result int = (SELECT dbo.GetWaterType( N'Side Burn') )

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

IF  @result <> 64
   RAISERROR ('FAILED: %s must be Burn type %d', 16, -1, @test_name, @result ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestGWTSideBurn
GO
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestGWTCanadaCanal
    declare @test_name sysname = N'TestGWTCanadaCanal [GetWaterType] Canada Canal'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test
-- 2. execute unit test   

declare @result int = (SELECT dbo.GetWaterType( N'Canada Canal') )

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

IF  @result <> 128
   RAISERROR ('FAILED: %s must be Canal type %d', 16, -1, @test_name, @result ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestGWTCanadaCanal
GO
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestGWTCanadaChannel
    declare @test_name sysname = N'TestGWTCanadaChannel [GetWaterType] Canada Channel'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test
-- 2. execute unit test   

declare @result int = (SELECT dbo.GetWaterType( N'Canada Channel') )

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

IF  @result <> 128
   RAISERROR ('FAILED: %s must be Canal type %d', 16, -1, @test_name, @result ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestGWTCanadaChannel
GO
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestGWTPikeCreek
    declare @test_name sysname = N'TestGWTPikeCreek [GetWaterType] Pike Creek'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test
-- 2. execute unit test   

declare @result int = (SELECT dbo.GetWaterType( N'Pike Creek') )

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

IF  @result <> 64
   RAISERROR ('FAILED: %s must be Creek type %d', 16, -1, @test_name, @result ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestGWTPikeCreek
GO
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestGWTPacificOcean
    declare @test_name sysname = N'TestGWTPacificOcean [GetWaterType] Pacific Ocean'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test
-- 2. execute unit test   

declare @result int = (SELECT dbo.GetWaterType( N'Pacific Ocean') )

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

IF  @result <> 16385
   RAISERROR ('FAILED: %s must be Ocean type %d', 16, -1, @test_name, @result ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestGWTPacificOcean
GO
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestGWTPacificOceanF
    declare @test_name sysname = N'TestGWTPacificOceanF [GetWaterType] Pacific Ocean'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test
-- 2. execute unit test   

declare @result int = (SELECT dbo.GetWaterType( N'Pacific ' + N'Oc'+nchar(233)+N'an') )

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

IF  @result <> 16385
   RAISERROR ('FAILED: %s must be Ocean type %d', 16, -1, @test_name, @result ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestGWTPacificOceanF
GO
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestGWTSmallPond
    declare @test_name sysname = N'TestGWTSmallPond [GetWaterType] Small Pond'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test
-- 2. execute unit test   

declare @result int = (SELECT dbo.GetWaterType( N'Small Pond') )

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

IF  @result <> 8
   RAISERROR ('FAILED: %s must be Pond type %d', 16, -1, @test_name, @result ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestGWTSmallPond
GO
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestGWTSmallPondF
    declare @test_name sysname = N'TestGWTSmallPondF [GetWaterType] Small Pond'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test
-- 2. execute unit test   

declare @result int = (SELECT dbo.GetWaterType( N'Small ' + nchar(201)+N'tang') )

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

IF  @result <> 8
   RAISERROR ('FAILED: %s must be Pond type %d', 16, -1, @test_name, @result ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestGWTSmallPondF
GO
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestGWTSmallRun
    declare @test_name sysname = N'TestGWTSmallRun [GetWaterType] Small Run'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test
-- 2. execute unit test   

declare @result int = (SELECT dbo.GetWaterType( N'Small Run') )

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

IF  @result <> 64
   RAISERROR ('FAILED: %s must be Run type %d', 16, -1, @test_name, @result ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestGWTSmallRun
GO
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestGWTSmallRunF
    declare @test_name sysname = N'TestGWTSmallRunF [GetWaterType] Small Courir'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test
-- 2. execute unit test   

declare @result int = (SELECT dbo.GetWaterType( N'Small Courir') )

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

IF  @result <> 64
   RAISERROR ('FAILED: %s must be Run type %d', 16, -1, @test_name, @result ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestGWTSmallRunF
GO
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestGWTBorderStrait
    declare @test_name sysname = N'TestGWTBorderStrait [GetWaterType] Border Strait'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test
-- 2. execute unit test   

declare @result int = (SELECT dbo.GetWaterType( N'Border Strait') )

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

IF  @result <> 128
   RAISERROR ('FAILED: %s must be Strait type %d', 16, -1, @test_name, @result ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestGWTBorderStrait
GO
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestGWTBorderStraitF
    declare @test_name sysname = N'TestGWTBorderStraitF [GetWaterType] Border Strait'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test
-- 2. execute unit test   

declare @result int = (SELECT dbo.GetWaterType( N'Border D'+nchar(233)+N'troit') )

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

IF  @result <> 128
   RAISERROR ('FAILED: %s must be Strait type %d', 16, -1, @test_name, @result ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestGWTBorderStraitF
GO
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestGWTStream
    declare @test_name sysname = N'TestGWTStream [GetWaterType] Silver Stream'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test
-- 2. execute unit test   

declare @result int = (SELECT dbo.GetWaterType( N'Silver Stream') )

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

IF  @result <> 4
   RAISERROR ('FAILED: %s must be Stream type %d', 16, -1, @test_name, @result ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestGWTStream
GO
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestGWTCourant
    declare @test_name sysname = N'TestGWTCourant [GetWaterType] Silver Courant'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test
-- 2. execute unit test   

declare @result int = (SELECT dbo.GetWaterType( N'Silver Courant') )

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

IF  @result <> 4
   RAISERROR ('FAILED: %s must be Stream type %d', 16, -1, @test_name, @result ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestGWTCourant
GO
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestGWTSee
    declare @test_name sysname = N'TestGWTSee [GetWaterType] Baltic See'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test
-- 2. execute unit test   

declare @result int = (SELECT dbo.GetWaterType( N'Baltic See') )

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

IF  @result <> 16385
   RAISERROR ('FAILED: %s must be See type %d', 16, -1, @test_name, @result ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestGWTSee
GO
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestGWTMer
    declare @test_name sysname = N'TestGWTMer [GetWaterType] Mer Lapteva'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test
-- 2. execute unit test   

declare @result int = (SELECT dbo.GetWaterType( N'Mer Lapteva') )

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

IF  @result <> 16385
   RAISERROR ('FAILED: %s must be See type %d', 16, -1, @test_name, @result ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestGWTMer
GO
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestGWTWrongType
    declare @test_name sysname = N'TestGWTWrongType [GetWaterType] Failed Wrong Type'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test
-- 2. execute unit test   

declare @result int = (SELECT dbo.GetWaterType( N'Abra Kadabra') )

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

IF  @result IS NOT NULL
   RAISERROR ('FAILED: %s wrong type %d', 16, -1, @test_name, @result ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestGWTWrongType
GO
----------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------
PRINT '--------------------------------------------------------------------------------------------------' 
----------------------------------------------------------------------------------------------------------
-- delete from Tributaries;delete from lake
