--------------------------------------------------------------------------------------------਍䌀刀䔀䄀吀䔀 吀䄀䈀䰀䔀 圀愀琀攀爀匀琀愀琀椀漀渀ഀഀ
(਍  ऀ椀搀 椀渀琀 一伀吀 一唀䰀䰀 倀刀䤀䴀䄀刀夀 䬀䔀夀 䌀䰀唀匀吀䔀刀䔀䐀Ⰰഀഀ
	[MLI] [varchar](32) NOT NULL,਍ऀ嬀氀漀挀一愀洀攀崀 嬀瘀愀爀挀栀愀爀崀⠀㈀㔀㔀⤀ 一伀吀 一唀䰀䰀Ⰰഀഀ
	[locDesc] [varchar](max) NOT NULL,਍ऀ嬀氀漀挀吀礀瀀攀崀 椀渀琀 一伀吀 一唀䰀䰀Ⰰ         ഀഀ
	--  1 - lake/arm/Harbour/Lac, 2 - river/Riviere,  4 - stream (Brook), 8 - pond, 16 - marsh, 32 - backwater, 64 - creek਍ऀⴀⴀ  ㄀㈀㠀 ⴀ 挀愀渀愀氀⼀䌀栀愀渀渀攀氀Ⰰ ㈀㔀㘀 ⴀ 䔀猀琀甀愀爀礀Ⰰ 㔀㄀㈀ ⴀ 猀栀漀爀攀Ⰰ ㄀　㈀㐀 ⴀ 搀爀愀椀渀Ⰰ ㈀　㐀㠀 ⴀ 漀挀攀愀渀Ⰰ 㐀　㤀㘀 㴀 圀攀琀氀愀渀搀Ⰰ 㠀㄀㤀㈀ ⴀ 刀攀猀攀爀瘀漀椀爀⼀戀愀猀椀渀Ⰰ ㄀㘀㌀㠀㐀 ⴀ 䐀愀洀Ⰰ ㌀㈀㜀㘀㠀 ⴀ 昀愀氀氀猀ഀഀ
	[lat] [float] NOT NULL,਍ऀ嬀氀漀渀崀 嬀昀氀漀愀琀崀 一伀吀 一唀䰀䰀Ⰰഀഀ
	[datum] [varchar](16) NULL,਍ऀ嬀挀爀攀愀琀攀搀崀 嬀搀愀琀攀琀椀洀攀崀 一唀䰀䰀Ⰰഀഀ
	[country] [char](3) NOT NULL,਍ऀ嬀猀琀愀琀攀崀   挀栀愀爀⠀㈀⤀Ⰰഀഀ
    CountyCode int,	਍ऀ嬀挀漀甀渀琀礀䤀搀崀 嬀椀渀琀崀 一伀吀 一唀䰀䰀Ⰰഀഀ
	[county] sysname,਍ऀ愀最攀渀挀礀 猀礀猀渀愀洀攀 搀攀昀愀甀氀琀⠀✀✀⤀Ⰰഀഀ
	[processed] [datetime],਍ऀ搀攀瀀琀栀 昀氀漀愀琀Ⰰ                     ⴀⴀ 洀⸀ഀഀ
	Drainage float,                  -- sq. mi.਍    䌀漀渀琀爀椀戀甀琀椀渀最 昀氀漀愀琀Ⰰ              ⴀⴀ 猀焀⸀ 洀椀⸀ഀഀ
    passed int,਍    甀瀀搀䐀愀琀愀  搀愀琀攀琀椀洀攀ഀഀ
) ਍䜀伀 ഀഀ
਍䄀䰀吀䔀刀 吀䄀䈀䰀䔀 圀愀琀攀爀匀琀愀琀椀漀渀 䄀䐀䐀 䌀伀一匀吀刀䄀䤀一吀 倀䬀开圀愀琀攀爀匀琀愀琀椀漀渀 倀刀䤀䴀䄀刀夀 䬀䔀夀 䌀䰀唀匀吀䔀刀䔀䐀 ⠀䴀䰀䤀⤀ ഀഀ
CREATE NONCLUSTERED INDEX [idx_WaterStation_id] ON WaterStation (id )਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开圀愀琀攀爀匀琀愀琀椀漀渀开氀愀琀崀 伀一 圀愀琀攀爀匀琀愀琀椀漀渀 ⠀氀愀琀 䄀匀䌀 ⤀ 伀一 嬀倀刀䤀䴀䄀刀夀崀ഀഀ
CREATE NONCLUSTERED INDEX [idx_WaterStation_lon] ON WaterStation (lon ASC ) ON [PRIMARY]਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开圀愀琀攀爀匀琀愀琀椀漀渀开猀琀愀琀攀崀 伀一 圀愀琀攀爀匀琀愀琀椀漀渀 ⠀猀琀愀琀攀⤀ഀഀ
CREATE NONCLUSTERED INDEX [idx_WaterStation_county] ON WaterStation (county ASC ) ON [PRIMARY]਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开圀愀琀攀爀匀琀愀琀椀漀渀开挀椀琀礀崀 伀一 圀愀琀攀爀匀琀愀琀椀漀渀 ⠀挀椀琀礀 䄀匀䌀 ⤀ 伀一 嬀倀刀䤀䴀䄀刀夀崀ഀഀ
GO਍ⴀⴀ 猀攀氀攀挀琀 䌀伀唀一吀⠀⨀⤀ 昀爀漀洀 圀愀琀攀爀匀琀愀琀椀漀渀ഀഀ
--------------------------------------------------------------------------------------------਍䤀䘀 䔀堀䤀匀吀匀 ⠀匀䔀䰀䔀䌀吀 ⨀ 䘀刀伀䴀 猀礀猀漀戀樀攀挀琀猀 圀䠀䔀刀䔀 一䄀䴀䔀 㴀 ✀瘀䜀攀琀一攀砀琀圀攀氀氀✀ 䄀一䐀 琀礀瀀攀 㴀 ✀嘀✀⤀ഀഀ
	DROP VIEW dbo.vGetNextWell਍䜀伀ഀഀ
