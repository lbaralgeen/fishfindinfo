SET QUOTED_IDENTIFIER ON
GO
PRINT 'Unit tests for search functions' 
PRINT '-----------------------------------------------------------------------------------------------------------------------------' 
-- database may not be empty
----------------------------------------------------------------------------------------------------------
-- SELECT dbo.NormalizeSearch( ' {5bcf4766-dc35-435c-97b1-733fd8675049} ' )
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestA2a
    declare @test_name sysname = 'TestA2a [NormalizeSearch] convert guid with spaces and figure brackets'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

-- 2. execute unit test   

declare @result nvarchar(255) = ( SELECT dbo.NormalizeSearch( ' {5bcf4766-dc35-435c-97b1-733fd8675049} ' ) )


END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

IF  @result <> '5bcf4766-dc35-435c-97b1-733fd8675049'
   RAISERROR ('FAILED: %s all number guid result %s', 16, -1, @test_name, @result ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestA2a
GO
----------------------------------------------------------------------------------------------------------
-- SELECT dbo.NormalizeSearch( null )
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestA2b
    declare @test_name sysname = 'TestA2b [NormalizeSearch] get NULL as a parameter'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

-- 2. execute unit test   

declare @result nvarchar(255) = dbo.NormalizeSearch( null )


END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

IF  @result is not null
   RAISERROR ('FAILED: %s result must be null %s', 16, -1, @test_name, @result ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestA2b
GO
----------------------------------------------------------------------------------------------------------
-- SELECT dbo.NormalizeSearch( '' )
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestA2c
    declare @test_name sysname = 'TestA2c [NormalizeSearch]  empty parameter'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

-- 2. execute unit test   

declare @result nvarchar(255) = dbo.NormalizeSearch( '' )


END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

IF  @result is not null
   RAISERROR ('FAILED: %s result must be null %s', 16, -1, @test_name, @result ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestA2c
GO
----------------------------------------------------------------------------------------------------------
-- SELECT dbo.NormalizeSearch( ' ' )
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestA2d
    declare @test_name sysname = 'TestA2d [NormalizeSearch]  space parameter'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

-- 2. execute unit test   

declare @result nvarchar(255) = dbo.NormalizeSearch( ' ' )


END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

IF  @result is not null
   RAISERROR ('FAILED: %s result must be null %s', 16, -1, @test_name, @result ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestA2d
GO
----------------------------------------------------------------------------------------------------------
-- SELECT dbo.NormalizeSearch( '  ' )
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestA2d
    declare @test_name sysname = 'TestA2d [NormalizeSearch] double space parameter'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

-- 2. execute unit test   

declare @result nvarchar(255) = dbo.NormalizeSearch( '  ' )


END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

IF  @result is not null
   RAISERROR ('FAILED: %s result must be null %s', 16, -1, @test_name, @result ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestA2d
GO
----------------------------------------------------------------------------------------------------------
-- SELECT dbo.NormalizeSearch( '.' )
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestA2e
    declare @test_name sysname = 'TestA2e [NormalizeSearch] dot parameter'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

-- 2. execute unit test   

declare @result nvarchar(255) = dbo.NormalizeSearch( '.' )


END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

IF  @result is not null
   RAISERROR ('FAILED: %s result must be null %s', 16, -1, @test_name, @result ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestA2e
GO
----------------------------------------------------------------------------------------------------------
-- SELECT dbo.NormalizeSearch( ',  ' + char(13) + char(10) + ' ){  }' )
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestA2f
    declare @test_name sysname = 'TestA2f [NormalizeSearch] filtered symbols parameter'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

-- 2. execute unit test   

declare @result nvarchar(255) = dbo.NormalizeSearch( ',  ' + char(13) + char(10) + ' ){  }' )


END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

IF  @result is not null
   RAISERROR ('FAILED: %s result must be null %s', 16, -1, @test_name, @result ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestA2f
GO
----------------------------------------------------------------------------------------------------------
-- SELECT dbo.NormalizeSearch( ',  ' + char(13) + char(10) + ' ){  }' )
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestA2g
    declare @test_name sysname = 'TestA2g [NormalizeSearch] filtered symbols with normal symbols'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

-- 2. execute unit test   

declare @result nvarchar(255) = dbo.NormalizeSearch( ',  ' + char(13) + char(10) + ' ){5BCF4766-DC35-435C-97B1-733FD8675049}' )


END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

IF  @result <> '5BCF4766-DC35-435C-97B1-733FD8675049'
   RAISERROR ('FAILED: %s result must be guid %s', 16, -1, @test_name, @result ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestA2g
GO
----------------------------------------------------------------------------------------------------------
-- SELECT dbo.NormalizeSearch( 'Lake Huron' )
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestA2h
    declare @test_name sysname = 'TestA2h [NormalizeSearch] Valid river name'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

-- 2. execute unit test   

declare @result nvarchar(255) = dbo.NormalizeSearch( 'Lake Huron' )


END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

IF  @result <> 'Lake Huron'
   RAISERROR ('FAILED: %s result must be Lake Huron %s', 16, -1, @test_name, @result ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestA2h
GO
----------------------------------------------------------------------------------------------------------
-- SELECT dbo.NormalizeSearch( 'Lake  Huron' )
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestA2k
    declare @test_name sysname = 'TestA2k [NormalizeSearch] Valid river name with double space'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

-- 2. execute unit test   

declare @result nvarchar(255) = dbo.NormalizeSearch( 'Lake  Huron' )


END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

IF  @result <> 'Lake Huron'
   RAISERROR ('FAILED: %s result must be Lake Huron %s', 16, -1, @test_name, @result ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestA2k
GO
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestA2l
    declare @test_name sysname = 'TestA2l [NormalizeSearch] Valid river name with dot'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

-- 2. execute unit test   

declare @result nvarchar(255) = (SELECT dbo.NormalizeSearch( 'Lake St. Francis' ) )


END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

IF  @result <> 'Lake St. Francis'
   RAISERROR ('FAILED: %s result must be Lake Huron %s', 16, -1, @test_name, @result ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestA2l
GO
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestA2m
    declare @test_name sysname = 'TestA2m [NormalizeSearch] Valid river name with dash'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

-- 2. execute unit test   

declare @result nvarchar(255) = (SELECT dbo.NormalizeSearch( 'A-H Lake' ) )


END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

IF  @result <> 'A-H Lake'
   RAISERROR ('FAILED: %s result must be Lake Huron %s', 16, -1, @test_name, @result ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestA2m
GO
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestA2n
    declare @test_name sysname = N'TestA2n [NormalizeSearch] Valid french river name: [Lac Hatché]'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

-- 2. execute unit test   

declare @result nvarchar(255) = (SELECT dbo.NormalizeSearch( N'Lac Hatché' ) )


END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

IF  @result <> N'Lac Hatché'
   RAISERROR ('FAILED: %s result must be Lake Huron %s', 16, -1, @test_name, @result ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestA2n
GO
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestA2o
    declare @test_name sysname = N'TestA2o [NormalizeSearch] Valid french river name: [Lac Hameçon]'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

-- 2. execute unit test   

declare @result nvarchar(255) = (SELECT dbo.NormalizeSearch( N'Lac Hameçon' ) )


END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

IF  @result <> N'Lac Hameçon'
   RAISERROR ('FAILED: %s result must be Lake Huron %s', 16, -1, @test_name, @result ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestA2o
GO
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestA2p
    declare @test_name sysname = N'TestA2p [NormalizeSearch] Valid french river name: [Lac Haüy]'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

-- 2. execute unit test   

declare @result nvarchar(255) = (SELECT dbo.NormalizeSearch( N'Lac Haüy' ) )


END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

IF  @result <> N'Lac Haüy'
   RAISERROR ('FAILED: %s result must be [Lac Haüy] %s', 16, -1, @test_name, @result ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestA2p
GO
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestA2r
    declare @test_name sysname = N'TestA2r [NormalizeSearch] Valid french river name: [Troisième lac Haut]'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

-- 2. execute unit test   

declare @result nvarchar(255) = (SELECT dbo.NormalizeSearch( N'Troisième lac Haut' ) )


END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

IF  @result <> N'Troisième lac Haut'
   RAISERROR ('FAILED: %s result must be [Lac Haüy] %s', 16, -1, @test_name, @result ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestA2r
GO
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestA2s
    declare @test_name sysname = N'TestA2s [NormalizeSearch] Valid river name wit exclamation mark: [Lac Ha! Ha!]'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

-- 2. execute unit test   

declare @result nvarchar(255) = (SELECT dbo.NormalizeSearch( N'Lac Ha! Ha!' ) )


END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

IF  @result <> N'Lac Ha! Ha!'
   RAISERROR ('FAILED: %s result must be [Lac Ha! Ha!] %s', 16, -1, @test_name, @result ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestA2s
GO
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestA2t
    declare @test_name sysname = N'TestA2t [NormalizeSearch] Valid french river name: [Étang Coté]'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

-- 2. execute unit test   

declare @result nvarchar(255) = (SELECT dbo.NormalizeSearch( N'Étang Coté' ) )


END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

IF  @result <> N'Étang Coté'
   RAISERROR ('FAILED: %s result must be [Lac Haüy] %s', 16, -1, @test_name, @result ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestA2t
GO
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestA2q
    declare @test_name sysname = N'TestA2q [NormalizeSearch] Valid french river name: [Étang Côté]'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

-- 2. execute unit test   

declare @result nvarchar(255) = (SELECT dbo.NormalizeSearch( N'Étang Côté' ) )


END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

IF  @result <> N'Étang Côté'
   RAISERROR ('FAILED: %s result must be [Étang Côté] %s', 16, -1, @test_name, @result ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestA2q
GO
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestA2s
    declare @test_name sysname = N'TestA2s [NormalizeSearch] hex guid'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

-- 2. execute unit test   

declare @result nvarchar(255) = (SELECT dbo.NormalizeSearch( N'5ae76765d05211d892e2080020a0f4c9') )


END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

IF  @result <> '5AE76765-D052-11D8-92E2-080020A0F4C9'
   RAISERROR ('FAILED: %s must be guid%s', 16, -1, @test_name, @result ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestA2s
GO
----------------------------------------------------------------------------------------------------------
PRINT '--------------------------------------------------------------------------------------------------' 
----------------------------------------------------------------------------------------------------------
-- delete from Tributaries;delete from lake
