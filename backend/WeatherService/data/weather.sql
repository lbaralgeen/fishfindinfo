declare @tbl TABLE(val  nvarchar(max));
INSERT INTO @tbl(val) 
SELECT BulkColumn FROM OPENROWSET(BULK N'k:\main\fish\Server\Weather\data\weather.json ', SINGLE_BLOB) rs;
declare @js nvarchar(max) = (select ows from [ows_meteo] where mli='05MD011');
declare  @link uniqueidentifier = newid();

exec sp_ows_meteo @js, 'sdsd', @link 