CREATE VIEW vGetNextWell AS਍猀攀氀攀挀琀 琀漀瀀 ㄀ 椀搀Ⰰ 䴀䰀䤀Ⰰ 瀀爀漀挀攀猀猀攀搀Ⰰ 䜀䔀吀唀吀䌀䐀䄀吀䔀⠀⤀ 愀猀 渀漀眀 昀爀漀洀 嬀圀愀琀攀爀匀琀愀琀椀漀渀崀 ഀഀ
  where passed IS NULL AND ( processed is NULL ਍    伀刀 ⠀ 瀀爀漀挀攀猀猀攀搀 㰀 䜀䔀吀唀吀䌀䐀䄀吀䔀⠀⤀ 䄀一䐀 瀀爀漀挀攀猀猀攀搀 㸀 ✀㄀㤀　　　㄀　㄀✀⤀⤀ഀഀ
GO਍ⴀⴀⴀ 匀䔀䰀䔀䌀吀 椀搀Ⰰ 䴀䰀䤀Ⰰ 瀀爀漀挀攀猀猀攀搀Ⰰ 渀漀眀 䘀刀伀䴀 瘀䜀攀琀一攀砀琀圀攀氀氀ഀഀ
--select * from [WaterStation] where passed IS NOT NULL਍ⴀⴀ 猀攀氀攀挀琀 挀漀甀渀琀⠀⨀⤀ 昀爀漀洀 嬀圀愀琀攀爀匀琀愀琀椀漀渀崀 眀栀攀爀攀 瀀爀漀挀攀猀猀攀搀 㴀 ✀㄀㤀　　　㄀　㄀✀ഀഀ
------------------------------------------------------------------------------------------------਍䌀刀䔀䄀吀䔀 吀䄀䈀䰀䔀 䄀䬀唀匀　㔀㌀ഀഀ
(਍ऀ嬀洀氀椀崀 瘀愀爀挀栀愀爀⠀㌀㈀⤀ 一伀吀 一唀䰀䰀Ⰰഀഀ
	stamp datetime NOT NULL,਍ऀ琀攀洀瀀攀爀愀琀甀爀攀    昀氀漀愀琀Ⰰ  ⴀⴀ 吀攀洀瀀攀爀愀琀甀爀攀Ⰰ 眀愀琀攀爀Ⰰ 搀攀最爀攀攀猀 䌀攀氀猀椀甀猀ഀഀ
	conductance    float,  -- Specific conductance, water, unfiltered, microsiemens per centimeter at 25 degrees Celsius ਍ऀ搀椀猀挀栀愀爀最攀      昀氀漀愀琀Ⰰ  ⴀⴀ 䐀椀猀挀栀愀爀最攀Ⰰ 挀甀戀椀挀 昀攀攀琀 瀀攀爀 猀攀挀漀渀搀ഀഀ
	ph             float,  -- pH, water, unfiltered, field, standard units   ਍ऀ琀甀爀戀椀搀椀琀礀      昀氀漀愀琀Ⰰ  ⴀⴀ 甀渀昀椀氀琀攀爀攀搀Ⰰ 洀漀渀漀挀栀爀漀洀攀 渀攀愀爀 椀渀昀爀愀ⴀ爀攀搀 䰀䔀䐀 氀椀最栀琀Ⰰ 㜀㠀　ⴀ㤀　　 渀洀Ⰰ 搀攀琀攀挀琀椀漀渀 愀渀最氀攀 㤀　 ⬀ⴀ㈀⸀㔀 搀攀最爀攀攀猀Ⰰ 昀漀爀洀愀稀椀渀 渀攀瀀栀攀氀漀洀攀琀爀椀挀 甀渀椀琀猀 ⠀䘀一唀⤀ ഀഀ
	oxygen         float,  -- Dissolved oxygen, water, unfiltered, milligrams per liter ਍ऀ瀀爀攀挀椀瀀椀琀愀琀椀漀渀  昀氀漀愀琀Ⰰ  ⴀⴀ 倀爀攀挀椀瀀椀琀愀琀椀漀渀Ⰰ 琀漀琀愀氀Ⰰ 椀渀挀栀攀猀ഀഀ
	velocity       float,਍ऀ愀椀爀  昀氀漀愀琀Ⰰ 挀氀漀甀搀挀漀瘀攀爀  昀氀漀愀琀Ⰰ  瀀爀攀猀猀甀爀攀  昀氀漀愀琀Ⰰ  眀椀渀搀  昀氀漀愀琀Ⰰ 眀椀渀搀搀椀爀  昀氀漀愀琀Ⰰ  栀甀洀椀搀椀琀礀  昀氀漀愀琀Ⰰ  攀氀攀瘀愀琀椀漀渀  昀氀漀愀琀Ⰰഀഀ
	sid bigint identity(53,500) NOT NULL PRIMARY KEY CLUSTERED ਍⤀㬀 ഀഀ
GO਍ഀഀ
SET IDENTITY_INSERT AKUS053 ON਍䜀伀ഀഀ
ALTER TABLE AKUS053 ADD CONSTRAINT CHECK_AKUS053 CHECK((sid % 500) % 53 = 0)਍ⴀⴀ 愀氀琀攀爀 琀愀戀氀攀 䄀䬀唀匀　㔀㌀ 愀搀搀 猀椀搀 戀椀最椀渀琀 椀搀攀渀琀椀琀礀⠀㔀㌀Ⰰ㔀　　⤀ 一伀吀 一唀䰀䰀 倀刀䤀䴀䄀刀夀 䬀䔀夀 䌀䰀唀匀吀䔀刀䔀䐀      ഀഀ
CREATE NONCLUSTERED INDEX [idx_AK_mli] ON AKUS053 (mli ASC)਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_AK_temperature] ON AKUS053 (temperature ASC)਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_AK_turbidity] ON AKUS053 (turbidity ASC)਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_AK_conductance] ON AKUS053 (conductance ASC)਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_AK_stamp] ON AKUS053 (stamp desc) ਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_AK_discharge] ON AKUS053 (discharge ASC)਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_AK_oxygen] ON AKUS053 (oxygen ASC)਍䜀伀ഀഀ
------------------------------------------------------------------------------------------------਍䌀刀䔀䄀吀䔀 吀䄀䈀䰀䔀 䄀䰀唀匀㄀㘀㌀ഀഀ
(਍ऀ嬀洀氀椀崀 瘀愀爀挀栀愀爀⠀㌀㈀⤀ 一伀吀 一唀䰀䰀Ⰰഀഀ
	stamp datetime NOT NULL,਍ऀ琀攀洀瀀攀爀愀琀甀爀攀    昀氀漀愀琀Ⰰ  ⴀⴀ 吀攀洀瀀攀爀愀琀甀爀攀Ⰰ 眀愀琀攀爀Ⰰ 搀攀最爀攀攀猀 䌀攀氀猀椀甀猀ഀഀ
	conductance    float,  -- Specific conductance, water, unfiltered, microsiemens per centimeter at 25 degrees Celsius ਍ऀ搀椀猀挀栀愀爀最攀      昀氀漀愀琀Ⰰ  ⴀⴀ 䐀椀猀挀栀愀爀最攀Ⰰ 挀甀戀椀挀 昀攀攀琀 瀀攀爀 猀攀挀漀渀搀ഀഀ
	ph             float,  -- pH, water, unfiltered, field, standard units   ਍ऀ琀甀爀戀椀搀椀琀礀      昀氀漀愀琀Ⰰ  ⴀⴀ 甀渀昀椀氀琀攀爀攀搀Ⰰ 洀漀渀漀挀栀爀漀洀攀 渀攀愀爀 椀渀昀爀愀ⴀ爀攀搀 䰀䔀䐀 氀椀最栀琀Ⰰ 㜀㠀　ⴀ㤀　　 渀洀Ⰰ 搀攀琀攀挀琀椀漀渀 愀渀最氀攀 㤀　 ⬀ⴀ㈀⸀㔀 搀攀最爀攀攀猀Ⰰ 昀漀爀洀愀稀椀渀 渀攀瀀栀攀氀漀洀攀琀爀椀挀 甀渀椀琀猀 ⠀䘀一唀⤀ ഀഀ
	oxygen         float,  -- Dissolved oxygen, water, unfiltered, milligrams per liter ਍ऀ瀀爀攀挀椀瀀椀琀愀琀椀漀渀  昀氀漀愀琀Ⰰ  ⴀⴀ 倀爀攀挀椀瀀椀琀愀琀椀漀渀Ⰰ 琀漀琀愀氀Ⰰ 椀渀挀栀攀猀ഀഀ
	velocity       float,਍ऀ愀椀爀  昀氀漀愀琀Ⰰ 挀氀漀甀搀挀漀瘀攀爀  昀氀漀愀琀Ⰰ  瀀爀攀猀猀甀爀攀  昀氀漀愀琀Ⰰ  眀椀渀搀  昀氀漀愀琀Ⰰ 眀椀渀搀搀椀爀  昀氀漀愀琀Ⰰ  栀甀洀椀搀椀琀礀  昀氀漀愀琀Ⰰ  攀氀攀瘀愀琀椀漀渀  昀氀漀愀琀Ⰰഀഀ
	sid bigint identity(163,500) NOT NULL PRIMARY KEY CLUSTERED ਍⤀㬀 ഀഀ
GO ਍匀䔀吀 䤀䐀䔀一吀䤀吀夀开䤀一匀䔀刀吀 䄀䰀唀匀㄀㘀㌀ 伀一ഀഀ
GO਍ഀഀ
ALTER TABLE ALUS163 ADD CONSTRAINT CHECK_ALUS163 CHECK((sid % 500) % 163 = 0)਍ⴀⴀ 愀氀琀攀爀 琀愀戀氀攀 䄀䰀唀匀㄀㘀㌀ 愀搀搀 猀椀搀 戀椀最椀渀琀 椀搀攀渀琀椀琀礀⠀㄀㘀㌀Ⰰ㔀　　⤀ 一伀吀 一唀䰀䰀 倀刀䤀䴀䄀刀夀 䬀䔀夀 䌀䰀唀匀吀䔀刀䔀䐀    ഀഀ
   ਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开䄀䰀唀匀㄀㘀㌀开洀氀椀崀 伀一 䄀䰀唀匀㄀㘀㌀ ⠀洀氀椀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开䄀䰀唀匀㄀㘀㌀开琀攀洀瀀攀爀愀琀甀爀攀崀 伀一 䄀䰀唀匀㄀㘀㌀ ⠀琀攀洀瀀攀爀愀琀甀爀攀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开䄀䰀唀匀㄀㘀㌀开琀甀爀戀椀搀椀琀礀崀 伀一 䄀䰀唀匀㄀㘀㌀ ⠀琀甀爀戀椀搀椀琀礀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开䄀䰀唀匀㄀㘀㌀开挀漀渀搀甀挀琀愀渀挀攀崀 伀一 䄀䰀唀匀㄀㘀㌀ ⠀挀漀渀搀甀挀琀愀渀挀攀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开䄀䰀唀匀㄀㘀㌀开猀琀愀洀瀀崀 伀一 䄀䰀唀匀㄀㘀㌀ ⠀猀琀愀洀瀀 䐀䔀匀䌀⤀ ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开䄀䰀唀匀㄀㘀㌀开搀椀猀挀栀愀爀最攀崀 伀一 䄀䰀唀匀㄀㘀㌀ ⠀搀椀猀挀栀愀爀最攀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开䄀䰀唀匀㄀㘀㌀开漀砀礀最攀渀崀 伀一 䄀䰀唀匀㄀㘀㌀ ⠀漀砀礀最攀渀 䄀匀䌀⤀ഀഀ
GO਍ഀഀ
------------------------------------------------------------------------------------------------਍䌀刀䔀䄀吀䔀 吀䄀䈀䰀䔀 吀堀唀匀　　㌀ഀഀ
(਍ऀ嬀洀氀椀崀 瘀愀爀挀栀愀爀⠀㌀㈀⤀ 一伀吀 一唀䰀䰀Ⰰഀഀ
	stamp datetime NOT NULL,਍ऀ琀攀洀瀀攀爀愀琀甀爀攀    昀氀漀愀琀Ⰰ  ⴀⴀ 吀攀洀瀀攀爀愀琀甀爀攀Ⰰ 眀愀琀攀爀Ⰰ 搀攀最爀攀攀猀 䌀攀氀猀椀甀猀ഀഀ
	conductance    float,  -- Specific conductance, water, unfiltered, microsiemens per centimeter at 25 degrees Celsius ਍ऀ搀椀猀挀栀愀爀最攀      昀氀漀愀琀Ⰰ  ⴀⴀ 䐀椀猀挀栀愀爀最攀Ⰰ 挀甀戀椀挀 昀攀攀琀 瀀攀爀 猀攀挀漀渀搀ഀഀ
	ph             float,  -- pH, water, unfiltered, field, standard units   ਍ऀ琀甀爀戀椀搀椀琀礀      昀氀漀愀琀Ⰰ  ⴀⴀ 甀渀昀椀氀琀攀爀攀搀Ⰰ 洀漀渀漀挀栀爀漀洀攀 渀攀愀爀 椀渀昀爀愀ⴀ爀攀搀 䰀䔀䐀 氀椀最栀琀Ⰰ 㜀㠀　ⴀ㤀　　 渀洀Ⰰ 搀攀琀攀挀琀椀漀渀 愀渀最氀攀 㤀　 ⬀ⴀ㈀⸀㔀 搀攀最爀攀攀猀Ⰰ 昀漀爀洀愀稀椀渀 渀攀瀀栀攀氀漀洀攀琀爀椀挀 甀渀椀琀猀 ⠀䘀一唀⤀ ഀഀ
	oxygen         float,  -- Dissolved oxygen, water, unfiltered, milligrams per liter ਍ऀ瀀爀攀挀椀瀀椀琀愀琀椀漀渀  昀氀漀愀琀Ⰰ  ⴀⴀ 倀爀攀挀椀瀀椀琀愀琀椀漀渀Ⰰ 琀漀琀愀氀Ⰰ 椀渀挀栀攀猀ഀഀ
	velocity       float,਍ऀ愀椀爀  昀氀漀愀琀Ⰰ 挀氀漀甀搀挀漀瘀攀爀  昀氀漀愀琀Ⰰ  瀀爀攀猀猀甀爀攀  昀氀漀愀琀Ⰰ  眀椀渀搀  昀氀漀愀琀Ⰰ 眀椀渀搀搀椀爀  昀氀漀愀琀Ⰰ  栀甀洀椀搀椀琀礀  昀氀漀愀琀Ⰰ  攀氀攀瘀愀琀椀漀渀  昀氀漀愀琀ഀഀ
	constraint CK_STATE check ((sid % 500) % 3 = 0),਍ऀ猀椀搀 戀椀最椀渀琀 椀搀攀渀琀椀琀礀⠀㌀Ⰰ㔀　　⤀ 一伀吀 一唀䰀䰀 倀刀䤀䴀䄀刀夀 䬀䔀夀 䌀䰀唀匀吀䔀刀䔀䐀 ഀഀ
); ਍䜀伀ഀഀ
SET IDENTITY_INSERT TXUS003 ON਍䜀伀ഀഀ
--alter table TXUS003 add sid bigint identity(3,500) NOT NULL PRIMARY KEY CLUSTERED਍ഀഀ
ALTER TABLE TXUS003 ADD CONSTRAINT CHECK_TXUS003 CHECK((sid % 500) % 3 = 0)਍䄀䰀吀䔀刀 吀䄀䈀䰀䔀 吀堀唀匀　　㌀ 䄀䐀䐀 䌀伀一匀吀刀䄀䤀一吀 倀䬀开吀堀唀匀　　㌀ 倀刀䤀䴀䄀刀夀 䬀䔀夀 䌀䰀唀匀吀䔀刀䔀䐀 ⠀猀椀搀⤀ഀഀ
਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开吀堀开洀氀椀崀 伀一 吀堀唀匀　　㌀ ⠀洀氀椀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开吀堀开琀攀洀瀀攀爀愀琀甀爀攀崀 伀一 吀堀唀匀　　㌀ ⠀琀攀洀瀀攀爀愀琀甀爀攀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开吀堀开琀甀爀戀椀搀椀琀礀崀 伀一 吀堀唀匀　　㌀ ⠀琀甀爀戀椀搀椀琀礀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开吀堀开挀漀渀搀甀挀琀愀渀挀攀崀 伀一 吀堀唀匀　　㌀ ⠀挀漀渀搀甀挀琀愀渀挀攀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开吀堀开猀琀愀洀瀀崀 伀一 吀堀唀匀　　㌀ ⠀猀琀愀洀瀀 䐀䔀匀䌀⤀ ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开吀堀开搀椀猀挀栀愀爀最攀崀 伀一 吀堀唀匀　　㌀ ⠀搀椀猀挀栀愀爀最攀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开吀堀开漀砀礀最攀渀崀 伀一 吀堀唀匀　　㌀ ⠀漀砀礀最攀渀 䄀匀䌀⤀ഀഀ
GO਍      ഀഀ
INSERT INTO TXUS003(mli, [stamp] , [precipitation]) VALUES ('303227097404504','2014-07-16 20:01:01',0);     ਍ⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀഀഀ
CREATE TABLE KSUS005਍⠀ഀഀ
	[mli] varchar(32) NOT NULL,਍ऀ猀琀愀洀瀀 搀愀琀攀琀椀洀攀 一伀吀 一唀䰀䰀Ⰰഀഀ
	temperature    float,  -- Temperature, water, degrees Celsius਍ऀ挀漀渀搀甀挀琀愀渀挀攀    昀氀漀愀琀Ⰰ  ⴀⴀ 匀瀀攀挀椀昀椀挀 挀漀渀搀甀挀琀愀渀挀攀Ⰰ 眀愀琀攀爀Ⰰ 甀渀昀椀氀琀攀爀攀搀Ⰰ 洀椀挀爀漀猀椀攀洀攀渀猀 瀀攀爀 挀攀渀琀椀洀攀琀攀爀 愀琀 ㈀㔀 搀攀最爀攀攀猀 䌀攀氀猀椀甀猀 ഀഀ
	discharge      float,  -- Discharge, cubic feet per second਍ऀ瀀栀             昀氀漀愀琀Ⰰ  ⴀⴀ 瀀䠀Ⰰ 眀愀琀攀爀Ⰰ 甀渀昀椀氀琀攀爀攀搀Ⰰ 昀椀攀氀搀Ⰰ 猀琀愀渀搀愀爀搀 甀渀椀琀猀   ഀഀ
	turbidity      float,  -- unfiltered, monochrome near infra-red LED light, 780-900 nm, detection angle 90 +-2.5 degrees, formazin nephelometric units (FNU) ਍ऀ漀砀礀最攀渀         昀氀漀愀琀Ⰰ  ⴀⴀ 䐀椀猀猀漀氀瘀攀搀 漀砀礀最攀渀Ⰰ 眀愀琀攀爀Ⰰ 甀渀昀椀氀琀攀爀攀搀Ⰰ 洀椀氀氀椀最爀愀洀猀 瀀攀爀 氀椀琀攀爀 ഀഀ
	precipitation  float,  -- Precipitation, total, inches਍ऀ瘀攀氀漀挀椀琀礀       昀氀漀愀琀Ⰰഀഀ
	air  float, cloudcover  float,  pressure  float,  wind  float, winddir  float,  humidity  float,  elevation  float,਍ऀ猀椀搀 戀椀最椀渀琀 椀搀攀渀琀椀琀礀⠀㔀Ⰰ㔀　　⤀ 一伀吀 一唀䰀䰀 倀刀䤀䴀䄀刀夀 䬀䔀夀 䌀䰀唀匀吀䔀刀䔀䐀 ഀഀ
);਍ ഀഀ
GO਍匀䔀吀 䤀䐀䔀一吀䤀吀夀开䤀一匀䔀刀吀 䬀匀唀匀　　㔀 伀一ഀഀ
GO਍䄀䰀吀䔀刀 吀䄀䈀䰀䔀 䬀匀唀匀　　㔀 䄀䐀䐀 䌀伀一匀吀刀䄀䤀一吀 䌀䠀䔀䌀䬀开䬀匀唀匀　　㔀 䌀䠀䔀䌀䬀⠀⠀猀椀搀 ─ 㔀　　⤀ ─ 㔀 㴀 　⤀ഀഀ
GO਍ⴀⴀ愀氀琀攀爀 琀愀戀氀攀 䬀匀唀匀　　㔀 愀搀搀 猀椀搀 戀椀最椀渀琀 椀搀攀渀琀椀琀礀⠀㔀Ⰰ㔀　　⤀ 一伀吀 一唀䰀䰀 倀刀䤀䴀䄀刀夀 䬀䔀夀 䌀䰀唀匀吀䔀刀䔀䐀   ഀഀ
CREATE NONCLUSTERED INDEX [idx_KS_mli] ON KSUS005 (mli ASC)਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_KS_temperature] ON KSUS005 (temperature ASC)਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_KS_turbidity] ON KSUS005 (turbidity ASC)਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_KS_conductance] ON KSUS005 (conductance ASC)਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_KS_stamp] ON KSUS005 (stamp DESC) ਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_KS_discharge] ON KSUS005 (discharge ASC)਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_KS_oxygen] ON KSUS005 (oxygen ASC)਍䜀伀ഀഀ
------------------------------------------------------------------------------------------------਍䌀刀䔀䄀吀䔀 吀䄀䈀䰀䔀 倀䄀唀匀　　㜀ഀഀ
(਍ऀ嬀洀氀椀崀 瘀愀爀挀栀愀爀⠀㌀㈀⤀ 一伀吀 一唀䰀䰀Ⰰഀഀ
	stamp datetime NOT NULL,਍ऀ琀攀洀瀀攀爀愀琀甀爀攀    昀氀漀愀琀Ⰰ  ⴀⴀ 吀攀洀瀀攀爀愀琀甀爀攀Ⰰ 眀愀琀攀爀Ⰰ 搀攀最爀攀攀猀 䌀攀氀猀椀甀猀ഀഀ
	conductance    float,  -- Specific conductance, water, unfiltered, microsiemens per centimeter at 25 degrees Celsius ਍ऀ搀椀猀挀栀愀爀最攀      昀氀漀愀琀Ⰰ  ⴀⴀ 䐀椀猀挀栀愀爀最攀Ⰰ 挀甀戀椀挀 昀攀攀琀 瀀攀爀 猀攀挀漀渀搀ഀഀ
	ph             float,  -- pH, water, unfiltered, field, standard units   ਍ऀ琀甀爀戀椀搀椀琀礀      昀氀漀愀琀Ⰰ  ⴀⴀ 甀渀昀椀氀琀攀爀攀搀Ⰰ 洀漀渀漀挀栀爀漀洀攀 渀攀愀爀 椀渀昀爀愀ⴀ爀攀搀 䰀䔀䐀 氀椀最栀琀Ⰰ 㜀㠀　ⴀ㤀　　 渀洀Ⰰ 搀攀琀攀挀琀椀漀渀 愀渀最氀攀 㤀　 ⬀ⴀ㈀⸀㔀 搀攀最爀攀攀猀Ⰰ 昀漀爀洀愀稀椀渀 渀攀瀀栀攀氀漀洀攀琀爀椀挀 甀渀椀琀猀 ⠀䘀一唀⤀ ഀഀ
	oxygen         float,  -- Dissolved oxygen, water, unfiltered, milligrams per liter ਍ऀ瀀爀攀挀椀瀀椀琀愀琀椀漀渀  昀氀漀愀琀Ⰰ  ⴀⴀ 倀爀攀挀椀瀀椀琀愀琀椀漀渀Ⰰ 琀漀琀愀氀Ⰰ 椀渀挀栀攀猀ഀഀ
	velocity       float,਍ऀ愀椀爀  昀氀漀愀琀Ⰰ 挀氀漀甀搀挀漀瘀攀爀  昀氀漀愀琀Ⰰ  瀀爀攀猀猀甀爀攀  昀氀漀愀琀Ⰰ  眀椀渀搀  昀氀漀愀琀Ⰰ 眀椀渀搀搀椀爀  昀氀漀愀琀Ⰰ  栀甀洀椀搀椀琀礀  昀氀漀愀琀Ⰰ  攀氀攀瘀愀琀椀漀渀  昀氀漀愀琀Ⰰഀഀ
	sid bigint identity(7,500) NOT NULL PRIMARY KEY CLUSTERED ਍⤀㬀 ഀഀ
GO਍匀䔀吀 䤀䐀䔀一吀䤀吀夀开䤀一匀䔀刀吀 倀䄀唀匀　　㜀 伀一ഀഀ
GO਍䄀䰀吀䔀刀 吀䄀䈀䰀䔀 倀䄀唀匀　　㜀 䄀䐀䐀 䌀伀一匀吀刀䄀䤀一吀 䌀䠀䔀䌀䬀开倀䄀唀匀　　㜀 䌀䠀䔀䌀䬀⠀⠀猀椀搀 ─ 㔀　　⤀ ─ 㜀 㴀 　⤀ഀഀ
--alter table PAUS007 add sid bigint identity(7,500) NOT NULL PRIMARY KEY CLUSTERED   ਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开倀䄀开洀氀椀崀 伀一 倀䄀唀匀　　㜀 ⠀洀氀椀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开倀䄀开琀攀洀瀀攀爀愀琀甀爀攀崀 伀一 倀䄀唀匀　　㜀 ⠀琀攀洀瀀攀爀愀琀甀爀攀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开倀䄀开琀甀爀戀椀搀椀琀礀崀 伀一 倀䄀唀匀　　㜀 ⠀琀甀爀戀椀搀椀琀礀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开倀䄀开挀漀渀搀甀挀琀愀渀挀攀崀 伀一 倀䄀唀匀　　㜀 ⠀挀漀渀搀甀挀琀愀渀挀攀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开倀䄀开猀琀愀洀瀀崀 伀一 倀䄀唀匀　　㜀 ⠀猀琀愀洀瀀 䐀䔀匀䌀⤀ ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开倀䄀开搀椀猀挀栀愀爀最攀崀 伀一 倀䄀唀匀　　㜀 ⠀搀椀猀挀栀愀爀最攀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开倀䄀开漀砀礀最攀渀崀 伀一 倀䄀唀匀　　㜀 ⠀漀砀礀最攀渀 䄀匀䌀⤀ഀഀ
GO ਍ⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀഀഀ
CREATE TABLE WIUS011਍⠀ഀഀ
	[mli] varchar(32) NOT NULL,਍ऀ猀琀愀洀瀀 搀愀琀攀琀椀洀攀 一伀吀 一唀䰀䰀Ⰰഀഀ
	temperature    float,  -- Temperature, water, degrees Celsius਍ऀ挀漀渀搀甀挀琀愀渀挀攀    昀氀漀愀琀Ⰰ  ⴀⴀ 匀瀀攀挀椀昀椀挀 挀漀渀搀甀挀琀愀渀挀攀Ⰰ 眀愀琀攀爀Ⰰ 甀渀昀椀氀琀攀爀攀搀Ⰰ 洀椀挀爀漀猀椀攀洀攀渀猀 瀀攀爀 挀攀渀琀椀洀攀琀攀爀 愀琀 ㈀㔀 搀攀最爀攀攀猀 䌀攀氀猀椀甀猀 ഀഀ
	discharge      float,  -- Discharge, cubic feet per second਍ऀ瀀栀             昀氀漀愀琀Ⰰ  ⴀⴀ 瀀䠀Ⰰ 眀愀琀攀爀Ⰰ 甀渀昀椀氀琀攀爀攀搀Ⰰ 昀椀攀氀搀Ⰰ 猀琀愀渀搀愀爀搀 甀渀椀琀猀   ഀഀ
	turbidity      float,  -- unfiltered, monochrome near infra-red LED light, 780-900 nm, detection angle 90 +-2.5 degrees, formazin nephelometric units (FNU) ਍ऀ漀砀礀最攀渀         昀氀漀愀琀Ⰰ  ⴀⴀ 䐀椀猀猀漀氀瘀攀搀 漀砀礀最攀渀Ⰰ 眀愀琀攀爀Ⰰ 甀渀昀椀氀琀攀爀攀搀Ⰰ 洀椀氀氀椀最爀愀洀猀 瀀攀爀 氀椀琀攀爀 ഀഀ
	precipitation  float,  -- Precipitation, total, inches਍ऀ瘀攀氀漀挀椀琀礀       昀氀漀愀琀Ⰰഀഀ
	air  float, cloudcover  float,  pressure  float,  wind  float, winddir  float,  humidity  float,  elevation  float,਍ऀ猀椀搀 戀椀最椀渀琀 椀搀攀渀琀椀琀礀⠀㄀㄀Ⰰ㔀　　⤀ 一伀吀 一唀䰀䰀 倀刀䤀䴀䄀刀夀 䬀䔀夀 䌀䰀唀匀吀䔀刀䔀䐀 ഀഀ
);਍ഀഀ
GO਍匀䔀吀 䤀䐀䔀一吀䤀吀夀开䤀一匀䔀刀吀 圀䤀唀匀　㄀㄀ 伀一ഀഀ
਍䄀䰀吀䔀刀 吀䄀䈀䰀䔀 圀䤀唀匀　㄀㄀ 䄀䐀䐀 䌀伀一匀吀刀䄀䤀一吀 䌀䠀䔀䌀䬀开圀䤀唀匀　㄀㄀ 䌀䠀䔀䌀䬀⠀⠀猀椀搀 ─ 㔀　　⤀ ─ ㄀㄀ 㴀 　⤀ഀഀ
-- alter table WIUS011 add sid bigint identity(11,500) NOT NULL PRIMARY KEY CLUSTERED  ਍䜀伀  ഀഀ
CREATE NONCLUSTERED INDEX [idx_WI_mli] ON WIUS011 (mli ASC)਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_WI_temperature] ON WIUS011 (temperature ASC)਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_WI_turbidity] ON WIUS011 (turbidity ASC)਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_WI_conductance] ON WIUS011 (conductance ASC)਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_WI_stamp] ON WIUS011 (stamp DESC) ਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_WI_discharge] ON WIUS011 (discharge ASC)਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_WI_oxygen] ON WIUS011 (oxygen ASC)਍䜀伀ഀഀ
------------------------------------------------------------------------------------------------਍䌀刀䔀䄀吀䔀 吀䄀䈀䰀䔀 䐀䔀唀匀　㄀㌀ഀഀ
(਍ऀ嬀洀氀椀崀 瘀愀爀挀栀愀爀⠀㌀㈀⤀ 一伀吀 一唀䰀䰀Ⰰഀഀ
	stamp datetime NOT NULL,਍ऀ琀攀洀瀀攀爀愀琀甀爀攀    昀氀漀愀琀Ⰰ  ⴀⴀ 吀攀洀瀀攀爀愀琀甀爀攀Ⰰ 眀愀琀攀爀Ⰰ 搀攀最爀攀攀猀 䌀攀氀猀椀甀猀ഀഀ
	conductance    float,  -- Specific conductance, water, unfiltered, microsiemens per centimeter at 25 degrees Celsius ਍ऀ搀椀猀挀栀愀爀最攀      昀氀漀愀琀Ⰰ  ⴀⴀ 䐀椀猀挀栀愀爀最攀Ⰰ 挀甀戀椀挀 昀攀攀琀 瀀攀爀 猀攀挀漀渀搀ഀഀ
	ph             float,  -- pH, water, unfiltered, field, standard units   ਍ऀ琀甀爀戀椀搀椀琀礀      昀氀漀愀琀Ⰰ  ⴀⴀ 甀渀昀椀氀琀攀爀攀搀Ⰰ 洀漀渀漀挀栀爀漀洀攀 渀攀愀爀 椀渀昀爀愀ⴀ爀攀搀 䰀䔀䐀 氀椀最栀琀Ⰰ 㜀㠀　ⴀ㤀　　 渀洀Ⰰ 搀攀琀攀挀琀椀漀渀 愀渀最氀攀 㤀　 ⬀ⴀ㈀⸀㔀 搀攀最爀攀攀猀Ⰰ 昀漀爀洀愀稀椀渀 渀攀瀀栀攀氀漀洀攀琀爀椀挀 甀渀椀琀猀 ⠀䘀一唀⤀ ഀഀ
	oxygen         float,  -- Dissolved oxygen, water, unfiltered, milligrams per liter ਍ऀ瀀爀攀挀椀瀀椀琀愀琀椀漀渀  昀氀漀愀琀Ⰰ  ⴀⴀ 倀爀攀挀椀瀀椀琀愀琀椀漀渀Ⰰ 琀漀琀愀氀Ⰰ 椀渀挀栀攀猀ഀഀ
	velocity       float,਍ऀ愀椀爀  昀氀漀愀琀Ⰰ 挀氀漀甀搀挀漀瘀攀爀  昀氀漀愀琀Ⰰ  瀀爀攀猀猀甀爀攀  昀氀漀愀琀Ⰰ  眀椀渀搀  昀氀漀愀琀Ⰰ 眀椀渀搀搀椀爀  昀氀漀愀琀Ⰰ  栀甀洀椀搀椀琀礀  昀氀漀愀琀Ⰰ  攀氀攀瘀愀琀椀漀渀  昀氀漀愀琀Ⰰഀഀ
	sid bigint identity(13,500) NOT NULL PRIMARY KEY CLUSTERED ਍⤀㬀 ഀഀ
GO਍匀䔀吀 䤀䐀䔀一吀䤀吀夀开䤀一匀䔀刀吀 䐀䔀唀匀　㄀㌀ 伀一ഀഀ
਍䄀䰀吀䔀刀 吀䄀䈀䰀䔀 䐀䔀唀匀　㄀㌀ 䄀䐀䐀 䌀伀一匀吀刀䄀䤀一吀 䌀䠀䔀䌀䬀开䐀䔀唀匀　㄀㌀ 䌀䠀䔀䌀䬀⠀⠀猀椀搀 ─ 㔀　　⤀ ─ ㄀㌀ 㴀 　⤀ഀഀ
-- alter table DEUS013 add sid bigint identity(13,500) NOT NULL PRIMARY KEY CLUSTERED  ਍䜀伀 ഀഀ
CREATE NONCLUSTERED INDEX [idx_DE_mli] ON DEUS013 (mli ASC)਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_DE_temperature] ON DEUS013 (temperature ASC)਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_DE_turbidity] ON DEUS013 (turbidity ASC)਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_DE_conductance] ON DEUS013 (conductance ASC)਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_DE_stamp] ON DEUS013 (stamp DESC) ਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_DE_discharge] ON DEUS013 (discharge ASC)਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_DE_oxygen] ON DEUS013 (oxygen ASC)਍䜀伀ഀഀ
------------------------------------------------------------------------------------------------਍䌀刀䔀䄀吀䔀 吀䄀䈀䰀䔀 䤀一唀匀　㄀㜀ഀഀ
(਍ऀ嬀洀氀椀崀 瘀愀爀挀栀愀爀⠀㌀㈀⤀ 一伀吀 一唀䰀䰀Ⰰഀഀ
	stamp datetime NOT NULL,਍ऀ琀攀洀瀀攀爀愀琀甀爀攀    昀氀漀愀琀Ⰰ  ⴀⴀ 吀攀洀瀀攀爀愀琀甀爀攀Ⰰ 眀愀琀攀爀Ⰰ 搀攀最爀攀攀猀 䌀攀氀猀椀甀猀ഀഀ
	conductance    float,  -- Specific conductance, water, unfiltered, microsiemens per centimeter at 25 degrees Celsius ਍ऀ搀椀猀挀栀愀爀最攀      昀氀漀愀琀Ⰰ  ⴀⴀ 䐀椀猀挀栀愀爀最攀Ⰰ 挀甀戀椀挀 昀攀攀琀 瀀攀爀 猀攀挀漀渀搀ഀഀ
	ph             float,  -- pH, water, unfiltered, field, standard units   ਍ऀ琀甀爀戀椀搀椀琀礀      昀氀漀愀琀Ⰰ  ⴀⴀ 甀渀昀椀氀琀攀爀攀搀Ⰰ 洀漀渀漀挀栀爀漀洀攀 渀攀愀爀 椀渀昀爀愀ⴀ爀攀搀 䰀䔀䐀 氀椀最栀琀Ⰰ 㜀㠀　ⴀ㤀　　 渀洀Ⰰ 搀攀琀攀挀琀椀漀渀 愀渀最氀攀 㤀　 ⬀ⴀ㈀⸀㔀 搀攀最爀攀攀猀Ⰰ 昀漀爀洀愀稀椀渀 渀攀瀀栀攀氀漀洀攀琀爀椀挀 甀渀椀琀猀 ⠀䘀一唀⤀ ഀഀ
	oxygen         float,  -- Dissolved oxygen, water, unfiltered, milligrams per liter ਍ऀ瀀爀攀挀椀瀀椀琀愀琀椀漀渀  昀氀漀愀琀Ⰰ  ⴀⴀ 倀爀攀挀椀瀀椀琀愀琀椀漀渀Ⰰ 琀漀琀愀氀Ⰰ 椀渀挀栀攀猀ഀഀ
	velocity       float,਍ऀ愀椀爀  昀氀漀愀琀Ⰰ 挀氀漀甀搀挀漀瘀攀爀  昀氀漀愀琀Ⰰ  瀀爀攀猀猀甀爀攀  昀氀漀愀琀Ⰰ  眀椀渀搀  昀氀漀愀琀Ⰰ 眀椀渀搀搀椀爀  昀氀漀愀琀Ⰰ  栀甀洀椀搀椀琀礀  昀氀漀愀琀Ⰰ  攀氀攀瘀愀琀椀漀渀  昀氀漀愀琀Ⰰഀഀ
	sid bigint identity(17,500) NOT NULL PRIMARY KEY CLUSTERED ਍⤀㬀 ഀഀ
GO਍匀䔀吀 䤀䐀䔀一吀䤀吀夀开䤀一匀䔀刀吀 䤀一唀匀　㄀㜀 伀一ഀഀ
਍䜀伀ഀഀ
ALTER TABLE INUS017 ADD CONSTRAINT CHECK_INUS017 CHECK((sid % 500) % 17 = 0)਍ⴀⴀ 愀氀琀攀爀 琀愀戀氀攀 䤀一唀匀　㄀㜀 愀搀搀 猀椀搀 戀椀最椀渀琀 椀搀攀渀琀椀琀礀⠀㄀㜀Ⰰ㔀　　⤀ 一伀吀 一唀䰀䰀 倀刀䤀䴀䄀刀夀 䬀䔀夀 䌀䰀唀匀吀䔀刀䔀䐀  ഀഀ
CREATE NONCLUSTERED INDEX [idx_IN_mli] ON INUS017 (mli ASC)਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_IN_temperature] ON INUS017 (temperature ASC)਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_IN_turbidity] ON INUS017 (turbidity ASC)਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_IN_conductance] ON INUS017 (conductance ASC)਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_IN_stamp] ON INUS017 (stamp desc) ਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_IN_discharge] ON INUS017 (discharge ASC)਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_IN_oxygen] ON INUS017 (oxygen ASC)਍䜀伀 ഀഀ
------------------------------------------------------------------------------------------------਍䌀刀䔀䄀吀䔀 吀䄀䈀䰀䔀 䤀䰀唀匀　㄀㤀ഀഀ
(਍ऀ嬀洀氀椀崀 瘀愀爀挀栀愀爀⠀㌀㈀⤀ 一伀吀 一唀䰀䰀Ⰰഀഀ
	stamp datetime NOT NULL,਍ऀ琀攀洀瀀攀爀愀琀甀爀攀    昀氀漀愀琀Ⰰ  ⴀⴀ 吀攀洀瀀攀爀愀琀甀爀攀Ⰰ 眀愀琀攀爀Ⰰ 搀攀最爀攀攀猀 䌀攀氀猀椀甀猀ഀഀ
	conductance    float,  -- Specific conductance, water, unfiltered, microsiemens per centimeter at 25 degrees Celsius ਍ऀ搀椀猀挀栀愀爀最攀      昀氀漀愀琀Ⰰ  ⴀⴀ 䐀椀猀挀栀愀爀最攀Ⰰ 挀甀戀椀挀 昀攀攀琀 瀀攀爀 猀攀挀漀渀搀ഀഀ
	ph             float,  -- pH, water, unfiltered, field, standard units   ਍ऀ琀甀爀戀椀搀椀琀礀      昀氀漀愀琀Ⰰ  ⴀⴀ 甀渀昀椀氀琀攀爀攀搀Ⰰ 洀漀渀漀挀栀爀漀洀攀 渀攀愀爀 椀渀昀爀愀ⴀ爀攀搀 䰀䔀䐀 氀椀最栀琀Ⰰ 㜀㠀　ⴀ㤀　　 渀洀Ⰰ 搀攀琀攀挀琀椀漀渀 愀渀最氀攀 㤀　 ⬀ⴀ㈀⸀㔀 搀攀最爀攀攀猀Ⰰ 昀漀爀洀愀稀椀渀 渀攀瀀栀攀氀漀洀攀琀爀椀挀 甀渀椀琀猀 ⠀䘀一唀⤀ ഀഀ
	oxygen         float,  -- Dissolved oxygen, water, unfiltered, milligrams per liter ਍ⴀⴀऀ瀀爀攀挀椀瀀椀琀愀琀椀漀渀  昀氀漀愀琀Ⰰ  ⴀⴀ 倀爀攀挀椀瀀椀琀愀琀椀漀渀Ⰰ 琀漀琀愀氀Ⰰ 椀渀挀栀攀猀ഀഀ
--	velocity       float,਍ⴀⴀऀ愀椀爀  昀氀漀愀琀Ⰰ 挀氀漀甀搀挀漀瘀攀爀  昀氀漀愀琀Ⰰ  瀀爀攀猀猀甀爀攀  昀氀漀愀琀Ⰰ  眀椀渀搀  昀氀漀愀琀Ⰰ 眀椀渀搀搀椀爀  昀氀漀愀琀Ⰰ  栀甀洀椀搀椀琀礀  昀氀漀愀琀Ⰰ  攀氀攀瘀愀琀椀漀渀  昀氀漀愀琀Ⰰഀഀ
	sid bigint identity(19,500) NOT NULL PRIMARY KEY CLUSTERED ਍⤀㬀 ഀഀ
GO਍匀䔀吀 䤀䐀䔀一吀䤀吀夀开䤀一匀䔀刀吀 䤀䰀唀匀　㄀㤀 伀一ഀഀ
਍䄀䰀吀䔀刀 吀䄀䈀䰀䔀 䤀䰀唀匀　㄀㤀 䄀䐀䐀 䌀伀一匀吀刀䄀䤀一吀 䌀䠀䔀䌀䬀开䤀䰀唀匀　㄀㤀 䌀䠀䔀䌀䬀⠀⠀猀椀搀 ─ 㔀　　⤀ ─ ㄀㤀 㴀 　⤀ഀഀ
-- alter table ILUS019 add sid bigint identity(19,500) NOT NULL PRIMARY KEY CLUSTERED  ਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开䤀䰀唀匀　㄀㤀开洀氀椀崀 伀一 䤀䰀唀匀　㄀㤀 ⠀洀氀椀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开䤀䰀唀匀　㄀㤀开琀攀洀瀀攀爀愀琀甀爀攀崀 伀一 䤀䰀唀匀　㄀㤀 ⠀琀攀洀瀀攀爀愀琀甀爀攀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开䤀䰀唀匀　㄀㤀开琀甀爀戀椀搀椀琀礀崀 伀一 䤀䰀唀匀　㄀㤀 ⠀琀甀爀戀椀搀椀琀礀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开䤀䰀唀匀　㄀㤀开挀漀渀搀甀挀琀愀渀挀攀崀 伀一 䤀䰀唀匀　㄀㤀 ⠀挀漀渀搀甀挀琀愀渀挀攀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开䤀䰀唀匀　㄀㤀开猀琀愀洀瀀崀 伀一 䤀䰀唀匀　㄀㤀 ⠀猀琀愀洀瀀 搀攀猀挀⤀ ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开䤀䰀唀匀　㄀㤀开搀椀猀挀栀愀爀最攀崀 伀一 䤀䰀唀匀　㄀㤀 ⠀搀椀猀挀栀愀爀最攀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开䤀䰀唀匀　㄀㤀开漀砀礀最攀渀崀 伀一 䤀䰀唀匀　㄀㤀 ⠀漀砀礀最攀渀 䄀匀䌀⤀ഀഀ
GO਍ⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀഀഀ
CREATE TABLE NHUS023਍⠀ഀഀ
	[mli] varchar(32) NOT NULL,਍ऀ猀琀愀洀瀀 搀愀琀攀琀椀洀攀 一伀吀 一唀䰀䰀Ⰰഀഀ
	temperature    float,  -- Temperature, water, degrees Celsius਍ऀ挀漀渀搀甀挀琀愀渀挀攀    昀氀漀愀琀Ⰰ  ⴀⴀ 匀瀀攀挀椀昀椀挀 挀漀渀搀甀挀琀愀渀挀攀Ⰰ 眀愀琀攀爀Ⰰ 甀渀昀椀氀琀攀爀攀搀Ⰰ 洀椀挀爀漀猀椀攀洀攀渀猀 瀀攀爀 挀攀渀琀椀洀攀琀攀爀 愀琀 ㈀㔀 搀攀最爀攀攀猀 䌀攀氀猀椀甀猀 ഀഀ
	discharge      float,  -- Discharge, cubic feet per second਍ऀ瀀栀             昀氀漀愀琀Ⰰ  ⴀⴀ 瀀䠀Ⰰ 眀愀琀攀爀Ⰰ 甀渀昀椀氀琀攀爀攀搀Ⰰ 昀椀攀氀搀Ⰰ 猀琀愀渀搀愀爀搀 甀渀椀琀猀   ഀഀ
	turbidity      float,  -- unfiltered, monochrome near infra-red LED light, 780-900 nm, detection angle 90 +-2.5 degrees, formazin nephelometric units (FNU) ਍ऀ漀砀礀最攀渀         昀氀漀愀琀Ⰰ  ⴀⴀ 䐀椀猀猀漀氀瘀攀搀 漀砀礀最攀渀Ⰰ 眀愀琀攀爀Ⰰ 甀渀昀椀氀琀攀爀攀搀Ⰰ 洀椀氀氀椀最爀愀洀猀 瀀攀爀 氀椀琀攀爀 ഀഀ
	precipitation  float,  -- Precipitation, total, inches਍ऀ瘀攀氀漀挀椀琀礀       昀氀漀愀琀Ⰰഀഀ
	air  float, cloudcover  float,  pressure  float,  wind  float, winddir  float,  humidity  float,  elevation  float,਍ऀ猀椀搀 戀椀最椀渀琀 椀搀攀渀琀椀琀礀⠀㈀㌀Ⰰ㔀　　⤀ 一伀吀 一唀䰀䰀 倀刀䤀䴀䄀刀夀 䬀䔀夀 䌀䰀唀匀吀䔀刀䔀䐀 ഀഀ
); ਍䜀伀ഀഀ
SET IDENTITY_INSERT NHUS023 ON਍䜀伀 ഀഀ
ALTER TABLE NHUS023 ADD CONSTRAINT CHECK_NHUS023 CHECK((sid % 500) % 23 = 0)਍ⴀⴀ 愀氀琀攀爀 琀愀戀氀攀 一䠀唀匀　㈀㌀ 愀搀搀 猀椀搀 戀椀最椀渀琀 椀搀攀渀琀椀琀礀⠀㈀㌀Ⰰ㔀　　⤀ 一伀吀 一唀䰀䰀 倀刀䤀䴀䄀刀夀 䬀䔀夀 䌀䰀唀匀吀䔀刀䔀䐀  ഀഀ
਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开一䠀开开洀氀椀崀 伀一 一䠀唀匀　㈀㌀ ⠀洀氀椀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开一䠀开琀攀洀瀀攀爀愀琀甀爀攀崀 伀一 一䠀唀匀　㈀㌀ ⠀琀攀洀瀀攀爀愀琀甀爀攀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开一䠀开琀甀爀戀椀搀椀琀礀崀 伀一 一䠀唀匀　㈀㌀ ⠀琀甀爀戀椀搀椀琀礀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开一䠀开挀漀渀搀甀挀琀愀渀挀攀崀 伀一 一䠀唀匀　㈀㌀ ⠀挀漀渀搀甀挀琀愀渀挀攀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开一䠀开猀琀愀洀瀀崀 伀一 一䠀唀匀　㈀㌀ ⠀猀琀愀洀瀀 搀攀猀挀⤀ ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开一䠀开搀椀猀挀栀愀爀最攀崀 伀一 一䠀唀匀　㈀㌀ ⠀搀椀猀挀栀愀爀最攀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开一䠀开漀砀礀最攀渀崀 伀一 一䠀唀匀　㈀㌀ ⠀漀砀礀最攀渀 䄀匀䌀⤀ഀഀ
GO ਍ⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀഀഀ
CREATE TABLE MDUS029਍⠀ഀഀ
	[mli] varchar(32) NOT NULL,਍ऀ猀琀愀洀瀀 搀愀琀攀琀椀洀攀 一伀吀 一唀䰀䰀Ⰰഀഀ
	temperature    float,  -- Temperature, water, degrees Celsius਍ऀ挀漀渀搀甀挀琀愀渀挀攀    昀氀漀愀琀Ⰰ  ⴀⴀ 匀瀀攀挀椀昀椀挀 挀漀渀搀甀挀琀愀渀挀攀Ⰰ 眀愀琀攀爀Ⰰ 甀渀昀椀氀琀攀爀攀搀Ⰰ 洀椀挀爀漀猀椀攀洀攀渀猀 瀀攀爀 挀攀渀琀椀洀攀琀攀爀 愀琀 ㈀㔀 搀攀最爀攀攀猀 䌀攀氀猀椀甀猀 ഀഀ
	discharge      float,  -- Discharge, cubic feet per second਍ऀ瀀栀             昀氀漀愀琀Ⰰ  ⴀⴀ 瀀䠀Ⰰ 眀愀琀攀爀Ⰰ 甀渀昀椀氀琀攀爀攀搀Ⰰ 昀椀攀氀搀Ⰰ 猀琀愀渀搀愀爀搀 甀渀椀琀猀   ഀഀ
	turbidity      float,  -- unfiltered, monochrome near infra-red LED light, 780-900 nm, detection angle 90 +-2.5 degrees, formazin nephelometric units (FNU) ਍ऀ漀砀礀最攀渀         昀氀漀愀琀Ⰰ  ⴀⴀ 䐀椀猀猀漀氀瘀攀搀 漀砀礀最攀渀Ⰰ 眀愀琀攀爀Ⰰ 甀渀昀椀氀琀攀爀攀搀Ⰰ 洀椀氀氀椀最爀愀洀猀 瀀攀爀 氀椀琀攀爀 ഀഀ
	precipitation  float,  -- Precipitation, total, inches਍ऀ瘀攀氀漀挀椀琀礀       昀氀漀愀琀Ⰰഀഀ
	air  float, cloudcover  float,  pressure  float,  wind  float, winddir  float,  humidity  float,  elevation  float,਍ऀ猀椀搀 戀椀最椀渀琀 椀搀攀渀琀椀琀礀⠀㈀㤀Ⰰ㔀　　⤀ 一伀吀 一唀䰀䰀 倀刀䤀䴀䄀刀夀 䬀䔀夀 䌀䰀唀匀吀䔀刀䔀䐀 ഀഀ
); ਍䜀伀ഀഀ
SET IDENTITY_INSERT MDUS029 ON਍ഀഀ
ALTER TABLE MDUS029 ADD CONSTRAINT CHECK_MDUS029 CHECK((sid % 500) % 29 = 0)਍ⴀⴀ 愀氀琀攀爀 琀愀戀氀攀 䴀䐀唀匀　㈀㤀 愀搀搀 猀椀搀 戀椀最椀渀琀 椀搀攀渀琀椀琀礀⠀㈀㤀Ⰰ㔀　　⤀ 一伀吀 一唀䰀䰀 倀刀䤀䴀䄀刀夀 䬀䔀夀 䌀䰀唀匀吀䔀刀䔀䐀ഀഀ
GO ਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开䴀䐀唀匀　㈀㤀开洀氀椀崀 伀一 䴀䐀唀匀　㈀㤀 ⠀洀氀椀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开䴀䐀唀匀　㈀㤀开琀攀洀瀀攀爀愀琀甀爀攀崀 伀一 䴀䐀唀匀　㈀㤀 ⠀琀攀洀瀀攀爀愀琀甀爀攀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开䴀䐀唀匀　㈀㤀开琀甀爀戀椀搀椀琀礀崀 伀一 䴀䐀唀匀　㈀㤀 ⠀琀甀爀戀椀搀椀琀礀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开䴀䐀唀匀　㈀㤀开挀漀渀搀甀挀琀愀渀挀攀崀 伀一 䴀䐀唀匀　㈀㤀 ⠀挀漀渀搀甀挀琀愀渀挀攀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开䴀䐀唀匀　㈀㤀开猀琀愀洀瀀崀 伀一 䴀䐀唀匀　㈀㤀 ⠀猀琀愀洀瀀 搀攀猀挀⤀ ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开䴀䐀唀匀　㈀㤀开搀椀猀挀栀愀爀最攀崀 伀一 䴀䐀唀匀　㈀㤀 ⠀搀椀猀挀栀愀爀最攀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开䴀䐀唀匀　㈀㤀开漀砀礀最攀渀崀 伀一 䴀䐀唀匀　㈀㤀 ⠀漀砀礀最攀渀 䄀匀䌀⤀ഀഀ
GO਍ⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀഀഀ
CREATE TABLE DCUS031਍⠀ഀഀ
	[mli] varchar(32) NOT NULL,਍ऀ猀琀愀洀瀀 搀愀琀攀琀椀洀攀 一伀吀 一唀䰀䰀Ⰰഀഀ
	temperature    float,  -- Temperature, water, degrees Celsius਍ऀ挀漀渀搀甀挀琀愀渀挀攀    昀氀漀愀琀Ⰰ  ⴀⴀ 匀瀀攀挀椀昀椀挀 挀漀渀搀甀挀琀愀渀挀攀Ⰰ 眀愀琀攀爀Ⰰ 甀渀昀椀氀琀攀爀攀搀Ⰰ 洀椀挀爀漀猀椀攀洀攀渀猀 瀀攀爀 挀攀渀琀椀洀攀琀攀爀 愀琀 ㈀㔀 搀攀最爀攀攀猀 䌀攀氀猀椀甀猀 ഀഀ
	discharge      float,  -- Discharge, cubic feet per second਍ऀ瀀栀             昀氀漀愀琀Ⰰ  ⴀⴀ 瀀䠀Ⰰ 眀愀琀攀爀Ⰰ 甀渀昀椀氀琀攀爀攀搀Ⰰ 昀椀攀氀搀Ⰰ 猀琀愀渀搀愀爀搀 甀渀椀琀猀   ഀഀ
	turbidity      float,  -- unfiltered, monochrome near infra-red LED light, 780-900 nm, detection angle 90 +-2.5 degrees, formazin nephelometric units (FNU) ਍ऀ漀砀礀最攀渀         昀氀漀愀琀Ⰰ  ⴀⴀ 䐀椀猀猀漀氀瘀攀搀 漀砀礀最攀渀Ⰰ 眀愀琀攀爀Ⰰ 甀渀昀椀氀琀攀爀攀搀Ⰰ 洀椀氀氀椀最爀愀洀猀 瀀攀爀 氀椀琀攀爀 ഀഀ
	precipitation  float,  -- Precipitation, total, inches਍ऀ瘀攀氀漀挀椀琀礀       昀氀漀愀琀Ⰰഀഀ
	air  float, cloudcover  float,  pressure  float,  wind  float, winddir  float,  humidity  float,  elevation  float,਍ऀ猀椀搀 戀椀最椀渀琀 椀搀攀渀琀椀琀礀⠀㌀㄀Ⰰ㔀　　⤀ 一伀吀 一唀䰀䰀 倀刀䤀䴀䄀刀夀 䬀䔀夀 䌀䰀唀匀吀䔀刀䔀䐀 ഀഀ
);਍䜀伀ഀഀ
SET IDENTITY_INSERT DCUS031 ON਍ ഀഀ
GO਍䄀䰀吀䔀刀 吀䄀䈀䰀䔀 䐀䌀唀匀　㌀㄀ 䄀䐀䐀 䌀伀一匀吀刀䄀䤀一吀 䌀䠀䔀䌀䬀开䐀䌀唀匀　㌀㄀ 䌀䠀䔀䌀䬀⠀⠀猀椀搀 ─ 㔀　　⤀ ─ ㌀㄀ 㴀 　⤀ഀഀ
-- alter table DCUS031 add sid bigint identity(31,500) NOT NULL PRIMARY KEY CLUSTERED਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开䐀䌀唀匀　㌀㄀开洀氀椀崀 伀一 䐀䌀唀匀　㌀㄀ ⠀洀氀椀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开䐀䌀唀匀　㌀㄀开琀攀洀瀀攀爀愀琀甀爀攀崀 伀一 䐀䌀唀匀　㌀㄀ ⠀琀攀洀瀀攀爀愀琀甀爀攀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开䐀䌀唀匀　㌀㄀开琀甀爀戀椀搀椀琀礀崀 伀一 䐀䌀唀匀　㌀㄀ ⠀琀甀爀戀椀搀椀琀礀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开䐀䌀唀匀　㌀㄀开挀漀渀搀甀挀琀愀渀挀攀崀 伀一 䐀䌀唀匀　㌀㄀ ⠀挀漀渀搀甀挀琀愀渀挀攀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开䐀䌀唀匀　㌀㄀开猀琀愀洀瀀崀 伀一 䐀䌀唀匀　㌀㄀ ⠀猀琀愀洀瀀 搀攀猀挀⤀ ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开䐀䌀唀匀　㌀㄀开搀椀猀挀栀愀爀最攀崀 伀一 䐀䌀唀匀　㌀㄀ ⠀搀椀猀挀栀愀爀最攀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开䐀䌀唀匀　㌀㄀开漀砀礀最攀渀崀 伀一 䐀䌀唀匀　㌀㄀ ⠀漀砀礀最攀渀 䄀匀䌀⤀ഀഀ
GO਍ⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀഀഀ
CREATE TABLE COUS037਍⠀ഀഀ
	[mli] varchar(32) NOT NULL,਍ऀ猀琀愀洀瀀 搀愀琀攀琀椀洀攀 一伀吀 一唀䰀䰀Ⰰഀഀ
	temperature    float,  -- Temperature, water, degrees Celsius਍ऀ挀漀渀搀甀挀琀愀渀挀攀    昀氀漀愀琀Ⰰ  ⴀⴀ 匀瀀攀挀椀昀椀挀 挀漀渀搀甀挀琀愀渀挀攀Ⰰ 眀愀琀攀爀Ⰰ 甀渀昀椀氀琀攀爀攀搀Ⰰ 洀椀挀爀漀猀椀攀洀攀渀猀 瀀攀爀 挀攀渀琀椀洀攀琀攀爀 愀琀 ㈀㔀 搀攀最爀攀攀猀 䌀攀氀猀椀甀猀 ഀഀ
	discharge      float,  -- Discharge, cubic feet per second਍ऀ瀀栀             昀氀漀愀琀Ⰰ  ⴀⴀ 瀀䠀Ⰰ 眀愀琀攀爀Ⰰ 甀渀昀椀氀琀攀爀攀搀Ⰰ 昀椀攀氀搀Ⰰ 猀琀愀渀搀愀爀搀 甀渀椀琀猀   ഀഀ
	turbidity      float,  -- unfiltered, monochrome near infra-red LED light, 780-900 nm, detection angle 90 +-2.5 degrees, formazin nephelometric units (FNU) ਍ऀ漀砀礀最攀渀         昀氀漀愀琀Ⰰ  ⴀⴀ 䐀椀猀猀漀氀瘀攀搀 漀砀礀最攀渀Ⰰ 眀愀琀攀爀Ⰰ 甀渀昀椀氀琀攀爀攀搀Ⰰ 洀椀氀氀椀最爀愀洀猀 瀀攀爀 氀椀琀攀爀 ഀഀ
	precipitation  float,  -- Precipitation, total, inches਍ऀ瘀攀氀漀挀椀琀礀       昀氀漀愀琀Ⰰഀഀ
	air  float, cloudcover  float,  pressure  float,  wind  float, winddir  float,  humidity  float,  elevation  float,਍ऀ猀椀搀 戀椀最椀渀琀 椀搀攀渀琀椀琀礀⠀㌀㜀Ⰰ㔀　　⤀ 一伀吀 一唀䰀䰀 倀刀䤀䴀䄀刀夀 䬀䔀夀 䌀䰀唀匀吀䔀刀䔀䐀 ഀഀ
);਍䜀伀ഀഀ
SET IDENTITY_INSERT COUS037 ON਍ ഀഀ
GO਍䄀䰀吀䔀刀 吀䄀䈀䰀䔀 䌀伀唀匀　㌀㜀 䄀䐀䐀 䌀伀一匀吀刀䄀䤀一吀 䌀䠀䔀䌀䬀开䌀伀唀匀　㌀㜀 䌀䠀䔀䌀䬀⠀⠀猀椀搀 ─ 㔀　　⤀ ─ ㌀㜀 㴀 　⤀ഀഀ
-- alter table COUS037 add sid bigint identity(37,500) NOT NULL PRIMARY KEY CLUSTERED     ਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开䤀一开洀氀椀崀 伀一 䌀伀唀匀　㌀㜀 ⠀洀氀椀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开䌀伀开琀攀洀瀀攀爀愀琀甀爀攀崀 伀一 䌀伀唀匀　㌀㜀 ⠀琀攀洀瀀攀爀愀琀甀爀攀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开䌀伀开琀甀爀戀椀搀椀琀礀崀 伀一 䌀伀唀匀　㌀㜀 ⠀琀甀爀戀椀搀椀琀礀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开䌀伀开挀漀渀搀甀挀琀愀渀挀攀崀 伀一 䌀伀唀匀　㌀㜀 ⠀挀漀渀搀甀挀琀愀渀挀攀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开䌀伀开猀琀愀洀瀀崀 伀一 䌀伀唀匀　㌀㜀 ⠀猀琀愀洀瀀 搀攀猀挀⤀ ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开䌀伀开搀椀猀挀栀愀爀最攀崀 伀一 䌀伀唀匀　㌀㜀 ⠀搀椀猀挀栀愀爀最攀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开䌀伀开漀砀礀最攀渀崀 伀一 䌀伀唀匀　㌀㜀 ⠀漀砀礀最攀渀 䄀匀䌀⤀ഀഀ
GO਍ⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀഀഀ
CREATE TABLE MIUS041਍⠀ഀഀ
	[mli] varchar(32) NOT NULL,਍ऀ猀琀愀洀瀀 搀愀琀攀琀椀洀攀 一伀吀 一唀䰀䰀Ⰰഀഀ
	temperature    float,  -- Temperature, water, degrees Celsius਍ऀ挀漀渀搀甀挀琀愀渀挀攀    昀氀漀愀琀Ⰰ  ⴀⴀ 匀瀀攀挀椀昀椀挀 挀漀渀搀甀挀琀愀渀挀攀Ⰰ 眀愀琀攀爀Ⰰ 甀渀昀椀氀琀攀爀攀搀Ⰰ 洀椀挀爀漀猀椀攀洀攀渀猀 瀀攀爀 挀攀渀琀椀洀攀琀攀爀 愀琀 ㈀㔀 搀攀最爀攀攀猀 䌀攀氀猀椀甀猀 ഀഀ
	discharge      float,  -- Discharge, cubic feet per second਍ऀ瀀栀             昀氀漀愀琀Ⰰ  ⴀⴀ 瀀䠀Ⰰ 眀愀琀攀爀Ⰰ 甀渀昀椀氀琀攀爀攀搀Ⰰ 昀椀攀氀搀Ⰰ 猀琀愀渀搀愀爀搀 甀渀椀琀猀   ഀഀ
	turbidity      float,  -- unfiltered, monochrome near infra-red LED light, 780-900 nm, detection angle 90 +-2.5 degrees, formazin nephelometric units (FNU) ਍ऀ漀砀礀最攀渀         昀氀漀愀琀Ⰰ  ⴀⴀ 䐀椀猀猀漀氀瘀攀搀 漀砀礀最攀渀Ⰰ 眀愀琀攀爀Ⰰ 甀渀昀椀氀琀攀爀攀搀Ⰰ 洀椀氀氀椀最爀愀洀猀 瀀攀爀 氀椀琀攀爀 ഀഀ
	precipitation  float,  -- Precipitation, total, inches਍ऀ瘀攀氀漀挀椀琀礀       昀氀漀愀琀Ⰰഀഀ
	air  float, cloudcover  float,  pressure  float,  wind  float, winddir  float,  humidity  float,  elevation  float,਍ऀ猀椀搀 戀椀最椀渀琀 椀搀攀渀琀椀琀礀⠀㐀㄀Ⰰ㔀　　⤀ 一伀吀 一唀䰀䰀 倀刀䤀䴀䄀刀夀 䬀䔀夀 䌀䰀唀匀吀䔀刀䔀䐀 ഀഀ
); ਍䜀伀ഀഀ
SET IDENTITY_INSERT MIUS041 ON਍䜀伀ഀഀ
ALTER TABLE MIUS041 ADD CONSTRAINT CHECK_MIUS041 CHECK((sid % 500) % 41 = 0)਍ⴀⴀ 愀氀琀攀爀 琀愀戀氀攀 䴀䤀唀匀　㐀㄀ 愀搀搀 猀椀搀 戀椀最椀渀琀 椀搀攀渀琀椀琀礀⠀㐀㄀Ⰰ㔀　　⤀ 一伀吀 一唀䰀䰀 倀刀䤀䴀䄀刀夀 䬀䔀夀 䌀䰀唀匀吀䔀刀䔀䐀     ഀഀ
     ਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开䴀䤀开洀氀椀崀 伀一 䴀䤀唀匀　㐀㄀ ⠀洀氀椀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开䴀䤀开琀攀洀瀀攀爀愀琀甀爀攀崀 伀一 䴀䤀唀匀　㐀㄀ ⠀琀攀洀瀀攀爀愀琀甀爀攀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开䴀䤀开琀甀爀戀椀搀椀琀礀崀 伀一 䴀䤀唀匀　㐀㄀ ⠀琀甀爀戀椀搀椀琀礀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开䴀䤀开挀漀渀搀甀挀琀愀渀挀攀崀 伀一 䴀䤀唀匀　㐀㄀ ⠀挀漀渀搀甀挀琀愀渀挀攀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开䴀䤀开猀琀愀洀瀀崀 伀一 䴀䤀唀匀　㐀㄀ ⠀猀琀愀洀瀀 搀攀猀挀⤀ ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开䴀䤀开搀椀猀挀栀愀爀最攀崀 伀一 䴀䤀唀匀　㐀㄀ ⠀搀椀猀挀栀愀爀最攀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开䴀䤀开漀砀礀最攀渀崀 伀一 䴀䤀唀匀　㐀㄀ ⠀漀砀礀最攀渀 䄀匀䌀⤀ഀഀ
