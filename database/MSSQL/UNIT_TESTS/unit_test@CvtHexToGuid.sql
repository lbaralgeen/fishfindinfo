SET QUOTED_IDENTIFIER ON
GO
PRINT 'Unit tests for search functions' 
PRINT '-----------------------------------------------------------------------------------------------------------------------------' 
-- database may not be empty
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestA1a
    declare @test_name sysname = 'TestA1a [fn_CvtHexToGuid] convert 00000000-0000-0000-0000-000000000000'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

-- 2. execute unit test   

declare @result uniqueidentifier = dbo.fn_CvtHexToGuid( '00000000000000000000000000000000' )

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

declare @tst char(36) = CAST(@result AS char(36))

IF  @result <> '00000000-0000-0000-0000-000000000000'
   RAISERROR ('FAILED: %s zero guid result %s', 16, -1, @test_name, @tst ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestA1a
GO
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestA1b
    declare @test_name sysname = 'TestA1b [fn_CvtHexToGuid] convert 11111111-1111-1111-1111-1111111111111'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

-- 2. execute unit test   

declare @result uniqueidentifier = dbo.fn_CvtHexToGuid( '111111111111111111111111111111111' )

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

declare @tst char(36) = CAST(@result AS char(36))

IF  @result <> '11111111-1111-1111-1111-1111111111111'
   RAISERROR ('FAILED: %s one guid result %s', 16, -1, @test_name, @tst ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestA1b
GO
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestA1f
    declare @test_name sysname = 'TestA1f [fn_CvtHexToGuid] convert ffffffff-ffff-ffff-ffff-fffffffffffff'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

-- 2. execute unit test   

declare @result uniqueidentifier = dbo.fn_CvtHexToGuid( 'fffffffffffffffffffffffffffffffff' )

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

declare @tst char(36) = CAST(@result AS char(36))

IF  @result <> 'ffffffff-ffff-ffff-ffff-fffffffffffff'
   RAISERROR ('FAILED: %s fff guid result %s', 16, -1, @test_name, @tst ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestA1f
GO
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestA1c
    declare @test_name sysname = 'TestA1c [fn_CvtHexToGuid] convert 12345678-9012-3456-7890-abcdef0123456'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

-- 2. execute unit test   

declare @result uniqueidentifier = dbo.fn_CvtHexToGuid( '12345678901234567890abcdef0123456' )

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

declare @tst char(36) = CAST(@result AS char(36))

IF  @result <> '12345678-9012-3456-7890-abcdef0123456'
   RAISERROR ('FAILED: %s all number guid result %s', 16, -1, @test_name, @tst ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestA1c
GO
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestA1d
    declare @test_name sysname = 'TestA1d [fn_CvtHexToGuid] convert upper case random 5BCF4766-DC35-435C-97B1-733FD8675049'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

-- 2. execute unit test   

declare @result uniqueidentifier = ( SELECT dbo.fn_CvtHexToGuid( '5BCF4766DC35435C97B1733FD8675049' ) )

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

declare @tst char(36) = CAST(@result AS char(36))

IF  @result <> '5BCF4766-DC35-435C-97B1-733FD8675049'
   RAISERROR ('FAILED: %s all number guid result %s', 16, -1, @test_name, @tst ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestA1d
GO
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestA1e
    declare @test_name sysname = 'TestA1e [fn_CvtHexToGuid] convert lower case random 5bcf4766-dc35-435c-97b1-733fd8675049'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

-- 2. execute unit test   

declare @result uniqueidentifier = dbo.fn_CvtHexToGuid( '5bcf4766dc35435c97b1733fd8675049' )

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

declare @tst char(36) = CAST(@result AS char(36))

IF  @result <> '5bcf4766-dc35-435c-97b1-733fd8675049'
   RAISERROR ('FAILED: %s all number guid result %s', 16, -1, @test_name, @tst ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestA1e
GO
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestA1g
    declare @test_name sysname = 'TestA1g [fn_CvtHexToGuid] convert with space at front 5bcf4766-dc35-435c-97b1-733fd8675049'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

-- 2. execute unit test   

declare @result uniqueidentifier = dbo.fn_CvtHexToGuid( ' 5bcf4766dc35435c97b1733fd8675049' )

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

declare @tst char(36) = CAST(@result AS char(36))

IF  @result <> '5bcf4766-dc35-435c-97b1-733fd8675049'
   RAISERROR ('FAILED: %s all number guid result %s', 16, -1, @test_name, @tst ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestA1g
GO
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestA1h
    declare @test_name sysname = 'TestA1h [fn_CvtHexToGuid] convert with space after 5bcf4766-dc35-435c-97b1-733fd8675049'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

-- 2. execute unit test   

declare @result uniqueidentifier = dbo.fn_CvtHexToGuid( '5bcf4766dc35435c97b1733fd8675049 ' )

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

declare @tst char(36) = CAST(@result AS char(36))

IF  @result <> '5bcf4766-dc35-435c-97b1-733fd8675049'
   RAISERROR ('FAILED: %s all number guid result %s', 16, -1, @test_name, @tst ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestA1h
GO
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestA1e
    declare @test_name sysname = 'TestA1e [fn_CvtHexToGuid] convert with figure brackets {5bcf4766-dc35-435c-97b1-733fd8675049}'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

-- 2. execute unit test   

declare @result uniqueidentifier = dbo.fn_CvtHexToGuid( ' {5bcf4766dc35435c97b1733fd8675049} ' )

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

declare @tst char(36) = CAST(@result AS char(36))

IF  @result <> '5bcf4766-dc35-435c-97b1-733fd8675049'
   RAISERROR ('FAILED: %s all number guid result %s', 16, -1, @test_name, @tst ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestA1e
GO
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestA1g
    declare @test_name sysname = 'TestA1g [fn_CvtHexToGuid] failed to convert invalid guid'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

-- 2. execute unit test   

declare @result uniqueidentifier = dbo.fn_CvtHexToGuid( '4766+dc35(435c)97b1' )

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

declare @tst char(36) = CAST(@result AS char(36))

IF  @result IS NOT NULL
   RAISERROR ('FAILED: %s must be null %s', 16, -1, @test_name, @tst ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestA1g
GO
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestA1h
    declare @test_name sysname = 'TestA1h [fn_CvtHexToGuid] failed to convert space string'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

-- 2. execute unit test   

declare @result uniqueidentifier = dbo.fn_CvtHexToGuid( '    ' )

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

declare @tst char(36) = CAST(@result AS char(36))

IF  @result IS NOT NULL
   RAISERROR ('FAILED: %s must be null %s', 16, -1, @test_name, @tst ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestA1h
GO
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestA1k
    declare @test_name sysname = 'TestA1k [fn_CvtHexToGuid] failed to convert empty string'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

-- 2. execute unit test   

declare @result uniqueidentifier = dbo.fn_CvtHexToGuid( '' )

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

declare @tst char(36) = CAST(@result AS char(36))

IF  @result IS NOT NULL
   RAISERROR ('FAILED: %s must be null %s', 16, -1, @test_name, @tst ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestA1k
GO
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestA1z
    declare @test_name sysname = 'TestA1z [fn_CvtHexToGuid] failed to convert null value'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

-- 2. execute unit test   

declare @result uniqueidentifier = dbo.fn_CvtHexToGuid( NULL )

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

declare @tst char(36) = CAST(@result AS char(36))

IF  @result IS NOT NULL
   RAISERROR ('FAILED: %s must be null %s', 16, -1, @test_name, @tst ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestA1z
GO
----------------------------------------------------------------------------------------------------------
PRINT '--------------------------------------------------------------------------------------------------' 
----------------------------------------------------------------------------------------------------------
-- delete from Tributaries;delete from lake
