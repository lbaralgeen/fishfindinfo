
---  update lake set lake_name = 'West Branch Black Creek', loctype= 32, alt_name='' where lake_id = '11C3F6C7-BD5C-459B-9E17-D53B0EC8BD3C'
-- --  1 - lake, 2 - river,  4 - stream, 8 - pond, 16 - marsh, 32 - backwater, 64 - creek
--  128 - canal, 256 - Estuary, 512 - shore, 1024 - drain, 2048 - ditch, 4096 = Wetland,  8192 - Reservoir,  16384 - Bay,  32468 - See

update lake set Location= 'Cochrane' where lake_id= 'E772A62D-798D-44F4-B8D2-7681FE475EC8' 
update lake set link= 'https://en.wikipedia.org/wiki/Econfina_River' where lake_id= 'D722E283-961F-4A1B-8D80-D77CF4E0BECB' 

update lake set alt_name= 'Little Mud Lake' where lake_id= 'DDEB9B56-0BE3-4014-A9EE-576B18567F5A' 
update lake set alt_name = 'Livingston Reservoir' WHERE lake_name = 'Lake Livingston'
update lake set city = 'Hamilton'   where lake_id= 'F261B483-663B-4AAC-9D0A-B7F4A8344F4B' and state='NY'
update lake set 	[mouth] = 'CC83DC81-ADE8-4E4B-B254-2ABE38FA9F84'  where lake_id= '2DF73123-2448-423E-97CD-00AE5B32045B'
update lake set 	[source] = 'CC83DC81-ADE8-4E4B-B254-2ABE38FA9F84' where lake_id=  '2DF73123-2448-423E-97CD-00AE5B32045B' 
update lake set sourceLat = 39.0352559, sourceLon= -120.2000654 where lake_id=  '71254CE4-2D45-4B11-8438-D36F1AE744E9'
update lake set mouthLat = 44.558583, mouthLon= -74.324512 where lake_id= '3AA3F808-69D1-4B33-B405-09F63C840A67'
update lake set depth= 8.8  where lake_id= '14066B70-6143-469A-BA68-56C5E2FF0919' 
update lake set [locType]= 1  where lake_id= '2E0BA53F-6495-453E-AE6D-4912B997E642' 
update lake set CGNDB= 'FCWZE'  where lake_id= '6596d8e6-d052-11d8-92e2-080020a0f4c9' 
GO
-- 11111111-1111-1111-1111-111111111111
declare @id uniqueidentifier = (select dbo.fn_CvtHexToGuid('0cf03eae849c20c3787748c9f3ad8f1c')  )
insert into lake (lake_id, locType, lake_name, CGNDB) values (@id, 64, N'Big Creek', 'FEUNS')
GO

exec sp_MergeLakes '6681271f-599c-4364-8dd6-afb8f4f501ea',  '10940b08-d053-11d8-92e2-080020a0f4c9'
GO
select * from dbo.SearchLakeList( N'Bear Creek' )   where state='PE'
 
---  update lake set lake_name = 'West Branch Black Creek', loctype= 32, alt_name='' where lake_id = '11C3F6C7-BD5C-459B-9E17-D53B0EC8BD3C'
-- --  1 - lake, 2 - river,  4 - stream, 8 - pond, 16 - marsh, 32 - backwater, 64 - creek
--  128 - canal, 256 - Estuary, 512 - shore, 1024 - drain, 2048 - ditch, 4096 = Wetland,  8192 - Reservoir, 16385 - see

exec dbo.sp_add_lake N'Hunter Face Lake', 1, 'CA', 'ON', N'Kenora'

--  delete from [lake] where sid = (select max(sid) from lake)

delete from lake where lake_id=  '732b762b-b2a7-4dac-8f40-daae4fd50a92' and  not exists (select * from WaterStation where lakeId = lake_id )
GO
 
 declare @id uniqueidentifier = (select dbo.fn_CvtHexToGuid('0c41f627-849c-20c3-3ec4-d7c126f55f76')  )
exec dbo.sp_del_river '266d3663-937d-4c4a-918f-906160ed670f'
GO

 
update m set m.location = null FROm [dbo].[Tributaries] s join [dbo].[Tributaries] m on s.Main_Lake_id = m.Main_Lake_id and s.Lake_id = m.Lake_id
  join lake l on l.lake_id = s.Main_Lake_id
 where s.side = 16 and m.side = 32 and s.district = m.location and l.locType = 8192

 update [Tributaries] set [district] = location, location = null where location = N'York'
 update [Tributaries] set [district] = N'Kuujjuaq', location = null  where location like N'Kuujjuaq; Kuujjuaq' or  district like N'Kuujjuaq; Kuujjuaq'

 update [Tributaries] set [district] = N'Saint-Liguori', location = N'Montcalm'
 where N'0' in (location, [district])
 GO

update lake set lake_name = select  N'Coulée des ' + right(lake_name, len(lake_name)-12)    from lake
 where lake_name like N'Coulée des%'
 GO

exec  sp_sys_update_loc N'Racine; Le Val-Saint-FranÃ§ois', N'Le Val-Saint-François', N'Racine'
GO

exec sp_exchange_latlon '0c1d838c-849c-20c3-d9dd-5fcf9251863c'
 GO

  UPDATE lake SET lake_name = N'Saint-Ubalde; Portneuf', french_name = N'Saint-Ubalde' where lake_name = N'Portneuf'
  GO

 UPDATE lake SET lake_id = dbo.fn_CvtHexToGuid('0c84cef1849c20c3542d5ea3de6770c2') WHERE CGNDB = 'IAFOE'

 select top 5 * from news where news_title like '%anglers seek protection%'
 delete from news where news_id = 'B2374F22-6588-48BF-ACCC-19A40BAEF471'

 update news set country='US' where news_id = 'c97b30a0-484c-4c00-bcc0-fb8ea5bf770e'

  update news set fish1_id='bd6e2615-adcc-4ffd-8870-e3b579be8d91' where news_id =  'd1ea66a7-1b8d-481c-b9d9-85cc4b123aeb'
  update news set fish2_id='a35109a0-63ba-4bf5-8a25-2e7e39b74f6e' where news_id =  '28976225-7dad-4253-8237-009c7abf209e'

    update news set lake_id='E083EDFF-76E3-466F-8F28-CA6F65D31974' where news_id = '50e09e59-1727-493e-99df-a6c88904ea9f'

  update news set news_source='Whig-Standard' where news_id = 'f38d5b5c-d053-11d8-92e2-080020a0f4c9'

    update news set news_title='Fish lost for 14 years found in Bremer River' where news_id = '59aae227-5510-47a6-be70-a7ae24f5c322'

    update news set news_stamp='2004/12/18' where news_id = 'd1ea66a7-1b8d-481c-b9d9-85cc4b123aeb'
GO

 update lake set lake_name = N'Lac Hébert' WHERE lake_name = N'Lac HÃ©bert'

 select * from news where news_title like N'%Sainte-Anne River%'

 select top 10 * from lake where lake_name like N'a%' and Reviewed = 1 order by stamp desc
 GO

 select top 10 lake.lake_name, f.link from lake_fish f join lake on lake.lake_id = f.lake_Id where f.link like N'%248274%'   order by f.stamp desc
 GO

 delete from [dbo].[WaterData] where stamp < '2020/12/10'
 GO
 delete from [dbo].[weather_Forecast]  where dt < '2020/12/10'
 GO
 select top 100  * from [weather_Forecast] order by dt desc

 select top 100 * from vw_plot_weather
 select * from vw_lake where lake_id ='0c368565-849c-20c3-9e30-894176dc241f'