GO਍ⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀഀഀ
CREATE TABLE VAUS043਍⠀ഀഀ
	[mli] varchar(32) NOT NULL,਍ऀ猀琀愀洀瀀 搀愀琀攀琀椀洀攀 一伀吀 一唀䰀䰀Ⰰഀഀ
	temperature    float,  -- Temperature, water, degrees Celsius਍ऀ挀漀渀搀甀挀琀愀渀挀攀    昀氀漀愀琀Ⰰ  ⴀⴀ 匀瀀攀挀椀昀椀挀 挀漀渀搀甀挀琀愀渀挀攀Ⰰ 眀愀琀攀爀Ⰰ 甀渀昀椀氀琀攀爀攀搀Ⰰ 洀椀挀爀漀猀椀攀洀攀渀猀 瀀攀爀 挀攀渀琀椀洀攀琀攀爀 愀琀 ㈀㔀 搀攀最爀攀攀猀 䌀攀氀猀椀甀猀 ഀഀ
	discharge      float,  -- Discharge, cubic feet per second਍ऀ瀀栀             昀氀漀愀琀Ⰰ  ⴀⴀ 瀀䠀Ⰰ 眀愀琀攀爀Ⰰ 甀渀昀椀氀琀攀爀攀搀Ⰰ 昀椀攀氀搀Ⰰ 猀琀愀渀搀愀爀搀 甀渀椀琀猀   ഀഀ
	turbidity      float,  -- unfiltered, monochrome near infra-red LED light, 780-900 nm, detection angle 90 +-2.5 degrees, formazin nephelometric units (FNU) ਍ऀ漀砀礀最攀渀         昀氀漀愀琀Ⰰ  ⴀⴀ 䐀椀猀猀漀氀瘀攀搀 漀砀礀最攀渀Ⰰ 眀愀琀攀爀Ⰰ 甀渀昀椀氀琀攀爀攀搀Ⰰ 洀椀氀氀椀最爀愀洀猀 瀀攀爀 氀椀琀攀爀 ഀഀ
	precipitation  float,  -- Precipitation, total, inches਍ऀ瘀攀氀漀挀椀琀礀       昀氀漀愀琀Ⰰഀഀ
	air  float, cloudcover  float,  pressure  float,  wind  float, winddir  float,  humidity  float,  elevation  float,਍ऀ猀椀搀 戀椀最椀渀琀 椀搀攀渀琀椀琀礀⠀㐀㌀Ⰰ㔀　　⤀ 一伀吀 一唀䰀䰀 倀刀䤀䴀䄀刀夀 䬀䔀夀 䌀䰀唀匀吀䔀刀䔀䐀 ഀഀ
); ਍䜀伀ഀഀ
SET IDENTITY_INSERT VAUS043 ON਍ഀഀ
ALTER TABLE VAUS043 ADD CONSTRAINT CHECK_VAUS043 CHECK((sid % 500) % 43 = 0)਍ⴀⴀ 愀氀琀攀爀 琀愀戀氀攀 嘀䄀唀匀　㐀㌀ 愀搀搀 猀椀搀 戀椀最椀渀琀 椀搀攀渀琀椀琀礀⠀㐀㌀Ⰰ㔀　　⤀ 一伀吀 一唀䰀䰀 倀刀䤀䴀䄀刀夀 䬀䔀夀 䌀䰀唀匀吀䔀刀䔀䐀 ഀഀ
GO    ਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开嘀䄀开洀氀椀崀 伀一 嘀䄀唀匀　㐀㌀ ⠀洀氀椀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开嘀䄀开琀攀洀瀀攀爀愀琀甀爀攀崀 伀一 嘀䄀唀匀　㐀㌀ ⠀琀攀洀瀀攀爀愀琀甀爀攀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开嘀䄀开琀甀爀戀椀搀椀琀礀崀 伀一 嘀䄀唀匀　㐀㌀ ⠀琀甀爀戀椀搀椀琀礀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开嘀䄀开挀漀渀搀甀挀琀愀渀挀攀崀 伀一 嘀䄀唀匀　㐀㌀ ⠀挀漀渀搀甀挀琀愀渀挀攀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开嘀䄀开猀琀愀洀瀀崀 伀一 嘀䄀唀匀　㐀㌀ ⠀猀琀愀洀瀀 䐀䔀匀䌀⤀ ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开嘀䄀开搀椀猀挀栀愀爀最攀崀 伀一 嘀䄀唀匀　㐀㌀ ⠀搀椀猀挀栀愀爀最攀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开嘀䄀开漀砀礀最攀渀崀 伀一 嘀䄀唀匀　㐀㌀ ⠀漀砀礀最攀渀 䄀匀䌀⤀ഀഀ
GO਍ⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀഀഀ
਍䌀刀䔀䄀吀䔀 吀䄀䈀䰀䔀 䴀䔀唀匀　㐀㜀ഀഀ
(਍ऀ嬀洀氀椀崀 瘀愀爀挀栀愀爀⠀㌀㈀⤀ 一伀吀 一唀䰀䰀Ⰰഀഀ
	stamp datetime NOT NULL,਍ऀ琀攀洀瀀攀爀愀琀甀爀攀    昀氀漀愀琀Ⰰ  ⴀⴀ 吀攀洀瀀攀爀愀琀甀爀攀Ⰰ 眀愀琀攀爀Ⰰ 搀攀最爀攀攀猀 䌀攀氀猀椀甀猀ഀഀ
	conductance    float,  -- Specific conductance, water, unfiltered, microsiemens per centimeter at 25 degrees Celsius ਍ऀ搀椀猀挀栀愀爀最攀      昀氀漀愀琀Ⰰ  ⴀⴀ 䐀椀猀挀栀愀爀最攀Ⰰ 挀甀戀椀挀 昀攀攀琀 瀀攀爀 猀攀挀漀渀搀ഀഀ
	ph             float,  -- pH, water, unfiltered, field, standard units   ਍ऀ琀甀爀戀椀搀椀琀礀      昀氀漀愀琀Ⰰ  ⴀⴀ 甀渀昀椀氀琀攀爀攀搀Ⰰ 洀漀渀漀挀栀爀漀洀攀 渀攀愀爀 椀渀昀爀愀ⴀ爀攀搀 䰀䔀䐀 氀椀最栀琀Ⰰ 㜀㠀　ⴀ㤀　　 渀洀Ⰰ 搀攀琀攀挀琀椀漀渀 愀渀最氀攀 㤀　 ⬀ⴀ㈀⸀㔀 搀攀最爀攀攀猀Ⰰ 昀漀爀洀愀稀椀渀 渀攀瀀栀攀氀漀洀攀琀爀椀挀 甀渀椀琀猀 ⠀䘀一唀⤀ ഀഀ
	oxygen         float,  -- Dissolved oxygen, water, unfiltered, milligrams per liter ਍ऀ瀀爀攀挀椀瀀椀琀愀琀椀漀渀  昀氀漀愀琀Ⰰ  ⴀⴀ 倀爀攀挀椀瀀椀琀愀琀椀漀渀Ⰰ 琀漀琀愀氀Ⰰ 椀渀挀栀攀猀ഀഀ
	velocity       float,਍ऀ愀椀爀  昀氀漀愀琀Ⰰ 挀氀漀甀搀挀漀瘀攀爀  昀氀漀愀琀Ⰰ  瀀爀攀猀猀甀爀攀  昀氀漀愀琀Ⰰ  眀椀渀搀  昀氀漀愀琀Ⰰ 眀椀渀搀搀椀爀  昀氀漀愀琀Ⰰ  栀甀洀椀搀椀琀礀  昀氀漀愀琀Ⰰ  攀氀攀瘀愀琀椀漀渀  昀氀漀愀琀Ⰰഀഀ
	sid bigint identity(47,500) NOT NULL PRIMARY KEY CLUSTERED ਍⤀㬀 ഀഀ
GO਍匀䔀吀 䤀䐀䔀一吀䤀吀夀开䤀一匀䔀刀吀 䴀䔀唀匀　㐀㜀 伀一ഀഀ
਍䜀伀ഀഀ
ALTER TABLE MEUS047 ADD CONSTRAINT CHECK_MEUS047 CHECK((sid % 500) % 47 = 0)਍ⴀⴀ 愀氀琀攀爀 琀愀戀氀攀 䴀䔀唀匀　㐀㜀 愀搀搀 猀椀搀 戀椀最椀渀琀 椀搀攀渀琀椀琀礀⠀㐀㜀Ⰰ㔀　　⤀ 一伀吀 一唀䰀䰀 倀刀䤀䴀䄀刀夀 䬀䔀夀 䌀䰀唀匀吀䔀刀䔀䐀      ഀഀ
CREATE NONCLUSTERED INDEX [idx_ME_mli] ON MEUS047 (mli ASC)਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_ME_temperature] ON MEUS047 (temperature ASC)਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_ME_turbidity] ON MEUS047 (turbidity ASC)਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_ME_conductance] ON MEUS047 (conductance ASC)਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_ME_stamp] ON MEUS047 (stamp desc) ਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_ME_discharge] ON MEUS047 (discharge ASC)਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_ME_oxygen] ON MEUS047 (oxygen ASC)਍䜀伀ഀഀ
------------------------------------------------------------------------------------------------਍䌀刀䔀䄀吀䔀 吀䄀䈀䰀䔀 匀䌀唀匀　㔀㤀ഀഀ
(਍ऀ嬀洀氀椀崀 瘀愀爀挀栀愀爀⠀㔀㤀⤀ 一伀吀 一唀䰀䰀Ⰰഀഀ
	stamp datetime NOT NULL,਍ऀ琀攀洀瀀攀爀愀琀甀爀攀    昀氀漀愀琀Ⰰ  ⴀⴀ 吀攀洀瀀攀爀愀琀甀爀攀Ⰰ 眀愀琀攀爀Ⰰ 搀攀最爀攀攀猀 䌀攀氀猀椀甀猀ഀഀ
	conductance    float,  -- Specific conductance, water, unfiltered, microsiemens per centimeter at 25 degrees Celsius ਍ऀ搀椀猀挀栀愀爀最攀      昀氀漀愀琀Ⰰ  ⴀⴀ 䐀椀猀挀栀愀爀最攀Ⰰ 挀甀戀椀挀 昀攀攀琀 瀀攀爀 猀攀挀漀渀搀ഀഀ
	ph             float,  -- pH, water, unfiltered, field, standard units   ਍ऀ琀甀爀戀椀搀椀琀礀      昀氀漀愀琀Ⰰ  ⴀⴀ 甀渀昀椀氀琀攀爀攀搀Ⰰ 洀漀渀漀挀栀爀漀洀攀 渀攀愀爀 椀渀昀爀愀ⴀ爀攀搀 䰀䔀䐀 氀椀最栀琀Ⰰ 㜀㠀　ⴀ㤀　　 渀洀Ⰰ 搀攀琀攀挀琀椀漀渀 愀渀最氀攀 㤀　 ⬀ⴀ㈀⸀㔀 搀攀最爀攀攀猀Ⰰ 昀漀爀洀愀稀椀渀 渀攀瀀栀攀氀漀洀攀琀爀椀挀 甀渀椀琀猀 ⠀䘀一唀⤀ ഀഀ
	oxygen         float,  -- Dissolved oxygen, water, unfiltered, milligrams per liter ਍ऀ瀀爀攀挀椀瀀椀琀愀琀椀漀渀  昀氀漀愀琀Ⰰ  ⴀⴀ 倀爀攀挀椀瀀椀琀愀琀椀漀渀Ⰰ 琀漀琀愀氀Ⰰ 椀渀挀栀攀猀ഀഀ
	velocity       float,਍ऀ愀椀爀  昀氀漀愀琀Ⰰ 挀氀漀甀搀挀漀瘀攀爀  昀氀漀愀琀Ⰰ  瀀爀攀猀猀甀爀攀  昀氀漀愀琀Ⰰ  眀椀渀搀  昀氀漀愀琀Ⰰ 眀椀渀搀搀椀爀  昀氀漀愀琀Ⰰ  栀甀洀椀搀椀琀礀  昀氀漀愀琀Ⰰ  攀氀攀瘀愀琀椀漀渀  昀氀漀愀琀Ⰰഀഀ
	sid bigint identity(59,500) NOT NULL PRIMARY KEY CLUSTERED ਍⤀㬀 ഀഀ
GO਍匀䔀吀 䤀䐀䔀一吀䤀吀夀开䤀一匀䔀刀吀 匀䌀唀匀　㔀㤀 伀一ഀഀ
GO਍䄀䰀吀䔀刀 吀䄀䈀䰀䔀 匀䌀唀匀　㔀㤀 䄀䐀䐀 䌀伀一匀吀刀䄀䤀一吀 䌀䠀䔀䌀䬀开匀䌀唀匀　㔀㤀 䌀䠀䔀䌀䬀⠀⠀猀椀搀 ─ 㔀　　⤀ ─ 㔀㤀 㴀 　⤀ഀഀ
-- alter table SCUS059 add sid bigint identity(59,500) NOT NULL PRIMARY KEY CLUSTERED      ਍     ഀഀ
CREATE NONCLUSTERED INDEX [idx_SC_mli] ON SCUS059 (mli ASC)਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_SC_temperature] ON SCUS059 (temperature ASC)਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_SC_turbidity] ON SCUS059 (turbidity ASC)਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_SC_conductance] ON SCUS059 (conductance ASC)਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_SC_stamp] ON SCUS059 (stamp desc) ਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_SC_discharge] ON SCUS059 (discharge ASC)਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_SC_oxygen] ON SCUS059 (oxygen ASC)਍䜀伀ഀഀ
------------------------------------------------------------------------------------------------਍䌀刀䔀䄀吀䔀 吀䄀䈀䰀䔀 刀䤀唀匀　㘀㄀ഀഀ
(਍ऀ嬀洀氀椀崀 瘀愀爀挀栀愀爀⠀㌀㈀⤀ 一伀吀 一唀䰀䰀Ⰰഀഀ
	stamp datetime NOT NULL,਍ऀ琀攀洀瀀攀爀愀琀甀爀攀    昀氀漀愀琀Ⰰ  ⴀⴀ 吀攀洀瀀攀爀愀琀甀爀攀Ⰰ 眀愀琀攀爀Ⰰ 搀攀最爀攀攀猀 䌀攀氀猀椀甀猀ഀഀ
	conductance    float,  -- Specific conductance, water, unfiltered, microsiemens per centimeter at 25 degrees Celsius ਍ऀ搀椀猀挀栀愀爀最攀      昀氀漀愀琀Ⰰ  ⴀⴀ 䐀椀猀挀栀愀爀最攀Ⰰ 挀甀戀椀挀 昀攀攀琀 瀀攀爀 猀攀挀漀渀搀ഀഀ
	ph             float,  -- pH, water, unfiltered, field, standard units   ਍ऀ琀甀爀戀椀搀椀琀礀      昀氀漀愀琀Ⰰ  ⴀⴀ 甀渀昀椀氀琀攀爀攀搀Ⰰ 洀漀渀漀挀栀爀漀洀攀 渀攀愀爀 椀渀昀爀愀ⴀ爀攀搀 䰀䔀䐀 氀椀最栀琀Ⰰ 㜀㠀　ⴀ㤀　　 渀洀Ⰰ 搀攀琀攀挀琀椀漀渀 愀渀最氀攀 㤀　 ⬀ⴀ㈀⸀㔀 搀攀最爀攀攀猀Ⰰ 昀漀爀洀愀稀椀渀 渀攀瀀栀攀氀漀洀攀琀爀椀挀 甀渀椀琀猀 ⠀䘀一唀⤀ ഀഀ
	oxygen         float,  -- Dissolved oxygen, water, unfiltered, milligrams per liter ਍ऀ瀀爀攀挀椀瀀椀琀愀琀椀漀渀  昀氀漀愀琀Ⰰ  ⴀⴀ 倀爀攀挀椀瀀椀琀愀琀椀漀渀Ⰰ 琀漀琀愀氀Ⰰ 椀渀挀栀攀猀ഀഀ
	velocity       float,਍ऀ愀椀爀  昀氀漀愀琀Ⰰ 挀氀漀甀搀挀漀瘀攀爀  昀氀漀愀琀Ⰰ  瀀爀攀猀猀甀爀攀  昀氀漀愀琀Ⰰ  眀椀渀搀  昀氀漀愀琀Ⰰ 眀椀渀搀搀椀爀  昀氀漀愀琀Ⰰ  栀甀洀椀搀椀琀礀  昀氀漀愀琀Ⰰ  攀氀攀瘀愀琀椀漀渀  昀氀漀愀琀Ⰰഀഀ
	sid bigint identity(61,500) NOT NULL PRIMARY KEY CLUSTERED ਍⤀㬀 ഀഀ
GO਍匀䔀吀 䤀䐀䔀一吀䤀吀夀开䤀一匀䔀刀吀 刀䤀唀匀　㘀㄀ 伀一ഀഀ
GO਍䄀䰀吀䔀刀 吀䄀䈀䰀䔀 刀䤀唀匀　㘀㄀ 䄀䐀䐀 䌀伀一匀吀刀䄀䤀一吀 䌀䠀䔀䌀䬀开刀䤀唀匀　㘀㄀ 䌀䠀䔀䌀䬀⠀⠀猀椀搀 ─ 㔀　　⤀ ─ 㘀㄀ 㴀 　⤀ഀഀ
-- alter table RIUS061 add sid bigint identity(61,500) NOT NULL PRIMARY KEY CLUSTERED        ਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开刀䤀开洀氀椀崀 伀一 刀䤀唀匀　㘀㄀ ⠀洀氀椀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开刀䤀开琀攀洀瀀攀爀愀琀甀爀攀崀 伀一 刀䤀唀匀　㘀㄀ ⠀琀攀洀瀀攀爀愀琀甀爀攀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开刀䤀开琀甀爀戀椀搀椀琀礀崀 伀一 刀䤀唀匀　㘀㄀ ⠀琀甀爀戀椀搀椀琀礀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开刀䤀开挀漀渀搀甀挀琀愀渀挀攀崀 伀一 刀䤀唀匀　㘀㄀ ⠀挀漀渀搀甀挀琀愀渀挀攀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开刀䤀开猀琀愀洀瀀崀 伀一 刀䤀唀匀　㘀㄀ ⠀猀琀愀洀瀀 搀攀猀挀⤀ ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开刀䤀开搀椀猀挀栀愀爀最攀崀 伀一 刀䤀唀匀　㘀㄀ ⠀搀椀猀挀栀愀爀最攀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开刀䤀开漀砀礀最攀渀崀 伀一 刀䤀唀匀　㘀㄀ ⠀漀砀礀最攀渀⤀ഀഀ
GO਍ⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀഀഀ
CREATE TABLE WAUS067਍⠀ഀഀ
	[mli] varchar(32) NOT NULL,਍ऀ猀琀愀洀瀀 搀愀琀攀琀椀洀攀 一伀吀 一唀䰀䰀Ⰰഀഀ
	temperature    float,  -- Temperature, water, degrees Celsius਍ऀ挀漀渀搀甀挀琀愀渀挀攀    昀氀漀愀琀Ⰰ  ⴀⴀ 匀瀀攀挀椀昀椀挀 挀漀渀搀甀挀琀愀渀挀攀Ⰰ 眀愀琀攀爀Ⰰ 甀渀昀椀氀琀攀爀攀搀Ⰰ 洀椀挀爀漀猀椀攀洀攀渀猀 瀀攀爀 挀攀渀琀椀洀攀琀攀爀 愀琀 ㈀㔀 搀攀最爀攀攀猀 䌀攀氀猀椀甀猀 ഀഀ
	discharge      float,  -- Discharge, cubic feet per second਍ऀ瀀栀             昀氀漀愀琀Ⰰ  ⴀⴀ 瀀䠀Ⰰ 眀愀琀攀爀Ⰰ 甀渀昀椀氀琀攀爀攀搀Ⰰ 昀椀攀氀搀Ⰰ 猀琀愀渀搀愀爀搀 甀渀椀琀猀   ഀഀ
	turbidity      float,  -- unfiltered, monochrome near infra-red LED light, 780-900 nm, detection angle 90 +-2.5 degrees, formazin nephelometric units (FNU) ਍ऀ漀砀礀最攀渀         昀氀漀愀琀Ⰰ  ⴀⴀ 䐀椀猀猀漀氀瘀攀搀 漀砀礀最攀渀Ⰰ 眀愀琀攀爀Ⰰ 甀渀昀椀氀琀攀爀攀搀Ⰰ 洀椀氀氀椀最爀愀洀猀 瀀攀爀 氀椀琀攀爀 ഀഀ
	precipitation  float,  -- Precipitation, total, inches਍ऀ瘀攀氀漀挀椀琀礀       昀氀漀愀琀Ⰰഀഀ
	air  float, cloudcover  float,  pressure  float,  wind  float, winddir  float,  humidity  float,  elevation  float,਍ऀ猀椀搀 戀椀最椀渀琀 椀搀攀渀琀椀琀礀⠀㘀㜀Ⰰ㔀　　⤀ 一伀吀 一唀䰀䰀 倀刀䤀䴀䄀刀夀 䬀䔀夀 䌀䰀唀匀吀䔀刀䔀䐀 ഀഀ
); ਍䜀伀ഀഀ
SET IDENTITY_INSERT WAUS067 ON਍䜀伀ഀഀ
ALTER TABLE WAUS067 ADD CONSTRAINT CHECK_WAUS067 CHECK((sid % 500) % 67 = 0)਍ⴀⴀ 愀氀琀攀爀 琀愀戀氀攀 圀䄀唀匀　㘀㜀 愀搀搀 猀椀搀 戀椀最椀渀琀 椀搀攀渀琀椀琀礀⠀㘀㜀Ⰰ㔀　　⤀ 一伀吀 一唀䰀䰀 倀刀䤀䴀䄀刀夀 䬀䔀夀 䌀䰀唀匀吀䔀刀䔀䐀        ഀഀ
     ਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开圀䄀开洀氀椀崀 伀一 圀䄀唀匀　㘀㜀 ⠀洀氀椀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开圀䄀开琀攀洀瀀攀爀愀琀甀爀攀崀 伀一 圀䄀唀匀　㘀㜀 ⠀琀攀洀瀀攀爀愀琀甀爀攀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开圀䄀开琀甀爀戀椀搀椀琀礀崀 伀一 圀䄀唀匀　㘀㜀 ⠀琀甀爀戀椀搀椀琀礀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开圀䄀开挀漀渀搀甀挀琀愀渀挀攀崀 伀一 圀䄀唀匀　㘀㜀 ⠀挀漀渀搀甀挀琀愀渀挀攀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开圀䄀开猀琀愀洀瀀崀 伀一 圀䄀唀匀　㘀㜀 ⠀猀琀愀洀瀀 搀攀猀挀⤀ ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开圀䄀开搀椀猀挀栀愀爀最攀崀 伀一 圀䄀唀匀　㘀㜀 ⠀搀椀猀挀栀愀爀最攀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开圀䄀开漀砀礀最攀渀崀 伀一 圀䄀唀匀　㘀㜀 ⠀漀砀礀最攀渀⤀ഀഀ
