	--  1 - lake/arm/Harbour/Lac, 2 - river/Riviиre,  4 - stream (Brook), 8 - pond, 16 - backwater, 32 - creek
	--  64 - canal/Channel, 128 - Estuary, 256 - Reservoir
	[lat] [float] NOT NULL,

 insert into fish (fish_id, [fish_name], [fish_latin], [created], [family_Id], fish_moon_sensitive, fish_migrate_pattern, fish_ability ) values
 (newid(), 'Haddock', 'Melanogrammus aeglefinus', getdate()
 , (select family_id from [dbo].[fish_family] where [Family_name] = 'Gadidae'), 0, 0, 0 )
GO

update fish set fish_name = 'Atlantic Bonito' where [fish_latin]='Sarda sarda'

 select newid()
 select * from [dbo].[fish_family] where [Family_name] like 'Richardsonius egregius'

  ------------------------------------------
select * from dbo.SearchFishList(' Giant oarfish  ')    -- Bluegill
GO

SELECT TOP 1 CAST(fish_id AS varchar(36)) AS id FROM dbo.SearchFishList('bluegill')

select * from dbo.SearchLakeList( N'Threemile Pond' )  --- where state='ON'
    GO
-- exec dbo.sp_add_lake N'Threemile Pond', 8, 'US', 'ME', N'Kennebec'

exec sp_add_fish_river 'A85EBF22-4AB9-4A91-A14A-CEF6C8E64D97', '1c51be33-f6e4-4124-92eb-ee2849d35938'
	, N'https://www.anglersatlas.com/place/102540/west-kabenung-lake', null, 2, ' ' -- 1 - science documents (high priority), 1- site owner, 2 - paid fishers, 3 - unknown fishers
GO
-- delete from  lake_fish where lake_Id = 'D973E1AD-539C-4EE7-9DAD-0FACFA30ED53' and fish_id = 'F124F917-D11F-4ED9-9B59-863D184CBFED'
-- select * from lake_fish where lake_Id = 'fcdf62d3-f1b3-4715-bfca-78dcf0e3a4c5'

SELECT * FROM dbo.fn_river_view_regulations( '9B879189-67AE-412C-9D67-6082AB3A0846' )

 select * from lake p where [lake_Id] in
(
  select distinct [lakeId] from ( select  [lakeId] from [dbo].[WaterStation] w where [lakeId] <> '00000000-0000-0000-0000-000000000000' and state='ON'  )y
   where not exists (select * from  [dbo].[lake_fish] l where l.[lake_Id] = y.[lakeId])
)

   insert into fish_record (fish_id, lake_id, stamp, angler, weight, length, Girth, lure, link) values
   ( '7d739494-d919-43d6-9b11-25a6b4a28455', 'B9D16868-4A47-4FE6-8A0C-B081A7BA7C79'
   , '1982/05/29', 'Edward Paszkowski', 168, 69, 42
   , '', 'http://www.ofah.org/fishing/ofah-ontario-record-fish-registry#popdown_toggle')
   GO

exec sp_add_regulation 2, 'Kenny, Gladman, Flett, Gooderham and Milne Twps. '
    , '20140101', 'Fri. before 3rd Sat. in May', '', 1  -- Fish sanctuary - no fishing from, 3 include 2 to 1
    , null, 'AFDD80AE-1091-49D8-8794-1B0BC7BA8690', 'http://files.ontario.ca/environment-and-energy/fishing/mnr_e001331.pdf'
GO 

exec sp_add_regulation 2, 'Sisk Twp. ', null, null, '', 2           -- Live fish may not be used as bait or possessed for use as bait. 
    , null, 'D50DB946-B7FB-4958-912C-8671F422254D', 'http://files.ontario.ca/environment-and-energy/fishing/mnr_e001331.pdf'
GO

exec sp_add_regulation 2, ''
    , null, null, '', 4  -- Fish closed
    , null, 'C67F6471-114B-4C99-8957-CDB02C93E9E5', 'https://www.ontario.ca/page/sport-fishing-variation-order-fisheries-management-zone-2'
GO 

exec sp_add_regulation 2, ''
    , null, null, 'Sport License - 2, not more than 1 greater than 56 cm., License Conservation - 1, any size'
    , 8  -- Fish open
    , 'F3C65C73-F913-43B8-9F22-965AB095D13E', '17EF77A2-7ABC-4843-849D-03DB803C26A6', 'https://www.ontario.ca/page/sport-fishing-variation-order-fisheries-management-zone-2'
GO 

-- '2038693F-D38C-43C8-B0CE-4E96B0F9AF7E' small bass
delete from regulations where lake_id = 'BFA25777-8F29-4137-A6F3-AC3BBDF06E62'
update regulations set regulations_code = 4 where  lake_id = '24BD7FE0-0B0D-4445-A404-D3CC37DB052E'
SELECT * FROM vw_regulations 

insert into fish_spot (spot_id, fish_id) values (
 'D19347AB-25AF-4EE1-95D9-662BAF623BE9', '2CFFB500-3E59-4120-9460-055856E9AC5C' )
GO
Log Perch

   delete from [dbo].[fish_general] where fish_id='164b68d4-2b60-49e5-86d3-006dd9f44fcd'
      delete from  [dbo].[fish_Rule] where fish_id='164b68d4-2b60-49e5-86d3-006dd9f44fcd'
      delete from  [dbo].[fish] where fish_id='164b68d4-2b60-49e5-86d3-006dd9f44fcd'
   select * from [dbo].[fish_location] where fish_id='164b68d4-2b60-49e5-86d3-006dd9f44fcd'

