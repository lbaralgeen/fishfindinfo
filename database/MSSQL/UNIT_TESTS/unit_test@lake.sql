SET QUOTED_IDENTIFIER ON
GO
PRINT 'Unit tests for lake table' 
PRINT '-----------------------------------------------------------------------------------------------------------------------------' 
-- database may not be empty
----------------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestLakeName
    declare @test_name sysname = N'TestLakeName [fn_lake_edit] : lake name'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

insert into lake (locType, lake_name) values (999, N'TestLakeName');

declare @lake_id uniqueidentifier = (select lake_id from lake where lake_name = N'TestLakeName') 

-- 2. execute unit test   

declare @doc xml = dbo.fn_lake_edit( @lake_id );

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

declare @rst sysname =  @doc.value('(/root/node/text())[1]','varchar(100)')

IF  @rst IS NULL OR @rst <> N'TestLakeName'
   RAISERROR ('FAILED: %s result must have name %s', 16, -1, @test_name, @rst ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestLakeName
GO
----------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestLakeLink
    declare @test_name sysname = N'TestLakeLink [fn_lake_edit] : link'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

insert into lake (locType, lake_name, link) values (999, N'TestLakeLink', N'www.link');

declare @lake_id uniqueidentifier = (select lake_id from lake where lake_name = N'TestLakeLink') 

-- 2. execute unit test   

declare @doc xml = dbo.fn_lake_edit( @lake_id );

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

declare @rst sysname =   @doc.value('(/root/node[@name="link"]/text())[1]','nvarchar(255)')  

IF  @rst IS NULL OR @rst <> N'www.link'
   RAISERROR ('FAILED: %s result must have link %s', 16, -1, @test_name, @rst ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestLakeLink
GO
----------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestLakeType
    declare @test_name sysname = N'TestLakeType [fn_lake_edit] : lake type'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

insert into lake (locType, lake_name) values (1, N'TestLakeType');

declare @lake_id uniqueidentifier = (select lake_id from lake where lake_name = N'TestLakeType') 

-- 2. execute unit test   

declare @doc xml = dbo.fn_lake_edit( @lake_id );

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification
declare @rst int = (SELECT T.C.value('@locType', 'int') FROM @doc.nodes('/root/lake') T(C) );

IF  @rst IS NULL OR @rst <> 1
   RAISERROR ('FAILED: %s result must have type %d', 16, -1, @test_name, @rst ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestLakeType
GO
----------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestLakeLength
    declare @test_name sysname = N'TestLakeLength [fn_lake_edit] : lake length'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

insert into lake (locType, lake_name, length) values (1, N'TestLakeLength', 666);

declare @lake_id uniqueidentifier = (select lake_id from lake where lake_name = N'TestLakeLength') 

-- 2. execute unit test   

declare @doc xml = dbo.fn_lake_edit( @lake_id );

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification
declare @rst int = (SELECT T.C.value('@length', 'int') FROM @doc.nodes('/root/lake') T(C) );

IF  @rst IS NULL OR @rst <> 666
   RAISERROR ('FAILED: %s result must have length %d', 16, -1, @test_name, @rst ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestLakeLength
GO
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestLakeDepth
    declare @test_name sysname = N'TestLakeDepth [fn_lake_edit] : lake depth'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

insert into lake (locType, lake_name, depth) values (1, N'TestLakeDepth', 777);

declare @lake_id uniqueidentifier = (select lake_id from lake where lake_name = N'TestLakeDepth') 

-- 2. execute unit test   

declare @doc xml = dbo.fn_lake_edit( @lake_id );

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification
declare @rst int = (SELECT T.C.value('@depth', 'int') FROM @doc.nodes('/root/lake') T(C) );

IF  @rst IS NULL OR @rst <> 777
   RAISERROR ('FAILED: %s result must have depth %d', 16, -1, @test_name, @rst ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestLakeDepth
GO
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestLakeWidth
    declare @test_name sysname = N'TestLakeWidth [fn_lake_edit] : lake width'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

insert into lake (locType, lake_name, width) values (1, N'TestLakeDepth', 878);

declare @lake_id uniqueidentifier = (select lake_id from lake where lake_name = N'TestLakeDepth') 

-- 2. execute unit test   

declare @doc xml = dbo.fn_lake_edit( @lake_id );

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification
declare @rst int = (SELECT T.C.value('@width', 'int') FROM @doc.nodes('/root/lake') T(C) );

IF  @rst IS NULL OR @rst <> 878
   RAISERROR ('FAILED: %s result must have width %d', 16, -1, @test_name, @rst ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestLakeWidth
GO
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestLakeBasin
    declare @test_name sysname = N'TestLakeBasin [fn_lake_edit] : lake basin'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

insert into lake (locType, lake_name, basin) values (1, N'TestLakeBasin', 'Basin');

declare @lake_id uniqueidentifier = (select lake_id from lake where lake_name = N'TestLakeBasin') 

-- 2. execute unit test   

declare @doc xml = dbo.fn_lake_edit( @lake_id );

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification
declare @rst varchar(64) = (SELECT T.C.value('@basin', 'varchar(64)') FROM @doc.nodes('/root/lake') T(C) );

IF  @rst IS NULL OR @rst <> 'Basin'
   RAISERROR ('FAILED: %s result must have basin %s', 16, -1, @test_name, @rst ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestLakeBasin
GO
----------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestLakdescript
    declare @test_name sysname = N'TestLakdescript [fn_lake_edit] : descript'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

insert into lake (locType, lake_name, descript) values (999, N'TestLakdescript', N'descript');

declare @lake_id uniqueidentifier = (select lake_id from lake where lake_name = N'TestLakdescript') 

-- 2. execute unit test   

declare @doc xml = dbo.fn_lake_edit( @lake_id );

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

declare @rst sysname =   @doc.value('(/root/node[@name="descript"]/text())[1]','nvarchar(255)')  

IF  @rst IS NULL OR @rst <> N'descript'
   RAISERROR ('FAILED: %s result must have link %s', 16, -1, @test_name, @rst ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestLakdescript
GO
----------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestLakdedrainage
    declare @test_name sysname = N'TestLakdedrainage [fn_lake_edit] : drainage'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

insert into lake (locType, lake_name, drainage) values (999, N'TestLakdedrainage', N'drainage');

declare @lake_id uniqueidentifier = (select lake_id from lake where lake_name = N'TestLakdedrainage') 

-- 2. execute unit test   

declare @doc xml = (select dbo.fn_lake_edit( @lake_id ));           -- select dbo.fn_lake_edit( '015CA7F7-84E0-E911-9106-00155D007B55' )

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

declare @rst sysname =   @doc.value('(/root/node[@name="drainage"]/text())[1]','nvarchar(128)')  

IF  @rst IS NULL OR  @rst <> N'drainage'
   RAISERROR ('FAILED: %s result must have drainage %s', 16, -1, @test_name, @rst ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestLakdedrainage
GO
----------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestLakdeDischarge
    declare @test_name sysname = N'TestLakdeDischarge [fn_lake_edit] : discharge'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

insert into lake (locType, lake_name, discharge) values (999, N'TestLakdeDischarge', N'discharge');

declare @lake_id uniqueidentifier = (select lake_id from lake where lake_name = N'TestLakdeDischarge') 

-- 2. execute unit test   

declare @doc xml = dbo.fn_lake_edit( @lake_id );

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

declare @rst sysname =   @doc.value('(/root/node[@name="discharge"]/text())[1]','nvarchar(255)')  

IF  @rst IS NULL OR @rst <> N'discharge'
   RAISERROR ('FAILED: %s result must have discharge %s', 16, -1, @test_name, @rst ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestLakdeDischarge
GO
----------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestLakewatershield
    declare @test_name sysname = N'TestLakewatershield [fn_lake_edit] : watershield'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

insert into lake (locType, lake_name, watershield) values (999, N'TestLakewatershield', N'watershield');

declare @lake_id uniqueidentifier = (select lake_id from lake where lake_name = N'TestLakewatershield') 

-- 2. execute unit test   

declare @doc xml = dbo.fn_lake_edit( @lake_id );

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

declare @rst sysname =   @doc.value('(/root/node[@name="watershield"]/text())[1]','nvarchar(255)')  

IF  @rst IS NULL OR @rst <> N'watershield'
   RAISERROR ('FAILED: %s result must have watershield %s', 16, -1, @test_name, @rst ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestLakewatershield
GO
----------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestLake_fishing
    declare @test_name sysname = N'TestLake_fishing [fn_lake_edit] : fishing'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

insert into lake (locType, lake_name, fishing) values (999, N'TestLake_fishing', N'fishing');

declare @lake_id uniqueidentifier = (select lake_id from lake where lake_name = N'TestLake_fishing') 

-- 2. execute unit test   

declare @doc xml = dbo.fn_lake_edit( @lake_id );

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

declare @rst sysname =   @doc.value('(/root/node[@name="fishing"]/text())[1]','nvarchar(max)')  

IF  @rst IS NULL OR @rst <> N'fishing'
   RAISERROR ('FAILED: %s result must have fishing %s', 16, -1, @test_name, @rst ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestLake_fishing
GO
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestLakeVolume
    declare @test_name sysname = N'TestLakeVolume [fn_lake_edit] : lake volume'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

insert into lake (locType, lake_name, volume) values (1, N'TestLakeVolume', 17);

declare @lake_id uniqueidentifier = (select lake_id from lake where lake_name = N'TestLakeVolume') 

-- 2. execute unit test   

declare @doc xml = dbo.fn_lake_edit( @lake_id );

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification
declare @rst int = (SELECT T.C.value('@volume', 'float') FROM @doc.nodes('/root/lake') T(C) );

IF  @rst IS NULL OR @rst <> 17
   RAISERROR ('FAILED: %s result must have volume %f', 16, -1, @test_name, @rst ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestLakeVolume
GO
----------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestLakeShoreline
    declare @test_name sysname = N'TestLakeShoreline [fn_lake_edit] : lake shoreline'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

insert into lake (locType, lake_name, shoreline) values (1, N'TestLakeShoreline', 666);

declare @lake_id uniqueidentifier = (select lake_id from lake where lake_name = N'TestLakeShoreline') 

-- 2. execute unit test   

declare @doc xml = dbo.fn_lake_edit( @lake_id );

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification
declare @rst int = (SELECT T.C.value('@shoreline', 'int') FROM @doc.nodes('/root/lake') T(C) );

IF  @rst IS NULL OR @rst <> 666
   RAISERROR ('FAILED: %s result must have shoreline %d', 16, -1, @test_name, @rst ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestLakeShoreline
GO
----------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestLakeSurface
    declare @test_name sysname = N'TestLakeSurface [fn_lake_edit] : lake surface'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

insert into lake (locType, lake_name, surface) values (1, N'TestLakeSurface', 666);

declare @lake_id uniqueidentifier = (select lake_id from lake where lake_name = N'TestLakeSurface') 

-- 2. execute unit test   

declare @doc xml = dbo.fn_lake_edit( @lake_id );

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification
declare @rst int = (SELECT T.C.value('@surface', 'int') FROM @doc.nodes('/root/lake') T(C) );

IF  @rst IS NULL OR @rst <> 666
   RAISERROR ('FAILED: %s result must have surface %d', 16, -1, @test_name, @rst ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestLakeSurface
GO
----------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestLake_road_access
    declare @test_name sysname = N'TestLake_road_access [fn_lake_edit] : lake_road_access'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

insert into lake (locType, lake_name, lake_road_access) values (999, N'TestLake_road_access', N'lake_road_access');

declare @lake_id uniqueidentifier = (select lake_id from lake where lake_name = N'TestLake_road_access') 

-- 2. execute unit test   

declare @doc xml = dbo.fn_lake_edit( @lake_id );

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

declare @rst sysname =   @doc.value('(/root/node[@name="lake_road_access"]/text())[1]','nvarchar(max)')  

IF  @rst IS NULL OR @rst <> N'lake_road_access'
   RAISERROR ('FAILED: %s result must have lake_road_access %s', 16, -1, @test_name, @rst ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestLake_road_access
GO
----------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestLakeCGNDB
    declare @test_name sysname = N'TestLakeCGNDB [fn_lake_edit] : lake CGNDB'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

insert into lake (locType, lake_name, CGNDB) values (1, N'TestLakeCGNDB', 'CGNDB');

declare @lake_id uniqueidentifier = (select lake_id from lake where lake_name = N'TestLakeCGNDB') 

-- 2. execute unit test   

declare @doc xml = dbo.fn_lake_edit( @lake_id );

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification
declare @rst char(5) = (SELECT T.C.value('@CGNDB', 'char(5)') FROM @doc.nodes('/root/lake') T(C) );

IF  @rst IS NULL OR @rst <> 'CGNDB'
   RAISERROR ('FAILED: %s result must have CGNDB %d', 16, -1, @test_name, @rst ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestLakeCGNDB
GO
----------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestLakeNative
    declare @test_name sysname = N'TestLakeNative [fn_lake_edit] : native'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

insert into lake (locType, lake_name, native) values (999, N'TestLakeNative', N'native');

declare @lake_id uniqueidentifier = (select lake_id from lake where lake_name = N'TestLakeNative') 

-- 2. execute unit test   

declare @doc xml = dbo.fn_lake_edit( @lake_id );

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

declare @rst sysname =   @doc.value('(/root/node[@name="native"]/text())[1]','nvarchar(64)')  

IF  @rst IS NULL OR @rst <> N'native'
   RAISERROR ('FAILED: %s result must have native %s', 16, -1, @test_name, @rst ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestLakeNative
GO
----------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestLake_french_name
    declare @test_name sysname = N'TestLake_french_name [fn_lake_edit] : french_name'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

insert into lake (locType, lake_name, french_name) values (999, N'TestLakeNative', N'french_name');

declare @lake_id uniqueidentifier = (select lake_id from lake where lake_name = N'TestLakeNative') 

-- 2. execute unit test   

declare @doc xml = dbo.fn_lake_edit( @lake_id );

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

declare @rst nvarchar(128) = @doc.value('(/root/node[@name="french_name"]/text())[1]','nvarchar(128)')  

IF  @rst IS NULL OR @rst <> N'french_name'
   RAISERROR ('FAILED: %s result must have french_name %s', 16, -1, @test_name, @rst ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestLake_french_name
GO
----------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestLake_alt_name
    declare @test_name sysname = N'TestLake_alt_name [fn_lake_edit] : alt_name'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

insert into lake (locType, lake_name, alt_name) values (999, N'TestLake_alt_name', N'alt_name');

declare @lake_id uniqueidentifier = (select lake_id from lake where lake_name = N'TestLake_alt_name') 

-- 2. execute unit test   

declare @doc xml = dbo.fn_lake_edit( @lake_id );

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification

declare @rst nvarchar(64) = @doc.value('(/root/node[@name="alt_name"]/text())[1]','nvarchar(64)')  

IF  @rst IS NULL OR @rst <> N'alt_name'
   RAISERROR ('FAILED: %s result must have alt_name %s', 16, -1, @test_name, @rst ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestLake_alt_name
GO
----------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestLakeIsolated
    declare @test_name sysname = N'TestLakeIsolated [fn_lake_edit] : lake isolated'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

insert into lake (locType, lake_name, isolated) values (1, N'TestLakeIsolated', 1);

declare @lake_id uniqueidentifier = (select lake_id from lake where lake_name = N'TestLakeIsolated') 

-- 2. execute unit test   

declare @doc xml = dbo.fn_lake_edit( @lake_id );

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification
declare @rst int = (SELECT T.C.value('@isolated', 'int') FROM @doc.nodes('/root/lake') T(C) );

IF  @rst IS NULL OR @rst <> 1
   RAISERROR ('FAILED: %s result must have isolated %d', 16, -1, @test_name, @rst ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestLakeIsolated
GO
----------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestLakeProhibited
    declare @test_name sysname = N'TestLakeIsolated [fn_lake_edit] : lake is_fishing_prohibited'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

insert into lake (locType, lake_name, is_fishing_prohibited) values (1, N'TestLakeProhibited', 1);

declare @lake_id uniqueidentifier = (select lake_id from lake where lake_name = N'TestLakeProhibited') 

-- 2. execute unit test   

declare @doc xml = dbo.fn_lake_edit( @lake_id );

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification
declare @rst int = (SELECT T.C.value('@is_fishing_prohibited', 'int') FROM @doc.nodes('/root/lake') T(C) );

IF  @rst IS NULL OR @rst <> 1
   RAISERROR ('FAILED: %s result must have is_fishing_prohibited %d', 16, -1, @test_name, @rst ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestLakeProhibited
GO
----------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------
BEGIN TRAN TestXmlTributary
    declare @test_name sysname = N'TestXmlTributary [fn_xml_tributary] : lake is_fishing_prohibited'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

insert into lake (locType, lake_name ) values (1, N'TestXmlTributary' );

declare @lake_id uniqueidentifier = (select lake_id from lake where lake_name = N'TestXmlTributary') 

-- 2. execute unit test   

declare @doc xml = dbo.fn_xml_tributary( @lake_id, 0 );

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH

-- 3. result verification
declare @rst sysname =   @doc.value('(/root/node/text())[1]','nvarchar(64)')  

IF  @rst IS NOT NULL OR @rst <> N''
   RAISERROR ('FAILED: %s result should not have name %s', 16, -1, @test_name, @rst ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN TestXmlTributary
GO
----------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------
PRINT '--------------------------------------------------------------------------------------------------' 
----------------------------------------------------------------------------------------------------------
-- exec sp_del_river   '029D1EBD-87E5-E911-9106-00155D007B55'

 