GO਍ⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀഀഀ
CREATE TABLE MAUS071਍⠀ഀഀ
	[mli] varchar(32) NOT NULL,਍ऀ猀琀愀洀瀀 搀愀琀攀琀椀洀攀 一伀吀 一唀䰀䰀Ⰰഀഀ
	temperature    float,  -- Temperature, water, degrees Celsius਍ऀ挀漀渀搀甀挀琀愀渀挀攀    昀氀漀愀琀Ⰰ  ⴀⴀ 匀瀀攀挀椀昀椀挀 挀漀渀搀甀挀琀愀渀挀攀Ⰰ 眀愀琀攀爀Ⰰ 甀渀昀椀氀琀攀爀攀搀Ⰰ 洀椀挀爀漀猀椀攀洀攀渀猀 瀀攀爀 挀攀渀琀椀洀攀琀攀爀 愀琀 ㈀㔀 搀攀最爀攀攀猀 䌀攀氀猀椀甀猀 ഀഀ
	discharge      float,  -- Discharge, cubic feet per second਍ऀ瀀栀             昀氀漀愀琀Ⰰ  ⴀⴀ 瀀䠀Ⰰ 眀愀琀攀爀Ⰰ 甀渀昀椀氀琀攀爀攀搀Ⰰ 昀椀攀氀搀Ⰰ 猀琀愀渀搀愀爀搀 甀渀椀琀猀   ഀഀ
	turbidity      float,  -- unfiltered, monochrome near infra-red LED light, 780-900 nm, detection angle 90 +-2.5 degrees, formazin nephelometric units (FNU) ਍ऀ漀砀礀最攀渀         昀氀漀愀琀Ⰰ  ⴀⴀ 䐀椀猀猀漀氀瘀攀搀 漀砀礀最攀渀Ⰰ 眀愀琀攀爀Ⰰ 甀渀昀椀氀琀攀爀攀搀Ⰰ 洀椀氀氀椀最爀愀洀猀 瀀攀爀 氀椀琀攀爀 ഀഀ
	precipitation  float,  -- Precipitation, total, inches਍ऀ瘀攀氀漀挀椀琀礀       昀氀漀愀琀Ⰰഀഀ
	air  float, cloudcover  float,  pressure  float,  wind  float, winddir  float,  humidity  float,  elevation  float,਍ऀ猀椀搀 戀椀最椀渀琀 椀搀攀渀琀椀琀礀⠀㜀㄀Ⰰ 㔀　　⤀ 一伀吀 一唀䰀䰀 倀刀䤀䴀䄀刀夀 䬀䔀夀 䌀䰀唀匀吀䔀刀䔀䐀 ഀഀ
); ਍䜀伀ഀഀ
SET IDENTITY_INSERT MAUS071 ON਍䜀伀ഀഀ
ALTER TABLE MAUS071 ADD CONSTRAINT CHECK_MAUS071 CHECK((sid % 500) % 71 = 0)਍ⴀⴀ 愀氀琀攀爀 琀愀戀氀攀 䴀䄀唀匀　㜀㄀ 愀搀搀 猀椀搀 戀椀最椀渀琀 椀搀攀渀琀椀琀礀⠀㜀㄀Ⰰ㔀　　⤀ 一伀吀 一唀䰀䰀 倀刀䤀䴀䄀刀夀 䬀䔀夀 䌀䰀唀匀吀䔀刀䔀䐀        ഀഀ
CREATE NONCLUSTERED INDEX [idx_MA_mli] ON MAUS071 (mli)਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_MA_temperature] ON MAUS071 (temperature)਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_MA_turbidity] ON MAUS071 (turbidity)਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_MA_conductance] ON MAUS071 (conductance)਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_MA_stamp] ON MAUS071 (stamp desc) ਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_MA_discharge] ON MAUS071 (discharge)਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_MA_oxygen] ON MAUS071 (oxygen)਍䜀伀ഀഀ
------------------------------------------------------------------------------------------------਍䌀刀䔀䄀吀䔀 吀䄀䈀䰀䔀 一嘀唀匀　㜀㌀ഀഀ
(਍ऀ嬀洀氀椀崀 瘀愀爀挀栀愀爀⠀㌀㈀⤀ 一伀吀 一唀䰀䰀Ⰰഀഀ
	stamp datetime NOT NULL,਍ऀ琀攀洀瀀攀爀愀琀甀爀攀    昀氀漀愀琀Ⰰ  ⴀⴀ 吀攀洀瀀攀爀愀琀甀爀攀Ⰰ 眀愀琀攀爀Ⰰ 搀攀最爀攀攀猀 䌀攀氀猀椀甀猀ഀഀ
	conductance    float,  -- Specific conductance, water, unfiltered, microsiemens per centimeter at 25 degrees Celsius ਍ऀ搀椀猀挀栀愀爀最攀      昀氀漀愀琀Ⰰ  ⴀⴀ 䐀椀猀挀栀愀爀最攀Ⰰ 挀甀戀椀挀 昀攀攀琀 瀀攀爀 猀攀挀漀渀搀ഀഀ
	ph             float,  -- pH, water, unfiltered, field, standard units   ਍ऀ琀甀爀戀椀搀椀琀礀      昀氀漀愀琀Ⰰ  ⴀⴀ 甀渀昀椀氀琀攀爀攀搀Ⰰ 洀漀渀漀挀栀爀漀洀攀 渀攀愀爀 椀渀昀爀愀ⴀ爀攀搀 䰀䔀䐀 氀椀最栀琀Ⰰ 㜀㠀　ⴀ㤀　　 渀洀Ⰰ 搀攀琀攀挀琀椀漀渀 愀渀最氀攀 㤀　 ⬀ⴀ㈀⸀㔀 搀攀最爀攀攀猀Ⰰ 昀漀爀洀愀稀椀渀 渀攀瀀栀攀氀漀洀攀琀爀椀挀 甀渀椀琀猀 ⠀䘀一唀⤀ ഀഀ
	oxygen         float,  -- Dissolved oxygen, water, unfiltered, milligrams per liter ਍ऀ瀀爀攀挀椀瀀椀琀愀琀椀漀渀  昀氀漀愀琀Ⰰ  ⴀⴀ 倀爀攀挀椀瀀椀琀愀琀椀漀渀Ⰰ 琀漀琀愀氀Ⰰ 椀渀挀栀攀猀ഀഀ
	velocity       float,਍ऀ愀椀爀  昀氀漀愀琀Ⰰ 挀氀漀甀搀挀漀瘀攀爀  昀氀漀愀琀Ⰰ  瀀爀攀猀猀甀爀攀  昀氀漀愀琀Ⰰ  眀椀渀搀  昀氀漀愀琀Ⰰ 眀椀渀搀搀椀爀  昀氀漀愀琀Ⰰ  栀甀洀椀搀椀琀礀  昀氀漀愀琀Ⰰ  攀氀攀瘀愀琀椀漀渀  昀氀漀愀琀Ⰰഀഀ
	sid bigint identity(73,500) NOT NULL PRIMARY KEY CLUSTERED ਍⤀㬀 ഀഀ
GO਍匀䔀吀 䤀䐀䔀一吀䤀吀夀开䤀一匀䔀刀吀 一嘀唀匀　㜀㌀ 伀一ഀഀ
GO਍䄀䰀吀䔀刀 吀䄀䈀䰀䔀 一嘀唀匀　㜀㌀ 䄀䐀䐀 䌀伀一匀吀刀䄀䤀一吀 䌀䠀䔀䌀䬀开一嘀唀匀　㜀㌀ 䌀䠀䔀䌀䬀⠀⠀猀椀搀 ─ 㔀　　⤀ ─ 㜀㌀ 㴀 　⤀ഀഀ
-- alter table NVUS073 add sid bigint identity(73,500) NOT NULL PRIMARY KEY CLUSTERED        ਍     ഀഀ
CREATE NONCLUSTERED INDEX [idx_NV_mli] ON NVUS073 (mli)਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_NV_temperature] ON NVUS073 (temperature)਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_NV_turbidity] ON NVUS073 (turbidity)਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_NV_conductance] ON NVUS073 (conductance)਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_NV_stamp] ON NVUS073 (stamp desc) ਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_NV_discharge] ON NVUS073 (discharge)਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_NV_oxygen] ON NVUS073 (oxygen)਍䜀伀ഀഀ
------------------------------------------------------------------------------------------------਍䌀刀䔀䄀吀䔀 吀䄀䈀䰀䔀 一夀唀匀　㜀㤀ഀഀ
(਍ऀ嬀洀氀椀崀 瘀愀爀挀栀愀爀⠀㌀㈀⤀ 一伀吀 一唀䰀䰀Ⰰഀഀ
	stamp datetime NOT NULL,਍ऀ琀攀洀瀀攀爀愀琀甀爀攀    昀氀漀愀琀Ⰰ  ⴀⴀ 吀攀洀瀀攀爀愀琀甀爀攀Ⰰ 眀愀琀攀爀Ⰰ 搀攀最爀攀攀猀 䌀攀氀猀椀甀猀ഀഀ
	conductance    float,  -- Specific conductance, water, unfiltered, microsiemens per centimeter at 25 degrees Celsius ਍ऀ搀椀猀挀栀愀爀最攀      昀氀漀愀琀Ⰰ  ⴀⴀ 䐀椀猀挀栀愀爀最攀Ⰰ 挀甀戀椀挀 昀攀攀琀 瀀攀爀 猀攀挀漀渀搀ഀഀ
	ph             float,  -- pH, water, unfiltered, field, standard units   ਍ऀ琀甀爀戀椀搀椀琀礀      昀氀漀愀琀Ⰰ  ⴀⴀ 甀渀昀椀氀琀攀爀攀搀Ⰰ 洀漀渀漀挀栀爀漀洀攀 渀攀愀爀 椀渀昀爀愀ⴀ爀攀搀 䰀䔀䐀 氀椀最栀琀Ⰰ 㜀㠀　ⴀ㤀　　 渀洀Ⰰ 搀攀琀攀挀琀椀漀渀 愀渀最氀攀 㤀　 ⬀ⴀ㈀⸀㔀 搀攀最爀攀攀猀Ⰰ 昀漀爀洀愀稀椀渀 渀攀瀀栀攀氀漀洀攀琀爀椀挀 甀渀椀琀猀 ⠀䘀一唀⤀ ഀഀ
	oxygen         float,  -- Dissolved oxygen, water, unfiltered, milligrams per liter ਍ऀ瀀爀攀挀椀瀀椀琀愀琀椀漀渀  昀氀漀愀琀Ⰰ  ⴀⴀ 倀爀攀挀椀瀀椀琀愀琀椀漀渀Ⰰ 琀漀琀愀氀Ⰰ 椀渀挀栀攀猀ഀഀ
	velocity       float,਍ऀ愀椀爀  昀氀漀愀琀Ⰰ 挀氀漀甀搀挀漀瘀攀爀  昀氀漀愀琀Ⰰ  瀀爀攀猀猀甀爀攀  昀氀漀愀琀Ⰰ  眀椀渀搀  昀氀漀愀琀Ⰰ 眀椀渀搀搀椀爀  昀氀漀愀琀Ⰰ  栀甀洀椀搀椀琀礀  昀氀漀愀琀Ⰰ  攀氀攀瘀愀琀椀漀渀  昀氀漀愀琀Ⰰഀഀ
	sid bigint identity(79,500) NOT NULL PRIMARY KEY CLUSTERED ਍⤀㬀 ഀഀ
GO਍匀䔀吀 䤀䐀䔀一吀䤀吀夀开䤀一匀䔀刀吀 一夀唀匀　㜀㤀 伀一ഀഀ
GO਍䄀䰀吀䔀刀 吀䄀䈀䰀䔀 一夀唀匀　㜀㤀 䄀䐀䐀 䌀伀一匀吀刀䄀䤀一吀 䌀䠀䔀䌀䬀开一夀唀匀　㜀㤀 䌀䠀䔀䌀䬀⠀⠀猀椀搀 ─ 㔀　　⤀ ─ 㜀㤀 㴀 　⤀ഀഀ
-- alter table NYUS079 add sid bigint identity(79,500) NOT NULL PRIMARY KEY CLUSTERED        ਍  ഀഀ
CREATE NONCLUSTERED INDEX [idx_NY_mli] ON NYUS079 (mli ASC)਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_NY_temperature] ON NYUS079 (temperature ASC)਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_NY_turbidity] ON NYUS079 (turbidity ASC)਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_NY_conductance] ON NYUS079 (conductance ASC)਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_NY_stamp] ON NYUS079 (stamp DESC) ਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_NY_discharge] ON NYUS079 (discharge ASC)਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_NY_oxygen] ON NYUS079 (oxygen ASC)਍䜀伀ഀഀ
------------------------------------------------------------------------------------------------਍䌀刀䔀䄀吀䔀 吀䄀䈀䰀䔀 伀䠀唀匀　㠀㌀ഀഀ
(਍ऀ嬀洀氀椀崀 瘀愀爀挀栀愀爀⠀㌀㈀⤀ 一伀吀 一唀䰀䰀Ⰰഀഀ
	stamp datetime NOT NULL,਍ऀ琀攀洀瀀攀爀愀琀甀爀攀    昀氀漀愀琀Ⰰ  ⴀⴀ 吀攀洀瀀攀爀愀琀甀爀攀Ⰰ 眀愀琀攀爀Ⰰ 搀攀最爀攀攀猀 䌀攀氀猀椀甀猀ഀഀ
	conductance    float,  -- Specific conductance, water, unfiltered, microsiemens per centimeter at 25 degrees Celsius ਍ऀ搀椀猀挀栀愀爀最攀      昀氀漀愀琀Ⰰ  ⴀⴀ 䐀椀猀挀栀愀爀最攀Ⰰ 挀甀戀椀挀 昀攀攀琀 瀀攀爀 猀攀挀漀渀搀ഀഀ
	ph             float,  -- pH, water, unfiltered, field, standard units   ਍ऀ琀甀爀戀椀搀椀琀礀      昀氀漀愀琀Ⰰ  ⴀⴀ 甀渀昀椀氀琀攀爀攀搀Ⰰ 洀漀渀漀挀栀爀漀洀攀 渀攀愀爀 椀渀昀爀愀ⴀ爀攀搀 䰀䔀䐀 氀椀最栀琀Ⰰ 㜀㠀　ⴀ㤀　　 渀洀Ⰰ 搀攀琀攀挀琀椀漀渀 愀渀最氀攀 㤀　 ⬀ⴀ㈀⸀㔀 搀攀最爀攀攀猀Ⰰ 昀漀爀洀愀稀椀渀 渀攀瀀栀攀氀漀洀攀琀爀椀挀 甀渀椀琀猀 ⠀䘀一唀⤀ ഀഀ
	oxygen         float,  -- Dissolved oxygen, water, unfiltered, milligrams per liter ਍ऀ瀀爀攀挀椀瀀椀琀愀琀椀漀渀  昀氀漀愀琀Ⰰ  ⴀⴀ 倀爀攀挀椀瀀椀琀愀琀椀漀渀Ⰰ 琀漀琀愀氀Ⰰ 椀渀挀栀攀猀ഀഀ
	velocity       float,਍ऀ愀椀爀  昀氀漀愀琀Ⰰ 挀氀漀甀搀挀漀瘀攀爀  昀氀漀愀琀Ⰰ  瀀爀攀猀猀甀爀攀  昀氀漀愀琀Ⰰ  眀椀渀搀  昀氀漀愀琀Ⰰ 眀椀渀搀搀椀爀  昀氀漀愀琀Ⰰ  栀甀洀椀搀椀琀礀  昀氀漀愀琀Ⰰ  攀氀攀瘀愀琀椀漀渀  昀氀漀愀琀Ⰰഀഀ
	sid bigint identity(83,500) NOT NULL PRIMARY KEY CLUSTERED ਍⤀㬀 ഀഀ
GO਍匀䔀吀 䤀䐀䔀一吀䤀吀夀开䤀一匀䔀刀吀 伀䠀唀匀　㠀㌀ 伀一ഀഀ
GO਍䄀䰀吀䔀刀 吀䄀䈀䰀䔀 伀䠀唀匀　㠀㌀ 䄀䐀䐀 䌀伀一匀吀刀䄀䤀一吀 䌀䠀䔀䌀䬀开伀䠀唀匀㠀㌀ 䌀䠀䔀䌀䬀⠀⠀猀椀搀 ─ 㔀　　⤀ ─ 㠀㌀ 㴀 　⤀ ഀഀ
-- alter table OHUS83 add sid bigint identity(83,500) NOT NULL PRIMARY KEY CLUSTERED        ਍    ഀഀ
CREATE NONCLUSTERED INDEX [idx_OH_mli] ON OHUS083 (mli ASC)਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_OH_temperature] ON OHUS083 (temperature ASC)਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_OH_turbidity] ON OHUS083 (turbidity ASC)਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_OH_conductance] ON OHUS083 (conductance ASC)਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_OH_stamp] ON OHUS083 (stamp DESC) ਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_OH_discharge] ON OHUS083 (discharge ASC)਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_OH_oxygen] ON OHUS083 (oxygen ASC)਍䜀伀ഀഀ
------------------------------------------------------------------------------------------------਍䌀刀䔀䄀吀䔀 吀䄀䈀䰀䔀 匀䐀唀匀　㠀㤀ഀഀ
(਍ऀ嬀洀氀椀崀 瘀愀爀挀栀愀爀⠀㌀㈀⤀ 一伀吀 一唀䰀䰀Ⰰഀഀ
	stamp datetime NOT NULL,਍ऀ琀攀洀瀀攀爀愀琀甀爀攀    昀氀漀愀琀Ⰰ  ⴀⴀ 吀攀洀瀀攀爀愀琀甀爀攀Ⰰ 眀愀琀攀爀Ⰰ 搀攀最爀攀攀猀 䌀攀氀猀椀甀猀ഀഀ
	conductance    float,  -- Specific conductance, water, unfiltered, microsiemens per centimeter at 25 degrees Celsius ਍ऀ搀椀猀挀栀愀爀最攀      昀氀漀愀琀Ⰰ  ⴀⴀ 䐀椀猀挀栀愀爀最攀Ⰰ 挀甀戀椀挀 昀攀攀琀 瀀攀爀 猀攀挀漀渀搀ഀഀ
	ph             float,  -- pH, water, unfiltered, field, standard units   ਍ऀ琀甀爀戀椀搀椀琀礀      昀氀漀愀琀Ⰰ  ⴀⴀ 甀渀昀椀氀琀攀爀攀搀Ⰰ 洀漀渀漀挀栀爀漀洀攀 渀攀愀爀 椀渀昀爀愀ⴀ爀攀搀 䰀䔀䐀 氀椀最栀琀Ⰰ 㜀㠀　ⴀ㤀　　 渀洀Ⰰ 搀攀琀攀挀琀椀漀渀 愀渀最氀攀 㤀　 ⬀ⴀ㈀⸀㔀 搀攀最爀攀攀猀Ⰰ 昀漀爀洀愀稀椀渀 渀攀瀀栀攀氀漀洀攀琀爀椀挀 甀渀椀琀猀 ⠀䘀一唀⤀ ഀഀ
	oxygen         float,  -- Dissolved oxygen, water, unfiltered, milligrams per liter ਍ऀ瀀爀攀挀椀瀀椀琀愀琀椀漀渀  昀氀漀愀琀Ⰰ  ⴀⴀ 倀爀攀挀椀瀀椀琀愀琀椀漀渀Ⰰ 琀漀琀愀氀Ⰰ 椀渀挀栀攀猀ഀഀ
	velocity       float,਍ऀ愀椀爀  昀氀漀愀琀Ⰰ 挀氀漀甀搀挀漀瘀攀爀  昀氀漀愀琀Ⰰ  瀀爀攀猀猀甀爀攀  昀氀漀愀琀Ⰰ  眀椀渀搀  昀氀漀愀琀Ⰰ 眀椀渀搀搀椀爀  昀氀漀愀琀Ⰰ  栀甀洀椀搀椀琀礀  昀氀漀愀琀Ⰰ  攀氀攀瘀愀琀椀漀渀  昀氀漀愀琀Ⰰഀഀ
	sid bigint identity(89,500) NOT NULL PRIMARY KEY CLUSTERED ਍⤀㬀 ഀഀ
GO਍匀䔀吀 䤀䐀䔀一吀䤀吀夀开䤀一匀䔀刀吀 匀䐀唀匀　㠀㤀 伀一ഀഀ
GO਍䄀䰀吀䔀刀 吀䄀䈀䰀䔀 匀䐀唀匀　㠀㤀 䄀䐀䐀 䌀伀一匀吀刀䄀䤀一吀 䌀䠀䔀䌀䬀开匀䐀唀匀　㠀㤀 䌀䠀䔀䌀䬀⠀⠀猀椀搀 ─ 㔀　　⤀ ─ 㠀㤀 㴀 　⤀ ഀഀ
-- alter table SDUS089 add sid bigint identity(89,500) NOT NULL PRIMARY KEY CLUSTERED    ਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开匀䐀唀匀　㠀㤀开洀氀椀崀 伀一 匀䐀唀匀　㠀㤀 ⠀洀氀椀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开匀䐀唀匀　㠀㤀开琀攀洀瀀攀爀愀琀甀爀攀崀 伀一 匀䐀唀匀　㠀㤀 ⠀琀攀洀瀀攀爀愀琀甀爀攀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开匀䐀唀匀　㠀㤀开琀甀爀戀椀搀椀琀礀崀 伀一 匀䐀唀匀　㠀㤀 ⠀琀甀爀戀椀搀椀琀礀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开匀䐀唀匀　㠀㤀开挀漀渀搀甀挀琀愀渀挀攀崀 伀一 匀䐀唀匀　㠀㤀 ⠀挀漀渀搀甀挀琀愀渀挀攀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开匀䐀唀匀　㠀㤀开猀琀愀洀瀀崀 伀一 匀䐀唀匀　㠀㤀 ⠀猀琀愀洀瀀 䐀䔀匀䌀⤀ ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开匀䐀唀匀　㠀㤀开搀椀猀挀栀愀爀最攀崀 伀一 匀䐀唀匀　㠀㤀 ⠀搀椀猀挀栀愀爀最攀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开匀䐀唀匀　㠀㤀开漀砀礀最攀渀崀 伀一 匀䐀唀匀　㠀㤀 ⠀漀砀礀最攀渀 䄀匀䌀⤀ഀഀ
GO ਍ⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀഀഀ
CREATE TABLE CTUS097਍⠀ഀഀ
	[mli] varchar(32) NOT NULL,਍ऀ猀琀愀洀瀀 搀愀琀攀琀椀洀攀 一伀吀 一唀䰀䰀Ⰰഀഀ
	temperature    float,  -- Temperature, water, degrees Celsius਍ऀ挀漀渀搀甀挀琀愀渀挀攀    昀氀漀愀琀Ⰰ  ⴀⴀ 匀瀀攀挀椀昀椀挀 挀漀渀搀甀挀琀愀渀挀攀Ⰰ 眀愀琀攀爀Ⰰ 甀渀昀椀氀琀攀爀攀搀Ⰰ 洀椀挀爀漀猀椀攀洀攀渀猀 瀀攀爀 挀攀渀琀椀洀攀琀攀爀 愀琀 ㈀㔀 搀攀最爀攀攀猀 䌀攀氀猀椀甀猀 ഀഀ
	discharge      float,  -- Discharge, cubic feet per second਍ऀ瀀栀             昀氀漀愀琀Ⰰ  ⴀⴀ 瀀䠀Ⰰ 眀愀琀攀爀Ⰰ 甀渀昀椀氀琀攀爀攀搀Ⰰ 昀椀攀氀搀Ⰰ 猀琀愀渀搀愀爀搀 甀渀椀琀猀   ഀഀ
	turbidity      float,  -- unfiltered, monochrome near infra-red LED light, 780-900 nm, detection angle 90 +-2.5 degrees, formazin nephelometric units (FNU) ਍ऀ漀砀礀最攀渀         昀氀漀愀琀Ⰰ  ⴀⴀ 䐀椀猀猀漀氀瘀攀搀 漀砀礀最攀渀Ⰰ 眀愀琀攀爀Ⰰ 甀渀昀椀氀琀攀爀攀搀Ⰰ 洀椀氀氀椀最爀愀洀猀 瀀攀爀 氀椀琀攀爀 ഀഀ
	precipitation  float,  -- Precipitation, total, inches਍ऀ瘀攀氀漀挀椀琀礀       昀氀漀愀琀Ⰰഀഀ
	air  float, cloudcover  float,  pressure  float,  wind  float, winddir  float,  humidity  float,  elevation  float,਍ऀ猀椀搀 戀椀最椀渀琀 椀搀攀渀琀椀琀礀⠀㤀㜀Ⰰ㔀　　⤀ 一伀吀 一唀䰀䰀 倀刀䤀䴀䄀刀夀 䬀䔀夀 䌀䰀唀匀吀䔀刀䔀䐀 ഀഀ
);਍䜀伀ഀഀ
SET IDENTITY_INSERT CTUS097 ON਍䜀伀ഀഀ
ALTER TABLE CTUS097 ADD CONSTRAINT CHECK_CTUS097 CHECK((sid % 500) % 97 = 0) ਍䜀伀ഀഀ
alter table CTUS097 add sid bigint identity(97,500) NOT NULL PRIMARY KEY CLUSTERED ਍ഀഀ
-- alter table CTUS097 add sid bigint identity(97,500) NOT NULL PRIMARY KEY CLUSTERED    ਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开䌀吀唀匀　㤀㜀开洀氀椀崀 伀一 䌀吀唀匀　㤀㜀 ⠀洀氀椀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开䌀吀唀匀　㤀㜀开琀攀洀瀀攀爀愀琀甀爀攀崀 伀一 䌀吀唀匀　㤀㜀 ⠀琀攀洀瀀攀爀愀琀甀爀攀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开䌀吀唀匀　㤀㜀开琀甀爀戀椀搀椀琀礀崀 伀一 䌀吀唀匀　㤀㜀 ⠀琀甀爀戀椀搀椀琀礀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开䌀吀唀匀　㤀㜀开挀漀渀搀甀挀琀愀渀挀攀崀 伀一 䌀吀唀匀　㤀㜀 ⠀挀漀渀搀甀挀琀愀渀挀攀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开䌀吀唀匀　㤀㜀开猀琀愀洀瀀崀 伀一 䌀吀唀匀　㤀㜀 ⠀猀琀愀洀瀀 䐀䔀匀䌀⤀ ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开䌀吀唀匀　㤀㜀开搀椀猀挀栀愀爀最攀崀 伀一 䌀吀唀匀　㤀㜀 ⠀搀椀猀挀栀愀爀最攀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开䌀吀唀匀　㤀㜀开漀砀礀最攀渀崀 伀一 䌀吀唀匀　㤀㜀 ⠀漀砀礀最攀渀 䄀匀䌀⤀ഀഀ
GO  ਍ ⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀഀഀ
CREATE TABLE LAUS101਍⠀ഀഀ
	[mli] varchar(32) NOT NULL,਍ऀ猀琀愀洀瀀 搀愀琀攀琀椀洀攀 一伀吀 一唀䰀䰀Ⰰഀഀ
	temperature    float,  -- Temperature, water, degrees Celsius਍ऀ挀漀渀搀甀挀琀愀渀挀攀    昀氀漀愀琀Ⰰ  ⴀⴀ 匀瀀攀挀椀昀椀挀 挀漀渀搀甀挀琀愀渀挀攀Ⰰ 眀愀琀攀爀Ⰰ 甀渀昀椀氀琀攀爀攀搀Ⰰ 洀椀挀爀漀猀椀攀洀攀渀猀 瀀攀爀 挀攀渀琀椀洀攀琀攀爀 愀琀 ㈀㔀 搀攀最爀攀攀猀 䌀攀氀猀椀甀猀 ഀഀ
	discharge      float,  -- Discharge, cubic feet per second਍ऀ瀀栀             昀氀漀愀琀Ⰰ  ⴀⴀ 瀀䠀Ⰰ 眀愀琀攀爀Ⰰ 甀渀昀椀氀琀攀爀攀搀Ⰰ 昀椀攀氀搀Ⰰ 猀琀愀渀搀愀爀搀 甀渀椀琀猀   ഀഀ
	turbidity      float,  -- unfiltered, monochrome near infra-red LED light, 780-900 nm, detection angle 90 +-2.5 degrees, formazin nephelometric units (FNU) ਍ऀ漀砀礀最攀渀         昀氀漀愀琀Ⰰ  ⴀⴀ 䐀椀猀猀漀氀瘀攀搀 漀砀礀最攀渀Ⰰ 眀愀琀攀爀Ⰰ 甀渀昀椀氀琀攀爀攀搀Ⰰ 洀椀氀氀椀最爀愀洀猀 瀀攀爀 氀椀琀攀爀 ഀഀ
	precipitation  float,  -- Precipitation, total, inches਍ऀ瘀攀氀漀挀椀琀礀       昀氀漀愀琀Ⰰഀഀ
	air  float, cloudcover  float,  pressure  float,  wind  float, winddir  float,  humidity  float,  elevation  float,਍ऀ猀椀搀 戀椀最椀渀琀 椀搀攀渀琀椀琀礀⠀㄀　㄀Ⰰ㔀　　⤀ 一伀吀 一唀䰀䰀 倀刀䤀䴀䄀刀夀 䬀䔀夀 䌀䰀唀匀吀䔀刀䔀䐀 ഀഀ
); ਍䜀伀ഀഀ
SET IDENTITY_INSERT LAUS101 ON਍䜀伀ഀഀ
ALTER TABLE LAUS101 ADD CONSTRAINT CHECK_LAUS101 CHECK((sid % 500) % 101 = 0)਍ⴀⴀ 愀氀琀攀爀 琀愀戀氀攀 䰀䄀唀匀㄀　㄀ 愀搀搀 猀椀搀 戀椀最椀渀琀 椀搀攀渀琀椀琀礀⠀㄀　㄀Ⰰ㔀　　⤀ 一伀吀 一唀䰀䰀 倀刀䤀䴀䄀刀夀 䬀䔀夀 䌀䰀唀匀吀䔀刀䔀䐀    ഀഀ
   ਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开䰀䄀开洀氀椀崀 伀一 䰀䄀唀匀㄀　㄀ ⠀洀氀椀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开䰀䄀开琀攀洀瀀攀爀愀琀甀爀攀崀 伀一 䰀䄀唀匀㄀　㄀ ⠀琀攀洀瀀攀爀愀琀甀爀攀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开䰀䄀开琀甀爀戀椀搀椀琀礀崀 伀一 䰀䄀唀匀㄀　㄀ ⠀琀甀爀戀椀搀椀琀礀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开䰀䄀开挀漀渀搀甀挀琀愀渀挀攀崀 伀一 䰀䄀唀匀㄀　㄀ ⠀挀漀渀搀甀挀琀愀渀挀攀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开䰀䄀开猀琀愀洀瀀崀 伀一 䰀䄀唀匀㄀　㄀ ⠀猀琀愀洀瀀 䐀䔀匀䌀⤀ ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开䰀䄀开搀椀猀挀栀愀爀最攀崀 伀一 䰀䄀唀匀㄀　㄀ ⠀搀椀猀挀栀愀爀最攀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开䰀䄀开漀砀礀最攀渀崀 伀一 䰀䄀唀匀㄀　㄀ ⠀漀砀礀最攀渀 䄀匀䌀⤀ഀഀ
GO   ਍ ⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀഀഀ
CREATE TABLE NJUS103਍⠀ഀഀ
	[mli] varchar(32) NOT NULL,਍ऀ猀琀愀洀瀀 搀愀琀攀琀椀洀攀 一伀吀 一唀䰀䰀Ⰰഀഀ
	temperature    float,  -- Temperature, water, degrees Celsius਍ऀ挀漀渀搀甀挀琀愀渀挀攀    昀氀漀愀琀Ⰰ  ⴀⴀ 匀瀀攀挀椀昀椀挀 挀漀渀搀甀挀琀愀渀挀攀Ⰰ 眀愀琀攀爀Ⰰ 甀渀昀椀氀琀攀爀攀搀Ⰰ 洀椀挀爀漀猀椀攀洀攀渀猀 瀀攀爀 挀攀渀琀椀洀攀琀攀爀 愀琀 ㈀㔀 搀攀最爀攀攀猀 䌀攀氀猀椀甀猀 ഀഀ
	discharge      float,  -- Discharge, cubic feet per second਍ऀ瀀栀             昀氀漀愀琀Ⰰ  ⴀⴀ 瀀䠀Ⰰ 眀愀琀攀爀Ⰰ 甀渀昀椀氀琀攀爀攀搀Ⰰ 昀椀攀氀搀Ⰰ 猀琀愀渀搀愀爀搀 甀渀椀琀猀   ഀഀ
	turbidity      float,  -- unfiltered, monochrome near infra-red LED light, 780-900 nm, detection angle 90 +-2.5 degrees, formazin nephelometric units (FNU) ਍ऀ漀砀礀最攀渀         昀氀漀愀琀Ⰰ  ⴀⴀ 䐀椀猀猀漀氀瘀攀搀 漀砀礀最攀渀Ⰰ 眀愀琀攀爀Ⰰ 甀渀昀椀氀琀攀爀攀搀Ⰰ 洀椀氀氀椀最爀愀洀猀 瀀攀爀 氀椀琀攀爀 ഀഀ
	precipitation  float,  -- Precipitation, total, inches਍ऀ瘀攀氀漀挀椀琀礀       昀氀漀愀琀Ⰰഀഀ
	air  float, cloudcover  float,  pressure  float,  wind  float, winddir  float,  humidity  float,  elevation  float,਍ऀ猀椀搀 戀椀最椀渀琀 椀搀攀渀琀椀琀礀⠀㄀　㌀Ⰰ㔀　　⤀ 一伀吀 一唀䰀䰀 倀刀䤀䴀䄀刀夀 䬀䔀夀 䌀䰀唀匀吀䔀刀䔀䐀 ഀഀ
); ਍䜀伀ഀഀ
SET IDENTITY_INSERT NJUS103 ON਍䜀伀ഀഀ
ALTER TABLE NJUS103 ADD CONSTRAINT CHECK_NJUS103 CHECK((sid % 500) % 103 = 0)਍ⴀⴀ 愀氀琀攀爀 琀愀戀氀攀 一䨀唀匀㄀　㌀ 愀搀搀 猀椀搀 戀椀最椀渀琀 椀搀攀渀琀椀琀礀⠀㄀　㌀Ⰰ㔀　　⤀ 一伀吀 一唀䰀䰀 倀刀䤀䴀䄀刀夀 䬀䔀夀 䌀䰀唀匀吀䔀刀䔀䐀    ഀഀ
 ਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开一䨀开洀氀椀崀 伀一 一䨀唀匀㄀　㌀ ⠀洀氀椀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开一䨀开琀攀洀瀀攀爀愀琀甀爀攀崀 伀一 一䨀唀匀㄀　㌀ ⠀琀攀洀瀀攀爀愀琀甀爀攀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开一䨀开琀甀爀戀椀搀椀琀礀崀 伀一 一䨀唀匀㄀　㌀ ⠀琀甀爀戀椀搀椀琀礀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开一䨀开挀漀渀搀甀挀琀愀渀挀攀崀 伀一 一䨀唀匀㄀　㌀ ⠀挀漀渀搀甀挀琀愀渀挀攀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开一䨀开猀琀愀洀瀀崀 伀一 一䨀唀匀㄀　㌀ ⠀猀琀愀洀瀀 䐀䔀匀䌀⤀ ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开一䨀开搀椀猀挀栀愀爀最攀崀 伀一 一䨀唀匀㄀　㌀ ⠀搀椀猀挀栀愀爀最攀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开一䨀开漀砀礀最攀渀崀 伀一 一䨀唀匀㄀　㌀ ⠀漀砀礀最攀渀 䄀匀䌀⤀ഀഀ
GO     ਍ ⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀഀഀ
CREATE TABLE MOUS107਍⠀ഀഀ
	[mli] varchar(32) NOT NULL,਍ऀ猀琀愀洀瀀 搀愀琀攀琀椀洀攀 一伀吀 一唀䰀䰀Ⰰഀഀ
	temperature    float,  -- Temperature, water, degrees Celsius਍ऀ挀漀渀搀甀挀琀愀渀挀攀    昀氀漀愀琀Ⰰ  ⴀⴀ 匀瀀攀挀椀昀椀挀 挀漀渀搀甀挀琀愀渀挀攀Ⰰ 眀愀琀攀爀Ⰰ 甀渀昀椀氀琀攀爀攀搀Ⰰ 洀椀挀爀漀猀椀攀洀攀渀猀 瀀攀爀 挀攀渀琀椀洀攀琀攀爀 愀琀 ㈀㔀 搀攀最爀攀攀猀 䌀攀氀猀椀甀猀 ഀഀ
	discharge      float,  -- Discharge, cubic feet per second਍ऀ瀀栀             昀氀漀愀琀Ⰰ  ⴀⴀ 瀀䠀Ⰰ 眀愀琀攀爀Ⰰ 甀渀昀椀氀琀攀爀攀搀Ⰰ 昀椀攀氀搀Ⰰ 猀琀愀渀搀愀爀搀 甀渀椀琀猀   ഀഀ
	turbidity      float,  -- unfiltered, monochrome near infra-red LED light, 780-900 nm, detection angle 90 +-2.5 degrees, formazin nephelometric units (FNU) ਍ऀ漀砀礀最攀渀         昀氀漀愀琀Ⰰ  ⴀⴀ 䐀椀猀猀漀氀瘀攀搀 漀砀礀最攀渀Ⰰ 眀愀琀攀爀Ⰰ 甀渀昀椀氀琀攀爀攀搀Ⰰ 洀椀氀氀椀最爀愀洀猀 瀀攀爀 氀椀琀攀爀 ഀഀ
	precipitation  float,  -- Precipitation, total, inches਍ऀ瘀攀氀漀挀椀琀礀       昀氀漀愀琀Ⰰഀഀ
	air  float, cloudcover  float,  pressure  float,  wind  float, winddir  float,  humidity  float,  elevation  float,਍ऀ猀椀搀 戀椀最椀渀琀 椀搀攀渀琀椀琀礀⠀㄀　㜀Ⰰ㔀　　⤀ 一伀吀 一唀䰀䰀 倀刀䤀䴀䄀刀夀 䬀䔀夀 䌀䰀唀匀吀䔀刀䔀䐀 ഀഀ
); ਍䜀伀ഀഀ
SET IDENTITY_INSERT MOUS107 ON਍䜀伀ഀഀ
ALTER TABLE MOUS107 ADD CONSTRAINT CHECK_MOUS107 CHECK((sid % 500) % 107 = 0)਍ⴀⴀ 愀氀琀攀爀 琀愀戀氀攀 䴀伀唀匀㄀　㜀 愀搀搀 猀椀搀 戀椀最椀渀琀 椀搀攀渀琀椀琀礀⠀㄀　㜀Ⰰ㔀　　⤀ 一伀吀 一唀䰀䰀 倀刀䤀䴀䄀刀夀 䬀䔀夀 䌀䰀唀匀吀䔀刀䔀䐀    ഀഀ
   ਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开䴀伀开洀氀椀崀 伀一 䴀伀唀匀㄀　㜀 ⠀洀氀椀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开䴀伀开琀攀洀瀀攀爀愀琀甀爀攀崀 伀一 䴀伀唀匀㄀　㜀 ⠀琀攀洀瀀攀爀愀琀甀爀攀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开䴀伀开琀甀爀戀椀搀椀琀礀崀 伀一 䴀伀唀匀㄀　㜀 ⠀琀甀爀戀椀搀椀琀礀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开䴀伀开挀漀渀搀甀挀琀愀渀挀攀崀 伀一 䴀伀唀匀㄀　㜀 ⠀挀漀渀搀甀挀琀愀渀挀攀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开䴀伀开猀琀愀洀瀀崀 伀一 䴀伀唀匀㄀　㜀 ⠀猀琀愀洀瀀 䐀䔀匀䌀⤀ ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开䴀伀开搀椀猀挀栀愀爀最攀崀 伀一 䴀伀唀匀㄀　㜀 ⠀搀椀猀挀栀愀爀最攀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开䴀伀开漀砀礀最攀渀崀 伀一 䴀伀唀匀㄀　㜀 ⠀漀砀礀最攀渀 䄀匀䌀⤀ഀഀ
GO                  ਍ ⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀഀഀ
CREATE TABLE CAUS109਍⠀ഀഀ
	[mli] varchar(32) NOT NULL,਍ऀ猀琀愀洀瀀 搀愀琀攀琀椀洀攀 一伀吀 一唀䰀䰀Ⰰഀഀ
	temperature    float,  -- Temperature, water, degrees Celsius਍ऀ挀漀渀搀甀挀琀愀渀挀攀    昀氀漀愀琀Ⰰ  ⴀⴀ 匀瀀攀挀椀昀椀挀 挀漀渀搀甀挀琀愀渀挀攀Ⰰ 眀愀琀攀爀Ⰰ 甀渀昀椀氀琀攀爀攀搀Ⰰ 洀椀挀爀漀猀椀攀洀攀渀猀 瀀攀爀 挀攀渀琀椀洀攀琀攀爀 愀琀 ㈀㔀 搀攀最爀攀攀猀 䌀攀氀猀椀甀猀 ഀഀ
	discharge      float,  -- Discharge, cubic feet per second਍ऀ瀀栀             昀氀漀愀琀Ⰰ  ⴀⴀ 瀀䠀Ⰰ 眀愀琀攀爀Ⰰ 甀渀昀椀氀琀攀爀攀搀Ⰰ 昀椀攀氀搀Ⰰ 猀琀愀渀搀愀爀搀 甀渀椀琀猀   ഀഀ
	turbidity      float,  -- unfiltered, monochrome near infra-red LED light, 780-900 nm, detection angle 90 +-2.5 degrees, formazin nephelometric units (FNU) ਍ऀ漀砀礀最攀渀         昀氀漀愀琀Ⰰ  ⴀⴀ 䐀椀猀猀漀氀瘀攀搀 漀砀礀最攀渀Ⰰ 眀愀琀攀爀Ⰰ 甀渀昀椀氀琀攀爀攀搀Ⰰ 洀椀氀氀椀最爀愀洀猀 瀀攀爀 氀椀琀攀爀 ഀഀ
	precipitation  float,  -- Precipitation, total, inches਍ऀ瘀攀氀漀挀椀琀礀       昀氀漀愀琀Ⰰഀഀ
	air  float, cloudcover  float,  pressure  float,  wind  float, winddir  float,  humidity  float,  elevation  float,਍ऀ猀椀搀 戀椀最椀渀琀 椀搀攀渀琀椀琀礀⠀㄀　㤀Ⰰ㔀　　⤀ 一伀吀 一唀䰀䰀 倀刀䤀䴀䄀刀夀 䬀䔀夀 䌀䰀唀匀吀䔀刀䔀䐀 ഀഀ
); ਍䜀伀ഀഀ
SET IDENTITY_INSERT CAUS109 ON਍䜀伀ഀഀ
ALTER TABLE CAUS109 ADD CONSTRAINT CHECK_CAUS109 CHECK((sid % 500) % 109 = 0)਍ⴀⴀ 愀氀琀攀爀 琀愀戀氀攀 䌀䄀唀匀㄀　㤀 愀搀搀 猀椀搀 戀椀最椀渀琀 椀搀攀渀琀椀琀礀⠀㄀　㤀Ⰰ㔀　　⤀ 一伀吀 一唀䰀䰀 倀刀䤀䴀䄀刀夀 䬀䔀夀 䌀䰀唀匀吀䔀刀䔀䐀    ഀഀ
 ਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开䌀䄀唀匀㄀　㤀开洀氀椀崀 伀一 䌀䄀唀匀㄀　㤀 ⠀洀氀椀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开䌀䄀唀匀㄀　㤀开琀攀洀瀀攀爀愀琀甀爀攀崀 伀一 䌀䄀唀匀㄀　㤀 ⠀琀攀洀瀀攀爀愀琀甀爀攀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开䌀䄀唀匀㄀　㤀开琀甀爀戀椀搀椀琀礀崀 伀一 䌀䄀唀匀㄀　㤀 ⠀琀甀爀戀椀搀椀琀礀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开䌀䄀唀匀㄀　㤀开挀漀渀搀甀挀琀愀渀挀攀崀 伀一 䌀䄀唀匀㄀　㤀 ⠀挀漀渀搀甀挀琀愀渀挀攀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开䌀䄀唀匀㄀　㤀开猀琀愀洀瀀崀 伀一 䌀䄀唀匀㄀　㤀 ⠀猀琀愀洀瀀 䐀䔀匀䌀⤀ ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开䌀䄀唀匀㄀　㤀开搀椀猀挀栀愀爀最攀崀 伀一 䌀䄀唀匀㄀　㤀 ⠀搀椀猀挀栀愀爀最攀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开䌀䄀唀匀㄀　㤀开漀砀礀最攀渀崀 伀一 䌀䄀唀匀㄀　㤀 ⠀漀砀礀最攀渀 䄀匀䌀⤀ഀഀ
