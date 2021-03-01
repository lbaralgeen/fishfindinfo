-------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------

IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'fn_clean_river_name')
    DROP FUNCTION dbo.fn_clean_river_name
GO

IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'fn_river_list' AND xtype = 'IF')
    DROP FUNCTION dbo.fn_river_list
GO

/*
    Usage:
        SELECT dbo.fn_clean_river_name( N'Chumak Viteetshìk' )
*/

CREATE FUNCTION dbo.fn_clean_river_name( @full_river_name sysname )
RETURNS sysname
WITH SCHEMABINDING 
BEGIN
	DECLARE @result sysname = @full_river_name
	SELECT TOP 1 @result = CASE WHEN NULLIF(val, '') IS NULL THEN @full_river_name ELSE val END FROM 
		(
			SELECT DISTINCT z.val FROM 
			(
				SELECT DISTINCT val FROM 
				( 
					SELECT CAST(en AS sysname) As name FROM dbo.water_body 
					UNION ALL
					SELECT fr FROM dbo.water_body 
					UNION ALL
					SELECT gw FROM dbo.water_body WHERE gw IS NOT NULL
				) l CROSS APPLY 
					(SELECT TRIM(REPLACE(@full_river_name, l.name, N'')) )x(val)
			)z
		)y WHERE y.val <> @full_river_name
	RETURN @result
END
GO

IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'GetStationInfo' AND xtype = 'TF')
    DROP FUNCTION dbo.GetStationInfo
GO

CREATE FUNCTION dbo.GetStationInfo( @fishId uniqueidentifier, @placeId bigint )
  RETURNS @TBL TABLE (wheatherStamp datetime, lat float, lon float, loadWeather int
        , county varchar(64), city varchar(64), state char(2), country char(2), locName varchar(max), id uniqueidentifier
        , today int
        , temperature float, turbidity float, oxygen float, sid int, mli varchar(64)
        , stamp datetime, discharge float, elevation float )
    AS
    begin
      DECLARE @today int, @temperature float, @turbidity float, @oxygen float, @state char(2)
      DECLARE @stamp datetime, @discharge float, @elevation float, @locId uniqueidentifier, @shift int
      DECLARE @isw int, @wsId uniqueidentifier, @mli varchar(64)
      
      SELECT @mli = w.mli, @wsId = w.id, @today = f.today  FROM WaterStation w 
        JOIN dbo.fish_location f ON  (w.id = f.station_Id) WHERE w.sid=@placeId and @fishId = fish_Id
    
  INSERT INTO @TBL   
    SELECT w.wheatherStamp, w.lat, w.lon, 0 as loadWeather, county, city, [state], country, locName, id, @today 
       , s.temperature, s.turbidity, s.oxygen, w.sid, w.mli, s.stamp, s.discharge, s.elevation
    FROM vWaterStation w, CurrentWaterState s  WHERE w.mli=s.mli AND w.sid = @placeId
    
    SELECT @stamp = stamp, @state = state FROM @TBL  
    SELECT @shift = shift FROM states WHERE state = @state
    SET @stamp = DATEADD( HOUR, -@shift, @stamp)
    SELECT @isw = COUNT(*) FROM dbo.weather_Forecast   -- check if todays weather is saved
       WHERE link= @wsId AND CONVERT(VARCHAR(10),GETDATE(),101) <= dt AND tm IS NULL
    UPDATE @TBL SET stamp = @stamp, loadWeather = ISNULL(@isw, 0)         
  return
END      
GO
----------  display current wheather for last 10 days from ForecastFrame.aspx.cs ----------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'fnWeatherForecast' AND xtype = 'TF')
    DROP FUNCTION dbo.fnWeatherForecast
GO

CREATE FUNCTION dbo.fnWeatherForecast( @link uniqueidentifier )
  RETURNS @TBL TABLE (dt date, wind_degree float, gpfDay float, gpfNight float, humidity int
  , wind_direction varchar(4), tmLow float, tmHigh float, wind_max_speed float, shortText varchar(255)
  , longText  varchar(255), icon  varchar(32)  )
AS
BEGIN
  INSERT INTO @TBL
    SELECT dt, wind_degree, gpfDay, gpfNight, humidity, wind_direction
    , tmLow, tmHigh, wind_max_speed, shortText, longText, icon
      FROM weather_Forecast WHERE tm IS NULL AND dt >= CONVERT(VARCHAR(10),GETDATE(),101)   
        AND link = @link 
  RETURN
END  
GO  
----------------------------------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'fn_get_fish_list_type' AND xtype = 'IF')
    DROP FUNCTION dbo.fn_get_fish_list_type
GO
/*
    Used in Admin -> FishList
    select * from dbo.fn_get_fish_list_type( 1 ) ORDER BY fish_name ASC 
----------  get list of species for editing ----------------
*/
--  select * from dbo.fn_get_fish_list_type( 32 )   -- sport fishes
-- 1 - sport, 2 - commersial, 4 - invading
CREATE FUNCTION fn_get_fish_list_type( @fish_type int )
RETURNS TABLE
WITH SCHEMABINDING
RETURN
SELECT ROW_NUMBER() OVER (ORDER BY fish_name ASC) AS num, fish_name, fish_latin, fish_id FROM
(
      SELECT fish_name, fish_latin, fish_id, 0 AS line FROM dbo.fish
      UNION ALL
      SELECT fish_name, fish_latin, fish_id, 1 AS line FROM dbo.fish 
        WHERE @fish_type = @fish_type & fish_type
)a WHERE line = CASE WHEN @fish_type IS NULL OR 0 = @fish_type THEN 0 ELSE 1 END
 GO
----------------------------------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'fn_get_trial_location' AND xtype = 'IF')
    DROP function dbo.fn_get_trial_location
GO

CREATE function [dbo].fn_get_trial_location( @fishName  varchar(64), @lat float, @lon float )
  RETURNS  TABLE
  WITH SCHEMABINDING
AS
RETURN
    SELECT w.mli, w.county, w.state, w.country, w.LocName as location, w.sid, w.lat, w.lon, f.today 
      FROM dbo.vWaterStation w JOIN [dbo].[fish_location] f ON (f.station_Id = w.id  )
      WHERE ( w.lat between (@lat-1.0) AND (@lat+1.0) ) AND (w.lon between (@lon-1.0) AND (@lon+1.0) ) 
        AND EXISTS( SELECT fish_name FROM dbo.fish s WHERE fish_name = @fishName and f.fish_id = s.fish_id )
GO
-- select * from [dbo].fn_get_trial_location( 'Burbot', 43, -80 )
-------------------------------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'GetUserLocation' AND xtype = 'TF')
    DROP FUNCTION dbo.GetUserLocation
GO

create function dbo.GetUserLocation( @userId uniqueidentifier )
  RETURNS @TBL TABLE ( postal sysname, lat float, lon float, email sysname )
    AS
BEGIN
  DECLARE @postal sysname, @email sysname    
  SELECT TOP 1 @postal=postal, @email=email FROM users WHERE id=@userId
--  IF 0 > LEN(@postal)
--    RETURN;
  INSERT INTO @TBL   
  select TOP 1 @postal, lat, lon, @email from dbo.GetLatLonByPostal( @postal )
  RETURN;
END
GO
-------------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'fn_get_fish_bylatlon' AND xtype = 'IF')
    DROP FUNCTION dbo.fn_get_fish_bylatlon
GO

CREATE FUNCTION dbo.fn_get_fish_bylatlon( @lat real, @lon real, @dist real  )
  RETURNS TABLE 
RETURN
  SELECT DISTINCT fish_id, fish_name FROM 
  (
    SELECT fish_id, fish_name FROM dbo.vget_fish_list v
      WHERE EXISTS
        ( SELECT * FROM dbo.fish_location f JOIN WaterStation w ON (f.station_Id = w.id)
            WHERE f.fish_id = v.fish_id 
           AND ( w.lat between (@lat-@dist) AND (@lat+@dist) )
           AND ( w.lon between (@lon-@dist) AND (@lon+@dist) )
           AND w.country = 'US'
        )      
    UNION ALL
    SELECT s.fish_id, v.fish_name FROM dbo.vget_fish_list v RIGHT JOIN Fish_State s ON (v.fish_id = s.fish_id)
      WHERE EXISTS
        ( SELECT * FROM dbo.fish_location f JOIN WaterStation w ON (f.station_Id = w.id)
            WHERE f.fish_id = v.fish_id 
           AND ( w.lat between (@lat-@dist) AND (@lat+@dist) )
           AND ( w.lon between (@lon-@dist) AND (@lon+@dist) )
           AND w.country = 'CA'
        )     
   )ul 
GO
--  SELECT * FROM dbo.GetLatLonByIP( '::1' )
-- select * from dbo.fn_get_fish_bylatlon( 41, -83, 3 )    -- V5K 0A1
----------------------------------------------------------------------------------------------------------------------------

IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'GetLatLonByPostal' AND xtype = 'TF')
    DROP FUNCTION dbo.GetLatLonByPostal
GO

CREATE FUNCTION GetLatLonByPostal( @postal varchar(8) )
RETURNS @TBL TABLE (lat float, lon float )
AS
begin
  IF 1 = ISNUMERIC(@postal) AND (LEN(@postal) = 5 OR LEN(@postal) = 4)
  BEGIN
    insert into @TBL
      SELECT lat, lon FROM [USPost] where  zip= @postal 
  END
  ELSE
    insert into @TBL SELECT lat, lon  FROM CanPostLatLon  where postal=@postal
  return
end          
GO     
-- SELECT TOP 1 lat, lon FROM dbo.GetLatLonByPostal( 'V2K1G7' )
-- SELECT TOP 1 lat, lon FROM dbo.GetLatLonByPostal( '98101' )
 
----------------------------------------------------------------------------------------------------------------------------

IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'GetLatLonByIP' AND xtype = 'TF')
    DROP FUNCTION dbo.GetLatLonByIP
GO

CREATE FUNCTION GetLatLonByIP( @ip sysname )
RETURNS @TBL TABLE (lat float, lon float )
AS
begin
  declare @ip4 binary(4)
  SET @ip4 = CAST( dbo.IP2Int(@ip) AS binary(4) )
  if EXISTS (SELECT * FROM dbo.GeoIP WHERE ip4 = @ip4)
      insert into @TBL SELECT latitude, longitude FROM GeoIP WHERE ip4 = @ip4
  ELSE
    insert into @TBL (lat , lon ) VALUES (41, -80)
  return
end         
GO

--  select * from dbo.GetLatLonByIP( '38.127.167.46' )

----------------------------------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'CheckInterval' AND xtype = 'FN')
    DROP FUNCTION dbo.CheckInterval
GO    

create function dbo.CheckInterval( @low float, @high float  )
RETURNS BIT
AS
BEGIN
  DECLARE @rst BIT
  SET @rst = 0;
  IF @low IS NOT NULL AND @high IS NOT NULL AND @high > @low 
    SET @rst = 1;
  RETURN @rst;        
END
GO
----------------------------------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'GetStation' AND xtype = 'TF')
    DROP FUNCTION dbo.GetStation
GO

create function dbo.GetStation( @lat float, @lon float, @dist float )
  RETURNS @TBL TABLE (mli varchar(32) NOT NULL PRIMARY KEY, lat float, lon float )
    AS
    begin
      insert into @TBL (mli, lat, lon)
         SELECT mli, lat, lon FROM vWaterStation w
              WHERE ( lat between (@lat-@dist) AND (@lat+@dist) ) AND (lon between (@lon-@dist) AND (@lon+@dist) ) 
                AND EXISTS ( select * from dbo.fish_location f WHERE f.station_Id = w.id )
  return
END      
GO
--  SELECT mli, lat, lon FROM dbo.GetStation( 40, -81, 3 ) 
-------------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'Int2IP' AND xtype = 'FN')
    DROP function dbo.Int2IP
GO

CREATE function dbo.Int2IP
(@i bigint)
returns varchar(15)
WITH SCHEMABINDING
as
begin
  return        cast((@i/16777216)%256 as varchar(3)) 
    +'.'+cast((@i/65536)%256 as varchar(3))
    +'.'+cast((@i/256)%256 as varchar(3))
    +'.'+cast(@i%256 as varchar(3))
end
GO
-------------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'BinaryToIP' AND xtype = 'FN')
    DROP FUNCTION dbo.BinaryToIP
GO

CREATE  FUNCTION dbo.BinaryToIP
    (
    @binIP Binary(4)
    )
RETURNS varchar(15)
WITH SCHEMABINDING
AS
    BEGIN
        DECLARE @Tmp bigint
        SET @Tmp=@binIP
RETURN  LTRIM(STR((@Tmp & 0xff000000) /0x1000000))+'.'+
    LTRIM(STR((@Tmp & 0xff0000) /0x10000))+'.'+
    LTRIM(STR((@Tmp & 0xff00) /0x100))+'.'+
    LTRIM(STR((@Tmp & 0xff)))

    END
GO
-------------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'IpToBinary' AND xtype = 'FN')
    DROP FUNCTION dbo.IpToBinary
GO

CREATE  FUNCTION dbo.IpToBinary( @strIP varchar(15) )
  RETURNS Binary(4)
WITH SCHEMABINDING
AS
    BEGIN
        DECLARE @Tmp Binary(4)
        SET @Tmp=CAST(
        CAST(PARSENAME(@strIP,4) as bigint)*0x1000000
        +CAST(PARSENAME(@strIP,3) as bigint)*0x10000
        +CAST(PARSENAME(@strIP,2) as bigint)*0x100
        +CAST(PARSENAME(@strIP,1) as bigint)
        as binary(4))
        RETURN @Tmp
    END
 GO
----------------------------------------------------------------------------------------------------------------------------------

IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'GetLocations' AND xtype = 'TF')
    DROP FUNCTION dbo.GetLocations
GO

IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'GetStation' AND xtype = 'TF')
    DROP FUNCTION dbo.GetStation
GO

IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'GetFisNamePlaceDescr' AND xtype = 'TF')
    DROP FUNCTION dbo.GetFisNamePlaceDescr
GO

IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'fn_get_trial_fish_byzip' AND xtype = 'IF')
    DROP FUNCTION dbo.fn_get_trial_fish_byzip
GO
-------------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'fn_get_trial_fish_bylatlon' AND xtype = 'IF')
    DROP FUNCTION dbo.fn_get_trial_fish_bylatlon
GO

--  SELECT * FROM dbo.fn_get_trial_fish_bylatlon( 43, -80  ) ORDER BY 2
-------------------------------------------------------------------------------------------------------

IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'fn_get_trial_fish_bylatlon' AND xtype = 'IF')
    DROP FUNCTION dbo.fn_get_trial_fish_bylatlon
GO
-------------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'fn_get_latlon_byzip' AND xtype = 'IF')
    DROP FUNCTION dbo.fn_get_latlon_byzip
GO
IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'fn_get_trial_location' AND xtype = 'IF')
    DROP FUNCTION dbo.fn_get_trial_location
GO
IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'GetStationInfo' AND xtype = 'TF')
    DROP FUNCTION dbo.GetStationInfo
GO
-------------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'GetStationInfo' AND xtype = 'TF')
    DROP FUNCTION dbo.GetStationInfo
GO

CREATE FUNCTION dbo.GetStationInfo( @fishId uniqueidentifier, @placeId bigint )
  RETURNS @TBL TABLE (wheatherStamp datetime, lat float, lon float, loadWeather int
        , county varchar(64), city varchar(64), state char(2), country char(2), locName varchar(max), id uniqueidentifier
        , today int
        , temperature float, turbidity float, oxygen float, sid int, mli varchar(64)
        , stamp datetime, discharge float, elevation float )
WITH SCHEMABINDING
    AS
    begin
      DECLARE @today int, @temperature float, @turbidity float, @oxygen float, @state char(2)
      DECLARE @stamp datetime, @discharge float, @elevation float, @locId uniqueidentifier, @shift int
      DECLARE @isw int, @wsId uniqueidentifier, @mli varchar(64)
      
      SELECT @mli = w.mli, @wsId = w.id, @today = f.today  FROM dbo.WaterStation w 
        JOIN dbo.fish_location f ON  (w.id = f.station_Id) WHERE w.sid=@placeId and @fishId = fish_Id
    
  INSERT INTO @TBL   
    SELECT w.wheatherStamp, w.lat, w.lon, 0 as loadWeather, county, city, [state], country, locName, id, @today 
       , s.temperature, s.turbidity, s.oxygen, w.sid, w.mli, s.stamp, s.discharge, s.elevation
    FROM dbo.vWaterStation w, dbo.CurrentWaterState s  WHERE w.mli=s.mli AND w.sid = @placeId
    
    SELECT @stamp = stamp, @state = state FROM @TBL  
    SELECT @shift = shift FROM dbo.states WHERE state = @state
    SET @stamp = DATEADD( HOUR, -@shift, @stamp)
    SELECT @isw = COUNT(*) FROM dbo.weather_Forecast   -- check if todays weather is saved
       WHERE link= @wsId AND CONVERT(VARCHAR(10),GETDATE(),101) <= dt AND tm IS NULL
    UPDATE @TBL SET stamp = @stamp, loadWeather = ISNULL(@isw, 0)         
  return
END      
GO

-------------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'fn_get_trial_location' AND xtype = 'IF')
    DROP FUNCTION dbo.fn_get_trial_location
GO

CREATE function dbo.fn_get_trial_location( @fishName  varchar(64), @lat float, @lon float )
  RETURNS  TABLE
  WITH SCHEMABINDING
AS
RETURN
    SELECT w.mli, w.county, w.state, w.country, w.LocName as location, w.sid, w.lat, w.lon, f.today 
      FROM dbo.vWaterStation w JOIN [dbo].[fish_location] f ON (f.station_Id = w.id  )
      WHERE ( w.lat between (@lat-1.0) AND (@lat+1.0) ) AND (w.lon between (@lon-1.0) AND (@lon+1.0) ) 
        AND EXISTS( SELECT fish_name FROM dbo.fish s WHERE fish_name = @fishName and f.fish_id = s.fish_id )
GO
-------------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'fn_get_trial_fish_bylatlon' AND xtype = 'IF')
    DROP FUNCTION dbo.fn_get_trial_fish_bylatlon
GO

CREATE FUNCTION dbo.fn_get_trial_fish_bylatlon( @lat real, @lon real )
  RETURNS TABLE 
WITH SCHEMABINDING
RETURN
    SELECT fish_id, fish_name FROM dbo.vget_trial_fish_list v
      WHERE EXISTS
        ( SELECT TOP 1 1 FROM  dbo.lake_fish  lf
            JOIN dbo.WaterStation w  ON (lf.lake_Id = w.lakeId)
            WHERE ( lf.fish_id = v.fish_Id)
           AND ( w.lat between (@lat-1) AND (@lat+1) )
           AND ( w.lon between (@lon-1) AND (@lon+1) )
        )        
GO
-------------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'fn_get_trial_fish_byzip' AND xtype = 'IF')
    DROP FUNCTION dbo.fn_get_trial_fish_byzip
GO
IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'fn_get_trial_fish_bylatlon' AND xtype = 'IF')
    DROP FUNCTION dbo.fn_get_trial_fish_bylatlon
GO

CREATE FUNCTION dbo.fn_get_trial_fish_bylatlon( @lat real, @lon real )
  RETURNS TABLE 
WITH SCHEMABINDING
RETURN
    SELECT fish_id, fish_name FROM dbo.vget_trial_fish_list v
      WHERE EXISTS
        ( SELECT TOP 1 1 FROM  dbo.lake_fish  lf
            JOIN dbo.WaterStation w  ON (lf.lake_Id = w.lakeId)
            WHERE ( lf.fish_id = v.fish_Id)
           AND ( w.lat between (@lat-1) AND (@lat+1) )
           AND ( w.lon between (@lon-1) AND (@lon+1) )
        )        
