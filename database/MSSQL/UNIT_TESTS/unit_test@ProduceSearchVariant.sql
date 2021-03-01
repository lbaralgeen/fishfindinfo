SET QUOTED_IDENTIFIER ON
GO
PRINT 'Unit tests for search functions' 
PRINT '-----------------------------------------------------------------------------------------------------------------------------' 
-- database may not be empty
----------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestA3a
    declare @test_name sysname = N'TestA3a [ProduceSearchVariant] null request'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

declare @tbl TABLE ( line sysname, irank int ) 

-- 2. execute unit test   

insert into @tbl SELECT * FROM dbo.ProduceSearchVariant( null )

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

declare @result int = (SELECT COUNT(*) FROM @tbl)

IF  @result <> 0
   RAISERROR ('FAILED: %s result must be 0 %d', 16, -1, @test_name, @result ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestA3a
GO
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestA3b
    declare @test_name sysname = N'TestA3b [ProduceSearchVariant] space'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

declare @tbl TABLE ( line sysname, irank int ) 

-- 2. execute unit test   

insert into @tbl SELECT * FROM dbo.ProduceSearchVariant( '' )

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

declare @result int = (SELECT COUNT(*) FROM @tbl)

IF  @result <> 0
   RAISERROR ('FAILED: %s result must be 1 %d', 16, -1, @test_name, @result ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestA3b
GO
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestA3c
    declare @test_name sysname = N'TestA3c [ProduceSearchVariant] english: Lake Francis'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

declare @tbl TABLE ( line sysname, irank int ) 

-- 2. execute unit test   

insert into @tbl SELECT * FROM dbo.ProduceSearchVariant( N'Lake Francis' )

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

declare @result1 int = (SELECT COUNT(*) FROM @tbl)
declare @result2 int = (SELECT COUNT(*) FROM @tbl WHERE line = N'Lake Francis')

IF  @result1 <> 60 OR @result2 <> 1
   RAISERROR ('FAILED: %s result must be thirty six %d : %d', 16, -1, @test_name, @result1, @result2 ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestA3c
GO
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestA3d
    declare @test_name sysname = N'TestA3d [ProduceSearchVariant] single name Francis'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

declare @tbl TABLE ( line sysname, irank int ) 

-- 2. execute unit test   

insert into @tbl SELECT * FROM dbo.ProduceSearchVariant( N'Francis' )

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

declare @result1 int = (SELECT COUNT(*) FROM @tbl)
declare @result2 int = (SELECT COUNT(*) FROM @tbl WHERE line = N'Francis')

IF  @result1 <> 15 OR @result2 <> 1
   RAISERROR ('FAILED: %s result must be nine %d : %d', 16, -1, @test_name, @result1, @result2 ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestA3d
GO
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestA3e
    declare @test_name sysname = N'TestA3e [ProduceSearchVariant] french: Lac Francis'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

declare @tbl TABLE ( line sysname, irank int ) 

-- 2. execute unit test   

insert into @tbl SELECT * FROM dbo.ProduceSearchVariant( N'Lac Francis' )

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

declare @result1 int = (SELECT COUNT(*) FROM @tbl)
declare @result2 int = (SELECT COUNT(*) FROM @tbl WHERE line = N'Lac Francis' and irank = 0)

IF  @result1 <> 60 OR @result2 <> 1
   RAISERROR ('FAILED: %s result must be thirty six %d : %d', 16, -1, @test_name, @result1, @result2 ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestA3e
GO
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestA3f
    declare @test_name sysname = N'TestA3f [ProduceSearchVariant] triple: Lac Santa Francis'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

declare @tbl TABLE ( line sysname, irank int ) 

-- 2. execute unit test   

insert into @tbl SELECT * FROM dbo.ProduceSearchVariant( N'Lac Santa Francis' )

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

declare @result1 int = (SELECT COUNT(*) FROM @tbl)
declare @result2 int = (SELECT COUNT(*) FROM @tbl WHERE line = N'Lac Santa Francis' and irank = 0)

IF  @result1 <> 420 OR @result2 <> 1
   RAISERROR ('FAILED: %s result must be twenty eight %d : %d', 16, -1, @test_name, @result1, @result2 ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestA3f
GO
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestA3g
    declare @test_name sysname = N'TestA3g [ProduceSearchVariant] quadra: Lac Santa Laperusa Francis'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

declare @tbl TABLE ( line sysname, irank int ) 

-- 2. execute unit test   

insert into @tbl SELECT * FROM dbo.ProduceSearchVariant( N'Lac Santa Laperusa Francis' )

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

declare @result1 int = (SELECT COUNT(*) FROM @tbl)
declare @result2 int = (SELECT COUNT(*) FROM @tbl WHERE line = N'Lac Santa Laperusa Francis' and irank = 0)

IF  @result1 <> 1560 OR @result2 <> 1
   RAISERROR ('FAILED: %s result must be one hundred four %d : %d', 16, -1, @test_name, @result1, @result2 ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestA3g
GO
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestA3h
    declare @test_name sysname = N'TestA3h [ProduceSearchVariant] : Lac St. Francis'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

declare @tbl TABLE ( line sysname, irank int ) 

-- 2. execute unit test   

insert into @tbl SELECT * FROM dbo.ProduceSearchVariant( N'Lac St. Francis' )

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

declare @result1 int = (SELECT COUNT(*) FROM @tbl)
declare @result2 int = (SELECT COUNT(*) FROM @tbl WHERE line = N'Lac St. Francis' and irank = 0)
declare @result3 int = (SELECT COUNT(*) FROM @tbl WHERE line = N'Santa Francis Lake')

IF  @result1 <> 420 OR @result2 <> 1 OR @result3 <> 1
   RAISERROR ('FAILED: %s result must be twenty eight %d : %d', 16, -1, @test_name, @result1, @result2 ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestA3h
GO
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestA3i
    declare @test_name sysname = N'TestA3i [ProduceSearchVariant] : Lac Santa Francis'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

declare @tbl TABLE ( line sysname, irank int ) 

-- 2. execute unit test   

insert into @tbl SELECT * FROM dbo.ProduceSearchVariant( N'Lac Santa Francis' )

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

declare @result1 int = (SELECT COUNT(*) FROM @tbl)
declare @result2 int = (SELECT COUNT(*) FROM @tbl WHERE line = N'Lac Santa Francis' and irank = 0)
declare @result3 int = (SELECT COUNT(*) FROM @tbl WHERE line = N'St. Francis Lake')

IF  @result1 <> 420 OR @result2 <> 1 OR @result3 <> 1
   RAISERROR ('FAILED: %s result must be twenty eight %d : %d', 16, -1, @test_name, @result1, @result2 ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestA3i
GO
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestA3j
    declare @test_name sysname = N'TestA3j [ProduceSearchVariant] : Lac Santa Francis via St. Francis Lake'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

declare @tbl1 TABLE ( line sysname, irank int ) 
declare @tbl2 TABLE ( line sysname, irank int ) 

-- 2. execute unit test   

insert into @tbl1 SELECT * FROM dbo.ProduceSearchVariant( N'Lac Santa Francis' )
insert into @tbl2 SELECT * FROM dbo.ProduceSearchVariant( N'St. Francis Lake' )

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

declare @result1 int = (SELECT COUNT(*) FROM @tbl1)
declare @result2 int = (SELECT COUNT(*) FROM @tbl1 WHERE line = N'Lac Santa Francis' and irank = 0)
declare @result3 int = (SELECT COUNT(*) FROM @tbl2)
declare @result4 int = (SELECT COUNT(*) FROM @tbl2 WHERE line = N'St. Francis Lake' and irank = 0)

IF  @result1 <> 420 OR @result2 <> 1 OR @result3 <> @result1 OR @result4 <> 1
   RAISERROR ('FAILED: %s result must be twenty eight %d : %d', 16, -1, @test_name, @result1, @result2 ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestA3j
GO
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestA3l
    declare @test_name sysname = N'TestA3l [ProduceSearchVariant] : Blackie''s Lake'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

declare @tbl TABLE ( line sysname, irank int ) 

-- 2. execute unit test   

insert into @tbl SELECT * FROM dbo.ProduceSearchVariant( N'Blackie''s Lake' )

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

declare @result1 int = (SELECT COUNT(*) FROM @tbl)
declare @result2 int = (SELECT COUNT(*) FROM @tbl WHERE line = N'Blackie''s Lake' and irank = 0)
declare @result3 int = (SELECT COUNT(*) FROM @tbl WHERE line = N'Lac Blackies' and irank > 0)

IF  @result1 <> 180 OR @result2 <> 1 OR @result3 <> 1
   RAISERROR ('FAILED: %s result must be eight %d : %d : %d', 16, -1, @test_name, @result1, @result2, @result3 ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestA3l
GO
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestA4a
    declare @test_name sysname = N'TestA4a [ProduceSearchVariant] : test river'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

declare @tbl TABLE ( line sysname, irank int ) 

-- 2. execute unit test   

insert into @tbl SELECT * FROM dbo.ProduceSearchVariant( N'test river' )

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

declare @result1 int = (SELECT COUNT(*) FROM @tbl)
declare @result2 int = (SELECT COUNT(*) FROM @tbl WHERE line = N'test river' and irank = 0)

IF  @result1 <> 60 OR @result2 <> 1
   RAISERROR ('FAILED: %s result must be thirty six %d : %d', 16, -1, @test_name, @result1, @result2 ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestA4a
GO
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestA4b
    declare @test_name sysname = N'TestA4b [ProduceSearchVariant] : test Reservoir'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

declare @tbl TABLE ( line sysname, irank int ) 

-- 2. execute unit test   

insert into @tbl SELECT * FROM dbo.ProduceSearchVariant( N'test Reservoir' )

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

declare @result1 int = (SELECT COUNT(*) FROM @tbl)
declare @result2 int = (SELECT COUNT(*) FROM @tbl WHERE line = N'test Reservoir' and irank = 0)

IF  @result1 <> 60 OR @result2 <> 1
   RAISERROR ('FAILED: %s result must be thirty six %d : %d', 16, -1, @test_name, @result1, @result2 ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestA4b
GO
---------------------------------
BEGIN TRAN TestA4d
    declare @test_name sysname = N'TestA4d [ProduceSearchVariant] : test Brook'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

declare @tbl TABLE ( line sysname, irank int ) 

-- 2. execute unit test   

insert into @tbl SELECT * FROM dbo.ProduceSearchVariant( N'test Brook' )

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

declare @result1 int = (SELECT COUNT(*) FROM @tbl)
declare @result2 int = (SELECT COUNT(*) FROM @tbl WHERE line = N'test Brook' and irank = 0)

IF  @result1 <> 210 OR @result2 <> 1
   RAISERROR ('FAILED: %s result must be sixteen %d : %d', 16, -1, @test_name, @result1, @result2 ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestA4d
GO
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestA4e
    declare @test_name sysname = N'TestA4e [ProduceSearchVariant] : test Burn'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

declare @tbl TABLE ( line sysname, irank int ) 

-- 2. execute unit test   

insert into @tbl SELECT * FROM dbo.ProduceSearchVariant( N'test Burn' )

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

declare @result1 int = (SELECT COUNT(*) FROM @tbl)
declare @result2 int = (SELECT COUNT(*) FROM @tbl WHERE line = N'test Burn' and irank = 0)

IF  @result1 <> 210 OR @result2 <> 1
   RAISERROR ('FAILED: %s result must be sixteen %d : %d', 16, -1, @test_name, @result1, @result2 ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestA4e
GO
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestA4f
    declare @test_name sysname = N'TestA4f [ProduceSearchVariant] : test Canal'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

declare @tbl TABLE ( line sysname, irank int ) 

-- 2. execute unit test   

insert into @tbl SELECT * FROM dbo.ProduceSearchVariant( N'test Canal' )

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

declare @result1 int = (SELECT COUNT(*) FROM @tbl)
declare @result2 int = (SELECT COUNT(*) FROM @tbl WHERE line = N'test Canal' and irank = 0)

IF  @result1 <> 120 OR @result2 <> 1
   RAISERROR ('FAILED: %s result must be sixteen %d : %d', 16, -1, @test_name, @result1, @result2 ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestA4f
GO
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestA4g
    declare @test_name sysname = N'TestA4g [ProduceSearchVariant] : test Channel'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

declare @tbl TABLE ( line sysname, irank int ) 

-- 2. execute unit test   

insert into @tbl SELECT * FROM dbo.ProduceSearchVariant( N'test Channel' )

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

declare @result1 int = (SELECT COUNT(*) FROM @tbl)
declare @result2 int = (SELECT COUNT(*) FROM @tbl WHERE line = N'test Channel' and irank = 0)

IF  @result1 <> 120 OR @result2 <> 1
   RAISERROR ('FAILED: %s result must be sixteen %d : %d', 16, -1, @test_name, @result1, @result2 ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestA4g
GO
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestA4h
    declare @test_name sysname = N'TestA4h [ProduceSearchVariant] : test Creek'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

declare @tbl TABLE ( line sysname, irank int ) 

-- 2. execute unit test   

insert into @tbl SELECT * FROM dbo.ProduceSearchVariant( N'test Creek' )

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

declare @result1 int = (SELECT COUNT(*) FROM @tbl)
declare @result2 int = (SELECT COUNT(*) FROM @tbl WHERE line = N'test Creek' and irank = 0)

IF  @result1 <> 210 OR @result2 <> 1
   RAISERROR ('FAILED: %s result must be sixteen %d : %d', 16, -1, @test_name, @result1, @result2 ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestA4h
GO
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestA4i
    declare @test_name sysname = N'TestA4i [ProduceSearchVariant] : test Ocean'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

declare @tbl TABLE ( line sysname, irank int ) 

-- 2. execute unit test   

insert into @tbl SELECT * FROM dbo.ProduceSearchVariant( N'test Ocean' )

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

declare @result1 int = (SELECT COUNT(*) FROM @tbl)
declare @result2 int = (SELECT COUNT(*) FROM @tbl WHERE line = N'test Ocean' and irank = 0)

IF  @result1 <> 120 OR @result2 <> 1
   RAISERROR ('FAILED: %s result must be sixteen %d : %d', 16, -1, @test_name, @result1, @result2 ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestA4i
GO
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestA4j
    declare @test_name sysname = N'TestA4j [ProduceSearchVariant] : test Pond'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

declare @tbl TABLE ( line sysname, irank int ) 

-- 2. execute unit test   

insert into @tbl SELECT * FROM dbo.ProduceSearchVariant( N'test Pond' )

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

declare @result1 int = (SELECT COUNT(*) FROM @tbl)
declare @result2 int = (SELECT COUNT(*) FROM @tbl WHERE line = N'test Pond' and irank = 0)

IF  @result1 <> 60 OR @result2 <> 1
   RAISERROR ('FAILED: %s result must be sixteen %d : %d', 16, -1, @test_name, @result1, @result2 ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestA4j
GO
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestA4k
    declare @test_name sysname = N'TestA4k [ProduceSearchVariant] : test River'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

declare @tbl TABLE ( line sysname, irank int ) 

-- 2. execute unit test   

insert into @tbl SELECT * FROM dbo.ProduceSearchVariant( N'test River' )

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

declare @result1 int = (SELECT COUNT(*) FROM @tbl)
declare @result2 int = (SELECT COUNT(*) FROM @tbl WHERE line = N'test River' and irank = 0)

IF  @result1 <> 60 OR @result2 <> 1
   RAISERROR ('FAILED: %s result must be sixteen %d : %d', 16, -1, @test_name, @result1, @result2 ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestA4k
GO
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestA4l
    declare @test_name sysname = N'TestA4l [ProduceSearchVariant] : test Run'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

declare @tbl TABLE ( line sysname, irank int ) 

-- 2. execute unit test   

insert into @tbl SELECT * FROM dbo.ProduceSearchVariant( N'test Run' )

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

declare @result1 int = (SELECT COUNT(*) FROM @tbl)
declare @result2 int = (SELECT COUNT(*) FROM @tbl WHERE line = N'test Run' and irank = 0)

IF  @result1 <> 210 OR @result2 <> 1
   RAISERROR ('FAILED: %s result must be sixteen %d : %d', 16, -1, @test_name, @result1, @result2 ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestA4l
GO
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestA4m
    declare @test_name sysname = N'TestA4m [ProduceSearchVariant] : test Strait'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

declare @tbl TABLE ( line sysname, irank int ) 

-- 2. execute unit test   

insert into @tbl SELECT * FROM dbo.ProduceSearchVariant( N'test Strait' )

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

declare @result1 int = (SELECT COUNT(*) FROM @tbl)
declare @result2 int = (SELECT COUNT(*) FROM @tbl WHERE line = N'test Strait' and irank = 0)

IF  @result1 <> 120 OR @result2 <> 1
   RAISERROR ('FAILED: %s result must be sixteen %d : %d', 16, -1, @test_name, @result1, @result2 ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestA4m
GO
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestA4n
    declare @test_name sysname = N'TestA4n [ProduceSearchVariant] : test Stream'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

declare @tbl TABLE ( line sysname, irank int ) 

-- 2. execute unit test   

insert into @tbl SELECT * FROM dbo.ProduceSearchVariant( N'test Stream' )

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

declare @result1 int = (SELECT COUNT(*) FROM @tbl)
declare @result2 int = (SELECT COUNT(*) FROM @tbl WHERE line = N'test Stream' and irank = 0)

IF  @result1 <> 60 OR @result2 <> 1
   RAISERROR ('FAILED: %s result must be sixteen %d : %d', 16, -1, @test_name, @result1, @result2 ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestA4n
GO
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestA4o
    declare @test_name sysname = N'TestA4o [ProduceSearchVariant] : test Sea'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

declare @tbl TABLE ( line sysname, irank int ) 

-- 2. execute unit test   

insert into @tbl SELECT * FROM dbo.ProduceSearchVariant( N'test Sea' )

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

declare @result1 int = (SELECT COUNT(*) FROM @tbl)
declare @result2 int = (SELECT COUNT(*) FROM @tbl WHERE line = N'test Sea' and irank = 0)

IF  @result1 <> 120 OR @result2 <> 1
   RAISERROR ('FAILED: %s result must be sixteen %d : %d', 16, -1, @test_name, @result1, @result2 ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestA4o
GO
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestA5a
    declare @test_name sysname = N'TestA5a [ProduceSearchVariant] : test Guid'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

declare @tbl TABLE ( line sysname, irank int ) 

-- 2. execute unit test   

insert into @tbl SELECT * FROM dbo.ProduceSearchVariant( '5AE76765-D052-11D8-92E2-080020A0F4C9' )

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

declare @result1 int = (SELECT COUNT(*) FROM @tbl)
declare @result2 int = (SELECT COUNT(*) FROM @tbl WHERE line = '5AE76765-D052-11D8-92E2-080020A0F4C9')

IF  @result1 <> 15 OR @result2 <> 1
   RAISERROR ('FAILED: %s result must be sixteen %d : %d', 16, -1, @test_name, @result1, @result2 ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestA5a
GO
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestA5b
    declare @test_name sysname = N'TestA5b [ProduceSearchVariant] : test hex Guid'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

declare @tbl TABLE ( line sysname, irank int ) 

-- 2. execute unit test   

insert into @tbl SELECT * FROM dbo.ProduceSearchVariant( '5AE76765-D052-11D8-92E2-080020A0F4C9' )

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

declare @result1 int = (SELECT COUNT(*) FROM @tbl)
declare @result2 int = (SELECT COUNT(*) FROM @tbl WHERE line LIKE '5AE76765-D052-11D8-92E2-080020A0F4C9')

IF  @result1 <> 15 OR @result2 <> 1
   RAISERROR ('FAILED: %s result must be sixteen %d : %d', 16, -1, @test_name, @result1, @result2 ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestA5b
GO
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestA5c
    declare @test_name sysname = N'TestA5c [ProduceSearchVariant] :  "A" Lake'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

declare @tbl TABLE ( line sysname, irank int ) 

-- 2. execute unit test   

insert into @tbl SELECT * FROM dbo.ProduceSearchVariant( N'"A" Lake' )

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

declare @result1 int = (SELECT COUNT(*) FROM @tbl)
declare @result2 int = (SELECT COUNT(*) FROM @tbl WHERE line LIKE N'A Lake')
declare @result3 int = (SELECT COUNT(*) FROM @tbl WHERE line LIKE N'"A" Lake')

IF  @result1 <> 120 OR @result2 <> 1 OR @result3 <> 1
   RAISERROR ('FAILED: %s result must be sixteen %d : %d', 16, -1, @test_name, @result1, @result2 ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestA5c
GO
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestA5c
    declare @test_name sysname = N'TestA5c [ProduceSearchVariant] :  ''A'' Lake'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

declare @tbl TABLE ( line sysname, irank int ) 

-- 2. execute unit test   

insert into @tbl SELECT * FROM dbo.ProduceSearchVariant( N'''A'' Lake' )

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

declare @result1 int = (SELECT COUNT(*) FROM @tbl)
declare @result2 int = (SELECT COUNT(*) FROM @tbl WHERE line LIKE N'A Lake')
declare @result3 int = (SELECT COUNT(*) FROM @tbl WHERE line LIKE N'''A'' Lake')

IF  @result1 <> 120 OR @result2 <> 1 OR @result3 <> 1
   RAISERROR ('FAILED: %s result must be sixteen %d : %d', 16, -1, @test_name, @result1, @result2 ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestA5c
GO
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestA5d
    declare @test_name sysname = N'TestA5d [ProduceSearchVariant] :  North Sigma River'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

declare @tbl TABLE ( line sysname, irank int ) 

-- 2. execute unit test   

insert into @tbl SELECT * FROM dbo.ProduceSearchVariant( N'North Sigma River' )

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

declare @result1 int = (SELECT COUNT(*) FROM @tbl)
declare @result2 int = (SELECT COUNT(*) FROM @tbl WHERE line LIKE N'Sigma River')

IF  @result1 <> 232 OR @result2 <> 1
   RAISERROR ('FAILED: %s result must be sixteen %d : %d', 16, -1, @test_name, @result1, @result2 ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestA5d
GO
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestA5e
    declare @test_name sysname = N'TestA5e [ProduceSearchVariant] : Variant with/or proclamation mark'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

declare @tbl TABLE ( line sysname, irank int ) 

-- 2. execute unit test   

insert into @tbl SELECT * FROM dbo.ProduceSearchVariant( N'Ha! Ha! Lake' )

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

declare @result1 int = (SELECT COUNT(*) FROM @tbl)
declare @result2 int = (SELECT COUNT(*) FROM @tbl WHERE line LIKE N'Ha Ha Lake')

IF  @result1 <> 122 OR @result2 <> 1
   RAISERROR ('FAILED: %s result must be ten %d : %d', 16, -1, @test_name, @result1, @result2 ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestA5e
GO
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestA5f
    declare @test_name sysname = N'TestA5f [ProduceSearchVariant] : Humber River'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

declare @tbl TABLE ( line sysname, irank int ) 

-- 2. execute unit test   

insert into @tbl SELECT * FROM dbo.ProduceSearchVariant( N'Humber River' )

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

declare @result1 int = (SELECT COUNT(*) FROM @tbl)
declare @result2 int = (SELECT COUNT(*) FROM @tbl WHERE line LIKE N'Humber River')

IF  @result1 <> 60 OR @result2 <> 1
   RAISERROR ('FAILED: %s result must be ten %d : %d', 16, -1, @test_name, @result1, @result2 ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestA5f
GO
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestA5fa
    declare @test_name sysname = N'TestA5fa [ProduceSearchVariant] : Naftel''s Creek'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

declare @tbl TABLE ( line sysname, irank int ) 

-- 2. execute unit test   

insert into @tbl SELECT * FROM dbo.ProduceSearchVariant( N'Naftel''s Creek' )

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

declare @result1 int = (SELECT COUNT(*) FROM @tbl)
declare @result2 int = (SELECT COUNT(*) FROM @tbl WHERE line LIKE N'Naftel''s Creek')

IF  @result1 <> 630 OR @result2 <> 1
   RAISERROR ('FAILED: %s result must be ten %d : %d', 16, -1, @test_name, @result1, @result2 ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestA5fa
GO
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestA5g
    declare @test_name sysname = N'TestA5g [ProduceSearchVariant] : West Little White River'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

declare @tbl TABLE ( line sysname, irank int ) 

-- 2. execute unit test   

insert into @tbl SELECT * FROM dbo.ProduceSearchVariant( N'West Little White River' )

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

declare @result1 int = (SELECT COUNT(*) FROM @tbl)
declare @result2 int = (SELECT COUNT(*) FROM @tbl WHERE line LIKE N'West Little White River')

IF  @result1 <> 868 OR @result2 <> 1
   RAISERROR ('FAILED: %s result must be ten %d : %d', 16, -1, @test_name, @result1, @result2 ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestA5g
GO
----------------------------------------------------------------------------------------------------------
PRINT '--------------------------------------------------------------------------------------------------' 
----------------------------------------------------------------------------------------------------------
-- delete from Tributaries;delete from lake