GO              ਍ ⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀഀഀ
CREATE TABLE ORUS113਍⠀ഀഀ
	[mli] varchar(32) NOT NULL,਍ऀ猀琀愀洀瀀 搀愀琀攀琀椀洀攀 一伀吀 一唀䰀䰀Ⰰഀഀ
	temperature    float,  -- Temperature, water, degrees Celsius਍ऀ挀漀渀搀甀挀琀愀渀挀攀    昀氀漀愀琀Ⰰ  ⴀⴀ 匀瀀攀挀椀昀椀挀 挀漀渀搀甀挀琀愀渀挀攀Ⰰ 眀愀琀攀爀Ⰰ 甀渀昀椀氀琀攀爀攀搀Ⰰ 洀椀挀爀漀猀椀攀洀攀渀猀 瀀攀爀 挀攀渀琀椀洀攀琀攀爀 愀琀 ㈀㔀 搀攀最爀攀攀猀 䌀攀氀猀椀甀猀 ഀഀ
	discharge      float,  -- Discharge, cubic feet per second਍ऀ瀀栀             昀氀漀愀琀Ⰰ  ⴀⴀ 瀀䠀Ⰰ 眀愀琀攀爀Ⰰ 甀渀昀椀氀琀攀爀攀搀Ⰰ 昀椀攀氀搀Ⰰ 猀琀愀渀搀愀爀搀 甀渀椀琀猀   ഀഀ
	turbidity      float,  -- unfiltered, monochrome near infra-red LED light, 780-900 nm, detection angle 90 +-2.5 degrees, formazin nephelometric units (FNU) ਍ऀ漀砀礀最攀渀         昀氀漀愀琀Ⰰ  ⴀⴀ 䐀椀猀猀漀氀瘀攀搀 漀砀礀最攀渀Ⰰ 眀愀琀攀爀Ⰰ 甀渀昀椀氀琀攀爀攀搀Ⰰ 洀椀氀氀椀最爀愀洀猀 瀀攀爀 氀椀琀攀爀 ഀഀ
	precipitation  float,  -- Precipitation, total, inches਍ऀ瘀攀氀漀挀椀琀礀       昀氀漀愀琀Ⰰഀഀ
	air  float, cloudcover  float,  pressure  float,  wind  float, winddir  float,  humidity  float,  elevation  float,਍ऀ猀椀搀 戀椀最椀渀琀 椀搀攀渀琀椀琀礀⠀㄀㄀㌀Ⰰ㔀　　⤀ 一伀吀 一唀䰀䰀 倀刀䤀䴀䄀刀夀 䬀䔀夀 䌀䰀唀匀吀䔀刀䔀䐀 ഀഀ
); ਍䜀伀ഀഀ
SET IDENTITY_INSERT ORUS113 ON਍䜀伀ഀഀ
ALTER TABLE ORUS113 ADD CONSTRAINT CHECK_ORUS113 CHECK((sid % 500) % 113 = 0)਍ⴀⴀ 愀氀琀攀爀 琀愀戀氀攀 伀刀唀匀㄀㄀㌀ 愀搀搀 猀椀搀 戀椀最椀渀琀 椀搀攀渀琀椀琀礀⠀㄀㄀㌀Ⰰ㔀　　⤀ 一伀吀 一唀䰀䰀 倀刀䤀䴀䄀刀夀 䬀䔀夀 䌀䰀唀匀吀䔀刀䔀䐀    ഀഀ
  ਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开伀刀唀匀㄀㄀㌀开洀氀椀崀 伀一 伀刀唀匀㄀㄀㌀ ⠀洀氀椀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开伀刀唀匀㄀㄀㌀开琀攀洀瀀攀爀愀琀甀爀攀崀 伀一 伀刀唀匀㄀㄀㌀ ⠀琀攀洀瀀攀爀愀琀甀爀攀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开伀刀唀匀㄀㄀㌀开琀甀爀戀椀搀椀琀礀崀 伀一 伀刀唀匀㄀㄀㌀ ⠀琀甀爀戀椀搀椀琀礀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开伀刀唀匀㄀㄀㌀开挀漀渀搀甀挀琀愀渀挀攀崀 伀一 伀刀唀匀㄀㄀㌀ ⠀挀漀渀搀甀挀琀愀渀挀攀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开伀刀唀匀㄀㄀㌀开猀琀愀洀瀀崀 伀一 伀刀唀匀㄀㄀㌀ ⠀猀琀愀洀瀀 䐀䔀匀䌀⤀ ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开伀刀唀匀㄀㄀㌀开搀椀猀挀栀愀爀最攀崀 伀一 伀刀唀匀㄀㄀㌀ ⠀搀椀猀挀栀愀爀最攀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开伀刀唀匀㄀㄀㌀开漀砀礀最攀渀崀 伀一 伀刀唀匀㄀㄀㌀ ⠀漀砀礀最攀渀 䄀匀䌀⤀ഀഀ
GO    ਍ ⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀഀഀ
CREATE TABLE MNUS127਍⠀ഀഀ
	[mli] varchar(32) NOT NULL,਍ऀ猀琀愀洀瀀 搀愀琀攀琀椀洀攀 一伀吀 一唀䰀䰀Ⰰഀഀ
	temperature    float,  -- Temperature, water, degrees Celsius਍ऀ挀漀渀搀甀挀琀愀渀挀攀    昀氀漀愀琀Ⰰ  ⴀⴀ 匀瀀攀挀椀昀椀挀 挀漀渀搀甀挀琀愀渀挀攀Ⰰ 眀愀琀攀爀Ⰰ 甀渀昀椀氀琀攀爀攀搀Ⰰ 洀椀挀爀漀猀椀攀洀攀渀猀 瀀攀爀 挀攀渀琀椀洀攀琀攀爀 愀琀 ㈀㔀 搀攀最爀攀攀猀 䌀攀氀猀椀甀猀 ഀഀ
	discharge      float,  -- Discharge, cubic feet per second਍ऀ瀀栀             昀氀漀愀琀Ⰰ  ⴀⴀ 瀀䠀Ⰰ 眀愀琀攀爀Ⰰ 甀渀昀椀氀琀攀爀攀搀Ⰰ 昀椀攀氀搀Ⰰ 猀琀愀渀搀愀爀搀 甀渀椀琀猀   ഀഀ
	turbidity      float,  -- unfiltered, monochrome near infra-red LED light, 780-900 nm, detection angle 90 +-2.5 degrees, formazin nephelometric units (FNU) ਍ऀ漀砀礀最攀渀         昀氀漀愀琀Ⰰ  ⴀⴀ 䐀椀猀猀漀氀瘀攀搀 漀砀礀最攀渀Ⰰ 眀愀琀攀爀Ⰰ 甀渀昀椀氀琀攀爀攀搀Ⰰ 洀椀氀氀椀最爀愀洀猀 瀀攀爀 氀椀琀攀爀 ഀഀ
	precipitation  float,  -- Precipitation, total, inches਍ऀ瘀攀氀漀挀椀琀礀       昀氀漀愀琀Ⰰഀഀ
	air  float, cloudcover  float,  pressure  float,  wind  float, winddir  float,  humidity  float,  elevation  float,਍ऀ猀椀搀 戀椀最椀渀琀 椀搀攀渀琀椀琀礀⠀㄀㈀㜀Ⰰ㔀　　⤀ 一伀吀 一唀䰀䰀 倀刀䤀䴀䄀刀夀 䬀䔀夀 䌀䰀唀匀吀䔀刀䔀䐀 ഀഀ
); ਍䜀伀ഀഀ
SET IDENTITY_INSERT MNUS127 ON਍䜀伀ഀഀ
ALTER TABLE MNUS127 ADD CONSTRAINT CHECK_MNUS127 CHECK((sid % 500) % 127 = 0)਍ⴀⴀ 愀氀琀攀爀 琀愀戀氀攀 䴀一唀匀㄀㈀㜀 愀搀搀 猀椀搀 戀椀最椀渀琀 椀搀攀渀琀椀琀礀⠀㄀㈀㜀Ⰰ㔀　　⤀ 一伀吀 一唀䰀䰀 倀刀䤀䴀䄀刀夀 䬀䔀夀 䌀䰀唀匀吀䔀刀䔀䐀    ഀഀ
CREATE NONCLUSTERED INDEX [idx_MN_mli] ON MNUS127 (mli ASC)਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_MN_temperature] ON MNUS127 (temperature ASC)਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_MN_turbidity] ON MNUS127 (turbidity ASC)਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_MN_conductance] ON MNUS127 (conductance ASC)਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_MN_stamp] ON MNUS127 (stamp DESC) ਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_MN_discharge] ON MNUS127 (discharge ASC)਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_MN_oxygen] ON MNUS127 (oxygen ASC)਍䜀伀   ഀഀ
 ------------------------------------------------------------------------------------------------਍䌀刀䔀䄀吀䔀 吀䄀䈀䰀䔀 䴀吀唀匀㄀㌀㄀ഀഀ
(਍ऀ嬀洀氀椀崀 瘀愀爀挀栀愀爀⠀㌀㈀⤀ 一伀吀 一唀䰀䰀Ⰰഀഀ
	stamp datetime NOT NULL,਍ऀ琀攀洀瀀攀爀愀琀甀爀攀    昀氀漀愀琀Ⰰ  ⴀⴀ 吀攀洀瀀攀爀愀琀甀爀攀Ⰰ 眀愀琀攀爀Ⰰ 搀攀最爀攀攀猀 䌀攀氀猀椀甀猀ഀഀ
	conductance    float,  -- Specific conductance, water, unfiltered, microsiemens per centimeter at 25 degrees Celsius ਍ऀ搀椀猀挀栀愀爀最攀      昀氀漀愀琀Ⰰ  ⴀⴀ 䐀椀猀挀栀愀爀最攀Ⰰ 挀甀戀椀挀 昀攀攀琀 瀀攀爀 猀攀挀漀渀搀ഀഀ
	ph             float,  -- pH, water, unfiltered, field, standard units   ਍ऀ琀甀爀戀椀搀椀琀礀      昀氀漀愀琀Ⰰ  ⴀⴀ 甀渀昀椀氀琀攀爀攀搀Ⰰ 洀漀渀漀挀栀爀漀洀攀 渀攀愀爀 椀渀昀爀愀ⴀ爀攀搀 䰀䔀䐀 氀椀最栀琀Ⰰ 㜀㠀　ⴀ㤀　　 渀洀Ⰰ 搀攀琀攀挀琀椀漀渀 愀渀最氀攀 㤀　 ⬀ⴀ㈀⸀㔀 搀攀最爀攀攀猀Ⰰ 昀漀爀洀愀稀椀渀 渀攀瀀栀攀氀漀洀攀琀爀椀挀 甀渀椀琀猀 ⠀䘀一唀⤀ ഀഀ
	oxygen         float,  -- Dissolved oxygen, water, unfiltered, milligrams per liter ਍ऀ瀀爀攀挀椀瀀椀琀愀琀椀漀渀  昀氀漀愀琀Ⰰ  ⴀⴀ 倀爀攀挀椀瀀椀琀愀琀椀漀渀Ⰰ 琀漀琀愀氀Ⰰ 椀渀挀栀攀猀ഀഀ
	velocity       float,਍ऀ愀椀爀  昀氀漀愀琀Ⰰ 挀氀漀甀搀挀漀瘀攀爀  昀氀漀愀琀Ⰰ  瀀爀攀猀猀甀爀攀  昀氀漀愀琀Ⰰ  眀椀渀搀  昀氀漀愀琀Ⰰ 眀椀渀搀搀椀爀  昀氀漀愀琀Ⰰ  栀甀洀椀搀椀琀礀  昀氀漀愀琀Ⰰ  攀氀攀瘀愀琀椀漀渀  昀氀漀愀琀Ⰰഀഀ
	sid bigint identity(131,500) NOT NULL PRIMARY KEY CLUSTERED ਍⤀㬀ഀഀ
GO ਍匀䔀吀 䤀䐀䔀一吀䤀吀夀开䤀一匀䔀刀吀 䴀吀唀匀㄀㌀㄀ 伀一ഀഀ
GO਍䄀䰀吀䔀刀 吀䄀䈀䰀䔀 䴀吀唀匀㄀㌀㄀ 䄀䐀䐀 䌀伀一匀吀刀䄀䤀一吀 䌀䠀䔀䌀䬀开䴀吀唀匀㄀㌀㄀ 䌀䠀䔀䌀䬀⠀⠀猀椀搀 ─ 㔀　　⤀ ─ ㄀㌀㄀ 㴀 　⤀ഀഀ
-- alter table MTUS131 add sid bigint identity(131,500) NOT NULL PRIMARY KEY CLUSTERED    ਍   ഀഀ
CREATE NONCLUSTERED INDEX [idx_MT_mli] ON MTUS131 (mli ASC)਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_MT_temperature] ON MTUS131 (temperature ASC)਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_MT_turbidity] ON MTUS131 (turbidity ASC)਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_MT_conductance] ON MTUS131 (conductance ASC)਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_MT_stamp] ON MTUS131 (stamp DESC) ਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_MT_discharge] ON MTUS131 (discharge ASC)਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_MT_oxygen] ON MTUS131 (oxygen ASC)਍䜀伀ഀഀ
 ------------------------------------------------------------------------------------------------਍䌀刀䔀䄀吀䔀 吀䄀䈀䰀䔀 伀䬀唀匀㄀㌀㜀ഀഀ
(਍ऀ嬀洀氀椀崀 瘀愀爀挀栀愀爀⠀㌀㈀⤀ 一伀吀 一唀䰀䰀Ⰰഀഀ
	stamp datetime NOT NULL,਍ऀ琀攀洀瀀攀爀愀琀甀爀攀    昀氀漀愀琀Ⰰ  ⴀⴀ 吀攀洀瀀攀爀愀琀甀爀攀Ⰰ 眀愀琀攀爀Ⰰ 搀攀最爀攀攀猀 䌀攀氀猀椀甀猀ഀഀ
	conductance    float,  -- Specific conductance, water, unfiltered, microsiemens per centimeter at 25 degrees Celsius ਍ऀ搀椀猀挀栀愀爀最攀      昀氀漀愀琀Ⰰ  ⴀⴀ 䐀椀猀挀栀愀爀最攀Ⰰ 挀甀戀椀挀 昀攀攀琀 瀀攀爀 猀攀挀漀渀搀ഀഀ
	ph             float,  -- pH, water, unfiltered, field, standard units   ਍ऀ琀甀爀戀椀搀椀琀礀      昀氀漀愀琀Ⰰ  ⴀⴀ 甀渀昀椀氀琀攀爀攀搀Ⰰ 洀漀渀漀挀栀爀漀洀攀 渀攀愀爀 椀渀昀爀愀ⴀ爀攀搀 䰀䔀䐀 氀椀最栀琀Ⰰ 㜀㠀　ⴀ㤀　　 渀洀Ⰰ 搀攀琀攀挀琀椀漀渀 愀渀最氀攀 㤀　 ⬀ⴀ㈀⸀㔀 搀攀最爀攀攀猀Ⰰ 昀漀爀洀愀稀椀渀 渀攀瀀栀攀氀漀洀攀琀爀椀挀 甀渀椀琀猀 ⠀䘀一唀⤀ ഀഀ
	oxygen         float,  -- Dissolved oxygen, water, unfiltered, milligrams per liter ਍ऀ瀀爀攀挀椀瀀椀琀愀琀椀漀渀  昀氀漀愀琀Ⰰ  ⴀⴀ 倀爀攀挀椀瀀椀琀愀琀椀漀渀Ⰰ 琀漀琀愀氀Ⰰ 椀渀挀栀攀猀ഀഀ
	velocity       float,਍ऀ愀椀爀  昀氀漀愀琀Ⰰ 挀氀漀甀搀挀漀瘀攀爀  昀氀漀愀琀Ⰰ  瀀爀攀猀猀甀爀攀  昀氀漀愀琀Ⰰ  眀椀渀搀  昀氀漀愀琀Ⰰ 眀椀渀搀搀椀爀  昀氀漀愀琀Ⰰ  栀甀洀椀搀椀琀礀  昀氀漀愀琀Ⰰ  攀氀攀瘀愀琀椀漀渀  昀氀漀愀琀Ⰰഀഀ
	sid bigint identity(137,500) NOT NULL PRIMARY KEY CLUSTERED ਍⤀㬀 ഀഀ
GO ਍匀䔀吀 䤀䐀䔀一吀䤀吀夀开䤀一匀䔀刀吀 伀䬀唀匀㄀㌀㜀 伀一ഀഀ
GO਍䄀䰀吀䔀刀 吀䄀䈀䰀䔀 伀䬀唀匀㄀㌀㜀 䄀䐀䐀 䌀伀一匀吀刀䄀䤀一吀 䌀䠀䔀䌀䬀开伀䬀唀匀㄀㌀㜀 䌀䠀䔀䌀䬀⠀⠀猀椀搀 ─ 㔀　　⤀ ─ ㄀㌀㜀 㴀 　⤀ഀഀ
-- alter table OKUS137 add sid bigint identity(137,500) NOT NULL PRIMARY KEY CLUSTERED    ਍   ഀഀ
CREATE NONCLUSTERED INDEX [idx_OK_mli] ON OKUS137 (mli ASC)਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_OK_temperature] ON OKUS137 (temperature ASC)਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_OK_turbidity] ON OKUS137 (turbidity ASC)਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_OK_conductance] ON OKUS137 (conductance ASC)਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_OK_stamp] ON OKUS137 (stamp DESC) ਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_OK_discharge] ON OKUS137 (discharge ASC)਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_OK_oxygen] ON OKUS137 (oxygen ASC)਍䜀伀   ഀഀ
 ------------------------------------------------------------------------------------------------਍䌀刀䔀䄀吀䔀 吀䄀䈀䰀䔀 䘀䰀唀匀㄀㌀㤀ഀഀ
(਍ऀ嬀洀氀椀崀 瘀愀爀挀栀愀爀⠀㌀㈀⤀ 一伀吀 一唀䰀䰀Ⰰഀഀ
	stamp datetime NOT NULL,਍ऀ琀攀洀瀀攀爀愀琀甀爀攀    昀氀漀愀琀Ⰰ  ⴀⴀ 吀攀洀瀀攀爀愀琀甀爀攀Ⰰ 眀愀琀攀爀Ⰰ 搀攀最爀攀攀猀 䌀攀氀猀椀甀猀ഀഀ
	conductance    float,  -- Specific conductance, water, unfiltered, microsiemens per centimeter at 25 degrees Celsius ਍ऀ搀椀猀挀栀愀爀最攀      昀氀漀愀琀Ⰰ  ⴀⴀ 䐀椀猀挀栀愀爀最攀Ⰰ 挀甀戀椀挀 昀攀攀琀 瀀攀爀 猀攀挀漀渀搀ഀഀ
	ph             float,  -- pH, water, unfiltered, field, standard units   ਍ऀ琀甀爀戀椀搀椀琀礀      昀氀漀愀琀Ⰰ  ⴀⴀ 甀渀昀椀氀琀攀爀攀搀Ⰰ 洀漀渀漀挀栀爀漀洀攀 渀攀愀爀 椀渀昀爀愀ⴀ爀攀搀 䰀䔀䐀 氀椀最栀琀Ⰰ 㜀㠀　ⴀ㤀　　 渀洀Ⰰ 搀攀琀攀挀琀椀漀渀 愀渀最氀攀 㤀　 ⬀ⴀ㈀⸀㔀 搀攀最爀攀攀猀Ⰰ 昀漀爀洀愀稀椀渀 渀攀瀀栀攀氀漀洀攀琀爀椀挀 甀渀椀琀猀 ⠀䘀一唀⤀ ഀഀ
	oxygen         float,  -- Dissolved oxygen, water, unfiltered, milligrams per liter ਍ऀ瀀爀攀挀椀瀀椀琀愀琀椀漀渀  昀氀漀愀琀Ⰰ  ⴀⴀ 倀爀攀挀椀瀀椀琀愀琀椀漀渀Ⰰ 琀漀琀愀氀Ⰰ 椀渀挀栀攀猀ഀഀ
	velocity       float,਍ऀ愀椀爀  昀氀漀愀琀Ⰰ 挀氀漀甀搀挀漀瘀攀爀  昀氀漀愀琀Ⰰ  瀀爀攀猀猀甀爀攀  昀氀漀愀琀Ⰰ  眀椀渀搀  昀氀漀愀琀Ⰰ 眀椀渀搀搀椀爀  昀氀漀愀琀Ⰰ  栀甀洀椀搀椀琀礀  昀氀漀愀琀Ⰰ  攀氀攀瘀愀琀椀漀渀  昀氀漀愀琀Ⰰഀഀ
	sid bigint identity(139,1500) NOT NULL PRIMARY KEY CLUSTERED ਍⤀㬀 ഀഀ
GO ਍匀䔀吀 䤀䐀䔀一吀䤀吀夀开䤀一匀䔀刀吀 䘀䰀唀匀㄀㌀㤀 伀一ഀഀ
GO਍䄀䰀吀䔀刀 吀䄀䈀䰀䔀 䘀䰀唀匀㄀㌀㤀 䄀䐀䐀 䌀伀一匀吀刀䄀䤀一吀 䌀䠀䔀䌀䬀开伀䬀唀匀㄀㌀㤀 䌀䠀䔀䌀䬀⠀⠀猀椀搀 ─ 㔀　　⤀ ─ ㄀㌀㤀 㴀 　⤀ഀഀ
-- alter table FLUS139 add sid bigint identity(139,500) NOT NULL PRIMARY KEY CLUSTERED    ਍   ഀഀ
CREATE NONCLUSTERED INDEX [idx_FLUS139_mli] ON FLUS139 (mli ASC)਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_FLUS139_temperature] ON FLUS139 (temperature ASC)਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_FLUS139_turbidity] ON FLUS139 (turbidity ASC)਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_FLUS139_conductance] ON FLUS139 (conductance ASC)਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_FLUS139_stamp] ON FLUS139 (stamp DESC) ਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_FLUS139_discharge] ON FLUS139 (discharge ASC)਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_FLUS139_oxygen] ON FLUS139 (oxygen ASC)਍䜀伀ഀഀ
 ------------------------------------------------------------------------------------------------਍䌀刀䔀䄀吀䔀 吀䄀䈀䰀䔀 䄀刀唀匀㄀㐀㤀ഀഀ
(਍ऀ嬀洀氀椀崀 瘀愀爀挀栀愀爀⠀㌀㈀⤀ 一伀吀 一唀䰀䰀Ⰰഀഀ
	stamp datetime NOT NULL,਍ऀ琀攀洀瀀攀爀愀琀甀爀攀    昀氀漀愀琀Ⰰ  ⴀⴀ 吀攀洀瀀攀爀愀琀甀爀攀Ⰰ 眀愀琀攀爀Ⰰ 搀攀最爀攀攀猀 䌀攀氀猀椀甀猀ഀഀ
	conductance    float,  -- Specific conductance, water, unfiltered, microsiemens per centimeter at 25 degrees Celsius ਍ऀ搀椀猀挀栀愀爀最攀      昀氀漀愀琀Ⰰ  ⴀⴀ 䐀椀猀挀栀愀爀最攀Ⰰ 挀甀戀椀挀 昀攀攀琀 瀀攀爀 猀攀挀漀渀搀ഀഀ
	ph             float,  -- pH, water, unfiltered, field, standard units   ਍ऀ琀甀爀戀椀搀椀琀礀      昀氀漀愀琀Ⰰ  ⴀⴀ 甀渀昀椀氀琀攀爀攀搀Ⰰ 洀漀渀漀挀栀爀漀洀攀 渀攀愀爀 椀渀昀爀愀ⴀ爀攀搀 䰀䔀䐀 氀椀最栀琀Ⰰ 㜀㠀　ⴀ㤀　　 渀洀Ⰰ 搀攀琀攀挀琀椀漀渀 愀渀最氀攀 㤀　 ⬀ⴀ㈀⸀㔀 搀攀最爀攀攀猀Ⰰ 昀漀爀洀愀稀椀渀 渀攀瀀栀攀氀漀洀攀琀爀椀挀 甀渀椀琀猀 ⠀䘀一唀⤀ ഀഀ
	oxygen         float,  -- Dissolved oxygen, water, unfiltered, milligrams per liter ਍ऀ瀀爀攀挀椀瀀椀琀愀琀椀漀渀  昀氀漀愀琀Ⰰ  ⴀⴀ 倀爀攀挀椀瀀椀琀愀琀椀漀渀Ⰰ 琀漀琀愀氀Ⰰ 椀渀挀栀攀猀ഀഀ
	velocity       float,਍ऀ愀椀爀  昀氀漀愀琀Ⰰ 挀氀漀甀搀挀漀瘀攀爀  昀氀漀愀琀Ⰰ  瀀爀攀猀猀甀爀攀  昀氀漀愀琀Ⰰ  眀椀渀搀  昀氀漀愀琀Ⰰ 眀椀渀搀搀椀爀  昀氀漀愀琀Ⰰ  栀甀洀椀搀椀琀礀  昀氀漀愀琀Ⰰ  攀氀攀瘀愀琀椀漀渀  昀氀漀愀琀Ⰰഀഀ
	sid bigint identity(149,500) NOT NULL PRIMARY KEY CLUSTERED ਍⤀㬀 ഀഀ
GO ਍匀䔀吀 䤀䐀䔀一吀䤀吀夀开䤀一匀䔀刀吀 䄀刀唀匀㄀㐀㤀 伀一ഀഀ
GO਍䄀䰀吀䔀刀 吀䄀䈀䰀䔀 䄀刀唀匀㄀㐀㤀 䄀䐀䐀 䌀伀一匀吀刀䄀䤀一吀 䌀䠀䔀䌀䬀开䄀刀唀匀㄀㐀㤀 䌀䠀䔀䌀䬀⠀⠀猀椀搀 ─ 㔀　　⤀ ─ ㄀㐀㤀 㴀 　⤀ഀഀ
-- alter table ARUS149 add sid bigint identity(149,500) NOT NULL PRIMARY KEY CLUSTERED    ਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开䄀刀唀匀㄀㐀㤀开洀氀椀崀 伀一 䄀刀唀匀㄀㐀㤀 ⠀洀氀椀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开䄀刀唀匀㄀㐀㤀开琀攀洀瀀攀爀愀琀甀爀攀崀 伀一 䄀刀唀匀㄀㐀㤀 ⠀琀攀洀瀀攀爀愀琀甀爀攀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开䄀刀唀匀㄀㐀㤀开琀甀爀戀椀搀椀琀礀崀 伀一 䄀刀唀匀㄀㐀㤀 ⠀琀甀爀戀椀搀椀琀礀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开䄀刀唀匀㄀㐀㤀开挀漀渀搀甀挀琀愀渀挀攀崀 伀一 䄀刀唀匀㄀㐀㤀 ⠀挀漀渀搀甀挀琀愀渀挀攀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开䄀刀唀匀㄀㐀㤀开猀琀愀洀瀀崀 伀一 䄀刀唀匀㄀㐀㤀 ⠀猀琀愀洀瀀 䐀䔀匀䌀⤀ ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开䄀刀唀匀㄀㐀㤀开搀椀猀挀栀愀爀最攀崀 伀一 䄀刀唀匀㄀㐀㤀 ⠀搀椀猀挀栀愀爀最攀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开䄀刀唀匀㄀㐀㤀开漀砀礀最攀渀崀 伀一 䄀刀唀匀㄀㐀㤀 ⠀漀砀礀最攀渀 䄀匀䌀⤀ഀഀ
GO਍ⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀഀഀ
CREATE TABLE IAUS151਍⠀ഀഀ
	[mli] varchar(32) NOT NULL,਍ऀ猀琀愀洀瀀 搀愀琀攀琀椀洀攀 一伀吀 一唀䰀䰀Ⰰഀഀ
	temperature    float,  -- Temperature, water, degrees Celsius਍ऀ挀漀渀搀甀挀琀愀渀挀攀    昀氀漀愀琀Ⰰ  ⴀⴀ 匀瀀攀挀椀昀椀挀 挀漀渀搀甀挀琀愀渀挀攀Ⰰ 眀愀琀攀爀Ⰰ 甀渀昀椀氀琀攀爀攀搀Ⰰ 洀椀挀爀漀猀椀攀洀攀渀猀 瀀攀爀 挀攀渀琀椀洀攀琀攀爀 愀琀 ㈀㔀 搀攀最爀攀攀猀 䌀攀氀猀椀甀猀 ഀഀ
	discharge      float,  -- Discharge, cubic feet per second਍ऀ瀀栀             昀氀漀愀琀Ⰰ  ⴀⴀ 瀀䠀Ⰰ 眀愀琀攀爀Ⰰ 甀渀昀椀氀琀攀爀攀搀Ⰰ 昀椀攀氀搀Ⰰ 猀琀愀渀搀愀爀搀 甀渀椀琀猀   ഀഀ
	turbidity      float,  -- unfiltered, monochrome near infra-red LED light, 780-900 nm, detection angle 90 +-2.5 degrees, formazin nephelometric units (FNU) ਍ऀ漀砀礀最攀渀         昀氀漀愀琀Ⰰ  ⴀⴀ 䐀椀猀猀漀氀瘀攀搀 漀砀礀最攀渀Ⰰ 眀愀琀攀爀Ⰰ 甀渀昀椀氀琀攀爀攀搀Ⰰ 洀椀氀氀椀最爀愀洀猀 瀀攀爀 氀椀琀攀爀 ഀഀ
	precipitation  float,  -- Precipitation, total, inches਍ऀ瘀攀氀漀挀椀琀礀       昀氀漀愀琀Ⰰഀഀ
	air  float, cloudcover  float,  pressure  float,  wind  float, winddir  float,  humidity  float,  elevation  float,਍ऀ猀椀搀 戀椀最椀渀琀 椀搀攀渀琀椀琀礀⠀㄀㔀㄀Ⰰ㔀　　⤀ 一伀吀 一唀䰀䰀 倀刀䤀䴀䄀刀夀 䬀䔀夀 䌀䰀唀匀吀䔀刀䔀䐀 ഀഀ
); ਍䜀伀 ഀഀ
SET IDENTITY_INSERT IAUS151 ON਍䜀伀ഀഀ
ALTER TABLE IAUS151 ADD CONSTRAINT CHECK_IAUS151 CHECK((sid % 500) % 151 = 0)਍ⴀⴀ 愀氀琀攀爀 琀愀戀氀攀 䤀䄀唀匀㄀㔀㄀ 愀搀搀 猀椀搀 戀椀最椀渀琀 椀搀攀渀琀椀琀礀⠀㄀㔀㄀Ⰰ㔀　　⤀ 一伀吀 一唀䰀䰀 倀刀䤀䴀䄀刀夀 䬀䔀夀 䌀䰀唀匀吀䔀刀䔀䐀    ഀഀ
਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开䤀䄀唀匀㄀㔀㄀开洀氀椀崀 伀一 䤀䄀唀匀㄀㔀㄀ ⠀洀氀椀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开䤀䄀唀匀㄀㔀㄀开琀攀洀瀀攀爀愀琀甀爀攀崀 伀一 䤀䄀唀匀㄀㔀㄀ ⠀琀攀洀瀀攀爀愀琀甀爀攀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开䤀䄀唀匀㄀㔀㄀开琀甀爀戀椀搀椀琀礀崀 伀一 䤀䄀唀匀㄀㔀㄀ ⠀琀甀爀戀椀搀椀琀礀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开䤀䄀唀匀㄀㔀㄀开挀漀渀搀甀挀琀愀渀挀攀崀 伀一 䤀䄀唀匀㄀㔀㄀ ⠀挀漀渀搀甀挀琀愀渀挀攀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开䤀䄀唀匀㄀㔀㄀开猀琀愀洀瀀崀 伀一 䤀䄀唀匀㄀㔀㄀ ⠀猀琀愀洀瀀 䐀䔀匀䌀⤀ ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开䤀䄀唀匀㄀㔀㄀开搀椀猀挀栀愀爀最攀崀 伀一 䤀䄀唀匀㄀㔀㄀ ⠀搀椀猀挀栀愀爀最攀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开䤀䄀唀匀㄀㔀㄀开漀砀礀最攀渀崀 伀一 䤀䄀唀匀㄀㔀㄀ ⠀漀砀礀最攀渀 䄀匀䌀⤀ഀഀ
GO਍ⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀഀഀ
CREATE TABLE VTUS157਍⠀ഀഀ
	[mli] varchar(32) NOT NULL,਍ऀ猀琀愀洀瀀 搀愀琀攀琀椀洀攀 一伀吀 一唀䰀䰀Ⰰഀഀ
	temperature    float,  -- Temperature, water, degrees Celsius਍ऀ挀漀渀搀甀挀琀愀渀挀攀    昀氀漀愀琀Ⰰ  ⴀⴀ 匀瀀攀挀椀昀椀挀 挀漀渀搀甀挀琀愀渀挀攀Ⰰ 眀愀琀攀爀Ⰰ 甀渀昀椀氀琀攀爀攀搀Ⰰ 洀椀挀爀漀猀椀攀洀攀渀猀 瀀攀爀 挀攀渀琀椀洀攀琀攀爀 愀琀 ㈀㔀 搀攀最爀攀攀猀 䌀攀氀猀椀甀猀 ഀഀ
	discharge      float,  -- Discharge, cubic feet per second਍ऀ瀀栀             昀氀漀愀琀Ⰰ  ⴀⴀ 瀀䠀Ⰰ 眀愀琀攀爀Ⰰ 甀渀昀椀氀琀攀爀攀搀Ⰰ 昀椀攀氀搀Ⰰ 猀琀愀渀搀愀爀搀 甀渀椀琀猀   ഀഀ
	turbidity      float,  -- unfiltered, monochrome near infra-red LED light, 780-900 nm, detection angle 90 +-2.5 degrees, formazin nephelometric units (FNU) ਍ऀ漀砀礀最攀渀         昀氀漀愀琀Ⰰ  ⴀⴀ 䐀椀猀猀漀氀瘀攀搀 漀砀礀最攀渀Ⰰ 眀愀琀攀爀Ⰰ 甀渀昀椀氀琀攀爀攀搀Ⰰ 洀椀氀氀椀最爀愀洀猀 瀀攀爀 氀椀琀攀爀 ഀഀ
	precipitation  float,  -- Precipitation, total, inches਍ऀ瘀攀氀漀挀椀琀礀       昀氀漀愀琀Ⰰഀഀ
	air  float, cloudcover  float,  pressure  float,  wind  float, winddir  float,  humidity  float,  elevation  float,਍ऀ猀椀搀 戀椀最椀渀琀 椀搀攀渀琀椀琀礀⠀㄀㔀㜀Ⰰ㔀　　⤀ 一伀吀 一唀䰀䰀 倀刀䤀䴀䄀刀夀 䬀䔀夀 䌀䰀唀匀吀䔀刀䔀䐀 ഀഀ
); ਍䜀伀 ഀഀ
SET IDENTITY_INSERT VTUS157 ON਍䜀伀ഀഀ
ALTER TABLE VTUS157 ADD CONSTRAINT CHECK_VTUS157 CHECK((sid % 500) % 157 = 0)਍ⴀⴀ 愀氀琀攀爀 琀愀戀氀攀 嘀吀唀匀㄀㔀㜀 愀搀搀 猀椀搀 戀椀最椀渀琀 椀搀攀渀琀椀琀礀⠀㄀㔀㜀Ⰰ㔀　　⤀ 一伀吀 一唀䰀䰀 倀刀䤀䴀䄀刀夀 䬀䔀夀 䌀䰀唀匀吀䔀刀䔀䐀    ഀഀ
   ਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开嘀吀开洀氀椀崀 伀一 嘀吀唀匀㄀㔀㜀 ⠀洀氀椀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开嘀吀开琀攀洀瀀攀爀愀琀甀爀攀崀 伀一 嘀吀唀匀㄀㔀㜀 ⠀琀攀洀瀀攀爀愀琀甀爀攀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开嘀吀开琀甀爀戀椀搀椀琀礀崀 伀一 嘀吀唀匀㄀㔀㜀 ⠀琀甀爀戀椀搀椀琀礀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开嘀吀开挀漀渀搀甀挀琀愀渀挀攀崀 伀一 嘀吀唀匀㄀㔀㜀 ⠀挀漀渀搀甀挀琀愀渀挀攀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开嘀吀开猀琀愀洀瀀崀 伀一 嘀吀唀匀㄀㔀㜀 ⠀猀琀愀洀瀀 䐀䔀匀䌀⤀ ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开嘀吀开搀椀猀挀栀愀爀最攀崀 伀一 嘀吀唀匀㄀㔀㜀 ⠀搀椀猀挀栀愀爀最攀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开嘀吀开漀砀礀最攀渀崀 伀一 嘀吀唀匀㄀㔀㜀 ⠀漀砀礀最攀渀 䄀匀䌀⤀ഀഀ
