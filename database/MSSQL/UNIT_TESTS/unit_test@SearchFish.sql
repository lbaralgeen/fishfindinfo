SET QUOTED_IDENTIFIER ON
GO
PRINT 'Unit tests for search functions' 
PRINT '-----------------------------------------------------------------------------------------------------------------------------' 
----------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestSSFL1
    declare @test_name sysname = N'TestSSFL1 [SearchFishList] : find by single word name'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

insert into fish (fish_name, fish_latin, family_Id, pic) values ('splike',  'latin', '00000000-0000-0000-0000-000000000000', 0x00)
declare @tbl table (fish_name sysname)

-- 2. execute unit test   

insert into @tbl (fish_name)  SELECT fish_name FROM dbo.SearchFishList( 'splike' )

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

declare @result1 int = (SELECT COUNT(*) FROM @tbl)
declare @result2 int = (SELECT COUNT(*) FROM @tbl WHERE fish_name = 'splike')

IF  @result1 <> 1 OR @result2 <> 1
   RAISERROR ('FAILED: %s result must be single records %d ', 16, -1, @test_name, @result1  ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestSSFL1
GO
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestSSFL1a
    declare @test_name sysname = N'TestSSFL1a [SearchFishList] : find by double word name'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

insert into fish (fish_name, fish_latin, family_Id, pic) values ('splike fish',  'latin', '00000000-0000-0000-0000-000000000000', 0x00)
declare @tbl table (fish_name sysname)

-- 2. execute unit test   

insert into @tbl (fish_name)  SELECT fish_name FROM dbo.SearchFishList( 'splike fish' )

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

declare @result1 int = (SELECT COUNT(*) FROM @tbl)
declare @result2 int = (SELECT COUNT(*) FROM @tbl WHERE fish_name = 'splike fish')

IF  @result1 <> 1 OR @result2 <> 1
   RAISERROR ('FAILED: %s result must be single records %d ', 16, -1, @test_name, @result1  ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestSSFL1a
GO
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestSSFL1b
    declare @test_name sysname = N'TestSSFL1b [SearchFishList] : find by single word name with upfront space'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

insert into fish (fish_name, fish_latin, family_Id, pic) values ('splike',  'latin', '00000000-0000-0000-0000-000000000000', 0x00)
declare @tbl table (fish_name sysname)

-- 2. execute unit test   

insert into @tbl (fish_name)  SELECT fish_name FROM dbo.SearchFishList( ' splike' )

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

declare @result1 int = (SELECT COUNT(*) FROM @tbl)
declare @result2 int = (SELECT COUNT(*) FROM @tbl WHERE fish_name = 'splike')

IF  @result1 <> 1 OR @result2 <> 1
   RAISERROR ('FAILED: %s result must be single records %d ', 16, -1, @test_name, @result1  ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestSSFL1b
GO
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestSSFL1c
    declare @test_name sysname = N'TestSSFL1c [SearchFishList] : find by single word name with postpond space'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

insert into fish (fish_name, fish_latin, family_Id, pic) values ('splike',  'latin', '00000000-0000-0000-0000-000000000000', 0x00)
declare @tbl table (fish_name sysname)

-- 2. execute unit test   

insert into @tbl (fish_name)  SELECT fish_name FROM dbo.SearchFishList( 'splike ' )

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

declare @result1 int = (SELECT COUNT(*) FROM @tbl)
declare @result2 int = (SELECT COUNT(*) FROM @tbl WHERE fish_name = 'splike')

IF  @result1 <> 1 OR @result2 <> 1
   RAISERROR ('FAILED: %s result must be single records %d ', 16, -1, @test_name, @result1  ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestSSFL1c
GO
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestSSFL1d
    declare @test_name sysname = N'TestSSFL1d [SearchFishList] : find by single word name surranded by space'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

insert into fish (fish_name, fish_latin, family_Id, pic) values ('splike',  'latin', '00000000-0000-0000-0000-000000000000', 0x00)
declare @tbl table (fish_name sysname)

-- 2. execute unit test   

insert into @tbl (fish_name)  SELECT fish_name FROM dbo.SearchFishList( ' splike ' )

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

declare @result1 int = (SELECT COUNT(*) FROM @tbl)
declare @result2 int = (SELECT COUNT(*) FROM @tbl WHERE fish_name = 'splike')

IF  @result1 <> 1 OR @result2 <> 1
   RAISERROR ('FAILED: %s result must be single records %d ', 16, -1, @test_name, @result1  ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestSSFL1d
GO
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestSSFL2
    declare @test_name sysname = N'TestSSFL2 [SearchFishList] : find by single word latin name'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

insert into fish (fish_name, fish_latin, family_Id, pic) values ('splike',  'latin', '00000000-0000-0000-0000-000000000000', 0x00)
declare @tbl table (fish_name sysname)

-- 2. execute unit test   

insert into @tbl (fish_name)  SELECT fish_name FROM dbo.SearchFishList( 'latin' )

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

declare @result1 int = (SELECT COUNT(*) FROM @tbl)
declare @result2 int = (SELECT COUNT(*) FROM @tbl WHERE fish_name = 'splike')

IF  @result1 <> 1 OR @result2 <> 1
   RAISERROR ('FAILED: %s result must be single records %d ', 16, -1, @test_name, @result1  ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestSSFL2
GO
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestSSFL2a
    declare @test_name sysname = N'TestSSFL2a [SearchFishList] : find by double word latin name'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

insert into fish (fish_name, fish_latin, family_Id, pic) values ('splike',  'latin double', '00000000-0000-0000-0000-000000000000', 0x00)
declare @tbl table (fish_name sysname)

-- 2. execute unit test   

insert into @tbl (fish_name)  SELECT fish_name FROM dbo.SearchFishList( 'latin double' )

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

declare @result1 int = (SELECT COUNT(*) FROM @tbl)
declare @result2 int = (SELECT COUNT(*) FROM @tbl WHERE fish_name = 'splike')

IF  @result1 <> 1 OR @result2 <> 1
   RAISERROR ('FAILED: %s result must be single records %d ', 16, -1, @test_name, @result1  ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestSSFL2a
GO
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestSSFL3
    declare @test_name sysname = N'TestSSFL3 [SearchFishList] : find by double word name with comma - full match'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

insert into fish (fish_name, fish_latin, family_Id, pic) values ('Sucker, Longnose',  'latin double', '00000000-0000-0000-0000-000000000000', 0x00)
declare @tbl table (fish_name sysname)

-- 2. execute unit test   

insert into @tbl (fish_name)  SELECT fish_name FROM dbo.SearchFishList( 'Sucker, Longnose' )

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

declare @result1 int = (SELECT COUNT(*) FROM @tbl)
declare @result2 int = (SELECT COUNT(*) FROM @tbl WHERE fish_name = 'Sucker, Longnose')

IF  @result1 <> 1 OR @result2 <> 1
   RAISERROR ('FAILED: %s result must be single records %d ', 16, -1, @test_name, @result1  ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestSSFL3
GO
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestSSFL3a
    declare @test_name sysname = N'TestSSFL3a [SearchFishList] : find by double word name with comma - alt match '
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

insert into fish (fish_name, fish_latin, family_Id, pic) values ('Sucker, Longnose',  'latin double', '00000000-0000-0000-0000-000000000000', 0x00)
declare @tbl table (fish_name sysname)

-- 2. execute unit test   

insert into @tbl (fish_name)  SELECT fish_name FROM dbo.SearchFishList( 'Longnose Sucker' )

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

declare @result1 int = (SELECT COUNT(*) FROM @tbl)
declare @result2 int = (SELECT COUNT(*) FROM @tbl WHERE fish_name = 'Sucker, Longnose')

IF  @result1 <> 1 OR @result2 <> 1
   RAISERROR ('FAILED: %s result must be single records %d ', 16, -1, @test_name, @result1  ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestSSFL3a
GO
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestSSFL3b
    declare @test_name sysname = N'TestSSFL3b [SearchFishList] : find by double word name with comma - alt match2 '
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

insert into fish (fish_name, fish_latin, family_Id, pic) values ('Sucker, Longnose',  'latin double', '00000000-0000-0000-0000-000000000000', 0x00)
declare @tbl table (fish_name sysname)

-- 2. execute unit test   

insert into @tbl (fish_name)  SELECT fish_name FROM dbo.SearchFishList( 'Sucker Longnose' )

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

declare @result1 int = (SELECT COUNT(*) FROM @tbl)
declare @result2 int = (SELECT COUNT(*) FROM @tbl WHERE fish_name = 'Sucker, Longnose')

IF  @result1 <> 1 OR @result2 <> 1
   RAISERROR ('FAILED: %s result must be single records %d ', 16, -1, @test_name, @result1  ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestSSFL3b
GO
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestSSFL4
    declare @test_name sysname = N'TestSSFL4 [SearchFishList] : find by three word name : full match'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

insert into fish (fish_name, fish_latin, family_Id, pic) values ('Trout, Westslope Cutthroat',  'Oncorhynchus clarki lewisi', '00000000-0000-0000-0000-000000000000', 0x00)
declare @tbl table (fish_name sysname)

-- 2. execute unit test   

insert into @tbl (fish_name)  SELECT fish_name FROM dbo.SearchFishList( 'Trout, Westslope Cutthroat' )

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

declare @result1 int = (SELECT COUNT(*) FROM @tbl)
declare @result2 int = (SELECT COUNT(*) FROM @tbl WHERE fish_name = 'Trout, Westslope Cutthroat')

IF  @result1 <> 1 OR @result2 <> 1
   RAISERROR ('FAILED: %s result must be single records %d ', 16, -1, @test_name, @result1  ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestSSFL4
GO
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestSSFL4a
    declare @test_name sysname = N'TestSSFL4a [SearchFishList] : find by three word name: akt match'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

insert into fish (fish_name, fish_latin, family_Id, pic) values ('Trout, Westslope Cutthroat',  'Oncorhynchus clarki lewisi', '00000000-0000-0000-0000-000000000000', 0x00)
declare @tbl table (fish_name sysname)

-- 2. execute unit test   

insert into @tbl (fish_name)  SELECT fish_name FROM dbo.SearchFishList( 'Westslope Cutthroat Trout' )

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

declare @result1 int = (SELECT COUNT(*) FROM @tbl)
declare @result2 int = (SELECT COUNT(*) FROM @tbl WHERE fish_name = 'Trout, Westslope Cutthroat')

IF  @result1 <> 1 OR @result2 <> 1
   RAISERROR ('FAILED: %s result must be single records %d ', 16, -1, @test_name, @result1  ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestSSFL4a
GO
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestSSFL5
    declare @test_name sysname = N'TestSSFL5 [SearchFishList] : find by quatra word name'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

insert into fish (fish_name, fish_latin, family_Id, pic) values ('Lamprey, Small black brook',  'latin double', '00000000-0000-0000-0000-000000000000', 0x00)
declare @tbl table (fish_name sysname)

-- 2. execute unit test   

insert into @tbl (fish_name)  SELECT fish_name FROM dbo.SearchFishList( 'Lamprey, Small black brook' )

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

declare @result1 int = (SELECT COUNT(*) FROM @tbl)
declare @result2 int = (SELECT COUNT(*) FROM @tbl WHERE fish_name = 'Lamprey, Small black brook')

IF  @result1 <> 1 OR @result2 <> 1
   RAISERROR ('FAILED: %s result must be single records %d ', 16, -1, @test_name, @result1  ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestSSFL5
GO
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestMalma
    declare @test_name sysname = N'TestMalma [SearchFishList] : find by single synonim'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

insert into fish (fish_name, fish_latin, family_Id, pic, alt_name) values ('Trout, Dolly Varden',  'Salvelinus malma', '00000000-0000-0000-0000-000000000000', 0x00, 'malma')
declare @tbl table (fish_name sysname)

-- 2. execute unit test   

insert into @tbl (fish_name)  SELECT fish_name FROM dbo.SearchFishList( 'malma ' )

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

declare @result1 int = (SELECT COUNT(*) FROM @tbl)
declare @result2 int = (SELECT COUNT(*) FROM @tbl WHERE fish_name = 'Trout, Dolly Varden')

IF  @result1 <> 1 OR @result2 <> 1
   RAISERROR ('FAILED: %s result must be single records %d ', 16, -1, @test_name, @result1  ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestMalma
GO
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestAcadian
    declare @test_name sysname = N'TestAcadian  [SearchFishList] : find by double synonim'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

insert into fish (fish_name, fish_latin, family_Id, pic, alt_name) values ('Acadian redfish',  'Sebastes fasciatus', '00000000-0000-0000-0000-000000000000', 0x00, 'Atlantic redfish;ocean perch')
declare @tbl table (fish_name sysname)

-- 2. execute unit test   

insert into @tbl (fish_name)  SELECT fish_name FROM dbo.SearchFishList( 'Atlantic redfish ' )

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

declare @result1 int = (SELECT COUNT(*) FROM @tbl)
declare @result2 int = (SELECT COUNT(*) FROM @tbl WHERE fish_name = 'Acadian redfish')

IF  @result1 <> 1 OR @result2 <> 1
   RAISERROR ('FAILED: %s result must be single records %d ', 16, -1, @test_name, @result1  ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestAcadian
GO
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestAcadian2
    declare @test_name sysname = N'TestAcadian2  [SearchFishList] : find by double synonim'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

insert into fish (fish_name, fish_latin, family_Id, pic, alt_name) values ('Acadian redfish',  'Sebastes fasciatus', '00000000-0000-0000-0000-000000000000', 0x00, 'Atlantic redfish;ocean perch')
declare @tbl table (fish_name sysname)

-- 2. execute unit test   

insert into @tbl (fish_name)  SELECT fish_name FROM dbo.SearchFishList( 'ocean perch' )

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

declare @result1 int = (SELECT COUNT(*) FROM @tbl)
declare @result2 int = (SELECT COUNT(*) FROM @tbl WHERE fish_name = 'Acadian redfish')

IF  @result1 <> 1 OR @result2 <> 1
   RAISERROR ('FAILED: %s result must be single records %d ', 16, -1, @test_name, @result1  ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestAcadian2
GO
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestSalmon
    declare @test_name sysname = N'TestSalmon  [SearchFishList] : find all Salmons'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

insert into fish (fish_name, fish_latin, family_Id, pic, alt_name) values ('Atlantic Salmon',  'Sebastes fasciatus', '00000000-0000-0000-0000-000000000000', 0x00, 'Salmo salar')
insert into fish (fish_name, fish_latin, family_Id, pic, alt_name) values ('Salmon, Coho',  'Oncorhynchus kisutch', '969E5641-010F-4E55-8E2C-00A04979F2CF', 0x00, 'Oncorhynchus kisutch')
declare @tbl table (fish_name sysname)

-- 2. execute unit test   

insert into @tbl (fish_name)  SELECT fish_name FROM dbo.SearchFishList( 'Salmon' )

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

declare @result1 int = (SELECT COUNT(*) FROM @tbl)
declare @result2 int = (SELECT COUNT(*) FROM @tbl WHERE fish_name = 'Acadian redfish')

IF  @result1 <> 2
   RAISERROR ('FAILED: %s result must be single records %d ', 16, -1, @test_name  ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestSalmon
GO
----------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestSalmon
    declare @test_name sysname = N'TestSalmon  [SearchFishList] : find "fin tuna"'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

insert into fish (fish_name, fish_latin, family_Id, pic, alt_name) values ('Atlantic bluefin tuna',  'Thunnus thynnus', '6B0D3CFE-7E3B-4109-A3A7-0A14C860850D', 0x00, ' ')
insert into fish (fish_name, fish_latin, family_Id, pic, alt_name) values ('Albacore Tuna',  'Thunnus alalunga', '6B0D3CFE-7E3B-4109-A3A7-0A14C860850D', 0x00, ' ')
declare @tbl table (fish_name sysname)

-- 2. execute unit test   

insert into @tbl (fish_name)  SELECT fish_name FROM dbo.SearchFishList( 'fin tuna' )

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

declare @result1 int = (SELECT COUNT(*) FROM @tbl)
declare @result2 int = (SELECT COUNT(*) FROM @tbl WHERE fish_name = 'Acadian redfish')

IF  @result1 <> 2
   RAISERROR ('FAILED: %s result must be single records %d ', 16, -1, @test_name  ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestSalmon
GO
----------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------
PRINT '--------------------------------------------------------------------------------------------------' 
----------------------------------------------------------------------------------------------------------
-- delete from fish_Rule;delete from fish