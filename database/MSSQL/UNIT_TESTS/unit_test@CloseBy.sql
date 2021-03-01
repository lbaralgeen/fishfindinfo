SET QUOTED_IDENTIFIER ON

PRINT 'Unit tests for Close By' 
PRINT '-----------------------------------------------------------------------------------------------------------------------------' 

GO
----------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------
BEGIN TRAN Test1
    declare @test_name sysname = 'Test1 [fn_GetCloseLake] Single Point for lake no closeby'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

insert into lake (lake_name, locType, Lake_id) values ('Lake',  1, '00000000-0000-0000-0000-000000000000')

UPDATE Tributaries SET lat = 1, lon = 1 where Main_Lake_id = '00000000-0000-0000-0000-000000000000' and side = 16

-- 2. execute unit test

declare @result int = ( select count(*) from dbo.fn_GetCloseLake( '00000000-0000-0000-0000-000000000000' ) );

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH
IF @result <> 0
   RAISERROR ('FAILED: %s failed to find right message: %d ', 16, -1, @test_name, @result ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN Test1
GO
----------------------------------------------------------------------------------------------------------
-- single lake with source has no turbidities and closeby lake
----------------------------------------------------------------------------------------------------------
BEGIN TRAN Test2
    declare @test_name sysname = 'Test2 [fn_GetCloseLake] Single Point for single lake no closeby'
BEGIN TRY  SET NOCOUNT ON;

-- 1. prepare data for unit test

insert into lake (lake_name, locType, Lake_id) values ('Lake',  1, '00000000-0000-0000-0000-000000000000')
insert into lake (lake_name, locType, Lake_id) values ('Lake2', 1, '11111111-1111-1111-1111-111111111111')

UPDATE Tributaries SET lat = 1, lon = 1 where Main_Lake_id = '00000000-0000-0000-0000-000000000000' and side = 16
UPDATE Tributaries SET lat = 2, lon = 2 where Main_Lake_id = '11111111-1111-1111-1111-111111111111' and side = 16

-- 2. execute unit test          --       select * from dbo.fn_GetCloseLake( '11111111-1111-1111-1111-111111111111' ) 

declare @result int = ( select count(*) from dbo.fn_GetCloseLake( '00000000-0000-0000-0000-000000000000' ) );

END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage
END CATCH
IF @result <> 0
   RAISERROR ('FAILED: %s failed to find right message: %d ', 16, -1, @test_name, @result ) 
ELSE
    print 'PASSED ' + @test_name

ROLLBACK TRAN Test2
GO
----------------------------------------------------------------------------------------------------------

declare @TBL TABLE (num int NOt NULL identity(1,1) PRIMARY KEY, Id uniqueidentifier, lake_name sysname, lat float, lon float)
declare @lk table (num int, name sysname, lat float, lon float, id uniqueidentifier)
declare @lakeId uniqueidentifier = '00000000-0000-0000-0000-000000000000' 
--   select * from dbo.fn_GetCloseLake( '00000000-0000-0000-0000-000000000000' ) 
insert into @lk SELECT num, CAST(lake_name AS sysname) AS lake_name, lat, lon, lake_id FROM dbo.fn_ViewTributary(@lakeId) ;
select * from @lk

;with cte  as
(
    SELECT num, name, lat, lon, id FROM @lk
)select * from cte
    INSERT INTO @TBL SELECT rid, lake_name, lat, lon FROM 
    (
        SELECT DISTINCT rid from 
        (
            select x.rid from cte
            cross apply
            (select TOP 7 cte.num
                , v.lake_name as rname, v.lat, v.lon, v.lake_id as rid from dbo.vw_lake v 
				join cte ON CAST(cte.lat AS int) = CAST(v.lat AS int) AND CAST(cte.lon AS int) = CAST(v.lon AS int)
                WHERE v.lake_id <> cte.id) x 
        )x
    )y JOIN dbo.vw_lake v ON lake_id = y.rid

----------------------------------------------------------------------------------------------------------
PRINT '--------------------------------------------------------------------------------------------------' 
----------------------------------------------------------------------------------------------------------

-- delete from Tributaries; delete from lake

 