GO਍ⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀഀഀ
CREATE TABLE NDUS167਍⠀ഀഀ
	[mli] varchar(32) NOT NULL,਍ऀ猀琀愀洀瀀 搀愀琀攀琀椀洀攀 一伀吀 一唀䰀䰀Ⰰഀഀ
	temperature    float,  -- Temperature, water, degrees Celsius਍ऀ挀漀渀搀甀挀琀愀渀挀攀    昀氀漀愀琀Ⰰ  ⴀⴀ 匀瀀攀挀椀昀椀挀 挀漀渀搀甀挀琀愀渀挀攀Ⰰ 眀愀琀攀爀Ⰰ 甀渀昀椀氀琀攀爀攀搀Ⰰ 洀椀挀爀漀猀椀攀洀攀渀猀 瀀攀爀 挀攀渀琀椀洀攀琀攀爀 愀琀 ㈀㔀 搀攀最爀攀攀猀 䌀攀氀猀椀甀猀 ഀഀ
	discharge      float,  -- Discharge, cubic feet per second਍ऀ瀀栀             昀氀漀愀琀Ⰰ  ⴀⴀ 瀀䠀Ⰰ 眀愀琀攀爀Ⰰ 甀渀昀椀氀琀攀爀攀搀Ⰰ 昀椀攀氀搀Ⰰ 猀琀愀渀搀愀爀搀 甀渀椀琀猀   ഀഀ
	turbidity      float,  -- unfiltered, monochrome near infra-red LED light, 780-900 nm, detection angle 90 +-2.5 degrees, formazin nephelometric units (FNU) ਍ऀ漀砀礀最攀渀         昀氀漀愀琀Ⰰ  ⴀⴀ 䐀椀猀猀漀氀瘀攀搀 漀砀礀最攀渀Ⰰ 眀愀琀攀爀Ⰰ 甀渀昀椀氀琀攀爀攀搀Ⰰ 洀椀氀氀椀最爀愀洀猀 瀀攀爀 氀椀琀攀爀 ഀഀ
	precipitation  float,  -- Precipitation, total, inches਍ऀ瘀攀氀漀挀椀琀礀       昀氀漀愀琀Ⰰഀഀ
	air  float, cloudcover  float,  pressure  float,  wind  float, winddir  float,  humidity  float,  elevation  float,਍ऀ猀椀搀 戀椀最椀渀琀 椀搀攀渀琀椀琀礀⠀㄀㘀㜀Ⰰ㔀　　⤀ 一伀吀 一唀䰀䰀 倀刀䤀䴀䄀刀夀 䬀䔀夀 䌀䰀唀匀吀䔀刀䔀䐀 ഀഀ
); ਍匀䔀吀 䤀䐀䔀一吀䤀吀夀开䤀一匀䔀刀吀 一䐀唀匀㄀㘀㜀 伀一ഀഀ
GO ਍䄀䰀吀䔀刀 吀䄀䈀䰀䔀 一䐀唀匀㄀㘀㜀 䄀䐀䐀 䌀伀一匀吀刀䄀䤀一吀 䌀䠀䔀䌀䬀开一䐀唀匀㄀㘀㜀 䌀䠀䔀䌀䬀⠀⠀猀椀搀 ─ 㔀　　⤀ ─ ㄀㘀㜀 㴀 　⤀ഀഀ
-- alter table NDUS167 add sid bigint identity(167,500) NOT NULL PRIMARY KEY CLUSTERED    ਍  ഀഀ
CREATE NONCLUSTERED INDEX [idx_NDUS167_mli] ON NDUS167 (mli ASC)਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_NDUS167_temperature] ON NDUS167 (temperature ASC)਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_NDUS167_turbidity] ON NDUS167 (turbidity ASC)਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_NDUS167_conductance] ON NDUS167 (conductance ASC)਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_NDUS167_stamp] ON NDUS167 (stamp DESC) ਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_NDUS167_discharge] ON NDUS167 (discharge ASC)਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_NDUS167_oxygen] ON NDUS167 (oxygen ASC)਍䜀伀   ഀഀ
------------------------------------------------------------------------------------------------਍䌀刀䔀䄀吀䔀 吀䄀䈀䰀䔀 䤀䐀唀匀㄀㜀㌀ഀഀ
(਍ऀ嬀洀氀椀崀 瘀愀爀挀栀愀爀⠀㌀㈀⤀ 一伀吀 一唀䰀䰀Ⰰഀഀ
	stamp datetime NOT NULL,਍ऀ琀攀洀瀀攀爀愀琀甀爀攀    昀氀漀愀琀Ⰰ  ⴀⴀ 吀攀洀瀀攀爀愀琀甀爀攀Ⰰ 眀愀琀攀爀Ⰰ 搀攀最爀攀攀猀 䌀攀氀猀椀甀猀ഀഀ
	conductance    float,  -- Specific conductance, water, unfiltered, microsiemens per centimeter at 25 degrees Celsius ਍ऀ搀椀猀挀栀愀爀最攀      昀氀漀愀琀Ⰰ  ⴀⴀ 䐀椀猀挀栀愀爀最攀Ⰰ 挀甀戀椀挀 昀攀攀琀 瀀攀爀 猀攀挀漀渀搀ഀഀ
	ph             float,  -- pH, water, unfiltered, field, standard units   ਍ऀ琀甀爀戀椀搀椀琀礀      昀氀漀愀琀Ⰰ  ⴀⴀ 甀渀昀椀氀琀攀爀攀搀Ⰰ 洀漀渀漀挀栀爀漀洀攀 渀攀愀爀 椀渀昀爀愀ⴀ爀攀搀 䰀䔀䐀 氀椀最栀琀Ⰰ 㜀㠀　ⴀ㤀　　 渀洀Ⰰ 搀攀琀攀挀琀椀漀渀 愀渀最氀攀 㤀　 ⬀ⴀ㈀⸀㔀 搀攀最爀攀攀猀Ⰰ 昀漀爀洀愀稀椀渀 渀攀瀀栀攀氀漀洀攀琀爀椀挀 甀渀椀琀猀 ⠀䘀一唀⤀ ഀഀ
	oxygen         float,  -- Dissolved oxygen, water, unfiltered, milligrams per liter ਍ऀ瀀爀攀挀椀瀀椀琀愀琀椀漀渀  昀氀漀愀琀Ⰰ  ⴀⴀ 倀爀攀挀椀瀀椀琀愀琀椀漀渀Ⰰ 琀漀琀愀氀Ⰰ 椀渀挀栀攀猀ഀഀ
	velocity       float,਍ऀ愀椀爀  昀氀漀愀琀Ⰰ 挀氀漀甀搀挀漀瘀攀爀  昀氀漀愀琀Ⰰ  瀀爀攀猀猀甀爀攀  昀氀漀愀琀Ⰰ  眀椀渀搀  昀氀漀愀琀Ⰰ 眀椀渀搀搀椀爀  昀氀漀愀琀Ⰰ  栀甀洀椀搀椀琀礀  昀氀漀愀琀Ⰰ  攀氀攀瘀愀琀椀漀渀  昀氀漀愀琀Ⰰഀഀ
	sid bigint identity(173,500) NOT NULL PRIMARY KEY CLUSTERED ਍⤀㬀 ഀഀ
GO   ਍匀䔀吀 䤀䐀䔀一吀䤀吀夀开䤀一匀䔀刀吀 䤀䐀唀匀㄀㜀㌀ 伀一ഀഀ
GO   ਍䄀䰀吀䔀刀 吀䄀䈀䰀䔀 䤀䐀唀匀㄀㜀㌀ 䄀䐀䐀 䌀伀一匀吀刀䄀䤀一吀 䌀䠀䔀䌀䬀开䤀䐀唀匀㄀㜀㌀ 䌀䠀䔀䌀䬀⠀⠀猀椀搀 ─ 㔀　　⤀ ─ ㄀㜀㌀ 㴀 　⤀ഀഀ
-- alter table IDUS173 add sid bigint identity(173,500) NOT NULL PRIMARY KEY CLUSTERED    ਍ ഀഀ
CREATE NONCLUSTERED INDEX [idx_IDUS173_mli] ON IDUS173 (mli ASC)਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_IDUS173_temperature] ON IDUS173 (temperature ASC)਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_IDUS173_turbidity] ON IDUS173 (turbidity ASC)਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_IDUS173_conductance] ON IDUS173 (conductance ASC)਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_IDUS173_stamp] ON IDUS173 (stamp DESC) ਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_IDUS173_discharge] ON IDUS173 (discharge ASC)਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_IDUS173_oxygen] ON IDUS173 (oxygen ASC)਍䜀伀ഀഀ
------------------------------------------------------------------------------------------------਍䌀刀䔀䄀吀䔀 吀䄀䈀䰀䔀 䜀䄀唀匀㄀㜀㤀ഀഀ
(਍ऀ嬀洀氀椀崀 瘀愀爀挀栀愀爀⠀㌀㈀⤀ 一伀吀 一唀䰀䰀Ⰰഀഀ
	stamp datetime NOT NULL,਍ऀ琀攀洀瀀攀爀愀琀甀爀攀    昀氀漀愀琀Ⰰ  ⴀⴀ 吀攀洀瀀攀爀愀琀甀爀攀Ⰰ 眀愀琀攀爀Ⰰ 搀攀最爀攀攀猀 䌀攀氀猀椀甀猀ഀഀ
	conductance    float,  -- Specific conductance, water, unfiltered, microsiemens per centimeter at 25 degrees Celsius ਍ऀ搀椀猀挀栀愀爀最攀      昀氀漀愀琀Ⰰ  ⴀⴀ 䐀椀猀挀栀愀爀最攀Ⰰ 挀甀戀椀挀 昀攀攀琀 瀀攀爀 猀攀挀漀渀搀ഀഀ
	ph             float,  -- pH, water, unfiltered, field, standard units   ਍ऀ琀甀爀戀椀搀椀琀礀      昀氀漀愀琀Ⰰ  ⴀⴀ 甀渀昀椀氀琀攀爀攀搀Ⰰ 洀漀渀漀挀栀爀漀洀攀 渀攀愀爀 椀渀昀爀愀ⴀ爀攀搀 䰀䔀䐀 氀椀最栀琀Ⰰ 㜀㠀　ⴀ㤀　　 渀洀Ⰰ 搀攀琀攀挀琀椀漀渀 愀渀最氀攀 㤀　 ⬀ⴀ㈀⸀㔀 搀攀最爀攀攀猀Ⰰ 昀漀爀洀愀稀椀渀 渀攀瀀栀攀氀漀洀攀琀爀椀挀 甀渀椀琀猀 ⠀䘀一唀⤀ ഀഀ
	oxygen         float,  -- Dissolved oxygen, water, unfiltered, milligrams per liter ਍ऀ瀀爀攀挀椀瀀椀琀愀琀椀漀渀  昀氀漀愀琀Ⰰ  ⴀⴀ 倀爀攀挀椀瀀椀琀愀琀椀漀渀Ⰰ 琀漀琀愀氀Ⰰ 椀渀挀栀攀猀ഀഀ
	velocity       float,਍ऀ愀椀爀  昀氀漀愀琀Ⰰ 挀氀漀甀搀挀漀瘀攀爀  昀氀漀愀琀Ⰰ  瀀爀攀猀猀甀爀攀  昀氀漀愀琀Ⰰ  眀椀渀搀  昀氀漀愀琀Ⰰ 眀椀渀搀搀椀爀  昀氀漀愀琀Ⰰ  栀甀洀椀搀椀琀礀  昀氀漀愀琀Ⰰ  攀氀攀瘀愀琀椀漀渀  昀氀漀愀琀Ⰰഀഀ
	sid bigint identity(179,500) NOT NULL PRIMARY KEY CLUSTERED ਍⤀㬀 ഀഀ
GO   ਍匀䔀吀 䤀䐀䔀一吀䤀吀夀开䤀一匀䔀刀吀 䜀䄀唀匀㄀㜀㤀 伀一ഀഀ
GO   ਍䄀䰀吀䔀刀 吀䄀䈀䰀䔀 䜀䄀唀匀㄀㜀㤀 䄀䐀䐀 䌀伀一匀吀刀䄀䤀一吀 䌀䠀䔀䌀䬀开䜀䄀唀匀㄀㜀㤀 䌀䠀䔀䌀䬀⠀⠀猀椀搀 ─ 㔀　　⤀ ─ ㄀㜀㤀 㴀 　⤀ഀഀ
-- alter table GAUS179 add sid bigint identity(179,500) NOT NULL PRIMARY KEY CLUSTERED    ਍ഀഀ
CREATE NONCLUSTERED INDEX [idx_GAUS179_mli] ON GAUS179 (mli ASC)਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_GAUS179_temperature] ON GAUS179 (temperature ASC)਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_GAUS179_turbidity] ON GAUS179 (turbidity ASC)਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_GAUS179_conductance] ON GAUS179 (conductance ASC)਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_GAUS179_stamp] ON GAUS179 (stamp DESC) ਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_GAUS179_discharge] ON GAUS179 (discharge ASC)਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_GAUS179_oxygen] ON GAUS179 (oxygen ASC)਍䜀伀ഀഀ
------------------------------------------------------------------------------------------------਍䌀刀䔀䄀吀䔀 吀䄀䈀䰀䔀 䄀娀唀匀㄀㠀㄀ഀഀ
(਍ऀ嬀洀氀椀崀 瘀愀爀挀栀愀爀⠀㌀㈀⤀ 一伀吀 一唀䰀䰀Ⰰഀഀ
	stamp datetime NOT NULL,਍ऀ琀攀洀瀀攀爀愀琀甀爀攀    昀氀漀愀琀Ⰰ  ⴀⴀ 吀攀洀瀀攀爀愀琀甀爀攀Ⰰ 眀愀琀攀爀Ⰰ 搀攀最爀攀攀猀 䌀攀氀猀椀甀猀ഀഀ
	conductance    float,  -- Specific conductance, water, unfiltered, microsiemens per centimeter at 25 degrees Celsius ਍ऀ搀椀猀挀栀愀爀最攀      昀氀漀愀琀Ⰰ  ⴀⴀ 䐀椀猀挀栀愀爀最攀Ⰰ 挀甀戀椀挀 昀攀攀琀 瀀攀爀 猀攀挀漀渀搀ഀഀ
	ph             float,  -- pH, water, unfiltered, field, standard units   ਍ऀ琀甀爀戀椀搀椀琀礀      昀氀漀愀琀Ⰰ  ⴀⴀ 甀渀昀椀氀琀攀爀攀搀Ⰰ 洀漀渀漀挀栀爀漀洀攀 渀攀愀爀 椀渀昀爀愀ⴀ爀攀搀 䰀䔀䐀 氀椀最栀琀Ⰰ 㜀㠀　ⴀ㤀　　 渀洀Ⰰ 搀攀琀攀挀琀椀漀渀 愀渀最氀攀 㤀　 ⬀ⴀ㈀⸀㔀 搀攀最爀攀攀猀Ⰰ 昀漀爀洀愀稀椀渀 渀攀瀀栀攀氀漀洀攀琀爀椀挀 甀渀椀琀猀 ⠀䘀一唀⤀ ഀഀ
	oxygen         float,  -- Dissolved oxygen, water, unfiltered, milligrams per liter ਍ऀ瀀爀攀挀椀瀀椀琀愀琀椀漀渀  昀氀漀愀琀Ⰰ  ⴀⴀ 倀爀攀挀椀瀀椀琀愀琀椀漀渀Ⰰ 琀漀琀愀氀Ⰰ 椀渀挀栀攀猀ഀഀ
	velocity       float,਍ऀ愀椀爀  昀氀漀愀琀Ⰰ 挀氀漀甀搀挀漀瘀攀爀  昀氀漀愀琀Ⰰ  瀀爀攀猀猀甀爀攀  昀氀漀愀琀Ⰰ  眀椀渀搀  昀氀漀愀琀Ⰰ 眀椀渀搀搀椀爀  昀氀漀愀琀Ⰰ  栀甀洀椀搀椀琀礀  昀氀漀愀琀Ⰰ  攀氀攀瘀愀琀椀漀渀  昀氀漀愀琀Ⰰഀഀ
	sid bigint identity(181,500) NOT NULL PRIMARY KEY CLUSTERED ਍⤀㬀 ഀഀ
GO   ਍匀䔀吀 䤀䐀䔀一吀䤀吀夀开䤀一匀䔀刀吀 䄀娀唀匀㄀㠀㄀ 伀一ഀഀ
GO   ਍䄀䰀吀䔀刀 吀䄀䈀䰀䔀 䄀娀唀匀㄀㠀㄀ 䄀䐀䐀 䌀伀一匀吀刀䄀䤀一吀 䌀䠀䔀䌀䬀开䄀娀唀匀㄀㠀㄀ 䌀䠀䔀䌀䬀⠀⠀猀椀搀 ─ 㔀　　⤀ ─ ㄀㠀㄀ 㴀 　⤀ഀഀ
-- alter table AZUS181 add sid bigint identity(181,500) NOT NULL PRIMARY KEY CLUSTERED    ਍ഀഀ
CREATE NONCLUSTERED INDEX [idx_AZUS181_mli] ON AZUS181 (mli ASC)਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_AZUS181_temperature] ON AZUS181 (temperature ASC)਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_AZUS181_turbidity] ON AZUS181 (turbidity ASC)਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_AZUS181_conductance] ON AZUS181 (conductance ASC)਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_AZUS181_stamp] ON AZUS181 (stamp DESC) ਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_AZUS181_discharge] ON AZUS181 (discharge ASC)਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_AZUS181_oxygen] ON AZUS181 (oxygen ASC)਍䜀伀ഀഀ
-------------------------------------------------------------------------------------------਍䌀刀䔀䄀吀䔀 吀䄀䈀䰀䔀 䴀匀唀匀㄀㤀㄀ഀഀ
(਍ऀ嬀洀氀椀崀 瘀愀爀挀栀愀爀⠀㌀㈀⤀ 一伀吀 一唀䰀䰀Ⰰഀഀ
	stamp datetime NOT NULL,਍ऀ琀攀洀瀀攀爀愀琀甀爀攀    昀氀漀愀琀Ⰰ  ⴀⴀ 吀攀洀瀀攀爀愀琀甀爀攀Ⰰ 眀愀琀攀爀Ⰰ 搀攀最爀攀攀猀 䌀攀氀猀椀甀猀ഀഀ
	conductance    float,  -- Specific conductance, water, unfiltered, microsiemens per centimeter at 25 degrees Celsius ਍ऀ搀椀猀挀栀愀爀最攀      昀氀漀愀琀Ⰰ  ⴀⴀ 䐀椀猀挀栀愀爀最攀Ⰰ 挀甀戀椀挀 昀攀攀琀 瀀攀爀 猀攀挀漀渀搀ഀഀ
	ph             float,  -- pH, water, unfiltered, field, standard units   ਍ऀ琀甀爀戀椀搀椀琀礀      昀氀漀愀琀Ⰰ  ⴀⴀ 甀渀昀椀氀琀攀爀攀搀Ⰰ 洀漀渀漀挀栀爀漀洀攀 渀攀愀爀 椀渀昀爀愀ⴀ爀攀搀 䰀䔀䐀 氀椀最栀琀Ⰰ 㜀㠀　ⴀ㤀　　 渀洀Ⰰ 搀攀琀攀挀琀椀漀渀 愀渀最氀攀 㤀　 ⬀ⴀ㈀⸀㔀 搀攀最爀攀攀猀Ⰰ 昀漀爀洀愀稀椀渀 渀攀瀀栀攀氀漀洀攀琀爀椀挀 甀渀椀琀猀 ⠀䘀一唀⤀ ഀഀ
	oxygen         float,  -- Dissolved oxygen, water, unfiltered, milligrams per liter ਍ऀ瀀爀攀挀椀瀀椀琀愀琀椀漀渀  昀氀漀愀琀Ⰰ  ⴀⴀ 倀爀攀挀椀瀀椀琀愀琀椀漀渀Ⰰ 琀漀琀愀氀Ⰰ 椀渀挀栀攀猀ഀഀ
	velocity       float,਍ऀ愀椀爀  昀氀漀愀琀Ⰰ 挀氀漀甀搀挀漀瘀攀爀  昀氀漀愀琀Ⰰ  瀀爀攀猀猀甀爀攀  昀氀漀愀琀Ⰰ  眀椀渀搀  昀氀漀愀琀Ⰰ 眀椀渀搀搀椀爀  昀氀漀愀琀Ⰰ  栀甀洀椀搀椀琀礀  昀氀漀愀琀Ⰰ  攀氀攀瘀愀琀椀漀渀  昀氀漀愀琀Ⰰഀഀ
	sid bigint identity(191,500) NOT NULL PRIMARY KEY CLUSTERED ਍⤀㬀 ഀഀ
GO   ਍匀䔀吀 䤀䐀䔀一吀䤀吀夀开䤀一匀䔀刀吀 䴀匀唀匀㄀㤀㄀ 伀一ഀഀ
GO   ਍䄀䰀吀䔀刀 吀䄀䈀䰀䔀 䴀匀唀匀㄀㤀㄀ 䄀䐀䐀 䌀伀一匀吀刀䄀䤀一吀 䌀䠀䔀䌀䬀开䴀匀唀匀㄀㤀㄀ 䌀䠀䔀䌀䬀⠀⠀猀椀搀 ─ 㔀　　⤀ ─ ㄀㤀㄀ 㴀 　⤀ഀഀ
-- alter table MSUS191 add sid bigint identity(191,500) NOT NULL PRIMARY KEY CLUSTERED    ਍   ഀഀ
CREATE NONCLUSTERED INDEX [idx_MS_mli] ON MSUS191 (mli ASC)਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_MS_temperature] ON MSUS191 (temperature ASC)਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_MS_turbidity] ON MSUS191 (turbidity ASC)਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_MS_conductance] ON MSUS191 (conductance ASC)਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_MS_stamp] ON MSUS191 (stamp DESC) ਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_MS_discharge] ON MSUS191 (discharge ASC)਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_MS_oxygen] ON MSUS191 (oxygen ASC)਍䜀伀ഀഀ
-------------------------------------------------------------------------------------------਍䌀刀䔀䄀吀䔀 吀䄀䈀䰀䔀 吀一唀匀㄀㤀㌀ഀഀ
(਍ऀ嬀洀氀椀崀 瘀愀爀挀栀愀爀⠀㌀㈀⤀ 一伀吀 一唀䰀䰀Ⰰഀഀ
	stamp datetime NOT NULL,਍ऀ琀攀洀瀀攀爀愀琀甀爀攀    昀氀漀愀琀Ⰰ  ⴀⴀ 吀攀洀瀀攀爀愀琀甀爀攀Ⰰ 眀愀琀攀爀Ⰰ 搀攀最爀攀攀猀 䌀攀氀猀椀甀猀ഀഀ
	conductance    float,  -- Specific conductance, water, unfiltered, microsiemens per centimeter at 25 degrees Celsius ਍ऀ搀椀猀挀栀愀爀最攀      昀氀漀愀琀Ⰰ  ⴀⴀ 䐀椀猀挀栀愀爀最攀Ⰰ 挀甀戀椀挀 昀攀攀琀 瀀攀爀 猀攀挀漀渀搀ഀഀ
	ph             float,  -- pH, water, unfiltered, field, standard units   ਍ऀ琀甀爀戀椀搀椀琀礀      昀氀漀愀琀Ⰰ  ⴀⴀ 甀渀昀椀氀琀攀爀攀搀Ⰰ 洀漀渀漀挀栀爀漀洀攀 渀攀愀爀 椀渀昀爀愀ⴀ爀攀搀 䰀䔀䐀 氀椀最栀琀Ⰰ 㜀㠀　ⴀ㤀　　 渀洀Ⰰ 搀攀琀攀挀琀椀漀渀 愀渀最氀攀 㤀　 ⬀ⴀ㈀⸀㔀 搀攀最爀攀攀猀Ⰰ 昀漀爀洀愀稀椀渀 渀攀瀀栀攀氀漀洀攀琀爀椀挀 甀渀椀琀猀 ⠀䘀一唀⤀ ഀഀ
	oxygen         float,  -- Dissolved oxygen, water, unfiltered, milligrams per liter ਍ऀ瀀爀攀挀椀瀀椀琀愀琀椀漀渀  昀氀漀愀琀Ⰰ  ⴀⴀ 倀爀攀挀椀瀀椀琀愀琀椀漀渀Ⰰ 琀漀琀愀氀Ⰰ 椀渀挀栀攀猀ഀഀ
	velocity       float,਍ऀ愀椀爀  昀氀漀愀琀Ⰰ 挀氀漀甀搀挀漀瘀攀爀  昀氀漀愀琀Ⰰ  瀀爀攀猀猀甀爀攀  昀氀漀愀琀Ⰰ  眀椀渀搀  昀氀漀愀琀Ⰰ 眀椀渀搀搀椀爀  昀氀漀愀琀Ⰰ  栀甀洀椀搀椀琀礀  昀氀漀愀琀Ⰰ  攀氀攀瘀愀琀椀漀渀  昀氀漀愀琀Ⰰഀഀ
	sid bigint identity(193,500) NOT NULL PRIMARY KEY CLUSTERED ਍⤀㬀 ഀഀ
GO   ਍匀䔀吀 䤀䐀䔀一吀䤀吀夀开䤀一匀䔀刀吀 吀一唀匀㄀㤀㌀ 伀一ഀഀ
GO   ਍䄀䰀吀䔀刀 吀䄀䈀䰀䔀 吀一唀匀㄀㤀㌀ 䄀䐀䐀 䌀伀一匀吀刀䄀䤀一吀 䌀䠀䔀䌀䬀开吀一唀匀㄀㤀㌀ 䌀䠀䔀䌀䬀⠀⠀猀椀搀 ─ 㔀　　⤀ ─ ㄀㤀㌀ 㴀 　⤀ഀഀ
-- alter table TNUS193 add sid bigint identity(193,500) NOT NULL PRIMARY KEY CLUSTERED    ਍   ഀഀ
CREATE NONCLUSTERED INDEX [idx_TNUS193_mli] ON TNUS193 (mli ASC)਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_TNUS193_temperature] ON TNUS193 (temperature ASC)਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_TNUS193_turbidity] ON TNUS193 (turbidity ASC)਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_TNUS193_conductance] ON TNUS193 (conductance ASC)਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_TNUS193_stamp] ON TNUS193 (stamp DESC) ਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_TNUS193_discharge] ON TNUS193 (discharge ASC)਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_TNUS193_oxygen] ON TNUS193 (oxygen ASC)਍䜀伀ഀഀ
-------------------------------------------------------------------------------------------਍䌀刀䔀䄀吀䔀 吀䄀䈀䰀䔀 一䌀唀匀㄀㤀㜀ഀഀ
(਍ऀ嬀洀氀椀崀 瘀愀爀挀栀愀爀⠀㌀㈀⤀ 一伀吀 一唀䰀䰀Ⰰഀഀ
	stamp datetime NOT NULL,਍ऀ琀攀洀瀀攀爀愀琀甀爀攀    昀氀漀愀琀Ⰰ  ⴀⴀ 吀攀洀瀀攀爀愀琀甀爀攀Ⰰ 眀愀琀攀爀Ⰰ 搀攀最爀攀攀猀 䌀攀氀猀椀甀猀ഀഀ
	conductance    float,  -- Specific conductance, water, unfiltered, microsiemens per centimeter at 25 degrees Celsius ਍ऀ搀椀猀挀栀愀爀最攀      昀氀漀愀琀Ⰰ  ⴀⴀ 䐀椀猀挀栀愀爀最攀Ⰰ 挀甀戀椀挀 昀攀攀琀 瀀攀爀 猀攀挀漀渀搀ഀഀ
	ph             float,  -- pH, water, unfiltered, field, standard units   ਍ऀ琀甀爀戀椀搀椀琀礀      昀氀漀愀琀Ⰰ  ⴀⴀ 甀渀昀椀氀琀攀爀攀搀Ⰰ 洀漀渀漀挀栀爀漀洀攀 渀攀愀爀 椀渀昀爀愀ⴀ爀攀搀 䰀䔀䐀 氀椀最栀琀Ⰰ 㜀㠀　ⴀ㤀　　 渀洀Ⰰ 搀攀琀攀挀琀椀漀渀 愀渀最氀攀 㤀　 ⬀ⴀ㈀⸀㔀 搀攀最爀攀攀猀Ⰰ 昀漀爀洀愀稀椀渀 渀攀瀀栀攀氀漀洀攀琀爀椀挀 甀渀椀琀猀 ⠀䘀一唀⤀ ഀഀ
	oxygen         float,  -- Dissolved oxygen, water, unfiltered, milligrams per liter ਍ऀ瀀爀攀挀椀瀀椀琀愀琀椀漀渀  昀氀漀愀琀Ⰰ  ⴀⴀ 倀爀攀挀椀瀀椀琀愀琀椀漀渀Ⰰ 琀漀琀愀氀Ⰰ 椀渀挀栀攀猀ഀഀ
	velocity       float,਍ऀ愀椀爀  昀氀漀愀琀Ⰰ 挀氀漀甀搀挀漀瘀攀爀  昀氀漀愀琀Ⰰ  瀀爀攀猀猀甀爀攀  昀氀漀愀琀Ⰰ  眀椀渀搀  昀氀漀愀琀Ⰰ 眀椀渀搀搀椀爀  昀氀漀愀琀Ⰰ  栀甀洀椀搀椀琀礀  昀氀漀愀琀Ⰰ  攀氀攀瘀愀琀椀漀渀  昀氀漀愀琀Ⰰഀഀ
	sid bigint identity(197, 500) NOT NULL PRIMARY KEY CLUSTERED ਍⤀㬀 ഀഀ
GO   ਍匀䔀吀 䤀䐀䔀一吀䤀吀夀开䤀一匀䔀刀吀 一䌀唀匀㄀㤀㜀 伀一ഀഀ
GO   ਍䄀䰀吀䔀刀 吀䄀䈀䰀䔀 一䌀唀匀㄀㤀㜀 䄀䐀䐀 䌀伀一匀吀刀䄀䤀一吀 䌀䠀䔀䌀䬀开一䌀唀匀㄀㤀㜀 䌀䠀䔀䌀䬀⠀⠀猀椀搀 ─ 㔀　　⤀ ─ ㄀㤀㜀 㴀 　⤀ഀഀ
-- alter table NCUS197 add sid bigint identity(197,500) NOT NULL PRIMARY KEY CLUSTERED    ਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开一䌀唀匀㄀㤀㜀开洀氀椀崀 伀一 一䌀唀匀㄀㤀㜀 ⠀洀氀椀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开一䌀唀匀㄀㤀㜀开琀攀洀瀀攀爀愀琀甀爀攀崀 伀一 一䌀唀匀㄀㤀㜀 ⠀琀攀洀瀀攀爀愀琀甀爀攀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开一䌀唀匀㄀㤀㜀开琀甀爀戀椀搀椀琀礀崀 伀一 一䌀唀匀㄀㤀㜀 ⠀琀甀爀戀椀搀椀琀礀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开一䌀唀匀㄀㤀㜀开挀漀渀搀甀挀琀愀渀挀攀崀 伀一 一䌀唀匀㄀㤀㜀 ⠀挀漀渀搀甀挀琀愀渀挀攀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开一䌀唀匀㄀㤀㜀开猀琀愀洀瀀崀 伀一 一䌀唀匀㄀㤀㜀 ⠀猀琀愀洀瀀 䐀䔀匀䌀⤀ ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开一䌀唀匀㄀㤀㜀开搀椀猀挀栀愀爀最攀崀 伀一 一䌀唀匀㄀㤀㜀 ⠀搀椀猀挀栀愀爀最攀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开一䌀唀匀㄀㤀㜀开漀砀礀最攀渀崀 伀一 一䌀唀匀㄀㤀㜀 ⠀漀砀礀最攀渀 䄀匀䌀⤀ഀഀ
GO਍ⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀഀഀ
CREATE TABLE NEUS199਍⠀ഀഀ
	[mli] varchar(32) NOT NULL,਍ऀ猀琀愀洀瀀 搀愀琀攀琀椀洀攀 一伀吀 一唀䰀䰀Ⰰഀഀ
	temperature    float,  -- Temperature, water, degrees Celsius਍ऀ挀漀渀搀甀挀琀愀渀挀攀    昀氀漀愀琀Ⰰ  ⴀⴀ 匀瀀攀挀椀昀椀挀 挀漀渀搀甀挀琀愀渀挀攀Ⰰ 眀愀琀攀爀Ⰰ 甀渀昀椀氀琀攀爀攀搀Ⰰ 洀椀挀爀漀猀椀攀洀攀渀猀 瀀攀爀 挀攀渀琀椀洀攀琀攀爀 愀琀 ㈀㔀 搀攀最爀攀攀猀 䌀攀氀猀椀甀猀 ഀഀ
	discharge      float,  -- Discharge, cubic feet per second਍ऀ瀀栀             昀氀漀愀琀Ⰰ  ⴀⴀ 瀀䠀Ⰰ 眀愀琀攀爀Ⰰ 甀渀昀椀氀琀攀爀攀搀Ⰰ 昀椀攀氀搀Ⰰ 猀琀愀渀搀愀爀搀 甀渀椀琀猀   ഀഀ
	turbidity      float,  -- unfiltered, monochrome near infra-red LED light, 780-900 nm, detection angle 90 +-2.5 degrees, formazin nephelometric units (FNU) ਍ऀ漀砀礀最攀渀         昀氀漀愀琀Ⰰ  ⴀⴀ 䐀椀猀猀漀氀瘀攀搀 漀砀礀最攀渀Ⰰ 眀愀琀攀爀Ⰰ 甀渀昀椀氀琀攀爀攀搀Ⰰ 洀椀氀氀椀最爀愀洀猀 瀀攀爀 氀椀琀攀爀 ഀഀ
	precipitation  float,  -- Precipitation, total, inches਍ऀ瘀攀氀漀挀椀琀礀       昀氀漀愀琀Ⰰഀഀ
	air  float, cloudcover  float,  pressure  float,  wind  float, winddir  float,  humidity  float,  elevation  float,਍ऀ猀椀搀 戀椀最椀渀琀 椀搀攀渀琀椀琀礀⠀㄀㤀㤀Ⰰ㔀　　⤀ 一伀吀 一唀䰀䰀 倀刀䤀䴀䄀刀夀 䬀䔀夀 䌀䰀唀匀吀䔀刀䔀䐀 ഀഀ
); ਍䜀伀   ഀഀ
SET IDENTITY_INSERT NEUS199 ON਍䜀伀   ഀഀ
ALTER TABLE NEUS199 ADD CONSTRAINT CHECK_NEUS199 CHECK((sid % 500) % 199 = 0)਍ⴀⴀ 愀氀琀攀爀 琀愀戀氀攀 一䔀唀匀㄀㤀㤀 愀搀搀 猀椀搀 戀椀最椀渀琀 椀搀攀渀琀椀琀礀⠀㄀㤀㤀Ⰰ㔀　　⤀ 一伀吀 一唀䰀䰀 倀刀䤀䴀䄀刀夀 䬀䔀夀 䌀䰀唀匀吀䔀刀䔀䐀    ഀഀ
  ਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开一䔀唀匀㄀㤀㤀开洀氀椀崀 伀一 一䔀唀匀㄀㤀㤀 ⠀洀氀椀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开一䔀唀匀㄀㤀㤀开琀攀洀瀀攀爀愀琀甀爀攀崀 伀一 一䔀唀匀㄀㤀㤀 ⠀琀攀洀瀀攀爀愀琀甀爀攀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开一䔀唀匀㄀㤀㤀开琀甀爀戀椀搀椀琀礀崀 伀一 一䔀唀匀㄀㤀㤀 ⠀琀甀爀戀椀搀椀琀礀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开一䔀唀匀㄀㤀㤀开挀漀渀搀甀挀琀愀渀挀攀崀 伀一 一䔀唀匀㄀㤀㤀 ⠀挀漀渀搀甀挀琀愀渀挀攀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开一䔀唀匀㄀㤀㤀开猀琀愀洀瀀崀 伀一 一䔀唀匀㄀㤀㤀 ⠀猀琀愀洀瀀 䐀䔀匀䌀⤀ ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开一䔀唀匀㄀㤀㤀开搀椀猀挀栀愀爀最攀崀 伀一 一䔀唀匀㄀㤀㤀 ⠀搀椀猀挀栀愀爀最攀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开一䔀唀匀㄀㤀㤀开漀砀礀最攀渀崀 伀一 一䔀唀匀㄀㤀㤀 ⠀漀砀礀最攀渀 䄀匀䌀⤀ഀഀ