GO
-------------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'fn_get_trial_fish_byzip' AND xtype = 'IF')
    DROP FUNCTION dbo.fn_get_trial_fish_byzip
GO
IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'fn_get_latlon_byzip' AND xtype = 'IF')
    DROP FUNCTION dbo.fn_get_latlon_byzip
GO

CREATE FUNCTION dbo.fn_get_latlon_byzip( @zip varchar(6) )
RETURNS  TABLE 
WITH SCHEMABINDING
  RETURN
    SELECT lat, lon FROM 
    (
        SELECT lat, lon, 0 AS country FROM dbo.CanPostLatLon WHERE @zip = postal
        UNION ALL
        SELECT lat, lon, 1 AS country FROM dbo.USPost WHERE @zip = zip
     )a WHERE country = ISNUMERIC(@zip) 
GO
---------------------------------------------------------------------------------------------

IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'GetTrialFishByPostal' AND xtype = 'IF')
    DROP FUNCTION dbo.GetTrialFishByPostal
GO

CREATE FUNCTION dbo.GetTrialFishByPostal( @postal varchar(6) )
RETURNS  TABLE 
  RETURN
    SELECT fish_Id, fish_name, 0 AS country FROM dbo.fn_get_latlon_byzip(@postal) c 
      CROSS APPLY dbo.fn_get_trial_fish_bylatlon( c.lat, c.lon ) l 
GO
--  select * from dbo.GetTrialFishByPostal( 'N2M5L4' )
-------------------------------------------------------------------------------------------------------
CREATE FUNCTION dbo.fn_get_trial_fish_byzip( @postal varchar(6) )
RETURNS  TABLE 
WITH SCHEMABINDING
  RETURN
    SELECT fish_Id, fish_name, 0 AS country FROM dbo.fn_get_latlon_byzip( @postal) c 
      CROSS APPLY dbo.fn_get_trial_fish_bylatlon( c.lat, c.lon  ) l 
GO
-------------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'fn_get_trial_fish_byzip' AND xtype = 'IF')
    DROP FUNCTION dbo.fn_get_trial_fish_byzip
GO
--  SELECT * FROM dbo.fn_get_trial_fish_bylatlon( 43, -80  ) ORDER BY 2

CREATE FUNCTION dbo.fn_get_trial_fish_byzip( @postal varchar(6) )
RETURNS  TABLE 
WITH SCHEMABINDING
  RETURN
    SELECT fish_Id, fish_name, 0 AS country FROM dbo.fn_get_latlon_byzip(@postal) c 
      CROSS APPLY dbo.fn_get_trial_fish_bylatlon( c.lat, c.lon  ) l 
GO
----------------------------------------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'GetFisNamePlaceDescr' AND xtype = 'TF')
    DROP FUNCTION dbo.GetFisNamePlaceDescr
GO

CREATE function dbo.GetFisNamePlaceDescr( @fishId uniqueidentifier, @placeId bigint  )
  RETURNS @TBL TABLE ( name sysname, place sysname )
WITH SCHEMABINDING
    AS
BEGIN
  DECLARE @place sysname, @desc sysname, @state sysname
  SELECT TOP 1 @place=locName FROM dbo.vWaterStation WHERE sid=@placeId
  INSERT INTO @TBL   
     SELECT TOP 1 fish_name, @place FROM dbo.fish WHERE fish_id=@fishId
  RETURN;
END
GO
----------------------------------------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'GetStation' AND xtype = 'TF')
    DROP FUNCTION dbo.GetStation
GO

CREATE function dbo.GetStation( @lat float, @lon float, @dist float )
  RETURNS @TBL TABLE (mli varchar(32) NOT NULL PRIMARY KEY, lat float, lon float )
WITH SCHEMABINDING
    AS
    begin
      insert into @TBL (mli, lat, lon)
         SELECT mli, lat, lon FROM dbo.vWaterStation w
              WHERE ( lat between (@lat-@dist) AND (@lat+@dist) ) AND (lon between (@lon-@dist) AND (@lon+@dist) ) 
                AND EXISTS ( select TOP 1 1 from dbo.fish_location f WHERE f.station_Id = w.id )
  return
END      
GO
----------------------------------------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'GetLocations' AND xtype = 'TF')
    DROP FUNCTION dbo.GetLocations
GO

CREATE function dbo.GetLocations( @fishName  varchar(64), @lat float, @lon float, @dist float )
  RETURNS @TBL TABLE ( mli varchar(32) primary key, county varchar(64), state char(2), country char(2)
                     , name varchar(64), sid int not null, lat float, lon float, today int)
WITH SCHEMABINDING
    AS
BEGIN
  DECLARE @fishId uniqueidentifier
  select @fishId = fish_Id FROM dbo.fish WHERE fish_name LIKE @fishName

  INSERT INTO @TBL
     SELECT w.mli, w.county, w.state, w.country, w.LocName as name, w.sid, w.lat, w.lon, f.today 
        FROM dbo.vWaterStation w, [dbo].[fish_location] f 
        WHERE ( w.lat between (@lat-@dist) AND (@lat+@dist) ) AND (w.lon between (@lon-@dist) AND (@lon+@dist) ) 
           AND f.station_Id = w.id AND @fishId=f.fish_Id 

   IF EXISTS( SELECT TOP 1 1 FROM @TBL WHERE country = 'CA' AND state = 'ON' )
     DELETE FROM @tbl WHERE country = 'CA' AND state = 'ON' 
       AND mli NOT IN (SELECT w.mli FROM dbo.WaterStation w, dbo.fish_location l 
         WHERE w.Id=l.station_Id AND l.fish_Id = @fishId 
         AND w.country = 'CA' AND w.state = 'ON')

    return
END
GO
-------------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'fn_get_fish_bylatlon' AND xtype = 'IF')
    DROP FUNCTION dbo.fn_get_fish_bylatlon
GO

CREATE FUNCTION dbo.fn_get_fish_bylatlon( @lat real, @lon real, @dist real  )
  RETURNS TABLE 
WITH SCHEMABINDING
RETURN
  SELECT DISTINCT fish_id, fish_name FROM 
  (
    SELECT fish_id, fish_name FROM dbo.vget_fish_list v
      WHERE EXISTS
        ( SELECT TOP 1 1 FROM dbo.fish_location f JOIN dbo.WaterStation w ON (f.station_Id = w.id)
            WHERE f.fish_id = v.fish_id 
           AND ( w.lat between (@lat-@dist) AND (@lat+@dist) )
           AND ( w.lon between (@lon-@dist) AND (@lon+@dist) )
           AND w.country = 'US'
        )      
    UNION ALL
    SELECT s.fish_id, v.fish_name FROM dbo.vget_fish_list v RIGHT JOIN dbo.Fish_State s ON (v.fish_id = s.fish_id)
      WHERE EXISTS
        ( SELECT TOP 1 1 FROM dbo.fish_location f JOIN dbo.WaterStation w ON (f.station_Id = w.id)
            WHERE f.fish_id = v.fish_id 
           AND ( w.lat between (@lat-@dist) AND (@lat+@dist) )
           AND ( w.lon between (@lon-@dist) AND (@lon+@dist) )
           AND w.country = 'CA'
        )     
   )ul 
GO
--  SELECT * FROM dbo.GetLatLonByIP( '::1' )
-- select * from dbo.fn_get_fish_bylatlon( 41, -83, 3 )    -- V5K 0A1
-------------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'fn_get_trial_fish_byzip' AND xtype = 'IF')
    DROP FUNCTION dbo.fn_get_trial_fish_byzip
GO

create FUNCTION dbo.fn_get_trial_fish_byzip( @postal varchar(6) )
RETURNS  TABLE 
WITH SCHEMABINDING
  RETURN
    SELECT fish_Id, fish_name, 0 AS country FROM dbo.fn_get_latlon_byzip(@postal) c 
      CROSS APPLY dbo.fn_get_trial_fish_bylatlon( c.lat, c.lon  ) l 
GO
-------------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'GetTrialFishByPostal' AND xtype = 'IF')
    DROP FUNCTION dbo.GetTrialFishByPostal
GO

CREATE FUNCTION dbo.GetTrialFishByPostal( @postal varchar(6) )
RETURNS  TABLE 
  RETURN
    SELECT fish_Id, fish_name, 0 AS country FROM dbo.fn_get_latlon_byzip(@postal) c 
      CROSS APPLY dbo.fn_get_trial_fish_bylatlon( c.lat, c.lon ) l 
GO
--  select * from dbo.GetTrialFishByPostal( 'N2M5L4' )
---------------------------------------------------------------------------------------------
----------  get list of species for editing ----------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'fn_get_fish_list_type' AND xtype = 'IF')
    DROP FUNCTION dbo.fn_get_fish_list_type
GO

-- 1 - sport, 2 - commersial, 4 - invading
CREATE FUNCTION fn_get_fish_list_type( @fish_type int )
RETURNS TABLE
WITH SCHEMABINDING
RETURN
SELECT ROW_NUMBER() OVER (ORDER BY fish_name ASC) AS num, fish_name, fish_latin, fish_id FROM
(
  SELECT fish_name, fish_latin, fish_id, 0 AS line FROM dbo.fish
  UNION ALL
  SELECT fish_name, fish_latin, fish_id, 1 AS line FROM dbo.fish 
    WHERE @fish_type = @fish_type & fish_type
 )a WHERE line = CASE WHEN @fish_type IS NULL OR 0 = @fish_type THEN 0 ELSE 1 END
GO
 --  select * from dbo.fn_get_fish_list_type( 32 )   -- sport fishes
---------------------------------------------------------------------------------------------
 ----------  display current wheather for last 10 days from ForecastFrame.aspx.cs ----------------

IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'fnWeatherForecast' AND xtype = 'TF')
    DROP FUNCTION dbo.fnWeatherForecast
GO

CREATE FUNCTION [dbo].fnWeatherForecast( @link uniqueidentifier )
  RETURNS @TBL TABLE (dt date, wind_degree float, gpfDay float, gpfNight float, humidity int
  , wind_direction varchar(4), tmLow float, tmHigh float, wind_max_speed float, shortText varchar(255)
  , longText  varchar(255), icon  varchar(32)  )
-- WITH SCHEMABINDING
AS
BEGIN
  INSERT INTO @TBL
    SELECT dt, wind_degree, gpfDay, gpfNight, humidity, wind_direction
    , tmLow, tmHigh, wind_max_speed, shortText, longText, icon
      FROM dbo.weather_Forecast WHERE tm IS NULL AND dt >= CONVERT(VARCHAR(10),GETDATE(),101)   
        AND link = @link 
  RETURN
END  
GO  

-- select * from vStationInfo
-------------------------------------  used in a frame  --------------------------------------------------------------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'GetStationInfo' AND xtype = 'TF')
    DROP FUNCTION dbo.GetStationInfo
GO

CREATE FUNCTION [dbo].[GetStationInfo]( @fishId uniqueidentifier, @placeId bigint )
  RETURNS @TBL TABLE (wheatherStamp datetime, lat float, lon float, loadWeather int
        , county varchar(64), city varchar(64), state char(2), country char(2), locName varchar(max), id uniqueidentifier
        , today int
        , temperature float, turbidity float, oxygen float, sid int, mli varchar(64)
        , stamp datetime, discharge float, elevation float )
WITH SCHEMABINDING
    AS
    begin
      DECLARE @today int, @temperature float, @turbidity float, @oxygen float, @state char(2)
      DECLARE @stamp datetime, @discharge float, @elevation float, @locId uniqueidentifier, @shift int
      DECLARE @isw int, @wsId uniqueidentifier, @mli varchar(64)
      
      SELECT @mli = w.mli, @wsId = w.id, @today = f.today  FROM  dbo.WaterStation w 
        JOIN dbo.fish_location f ON  (w.id = f.station_Id) WHERE w.sid=@placeId and @fishId = fish_Id
    
  INSERT INTO @TBL   
    SELECT w.wheatherStamp, w.lat, w.lon, 0 as loadWeather, county, city, [state], country, locName, id, @today 
       , s.temperature, s.turbidity, s.oxygen, w.sid, w.mli, s.stamp, s.discharge, s.elevation
    FROM  dbo.vWaterStation w,  dbo.CurrentWaterState s  WHERE w.mli=s.mli AND w.sid = @placeId
    
    SELECT @stamp = stamp, @state = state FROM @TBL  
    SELECT @shift = shift FROM dbo.states WHERE state = @state
    SET @stamp = DATEADD( HOUR, -@shift, @stamp)
    SELECT @isw = COUNT(*) FROM dbo.weather_Forecast   -- check if todays weather is saved
       WHERE link= @wsId AND CONVERT(VARCHAR(10),GETDATE(),101) <= dt AND tm IS NULL
    UPDATE @TBL SET stamp = @stamp, loadWeather = ISNULL(@isw, 0)         
  return
END      
GO
--  select * from dbo.GetStationInfo( (select fish_ID from dbo.fish where fish_name='Brown Trout'), 264004)
GO  
-- select * from dbo.WaterStation where country='CA' AND state='ON'
------------------------------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'GetLatLonByPostal' AND xtype = 'TF')
    DROP FUNCTION dbo.GetLatLonByPostal
GO

CREATE FUNCTION dbo.GetLatLonByPostal( @postal varchar(8) )
RETURNS @TBL TABLE (lat float, lon float )
WITH SCHEMABINDING
AS
begin
  IF 1 = ISNUMERIC(@postal) AND (LEN(@postal) = 5 OR LEN(@postal) = 4)
  BEGIN
    insert into @TBL
        SELECT lat, lon FROM dbo.USPost where  zip= @postal 
  END
  ELSE
    insert into @TBL SELECT lat, lon  
      FROM dbo.CanPostLatLon  where postal=@postal
  return
end          
GO     
-- SELECT TOP 1 lat, lon FROM dbo.GetLatLonByPostal( 'V2K1G7' )
-- SELECT TOP 1 lat, lon FROM dbo.GetLatLonByPostal( '98101' )
----------------------------------------------------------------------------------------------------------------------------
 IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'GetUserLocation' AND xtype = 'TF')
    DROP FUNCTION dbo.GetUserLocation
GO    
create function dbo.GetUserLocation( @userId uniqueidentifier )
  RETURNS @TBL TABLE ( postal sysname, lat float, lon float, email sysname )
WITH SCHEMABINDING
    AS
BEGIN
  DECLARE @postal sysname, @email sysname    
  SELECT TOP 1 @postal=postal, @email=email FROM dbo.users WHERE id=@userId
--  IF 0 > LEN(@postal)
--    RETURN;
  INSERT INTO @TBL   
  select TOP 1 @postal, lat, lon, @email from dbo.GetLatLonByPostal( @postal )
  RETURN;
END
GO
----------------------------------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'CheckInterval' AND xtype = 'FN')
    DROP FUNCTION dbo.CheckInterval
GO    
create function dbo.CheckInterval( @low float, @high float  )
RETURNS BIT
WITH SCHEMABINDING
AS
BEGIN
  DECLARE @rst BIT
  SET @rst = 0;
  IF @low IS NOT NULL AND @high IS NOT NULL AND @high > @low 
    SET @rst = 1;
  RETURN @rst;        
END
GO
----------------------------------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'fn_map_latlon_byip' AND xtype = 'TF')
    DROP FUNCTION dbo.fn_map_latlon_byip
GO
IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'GetLatLonByIP' AND xtype = 'TF')
    DROP FUNCTION dbo.GetLatLonByIP
GO
IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'GetLatLonByIP' AND xtype = 'TF')
    DROP function dbo.GetLatLonByIP
GO
-------------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'IP2Int' AND xtype = 'FN')
    DROP function dbo.IP2Int
GO
CREATE function dbo.IP2Int
(@ip varchar(15))
returns bigint
WITH SCHEMABINDING
as
begin
  return cast(PARSENAME(@ip , 1) as tinyint)
    +cast(PARSENAME(@ip , 2) as tinyint)*cast(256 as bigint)
    +cast(PARSENAME(@ip , 3) as tinyint)*cast(65536 as bigint)
    +cast(PARSENAME(@ip , 4) as tinyint)*cast(16777216 as bigint)
end
GO
-------------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'GetLatLonByIP' AND xtype = 'TF')
    DROP function dbo.GetLatLonByIP
GO
CREATE FUNCTION dbo.GetLatLonByIP( @ip sysname )
RETURNS @TBL TABLE (lat float, lon float )
WITH SCHEMABINDING
AS
begin
  declare @ip4 binary(4)
  SET @ip4 = CAST( dbo.IP2Int(@ip) AS binary(4) )

  if EXISTS (SELECT TOP 1 1 FROM dbo.GeoIP WHERE ip4 = @ip4)
      insert into @TBL SELECT latitude, longitude 
        FROM dbo.GeoIP WHERE ip4 = @ip4
  ELSE
    insert into @TBL (lat , lon ) VALUES (41, -80)
  return
end         
GO
-------------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'GetLastHourWaterData' AND xtype = 'IF')
    DROP function dbo.GetLastHourWaterData
GO
--http://fishportal.biz/WebService/Update.aspx?WaterData=A29B196D-B909-30A0-B719-6AFC8C3DE123
--  SELECT * FROM dbo.GetLastHourWaterData( 2, 'CA', 'ON' )
CREATE FUNCTION dbo.GetLastHourWaterData( @hr int, @country char(2), @state char(2) )
RETURNS TABLE
WITH SCHEMABINDING
RETURN
WITH cte AS
(
    SELECT MAX(stamp) AS stamp, AVG(temperature) AS temperature, AVG(discharge) AS discharge
        , AVG(turbidity) AS turbidity, AVG(oxygen) AS oxygen, AVG(ph) AS PH, AVG(elevation) AS elevation, AVG(velocity) AS velocity, mli 
        FROM dbo.vw_WaterData
        WHERE country=@country and state = @state AND stamp >= DATEADD( hour, -1 * @hr, getdate() ) 
        GROUP BY mli
)
SELECT stamp, temperature, discharge, turbidity, oxygen, ph, elevation, velocity, mli FROM cte
UNION ALL
    SELECT stamp, temperature, discharge, turbidity, oxygen, ph, elevation, velocity, mli
        FROM dbo.vw_WaterData z WHERE EXISTS
        (SELECT 1 FROM  ( SELECT MAX(stamp) AS stamp, mli FROM dbo.vw_WaterData v WHERE 
        country=@country and state = @state AND 
        NOT EXISTS (SELECT 1 FROM cte WHERE v.mli=cte.mli) GROUP BY mli )x
            WHERE z.stamp=x.stamp AND z.mli=x.mli )
GO
-------------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'GetLastHourFishLocation' AND xtype = 'IF')
    DROP function dbo.GetLastHourFishLocation
GO 
--http://fishportal.biz/WebService/Update.aspx?FishLocation=75501A06-5176-4465-B299-D6041D25931C
CREATE FUNCTION dbo.GetLastHourFishLocation( @hr int )
RETURNS TABLE
WITH SCHEMABINDING
RETURN
WITH cte  AS
(
SELECT   d.today, d.fish_id, d.station_Id
  FROM dbo.fish_location d 
    JOIN dbo.WaterStation w ON  (d.station_Id = w.id) 
    AND w.country='CA' and w.state = 'ON' AND d.stamp >= DATEADD( hour, -1, getdate() ) 
)
SELECT today, fish_id, station_Id FROM cte
UNION ALL
SELECT top 1  today, fish_id, station_Id  
  FROM dbo.fish_location d 
  JOIN dbo.WaterStation w ON (d.station_Id = w.id) --   
    AND w.country='CA' and w.state = 'ON'  
    AND EXISTS (SELECT MAX(wd.stamp)  FROM dbo.WaterData wd   where wd.stamp = d.stamp ) 
    AND NOT EXISTS ( SELECT TOP 1 1 FROM cte)
