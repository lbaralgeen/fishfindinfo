alter table cdn add fguid uniqueidentifier
GO
update cdn set fguid = dbo.CvtHexToGuid(ID)
GO
delete from cdn where CGNDB in (SELECT CGNDB from lake)
GO
alter table [cdn]  add loctype int
GO
update t set t.locType = a.locType from cdn t join abbr a on t.[CGNDB]=a.[CGNDB]
GO

delete from [cdn] where loctype is null

select distinct  gtype from cdn where locType is null order by 1 asc
GO
alter table lake add french_name nvarchar(255)

update l set native = cdn.name from Lake l join cdn on l.[CGNDB] = cdn.[CGNDB] where LANGUAGE not in ( 'French', 'English', 'Undetermined', 'Uncoded Languages')
update l set native = cdn.name from Lake l join cdn on l.[CGNDB] = cdn.[CGNDB] where LANGUAGE not in ( 'French', 'English', 'Undetermined', 'Uncoded Languages')


alter table lake alter column native nvarchar(128)


SELECT TOP (1000) *   FROM [cdn] where not exists (select * from Lake l join cdn on l.[CGNDB] = cdn.[CGNDB])

insert into Lake (lake_id, lake_name, old_id, loctype)
     select fguid, name, ID, loctype, CGNDB from cdn where not exists (select * from Lake join cdn on Lake.CGNDB = cdn.CGNDB)
     and exists (select * from Lake join cdn on Lake.lake_id = cdn.fguid)


-- 12345678-1234-1234-1234-123456789ABC
-- 1097bf09-d054-11d8-92e2-080020a0f4c9    
/*
alter function dbo.CvtHexToGuid( @hex varchar(36)  )
RETURNS uniqueidentifier
AS
BEGIN
    RETURN CAST(LEFT(@hex, 8) + '-' + SUBSTRING(@hex, 9, 4) + '-' + SUBSTRING(@hex, 13, 4)  + '-' + SUBSTRING(@hex, 17, 4)+ '-' + SUBSTRING(@hex, 21, 12) AS uniqueidentifier)
END
GO
*/

update cdn set locType = 1 where gtype in( 'Lake', 'Artificial Lake')
update cdn set locType = 2 where gtype = 'River'
update cdn set locType = 4 where gtype in ( 'Stream', 'Rapids', 'Rapid', 'Sound')
update cdn set locType = 8 where gtype in ( 'Pond', 'Pool')
update cdn set locType = 128 where gtype in ( 'Canal', 'Channel')
update cdn set locType = 1024 where gtype = 'Drain'
update cdn set locType = 8192 where gtype = 'Reservoir'
update cdn set locType = 16384 where gtype in ( 'Bay', 'Bays', 'Harbours', 'Harbour')
update cdn set locType = 32468 where gtype = 'Sea'

delete from cdn where locType is null