GO਍ⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀഀഀ
CREATE TABLE WVUS211਍⠀ഀഀ
	[mli] varchar(32) NOT NULL,਍ऀ猀琀愀洀瀀 搀愀琀攀琀椀洀攀 一伀吀 一唀䰀䰀Ⰰഀഀ
	temperature    float,  -- Temperature, water, degrees Celsius਍ऀ挀漀渀搀甀挀琀愀渀挀攀    昀氀漀愀琀Ⰰ  ⴀⴀ 匀瀀攀挀椀昀椀挀 挀漀渀搀甀挀琀愀渀挀攀Ⰰ 眀愀琀攀爀Ⰰ 甀渀昀椀氀琀攀爀攀搀Ⰰ 洀椀挀爀漀猀椀攀洀攀渀猀 瀀攀爀 挀攀渀琀椀洀攀琀攀爀 愀琀 ㈀㔀 搀攀最爀攀攀猀 䌀攀氀猀椀甀猀 ഀഀ
	discharge      float,  -- Discharge, cubic feet per second਍ऀ瀀栀             昀氀漀愀琀Ⰰ  ⴀⴀ 瀀䠀Ⰰ 眀愀琀攀爀Ⰰ 甀渀昀椀氀琀攀爀攀搀Ⰰ 昀椀攀氀搀Ⰰ 猀琀愀渀搀愀爀搀 甀渀椀琀猀   ഀഀ
	turbidity      float,  -- unfiltered, monochrome near infra-red LED light, 780-900 nm, detection angle 90 +-2.5 degrees, formazin nephelometric units (FNU) ਍ऀ漀砀礀最攀渀         昀氀漀愀琀Ⰰ  ⴀⴀ 䐀椀猀猀漀氀瘀攀搀 漀砀礀最攀渀Ⰰ 眀愀琀攀爀Ⰰ 甀渀昀椀氀琀攀爀攀搀Ⰰ 洀椀氀氀椀最爀愀洀猀 瀀攀爀 氀椀琀攀爀 ഀഀ
	precipitation  float,  -- Precipitation, total, inches਍ऀ瘀攀氀漀挀椀琀礀       昀氀漀愀琀Ⰰഀഀ
	air  float, cloudcover  float,  pressure  float,  wind  float, winddir  float,  humidity  float,  elevation  float,਍ऀ猀椀搀 戀椀最椀渀琀 椀搀攀渀琀椀琀礀⠀㈀㄀㄀Ⰰ㔀　　⤀ 一伀吀 一唀䰀䰀 倀刀䤀䴀䄀刀夀 䬀䔀夀 䌀䰀唀匀吀䔀刀䔀䐀 ഀഀ
); ਍䜀伀   ഀഀ
SET IDENTITY_INSERT WVUS211 ON਍䜀伀   ഀഀ
ALTER TABLE WVUS211 ADD CONSTRAINT CHECK_WVUS211 CHECK((sid % 500) % 211 = 0)਍ⴀⴀ 愀氀琀攀爀 琀愀戀氀攀 圀嘀唀匀㈀㄀㄀ 愀搀搀 猀椀搀 戀椀最椀渀琀 椀搀攀渀琀椀琀礀⠀㈀㄀㄀Ⰰ㔀　　⤀ 一伀吀 一唀䰀䰀 倀刀䤀䴀䄀刀夀 䬀䔀夀 䌀䰀唀匀吀䔀刀䔀䐀    ഀഀ
਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开圀嘀开洀氀椀崀 伀一 圀嘀唀匀㈀㄀㄀ ⠀洀氀椀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开圀嘀开琀攀洀瀀攀爀愀琀甀爀攀崀 伀一 圀嘀唀匀㈀㄀㄀ ⠀琀攀洀瀀攀爀愀琀甀爀攀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开圀嘀开琀甀爀戀椀搀椀琀礀崀 伀一 圀嘀唀匀㈀㄀㄀ ⠀琀甀爀戀椀搀椀琀礀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开圀嘀开挀漀渀搀甀挀琀愀渀挀攀崀 伀一 圀嘀唀匀㈀㄀㄀ ⠀挀漀渀搀甀挀琀愀渀挀攀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开圀嘀开猀琀愀洀瀀崀 伀一 圀嘀唀匀㈀㄀㄀ ⠀猀琀愀洀瀀 䐀䔀匀䌀⤀ ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开圀嘀开搀椀猀挀栀愀爀最攀崀 伀一 圀嘀唀匀㈀㄀㄀ ⠀搀椀猀挀栀愀爀最攀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开圀嘀开漀砀礀最攀渀崀 伀一 圀嘀唀匀㈀㄀㄀ ⠀漀砀礀最攀渀 䄀匀䌀⤀ഀഀ
GO਍ⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀഀഀ
CREATE TABLE WYUS223਍⠀ഀഀ
	[mli] varchar(32) NOT NULL,਍ऀ猀琀愀洀瀀 搀愀琀攀琀椀洀攀 一伀吀 一唀䰀䰀Ⰰഀഀ
	temperature    float,  -- Temperature, water, degrees Celsius਍ऀ挀漀渀搀甀挀琀愀渀挀攀    昀氀漀愀琀Ⰰ  ⴀⴀ 匀瀀攀挀椀昀椀挀 挀漀渀搀甀挀琀愀渀挀攀Ⰰ 眀愀琀攀爀Ⰰ 甀渀昀椀氀琀攀爀攀搀Ⰰ 洀椀挀爀漀猀椀攀洀攀渀猀 瀀攀爀 挀攀渀琀椀洀攀琀攀爀 愀琀 ㈀㔀 搀攀最爀攀攀猀 䌀攀氀猀椀甀猀 ഀഀ
	discharge      float,  -- Discharge, cubic feet per second਍ऀ瀀栀             昀氀漀愀琀Ⰰ  ⴀⴀ 瀀䠀Ⰰ 眀愀琀攀爀Ⰰ 甀渀昀椀氀琀攀爀攀搀Ⰰ 昀椀攀氀搀Ⰰ 猀琀愀渀搀愀爀搀 甀渀椀琀猀   ഀഀ
	turbidity      float,  -- unfiltered, monochrome near infra-red LED light, 780-900 nm, detection angle 90 +-2.5 degrees, formazin nephelometric units (FNU) ਍ऀ漀砀礀最攀渀         昀氀漀愀琀Ⰰ  ⴀⴀ 䐀椀猀猀漀氀瘀攀搀 漀砀礀最攀渀Ⰰ 眀愀琀攀爀Ⰰ 甀渀昀椀氀琀攀爀攀搀Ⰰ 洀椀氀氀椀最爀愀洀猀 瀀攀爀 氀椀琀攀爀 ഀഀ
	precipitation  float,  -- Precipitation, total, inches਍ऀ瘀攀氀漀挀椀琀礀       昀氀漀愀琀Ⰰഀഀ
	air  float, cloudcover  float,  pressure  float,  wind  float, winddir  float,  humidity  float,  elevation  float,਍ऀ猀椀搀 戀椀最椀渀琀 椀搀攀渀琀椀琀礀⠀㈀㈀㌀Ⰰ㔀　　⤀ 一伀吀 一唀䰀䰀 倀刀䤀䴀䄀刀夀 䬀䔀夀 䌀䰀唀匀吀䔀刀䔀䐀 ഀഀ
); ਍䜀伀   ഀഀ
SET IDENTITY_INSERT WYUS223 ON਍䜀伀   ഀഀ
ALTER TABLE WYUS223 ADD CONSTRAINT CHECK_WYUS223 CHECK((sid % 500) % 223 = 0)਍ⴀⴀ 愀氀琀攀爀 琀愀戀氀攀 圀夀唀匀㈀㈀㌀ 愀搀搀 猀椀搀 戀椀最椀渀琀 椀搀攀渀琀椀琀礀⠀㈀㈀㌀Ⰰ㔀　　⤀ 一伀吀 一唀䰀䰀 倀刀䤀䴀䄀刀夀 䬀䔀夀 䌀䰀唀匀吀䔀刀䔀䐀    ഀഀ
 ਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开圀夀开洀氀椀崀 伀一 圀夀唀匀㈀㈀㌀ ⠀洀氀椀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开圀夀开琀攀洀瀀攀爀愀琀甀爀攀崀 伀一 圀夀唀匀㈀㈀㌀ ⠀琀攀洀瀀攀爀愀琀甀爀攀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开圀夀开琀甀爀戀椀搀椀琀礀崀 伀一 圀夀唀匀㈀㈀㌀ ⠀琀甀爀戀椀搀椀琀礀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开圀夀开挀漀渀搀甀挀琀愀渀挀攀崀 伀一 圀夀唀匀㈀㈀㌀ ⠀挀漀渀搀甀挀琀愀渀挀攀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开圀夀开猀琀愀洀瀀崀 伀一 圀夀唀匀㈀㈀㌀ ⠀猀琀愀洀瀀 䐀䔀匀䌀⤀ ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开圀夀开搀椀猀挀栀愀爀最攀崀 伀一 圀夀唀匀㈀㈀㌀ ⠀搀椀猀挀栀愀爀最攀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开圀夀开漀砀礀最攀渀崀 伀一 圀夀唀匀㈀㈀㌀ ⠀漀砀礀最攀渀 䄀匀䌀⤀ഀഀ
GO਍ⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀഀഀ
CREATE TABLE HIUS227਍⠀ഀഀ
	[mli] varchar(32) NOT NULL,਍ऀ猀琀愀洀瀀 搀愀琀攀琀椀洀攀 一伀吀 一唀䰀䰀Ⰰഀഀ
	temperature    float,  -- Temperature, water, degrees Celsius਍ऀ挀漀渀搀甀挀琀愀渀挀攀    昀氀漀愀琀Ⰰ  ⴀⴀ 匀瀀攀挀椀昀椀挀 挀漀渀搀甀挀琀愀渀挀攀Ⰰ 眀愀琀攀爀Ⰰ 甀渀昀椀氀琀攀爀攀搀Ⰰ 洀椀挀爀漀猀椀攀洀攀渀猀 瀀攀爀 挀攀渀琀椀洀攀琀攀爀 愀琀 ㈀㔀 搀攀最爀攀攀猀 䌀攀氀猀椀甀猀 ഀഀ
	discharge      float,  -- Discharge, cubic feet per second਍ऀ瀀栀             昀氀漀愀琀Ⰰ  ⴀⴀ 瀀䠀Ⰰ 眀愀琀攀爀Ⰰ 甀渀昀椀氀琀攀爀攀搀Ⰰ 昀椀攀氀搀Ⰰ 猀琀愀渀搀愀爀搀 甀渀椀琀猀   ഀഀ
	turbidity      float,  -- unfiltered, monochrome near infra-red LED light, 780-900 nm, detection angle 90 +-2.5 degrees, formazin nephelometric units (FNU) ਍ऀ漀砀礀最攀渀         昀氀漀愀琀Ⰰ  ⴀⴀ 䐀椀猀猀漀氀瘀攀搀 漀砀礀最攀渀Ⰰ 眀愀琀攀爀Ⰰ 甀渀昀椀氀琀攀爀攀搀Ⰰ 洀椀氀氀椀最爀愀洀猀 瀀攀爀 氀椀琀攀爀 ഀഀ
	precipitation  float,  -- Precipitation, total, inches਍ऀ瘀攀氀漀挀椀琀礀       昀氀漀愀琀Ⰰഀഀ
	air  float, cloudcover  float,  pressure  float,  wind  float, winddir  float,  humidity  float,  elevation  float,਍ऀ猀椀搀 戀椀最椀渀琀 椀搀攀渀琀椀琀礀⠀㈀㈀㜀Ⰰ㔀　　⤀ 一伀吀 一唀䰀䰀 倀刀䤀䴀䄀刀夀 䬀䔀夀 䌀䰀唀匀吀䔀刀䔀䐀 ഀഀ
); ਍䜀伀ഀഀ
SET IDENTITY_INSERT HIUS227 ON਍䜀伀ഀഀ
ALTER TABLE HIUS227 ADD CONSTRAINT CHECK_HIUS227 CHECK((sid % 500) % 227 = 0)਍ⴀⴀ 愀氀琀攀爀 琀愀戀氀攀 䠀䤀唀匀㈀㈀㜀 愀搀搀 猀椀搀 戀椀最椀渀琀 椀搀攀渀琀椀琀礀⠀㈀㈀㜀Ⰰ㔀　　⤀ 一伀吀 一唀䰀䰀 倀刀䤀䴀䄀刀夀 䬀䔀夀 䌀䰀唀匀吀䔀刀䔀䐀    ഀഀ
   ਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开䠀䤀开洀氀椀崀 伀一 䠀䤀唀匀㈀㈀㜀 ⠀洀氀椀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开䠀䤀开琀攀洀瀀攀爀愀琀甀爀攀崀 伀一 䠀䤀唀匀㈀㈀㜀 ⠀琀攀洀瀀攀爀愀琀甀爀攀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开䠀䤀开琀甀爀戀椀搀椀琀礀崀 伀一 䠀䤀唀匀㈀㈀㜀 ⠀琀甀爀戀椀搀椀琀礀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开䠀䤀开挀漀渀搀甀挀琀愀渀挀攀崀 伀一 䠀䤀唀匀㈀㈀㜀 ⠀挀漀渀搀甀挀琀愀渀挀攀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开䠀䤀开猀琀愀洀瀀崀 伀一 䠀䤀唀匀㈀㈀㜀 ⠀猀琀愀洀瀀 䐀䔀匀䌀⤀ ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开䠀䤀开搀椀猀挀栀愀爀最攀崀 伀一 䠀䤀唀匀㈀㈀㜀 ⠀搀椀猀挀栀愀爀最攀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开䠀䤀开漀砀礀最攀渀崀 伀一 䠀䤀唀匀㈀㈀㜀 ⠀漀砀礀最攀渀 䄀匀䌀⤀ഀഀ
GO਍ⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀഀഀ
CREATE TABLE NMUS229਍⠀ഀഀ
	[mli] varchar(32) NOT NULL,਍ऀ猀琀愀洀瀀 搀愀琀攀琀椀洀攀 一伀吀 一唀䰀䰀Ⰰഀഀ
	temperature    float,  -- Temperature, water, degrees Celsius਍ऀ挀漀渀搀甀挀琀愀渀挀攀    昀氀漀愀琀Ⰰ  ⴀⴀ 匀瀀攀挀椀昀椀挀 挀漀渀搀甀挀琀愀渀挀攀Ⰰ 眀愀琀攀爀Ⰰ 甀渀昀椀氀琀攀爀攀搀Ⰰ 洀椀挀爀漀猀椀攀洀攀渀猀 瀀攀爀 挀攀渀琀椀洀攀琀攀爀 愀琀 ㈀㔀 搀攀最爀攀攀猀 䌀攀氀猀椀甀猀 ഀഀ
	discharge      float,  -- Discharge, cubic feet per second਍ऀ瀀栀             昀氀漀愀琀Ⰰ  ⴀⴀ 瀀䠀Ⰰ 眀愀琀攀爀Ⰰ 甀渀昀椀氀琀攀爀攀搀Ⰰ 昀椀攀氀搀Ⰰ 猀琀愀渀搀愀爀搀 甀渀椀琀猀   ഀഀ
	turbidity      float,  -- unfiltered, monochrome near infra-red LED light, 780-900 nm, detection angle 90 +-2.5 degrees, formazin nephelometric units (FNU) ਍ऀ漀砀礀最攀渀         昀氀漀愀琀Ⰰ  ⴀⴀ 䐀椀猀猀漀氀瘀攀搀 漀砀礀最攀渀Ⰰ 眀愀琀攀爀Ⰰ 甀渀昀椀氀琀攀爀攀搀Ⰰ 洀椀氀氀椀最爀愀洀猀 瀀攀爀 氀椀琀攀爀 ഀഀ
	precipitation  float,  -- Precipitation, total, inches਍ऀ瘀攀氀漀挀椀琀礀       昀氀漀愀琀Ⰰഀഀ
	air  float, cloudcover  float,  pressure  float,  wind  float, winddir  float,  humidity  float,  elevation  float,਍ऀ猀椀搀 戀椀最椀渀琀 椀搀攀渀琀椀琀礀⠀㈀㈀㤀Ⰰ㔀　　⤀ 一伀吀 一唀䰀䰀 倀刀䤀䴀䄀刀夀 䬀䔀夀 䌀䰀唀匀吀䔀刀䔀䐀 ഀഀ
); ਍䜀伀ഀഀ
SET IDENTITY_INSERT NMUS229 ON਍䜀伀ഀഀ
ALTER TABLE NMUS229 ADD CONSTRAINT CHECK_NMUS229 CHECK((sid % 500) % 229 = 0)਍ⴀⴀ 愀氀琀攀爀 琀愀戀氀攀 一䴀唀匀㈀㈀㤀 愀搀搀 猀椀搀 戀椀最椀渀琀 椀搀攀渀琀椀琀礀⠀㈀㈀㤀Ⰰ㔀　　⤀ 一伀吀 一唀䰀䰀 倀刀䤀䴀䄀刀夀 䬀䔀夀 䌀䰀唀匀吀䔀刀䔀䐀    ഀഀ
  ਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开一䴀开洀氀椀崀 伀一 一䴀唀匀㈀㈀㤀 ⠀洀氀椀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开一䴀开琀攀洀瀀攀爀愀琀甀爀攀崀 伀一 一䴀唀匀㈀㈀㤀 ⠀琀攀洀瀀攀爀愀琀甀爀攀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开一䴀开琀甀爀戀椀搀椀琀礀崀 伀一 一䴀唀匀㈀㈀㤀 ⠀琀甀爀戀椀搀椀琀礀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开一䴀开挀漀渀搀甀挀琀愀渀挀攀崀 伀一 一䴀唀匀㈀㈀㤀 ⠀挀漀渀搀甀挀琀愀渀挀攀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开一䴀开猀琀愀洀瀀崀 伀一 一䴀唀匀㈀㈀㤀 ⠀猀琀愀洀瀀 䐀䔀匀䌀⤀ ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开一䴀开搀椀猀挀栀愀爀最攀崀 伀一 一䴀唀匀㈀㈀㤀 ⠀搀椀猀挀栀愀爀最攀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开一䴀开漀砀礀最攀渀崀 伀一 一䴀唀匀㈀㈀㤀 ⠀漀砀礀最攀渀 䄀匀䌀⤀ഀഀ
