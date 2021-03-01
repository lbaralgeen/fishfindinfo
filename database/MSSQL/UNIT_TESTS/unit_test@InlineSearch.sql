SET QUOTED_IDENTIFIER ON
GO
PRINT 'Unit tests for search functions' 
PRINT '-----------------------------------------------------------------------------------------------------------------------------' 
-- database may not be empty
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestFish1
    declare @test_name sysname = N'TestFish1 [FishSearchVariant] : Black Bullhead'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

declare @tbl TABLE ( line sysname, irank int ) 

-- 2. execute unit test   

insert into @tbl SELECT * FROM dbo.FishSearchVariant( N'Black Bullhead' )

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

declare @result1 int = (SELECT COUNT(*) FROM @tbl)
declare @result2 int = (SELECT COUNT(*) FROM @tbl WHERE line LIKE N'Black Bullhead')

IF  @result1 <> 6 OR @result2 <> 1
   RAISERROR ('FAILED: %s result must be six %d : %d', 16, -1, @test_name, @result1, @result2 ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestFish1
GO
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestFish1a
    declare @test_name sysname = N'TestFish1a [FishSearchVariant] : Sucker, Longnose'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

declare @tbl TABLE ( line sysname, irank int ) 

-- 2. execute unit test   

insert into @tbl SELECT * FROM dbo.FishSearchVariant( N'Sucker, Longnose' )

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

declare @result1 int = (SELECT COUNT(*) FROM @tbl)
declare @result2 int = (SELECT COUNT(*) FROM @tbl WHERE line LIKE N'Sucker, Longnose')

IF  @result1 <> 6 OR @result2 <> 1
   RAISERROR ('FAILED: %s result must be six %d : %d', 16, -1, @test_name, @result1, @result2 ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestFish1a
GO
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestSalmon1
    declare @test_name sysname = N'TestSalmon1 [FishSearchVariant] : Salmon'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

declare @tbl TABLE ( line sysname, irank int ) 

-- 2. execute unit test   

insert into @tbl SELECT * FROM dbo.FishSearchVariant( N'Salmon' )

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

declare @result1 int = (SELECT COUNT(*) FROM @tbl)
declare @result2 int = (SELECT COUNT(*) FROM @tbl WHERE line LIKE N'Salmon')

IF  @result1 <> 1 OR @result2 <> 1
   RAISERROR ('FAILED: %s result must be single %d : %d', 16, -1, @test_name, @result1, @result2 ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestSalmon1
GO
----------------------------------------------------------------------------------------------------------
PRINT '--------------------------------------------------------------------------------------------------' 
----------------------------------------------------------------------------------------------------------
-- delete from Tributaries;delete from lake;delete from fish_Rule;delete from fish