GO
--------------------------------------------------------------------------------------------------------------------------------------------------
-- SELECT dbo.fn_CvtHexToGuid( '  {5ae76765d05211d892e2080020a0f4c9 } ' )
--------------------------------------------------------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'NormalizeSearch' AND xtype = 'FN')
    DROP function dbo.NormalizeSearch
GO

IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'fn_CvtHexToGuid' AND xtype = 'FN')
    DROP function dbo.fn_CvtHexToGuid
GO
/*
	convert string form of guid typed with spaces and figure brackets into guid
*/
CREATE function dbo.fn_CvtHexToGuid( @hex varchar(64)  )
RETURNS uniqueidentifier
WITH SCHEMABINDING
AS
BEGIN
    RETURN 
		( SELECT CAST(val AS uniqueidentifier) AS val
		  FROM  (SELECT LEFT(val, 8) + '-' + SUBSTRING(val, 9, 4) + '-' + SUBSTRING(val, 13, 4)  + '-' + SUBSTRING(val, 17, 4)+ '-' + SUBSTRING(val, 21, 12) AS val 
					FROM (SELECT UPPER(RTRIM(LTRIM(val))) AS val FROM (VALUES (REPLACE(REPLACE(@hex, '{', ''), '}', ''))) x(val) )y )z 
		   WHERE TRY_CONVERT(UNIQUEIDENTIFIER, val) IS NOT NULL
		)
END
GO
-------------------------------------------------------------------------------------------------------
-- SELECT dbo.NormalizeSearch( ' {5bcf4766-dc35-435c-97b1-733fd8675049} ' )
--------------------------------------------------------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'NormalizeSearch' AND xtype = 'FN')
    DROP function dbo.NormalizeSearch
GO

CREATE FUNCTION dbo.NormalizeSearch( @search nvarchar(255) )
RETURNS nvarchar(255)
WITH SCHEMABINDING
AS
BEGIN
    DECLARE @result nvarchar(255)

    set @result = LTRIM(RTRIM(@search))
    set @result  = replace( @result, char(13), ' ')
    set @result  = replace( @result, char(10), ' ')
    set @result  = replace( @result, ',', ' ')
    set @result  = replace( @result, ')', ' ')
    set @result  = replace( @result, '  ', ' ')
	set @result  = replace( @result, '{', '')
	set @result  = replace( @result, '}', '')
	SET @result = LTRIM(RTRIM(@result))

    -- set @search  = SELECT STUFF(@search,PATINDEX('%[A-Z0-9][A-Z0-9].[A-Z0-9][A-Z0-9].[A-Z0-9][A-Z0-9][A-Z0-9] %'COLLATE Cyrillic_General_BIN,@search),10,'');

    IF LEN(@result) = 32 AND ( @result LIKE '%[0-9]%' OR @result LIKE '%[abcdefABCDEF]%' )
    BEGIN
        SET @result = CAST(dbo.fn_CvtHexToGuid(@search) AS char(36))
    END
	IF @result = '.'
		SET @result = NULL
	RETURN NULLIF(@result, '')
END
GO
-------------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'SearchLakeList' AND xtype = 'TF')
    DROP function dbo.SearchLakeList
GO

IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'ProduceSearchVariant' AND xtype = 'TF')
    DROP function dbo.ProduceSearchVariant
GO
IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'GetWaterType' AND xtype = 'FN')
    DROP function dbo.GetWaterType
GO
/*
    SELECT dbo.GetWaterType( 'Lake Huron' ), dbo.GetWaterType( 'Grand River' ), dbo.GetWaterType( 'Biver Creek' ), dbo.GetWaterType( 'Gold Pond' )
*/
CREATE FUNCTION dbo.GetWaterType( @search sysname )
RETURNS INT
WITH SCHEMABINDING
AS
BEGIN
	IF NULLIF(@search, '') IS NULL
		RETURN NULL
	DECLARE @mix   TABLE ( line sysname, ln int IDENTITY(1,1) )

    INSERT INTO @mix (line) select RTRIM(LTRIM([value])) FROM STRING_SPLIT(@search,' ') WHERE NULLIF([value], '') IS NOT NULL

	DECLARE @cnt int = (SELECT MAX(ln) FROM @mix)

    RETURN (SELECT DISTINCT locType FROM @mix m JOIN dbo.water_body w ON m.line = w.en OR m.line = w.fr WHERE ln IN (1, @cnt));
END
GO
-------------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'ProduceWBVariant' AND xtype = 'TF')
    DROP function dbo.ProduceWBVariant