GO਍ⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀഀഀ
CREATE TABLE UTUS233਍⠀ഀഀ
	[mli] varchar(32) NOT NULL,਍ऀ猀琀愀洀瀀 搀愀琀攀琀椀洀攀 一伀吀 一唀䰀䰀Ⰰഀഀ
	temperature    float,  -- Temperature, water, degrees Celsius਍ऀ挀漀渀搀甀挀琀愀渀挀攀    昀氀漀愀琀Ⰰ  ⴀⴀ 匀瀀攀挀椀昀椀挀 挀漀渀搀甀挀琀愀渀挀攀Ⰰ 眀愀琀攀爀Ⰰ 甀渀昀椀氀琀攀爀攀搀Ⰰ 洀椀挀爀漀猀椀攀洀攀渀猀 瀀攀爀 挀攀渀琀椀洀攀琀攀爀 愀琀 ㈀㔀 搀攀最爀攀攀猀 䌀攀氀猀椀甀猀 ഀഀ
	discharge      float,  -- Discharge, cubic feet per second਍ऀ瀀栀             昀氀漀愀琀Ⰰ  ⴀⴀ 瀀䠀Ⰰ 眀愀琀攀爀Ⰰ 甀渀昀椀氀琀攀爀攀搀Ⰰ 昀椀攀氀搀Ⰰ 猀琀愀渀搀愀爀搀 甀渀椀琀猀   ഀഀ
	turbidity      float,  -- unfiltered, monochrome near infra-red LED light, 780-900 nm, detection angle 90 +-2.5 degrees, formazin nephelometric units (FNU) ਍ऀ漀砀礀最攀渀         昀氀漀愀琀Ⰰ  ⴀⴀ 䐀椀猀猀漀氀瘀攀搀 漀砀礀最攀渀Ⰰ 眀愀琀攀爀Ⰰ 甀渀昀椀氀琀攀爀攀搀Ⰰ 洀椀氀氀椀最爀愀洀猀 瀀攀爀 氀椀琀攀爀 ഀഀ
	precipitation  float,  -- Precipitation, total, inches਍ऀ瘀攀氀漀挀椀琀礀       昀氀漀愀琀Ⰰഀഀ
	air  float, cloudcover  float,  pressure  float,  wind  float, winddir  float,  humidity  float,  elevation  float,਍ऀ猀椀搀 戀椀最椀渀琀 椀搀攀渀琀椀琀礀⠀㈀㌀㌀Ⰰ㔀　　⤀ 一伀吀 一唀䰀䰀 倀刀䤀䴀䄀刀夀 䬀䔀夀 䌀䰀唀匀吀䔀刀䔀䐀 ഀഀ
); ਍䜀伀ഀഀ
SET IDENTITY_INSERT UTUS233 ON਍䜀伀ഀഀ
ALTER TABLE UTUS233 ADD CONSTRAINT CHECK_UTUS233 CHECK((sid % 500) % 233 = 0)਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_UTUS233_mli] ON UTUS233 (mli ASC)਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_UTUS233_temperature] ON UTUS233 (temperature ASC)਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_UTUS233_turbidity] ON UTUS233 (turbidity ASC)਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_UTUS233_conductance] ON UTUS233 (conductance ASC)਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_UTUS233_stamp] ON UTUS233 (stamp DESC) ਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_UTUS233_discharge] ON UTUS233 (discharge ASC)਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_UTUS233_oxygen] ON UTUS233 (oxygen ASC)਍䜀伀ഀഀ
------------------------------------------------------------------------------------------------਍䌀刀䔀䄀吀䔀 吀䄀䈀䰀䔀 䬀夀唀匀㈀㌀㤀ഀഀ
(਍ऀ嬀洀氀椀崀 瘀愀爀挀栀愀爀⠀㌀㈀⤀ 一伀吀 一唀䰀䰀Ⰰഀഀ
	stamp datetime NOT NULL,਍ऀ琀攀洀瀀攀爀愀琀甀爀攀    昀氀漀愀琀Ⰰ  ⴀⴀ 吀攀洀瀀攀爀愀琀甀爀攀Ⰰ 眀愀琀攀爀Ⰰ 搀攀最爀攀攀猀 䌀攀氀猀椀甀猀ഀഀ
	conductance    float,  -- Specific conductance, water, unfiltered, microsiemens per centimeter at 25 degrees Celsius ਍ऀ搀椀猀挀栀愀爀最攀      昀氀漀愀琀Ⰰ  ⴀⴀ 䐀椀猀挀栀愀爀最攀Ⰰ 挀甀戀椀挀 昀攀攀琀 瀀攀爀 猀攀挀漀渀搀ഀഀ
	ph             float,  -- pH, water, unfiltered, field, standard units   ਍ऀ琀甀爀戀椀搀椀琀礀      昀氀漀愀琀Ⰰ  ⴀⴀ 甀渀昀椀氀琀攀爀攀搀Ⰰ 洀漀渀漀挀栀爀漀洀攀 渀攀愀爀 椀渀昀爀愀ⴀ爀攀搀 䰀䔀䐀 氀椀最栀琀Ⰰ 㜀㠀　ⴀ㤀　　 渀洀Ⰰ 搀攀琀攀挀琀椀漀渀 愀渀最氀攀 㤀　 ⬀ⴀ㈀⸀㔀 搀攀最爀攀攀猀Ⰰ 昀漀爀洀愀稀椀渀 渀攀瀀栀攀氀漀洀攀琀爀椀挀 甀渀椀琀猀 ⠀䘀一唀⤀ ഀഀ
	oxygen         float,  -- Dissolved oxygen, water, unfiltered, milligrams per liter ਍ऀ瀀爀攀挀椀瀀椀琀愀琀椀漀渀  昀氀漀愀琀Ⰰ  ⴀⴀ 倀爀攀挀椀瀀椀琀愀琀椀漀渀Ⰰ 琀漀琀愀氀Ⰰ 椀渀挀栀攀猀ഀഀ
	velocity       float,਍ऀ愀椀爀  昀氀漀愀琀Ⰰ 挀氀漀甀搀挀漀瘀攀爀  昀氀漀愀琀Ⰰ  瀀爀攀猀猀甀爀攀  昀氀漀愀琀Ⰰ  眀椀渀搀  昀氀漀愀琀Ⰰ 眀椀渀搀搀椀爀  昀氀漀愀琀Ⰰ  栀甀洀椀搀椀琀礀  昀氀漀愀琀Ⰰ  攀氀攀瘀愀琀椀漀渀  昀氀漀愀琀Ⰰഀഀ
	sid bigint identity(239,500) NOT NULL PRIMARY KEY CLUSTERED ਍⤀㬀 ഀഀ
GO਍匀䔀吀 䤀䐀䔀一吀䤀吀夀开䤀一匀䔀刀吀 䬀夀唀匀㈀㌀㤀 伀一ഀഀ
GO਍䄀䰀吀䔀刀 吀䄀䈀䰀䔀 䬀夀唀匀㈀㌀㤀 䄀䐀䐀 䌀伀一匀吀刀䄀䤀一吀 䌀䠀䔀䌀䬀开䬀夀唀匀㈀㌀㤀 䌀䠀䔀䌀䬀⠀⠀猀椀搀 ─ 㔀　　⤀ ─ ㈀㌀㤀 㴀 　⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开䬀夀开洀氀椀崀 伀一 䬀夀唀匀㈀㌀㤀 ⠀洀氀椀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开䬀夀开琀攀洀瀀攀爀愀琀甀爀攀崀 伀一 䬀夀唀匀㈀㌀㤀 ⠀琀攀洀瀀攀爀愀琀甀爀攀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开䬀夀开琀甀爀戀椀搀椀琀礀崀 伀一 䬀夀唀匀㈀㌀㤀 ⠀琀甀爀戀椀搀椀琀礀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开䬀夀开挀漀渀搀甀挀琀愀渀挀攀崀 伀一 䬀夀唀匀㈀㌀㤀 ⠀挀漀渀搀甀挀琀愀渀挀攀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开䬀夀开猀琀愀洀瀀崀 伀一 䬀夀唀匀㈀㌀㤀 ⠀猀琀愀洀瀀 䐀䔀匀䌀⤀ ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开䬀夀开搀椀猀挀栀愀爀最攀崀 伀一 䬀夀唀匀㈀㌀㤀 ⠀搀椀猀挀栀愀爀最攀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开䬀夀开漀砀礀最攀渀崀 伀一 䬀夀唀匀㈀㌀㤀 ⠀漀砀礀最攀渀 䄀匀䌀⤀ഀഀ
GO਍ⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀഀഀ
CREATE TABLE PRUS241਍⠀ഀഀ
	[mli] varchar(32) NOT NULL,਍ऀ猀琀愀洀瀀 搀愀琀攀琀椀洀攀 一伀吀 一唀䰀䰀Ⰰഀഀ
	temperature    float,  -- Temperature, water, degrees Celsius਍ऀ挀漀渀搀甀挀琀愀渀挀攀    昀氀漀愀琀Ⰰ  ⴀⴀ 匀瀀攀挀椀昀椀挀 挀漀渀搀甀挀琀愀渀挀攀Ⰰ 眀愀琀攀爀Ⰰ 甀渀昀椀氀琀攀爀攀搀Ⰰ 洀椀挀爀漀猀椀攀洀攀渀猀 瀀攀爀 挀攀渀琀椀洀攀琀攀爀 愀琀 ㈀㔀 搀攀最爀攀攀猀 䌀攀氀猀椀甀猀 ഀഀ
	discharge      float,  -- Discharge, cubic feet per second਍ऀ瀀栀             昀氀漀愀琀Ⰰ  ⴀⴀ 瀀䠀Ⰰ 眀愀琀攀爀Ⰰ 甀渀昀椀氀琀攀爀攀搀Ⰰ 昀椀攀氀搀Ⰰ 猀琀愀渀搀愀爀搀 甀渀椀琀猀   ഀഀ
	turbidity      float,  -- unfiltered, monochrome near infra-red LED light, 780-900 nm, detection angle 90 +-2.5 degrees, formazin nephelometric units (FNU) ਍ऀ漀砀礀最攀渀         昀氀漀愀琀Ⰰ  ⴀⴀ 䐀椀猀猀漀氀瘀攀搀 漀砀礀最攀渀Ⰰ 眀愀琀攀爀Ⰰ 甀渀昀椀氀琀攀爀攀搀Ⰰ 洀椀氀氀椀最爀愀洀猀 瀀攀爀 氀椀琀攀爀 ഀഀ
	precipitation  float,  -- Precipitation, total, inches਍ऀ瘀攀氀漀挀椀琀礀       昀氀漀愀琀Ⰰഀഀ
	air  float, cloudcover  float,  pressure  float,  wind  float, winddir  float,  humidity  float,  elevation  float,਍ऀ猀椀搀 戀椀最椀渀琀 椀搀攀渀琀椀琀礀⠀㈀㐀㄀Ⰰ㔀　　⤀ 一伀吀 一唀䰀䰀 倀刀䤀䴀䄀刀夀 䬀䔀夀 䌀䰀唀匀吀䔀刀䔀䐀 ഀഀ
); ਍䜀伀ഀഀ
SET IDENTITY_INSERT PRUS241 ON਍䜀伀ഀഀ
ALTER TABLE PRUS241 ADD CONSTRAINT CHECK_PRUS241 CHECK((sid % 500) % 241 = 0)਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_PRUS241_mli] ON PRUS241 (mli ASC)਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_PRUS241_temperature] ON PRUS241 (temperature ASC)਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_PRUS241_turbidity] ON PRUS241 (turbidity ASC)਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_PRUS241_conductance] ON PRUS241 (conductance ASC)਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_PRUS241_stamp] ON PRUS241 (stamp DESC) ਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_PRUS241_discharge] ON PRUS241 (discharge ASC)਍䜀伀ഀഀ
CREATE NONCLUSTERED INDEX [idx_PRUS241_oxygen] ON PRUS241 (oxygen ASC)਍䜀伀ഀഀ
------------------------------------------------------------------------------------------------਍䌀刀䔀䄀吀䔀 吀䄀䈀䰀䔀 嘀䤀唀匀㈀㔀㄀ഀഀ
(਍ऀ嬀洀氀椀崀 瘀愀爀挀栀愀爀⠀㌀㈀⤀ 一伀吀 一唀䰀䰀Ⰰഀഀ
	stamp datetime NOT NULL,਍ऀ琀攀洀瀀攀爀愀琀甀爀攀    昀氀漀愀琀Ⰰ  ⴀⴀ 吀攀洀瀀攀爀愀琀甀爀攀Ⰰ 眀愀琀攀爀Ⰰ 搀攀最爀攀攀猀 䌀攀氀猀椀甀猀ഀഀ
	conductance    float,  -- Specific conductance, water, unfiltered, microsiemens per centimeter at 25 degrees Celsius ਍ऀ搀椀猀挀栀愀爀最攀      昀氀漀愀琀Ⰰ  ⴀⴀ 䐀椀猀挀栀愀爀最攀Ⰰ 挀甀戀椀挀 昀攀攀琀 瀀攀爀 猀攀挀漀渀搀ഀഀ
	ph             float,  -- pH, water, unfiltered, field, standard units   ਍ऀ琀甀爀戀椀搀椀琀礀      昀氀漀愀琀Ⰰ  ⴀⴀ 甀渀昀椀氀琀攀爀攀搀Ⰰ 洀漀渀漀挀栀爀漀洀攀 渀攀愀爀 椀渀昀爀愀ⴀ爀攀搀 䰀䔀䐀 氀椀最栀琀Ⰰ 㜀㠀　ⴀ㤀　　 渀洀Ⰰ 搀攀琀攀挀琀椀漀渀 愀渀最氀攀 㤀　 ⬀ⴀ㈀⸀㔀 搀攀最爀攀攀猀Ⰰ 昀漀爀洀愀稀椀渀 渀攀瀀栀攀氀漀洀攀琀爀椀挀 甀渀椀琀猀 ⠀䘀一唀⤀ ഀഀ
	oxygen         float,  -- Dissolved oxygen, water, unfiltered, milligrams per liter ਍ऀ瀀爀攀挀椀瀀椀琀愀琀椀漀渀  昀氀漀愀琀Ⰰ  ⴀⴀ 倀爀攀挀椀瀀椀琀愀琀椀漀渀Ⰰ 琀漀琀愀氀Ⰰ 椀渀挀栀攀猀ഀഀ
	velocity       float,਍ऀ愀椀爀  昀氀漀愀琀Ⰰ 挀氀漀甀搀挀漀瘀攀爀  昀氀漀愀琀Ⰰ  瀀爀攀猀猀甀爀攀  昀氀漀愀琀Ⰰ  眀椀渀搀  昀氀漀愀琀Ⰰ 眀椀渀搀搀椀爀  昀氀漀愀琀Ⰰ  栀甀洀椀搀椀琀礀  昀氀漀愀琀Ⰰ  攀氀攀瘀愀琀椀漀渀  昀氀漀愀琀Ⰰഀഀ
	sid bigint identity(251,500) NOT NULL PRIMARY KEY CLUSTERED ਍⤀㬀 ഀഀ
GO਍匀䔀吀 䤀䐀䔀一吀䤀吀夀开䤀一匀䔀刀吀 倀刀唀匀㈀㔀㄀ 伀一ഀഀ
GO਍䄀䰀吀䔀刀 吀䄀䈀䰀䔀 嘀䤀唀匀㈀㔀㄀ 䄀䐀䐀 䌀伀一匀吀刀䄀䤀一吀 䌀䠀䔀䌀䬀开嘀䤀唀匀㈀㔀㄀ 䌀䠀䔀䌀䬀⠀⠀猀椀搀 ─ 㔀　　⤀ ─ ㈀㔀㄀ 㴀 　⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开嘀䤀唀匀㈀㔀㄀开洀氀椀崀 伀一 嘀䤀唀匀㈀㔀㄀ ⠀洀氀椀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开嘀䤀唀匀㈀㔀㄀开琀攀洀瀀攀爀愀琀甀爀攀崀 伀一 嘀䤀唀匀㈀㔀㄀ ⠀琀攀洀瀀攀爀愀琀甀爀攀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开嘀䤀唀匀㈀㔀㄀开琀甀爀戀椀搀椀琀礀崀 伀一 嘀䤀唀匀㈀㔀㄀ ⠀琀甀爀戀椀搀椀琀礀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开嘀䤀唀匀㈀㔀㄀开挀漀渀搀甀挀琀愀渀挀攀崀 伀一 嘀䤀唀匀㈀㔀㄀ ⠀挀漀渀搀甀挀琀愀渀挀攀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开嘀䤀唀匀㈀㔀㄀开猀琀愀洀瀀崀 伀一 嘀䤀唀匀㈀㔀㄀ ⠀猀琀愀洀瀀 䐀䔀匀䌀⤀ ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开嘀䤀唀匀㈀㔀㄀开搀椀猀挀栀愀爀最攀崀 伀一 嘀䤀唀匀㈀㔀㄀ ⠀搀椀猀挀栀愀爀最攀 䄀匀䌀⤀ഀഀ
GO਍䌀刀䔀䄀吀䔀 一伀一䌀䰀唀匀吀䔀刀䔀䐀 䤀一䐀䔀堀 嬀椀搀砀开嘀䤀唀匀㈀㔀㄀开漀砀礀最攀渀崀 伀一 嘀䤀唀匀㈀㔀㄀ ⠀漀砀礀最攀渀 䄀匀䌀⤀ഀഀ
GO਍ⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀ⨀ഀഀ
਍䤀䘀 䔀堀䤀匀吀匀 ⠀匀䔀䰀䔀䌀吀 ⨀ 䘀刀伀䴀 猀礀猀漀戀樀攀挀琀猀 圀䠀䔀刀䔀 一䄀䴀䔀 㴀 ✀瘀唀匀圀愀琀攀爀䐀愀琀愀✀ 䄀一䐀 琀礀瀀攀 㴀 ✀嘀✀⤀ഀഀ
	DROP VIEW dbo.vUSWaterData਍䜀伀ഀഀ
CREATE VIEW vUSWaterData with schemabinding਍䄀匀ഀഀ
SELECT sid, mli, temperature, conductance, discharge, ph, turbidity, oxygen, stamp, elevation FROM dbo.PRUS241 UNION ALL਍匀䔀䰀䔀䌀吀 猀椀搀Ⰰ 洀氀椀Ⰰ 琀攀洀瀀攀爀愀琀甀爀攀Ⰰ 挀漀渀搀甀挀琀愀渀挀攀Ⰰ 搀椀猀挀栀愀爀最攀Ⰰ 瀀栀Ⰰ 琀甀爀戀椀搀椀琀礀Ⰰ 漀砀礀最攀渀Ⰰ 猀琀愀洀瀀Ⰰ 攀氀攀瘀愀琀椀漀渀 䘀刀伀䴀 搀戀漀⸀嘀䤀唀匀㈀㔀㄀ 唀一䤀伀一 䄀䰀䰀ഀഀ
SELECT sid, mli, temperature, conductance, discharge, ph, turbidity, oxygen, stamp, elevation FROM dbo.WVUS211 UNION ALL਍匀䔀䰀䔀䌀吀 猀椀搀Ⰰ 洀氀椀Ⰰ 琀攀洀瀀攀爀愀琀甀爀攀Ⰰ 挀漀渀搀甀挀琀愀渀挀攀Ⰰ 搀椀猀挀栀愀爀最攀Ⰰ 瀀栀Ⰰ 琀甀爀戀椀搀椀琀礀Ⰰ 漀砀礀最攀渀Ⰰ 猀琀愀洀瀀Ⰰ 攀氀攀瘀愀琀椀漀渀 䘀刀伀䴀 搀戀漀⸀嘀䄀唀匀　㐀㌀ 唀一䤀伀一 䄀䰀䰀ഀഀ
SELECT sid, mli, temperature, conductance, discharge, ph, turbidity, oxygen, stamp, elevation FROM dbo.WYUS223 UNION ALL਍匀䔀䰀䔀䌀吀 猀椀搀Ⰰ 洀氀椀Ⰰ 琀攀洀瀀攀爀愀琀甀爀攀Ⰰ 挀漀渀搀甀挀琀愀渀挀攀Ⰰ 搀椀猀挀栀愀爀最攀Ⰰ 瀀栀Ⰰ 琀甀爀戀椀搀椀琀礀Ⰰ 漀砀礀最攀渀Ⰰ 猀琀愀洀瀀Ⰰ 攀氀攀瘀愀琀椀漀渀 䘀刀伀䴀 搀戀漀⸀䴀䔀唀匀　㐀㜀 唀一䤀伀一 䄀䰀䰀ഀഀ
SELECT sid, mli, temperature, conductance, discharge, ph, turbidity, oxygen, stamp, elevation FROM dbo.HIUS227 UNION ALL਍匀䔀䰀䔀䌀吀 猀椀搀Ⰰ 洀氀椀Ⰰ 琀攀洀瀀攀爀愀琀甀爀攀Ⰰ 挀漀渀搀甀挀琀愀渀挀攀Ⰰ 搀椀猀挀栀愀爀最攀Ⰰ 瀀栀Ⰰ 琀甀爀戀椀搀椀琀礀Ⰰ 漀砀礀最攀渀Ⰰ 猀琀愀洀瀀Ⰰ 攀氀攀瘀愀琀椀漀渀 䘀刀伀䴀 搀戀漀⸀䄀䬀唀匀　㔀㌀ 唀一䤀伀一 䄀䰀䰀ഀഀ
SELECT sid, mli, temperature, conductance, discharge, ph, turbidity, oxygen, stamp, elevation FROM dbo.NMUS229 UNION ALL਍匀䔀䰀䔀䌀吀 猀椀搀Ⰰ 洀氀椀Ⰰ 琀攀洀瀀攀爀愀琀甀爀攀Ⰰ 挀漀渀搀甀挀琀愀渀挀攀Ⰰ 搀椀猀挀栀愀爀最攀Ⰰ 瀀栀Ⰰ 琀甀爀戀椀搀椀琀礀Ⰰ 漀砀礀最攀渀Ⰰ 猀琀愀洀瀀Ⰰ 攀氀攀瘀愀琀椀漀渀 䘀刀伀䴀 搀戀漀⸀匀䌀唀匀　㔀㤀 唀一䤀伀一 䄀䰀䰀ഀഀ
SELECT sid, mli, temperature, conductance, discharge, ph, turbidity, oxygen, stamp, elevation FROM dbo.UTUS233 UNION ALL਍匀䔀䰀䔀䌀吀 猀椀搀Ⰰ 洀氀椀Ⰰ 琀攀洀瀀攀爀愀琀甀爀攀Ⰰ 挀漀渀搀甀挀琀愀渀挀攀Ⰰ 搀椀猀挀栀愀爀最攀Ⰰ 瀀栀Ⰰ 琀甀爀戀椀搀椀琀礀Ⰰ 漀砀礀最攀渀Ⰰ 猀琀愀洀瀀Ⰰ 攀氀攀瘀愀琀椀漀渀 䘀刀伀䴀 搀戀漀⸀刀䤀唀匀　㘀㄀ 唀一䤀伀一 䄀䰀䰀ഀഀ
SELECT sid, mli, temperature, conductance, discharge, ph, turbidity, oxygen, stamp, elevation FROM dbo.KYUS239 UNION ALL਍匀䔀䰀䔀䌀吀 猀椀搀Ⰰ 洀氀椀Ⰰ 琀攀洀瀀攀爀愀琀甀爀攀Ⰰ 挀漀渀搀甀挀琀愀渀挀攀Ⰰ 搀椀猀挀栀愀爀最攀Ⰰ 瀀栀Ⰰ 琀甀爀戀椀搀椀琀礀Ⰰ 漀砀礀最攀渀Ⰰ 猀琀愀洀瀀Ⰰ 攀氀攀瘀愀琀椀漀渀 䘀刀伀䴀 搀戀漀⸀圀䄀唀匀　㘀㜀 唀一䤀伀一 䄀䰀䰀ഀഀ
SELECT sid, mli, temperature, conductance, discharge, ph, turbidity, oxygen, stamp, elevation FROM dbo.MAUS071 UNION ALL਍匀䔀䰀䔀䌀吀 猀椀搀Ⰰ 洀氀椀Ⰰ 琀攀洀瀀攀爀愀琀甀爀攀Ⰰ 挀漀渀搀甀挀琀愀渀挀攀Ⰰ 搀椀猀挀栀愀爀最攀Ⰰ 瀀栀Ⰰ 琀甀爀戀椀搀椀琀礀Ⰰ 漀砀礀最攀渀Ⰰ 猀琀愀洀瀀Ⰰ 攀氀攀瘀愀琀椀漀渀 䘀刀伀䴀 搀戀漀⸀一嘀唀匀　㜀㌀ 唀一䤀伀一 䄀䰀䰀ഀഀ
SELECT sid, mli, temperature, conductance, discharge, ph, turbidity, oxygen, stamp, elevation FROM dbo.NYUS079 UNION ALL਍匀䔀䰀䔀䌀吀 猀椀搀Ⰰ 洀氀椀Ⰰ 琀攀洀瀀攀爀愀琀甀爀攀Ⰰ 挀漀渀搀甀挀琀愀渀挀攀Ⰰ 搀椀猀挀栀愀爀最攀Ⰰ 瀀栀Ⰰ 琀甀爀戀椀搀椀琀礀Ⰰ 漀砀礀最攀渀Ⰰ 猀琀愀洀瀀Ⰰ 攀氀攀瘀愀琀椀漀渀 䘀刀伀䴀 搀戀漀⸀伀䠀唀匀　㠀㌀ 唀一䤀伀一 䄀䰀䰀ഀഀ
SELECT sid, mli, temperature, conductance, discharge, ph, turbidity, oxygen, stamp, elevation FROM dbo.SDUS089 UNION ALL਍匀䔀䰀䔀䌀吀 猀椀搀Ⰰ 洀氀椀Ⰰ 琀攀洀瀀攀爀愀琀甀爀攀Ⰰ 挀漀渀搀甀挀琀愀渀挀攀Ⰰ 搀椀猀挀栀愀爀最攀Ⰰ 瀀栀Ⰰ 琀甀爀戀椀搀椀琀礀Ⰰ 漀砀礀最攀渀Ⰰ 猀琀愀洀瀀Ⰰ 攀氀攀瘀愀琀椀漀渀 䘀刀伀䴀 搀戀漀⸀䌀吀唀匀　㤀㜀 唀一䤀伀一 䄀䰀䰀ഀഀ
SELECT sid, mli, temperature, conductance, discharge, ph, turbidity, oxygen, stamp, elevation FROM dbo.LAUS101 UNION ALL਍匀䔀䰀䔀䌀吀 猀椀搀Ⰰ 洀氀椀Ⰰ 琀攀洀瀀攀爀愀琀甀爀攀Ⰰ 挀漀渀搀甀挀琀愀渀挀攀Ⰰ 搀椀猀挀栀愀爀最攀Ⰰ 瀀栀Ⰰ 琀甀爀戀椀搀椀琀礀Ⰰ 漀砀礀最攀渀Ⰰ 猀琀愀洀瀀Ⰰ 攀氀攀瘀愀琀椀漀渀 䘀刀伀䴀 搀戀漀⸀一䨀唀匀㄀　㌀ 唀一䤀伀一 䄀䰀䰀ഀഀ
SELECT sid, mli, temperature, conductance, discharge, ph, turbidity, oxygen, stamp, elevation FROM dbo.MOUS107 UNION ALL਍匀䔀䰀䔀䌀吀 猀椀搀Ⰰ 洀氀椀Ⰰ 琀攀洀瀀攀爀愀琀甀爀攀Ⰰ 挀漀渀搀甀挀琀愀渀挀攀Ⰰ 搀椀猀挀栀愀爀最攀Ⰰ 瀀栀Ⰰ 琀甀爀戀椀搀椀琀礀Ⰰ 漀砀礀最攀渀Ⰰ 猀琀愀洀瀀Ⰰ 攀氀攀瘀愀琀椀漀渀 䘀刀伀䴀 搀戀漀⸀䌀䄀唀匀㄀　㤀 唀一䤀伀一 䄀䰀䰀ഀഀ
SELECT sid, mli, temperature, conductance, discharge, ph, turbidity, oxygen, stamp, elevation FROM dbo.ORUS113 UNION ALL਍匀䔀䰀䔀䌀吀 猀椀搀Ⰰ 洀氀椀Ⰰ 琀攀洀瀀攀爀愀琀甀爀攀Ⰰ 挀漀渀搀甀挀琀愀渀挀攀Ⰰ 搀椀猀挀栀愀爀最攀Ⰰ 瀀栀Ⰰ 琀甀爀戀椀搀椀琀礀Ⰰ 漀砀礀最攀渀Ⰰ 猀琀愀洀瀀Ⰰ 攀氀攀瘀愀琀椀漀渀 䘀刀伀䴀 搀戀漀⸀䴀一唀匀㄀㈀㜀 唀一䤀伀一 䄀䰀䰀ഀഀ
SELECT sid, mli, temperature, conductance, discharge, ph, turbidity, oxygen, stamp, elevation FROM dbo.MTUS131 UNION ALL਍匀䔀䰀䔀䌀吀 猀椀搀Ⰰ 洀氀椀Ⰰ 琀攀洀瀀攀爀愀琀甀爀攀Ⰰ 挀漀渀搀甀挀琀愀渀挀攀Ⰰ 搀椀猀挀栀愀爀最攀Ⰰ 瀀栀Ⰰ 琀甀爀戀椀搀椀琀礀Ⰰ 漀砀礀最攀渀Ⰰ 猀琀愀洀瀀Ⰰ 攀氀攀瘀愀琀椀漀渀 䘀刀伀䴀 搀戀漀⸀伀䬀唀匀㄀㌀㜀 唀一䤀伀一 䄀䰀䰀ഀഀ
SELECT sid, mli, temperature, conductance, discharge, ph, turbidity, oxygen, stamp, elevation FROM dbo.FLUS139 UNION ALL਍匀䔀䰀䔀䌀吀 猀椀搀Ⰰ 洀氀椀Ⰰ 琀攀洀瀀攀爀愀琀甀爀攀Ⰰ 挀漀渀搀甀挀琀愀渀挀攀Ⰰ 搀椀猀挀栀愀爀最攀Ⰰ 瀀栀Ⰰ 琀甀爀戀椀搀椀琀礀Ⰰ 漀砀礀最攀渀Ⰰ 猀琀愀洀瀀Ⰰ 攀氀攀瘀愀琀椀漀渀 䘀刀伀䴀 搀戀漀⸀䄀刀唀匀㄀㐀㤀 唀一䤀伀一 䄀䰀䰀ഀഀ
SELECT sid, mli, temperature, conductance, discharge, ph, turbidity, oxygen, stamp, elevation FROM dbo.IAUS151 UNION ALL਍匀䔀䰀䔀䌀吀 猀椀搀Ⰰ 洀氀椀Ⰰ 琀攀洀瀀攀爀愀琀甀爀攀Ⰰ 挀漀渀搀甀挀琀愀渀挀攀Ⰰ 搀椀猀挀栀愀爀最攀Ⰰ 瀀栀Ⰰ 琀甀爀戀椀搀椀琀礀Ⰰ 漀砀礀最攀渀Ⰰ 猀琀愀洀瀀Ⰰ 攀氀攀瘀愀琀椀漀渀 䘀刀伀䴀 搀戀漀⸀吀堀唀匀　　㌀ 唀一䤀伀一 䄀䰀䰀ഀഀ
SELECT sid, mli, temperature, conductance, discharge, ph, turbidity, oxygen, stamp, elevation FROM dbo.VTUS157 UNION ALL਍匀䔀䰀䔀䌀吀 猀椀搀Ⰰ 洀氀椀Ⰰ 琀攀洀瀀攀爀愀琀甀爀攀Ⰰ 挀漀渀搀甀挀琀愀渀挀攀Ⰰ 搀椀猀挀栀愀爀最攀Ⰰ 瀀栀Ⰰ 琀甀爀戀椀搀椀琀礀Ⰰ 漀砀礀最攀渀Ⰰ 猀琀愀洀瀀Ⰰ 攀氀攀瘀愀琀椀漀渀 䘀刀伀䴀 搀戀漀⸀䬀匀唀匀　　㔀 唀一䤀伀一 䄀䰀䰀ഀഀ
SELECT sid, mli, temperature, conductance, discharge, ph, turbidity, oxygen, stamp, elevation FROM dbo.ALUS163 UNION ALL਍匀䔀䰀䔀䌀吀 猀椀搀Ⰰ 洀氀椀Ⰰ 琀攀洀瀀攀爀愀琀甀爀攀Ⰰ 挀漀渀搀甀挀琀愀渀挀攀Ⰰ 搀椀猀挀栀愀爀最攀Ⰰ 瀀栀Ⰰ 琀甀爀戀椀搀椀琀礀Ⰰ 漀砀礀最攀渀Ⰰ 猀琀愀洀瀀Ⰰ 攀氀攀瘀愀琀椀漀渀 䘀刀伀䴀 搀戀漀⸀倀䄀唀匀　　㜀 唀一䤀伀一 䄀䰀䰀ഀഀ
SELECT sid, mli, temperature, conductance, discharge, ph, turbidity, oxygen, stamp, elevation FROM dbo.NDUS167 UNION ALL਍匀䔀䰀䔀䌀吀 猀椀搀Ⰰ 洀氀椀Ⰰ 琀攀洀瀀攀爀愀琀甀爀攀Ⰰ 挀漀渀搀甀挀琀愀渀挀攀Ⰰ 搀椀猀挀栀愀爀最攀Ⰰ 瀀栀Ⰰ 琀甀爀戀椀搀椀琀礀Ⰰ 漀砀礀最攀渀Ⰰ 猀琀愀洀瀀Ⰰ 攀氀攀瘀愀琀椀漀渀 䘀刀伀䴀 搀戀漀⸀圀䤀唀匀　㄀㄀ 唀一䤀伀一 䄀䰀䰀ഀഀ
SELECT sid, mli, temperature, conductance, discharge, ph, turbidity, oxygen, stamp, elevation FROM dbo.IDUS173 UNION ALL਍匀䔀䰀䔀䌀吀 猀椀搀Ⰰ 洀氀椀Ⰰ 琀攀洀瀀攀爀愀琀甀爀攀Ⰰ 挀漀渀搀甀挀琀愀渀挀攀Ⰰ 搀椀猀挀栀愀爀最攀Ⰰ 瀀栀Ⰰ 琀甀爀戀椀搀椀琀礀Ⰰ 漀砀礀最攀渀Ⰰ 猀琀愀洀瀀Ⰰ 攀氀攀瘀愀琀椀漀渀 䘀刀伀䴀 搀戀漀⸀䐀䔀唀匀　㄀㌀ 唀一䤀伀一 䄀䰀䰀ഀഀ
SELECT sid, mli, temperature, conductance, discharge, ph, turbidity, oxygen, stamp, elevation FROM dbo.GAUS179 UNION ALL਍匀䔀䰀䔀䌀吀 猀椀搀Ⰰ 洀氀椀Ⰰ 琀攀洀瀀攀爀愀琀甀爀攀Ⰰ 挀漀渀搀甀挀琀愀渀挀攀Ⰰ 搀椀猀挀栀愀爀最攀Ⰰ 瀀栀Ⰰ 琀甀爀戀椀搀椀琀礀Ⰰ 漀砀礀最攀渀Ⰰ 猀琀愀洀瀀Ⰰ 攀氀攀瘀愀琀椀漀渀 䘀刀伀䴀 搀戀漀⸀䤀一唀匀　㄀㜀 唀一䤀伀一 䄀䰀䰀ഀഀ
SELECT sid, mli, temperature, conductance, discharge, ph, turbidity, oxygen, stamp, elevation FROM dbo.AZUS181 UNION ALL਍匀䔀䰀䔀䌀吀 猀椀搀Ⰰ 洀氀椀Ⰰ 琀攀洀瀀攀爀愀琀甀爀攀Ⰰ 挀漀渀搀甀挀琀愀渀挀攀Ⰰ 搀椀猀挀栀愀爀最攀Ⰰ 瀀栀Ⰰ 琀甀爀戀椀搀椀琀礀Ⰰ 漀砀礀最攀渀Ⰰ 猀琀愀洀瀀Ⰰ 攀氀攀瘀愀琀椀漀渀 䘀刀伀䴀 搀戀漀⸀一䠀唀匀　㈀㌀ 唀一䤀伀一 䄀䰀䰀ഀഀ
SELECT sid, mli, temperature, conductance, discharge, ph, turbidity, oxygen, stamp, elevation FROM dbo.MSUS191 UNION ALL਍匀䔀䰀䔀䌀吀 猀椀搀Ⰰ 洀氀椀Ⰰ 琀攀洀瀀攀爀愀琀甀爀攀Ⰰ 挀漀渀搀甀挀琀愀渀挀攀Ⰰ 搀椀猀挀栀愀爀最攀Ⰰ 瀀栀Ⰰ 琀甀爀戀椀搀椀琀礀Ⰰ 漀砀礀最攀渀Ⰰ 猀琀愀洀瀀Ⰰ 攀氀攀瘀愀琀椀漀渀 䘀刀伀䴀 搀戀漀⸀䴀䐀唀匀　㈀㤀 唀一䤀伀一 䄀䰀䰀ഀഀ
SELECT sid, mli, temperature, conductance, discharge, ph, turbidity, oxygen, stamp, elevation FROM dbo.TNUS193 UNION ALL਍匀䔀䰀䔀䌀吀 猀椀搀Ⰰ 洀氀椀Ⰰ 琀攀洀瀀攀爀愀琀甀爀攀Ⰰ 挀漀渀搀甀挀琀愀渀挀攀Ⰰ 搀椀猀挀栀愀爀最攀Ⰰ 瀀栀Ⰰ 琀甀爀戀椀搀椀琀礀Ⰰ 漀砀礀最攀渀Ⰰ 猀琀愀洀瀀Ⰰ 攀氀攀瘀愀琀椀漀渀 䘀刀伀䴀 搀戀漀⸀䐀䌀唀匀　㌀㄀ 唀一䤀伀一 䄀䰀䰀ഀഀ
SELECT sid, mli, temperature, conductance, discharge, ph, turbidity, oxygen, stamp, elevation FROM dbo.NCUS197 UNION ALL਍匀䔀䰀䔀䌀吀 猀椀搀Ⰰ 洀氀椀Ⰰ 琀攀洀瀀攀爀愀琀甀爀攀Ⰰ 挀漀渀搀甀挀琀愀渀挀攀Ⰰ 搀椀猀挀栀愀爀最攀Ⰰ 瀀栀Ⰰ 琀甀爀戀椀搀椀琀礀Ⰰ 漀砀礀最攀渀Ⰰ 猀琀愀洀瀀Ⰰ 攀氀攀瘀愀琀椀漀渀 䘀刀伀䴀 搀戀漀⸀䌀伀唀匀　㌀㜀 唀一䤀伀一 䄀䰀䰀ഀഀ
SELECT sid, mli, temperature, conductance, discharge, ph, turbidity, oxygen, stamp, elevation FROM dbo.NEUS199 UNION ALL਍匀䔀䰀䔀䌀吀 猀椀搀Ⰰ 洀氀椀Ⰰ 琀攀洀瀀攀爀愀琀甀爀攀Ⰰ 挀漀渀搀甀挀琀愀渀挀攀Ⰰ 搀椀猀挀栀愀爀最攀Ⰰ 瀀栀Ⰰ 琀甀爀戀椀搀椀琀礀Ⰰ 漀砀礀最攀渀Ⰰ 猀琀愀洀瀀Ⰰ 攀氀攀瘀愀琀椀漀渀 䘀刀伀䴀 搀戀漀⸀䴀䤀唀匀　㐀㄀ഀഀ
GO਍ⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀഀഀ
਍䤀䘀 䔀堀䤀匀吀匀 ⠀匀䔀䰀䔀䌀吀 ⨀ 䘀刀伀䴀 猀礀猀漀戀樀攀挀琀猀 圀䠀䔀刀䔀 一䄀䴀䔀 㴀 ✀瘀唀匀圀愀琀攀爀䐀愀琀愀匀栀漀爀琀✀ 䄀一䐀 琀礀瀀攀 㴀 ✀嘀✀⤀ഀഀ
	DROP VIEW dbo.vUSWaterDataShort਍䜀伀ഀഀ
CREATE VIEW vUSWaterDataShort ਍䄀匀ഀഀ
 SELECT  mli, cast(convert(varchar, stamp, 101) as datetime) as stamp FROM vUSWaterData਍䜀伀ഀഀ
----------------------------------------------------------------------------------------------------------------------------------਍䤀䘀 䔀堀䤀匀吀匀 ⠀匀䔀䰀䔀䌀吀 ⨀ 䘀刀伀䴀 猀礀猀漀戀樀攀挀琀猀 圀䠀䔀刀䔀 一䄀䴀䔀 㴀 ✀瘀䜀攀琀一攀砀琀圀攀氀氀✀ 䄀一䐀 琀礀瀀攀 㴀 ✀嘀✀⤀ഀഀ
	DROP VIEW dbo.vGetNextWell਍䜀伀ഀഀ
CREATE VIEW vGetNextWell AS਍猀攀氀攀挀琀 琀漀瀀 ㄀ 椀搀Ⰰ 䴀䰀䤀Ⰰ 瀀爀漀挀攀猀猀攀搀Ⰰ 䜀䔀吀唀吀䌀䐀䄀吀䔀⠀⤀ 愀猀 渀漀眀 昀爀漀洀 嬀圀愀琀攀爀匀琀愀琀椀漀渀崀 ഀഀ
  where agency = 'USGS' AND (processed is NULL ਍    伀刀 ⠀ 瀀爀漀挀攀猀猀攀搀 㰀 䜀䔀吀唀吀䌀䐀䄀吀䔀⠀⤀ 䄀一䐀 瀀爀漀挀攀猀猀攀搀 㸀 ✀㄀㤀　　　㄀　㄀✀⤀⤀ഀഀ
GO਍ⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀഀഀ
IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'fnGetNextUpdateWell' AND xtype = 'TF')਍ऀ䐀刀伀倀 䘀唀一䌀吀䤀伀一 搀戀漀⸀昀渀䜀攀琀一攀砀琀唀瀀搀愀琀攀圀攀氀氀ഀഀ
GO਍ഀഀ
CREATE FUNCTION dbo.fnGetNextUpdateWell( @months int, @days int )  -- -3, 30਍  刀䔀吀唀刀一匀 䀀吀䈀䰀 吀䄀䈀䰀䔀 ⠀ 猀琀愀洀瀀 搀愀琀攀琀椀洀攀Ⰰ 洀氀椀 瘀愀爀挀栀愀爀⠀㘀㐀⤀Ⰰ 猀琀愀琀攀 挀栀愀爀⠀㈀⤀ ⤀ഀഀ
AS਍戀攀最椀渀ഀഀ
  DECLARE @dt datetime਍  猀攀氀攀挀琀 䀀搀琀 㴀 䐀䄀吀䔀䄀䐀䐀⠀洀漀渀琀栀Ⰰ 䀀洀漀渀琀栀猀Ⰰ 䜀䔀吀䐀䄀吀䔀⠀⤀⤀ഀഀ
  INSERT INTO @TBL਍    猀攀氀攀挀琀  甀瀀搀䐀愀琀愀Ⰰ  洀氀椀Ⰰ  猀琀愀琀攀ഀഀ
      FROM WaterStation਍        圀䠀䔀刀䔀  甀瀀搀䐀愀琀愀 椀猀 渀漀琀 渀甀氀氀 䄀一䐀 甀瀀搀䐀愀琀愀 㰀 䜀䔀吀唀吀䌀䐀䄀吀䔀⠀⤀ഀഀ
   RETURN ਍䔀一䐀          ഀഀ
GO਍ഀഀ
SELECT  mli, stamp, ਍ഀഀ
----------------------------------------------------------------------------------------------------------------------------------਍䤀䘀 䔀堀䤀匀吀匀 ⠀匀䔀䰀䔀䌀吀 ⨀ 䘀刀伀䴀 猀礀猀漀戀樀攀挀琀猀 圀䠀䔀刀䔀 一䄀䴀䔀 㴀 ✀瘀唀倀䐀吀✀ 䄀一䐀 琀礀瀀攀 㴀 ✀嘀✀⤀ഀഀ
	DROP VIEW dbo.vUPDT਍䜀伀ഀഀ
਍挀爀攀愀琀攀 瘀椀攀眀 搀戀漀⸀瘀唀倀䐀吀 愀猀 ഀഀ
    select d.mli, MAX(w.[state]) as [state], max(d.stamp) as updData ਍      䘀刀伀䴀 搀戀漀⸀瘀唀匀圀愀琀攀爀䐀愀琀愀 搀Ⰰ 圀愀琀攀爀匀琀愀琀椀漀渀 眀 ഀഀ
        WHERE w.processed = '19000101' AND d.stamp > '20130501'਍          䄀一䐀 搀⸀洀氀椀㴀眀⸀洀氀椀   䄀一䐀 眀⸀挀漀甀渀琀爀礀 㴀 ✀唀匀✀ 䄀一䐀 猀琀愀琀攀㴀✀一夀✀ഀഀ
           AND DATEDIFF(DAY, d.stamp, getdate()) > 7 ਍        䜀刀伀唀倀 䈀夀 搀⸀䴀䰀䤀 ഀഀ
਍           ഀഀ
-- select top 100 * from vUPDT   order by stamp updData        ਍ ഀഀ
update W set w.updData =  d.stamp  FROM vUPDT d, WaterStation w  ਍  圀䠀䔀刀䔀 眀⸀瀀爀漀挀攀猀猀攀搀 㴀 ✀㄀㤀　　　㄀　㄀✀  䄀一䐀 搀⸀洀氀椀㴀眀⸀洀氀椀 ഀഀ
  ਍ⴀⴀ 猀攀氀攀挀琀 ⨀ 昀爀漀洀 圀愀琀攀爀匀琀愀琀椀漀渀 眀栀攀爀攀 洀氀椀 㴀  ✀　㘀㌀㐀㠀㔀　　✀ഀഀ
-- select * from  dbo.CurrentWaterState  where mli = '06452320' order by stamp desc਍ⴀⴀ  匀䔀䰀䔀䌀吀 䴀䰀䤀Ⰰ 猀琀愀琀攀Ⰰ 猀琀愀洀瀀 䘀刀伀䴀 搀戀漀⸀昀渀䜀攀琀一攀砀琀唀瀀搀愀琀攀圀攀氀氀⠀ ⴀ㌀Ⰰ ㌀　 ⤀ഀഀ
਍⼀⨀ഀഀ
exec sp_MSforeachtable 'ALTER TABLE ? ADD precipitation float'਍攀砀攀挀 猀瀀开䴀匀昀漀爀攀愀挀栀琀愀戀氀攀 ✀䄀䰀吀䔀刀 吀䄀䈀䰀䔀 㼀 䄀䐀䐀 瘀攀氀漀挀椀琀礀 昀氀漀愀琀✀ഀഀ
exec sp_MSforeachtable 'ALTER TABLE ? ADD air float'਍攀砀攀挀 猀瀀开䴀匀昀漀爀攀愀挀栀琀愀戀氀攀 ✀䄀䰀吀䔀刀 吀䄀䈀䰀䔀 㼀 䄀䐀䐀 挀氀漀甀搀挀漀瘀攀爀 昀氀漀愀琀✀ഀഀ
exec sp_MSforeachtable 'ALTER TABLE ? ADD pressure float'਍攀砀攀挀 猀瀀开䴀匀昀漀爀攀愀挀栀琀愀戀氀攀 ✀䄀䰀吀䔀刀 吀䄀䈀䰀䔀 㼀 䄀䐀䐀 眀椀渀搀 昀氀漀愀琀✀ഀഀ
exec sp_MSforeachtable 'ALTER TABLE ? ADD winddir float'਍攀砀攀挀 猀瀀开䴀匀昀漀爀攀愀挀栀琀愀戀氀攀 ✀䄀䰀吀䔀刀 吀䄀䈀䰀䔀 㼀 䄀䐀䐀 栀甀洀椀搀椀琀礀 昀氀漀愀琀✀ഀഀ
exec sp_MSforeachtable 'ALTER TABLE ? ADD elevation float'਍ഀഀ
*/਍ⴀⴀ攀砀攀挀 猀瀀开䴀匀昀漀爀攀愀挀栀琀愀戀氀攀 ✀䐀䔀䰀䔀吀䔀 䘀刀伀䴀 㼀 圀䠀䔀刀䔀 猀琀愀洀瀀 㰀 ∀㈀　㄀㐀⼀　㘀⼀　㄀∀✀ഀഀ
--delete from  WaterStation  where not exists( select * from vUSWaterData where vUSWaterData.mli=WaterStation.mli)਍ⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀഀഀ
IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'vUpdateWaterData' AND type = 'V')਍ऀ䐀刀伀倀 嘀䤀䔀圀 搀戀漀⸀瘀唀瀀搀愀琀攀圀愀琀攀爀䐀愀琀愀ഀഀ
GO਍ഀഀ
create view dbo.vUpdateWaterData as ਍  匀䔀䰀䔀䌀吀 吀伀倀 ㄀　　 䴀䰀䤀Ⰰ 猀琀愀琀攀Ⰰ 甀瀀搀䐀愀琀愀 䘀刀伀䴀 圀愀琀攀爀匀琀愀琀椀漀渀 ഀഀ
    WHERE updData is not null AND DATEDIFF(DAY, updData, getdate()) > 7 AND state IN ('NY', 'PA', 'OH')਍䜀伀ഀഀ
਍ⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀഀഀ
਍䤀䘀 䔀堀䤀匀吀匀 ⠀匀䔀䰀䔀䌀吀 ⨀ 䘀刀伀䴀 猀礀猀漀戀樀攀挀琀猀 圀䠀䔀刀䔀 一䄀䴀䔀 㴀 ✀瘀䜀攀琀伀渀琀愀爀椀漀䰀椀猀琀✀ 䄀一䐀 琀礀瀀攀 㴀 ✀嘀✀⤀ഀഀ
	DROP VIEW dbo.vGetOntarioList਍䜀伀ഀഀ
CREATE VIEW dbo.vGetOntarioList਍䄀匀  ഀഀ
  SELECT  * FROM dbo.WaterStation WITH (NOLOCK) WHERE country = 'CA' AND state = 'ON'਍䜀伀ഀഀ
----------------------------------------------------------------------------------------------------------------------------------਍ 匀䔀䰀䔀䌀吀   䴀䰀䤀Ⰰ 猀琀愀琀攀Ⰰ 甀瀀搀䐀愀琀愀 䘀刀伀䴀 搀戀漀⸀瘀唀瀀搀愀琀攀圀愀琀攀爀䐀愀琀愀  伀刀䐀䔀刀 䈀夀 甀瀀搀䐀愀琀愀 䐀䔀匀䌀ഀഀ
 ਍ 匀䔀䰀䔀䌀吀 䌀伀唀一吀⠀⨀⤀ 䘀刀伀䴀 瘀䜀攀琀伀渀琀愀爀椀漀䰀椀猀琀ഀഀ
 SELECT mli FROM vGetOntarioList ORDER BY mli ASC