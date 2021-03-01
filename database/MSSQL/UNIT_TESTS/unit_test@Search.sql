SET QUOTED_IDENTIFIER ON
GO
PRINT 'Unit tests for search functions' 
PRINT '-----------------------------------------------------------------------------------------------------------------------------' 
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestS1
    declare @test_name sysname = N'TestS1 [SearchLakeList] : null parameter'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

insert into lake (lake_name, locType) values ('test lake', 1)
declare @tbl table (lake_name sysname, locType int)

-- 2. execute unit test   

insert into @tbl (lake_name, locType)  SELECT lake_name, locType FROM dbo.SearchLakeList( null )

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

declare @result int = (SELECT COUNT(*) FROM @tbl)

IF  @result <> 0
   RAISERROR ('FAILED: %s result must be empty %d ', 16, -1, @test_name, @result  ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestS1
GO
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestS1a
    declare @test_name sysname = N'TestS1a [SearchLakeList] : empty parameter'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

insert into lake (lake_name, locType) values ('test lake', 1)
declare @tbl table (lake_name sysname, locType int)

-- 2. execute unit test   

insert into @tbl (lake_name, locType)  SELECT lake_name, locType FROM dbo.SearchLakeList( '' )

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

declare @result int = (SELECT COUNT(*) FROM @tbl)

IF  @result <> 0
   RAISERROR ('FAILED: %s result must be empty %d ', 16, -1, @test_name, @result  ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestS1a
GO
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestS1a
    declare @test_name sysname = N'TestS1a [SearchLakeList] : find:  test lake'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

insert into lake (lake_name, locType) values ('test lake', 1)
declare @tbl table (lake_name sysname, locType int)

-- 2. execute unit test   

insert into @tbl (lake_name, locType)  SELECT lake_name, locType FROM dbo.SearchLakeList( N'test lake' )

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

declare @result int = (SELECT COUNT(*) FROM @tbl)

IF  @result <> 1
   RAISERROR ('FAILED: %s result must be single line %d ', 16, -1, @test_name, @result  ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestS1a
GO
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestS1b
    declare @test_name sysname = N'TestS1b [SearchLakeList] : failed to find:  test lake'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

insert into lake (lake_name, locType) values ('test river', 1)
declare @tbl table (lake_name sysname, locType int)

-- 2. execute unit test   

insert into @tbl (lake_name, locType)  SELECT lake_name, locType FROM dbo.SearchLakeList( N'test lake' )

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

declare @result int = (SELECT COUNT(*) FROM @tbl)

IF  @result <> 0
   RAISERROR ('FAILED: %s result must be empty %d ', 16, -1, @test_name, @result  ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestS1b
GO
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestS1c
    declare @test_name sysname = N'TestS1c [SearchLakeList] : find: french spelling of test lake'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

insert into lake (lake_name, locType) values ('Lac test', 1)
declare @tbl table (lake_name sysname, locType int)

-- 2. execute unit test   

insert into @tbl (lake_name, locType)  SELECT lake_name, locType FROM dbo.SearchLakeList( N'test lake' )

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

declare @result int = (SELECT COUNT(*) FROM @tbl)

IF  @result <> 1
   RAISERROR ('FAILED: %s result must be single line %d ', 16, -1, @test_name, @result  ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestS1c
GO
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestS1d
    declare @test_name sysname = N'TestS1d [SearchLakeList] : find: all variants of test lake'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

insert into lake (lake_name, locType) values ('Lac test',  1)
insert into lake (lake_name, locType) values ('test Lac',  1)
insert into lake (lake_name, locType) values ('test Lake', 1)
insert into lake (lake_name, locType) values ('Lake test', 1)
declare @tbl table (lake_name sysname, locType int)

-- 2. execute unit test   

insert into @tbl (lake_name, locType)  SELECT lake_name, locType FROM dbo.SearchLakeList( N'test lake' )

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

declare @result int = (SELECT COUNT(*) FROM @tbl)

IF  @result <> 4
   RAISERROR ('FAILED: %s result must be four records %d ', 16, -1, @test_name, @result  ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestS1d
GO
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestS1e
    declare @test_name sysname = N'TestS1e [SearchLakeList] : find by lake guid'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

insert into lake (lake_id, lake_name, locType) values ('5AE76765-D052-11D8-92E2-080020A0F4C9', 'Lac test', 1)

declare @tbl table (lake_id uniqueidentifier not null primary key, lake_name sysname, locType int)

-- 2. execute unit test   

insert into @tbl (lake_id, lake_name, locType)  SELECT lake_id, lake_name, locType FROM dbo.SearchLakeList( N'5AE76765-D052-11D8-92E2-080020A0F4C9' )

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

declare @result int = (SELECT COUNT(*) FROM @tbl)

IF  @result <> 1
   RAISERROR ('FAILED: %s result must be single line %d ', 16, -1, @test_name, @result  ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestS1e
GO
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestS1f
    declare @test_name sysname = N'TestS1f [SearchLakeList] : find by lake hex guid'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

insert into lake (lake_id, lake_name, locType) values ('5AE76765-D052-11D8-92E2-080020A0F4C9', 'Lac test', 1)

declare @tbl table (lake_id uniqueidentifier not null primary key, lake_name sysname, locType int)

-- 2. execute unit test   

insert into @tbl (lake_id, lake_name, locType)  SELECT lake_id, lake_name, locType FROM dbo.SearchLakeList( N'5ae76765d05211d892e2080020a0f4c9' )

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

declare @result int = (SELECT COUNT(*) FROM @tbl where lake_id = '5AE76765-D052-11D8-92E2-080020A0F4C9' )

IF  @result <> 1
   RAISERROR ('FAILED: %s result must be single line %d ', 16, -1, @test_name, @result  ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestS1f
GO
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestS1g
    declare @test_name sysname = N'TestS1g [SearchLakeList] : find: single name lake by double name'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

insert into lake (lake_name, locType) values ('Single Lake',  1)
declare @tbl table (lake_name sysname, locType int)

-- 2. execute unit test   

insert into @tbl (lake_name, locType)  SELECT lake_name, locType FROM dbo.SearchLakeList( N'Great Single Lake' )

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

declare @result1 int = (SELECT COUNT(*) FROM @tbl)
declare @result2 int = (SELECT COUNT(*) FROM @tbl WHERE lake_name = 'Single Lake')

IF  @result1 <> 1 OR @result2 <> 1
   RAISERROR ('FAILED: %s result must be single records %d ', 16, -1, @test_name, @result1  ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestS1g
GO
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestS1h
    declare @test_name sysname = N'TestS1h [SearchLakeList] : find: double name lake by single name'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

insert into lake (lake_name, locType) values ('Great Double Lake',  1)
declare @tbl table (lake_name sysname, locType int)

-- 2. execute unit test   

insert into @tbl (lake_name, locType)  SELECT lake_name, locType FROM dbo.SearchLakeList( N'Double Lake' )

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

declare @result1 int = (SELECT COUNT(*) FROM @tbl)
declare @result2 int = (SELECT COUNT(*) FROM @tbl WHERE lake_name = 'Great Double Lake')

IF  @result1 <> 1 OR @result2 <> 1
   RAISERROR ('FAILED: %s result must be single records %d ', 16, -1, @test_name, @result1  ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestS1h
GO
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestS1i
    declare @test_name sysname = N'TestS1i [SearchLakeList] : find: Ha! Ha! Lake by Ha Lake'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

declare @dbname sysname = 'Ha! Ha! Lake'
insert into lake (lake_name, locType) values (@dbname,  1)
declare @tbl table (lake_name sysname, locType int)

-- 2. execute unit test   

insert into @tbl (lake_name, locType)  SELECT lake_name, locType FROM dbo.SearchLakeList( N'Ha Lake' ) ORDER BY irank ASC

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

declare @result1 int = (SELECT COUNT(*) FROM @tbl)
declare @result2 int = (SELECT COUNT(*) FROM @tbl WHERE lake_name = @dbname)

IF  @result1 <> 1 OR @result2 <> 1
   RAISERROR ('FAILED: %s result must be single records %d ', 16, -1, @test_name, @result1  ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestS1i
GO
----------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------
PRINT '--------------------------------------------------------------------------------------------------' 
----------------------------------------------------------------------------------------------------------
-- delete from [dbo].[Tributaries];delete from lake