GO
/*
    remove water body from name and produce all name variants
    select * FROM dbo.ProduceWBVariant( 'Naftel''s Creek' )
    select * FROM dbo.ProduceWBVariant( 'st. Peter' )
*/
CREATE FUNCTION dbo.ProduceWBVariant( @search sysname )
RETURNS @comb TABLE ( line sysname NOT NULL, irank int DEFAULT 0, id int not null identity(1,1)) 
WITH SCHEMABINDING
AS
BEGIN
	IF NULLIF(@search, '') IS NULL
		RETURN
	DECLARE @mix   TABLE ( line sysname, ln int IDENTITY(1,1) )

    INSERT INTO @mix (line) select RTRIM(LTRIM([value])) FROM STRING_SPLIT(@search,' ') WHERE NULLIF([value], '') IS NOT NULL

	DECLARE @cnt int = (SELECT MAX(ln) FROM @mix)

	-- find type of water body
	DECLARE @bodytype int = (SELECT DISTINCT locType FROM @mix m JOIN dbo.water_body w ON m.line = w.en OR m.line = w.fr WHERE ln IN (1, @cnt))

	-- delete type of waterbody from name
	DELETE FROM @mix WHERE line IN (SELECT en FROM dbo.water_body UNION SELECT fr FROM dbo.water_body)

	SET @cnt = @cnt - 1

	-- make combinations
    INSERT INTO @comb  SELECT line, @cnt + 1 FROM @mix

	IF @cnt = 2
    BEGIN
		INSERT INTO @comb  SELECT m1.line + ' ' + m2.line as line, 2 FROM @mix m1, @mix m2 WHERE m1.line <> m2.line
    END ELSE
	IF @cnt = 3
    BEGIN
	    INSERT INTO @comb
		    SELECT m1.line + ' ' + m2.line + ' ' + m3.line as line, 2 FROM @mix m1, @mix m2 , @mix m3
			    WHERE m1.line <> m2.line AND m1.line <> m3.line AND m2.line <> m3.line
	    INSERT INTO @comb
		    SELECT m1.line + ' ' + m2.line as line, 3 FROM @mix m1, @mix m2 , @mix m3
			    WHERE m1.line <> m2.line AND m1.line <> m3.line AND m2.line <> m3.line
            UNION 
		    SELECT m2.line + ' ' + m3.line as line, 3 FROM @mix m1, @mix m2 , @mix m3
			    WHERE m1.line <> m2.line AND m1.line <> m3.line AND m2.line <> m3.line
    END ELSE
	IF @cnt = 4
    BEGIN
	    INSERT INTO @comb
		    SELECT m1.line + ' ' + m2.line + ' ' + m3.line + ' ' + m4.line as line, 2 FROM @mix m1, @mix m2 , @mix m3, @mix m4
			    WHERE m1.line <> m2.line AND m1.line <> m3.line AND m1.line <> m4.line AND m2.line <> m3.line AND m2.line <> m4.line AND m3.line <> m4.line
    END
	ELSE 
		INSERT INTO @comb select line, 1 FROM @mix

    -- delete duplicats
    delete x from (  select line, rn=row_number() over (partition by line order by irank)  from @comb) x where rn > 1;

	-- table for expanding
	DECLARE @expander TABLE ( val sysname, en nvarchar(64) )
	INSERT INTO @expander (val, en) VALUES (N'St.', N'Santa');

    -- add variant based on synonims
	WITH cte AS
	(
		SELECT c.line, x.[value], irank FROM @comb c CROSS APPLY (select RTRIM(LTRIM([value])) FROM STRING_SPLIT(c.line,' ') WHERE NULLIF([value], '') IS NOT NULL)x(value)
			WHERE EXISTS ( SELECT en FROM @expander e WHERE x.[value] = e.val UNION SELECT val FROM @expander e WHERE x.[value] = e.en)
	)
 	INSERT INTO @comb	-- insert expanded variants: St. => Santa
		SELECT REPLACE(cte.line, cte.[value], e.en), irank + 1  FROM cte JOIN @expander e ON cte.[value] = e.val
		UNION ALL 
		SELECT REPLACE(cte.line, cte.[value], e.val), irank + 1 FROM cte JOIN @expander e ON cte.[value] = e.en

    -- add variant or/with surrounded apostofs
    INSERT INTO @comb (line, irank)
        SELECT RIGHT(val, LEN(val)-1) AS line, irank FROM ( SELECT LEFT(line, LEN(line)-1) AS val, irank + 1 AS irank FROM @comb 
            WHERE (RIGHT(line, 1) = '"' AND LEFT(line, 1) = '"') OR (RIGHT(line, 1) = '''' AND LEFT(line, 1) = '''') )x

    -- add variant or/with apostof with s
    INSERT INTO @comb (line, irank)
        SELECT REPLACE(line, '''s', 's'), irank + 1  FROM @comb WHERE RIGHT(line, 2) = '''s'
    INSERT INTO @comb (line, irank)
        SELECT REPLACE(line, '''s', ''), irank + 1  FROM @comb WHERE RIGHT(line, 2) = '''s'
    INSERT INTO @comb (line, irank)
        SELECT REPLACE(line, '''s', ''), irank + 1  FROM @comb WHERE RIGHT(line, 2) = 's'

    -- add variant or/with proclamation mark
    INSERT INTO @comb (line, irank)
        SELECT REPLACE(line, '!', ''), irank + 1  FROM @comb WHERE RIGHT(line, 1) = '!'

	-- restore @search without bodytype
	DECLARE @srch sysname = ' ';
	SELECT @srch = @srch + N' ' + line FROM @mix ORDER BY ln ASC

	UPDATE @comb SET irank = 1 WHERE line = LTRIM(@srch)

	RETURN
END
GO
-------------------------------------------------------------------------------------------------------
-- SELECT * FROM dbo.ProduceSearchVariant( ' Lake St. Francis ' )
-- SELECT * FROM dbo.ProduceSearchVariant( ' MOSQUITO CREEK' )
--------------------------------------------------------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'SearchLakeList' AND xtype = 'TF')
    DROP function dbo.SearchLakeList
GO

IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'ProduceSearchVariant' AND xtype = 'TF')
    DROP function dbo.ProduceSearchVariant
GO
/*
	make all possible combinations of names with using english or french names of water body
	SELECT * FROM dbo.ProduceSearchVariant( ' Lake St. Francis ' ) order by irank ASC
    SELECT * FROM dbo.ProduceSearchVariant(  N'North Sigma River' ) order by irank ASC
*/
CREATE FUNCTION dbo.ProduceSearchVariant( @search sysname )
RETURNS @result TABLE ( line sysname NOT NULL, irank int ) 
WITH SCHEMABINDING
AS
BEGIN
	IF NULLIF(@search, '') IS NULL
		RETURN

	-- make combinations
	DECLARE @comb TABLE ( line sysname NOT NULL, irank int DEFAULT 0, id int not null identity(1,1)) 

    INSERT INTO @comb  SELECT line, irank FROM dbo.ProduceWBVariant( @search )

    IF EXISTS (SELECT line FROM @comb WHERE RIGHT(line, 1) = '!')
        INSERT INTO @result SELECT REPLACE(@search, '!', ''), 1

	INSERT INTO @result SELECT @search, 0

	INSERT INTO @comb SELECT s.value + N' ' + line, irank + 1 FROM @comb c, STRING_SPLIT(N'Left,La gauche,Right,Droite,Upper,Lower,North,Nord,South,Sud,West,Ouest,East,est',',') s
        WHERE line NOT LIKE (value + ' %')

    DECLARE @bodytype int = dbo.GetWaterType( @search );

	-- add all combinations of water body
	IF @bodytype IS NOT NULL
	BEGIN
		DECLARE @prepare TABLE ( line sysname NOT NULL, irank int);

        WITH cte (val) AS
        (
            SELECT en FROM dbo.water_body WHERE locType = @bodytype
            UNION
            SELECT fr FROM dbo.water_body WHERE locType = @bodytype
        )
        INSERT INTO @prepare 
            SELECT val  + N' ' + line, irank FROM @comb, cte
            UNION
            SELECT line+ N' ' + val, irank FROM @comb, cte

		INSERT INTO @result SELECT DISTINCT line, irank FROM @prepare c WHERE NOT EXISTS (SELECT line FROM @result r WHERE r.line = c.line)
	END
		ELSE 
			INSERT INTO @result SELECT DISTINCT line, 1 FROM @comb c WHERE NOT EXISTS (SELECT line FROM @result r WHERE r.line = c.line)

    delete x from (  select line, rn=row_number() over (partition by line order by irank)  from @result) x where rn > 1;
	RETURN
END
GO
-------------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'SearchLakeList' AND xtype = 'TF')
    DROP function dbo.SearchLakeList
GO

-- select * from dbo.SearchLakeList( 'Tim Lake' )
-- select * from dbo.SearchLakeList( '0c5210db849c20c357f421ff96a2047b' )
CREATE FUNCTION dbo.SearchLakeList( @search sysname )
  RETURNS @rst TABLE ( num int NOT NULL identity primary key, lake_name nvarchar(64), irank int, alt_name nvarchar(64), lake_id uniqueidentifier, locType int
                     , country char(2), state char(2), county nvarchar(64)
                     , source_name nvarchar(64) , mouth_name nvarchar(64), [description] nvarchar(1024)
                     , source_lat float, source_lon float, source uniqueidentifier, mouth uniqueidentifier
                     , zone int, isWell bit, isFish bit, source_state char(2), mouth_state char(2)
                     , source_country char(2), mouth_country char(2), mouth_lat float, mouth_lon float
                     , source_loc nvarchar(2048), mouth_loc nvarchar(2048), CGNDB varchar(32))
    AS
begin
    set @search = dbo.NormalizeSearch( @search ) -- remove garbige symbols from search string

    declare  @resultid TABLE ( lake_id uniqueidentifier not null, irank int )

	declare @comb TABLE( line sysname, irank int ); 
	INSERT INTO @comb SELECT line, irank FROM dbo.ProduceSearchVariant( @search )

	IF TRY_CONVERT(UNIQUEIDENTIFIER, dbo.fn_CvtHexToGuid( @search )) IS NOT NULL
		SET @search = dbo.fn_CvtHexToGuid( @search )

	IF TRY_CONVERT(UNIQUEIDENTIFIER, @search ) IS NOT NULL
        insert into @resultid (lake_id, irank) SELECT @search, 0

    IF NOT EXISTS (SELECT * FROM @resultid)    
    BEGIN
        insert into @resultid (lake_id, irank)
           select DISTINCT lake_id, 0 from dbo.lake l where @search = CGNDB

        IF NOT EXISTS (SELECT * FROM @resultid)    
        BEGIN
            insert into @resultid (lake_id, irank)
               select lake_id, irank from dbo.lake l WITH (INDEX (idx_Lake_alt_name)) JOIN @comb c ON c.line = alt_name

            insert into @resultid (lake_id, irank)
               select lake_id, irank from dbo.lake l WITH (INDEX (idx_Lake_name)) JOIN @comb c ON c.line = lake_name  

            insert into @resultid (lake_id, irank)
               select lake_id, irank from dbo.lake l WITH (INDEX (idx_Lake_french_name)) JOIN @comb c ON c.line = french_name

            insert into @resultid (lake_id, irank)
               select lake_id, irank from dbo.lake l WITH (INDEX (idx_Lake_native)) JOIN @comb c ON c.line = [native] 

            IF NOT EXISTS (SELECT * FROM @resultid)    
            BEGIN
                insert into @resultid (lake_id, irank)
                   select DISTINCT lake_id, 3 from dbo.lake l where lake_name like N'%' + @search + N'%'

                insert into @resultid (lake_id, irank)
                   select DISTINCT lake_id, 3 from dbo.lake l where alt_name like N'%' + @search + N'%' AND alt_name IS NOT NULL
            END
        END
    END
    delete x from (  select lake_id, rn=row_number() over (partition by lake_id order by irank)  from @resultid) x where rn > 1;

    INSERT INTO @rst SELECT lake_name, irank, alt_name, l.lake_id, locType
        , country, state, county, source_name, mouth_name
        , CASE WHEN county IS NULL THEN state ELSE county END AS [description]
        , lat, lon, null, null, zone, isWell, isFish
        , source_state, mouth_state, source_country, mouth_country
        , mouth_lat, mouth_lon, source_loc, mouth_loc, CGNDB
        FROM vw_lake l JOIN @resultid r ON  r.lake_id = l.lake_id
   RETURN
end
GO
--------------------------------------------------------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'SearchFishList' AND xtype = 'TF')
    DROP function dbo.SearchFishList
GO

IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'FishSearchVariant' AND xtype = 'TF')
    DROP function dbo.FishSearchVariant
GO
/*
	make all possible combinations of names
	SELECT * FROM dbo.FishSearchVariant( 'Sucker, Longnose' ) order by irank ASC
	SELECT * FROM dbo.FishSearchVariant( 'Salmon' ) order by irank ASC
    SELECT * FROM dbo.FishSearchVariant( 'Northern Pike' ) order by irank ASC
*/
CREATE FUNCTION dbo.FishSearchVariant( @search nvarchar(255) )
RETURNS @result TABLE ( line sysname NOT NULL PRIMARY KEY, irank int ) 
WITH SCHEMABINDING
AS
BEGIN
	IF NULLIF(@search, '') IS NULL
		RETURN

    SET @search = REPLACE( @search, N',', N' ');
    SET @search = REPLACE( @search, N'  ', N' ');

    IF EXISTS (SELECT 1 FROM dbo.fish WHERE fish_name = @search)
    BEGIN
    	INSERT INTO @result SELECT fish_name, 0 FROM dbo.fish WHERE fish_name = @search
        RETURN
    END	
    IF EXISTS (SELECT 1 FROM dbo.fish WHERE fish_latin = @search)
    BEGIN
    	INSERT INTO @result SELECT fish_name, 0 FROM dbo.fish WHERE fish_name = @search
        RETURN
    END	

    DECLARE @mix   TABLE ( line sysname, ln int IDENTITY(1,1) )

    INSERT INTO @mix (line) 
        SELECT RTRIM(LTRIM([value])) AS name FROM STRING_SPLIT(@search,' ') WHERE NULLIF([value], '') IS NOT NULL

    UPDATE @mix SET line = LEFT(line, LEN(line)-1) WHERE RIGHT(line, 1) = ','  -- remove comma symbol
    
	DECLARE @cnt int = (SELECT MAX(ln) FROM @mix)

	-- make combinations
	DECLARE @comb TABLE ( line sysname NOT NULL, irank int DEFAULT 0, id int not null identity(1,1)) 

    INSERT INTO @comb  SELECT line, @cnt + 1 FROM @mix

	IF @cnt = 2
    BEGIN
		INSERT INTO @comb  SELECT m1.line + ' ' + m2.line as line, 2 FROM @mix m1, @mix m2 WHERE m1.line <> m2.line
        -- set comma after first word
		INSERT INTO @comb  SELECT m1.line + ', ' + m2.line as line, 2 FROM @mix m1, @mix m2 WHERE m1.line <> m2.line
    END ELSE
	IF @cnt > 2
    BEGIN
	    INSERT INTO @comb
		    SELECT m1.line + ' ' + m2.line + ' ' + m3.line as line, 2 FROM @mix m1, @mix m2 , @mix m3
			    WHERE m1.line <> m2.line AND m1.line <> m3.line AND m2.line <> m3.line

	    INSERT INTO @comb
		    SELECT m1.line + ', ' + m2.line + ' ' + m3.line as line, 2 FROM @mix m1, @mix m2 , @mix m3
			    WHERE m1.line <> m2.line AND m1.line <> m3.line AND m2.line <> m3.line
	    INSERT INTO @comb
		    SELECT m1.line + ' ' + m2.line as line, 3 FROM @mix m1, @mix m2 , @mix m3
			    WHERE m1.line <> m2.line AND m1.line <> m3.line AND m2.line <> m3.line
            UNION 
		    SELECT m2.line + ' ' + m3.line as line, 3 FROM @mix m1, @mix m2 , @mix m3
			    WHERE m1.line <> m2.line AND m1.line <> m3.line AND m2.line <> m3.line
            UNION 
		    SELECT m1.line + ', ' + m2.line as line, 3 FROM @mix m1, @mix m2 , @mix m3
			    WHERE m1.line <> m2.line AND m1.line <> m3.line AND m2.line <> m3.line
            UNION 
		    SELECT m2.line + ', ' + m3.line as line, 3 FROM @mix m1, @mix m2 , @mix m3
			    WHERE m1.line <> m2.line AND m1.line <> m3.line AND m2.line <> m3.line
    END
	ELSE 
		INSERT INTO @comb select line, 1 FROM @mix

    -- delete duplicats
    delete x from (  select line, rn=row_number() over (partition by line order by irank ASC)  from @comb) x where rn > 1;

	INSERT INTO @result SELECT @search, 0 WHERE NOT EXISTS (SELECT line FROM @result r WHERE r.line = @search)

    INSERT INTO @result SELECT DISTINCT line, irank FROM @comb c WHERE NOT EXISTS (SELECT line FROM @result r WHERE r.line = c.line)

	RETURN
END
GO
--------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'SearchFishList' AND xtype = 'TF')
    DROP function dbo.SearchFishList
GO

-- search fish by any alternative name
-- select * from dbo.SearchFishList('rosefish ')    -- Bluegill
-- select * from dbo.SearchFishList('Northern Pike ')    -- Bluegill
CREATE FUNCTION dbo.SearchFishList( @search varchar(64) )
  RETURNS @rst TABLE ( num int identity, fish_name nvarchar(64), name nvarchar(64), fish_latin varchar(64), fish_id uniqueidentifier, irank int )
    AS
begin
    declare @origin varchar(64) = @search
    set @search = dbo.NormalizeSearch( @search ) -- remove garbige symbols from search string

    -- single result then return it
    if( 1 = (select count(*) from fish where fish_name LIKE @search OR fish_latin LIKE @search ) )
    begin
      insert into @rst select fish_name, fish_name, fish_latin, fish_id, 0 from fish  
        where @search = fish_name or @search = fish_latin OR @origin = fish_name or @origin = fish_latin
      update f set f.name = o.name from @rst f join vFishOK o on (f.fish_id=o.fish_id)
      RETURN
    end

    declare  @resultid TABLE ( fish_id uniqueidentifier not null primary key, irank int not null )
	declare @comb TABLE( line sysname, irank int not null); 
	INSERT INTO @comb SELECT DISTINCT line, 1 FROM dbo.FishSearchVariant( @search )

    delete x from (  select line, rn=row_number() over (partition by line order by irank)  from @comb) x where rn > 1;

    MERGE INTO @comb AS t
        USING (select @origin, 0) AS s(line, irank)  ON t.line = s.line
    WHEN MATCHED THEN 
        UPDATE SET irank = 0
    WHEN NOT MATCHED BY TARGET THEN  
        INSERT (line, irank) VALUES ( @origin, 0);

    insert into @resultid (fish_id, irank)
        select DISTINCT fish_id, c.irank from dbo.fish JOIN @comb c ON line like fish_name
            AND NOT EXISTS (SELECT * FROm @resultid t WHERE t.fish_id = fish_id)

    insert into @resultid (fish_id, irank)
        select DISTINCT fish_id, c.irank + 1 from dbo.fish CROSS APPLY STRING_SPLIT(alt_name ,';') x
            JOIN @comb c ON line like x.value
            AND NOT EXISTS (SELECT * FROm @resultid t WHERE t.fish_id = fish_id)

    insert into @resultid (fish_id, irank)
        SELECT fish_id, irank FROM
        (
            SELECT fish_id, MIN(irank) AS irank FROM
            (
                SELECT DISTINCT fish_id, c.irank + 2 AS irank from dbo.fish JOIN @comb c ON fish_name like ('%' + line + '%')
            )x  GROUP BY fish_id
        )z WHERE NOT EXISTS (SELECT * FROM @resultid t WHERE t.fish_id = z.fish_id)

    insert into @rst select fish_name, fish_name, fish_latin, f.fish_id , irank
        from fish f JOIN @resultid r ON r.fish_id = f.fish_id
   RETURN
end
GO
--------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'fn_only_river_list' AND xtype = 'IF')
    DROP function dbo.fn_only_river_list
GO

--------------------------------------------------------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'fn_first_item' AND xtype = 'FN')
    DROP function dbo.fn_first_item
GO

-- return first item from list if it's a list or value as is
create FUNCTION dbo.fn_first_item( @list NVARCHAR(max))
RETURNS nvarchar(128)
--WITH SCHEMABINDING
AS
BEGIN
  DECLARE @result nvarchar(128) = ( SELECT TOP 1 item FROM dbo.fn_Parser(@list) );
  RETURN @result
END
GO
--------------------------------------------------------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'fn_river_list')
    DROP function dbo.fn_river_list
GO
/*
    Display list of rivers
    Used in FishTracker.Resources.Water.LoadRiver
-- DROP  FUNCTION dbo.fn_river_list
-- used in RiverList
-- SELECT * FROM dbo.fn_river_list( 'ON', 'CA', 1, N'S', 0, 1, 0) where reviewed = 1  ORDER BY lake_name ASC
-- SELECT * FROM dbo.fn_river_list( 'ON', 'CA', 2, N'$', 0, 0, 0) ORDER BY num ASC
-- SELECT * FROM dbo.fn_river_list( 'ON', 'CA', '2', N'E', 0, 0 ) ORDER BY lake_name ASC
     SELECT DISTINCT LEFT(lake_name, 1) FROM dbo.fn_river_list( 'ON', 'CA', 2, '$', 1, 0, 0) ORDER BY 1 ASC
     SELECT DISTINCT symbol FROM dbo.fn_river_list('ON', 'CA', 1, '$', 0, 0, 1)
-- SELECT * FROM lake where lake_name = 'Grand River'
-- SELECT * FROM lake where lake_name = 'Seguin River'
*/
CREATE FUNCTION dbo.fn_river_list( @state char(2), @country char(2), @river int, @section nchar, @monitor bit, @fish bit, @page int = 0 )
RETURNS TABLE
WITH SCHEMABINDING 
RETURN 
    WITH cte
    AS
    (
        SELECT l.lat, l.lon, l.lake_name, l.alt_Name, l.county, l.lake_id, l.state, l.country
                , left(COALESCE(source_loc, mouth_loc), 32) AS [description] 
                , l.zone, l.IsFish, l.isWell, l.source_name, l.mouth_name, source_lat, source_lon, mouth_lat, mouth_lon, source_loc, mouth_loc, CGNDB
                , COALESCE(source_loc, mouth_loc, CGNDB) AS guidloc, symbol, reviewed
            FROM dbo.vw_lake l
            WHERE @state IN (source_state, mouth_state) AND @river = l.locType
            AND ISNULL(isFish,0)  = (CASE WHEN @fish    = 1 THEN 1 ELSE 0 END)
            AND ISNULL(isWell,0)  = (CASE WHEN @monitor = 1 THEN 1 ELSE 0 END)
            AND l.lake_id IN (SELECT lake_id FROm dbo.lake WHERE symbol in ('0','1','2','3','4','5','6','7','8','9')
                        UNION SELECT lake_id FROm dbo.lake WHERE symbol=UPPER(@section)
                        UNION SELECT lake_id FROm dbo.lake WHERE @section='$'  )
    )SELECT num, lat, lon, lake_name, alt_Name, county, lake_id, state, country, [description], zone
        , IsFish, isWell, source_name, mouth_name, source_lat, source_lon, mouth_lat, mouth_lon, source_loc, mouth_loc, CGNDB, guidloc 
		, x.cnt  AS itg, sym, reviewed
        FROM
        (
            SELECT ROW_NUMBER() Over(Order by (Select 1)) AS num, lat, lon, lake_name, alt_Name, county, lake_id, state
                 , country, [description], zone, IsFish, isWell, source_name, mouth_name, source_lat, source_lon
                 , mouth_lat, mouth_lon, source_loc, mouth_loc, CGNDB, guidloc, symbol AS sym, reviewed FROM cte
        )z, (SELECT COUNT(*) AS cnt FROM cte)x
        ORDER BY num ASC OFFSET @page * 25 ROWS FETCH NEXT 25 ROWS ONLY
GO
--------------------------------------------------------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'fn_river_sym')
    DROP function dbo.fn_river_sym
GO
/*
    Display list of rivers
    Used in FishTracker.Resources.Water.LoadRiver
-- DROP  FUNCTION dbo.fn_river_list
-- used in RiverList
-- SELECT * FROM dbo.fn_river_list( 'ON', 'CA', 1, N'A', 0, 0, 2) ORDER BY lake_name ASC
-- SELECT * FROM dbo.fn_river_list( 'ON', 'CA', 2, N'$', 0, 0, 0) ORDER BY num ASC
-- SELECT * FROM dbo.fn_river_list( 'ON', 'CA', '2', N'E', 0, 0 ) ORDER BY lake_name ASC
   SELECT DISTINCT symbol FROM dbo.fn_river_sym('ON', 'CA', 1, '$', 0, 0)
-- SELECT * FROM lake where lake_name = 'Grand River'
*/
CREATE FUNCTION dbo.fn_river_sym( @state char(2), @country char(2), @river int, @section nchar, @monitor bit, @fish bit )
RETURNS TABLE
WITH SCHEMABINDING 
RETURN 
    SELECT symbol FROM dbo.vw_lake
        WHERE @state IN (source_state, mouth_state) AND @river = locType
        AND ISNULL(isFish,0)  = (CASE WHEN @fish    = 1 THEN 1 ELSE 0 END)
        AND ISNULL(isWell,0)  = (CASE WHEN @monitor = 1 THEN 1 ELSE 0 END)
        AND lake_id IN (SELECT lake_id FROm dbo.lake WHERE symbol in ('0','1','2','3','4','5','6','7','8','9')
                    UNION SELECT lake_id FROm dbo.lake WHERE symbol=UPPER(@section)
                    UNION SELECT lake_id FROm dbo.lake WHERE @section='$'  )

GO
--------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'fn_river_viewer_otherfish' AND xtype = 'FN')    DROP function dbo.fn_river_viewer_otherfish
GO 
IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'fn_river_viewer_fish' AND xtype = 'IF')    DROP function dbo.fn_river_viewer_fish
GO 
IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'fn_river_fish' AND xtype = 'IF') DROP function dbo.fn_river_fish
GO
/*
IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'fn_river_viewer_fish' AND xtype = 'IF')    DROP function dbo.fn_river_viewer_fish
GO 
*/
GO
/******
 * on page wfRiverViewer display list of fishes
 * depend on fn_river_viewer_otherfish
 *
 * INPUT PARAMETERS:
 *
 *    @@lake_id   uniqueidentifier  - a lake guid
 *    @length     INT               - minimal length of fish used for report
 *    @typeangler int               - type of angler. not used yet (reserved)
 *
 *  Usage: 
               SELECT * FROM dbo.fn_river_viewer_fish('AB45F146-1273-44D5-802F-D913EE0BB66F', 20, 0) ORDER BY today, fish_name DESC
 */
CREATE FUNCTION dbo.fn_river_viewer_fish( @guid varchar(64), @fish_max_length int = 20, @typeangler int = 0 )
RETURNS TABLE
WITH SCHEMABINDING
RETURN
  WITH cte AS
  (
    SELECT fish_name, today
         , fish_id
         , ROW_NUMBER() OVER (ORDER BY x.fish_id) AS id
         , x.lake_id
      FROM
   (
        SELECT DISTINCT f.fish_name, f.fish_id, l.lake_id
        , CASE WHEN loc.today < 30 THEN 'Low' WHEN loc.today > 75  THEN 'High' ELSE 'Normal' END AS today  
            FROM dbo.fish_location loc 
            JOIN dbo.WaterStation ws ON loc.station_Id = ws.id
            JOIN dbo.fish f          ON f.fish_id  = loc.fish_id
            JOIN dbo.fish_zoo z          ON f.fish_id  = z.fish_id
            JOIN dbo.lake l          ON l.lake_id  = ws.lakeid 
            WHERE l.lake_id = CAST(@guid AS uniqueidentifier) AND  z.fish_max_length > 20 
    )x
  ) SELECT id, fish_name, today, link, CASE WHEN link Is NULL THEN 'empty.gif' ELSE 'link.png' END pic
          , cte.lake_id, cte.fish_id
      FROM cte 
      CROSS APPLY (SELECT TOP 1 fish_id, link FROM dbo.lake_fish lf WHERE cte.fish_id = lake_id AND @guid= fish_id ORDER BY link)lf
      WHERE cte.fish_id = lf.fish_id
GO
--------------------------------------------------------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'fn_river_viewer_fish' AND xtype = 'FN')    DROP function dbo.fn_river_viewer_fish
GO 
IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'fn_river_viewer_otherfish' AND xtype = 'FN')    DROP function dbo.fn_river_viewer_otherfish
GO 
/******
 * on page wfRiverViewer display list of other fishes not included to fn_river_viewer_fish
 * depend on fn_river_view
 *
 * INPUT PARAMETERS:
 *
 *    @@lake_id   uniqueidentifier  - a lake guid
 *    @typeangler int               - type of angler. not used yet (reserved)
 *
 *  Usage: 
               SELECT dbo.fn_river_viewer_otherfish('AB45F146-1273-44D5-802F-D913EE0BB66F', 0)
 */
CREATE FUNCTION dbo.fn_river_viewer_otherfish( @lake_id varchar(64), @typeangler int = 0 )
RETURNS nvarchar(2048)
WITH SCHEMABINDING
BEGIN
  DECLARE @result nvarchar(2048) = '';
  SELECT  @result = @result + '; ' + f.fish_name  FROM dbo.lake_fish l JOIN dbo.fish f ON l.fish_id = f.fish_id
    WHERE l.lake_id = @lake_id AND NOT EXISTS (SELECT fish_id FROM dbo.fn_river_viewer_fish( @lake_id, DEFAULT, @typeangler )x WHERE x.fish_id = l.fish_id)
    RETURN CASE WHEN NULLIF(@result, '') IS NULL THEN NULL ELSE  RIGHT(@result, LEN(@result)-1 ) END;
END
GO
--------------------------------------------------------------------------------------------------------------------------------------------------
/*
IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'fn_river_viewer_otherfish' AND xtype = 'FN') DROP function dbo.fn_river_viewer_otherfish
GO 
IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'fn_river_viewer_fish' AND xtype = 'IF') DROP function dbo.fn_river_viewer_fish
GO 
IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'fn_river_fish' AND xtype = 'IF') DROP function dbo.fn_river_fish
GO
*/
--- returns firt fish from river having link
--    SELECT * FROM dbo.fn_river_fish('D07EFE63-BAF4-4DD1-9B1C-FE94C5860185', '1D55814F-8047-48A8-8915-F8823A2D20B6')
CREATE FUNCTION dbo.fn_river_fish( @fish_id uniqueidentifier, @lake_id uniqueidentifier )
RETURNS TABLE
WITH SCHEMABINDING
RETURN
   SELECT TOP 1 fish_id, link FROM dbo.lake_fish lf WHERE @lake_id = lake_id AND @fish_id  = fish_id ORDER BY link;
GO
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'fn_resource_state' AND xtype = 'IF')
    DROP function dbo.fn_resource_state
GO 

-- used in RiverList in combobox
-- SELECT * FROM dbo.fn_resource_state( 'CA' )
create FUNCTION dbo.fn_resource_state( @country char(2) )
RETURNS TABLE WITH SCHEMABINDING
AS RETURN
   SELECT DISTINCT s.state AS Value FROM dbo.lake l 
        JOIN dbo.Tributaries m ON l.lake_id=m.lake_id AND l.lake_id=m.Main_Lake_id AND m.side IN (16,32)
        JOIN dbo.states s ON m.state = s.state
      WHERE m.country IS NOT NULL AND DATALENGTH(m.country) = 2 
        AND m.state IS NOT NULL AND DATALENGTH(m.country) = 2 AND @country = m.country
GO
--------------------------------------------------------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'fn_river_view_fishing' AND xtype = 'IF')
    DROP function dbo.fn_river_view_fishing
GO

--   required for wfRiverRegulations to dispay river/lake
--    select * from dbo.fn_river_view_fishing('a6c730df-2892-e811-9104-00155d007b12')
create FUNCTION dbo.fn_river_view_fishing( @lake_id uniqueidentifier )
RETURNS  TABLE
  WITH SCHEMABINDING
AS
  RETURN
    SELECT stateCountry, z.lake_id
         , CASE WHEN z.City IS NOT NULL AND DATALENGTH(z.City) > 0 THEN z.City + '&nbsp;twp.' ELSE '' END 
         + CASE WHEN z.County IS NOT NULL AND DATALENGTH(z.County) > 0 THEN ',&nbsp;' + ISNULL(z.County, '') ELSE '' END 
         + CASE WHEN z.Region IS NOT NULL AND DATALENGTH(z.Region) > 0 THEN ',&nbsp;' + ISNULL(z.Region, '') ELSE '' END 
         + CASE WHEN z.municipality IS NOT NULL AND DATALENGTH(z.municipality) > 0 THEN ',&nbsp;' + ISNULL(z.municipality, '') ELSE '' END 
         + CASE WHEN z.district IS NOT NULL AND DATALENGTH(z.district) > 0 THEN ', &nbsp;' + ISNULL(z.district, '') ELSE '' END 
         AS [description]
         , CASE WHEN z.link IS NULL THEN z.lake_name ELSE '<a href="' + z.link + '">' + z.lake_name + '</a>' END AS lake_name
         , z.alt_Name,  z.county,  z.state, z.country
         , CASE WHEN z.location IS NOT NULL THEN '<hr><table><tr><td>' + z.location + '</td></tr></table>' ELSE NULL END AS location
         , stateRules, stateName, stateParkRules, stateResidentFee, stateNonResidentFee

         , CASE WHEN z.regulations IS NOT NULL THEN '<tr><td><b>Exceptions to Regulations:</b></td><td><font color="red">' + z.regulations END + '</font>'
           + CASE WHEN z.link_reg IS NOT NULL THEN '&nbsp<a href="' + z.link_reg + '"><img src="/Images/link.png" /></a>' ELSE '' END
           + '</td></tr>' AS regulations
         , CASE WHEN z.zone IS NOT NULL THEN '<tr><td><b>Zone:</b></td><td>' + CAST(z.zone AS varchar(24)) + '</td></tr>' END AS zone 
      FROM
      (
        SELECT ('[' + t.state + '] ' + t.country) AS stateCountry
            ,  x.lake_id, lake_name,  alt_Name,  ISNULL(t.city, '') AS city
            , ISNULL(t.county, '') AS county
            , ISNULL(t.region, '') AS region
            , ISNULL(t.district, '') AS district, ISNULL(t.municipality, '') AS municipality
            , t.state, t.country
            , s.rules as stateRules, s.name as stateName
            , resident_fee as stateResidentFee, non_resident_fee as stateNonResidentFee, park_rules as stateParkRules
            , locType, t.[location]
            , link, watershield, t.zone, regulations, link_reg
            FROM dbo.lake x 
            JOIN dbo.Tributaries t ON x.lake_id=t.lake_id AND t.Main_Lake_id=x.lake_id
            JOIN dbo.states s ON t.state = s.state
            WHERE x.lake_id = @lake_id AND t.side=16
      )z 
GO
--------------------------------------------------------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'fn_river_view_regulations' AND xtype = 'IF')
    DROP function dbo.fn_river_view_regulations
GO
--   required for wfRiverRegulations to dispay river/lake
--    select * from dbo.fn_river_view_regulations('B74DCDFC-CC78-4464-BFB0-C64542A7DFF4')
create FUNCTION dbo.fn_river_view_regulations( @lake_id uniqueidentifier )
RETURNS  TABLE
  WITH SCHEMABINDING
AS
  RETURN
    SELECT stateCountry, z.lake_id
         , CASE WHEN z.City IS NOT NULL AND DATALENGTH(z.City) > 0 THEN z.City + '&nbsp;twp.' ELSE '' END 
         + CASE WHEN z.County IS NOT NULL AND DATALENGTH(z.County) > 0 THEN ',&nbsp;' + ISNULL(z.County, '') ELSE '' END 
          + CASE WHEN z.municipality IS NOT NULL AND DATALENGTH(z.municipality) > 0 THEN ',&nbsp;' + ISNULL(z.municipality, '') ELSE '' END 
         + CASE WHEN z.district IS NOT NULL AND DATALENGTH(z.district) > 0 THEN ', &nbsp;' + ISNULL(z.district, '') ELSE '' END 
         AS [description]
         , CASE WHEN z.link IS NULL THEN z.lake_name ELSE '<a href="' + z.link + '">' + z.lake_name + '</a>' END AS lake_name
         , z.alt_Name,  z.county,  z.state, z.country
         , CASE WHEN z.location IS NOT NULL THEN '<hr><table><tr><td>' + z.location + '</td></tr></table>' ELSE NULL END AS location
         , stateRules, stateName, stateParkRules, stateResidentFee, stateNonResidentFee

         , CASE WHEN z.regulations IS NOT NULL THEN '<tr><td><b>Exceptions to Regulations:</b></td><td><font color="red">' + z.regulations END + '</font>'
           + CASE WHEN z.link_reg IS NOT NULL THEN '&nbsp<a href="' + z.link_reg + '"><img src="/Images/link.png" /></a>' ELSE '' END
           + '</td></tr>' AS regulations
         , CASE WHEN z.zone IS NOT NULL THEN '<tr><td><b>Zone:</b></td><td>' + CAST(z.zone AS varchar(24)) + '</td></tr>' END AS zone 
         , CASE WHEN r.lake_id IS NOT NULL THEN 1 ELSE 0 END AS IsException
      FROM
      (
        SELECT ('[' + t.state + '] ' + t.country) AS stateCountry
            ,  x.lake_id, lake_name,  alt_Name,  ISNULL(t.city, '') AS city
            , ISNULL(t.county, '') AS county
            , ISNULL(t.region, '') AS region
            , ISNULL(t.district, '') AS district, ISNULL(t.municipality, '') AS municipality
            , t.state, t.country
            , s.rules as stateRules, s.name as stateName
            , resident_fee as stateResidentFee, non_resident_fee as stateNonResidentFee, park_rules as stateParkRules
            , x.locType, t.[location]
            , x.link, x.watershield, t.zone, regulations, link_reg
            FROM dbo.lake x 
                JOIN dbo.Tributaries t ON x.lake_id=t.lake_id AND x.lake_id=t.Main_Lake_id
                JOIN dbo.states s ON t.state = s.state
            WHERE x.lake_id = @lake_id AND t.side=16
      )z LEFT JOIN dbo.regulations r ON r.lake_id = z.lake_id
         LEFT JOIN dbo.fish f ON r.fish_id = f.fish_id
GO
--------------------------------------------------------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'fn_map_location_trial' AND xtype = 'IF')
    DROP function dbo.fn_map_location_trial
GO
/****** Called from FishTracker.Forecast.MapFrame.LoadMapLocation
-- SELECT * FROM [dbo].[fn_get_trial_location]( 'burbot', 43, -80 )
-- SELECT * FROM [dbo].[fn_map_location_trial]( 'Bass, Rock', 43, -80 )
**/
CREATE function dbo.fn_map_location_trial( @fishName  varchar(64), @lat float, @lon float )
  RETURNS  TABLE
  WITH SCHEMABINDING
AS
RETURN   --lat, lon, today, location, sid, country, state, county
    SELECT w.lat,  w.lon,  f.today, w.LocName as location, w.sid, w.country, w.state, w.county
      FROM dbo.vWaterStation w JOIN dbo.fish_location f ON (f.station_Id = w.id  )
      WHERE ( w.lat between (@lat-3.0) AND (@lat+3.0) ) AND (w.lon between (@lon-3.0) AND (@lon+3.0) ) 
        AND EXISTS( SELECT TOP 1 1 FROM dbo.fish s WHERE fish_name = @fishName and f.fish_id = s.fish_id )
		AND EXISTS( SELECT TOP 1 1 FROM dbo.WaterData d WHERE d.mli = w.mli )
		/*
     UNION ALL
    select  spot_lat, spot_lon, 0, '', b.spot_sid, 'CA', 'ON', ''        -- also display fish spots
      FROM dbo.Spot a 
         LEFT JOIN dbo.fish_spot b ON a.spot_id = b.spot_id
      WHERE ( spot_lat between (@lat-3.0) AND (@lat+3.0) ) AND (spot_lon between (@lon-3.0) AND (@lon+3.0) )
        AND EXISTS( SELECT TOP 1 1 FROM dbo.fish s WHERE fish_name = @fishName and b.fish_id = s.fish_id ) */
GO
------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'fn_map_location' AND xtype = 'IF')
    DROP function dbo.fn_map_location
GO

/****** Called from FishTracker.Forecast.MapFrame.LoadMapLocation
-- SELECT * FROM [dbo].[fn_get_trial_location]( 'Bass, rock', 43, -80 )
**/
CREATE function dbo.fn_map_location( @fishName  varchar(64), @lat float, @lon float, @dist float )
  RETURNS  TABLE
  WITH SCHEMABINDING
AS
RETURN   --lat, lon, today, location, sid, country, state, county
    SELECT  w.lat, w.lon, f.today, w.LocName AS location, w.sid, w.country, w.state, w.county 
        FROM dbo.vWaterStation w 
        JOIN dbo.fish_location f ON ( f.station_Id = w.id )
        JOIN dbo.fish          s ON ( f.fish_Id    = s.fish_Id )
        WHERE s.fish_name = @fishName
		AND EXISTS( SELECT TOP 1 1 FROM dbo.WaterData d WHERE d.mli = w.mli )
		/*
     UNION ALL
    select  spot_lat, spot_lon, 0, '', a.spot_sid, 'CA', 'ON', ''                -- also display fish spots
        FROM dbo.Spot a 
            LEFT JOIN dbo.fish_spot b ON a.spot_id = b.spot_id
        WHERE  EXISTS( SELECT TOP 1 1 FROM dbo.fish s WHERE fish_name = @fishName and b.fish_id = s.fish_id ) 
           OR  EXISTS( SELECT TOP 1 1 FROM dbo.fish f 
                         JOIN [dbo].lake_fish fl ON ( fl.fish_Id = f.fish_Id )
                         JOIN [dbo].lake l       ON ( fl.fish_Id = f.fish_Id )
                         JOIN [dbo].spot s       ON (  l.lake_Id = s.lake_Id AND s.spot_id = b.spot_id )
                         WHERE fish_name = @fishName and b.fish_id = f.fish_id ) 
						 */
GO
------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'fn_fish_image_handler' AND xtype = 'FN')
    DROP function dbo.fn_fish_image_handler
GO

-- used in ~/Editor/HandlerImage.ashx
-- SELECT dbo.fn_fish_image_handler( '7a7fa636-9957-4287-9892-e2d003a006c3', 7 )
CREATE FUNCTION dbo.fn_fish_image_handler( @fish_id uniqueidentifier, @image_id int )
RETURNS varbinary(max) WITH SCHEMABINDING
BEGIN
    RETURN
        (SELECT TOP 1 fish_image_pic FROM 
            (
                SELECT fish_image_pic FROM dbo.fish_image WHERE fish_image_id = @image_id AND fish_id = @fish_id
                UNION ALL
                SELECT TOP 1 fish_image_pic FROM dbo.fish_image f WHERE EXISTS 
                ( SELECT fish_image_id FROM  (SELECT MAX(fish_image_id) AS fish_image_id FROM dbo.fish_image WHERE fish_id = @fish_id)x WHERE x.fish_image_id = f.fish_image_id)
            )y
        );
END
GO
------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'fn_fish_image_info' AND xtype = 'IF')
    DROP function dbo.fn_fish_image_info
GO
-- used to display info about image
-- SELECT * from dbo.fn_fish_image_info( 'C2E8C307-F470-458B-8CEE-000999277126', 7 )
CREATE FUNCTION dbo.fn_fish_image_info( @fish_id uniqueidentifier, @image_id int )
RETURNS  TABLE
  WITH SCHEMABINDING
AS
  RETURN
        (SELECT TOP 1 fish_image_gender, fish_image_source, fish_image_author, fish_image_link, fish_image_label, fish_image_location
                    , fish_image_lat, fish_image_lon, fish_image_tag, fish_image_stamp FROM 
            (
                SELECT fish_image_gender, fish_image_source, fish_image_author, fish_image_link, fish_image_label, fish_image_location
                     , fish_image_lat, fish_image_lon, fish_image_tag, fish_image_stamp FROM dbo.fish_image WHERE fish_image_id = @image_id AND fish_id = @fish_id
                UNION ALL
                SELECT fish_image_gender, fish_image_source, fish_image_author, fish_image_link, fish_image_label, fish_image_location
                     , fish_image_lat, fish_image_lon, fish_image_tag, fish_image_stamp FROM dbo.fish_image f WHERE EXISTS 
                ( SELECT fish_image_id FROM  (SELECT MAX(fish_image_id) AS fish_image_id FROM dbo.fish_image WHERE fish_id = @fish_id)x WHERE x.fish_image_id = f.fish_image_id)
            )y
        );
GO
------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'fn_fish_spawn' AND xtype = 'IF')
    DROP function dbo.fn_fish_spawn
GO
-- used to display info about image
-- SELECT * FROM dbo.fn_fish_spawn( '58FC0EFC-3728-4A7E-9622-43C9747078E8' )
CREATE FUNCTION dbo.fn_fish_spawn( @fish_id uniqueidentifier  )
RETURNS  TABLE
  WITH SCHEMABINDING
AS
  RETURN
    SELECT fish_spawn_stamp, fish_spawn_age_female, fish_spawn_age_male, fish_spawn_eggs_min, fish_spawn_eggs_max
         , fish_spawn_description, fish_spawn_location, reproductive_strategy FROM dbo.fish_spawn WHERE fish_Id = @fish_id
GO
------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'fn_map_fish_list_bylatlon' AND xtype = 'IF')
    DROP function dbo.fn_map_fish_list_bylatlon
GO
-- Called from  FishTracker.Forecast.MapFrame.LoadInitialFishes
-- SELECT * FROM dbo.fn_map_fish_list_bylatlon( 40, -81, 3  )
CREATE FUNCTION dbo.fn_map_fish_list_bylatlon( @lat real, @lon real, @dist real  )
  RETURNS TABLE 
WITH SCHEMABINDING
AS
RETURN
SELECT fish_id, fish_name FROM dbo.fish v
    WHERE ( v.fish_Type & 1 ) = 1 AND EXISTS         -- 1 - sport fish
    ( 
		SELECT TOP 1 1 FROM dbo.fish_location f 
			JOIN dbo.WaterStation w ON (f.station_Id = w.id)
			WHERE f.fish_id = v.fish_id 
			AND ( w.lat between (@lat-@dist) AND (@lat+@dist) )
			AND ( w.lon between (@lon-@dist) AND (@lon+@dist) )
    )      
GO
---------------------------------------------------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'fn_map_fish_list_bylatlon_trial' AND xtype = 'IF')
    DROP function dbo.fn_map_fish_list_bylatlon_trial
GO
-- Called from  FishTracker.Forecast.MapFrame.LoadInitialFishes
-- SELECT * FROM dbo.fn_map_fish_list_bylatlon_trial( 40, -81   )
CREATE FUNCTION dbo.fn_map_fish_list_bylatlon_trial( @lat real, @lon real  )
  RETURNS TABLE 
WITH SCHEMABINDING
AS
RETURN
SELECT v.fish_id, fish_name FROM dbo.fish v
    LEFT JOIN dbo.fish_zoo z ON z.fish_id = v.fish_id
    WHERE ( v.fish_Type & 1 ) = 1 AND EXISTS         -- 1 - sport fish
    ( 
		SELECT TOP 1 1 FROM dbo.fish_location f 
			JOIN dbo.WaterStation w ON (f.station_Id = w.id)
			WHERE f.fish_id = v.fish_id 
			AND ( w.lat between (@lat-0.5) AND (@lat+0.5) )
			AND ( w.lon between (@lon-0.5) AND (@lon+0.5) )
    ) AND z.fish_max_length < 45
GO
---------------------------------------------------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'fn_read_fish_edit_list' AND xtype = 'TF')
    DROP function dbo.fn_read_fish_edit_list
GO
-- 1 - sport, 2 - Coarse, 4 - commersial, 8 - invading
-- select * from dbo.fn_read_fish_edit_list() where fish_id = '6b45fea3-5cbe-4982-89af-c241eb5c6a36'  ORDER BY fish_name ASC
CREATE FUNCTION dbo.fn_read_fish_edit_list()
RETURNS @TBL TABLE ( fish_id uniqueidentifier, fish_name varchar(32), fish_latin varchar(64), synonims  varchar(255) 
         , food_Type int, water_type int, feedsOver int , habitat int
         , tuLD float, tuL float, tuC float, tuH float, tuHD float 
         , tmLD float, tmL float, tmC float, tmH float, tmHD float
         , oxLD float, oxL float, oxC float, oxH float, oxHD float
         , phLD float, phL float, phC float, phH float, phHD float
         , veL float, veH float
         , depthMin float, depthMax float
         , saltL float, saltH float
         , NitrateH float, NitrateL float, PhosphateH float, PhosphateL float
         , periodStart int , periodEnd int, editor varchar(128), locked bit
         , fish_Type int, fish_ability int, react_color int, home_range float, stamp datetime )
WITH SCHEMABINDING
AS
begin
  -- get non-spawn period
  INSERT INTO @TBL ( fish_id, fish_name, fish_latin, synonims, food_Type
                   , water_type, fish_Type, fish_ability, react_color, home_range, stamp )
        SELECT fish_id, fish_name, fish_latin, alt_Name, food_Type, water_type, fish_Type
        , fish_ability, react_color, fish_home_range, stamp FROM dbo.fish;

  update t SET t.depthMin = n.ri_min, t.depthMax = n.ri_max 
      from dbo.real_interval n RIGHT JOIN dbo.fish_Rule c ON c.id = n.ri_parent_id RIGHT JOIN @tbl t on t.fish_id=c.fish_id  
        WHERE c.periodStart=-1 AND c.periodEnd=-1 AND ri_type = 3 

  update t SET t.veL = n.ri_min, t.veH = n.ri_max 
      from dbo.real_interval n RIGHT JOIN dbo.fish_Rule c ON c.id = n.ri_parent_id RIGHT JOIN @tbl t on t.fish_id=c.fish_id  
        WHERE c.periodStart=-1 AND c.periodEnd=-1 AND ri_type = 41

  update t SET t.saltL = n.ri_min, t.saltH = n.ri_max 
      from dbo.real_interval n RIGHT JOIN dbo.fish_Rule c ON c.id = n.ri_parent_id RIGHT JOIN @tbl t on t.fish_id=c.fish_id  
        WHERE c.periodStart=-1 AND c.periodEnd=-1 AND ri_type = 49

  update t SET t.PhosphateL = n.ri_min, t.PhosphateH = n.ri_max 
      from dbo.real_interval n RIGHT JOIN dbo.fish_Rule c ON c.id = n.ri_parent_id RIGHT JOIN @tbl t on t.fish_id=c.fish_id  
        WHERE c.periodStart=-1 AND c.periodEnd=-1 AND ri_type = 57

  update t SET t.NitrateL = n.ri_min, t.NitrateH = n.ri_max 
      from dbo.real_interval n RIGHT JOIN dbo.fish_Rule c ON c.id = n.ri_parent_id RIGHT JOIN @tbl t on t.fish_id=c.fish_id  
        WHERE c.periodStart=-1 AND c.periodEnd=-1 AND ri_type = 65

  update t SET t.oxLD=n.ri_min, t.oxL=n.ri_low, t.oxC=n.ri_avg, t.oxH=n.ri_high, t.oxHD=n.ri_max
      from dbo.real_interval n RIGHT JOIN dbo.fish_Rule c ON c.id = n.ri_parent_id RIGHT JOIN @tbl t on t.fish_id=c.fish_id  
        WHERE c.periodStart=-1 AND c.periodEnd=-1 AND ri_type = 33
  
  update t SET t.phLD=ph.ri_min, t.phL=ph.ri_low, t.phC=ph.ri_avg, t.phH=ph.ri_high, t.phHD=ph.ri_max
      from dbo.real_interval ph RIGHT JOIN dbo.fish_Rule c ON c.id = ph.ri_parent_id RIGHT JOIN @tbl t on t.fish_id=c.fish_id  
        WHERE c.periodStart=-1 AND c.periodEnd=-1 AND ri_type = 9

  update t SET t.tmLD=tm.ri_min, t.tmL=tm.ri_low, t.tmC=tm.ri_avg, t.tmH=tm.ri_high, t.tmHD=tm.ri_max
      from dbo.real_interval tm RIGHT JOIN dbo.fish_Rule c ON c.id = tm.ri_parent_id RIGHT JOIN @tbl t on t.fish_id=c.fish_id  
        WHERE c.periodStart=-1 AND c.periodEnd=-1 AND ri_type = 17

  update t SET t.tuLD=tu.ri_min, t.tuL=tu.ri_low, t.tuC=tu.ri_avg, t.tuH=tu.ri_high, t.tuHD=tu.ri_max
      from dbo.real_interval tu RIGHT JOIN dbo.fish_Rule c ON c.id = tu.ri_parent_id RIGHT JOIN @tbl t on t.fish_id=c.fish_id  
        WHERE c.periodStart=-1 AND c.periodEnd=-1 AND ri_type = 25
     
    update t SET t.locked = c.locked, t.feedsOver=c.feedsOver, t.habitat=c.habitat, t.editor = c.editor
     FROM @TBL t JOIN dbo.fish_Rule c ON t.fish_id=c.fish_id  WHERE -1 = c.periodStart AND -1 = c.periodEnd
  return
end
GO
--------------------------------------------------------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'fn_edit_fish_general' AND xtype = 'IF')
    DROP function dbo.fn_edit_fish_general
GO

-- Called from  FishTracker.Editor.FishGeneral.LoadGeneralFish
-- SELECT * FROM [dbo].fn_edit_fish_general('a85ebf22-4ab9-4a91-a14a-cef6c8e64d97')
-- SELECT TOP 1 fish_image_id FROM dbo.fish_image WHERE fish_id = '6b45fea3-5cbe-4982-89af-c241eb5c6a36'
CREATE FUNCTION [dbo].[fn_edit_fish_general]( @fish_id varchar(36) )
RETURNS TABLE
WITH SCHEMABINDING
AS
  RETURN
    SELECT TOP 1 fish_latin, fish_name, alt_name AS fish_alt_name, descrip AS fish_description 
        , locked, stamp, (select userName from dbo.users where id=editor) AS editor 
        , (SELECT TOP 1 fish_image_id FROM dbo.fish_image WHERE fish_id = @fish_id ORDER BY fish_image_stamp DESC) AS fish_image_id
      FROM dbo.fish f WHERE f.fish_id = @fish_id
GO
--------------------------------------------------------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'fn_cvt_date2bigint' AND xtype = 'FN')
    DROP function dbo.fn_cvt_date2bigint
GO

CREATE function dbo.fn_cvt_date2bigint(@dt datetime2)
returns bigint
WITH SCHEMABINDING
as
begin
    RETURN CAST(convert(varchar(8), @dt, 112) AS BIGINT)*10000 + DATEPART(hour,@dt)*100+DATEPART(minute,@dt)  
end
GO
----------------------------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'fn_getfirstmlifish' AND xtype = 'IF')
    DROP function dbo.fn_getfirstmlifish
GO

-- get fish for station science view related or any first
--     SELECT * FROM dbo.fn_getfirstmlifish('05ME009');
-- SELECT CAST(fish_id AS varchar(36)), fish_name, fish_latin FROM dbo.fn_getfirstmlifish('05MD011')
CREATE function dbo.fn_getfirstmlifish(@mli varchar(64))
  RETURNS TABLE 
WITH SCHEMABINDING
AS
RETURN
    WITH cte AS
    ( 
        SELECT TOP 1 fish_id, w.mli FROM dbo.lake_fish fl 
			JOIN dbo.lake l ON l.lake_id = fl.lake_id 
			JOIN dbo.WaterStation w ON w.lakeid = l.lake_id 
			WHERE w.mli = @mli
			ORDER BY fl.stamp DESC
    )
	SELECT fish_id, fish_name, fish_latin FROM dbo.fish WHERE fish_id IN (SELECT fish_id FROM cte)
GO
--------------------------------------------------------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'fn_EditLakeLink' AND xtype = 'IF')
    DROP function dbo.fn_EditLakeLink
GO

-- get fish for station science view related or any first
--     SELECT * FROM dbo.fn_EditLakeLink('45c0706e-d3aa-47eb-80b1-3f4712817916', 16);
CREATE function dbo.fn_EditLakeLink(@lake uniqueidentifier, @type int)
  RETURNS TABLE 
WITH SCHEMABINDING
AS
RETURN
SELECT TOP 1 lake_name, tname, lake_id, t_id, side, zone, country, county, state, city, elevation, location, descript, district, municipality, region, lat, lon 
FROM (
    SELECT 1 AS code, m.lake_name, l.lake_name AS tname, l.lake_id, m.lake_id AS t_id, t.side, t.zone, t.country, t.county, t.state, t.city, t.elevation, t.location, t.descript, t.district, t.municipality, t.region, t.lat, t.lon
        FROM dbo.lake l 
            JOIN dbo.Tributaries t ON l.lake_id = t.main_lake_id AND t.lake_id <> t.main_lake_id 
            JOIN dbo.lake m ON m.lake_id = t.lake_id 
        WHERE l.lake_id=@lake AND side = @type
    UNION 
    SELECT 2, l.lake_name, l.lake_name AS tname, l.lake_id, l.lake_id AS t_id, t.side, t.zone, t.country, t.county, t.state, t.city, t.elevation, t.location, t.descript, t.district, t.municipality, t.region, t.lat, t.lon
        FROM dbo.lake l 
            JOIN dbo.Tributaries t ON l.lake_id = t.main_lake_id AND t.lake_id = t.main_lake_id 
        WHERE l.lake_id=@lake AND side = @type
)x ORDER BY code
GO
--------------------------------------------------------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'fn_EditTributary' AND xtype = 'IF')
    DROP function dbo.fn_EditTributary
GO

-- get fish for station science view related or any first
--     SELECT * FROM dbo.fn_EditTributary('C0A2F9E8-1BC5-4431-9ED3-FAACF857E6EC');
CREATE function dbo.fn_EditTributary(@lake uniqueidentifier)
  RETURNS TABLE 
WITH SCHEMABINDING
AS
RETURN
SELECT ROW_NUMBER() OVER (ORDER BY  lake_name ASC) AS num, lake_name, Lake_id, side, country, state, zone, id, lat, lon
    FROM
    (
        SELECT v.lake_name, t.Lake_id, side, t.country, t.state, t.zone, t.id, t.lat, t.lon
            FROM dbo.Tributaries t
                JOIN dbo.Lake l ON l.lake_id = t.Main_Lake_id JOIN dbo.Lake v ON v.lake_id = t.Lake_id
                WHERE Main_Lake_id = @lake AND side NOT IN (16, 32) 
                   OR ( t.Lake_id = @lake AND t.side = 1) 
                   OR ( t.Lake_id = @lake AND t.side in (4,8))
    )x
GO
--------------------------------------------------------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'fn_SubTributary' AND xtype = 'IF')
    DROP function dbo.fn_SubTributary
GO

-- get fish for station science view related or any first
--     SELECT * FROM dbo.fn_SubTributary('C0A2F9E8-1BC5-4431-9ED3-FAACF857E6EC');
CREATE function dbo.fn_SubTributary(@lake uniqueidentifier)
  RETURNS TABLE 
WITH SCHEMABINDING
AS
RETURN
SELECT ROW_NUMBER() OVER (ORDER BY  lake_name ASC) AS num, lake_name, Lake_id, side, country, state, zone, id, lat, lon
    FROM
    (
        SELECT l.lake_name, l.Lake_id, side, t.country, t.state, t.zone, t.id, t.lat, t.lon
            FROM dbo.Tributaries t
                JOIN dbo.Lake l ON l.lake_id = t.main_Lake_id
                WHERE t.Lake_id = @lake AND side IN (16, 32, (16 | 1), (16 | 2), (32 | 1), (32 | 2))
    )x
GO
--------------------------------------------------------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'fn_EditLakeFish' AND xtype IN ('IF', 'TF'))
    DROP function dbo.fn_EditLakeFish
GO

-- get fish for station science view related or any first
--     SELECT * FROM dbo.fn_EditLakeFish('fc0d917b-d053-11d8-92e2-080020a0f4c9');
CREATE function dbo.fn_EditLakeFish(@lake uniqueidentifier)
RETURNS @TBL TABLE ( sid int not null primary key, fish_name sysname, fish_id uniqueidentifier, link nvarchar(2048), source_type int, type int )
WITH SCHEMABINDING
AS
BEGIN
    INSERT INTO @tbl
    SELECT t.sid, fish_name, t.fish_id, t.link, probability_source_type, null
        FROM dbo.lake_fish  t
        JOIN dbo.Lake l ON l.lake_id = t.Lake_id 
            JOIN dbo.fish v ON v.fish_id = t.fish_id
            JOIN dbo.fish_zoo z ON v.fish_id = z.fish_id
        WHERE t.Lake_id = @lake;
    -- select highest priority
    ;WITH cte AS 
    (
        SELECT fish_id, MAX(source_type) AS source_type FROM @tbl GROUP BY fish_id HAVING COUNT(*) > 1
    )
        DELETE FROM @tbl WHERE sid IN 
            ( SELECT MAX(sid) FROM ( SELECT t.sid, t.fish_id FROM cte JOIN @tbl t 
				ON t.fish_id = cte.fish_id AND t.source_type=cte.source_type )z GROUP BY fish_id HAVING COUNT(*) = 1 );
    -- remove duplicates with empty link
    ;WITH cte AS
    (
        SELECT fish_id FROM @tbl GROUP BY fish_id HAVING COUNT(*) > 1
    )
    DELETE FROM @tbl WHERE sid IN 
    ( SELECT t.sid FROM cte JOIN @tbl t ON t.fish_id = cte.fish_id WHERE link IS NULL );

    UPDATE t SET type = fish_type FROM @TBL t JOIN dbo.fish ON t.fish_id = fish.fish_id
    RETURN;        
END
GO
--------------------------------------------------------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'fn_GetCloseLake' AND xtype = 'IF')
    DROP function dbo.fn_GetCloseLake
GO
IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'fn_GetLakeRegulations' AND xtype = 'IF')
    DROP function dbo.fn_GetLakeRegulations
GO
IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'fn_GetAllLakeZones' AND xtype = 'IF')
    DROP function dbo.fn_GetAllLakeZones
GO
IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'fn_GetAllLakeStates' AND xtype = 'IF')
    DROP function dbo.fn_GetAllLakeStates
GO
IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'fn_ViewTributary' AND xtype = 'TF')
    DROP function dbo.fn_ViewTributary
GO
-- get fish for station science view related or any first
--     SELECT * FROM dbo.fn_ViewTributary('a6c730df-2892-e811-9104-00155d007b12');
--     SELECT * FROM dbo.fn_ViewTributary('00000000-0000-0000-0000-000000000000');
--     SELECT * FROM dbo.fn_ViewTributary('0c55ba0c-849c-20c3-9b46-02ad5bdf9847');
-- used in wfRiverViewer : LoadTributary(Guid lakeid)

CREATE function dbo.fn_ViewTributary( @lake uniqueidentifier )
  RETURNS @TBL TABLE (num int not null, lake_name sysname, Lake_id uniqueidentifier, way varchar(36)
    , lat float, lon float, nrows int not null, source_district nvarchar(255), mouth_district nvarchar(255)
    , source_country char(2), mouth_country char(2), source_state nvarchar(64), mouth_state nvarchar(64), source_zone int, mouth_zone int)
WITH SCHEMABINDING
AS
BEGIN
	;WITH cte AS
	(
		SELECT ROW_NUMBER() OVER (ORDER BY  y.Lake_id ASC) AS num, y.Lake_id, y.side, y.coast, y.type, v.source_id, v.mouth_id  FROM
		(
			SELECT  Lake_id, side, NULL AS coast, 0 AS type FROM dbo.Tributaries t WHERE  t.Main_Lake_id = @lake 
			UNION ALL
			SELECT  Main_Lake_id, CASE WHEN side = 32 THEN 16 WHEN side=16 THEN 32 ELSE side END, coast, 1 AS type 
                FROM dbo.Tributaries t WHERE t.Lake_id = @lake 
		)y, dbo.vw_lake v WHERE v.lake_id = @lake
	)
        INSERT INTO @TBL
	SELECT num, m.lake_name, m.Lake_id, way, lat, lon, COUNT(*) OVER () as nrows
      , m.source_district, m.mouth_district, m.source_country, m.mouth_country, m.source_state, m.mouth_state, m.source_zone, m.mouth_zone
	FROM 
	(
		SELECT ROW_NUMBER() OVER (ORDER BY  lake_name ASC) AS num, lake_name, Lake_id, way
			FROM
			(
				SELECT DISTINCT t.Lake_id, lake_name
				, CASE WHEN side = 16 THEN CASE WHEN source_id <> t.Lake_id then 'Inflow' ELSE 'Source' END
					   WHEN side = 32 THEN CASE WHEN mouth_id  <> t.Lake_id then 'Outflow'ELSE 'Mouth' END
					   WHEN side = 16 AND coast = 'L'   then 'Left Inflow' 
					   WHEN side = 16 AND coast = 'R'   then 'Right Inflow' 
					   WHEN side = 1  then 'Linked'
					   WHEN  side = 4 then 'Inflow Throw' 
					   WHEN  side = 8 then 'Outflow Throw' 
					   WHEN  side = 2 then 'Flow Throw' 
					   END as way 
				FROM 
				(
					SELECT num, Lake_id, side, coast, type, source_id, mouth_id FROM cte WHERE num IN
						(
						   SELECT num FROM cte
							EXCEPT
						   SELECT num FROM cte WHERE side IN (16, 32) AND lake_id IN ( SELECT lake_id FROM cte GROUP BY lake_id HAVING COUNT(*) = 3 )
						) AND Lake_id <> @lake
				)t
				 JOIN dbo.Lake l ON t.Lake_id = l.Lake_id  
				 WHERE t.Lake_id <> @lake
			)x WHERE way IS NOT NULL
	)y JOIN dbo.vw_lake m ON m.lake_id = y.lake_id
    RETURN
END
GO
--------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'fn_EditLakeFish' AND xtype = 'TF')
    DROP function dbo.fn_EditLakeFish
GO

-- get fish for station science view related or any first
--     SELECT * FROM dbo.fn_EditLakeFish('fcdf62d3-f1b3-4715-bfca-78dcf0e3a4c5');
CREATE function dbo.fn_EditLakeFish(@lake uniqueidentifier)
RETURNS @TBL TABLE ( sid int not null primary key, fish_name sysname, fish_id uniqueidentifier, link nvarchar(2048), source_type int )
WITH SCHEMABINDING
AS
BEGIN
    INSERT INTO @tbl
    SELECT t.sid, fish_name, t.fish_id, t.link, probability_source_type
        FROM dbo.lake_fish  t
        JOIN dbo.Lake l ON l.lake_id = t.Lake_id 
            JOIN dbo.fish v ON v.fish_id = t.fish_id
            JOIN dbo.fish_zoo z ON v.fish_id = z.fish_id
        WHERE t.Lake_id = @lake;
    -- select highest priority
    ;WITH cte AS 
    (
        SELECT fish_id, MAX(source_type) AS source_type FROM @tbl GROUP BY fish_id HAVING COUNT(*) > 1
    )
        DELETE FROM @tbl WHERE sid IN 
            ( SELECT MAX(sid) FROM ( SELECT t.sid, t.fish_id FROM cte JOIN @tbl t ON t.fish_id = cte.fish_id AND t.source_type=cte.source_type )z GROUP BY fish_id HAVING COUNT(*) = 1 );
    -- remove duplicates with empty link
    ;WITH cte AS
    (
        SELECT fish_id FROM @tbl GROUP BY fish_id HAVING COUNT(*) > 1
    )
    DELETE FROM @tbl WHERE sid IN 
    ( SELECT t.sid FROM cte JOIN @tbl t ON t.fish_id = cte.fish_id WHERE link IS NULL );
    RETURN;        
END
GO

--------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'fn_lake_fish' AND xtype = 'FN')
    DROP function dbo.fn_lake_fish
GO


/******
 * get fish data related to lake
 * used for fish editor at lake/river
 *
 * Author: K.T.
 * INPUT PARAMETERS:
 *
 *    @lake uniqueidentifier        -- lake id
 *
 *    Usage:    
                SELECT dbo.fn_lake_fish('fc0d917b-d053-11d8-92e2-080020a0f4c9');
 */
CREATE function dbo.fn_lake_fish(@lake uniqueidentifier)
RETURNS XML
WITH SCHEMABINDING
AS
BEGIN
    DECLARE @TBL TABLE ( 
      sid int not null primary key
    , fish_name sysname
    , fish_id uniqueidentifier
    , link nvarchar(2048)
    , source_type int
    , type int );

    INSERT INTO @tbl
    SELECT t.sid, fish_name, t.fish_id, t.link, probability_source_type, null
        FROM dbo.lake_fish  t
        JOIN dbo.Lake l ON l.lake_id = t.Lake_id 
            JOIN dbo.fish v ON v.fish_id = t.fish_id
            JOIN dbo.fish_zoo z ON v.fish_id = z.fish_id
        WHERE t.Lake_id = @lake;
    -- select highest priority
    ;WITH cte AS 
    (
        SELECT fish_id, MAX(source_type) AS source_type FROM @tbl GROUP BY fish_id HAVING COUNT(*) > 1
    )
        DELETE FROM @tbl WHERE sid IN 
            ( SELECT MAX(sid) FROM ( SELECT t.sid, t.fish_id FROM cte JOIN @tbl t 
				ON t.fish_id = cte.fish_id AND t.source_type=cte.source_type )z GROUP BY fish_id HAVING COUNT(*) = 1 );
    -- remove duplicates with empty link
    ;WITH cte AS
    (
        SELECT fish_id FROM @tbl GROUP BY fish_id HAVING COUNT(*) > 1
    )
    DELETE FROM @tbl WHERE sid IN 
    ( SELECT t.sid FROM cte JOIN @tbl t ON t.fish_id = cte.fish_id WHERE link IS NULL );

    UPDATE t SET type = fish_type FROM @TBL t JOIN dbo.fish ON t.fish_id = fish.fish_id

    DECLARE @result XML =
    (SELECT noFish, is_fishing_prohibited, isFish, fishing, lake_name, Lake_id, Reviewed,
        (SELECT sid, fish_name, fish_id, link, source_type, type FROM @TBL [fish] ORDER BY fish_name ASC FOR XML AUTO, TYPE)
        FROM dbo.lake WHERE lake_id = @lake FOR XML AUTO); 

    RETURN @result;        
END
GO
--------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'fn_EditLakeHelpList' AND xtype = 'IF')
    DROP function dbo.fn_EditLakeHelpList
GO

-- gives suggested fished for LakeFish Editor
-- SELECT * FROM dbo.fn_EditLakeHelpList( '0c49aa05-849c-20c3-ed12-b67a8b7cc629' )
CREATE function dbo.fn_EditLakeHelpList( @lake uniqueidentifier )
  RETURNS TABLE 
WITH SCHEMABINDING
AS
RETURN
SELECT sid, f.fish_id, fish_name, l.created FROM 
(
    SELECT fish_id, created FROM 
    ( 
        SELECT TOP 100 fish_id, MAX(created) AS created FROM dbo.lake_fish WHERE lake_id <> @lake 
		    GROUP BY fish_id ORDER BY created DESC 
    ) x 
	WHERE NOT EXISTS (SELECT 1 FROM dbo.lake_fish l WHERE l.lake_Id =  @lake AND l.fish_id = x.fish_id)
)l JOIN dbo.fish f ON l.fish_id = f.fish_id 
GO
--------------------------------------------------------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'fn_DefaultLastLake' AND xtype = 'IF')
    DROP function dbo.fn_DefaultLastLake
GO

-- gives suggested fished for default page
-- SELECT * FROM dbo.fn_DefaultLastLake( 'CA' )
CREATE function dbo.fn_DefaultLastLake( @country char(2) )
  RETURNS TABLE 
AS
RETURN
    SELECT TOP 20 lake_id, lake_name, stamp, lat, lon FROM
    (
        SELECT TOP 5 l.lake_id, l.lake_name, l.stamp, s.lat , s.lon 
                FROM dbo.lake l 
                    JOIN dbo.Tributaries s ON s.main_lake_id = l.lake_id AND s.side = 16
                WHERE s.Lat IS NOT NULL AND s.Lon IS NOT NULL AND l.locType = 2 AND s.country = @country
				   AND EXISTS (SELECT 1 FROM lake_fish f WHERE l.lake_Id = f.lake_Id)
                ORDER BY l.stamp DESC
        UNION ALL
        SELECT TOP 5 l.lake_id, l.lake_name, l.stamp, s.lat , s.lon 
                FROM dbo.lake l
                    JOIN dbo.Tributaries s ON s.main_lake_id = l.lake_id AND s.side = 16
                WHERE s.Lat IS NOT NULL AND s.Lon IS NOT NULL AND l.locType = 1 AND s.country = @country
					AND EXISTS (SELECT 1 FROM lake_fish f WHERE l.lake_Id = f.lake_Id)
                ORDER BY l.stamp DESC
        UNION ALL
        SELECT TOP 5 l.lake_id, l.lake_name, l.stamp, s.lat , s.lon 
                FROM dbo.lake l
                    JOIN dbo.Tributaries s ON s.main_lake_id = l.lake_id AND s.side = 16
                    , dbo.vw_NewID n
                WHERE s.Lat IS NOT NULL AND s.Lon IS NOT NULL AND l.locType IN (1,2) AND s.country = @country
								   AND EXISTS (SELECT 1 FROM lake_fish f WHERE l.lake_Id = f.lake_Id)
                ORDER BY n.new_id
    )x ORDER BY lake_id
GO
--------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'fn_LocType' AND xtype = 'IF')
    DROP function dbo.fn_LocType
GO
/*
   display water types for river list for trial ar registred users
   -- gives suggested fished for LakeFish Editor
-- SELECT * FROM dbo.fn_LocType( 'CA', 0 )
*/
CREATE function dbo.fn_LocType( @country char(2), @trial bit )
  RETURNS TABLE 
WITH SCHEMABINDING
AS
RETURN
SELECT locType, CAST(COUNT(*) AS int) AS cnt FROM dbo.lake l where locType IN (1, 2 ) AND @trial = 1
	AND EXISTS (SELECT 1 FROM dbo.Tributaries t WHERE t.Main_Lake_id = l.lake_id AND country = @country) GROUP BY locType  
UNION ALL
SELECT locType, CAST(COUNT(*) AS int) AS cnt FROM  dbo.lake l where locType IN (1, 2, 4, 8, 32, 64, 128, 8192 ) AND @trial = 0
	AND EXISTS (SELECT 1 FROM dbo.Tributaries t WHERE t.Main_Lake_id = l.lake_id AND country = @country) GROUP BY locType  
GO
--------------------------------------------------------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'fn_ANSII2CODE' AND xtype = 'IF')
    DROP function dbo.fn_ANSII2CODE
GO
/*
	convert unicode symbols as list of codes
	Usage: SELECT * FROM dbo.fn_ANSII2CODE( N'preved medved')
	Execute result : as SELECT NCHAR(73)+NCHAR(110)+NCHAR(105)
*/
CREATE FUNCTION dbo.fn_ANSII2CODE( @value sysname )
RETURNS TABLE
AS
  RETURN 
	WITH cte AS
	( 
		select CAST(UNICODE(substring(a.b, v.number+1, 1)) AS varchar(16)) AS value from (select b FROM (VALUES (@value))x(b)) a 
			join master.dbo.spt_values v on v.number < len(a.b) where v.type = 'P'
	)
	SELECT 'NCHAR(' + (SELECT STRING_AGG(value, ')+NCHAR(') AS state_code FROM cte) + ')' AS value
GO
--------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'fn_GetCloseLake' AND xtype = 'IF')
    DROP function dbo.fn_GetCloseLake
GO
IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'GetCloseByLatLon' AND xtype = 'IF')
    DROP function dbo.GetCloseByLatLon
GO
IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'GetCloseByDistance' AND xtype = 'IF')
    DROP function dbo.GetCloseByDistance
GO
/*
    Get closetst lakes near point with a distance
    select top 15 lake_id, closest from dbo.GetCloseByDistance( 46.9187080460205, -82.2112350422363, 1)
 */
CREATE function GetCloseByDistance( @lat float, @lon float, @distance int)
  RETURNS TABLE 
WITH SCHEMABINDING
AS
RETURN
    select lake_id, main_lake_id, @distance as closest from dbo.Tributaries 
        where lat > 0 and lon < 0 
            and (lat > (@lat - (0.01 * @distance)) and lat < (@lat + (0.01 * @distance))) 
            and (lon < (@lon + (0.01 * @distance)) and lon > (@lon - (0.01 * @distance))) 
GO
--------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'fn_GetCloseLake' AND xtype = 'IF')
    DROP function dbo.fn_GetCloseLake
GO
IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'GetCloseByLatLon' AND xtype = 'IF')
    DROP function dbo.GetCloseByLatLon
GO
/*
    Get closetst lakes near point
    select top 15 lake_id, closest from dbo.GetCloseByLatLon( 46.9187080460205, -82.2112350422363 )
 */
CREATE function GetCloseByLatLon( @lat float, @lon float )
  RETURNS TABLE 
WITH SCHEMABINDING
AS
RETURN
    select TOP 15 lake_id, MIN(closest) as closest from 
    (
        select top 15 lake_id, closest from dbo.GetCloseByDistance( @lat, @lon, 1)
        union 
        select top 15 main_lake_id, closest from dbo.GetCloseByDistance( @lat, @lon, 1)
        union all
        select top 15 lake_id, closest from dbo.GetCloseByDistance( @lat, @lon, 5)
        union 
        select top 15 main_lake_id, closest from dbo.GetCloseByDistance( @lat, @lon, 5)
        union all
        select top 15 lake_id, closest from dbo.GetCloseByDistance( @lat, @lon, 10)
        union 
        select top 15 main_lake_id, closest from dbo.GetCloseByDistance( @lat, @lon, 10)
        union all
        select top 15 lake_id, closest from dbo.GetCloseByDistance( @lat, @lon, 20)
        union 
        select top 15 main_lake_id, closest from dbo.GetCloseByDistance( @lat, @lon, 20)
    )x  group by lake_id ORDER BY closest ASC

GO
--------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'fn_GetCloseLake' AND xtype = 'IF')
    DROP function dbo.fn_GetCloseLake
GO
/* 
 select * from dbo.fn_GetCloseLake( '0c5e1097-849c-20c3-04f0-7bdd1e0a5ee5' )
 Used in river view aspx page as close by rivers
 */
CREATE FUNCTION dbo.fn_GetCloseLake( @lakeId uniqueidentifier )
  RETURNS TABLE 
WITH SCHEMABINDING
AS
RETURN
    SELECT TOP 10 ROW_NUMBER() OVER (ORDER BY closest ASC) AS num, v.lake_id, v.lake_name, lat, lon, closest  FROM
    (
        SELECT x.lake_id, MIN(closest) AS closest FROM dbo.fn_ViewTributary(@lakeId) cross apply  dbo.GetCloseByLatLon( lat, lon ) x 
            WHERE NOT EXISTS ( SELECT 1 FROM dbo.fn_ViewTributary(@lakeId) z WHERE x.lake_id = z.lake_id )
            group by x.lake_id
    )y JOIN dbo.vw_lake v ON v.lake_id = y.lake_id
    WHERE v.lake_id <> @lakeId
GO
--------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'fn_GetLakeRegulations' AND xtype = 'IF')
    DROP function dbo.fn_GetLakeRegulations
GO
IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'fn_GetAllLakeStates' AND xtype = 'IF')
    DROP function dbo.fn_GetAllLakeStates
GO
/* 
 select * from dbo.fn_GetAllLakeStates( '0c369d7b-849c-20c3-6274-0fd28a9dbbf4' )
 select * FROM dbo.fn_ViewTributary('0c369d7b-849c-20c3-6274-0fd28a9dbbf4')
 River may flow throw several states and counters, function retuns all of them
 */
CREATE FUNCTION dbo.fn_GetAllLakeStates( @lakeId uniqueidentifier )
  RETURNS TABLE 
WITH SCHEMABINDING
AS
RETURN
    WITH cte ( country, state ) AS
    (
        SELECT source_country, source_state FROM dbo.fn_ViewTributary(@lakeId)
        UNION
        SELECT mouth_country, mouth_state FROM dbo.fn_ViewTributary(@lakeId)
    )SELECT DISTINCT country, state FROM cte WHERE  country IS NOT NULL OR state  IS NOT NULL
GO
--------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'fn_GetLakeRegulations' AND xtype = 'IF')
    DROP function dbo.fn_GetLakeRegulations
GO
IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'fn_GetAllLakeZones' AND xtype = 'IF')
    DROP function dbo.fn_GetAllLakeZones
GO
/* 
 select * from dbo.fn_GetAllLakeZones( '0c369d7b-849c-20c3-6274-0fd28a9dbbf4' )
 select * FROM dbo.fn_ViewTributary('0c369d7b-849c-20c3-6274-0fd28a9dbbf4')
 River may flow throw several fishing zones
 */
CREATE FUNCTION dbo.fn_GetAllLakeZones( @lakeId uniqueidentifier )
  RETURNS TABLE 
WITH SCHEMABINDING
AS
RETURN
    WITH cte ( zone_id ) AS
    (
        SELECT source_zone FROM dbo.fn_ViewTributary(@lakeId)
        UNION
        SELECT mouth_zone FROM dbo.fn_ViewTributary(@lakeId)
    )SELECT DISTINCT zone_id FROM cte WHERE zone_id IS NOT NULL
GO
--------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'fn_GetLakeRegulations' AND xtype = 'IF')
    DROP function dbo.fn_GetLakeRegulations
GO
/* 
 select * from dbo.fn_GetLakeRegulations( '0c369d7b-849c-20c3-6274-0fd28a9dbbf4' )
 Each River has list of regulations
 */
CREATE FUNCTION dbo.fn_GetLakeRegulations( @lake_id uniqueidentifier )
  RETURNS TABLE 
WITH SCHEMABINDING
AS
RETURN
    WITH cte AS 
 (
    SELECT ROW_NUMBER() over (ORDER BY fish_id, level ASC) AS num, fish_id, regulations_id, level FROM
    (
        SELECT fish_id, regulations_id, 1 AS level FROM dbo.regulations WHERE lake_id = @lake_id
        UNION ALL
        SELECT fish_id, regulations_id, 2 FROM dbo.regulations r 
            JOIN dbo.fn_GetAllLakeZones( @lake_id ) z ON r.zone_id = z.zone_id WHERE r.lake_id Is NULL
        UNION ALL
        SELECT fish_id, regulations_id, 3 FROM dbo.regulations r JOIN dbo.fn_GetAllLakeStates( @lake_id ) z ON r.state = z.state WHERE r.lake_id Is NULL AND zone_id IS NULL
    )x
)   SELECT r.regulations_id,[regulations_part],[state],[zone_id],[Lake_id],[fish_id],[chain],[regulations_date_start],[regulations_start]
           ,[regulations_date_end],[regulations_end],[regulations_sport],[regulations_sport_text],[regulations_consr],[regulations_consr_text]
           ,[regulations_code],[regulations_link],[regulations_stamp],[regulations_text]
        FROM dbo.regulations r JOIN
        (SELECT regulations_id FROM cte WHERE num IN (SELECT MIN(num) AS num from cte GROUP BY fish_id)) z ON z.regulations_id = r.regulations_id
GO
--------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM sys.types WHERE is_table_type = 1 AND name = 't_xmltype')
    DROP type t_xmltype
GO

CREATE TYPE t_xmltype AS TABLE (id int not null identity(1,1), name sysname UNIQUE, value varchar(255));
GO
-------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------- 
 IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'fn_data2cdata' AND xtype = 'FN')
    DROP function dbo.fn_data2cdata ;
GO
/******
 * convert string to CDATA section
 *
 * INPUT PARAMETERS:
 *
 *    @root         sysname       -- node name
 *    @root         sysname       -- attribute name
 *    @root         sysname       -- attribute value
 *    @data         nvarchar(max) -- unicode data
 *
 *    Usage:    declare @v t_xmltype; insert into @v values ('name', 'test') ;
                SELECT dbo.fn_data2cdata(N'node', N'<test!>', @v) as val;
 */
CREATE function dbo.fn_data2cdata( @root sysname, @atrname sysname, @atrguid uniqueidentifier, @data nvarchar(max) )
RETURNS nvarchar(max)
AS
BEGIN
    DECLARE @rst nvarchar(max) = '';

    IF NULLIF(TRIM(@data), '') IS NOT NULL 
    BEGIN
        select @rst  = CAST(val As nvarchar(max)) from 
        (
            select * from 
            (
                SELECT 1 AS Tag, 0 AS Parent, null AS [Az-aZ!1], null AS [Az-aZ!2], null AS [Az-aZ!2!CDATA]
                UNION ALL
                SELECT 2, 1, null, null, @data
            ) t FOR XML EXPLICIT, BINARY BASE64
        )x(val);

        SET @rst = REPLACE( REPLACE( @rst, N'<Az-aZ/>', N''), N'<Az-aZ ',N'');
        SET @rst = REPLACE( @rst, N'<Az-aZ>', N'');
        SET @rst = REPLACE( @rst, N'CDATA="', N'<![CDATA[' );
        SET @rst = REPLACE( @rst, N'"/></Az-aZ>', N']]>');

        SET @rst = N'<' + @root + N' name="' + @atrname + N'"' 
        + CASE WHEN @atrguid IS NULL THEN N'' ELSE N' guid="' + CAST(@atrguid AS char(36)) + '"'  END
        + N'>' +  @rst + N'</' + @root + '>';
    END;

    RETURN @rst;
END
GO
 -- declare @v t_xmltype; insert into @v values ('name', 'test'), ('result', 'passed') ;
 -- SELECT dbo.fn_data2cdata(N'node', N'name', N'test', CAST(N'<test!>' AS varbinary(max))) as val;
-----------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------
 IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'fn_xml_tributary' AND xtype = 'FN')
    DROP function dbo.fn_xml_tributary ;
GO
/*
SELECT * FROM dbo.fn_ViewTributary('0c417be9-849c-20c3-1acf-10a55233029a')
SELECT dbo.fn_xml_tributary('0c52b234-849c-20c3-884f-2578d5997429', 1)
*/
CREATE function dbo.fn_xml_tributary(@lake_id uniqueidentifier, @header bit)
RETURNS nvarchar(max)
AS
BEGIN
    DECLARE @main nvarchar(max)
        , @source_district nvarchar(255), @mouth_district nvarchar(255), @lake_name nvarchar(128)

    SELECT @main = val, @source_district = source_district, @mouth_district = mouth_district
         , @lake_name = lake_name FROM
    (
        SELECT * FROM
        (
            SELECT lake_id, way, CAST(lat AS varchar(64)) AS lat, CAST(lon AS varchar(64)) AS lon
                 , source_country, mouth_country
                 , source_state, mouth_state, source_zone, mouth_zone
                 FROM dbo.fn_ViewTributary( @lake_id )
        ) t FOR XML RAW ('node')
    ) x(val), dbo.fn_ViewTributary( @lake_id );

    RETURN CASE WHEN @header = 1 THEN '<?xml version="1.0"?><root>' ELSE '' END
        + COALESCE( @main, '' )
        + dbo.fn_data2cdata(N'node', N'lake_name',       null, @lake_name ) 
        + dbo.fn_data2cdata(N'node', N'source_district', null, @source_district ) 
        + dbo.fn_data2cdata(N'node', N'mouth_district',  null, @mouth_district ) 
        + CASE WHEN @header = 1 THEN '</root>'  ELSE '' END;
END
GO
-----------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------
 IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'fn_lake_edit' AND xtype = 'FN')
    DROP function dbo.fn_lake_edit ;
GO
/******
 * get description data related to lake
 * used for lake editor
 *
 * INPUT PARAMETERS:
 *    @lake uniqueidentifier        -- lake id
 *
 *    Usage:    
                SELECT dbo.fn_lake_edit('982070AB-BBE4-11D8-92E2-080020A0F4C9')
                SELECT dbo.fn_lake_edit('1EB8EABC-BE3C-11D8-92E2-080020A0F4C9');
                select * from lake where lake_id = '1EB8EABC-BE3C-11D8-92E2-080020A0F4C9'
                UPDATE lake SET isFish = 0 where lake_id = '1EB8EABC-BE3C-11D8-92E2-080020A0F4C9'
 */
CREATE function dbo.fn_lake_edit(@lake_id uniqueidentifier)
RETURNS nvarchar(max)
AS
BEGIN
    DECLARE @main nvarchar(max), @name sysname, @native nvarchar(255), @french_name nvarchar(255), @lake_road_access nvarchar(255)
        , @source_name nvarchar(255), @mouth_name nvarchar(255), @fish nvarchar(max), @descript nvarchar(max), @link nvarchar(2048)
        , @drainage nvarchar(128), @discharge nvarchar(128), @watershield nvarchar(128), @fishing nvarchar(max), @alt_name nvarchar(64)
        , @src_id uniqueidentifier, @mth_id uniqueidentifier
    ;WITH cte AS
    (
        SELECT l.lake_id, l.lake_name, l.alt_name, l.[native], l.french_name 
        , l.stamp, l.locType, l.link, l.depth, l.width, l.length, l.volume
        , l.isFish, l.noFish, l.isolated, l.is_fishing_prohibited, l.sid, l.drainage, l.discharge, l.watershield, l.basin
        , l.surface, l.shoreline, l.lake_road_access, l.CGNDB, l.descript, l.fishing
        , w.source_name, w.mouth_name, w.source_state, w.source_country, l.source, l.mouth, l.reviewed
      FROM dbo.lake l JOIN dbo.vw_lake w ON l.lake_id=w.lake_id 
    )
    SELECT @main = val, @name = lake_name, @native = [native], @french_name = french_name, @descript = descript
         , @lake_road_access = lake_road_access, @source_name = source_name, @mouth_name = mouth_name, @link = link
         , @drainage = drainage, @discharge = discharge, @watershield = watershield, @fishing = fishing, @alt_name = alt_name
         , @src_id = source, @mth_id = mouth
         FROM
    (
        SELECT * FROM
        (
            SELECT lake_id, stamp, locType, depth, width, length, volume, surface, shoreline, CGNDB, source_state, source_country
                 , COALESCE(isfish, 0) AS is_fish, COALESCE(noFish, 0) AS no_fish
                 , COALESCE(is_fishing_prohibited, 0) AS is_fishing_prohibited, COALESCE(reviewed, 0) AS reviewed
                 , isolated, link, basin, sid, drainage, discharge, watershield, fishing, source, mouth
                 FROM cte WHERE lake_id = @lake_id
        ) t FOR XML RAW ('lake')
    ) x(val), cte WHERE lake_id = @lake_id;

    SELECT  @fish = COALESCE(val, '') FROM
    ( 
        SELECT * FROM
        (
            SELECT l.fish_id, fish_name FROM lake_fish l JOIN fish f  ON l.fish_id = f.fish_id WHERE lake_id = @lake_id
        ) t FOR XML RAW ('fish')
    ) x(val)

    DECLARE @vals nvarchar(max) = (SELECT STRING_AGG(mli, ',') FROM WaterStation WHERE lakeid=@lake_id);
    IF @vals IS NULL
    BEGIN
        SET @vals = '';
    END
    RETURN '<?xml version="1.0"?><root>' + @main
        + dbo.fn_data2cdata(N'node', N'lake_name',        null,     @name )        
        + dbo.fn_data2cdata(N'node', N'native',           null,     @native )
        + dbo.fn_data2cdata(N'node', N'french_name',      null,     @french_name ) 
        + dbo.fn_data2cdata(N'node', N'lake_road_access', null,     @lake_road_access )
        + dbo.fn_data2cdata(N'node', N'source_name',      @src_id,  @source_name ) 
        + dbo.fn_data2cdata(N'node', N'mouth_name',       @mth_id,  @mouth_name )
        + dbo.fn_data2cdata(N'node', N'descript',         null,     @descript )    
        + dbo.fn_data2cdata(N'node', N'link',             null,     @link )
        + dbo.fn_data2cdata(N'node', N'drainage',         null,     @drainage )    
        + dbo.fn_data2cdata(N'node', N'discharge',        null,     @discharge )
        + dbo.fn_data2cdata(N'node', N'watershield',      null,     @watershield ) 
        + dbo.fn_data2cdata(N'node', N'fishing',          null,     @fishing )
        + dbo.fn_data2cdata(N'node',  N'alt_name',        null,     @alt_name )
        + N'<tributary>' + dbo.fn_xml_tributary(@lake_id , 0) + N'</tributary>'
        + N'<fish>' + @fish + N'</fish>'
        + CASE WHEN NULLIF(@vals, '') IS NULL THEN '' ELSE '<node name="MLI">' + @vals + '</node>' END
        + '</root>';
END
GO
-----------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'fn_GetTopNews' AND xtype = 'IF')
    DROP function dbo.fn_GetTopNews
GO
/* 
 select * FROM dbo.fn_GetTopNews('4b3c2821-af05-4790-9fb8-37f6ba6abf7c')
 */
CREATE FUNCTION dbo.fn_GetTopNews( @newsId uniqueidentifier )
  RETURNS TABLE 
AS
RETURN
    select news_id, news_stamp, country, news_title, news_author_link, news_author, news_source_link, news_source
         , news_photo_author0, lake_id, news_paragraph0, news_paragraph1, news_photo0, 0 AS ORD, id
         , (select fish_name from fish f where f.fish_id = fish1_id) AS fish1_name
         , (select fish_name from fish f where f.fish_id = fish2_id) AS fish2_name
         , (select fish_name from fish f where f.fish_id = fish3_id) AS fish3_name
         , (select lake_name from lake l where l.lake_id = n.lake_id) AS lake_name
         FROM news n WHERE news_id = @newsId AND news_title <> 'title' 
    UNION 
    select top 24 news_id, news_stamp, country, news_title, news_author_link, news_author, news_source_link, news_source
         , news_photo_author0, lake_id, news_paragraph0, news_paragraph1, null AS news_photo0, 1, id 
         , null, null, null, null
        FROM news WHERE news_id <> @newsId AND news_title <> 'title' ORDER BY id DESC
GO
-----------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------
 IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'fn_lake_view_info' AND xtype = 'TF')
    DROP function dbo.fn_lake_view_info ;
GO
-----------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'fn_laketypebyint' AND xtype = 'FN')
    DROP function dbo.fn_laketypebyint;
GO
--- SELECT dbo.fn_laketypebyint(2)

CREATE function dbo.fn_laketypebyint( @type int )
RETURNS varchar(32)
AS
BEGIN
  RETURN
  CASE WHEN @type = 1 THEN 'Lake'
  WHEN @type = 2     THEN 'River'
  WHEN @type = 4     THEN 'Stream'
  WHEN @type = 8     THEN 'Pond'
  WHEN @type = 64    THEN 'Creek'
  WHEN @type = 128   THEN 'Channel'
  WHEN @type = 8912  THEN 'Reservoir'
  WHEN @type = 16385 THEN 'Sea'
  END
END
GO
-----------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------
 IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'fn_lake_view_info' AND xtype = 'TF')
    DROP function dbo.fn_lake_view_info ;
GO

/******
 * get description data related to lake
 * used for lake viewer
 *
 * INPUT PARAMETERS:
 *    @lake uniqueidentifier        -- lake id
 *
 *    Usage:    
                SELECT cast(doc AS xml), img FROM dbo.fn_lake_view_info('890c315e-ba2a-11d8-92e2-080020a0f4c9')
				SELECT cast(doc AS xml), img FROM dbo.fn_lake_view_info('2177FAC1-D376-429F-8AC2-DF4B0E555CA1')
				SELECT cast(doc AS xml), img FROM dbo.fn_lake_view_info('666a39da-ba2a-11d8-92e2-080020a0f4c9')
                SELECT cast(doc AS xml) as doc, img FROM dbo.fn_lake_view_info('22222222-2222-2222-2222-2222222222222')
                SELECT cast(doc AS xml), img FROM dbo.fn_lake_view_info('0CC463B6-849C-20C3-219D-AD76583F5015')
                SELECT * FROM dbo.fn_ViewTributary( 'fc0d917b-d053-11d8-92e2-080020a0f4c9' )
                select * from lake where lake_id = '1EB8EABC-BE3C-11D8-92E2-080020A0F4C9'
                SELECT TOP 1 lake_image_pic FROM dbo.lake_image WHERE lake_image_ownerid = 'fc0d917b-d053-11d8-92e2-080020a0f4c9'

				SELECT * FROM dbo.vw_lake WHERE  lake_id = 'FC0D917B-D053-11D8-92E2-080020A0F4C9'
 */
CREATE function dbo.fn_lake_view_info(@lake_id uniqueidentifier)
  RETURNS @rst TABLE (doc nvarchar(max), img varbinary(max))
AS
BEGIN
    DECLARE @main nvarchar(max), @name sysname, @native nvarchar(255), @french_name nvarchar(255), @lake_road_access nvarchar(255)
        , @source_name nvarchar(255), @mouth_name nvarchar(255), @fish nvarchar(max), @descript nvarchar(max), @link nvarchar(2048)
        , @drainage nvarchar(128), @discharge nvarchar(128), @watershield nvarchar(128), @fishing nvarchar(max), @alt_name nvarchar(64)
        , @src_id uniqueidentifier, @mth_id uniqueidentifier, @science nvarchar(max), @lat float, @lon float
		, @surface int
    ;WITH cte AS
    (
        SELECT l.lake_id, l.lake_name, l.alt_name, l.[native], l.french_name 
        , l.stamp, l.locType, l.link, l.depth, l.width, l.length, l.volume
        , l.isFish, l.noFish, l.isolated, l.is_fishing_prohibited, l.sid, l.drainage, l.discharge, l.watershield, l.basin
        , l.surface, l.shoreline
		, CASE WHEN l.lake_road_access LIKE w.source_district + N'%' THEN NULL ELSE l.lake_road_access END AS lake_road_access
		, l.CGNDB, l.descript, l.fishing
        , w.source_name, w.mouth_name, w.source_state, w.source_country, l.source, l.mouth, w.lat, w.lon
      FROM dbo.lake l JOIN dbo.vw_lake w ON l.lake_id=w.lake_id 
    )
    SELECT @main = val, @name = lake_name, @native = [native], @french_name = french_name, @descript = descript
         , @lake_road_access = lake_road_access, @source_name = source_name, @mouth_name = mouth_name, @link = link
         , @drainage = drainage, @discharge = discharge, @watershield = watershield, @fishing = fishing, @alt_name = alt_name
         , @src_id = source, @mth_id = mouth, @lat = lat, @lon = lon , @surface = surface
         FROM
    (
        SELECT * FROM
        (
            SELECT lake_id, stamp, locType, depth, width, length, volume, surface, shoreline, CGNDB, source_state, source_country
                 , COALESCE(isfish, 0) AS is_fish, COALESCE(noFish, 0) AS no_fish, COALESCE(is_fishing_prohibited, 0) AS is_fishing_prohibited
                 , isolated, link, basin, sid, drainage, discharge, watershield, fishing, source, mouth
				 , dbo.fn_laketypebyint(locType) AS [type], lat, lon
                 FROM cte WHERE lake_id = @lake_id
        ) t FOR XML RAW ('lake')
    ) x(val), cte WHERE lake_id = @lake_id;
	-- fish node 
    SELECT  @fish = COALESCE(val, '') FROM
    ( 
        SELECT * FROM
        (
            SELECT l.fish_id, fish_name, l.link FROM lake_fish l JOIN fish f  ON l.fish_id = f.fish_id WHERE lake_id = @lake_id
        ) t FOR XML RAW ('fish')
    ) x(val)
	-- science data log
    SELECT  @science = COALESCE(val, '') FROM
    ( 
        SELECT * FROM
        (
			 SELECT max(CAST(wd.stamp AS DATE)) AS dt 
				FROM WaterData wd JOIN WaterStation ws ON wd.mli = ws.mli 
				WHERE lakeid = @lake_id
		) t FOR XML RAW ('science')
    ) y(val)
	-- fish spots
	declare @fishspot nvarchar(max);

    SELECT  @fishspot = COALESCE(val, '') FROM
    ( 
        SELECT * FROM
        (
			 SELECT spot_lat, spot_lon 
				FROM Spot a JOIN lake d ON a.lake_id = d.lake_id 
				WHERE d.lake_id = @lake_id
		) t FOR XML RAW ('fishspot')
    ) y(val)

    DECLARE @vals nvarchar(max) = (SELECT STRING_AGG(mli, ',') FROM WaterStation WHERE lakeid=@lake_id);
    IF @vals IS NULL
    BEGIN
        SET @vals = '';
    END
    DECLARE @blob nvarchar(max) = '<?xml version="1.0"?><root>' + @main
        + dbo.fn_data2cdata(N'node', N'lake_name',        null,     @name )        
        + dbo.fn_data2cdata(N'node', N'native',           null,     @native )
        + dbo.fn_data2cdata(N'node', N'french_name',      null,     @french_name ) 
        + dbo.fn_data2cdata(N'node', N'lake_road_access', null,     @lake_road_access )
        + dbo.fn_data2cdata(N'node', N'source_name',      @src_id,  @source_name ) 
        + dbo.fn_data2cdata(N'node', N'mouth_name',       @mth_id,  @mouth_name )
        + dbo.fn_data2cdata(N'node', N'descript',         null,     @descript )    
        + dbo.fn_data2cdata(N'node', N'link',             null,     @link )
        + dbo.fn_data2cdata(N'node', N'drainage',         null,     @drainage )    
        + dbo.fn_data2cdata(N'node', N'discharge',        null,     @discharge )
        + dbo.fn_data2cdata(N'node', N'watershield',      null,     @watershield ) 
        + dbo.fn_data2cdata(N'node', N'fishing',          null,     @fishing )
        + dbo.fn_data2cdata(N'node',  N'alt_name',        null,     @alt_name )
        + CASE WHEN NULLIF(@vals, '') IS NULL THEN '' ELSE '<node name="MLI">' + @vals + '</node>' END
        + N'<tributary>' + dbo.fn_xml_tributary(@lake_id , 0) + N'</tributary>'
        + N'<fish>' + @fish + N'</fish>'
		+ N'<science>' + @science + N'</science>'
		+ N'<fishspot>' + @fishspot + N'</fishspot>'
        + '</root>';
    INSERT INTO @rst 
        SELECT @blob, (SELECT TOP 1 lake_image_pic FROM dbo.lake_image WHERE lake_image_ownerid = @lake_id) AS lake_image_pic
    RETURN
END
GO

-----------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------
 IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'fn_forecast_plot_json' AND xtype = 'FN')
    DROP function dbo.fn_forecast_plot_json ;
GO


-- provide values for FishTracker.Forecast.Plot.GetJsonPlot
-- select dbo.fn_forecast_plot_json (142266, '4db64c3d-95cc-4e19-85be-c2a46582f813' )
-- select dbo.fn_forecast_plot_json (266745, '4f023204-cdaf-4fae-bf7f-e9319794e8ff' )
CREATE FUNCTION dbo.fn_forecast_plot_json( @sid int, @fish_guid varchar(255) )
RETURNS nvarchar(MAX)
AS
BEGIN
  DECLARE @rst TABLE (dt date, tm float , lvl float , prc float , dis float , tu float);
  DECLARE @TemperatureList varchar(255) = '';
  DECLARE @WaterLevelList  varchar(255) = '';
  DECLARE @DischargeList  varchar(255) = '';
  DECLARE @Precipitation  varchar(255) = '';
  DECLARE @Turbidity  varchar(255) = '';
  DECLARE @DatesList  varchar(255) = '';
  DECLARE @country char(2) = '';
  DECLARE @state nvarchar(255) = '';
  DECLARE @lakeid uniqueidentifier;
  DECLARE @start date = DATEADD( DAY, -15, GETDATE());
  DECLARE @end date = DATEADD( DAY,  7, GETDATE());
  DECLARE @mli varchar(64), @WaterStation uniqueidentifier 
  SELECT TOP 1 @mli = MLI, @WaterStation = id, @country = country, @lakeid = lakeid,@state = [state]
	FROM WaterStation WITH (NOLOCK) WHERE sid = @sid;
  INSERT INTO @rst (dt) SELECT * from dbo.GetDatePeriod( @start, @end );
  DECLARE @fishName sysname = (SELECT fish_name FROM fish WHERE fish_id = @fish_guid);
  DECLARE @WaterStateDate varchar(32) = (SELECT TOP 1 CAST(stamp AS varchar(32)) FROM [WaterData] where mli = @mli ORDER BY stamp DESC);
  -- convert C to F if US
  UPDATE @rst SET tm = CASE WHEN 'US' = @country THEN ( tm * 2 ) + 30 ELSE tm END FROM @rst;

  UPDATE t SET t.tm  = ( CASE WHEN f.dt = CAST(getutcdate() AS DATE) THEN f.air_temperature ELSE f.tmDay END )
    , t.prc = (COALESCE(f.[gpfDay], 0) + COALESCE(f.[gpfNight], 0))/2.0
    FROM @rst t JOIN weather_Forecast f WITH (NOLOCK) ON (CAST(f.dt AS DATE) = t.dt) 
    WHERE f.mli = @mli;
  UPDATE t SET t.lvl = elevation, t.dis = discharge, t.tu = turbidity 
    FROM @rst t JOIN WaterData f WITH (NOLOCK) 
	ON CAST(CAST(f.stamp AS DATE) AS varchar(10)) = CAST(CAST(t.dt AS DATE) AS varchar(10))
    WHERE f.mli = @mli and ( elevation is not null OR discharge is not null);

 -- UPDATE @rst SET lvl = COALESCE(lvl, 99999), prc = COALESCE(prc, 99999), dis = COALESCE(dis, 99999), tu = COALESCE(tu, 99999), tm = COALESCE(tm, 99999)

  SELECT @DatesList =  @DatesList + '","' + LEFT(DATENAME(dw, dt), 3) + ' ' + CAST(DATEPART(DAY, dt) AS varchar(255) ) + '' FROM @rst ORDER BY dt ASC
  SET @DatesList = RIGHT(@DatesList, LEN(@DatesList)-2) + '"'
  
  SELECT @WaterLevelList =  @WaterLevelList + ',' + dbo.fn_get_float_as_string(lvl) + '' FROM @rst ORDER BY dt ASC
  SET @WaterLevelList = RIGHT(@WaterLevelList, LEN(@WaterLevelList)-1)
  
  SELECT @DischargeList =  @DischargeList + ',' + dbo.fn_get_float_as_string(dis) + '' FROM @rst   ORDER BY dt ASC
  SET @DischargeList = RIGHT(@DischargeList, LEN(@DischargeList)-1)
  
  SELECT @Precipitation =  @Precipitation + ',' + dbo.fn_get_float_as_string(prc) + '' FROM @rst ORDER BY dt ASC
  SET @Precipitation = RIGHT(@Precipitation, LEN(@Precipitation)-1)
  
  SELECT @TemperatureList =  @TemperatureList + ',' + dbo.fn_get_float_as_string(tm) + '' FROM @rst ORDER BY dt ASC
  SET @TemperatureList = RIGHT(@TemperatureList, LEN(@TemperatureList)-1)

  SELECT @Turbidity =  @Turbidity + ',' + dbo.fn_get_float_as_string(tu) + '' FROM @rst ORDER BY dt ASC
  SET @Turbidity = RIGHT(@Turbidity, LEN(@Turbidity)-1)

  DECLARE @placeDesc varchar(max) = (SELECT TOP 1 REPLACE(locDesc, '"', '''') FROM WaterStation WITH (NOLOCK) WHERE id = @waterStation);
  IF @placeDesc IS NULL SET @placeDesc = 'unknown'

  DECLARE @result nvarchar(MAX) = N'"place":"' + @placeDesc  + '"'
	+ ', "fish":"' + COALESCE(@fishName, '') + '"'
	+ ', "country":"' + @country + '"'
	+ ', "state":"' + @state + '"'
	+ ', "stamp":"' + @WaterStateDate + '"'
	+ ', "lakeid":"' + CAST(@lakeid as varchar(36)) + '"'
	+ ', "date":['          + @DatesList        + ']'
	+ ', "discharge":['     + @DischargeList   + ']'
	+ ', "precipitation":[' + @Precipitation   + ']'
	+ ', "temperature":['   + @TemperatureList + ']'
	+ ', "turbidity":['     + @Turbidity       + ']'
	+ ', "level":['         + @WaterLevelList  + ']';

  RETURN '{' + @result + '}';
end;
GO

-----------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------
 IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'fn_plot_weather' AND xtype = 'IF')
    DROP function dbo.fn_plot_weather ;
GO

/******
-- Called from FishTracker.Forecast.Plot.LoadPlaceLatLon
-- for 23 row set of data in the range from -15 to +10 days 
-- SELECT * FROM dbo.vw_plot_weather WHERE sid=263810
 *
 * INPUT PARAMETERS:
 *    @sid int        -- station id
 *
 *    Usage:    
         SELECT * FROM dbo.fn_plot_weather(226689)
		-- select top 1 ows  from ows_meteo where ows is not null order by stamp desc
 */
CREATE function dbo.fn_plot_weather(@sid int)
  RETURNS TABLE 
WITH SCHEMABINDING
AS
RETURN
    WITH cte AS 
	(
		SELECT CAST( dt AS DATE) AS dt  FROM dbo.weather_Forecast wf 
        JOIN dbo.WaterStation wt on wt.mli = wf.mli
        WHERE dt >= CAST(DATEADD(DAY, -15, getdate()) AS DATE) AND wt.sid = @sid
	) 
	SELECT  TOP 50 dt,  wind_degree, precipitation, humidity, wind_direction, pressure, temperature_low, temperature_high, wind_max_speed
	      , shortText, longText, icon, sid FROM
    (
    SELECT dt,  wind_degree
    , CAST(ISNULL(rain_today, 0.0) AS INT) AS precipitation
    , humidity, wind_direction
    , ISNULL(ROUND(pressure, 1), 0.0) AS pressure
    , CAST(ROUND(tmLow, 1)  AS INT)   AS temperature_low
    , CAST(ROUND(tmHigh, 1) AS INT)   AS temperature_high
    , CAST(ROUND(wind_max_speed, 1)   AS INT) AS wind_max_speed
    , shortText, longText, icon, wt.sid as sid
      FROM dbo.weather_Forecast wf 
        JOIN dbo.WaterStation wt on wt.mli = wf.mli
        WHERE dt >= CAST(DATEADD(DAY, -15, getdate()) AS DATE) AND wt.sid = @sid
	UNION ALL
	SELECT CAST(q.dt AS DATE) as dt, 0 wind_degree, 0 AS precipitation, 0 humidity, '' wind_direction
	, 0.0 pressure, 0 temperature_low, 0 temperature_high, 0 wind_max_speed, '' shortText, '' longText, null icon, @sid as sid FROM 
		(
		    SELECT CAST(DATEADD(DAY, dt-15, getdate()) AS DATE) as dt FROM (VALUES  (1), (2), (3), (4), (5), (6), (7), (8), (9), (10), (11), (12), (13), (14), (15), (16), (17), (18), (19), (20), (21), (22), (23), (24), (25), (26), (27), (28), (29), (30))  AS x(dt)
		)q
		WHERE q.dt NOT IN (SELECT dt FROM cte )
	)z
	ORDER BY dt ASC
GO

-----------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'fn_lake_state' AND xtype = 'IF')
    DROP function dbo.fn_lake_state;
GO
/*
--- SELECT * FROM dbo.fn_lake_state('0C21DC6B-849C-20C3-CAF9-000CDAA217E3', 3)
--   select * from Lake_State where lake_id = '743a5733-bf0d-11d8-92e2-080020a0f4c9'
*/
CREATE function dbo.fn_lake_state( @lake_id uniqueidentifier,  @month int )
RETURNS  TABLE
  WITH SCHEMABINDING
AS
  RETURN
	SELECT TOP 1 lake_id, lake_name, pH, phosphorus, TDS, Conductivity, Alkalinity, Hardness, Sodium, Chloride
		, Bicarbonate, transparency, oxygen, Salinity, clarity, velocity, water_degree, air_degree, cold_cool, flow_stand
		, Stamp FROM
	(
		SELECT l.lake_id, lake_name, s.Stamp
			 , s.pH, s.phosphorus, TDS, Conductivity, Alkalinity, Hardness, Sodium, Chloride, Bicarbonate
			 , transparency, oxygen, Salinity, clarity, s.velocity, water_degree, air_degree, cold_cool, flow_stand, [month]
			   FROM dbo.Lake_State s JOIN dbo.lake l ON l.lake_id = s.lake_id
			   WHERE l.lake_id = @lake_id AND s.[month] = @month
		UNION ALL  
		SELECT TOP 1 l.lake_id, lake_name, s.Stamp
			 , s.pH, s.phosphorus, TDS, Conductivity, Alkalinity, Hardness, Sodium, Chloride, Bicarbonate
			 , transparency, oxygen, Salinity, clarity, s.velocity, water_degree, air_degree, cold_cool, flow_stand, [month]
			   FROM dbo.Lake_State s JOIN dbo.lake l ON l.lake_id = s.lake_id
			   WHERE l.lake_id = @lake_id ORDER BY stamp DESC
    )x
GO
-----------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------
