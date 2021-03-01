SET QUOTED_IDENTIFIER ON
GO
PRINT 'Unit tests for search functions' 
PRINT '-----------------------------------------------------------------------------------------------------------------------------' 
-- database may not be empty
----------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestPWBV1
    declare @test_name sysname = N'TestPWBV1 [ProduceWBVariant] : West Little White River'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

declare @tbl TABLE ( line sysname, irank int, id int ) 

-- 2. execute unit test   

insert into @tbl SELECT * FROM dbo.ProduceWBVariant( N'West Little White River' )

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

declare @result1 int = (SELECT COUNT(*) FROM @tbl)
declare @result2 int = (SELECT COUNT(*) FROM @tbl WHERE line LIKE N'West Little White')

IF  @result1 <> 15 OR @result2 <> 1
   RAISERROR ('FAILED: %s result must be ten %d : %d', 16, -1, @test_name, @result1, @result2 ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestPWBV1
GO
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestPWBV1a
    declare @test_name sysname = N'TestPWBV1a [ProduceWBVariant] : Naftel''s Creek'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

declare @tbl TABLE ( line sysname, irank int, id int ) 

-- 2. execute unit test   

insert into @tbl SELECT * FROM dbo.ProduceWBVariant( N'Naftel''s Creek' )

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

declare @result1 int = (SELECT COUNT(*) FROM @tbl)
declare @result2 int = (SELECT COUNT(*) FROM @tbl WHERE line LIKE N'Naftel''s')

IF  @result1 <> 3 OR @result2 <> 1
   RAISERROR ('FAILED: %s result must be ten %d : %d', 16, -1, @test_name, @result1, @result2 ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestPWBV1a
GO
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestPWBV1b
    declare @test_name sysname = N'TestPWBV1b [ProduceWBVariant] : Casselman''s Creek'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

declare @tbl TABLE ( line sysname, irank int, id int ) 

-- 2. execute unit test   

insert into @tbl SELECT * FROM dbo.ProduceWBVariant( N'Casselman''s Creek' )

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

declare @result1 int = (SELECT COUNT(*) FROM @tbl)
declare @result2 int = (SELECT COUNT(*) FROM @tbl WHERE line LIKE N'Casselman''s')

IF  @result1 <> 3 OR @result2 <> 1
   RAISERROR ('FAILED: %s result must be ten %d : %d', 16, -1, @test_name, @result1, @result2 ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestPWBV1b
GO
----------------------------------------------------------------------------------------------------------
PRINT '--------------------------------------------------------------------------------------------------' 
----------------------------------------------------------------------------------------------------------
-- delete from Tributaries;delete from lake
