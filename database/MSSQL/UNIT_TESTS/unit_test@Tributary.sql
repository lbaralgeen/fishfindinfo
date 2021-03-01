SET QUOTED_IDENTIFIER ON਍䜀伀ഀഀ
PRINT 'Unit tests for ffi' ਍倀刀䤀一吀 ✀ⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀ✀ ഀഀ
਍ⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀഀഀ
BEGIN TRAN TestT1਍    搀攀挀氀愀爀攀 䀀琀攀猀琀开渀愀洀攀 猀礀猀渀愀洀攀 㴀 ✀吀攀猀琀吀㄀ 嬀吀刀开䰀愀欀攀开䤀一匀崀 椀渀猀攀爀琀 爀椀瘀攀爀✀ഀഀ
BEGIN TRY  SET NOCOUNT ON;਍ഀഀ
-- 1. prepare data for unit test਍ഀഀ
insert into lake (lake_id, locType, lake_name, CGNDB) values ('00000000-0000-0000-0000-000000000000', 2, N'River', 'ABCDE')਍ഀഀ
-- 2. execute unit test     -- select * from dbo.quota_usage_byuser(null , null ,null,null ,  '19000101' , '20340101'  )਍搀攀挀氀愀爀攀 䀀爀攀猀甀氀琀㄀ 椀渀琀 㴀 ⠀ 猀攀氀攀挀琀 挀漀甀渀琀⠀⨀⤀ 昀爀漀洀 氀愀欀攀 眀栀攀爀攀 氀愀欀攀开椀搀 㴀 ✀　　　　　　　　ⴀ　　　　ⴀ　　　　ⴀ　　　　ⴀ　　　　　　　　　　　　✀⤀ഀഀ
declare @result2 int = ( select count(*) from Tributaries where main_lake_id = '00000000-0000-0000-0000-000000000000')਍ഀഀ
END TRY਍䈀䔀䜀䤀一 䌀䄀吀䌀䠀ഀഀ
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState਍         Ⰰ 䀀琀攀猀琀开渀愀洀攀     䄀匀 䔀爀爀漀爀倀爀漀挀攀搀甀爀攀Ⰰ 䔀刀刀伀刀开䰀䤀一䔀⠀⤀     䄀匀 䔀爀爀漀爀䰀椀渀攀Ⰰ     䔀刀刀伀刀开䴀䔀匀匀䄀䜀䔀⠀⤀ 䄀匀 䔀爀爀漀爀䴀攀猀猀愀最攀ഀഀ
END CATCH਍ഀഀ
-- 3. result verification਍ഀഀ
IF  @result1 <> 1 OR @result2 <> 2 ਍   刀䄀䤀匀䔀刀刀伀刀 ⠀✀䘀䄀䤀䰀䔀䐀㨀 ─猀 猀椀渀最氀攀 氀愀欀攀 栀愀猀 ㈀ 吀爀椀戀甀琀愀爀椀攀猀 ─搀 ⴀ ─搀✀Ⰰ ㄀㘀Ⰰ ⴀ㄀Ⰰ 䀀琀攀猀琀开渀愀洀攀Ⰰ 䀀爀攀猀甀氀琀㄀Ⰰ 䀀爀攀猀甀氀琀㈀ ⤀ ഀഀ
ELSE਍    瀀爀椀渀琀 ✀倀䄀匀匀䔀䐀 ✀ ⬀ 䀀琀攀猀琀开渀愀洀攀ഀഀ
਍刀伀䰀䰀䈀䄀䌀䬀 吀刀䄀一 吀攀猀琀吀㄀ഀഀ
GO਍ⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀഀഀ
BEGIN TRAN TestT1s਍    搀攀挀氀愀爀攀 䀀琀攀猀琀开渀愀洀攀 猀礀猀渀愀洀攀 㴀 ✀吀攀猀琀吀㄀猀 嬀吀刀开䰀愀欀攀开䤀一匀崀 椀渀猀攀爀琀 爀椀瘀攀爀 眀椀琀栀 猀漀甀爀挀攀✀ഀഀ
BEGIN TRY  SET NOCOUNT ON;਍ഀഀ
-- 1. prepare data for unit test਍ഀഀ
insert into lake (lake_id, locType, lake_name, CGNDB) values ('11111111-1111-1111-1111-111111111111', 2, N'Source', 'QWERT')਍椀渀猀攀爀琀 椀渀琀漀 氀愀欀攀 ⠀氀愀欀攀开椀搀Ⰰ 氀漀挀吀礀瀀攀Ⰰ 氀愀欀攀开渀愀洀攀Ⰰ 䌀䜀一䐀䈀⤀ 瘀愀氀甀攀猀 ⠀✀　　　　　　　　ⴀ　　　　ⴀ　　　　ⴀ　　　　ⴀ　　　　　　　　　　　　✀Ⰰ ㈀Ⰰ 一✀刀椀瘀攀爀✀Ⰰ ✀䄀䈀䌀䐀䔀✀⤀ഀഀ
਍ⴀⴀ ㈀⸀ 攀砀攀挀甀琀攀 甀渀椀琀 琀攀猀琀     ⴀⴀ 猀攀氀攀挀琀 ⨀ 昀爀漀洀 搀戀漀⸀焀甀漀琀愀开甀猀愀最攀开戀礀甀猀攀爀⠀渀甀氀氀 Ⰰ 渀甀氀氀 Ⰰ渀甀氀氀Ⰰ渀甀氀氀 Ⰰ  ✀㄀㤀　　　㄀　㄀✀ Ⰰ ✀㈀　㌀㐀　㄀　㄀✀  ⤀ഀഀ
਍唀倀䐀䄀吀䔀 吀爀椀戀甀琀愀爀椀攀猀 匀䔀吀 䰀愀欀攀开椀搀㴀✀㄀㄀㄀㄀㄀㄀㄀㄀ⴀ㄀㄀㄀㄀ⴀ㄀㄀㄀㄀ⴀ㄀㄀㄀㄀ⴀ㄀㄀㄀㄀㄀㄀㄀㄀㄀㄀㄀㄀✀ 眀栀攀爀攀 䴀愀椀渀开䰀愀欀攀开椀搀 㴀 ✀　　　　　　　　ⴀ　　　　ⴀ　　　　ⴀ　　　　ⴀ　　　　　　　　　　　　✀ 愀渀搀 猀椀搀攀 㴀 ㄀㘀ഀഀ
਍䔀一䐀 吀刀夀ഀഀ
BEGIN CATCH਍    匀䔀䰀䔀䌀吀 䔀刀刀伀刀开一唀䴀䈀䔀刀⠀⤀ 䄀匀 䔀爀爀漀爀一甀洀戀攀爀Ⰰ    䔀刀刀伀刀开匀䔀嘀䔀刀䤀吀夀⠀⤀ 䄀匀 䔀爀爀漀爀匀攀瘀攀爀椀琀礀Ⰰ 䔀刀刀伀刀开匀吀䄀吀䔀⠀⤀   䄀匀 䔀爀爀漀爀匀琀愀琀攀ഀഀ
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage਍䔀一䐀 䌀䄀吀䌀䠀ഀഀ
਍ⴀⴀ ㌀⸀ 爀攀猀甀氀琀 瘀攀爀椀昀椀挀愀琀椀漀渀ഀഀ
declare @result1 int = ( select count(*) from lake where lake_id = '00000000-0000-0000-0000-000000000000')਍搀攀挀氀愀爀攀 䀀爀攀猀甀氀琀㈀ 椀渀琀 㴀 ⠀ 猀攀氀攀挀琀 挀漀甀渀琀⠀⨀⤀ 昀爀漀洀 吀爀椀戀甀琀愀爀椀攀猀 眀栀攀爀攀 洀愀椀渀开氀愀欀攀开椀搀 㴀 ✀　　　　　　　　ⴀ　　　　ⴀ　　　　ⴀ　　　　ⴀ　　　　　　　　　　　　✀⤀ഀഀ
declare @LoadTributary int = ( select count(*) from fn_ViewTributary('00000000-0000-0000-0000-000000000000') WHERE way = 'Inflow' )਍ഀഀ
IF  @result1 <> 1 OR @result2 <> 2  OR @LoadTributary <> 1਍   刀䄀䤀匀䔀刀刀伀刀 ⠀✀䘀䄀䤀䰀䔀䐀㨀 ─猀 猀椀渀最氀攀 氀愀欀攀 栀愀猀 ㈀ 吀爀椀戀甀琀愀爀椀攀猀 ─搀 ⴀ ─搀✀Ⰰ ㄀㘀Ⰰ ⴀ㄀Ⰰ 䀀琀攀猀琀开渀愀洀攀Ⰰ 䀀爀攀猀甀氀琀㄀Ⰰ 䀀爀攀猀甀氀琀㈀ ⤀ ഀഀ
ELSE਍    瀀爀椀渀琀 ✀倀䄀匀匀䔀䐀 ✀ ⬀ 䀀琀攀猀琀开渀愀洀攀ഀഀ
਍刀伀䰀䰀䈀䄀䌀䬀 吀刀䄀一 吀攀猀琀吀㄀猀ഀഀ
GO਍ⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀഀഀ
BEGIN TRAN TestT1m਍    搀攀挀氀愀爀攀 䀀琀攀猀琀开渀愀洀攀 猀礀猀渀愀洀攀 㴀 ✀吀攀猀琀吀㄀洀 嬀吀刀开䰀愀欀攀开䤀一匀崀 椀渀猀攀爀琀 爀椀瘀攀爀 眀椀琀栀 洀漀甀琀栀✀ഀഀ
BEGIN TRY  SET NOCOUNT ON;਍ഀഀ
-- 1. prepare data for unit test਍ഀഀ
insert into lake (lake_id, locType, lake_name, CGNDB) values ('11111111-1111-1111-1111-111111111111',  2, N'mouth', 'QWERT')਍椀渀猀攀爀琀 椀渀琀漀 氀愀欀攀 ⠀氀愀欀攀开椀搀Ⰰ 氀漀挀吀礀瀀攀Ⰰ 氀愀欀攀开渀愀洀攀Ⰰ 䌀䜀一䐀䈀⤀ 瘀愀氀甀攀猀 ⠀✀　　　　　　　　ⴀ　　　　ⴀ　　　　ⴀ　　　　ⴀ　　　　　　　　　　　　✀Ⰰ ㈀Ⰰ 一✀刀椀瘀攀爀✀Ⰰ ✀䄀䈀䌀䐀䔀✀⤀ഀഀ
਍ⴀⴀ ㈀⸀ 攀砀攀挀甀琀攀 甀渀椀琀 琀攀猀琀     ⴀⴀ 猀攀氀攀挀琀 ⨀ 昀爀漀洀 搀戀漀⸀焀甀漀琀愀开甀猀愀最攀开戀礀甀猀攀爀⠀渀甀氀氀 Ⰰ 渀甀氀氀 Ⰰ渀甀氀氀Ⰰ渀甀氀氀 Ⰰ  ✀㄀㤀　　　㄀　㄀✀ Ⰰ ✀㈀　㌀㐀　㄀　㄀✀  ⤀ഀഀ
਍唀倀䐀䄀吀䔀 吀爀椀戀甀琀愀爀椀攀猀 匀䔀吀 䰀愀欀攀开椀搀㴀✀㄀㄀㄀㄀㄀㄀㄀㄀ⴀ㄀㄀㄀㄀ⴀ㄀㄀㄀㄀ⴀ㄀㄀㄀㄀ⴀ㄀㄀㄀㄀㄀㄀㄀㄀㄀㄀㄀㄀✀ 眀栀攀爀攀 䴀愀椀渀开䰀愀欀攀开椀搀 㴀 ✀　　　　　　　　ⴀ　　　　ⴀ　　　　ⴀ　　　　ⴀ　　　　　　　　　　　　✀ 愀渀搀 猀椀搀攀 㴀 ㌀㈀ഀഀ
਍䔀一䐀 吀刀夀ഀഀ
BEGIN CATCH਍    匀䔀䰀䔀䌀吀 䔀刀刀伀刀开一唀䴀䈀䔀刀⠀⤀ 䄀匀 䔀爀爀漀爀一甀洀戀攀爀Ⰰ    䔀刀刀伀刀开匀䔀嘀䔀刀䤀吀夀⠀⤀ 䄀匀 䔀爀爀漀爀匀攀瘀攀爀椀琀礀Ⰰ 䔀刀刀伀刀开匀吀䄀吀䔀⠀⤀   䄀匀 䔀爀爀漀爀匀琀愀琀攀ഀഀ
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage਍䔀一䐀 䌀䄀吀䌀䠀ഀഀ
਍ⴀⴀ ㌀⸀ 爀攀猀甀氀琀 瘀攀爀椀昀椀挀愀琀椀漀渀ഀഀ
declare @result1 int = ( select count(*) from lake where lake_id = '00000000-0000-0000-0000-000000000000')਍搀攀挀氀愀爀攀 䀀爀攀猀甀氀琀㈀ 椀渀琀 㴀 ⠀ 猀攀氀攀挀琀 挀漀甀渀琀⠀⨀⤀ 昀爀漀洀 吀爀椀戀甀琀愀爀椀攀猀 眀栀攀爀攀 洀愀椀渀开氀愀欀攀开椀搀 㴀 ✀　　　　　　　　ⴀ　　　　ⴀ　　　　ⴀ　　　　ⴀ　　　　　　　　　　　　✀⤀ഀഀ
declare @LoadTributary int = ( select count(*) from fn_ViewTributary('00000000-0000-0000-0000-000000000000') WHERE way = 'Outflow' )਍ഀഀ
IF  @result1 <> 1 OR @result2 <> 2  OR @LoadTributary <> 1਍   刀䄀䤀匀䔀刀刀伀刀 ⠀✀䘀䄀䤀䰀䔀䐀㨀 ─猀 猀椀渀最氀攀 氀愀欀攀 栀愀猀 ㈀ 吀爀椀戀甀琀愀爀椀攀猀 ─搀 ⴀ ─搀✀Ⰰ ㄀㘀Ⰰ ⴀ㄀Ⰰ 䀀琀攀猀琀开渀愀洀攀Ⰰ 䀀爀攀猀甀氀琀㄀Ⰰ 䀀爀攀猀甀氀琀㈀ ⤀ ഀഀ
ELSE਍    瀀爀椀渀琀 ✀倀䄀匀匀䔀䐀 ✀ ⬀ 䀀琀攀猀琀开渀愀洀攀ഀഀ
਍刀伀䰀䰀䈀䄀䌀䬀 吀刀䄀一 吀攀猀琀吀㄀洀ഀഀ
GO਍ⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀഀഀ
BEGIN TRAN TestT1ms਍    搀攀挀氀愀爀攀 䀀琀攀猀琀开渀愀洀攀 猀礀猀渀愀洀攀 㴀 ✀吀攀猀琀吀㄀洀猀 嬀䘀一开䰀漀愀搀吀爀椀戀甀琀愀爀礀崀 椀渀猀攀爀琀 爀椀瘀攀爀 眀椀琀栀 洀漀甀琀栀 愀渀搀 猀漀甀爀挀攀✀ഀഀ
BEGIN TRY  SET NOCOUNT ON;਍ഀഀ
-- 1. prepare data for unit test਍ഀഀ
insert into lake (lake_id, locType, lake_name, CGNDB) values ('11111111-1111-1111-1111-111111111111', 1, N'Source', 'QWERT')਍椀渀猀攀爀琀 椀渀琀漀 氀愀欀攀 ⠀氀愀欀攀开椀搀Ⰰ 氀漀挀吀礀瀀攀Ⰰ 氀愀欀攀开渀愀洀攀Ⰰ 䌀䜀一䐀䈀⤀ 瘀愀氀甀攀猀 ⠀✀㈀㈀㈀㈀㈀㈀㈀㈀ⴀ㈀㈀㈀㈀ⴀ㈀㈀㈀㈀ⴀ㈀㈀㈀㈀ⴀ㈀㈀㈀㈀㈀㈀㈀㈀㈀㈀㈀㈀✀Ⰰ ㈀Ⰰ 一✀䴀漀甀琀栀✀Ⰰ ✀䄀匀䐀䘀䜀✀⤀ഀഀ
insert into lake (lake_id, locType, lake_name, CGNDB) values ('00000000-0000-0000-0000-000000000000', 2, N'River', 'ABCDE')਍ഀഀ
-- 2. execute unit test     -- select * from dbo.quota_usage_byuser(null , null ,null,null ,  '19000101' , '20340101'  )਍ഀഀ
UPDATE Tributaries SET Lake_id='11111111-1111-1111-1111-111111111111' where Main_Lake_id = '00000000-0000-0000-0000-000000000000' and side = 32਍唀倀䐀䄀吀䔀 吀爀椀戀甀琀愀爀椀攀猀 匀䔀吀 䰀愀欀攀开椀搀㴀✀㈀㈀㈀㈀㈀㈀㈀㈀ⴀ㈀㈀㈀㈀ⴀ㈀㈀㈀㈀ⴀ㈀㈀㈀㈀ⴀ㈀㈀㈀㈀㈀㈀㈀㈀㈀㈀㈀㈀✀ 眀栀攀爀攀 䴀愀椀渀开䰀愀欀攀开椀搀 㴀 ✀　　　　　　　　ⴀ　　　　ⴀ　　　　ⴀ　　　　ⴀ　　　　　　　　　　　　✀ 愀渀搀 猀椀搀攀 㴀 ㄀㘀ഀഀ
਍䔀一䐀 吀刀夀ഀഀ
BEGIN CATCH਍    匀䔀䰀䔀䌀吀 䔀刀刀伀刀开一唀䴀䈀䔀刀⠀⤀ 䄀匀 䔀爀爀漀爀一甀洀戀攀爀Ⰰ    䔀刀刀伀刀开匀䔀嘀䔀刀䤀吀夀⠀⤀ 䄀匀 䔀爀爀漀爀匀攀瘀攀爀椀琀礀Ⰰ 䔀刀刀伀刀开匀吀䄀吀䔀⠀⤀   䄀匀 䔀爀爀漀爀匀琀愀琀攀ഀഀ
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage਍䔀一䐀 䌀䄀吀䌀䠀ഀഀ
਍ⴀⴀ ㌀⸀ 爀攀猀甀氀琀 瘀攀爀椀昀椀挀愀琀椀漀渀ഀഀ
declare @result1 int = ( select count(*) from lake where lake_id = '00000000-0000-0000-0000-000000000000')਍搀攀挀氀愀爀攀 䀀爀攀猀甀氀琀㈀ 椀渀琀 㴀 ⠀ 猀攀氀攀挀琀 挀漀甀渀琀⠀⨀⤀ 昀爀漀洀 吀爀椀戀甀琀愀爀椀攀猀 眀栀攀爀攀 洀愀椀渀开氀愀欀攀开椀搀 㴀 ✀　　　　　　　　ⴀ　　　　ⴀ　　　　ⴀ　　　　ⴀ　　　　　　　　　　　　✀⤀ഀഀ
declare @LoadTributary int = ( select count(*) from fn_ViewTributary('00000000-0000-0000-0000-000000000000') WHERE way IN ('Outflow', 'Inflow') )਍ഀഀ
IF  @result1 <> 1 OR @result2 <> 2  OR @LoadTributary <> 2਍   刀䄀䤀匀䔀刀刀伀刀 ⠀✀䘀䄀䤀䰀䔀䐀㨀 ─猀 猀椀渀最氀攀 氀愀欀攀 栀愀猀 ㈀ 吀爀椀戀甀琀愀爀椀攀猀 ─搀 ⴀ ─搀✀Ⰰ ㄀㘀Ⰰ ⴀ㄀Ⰰ 䀀琀攀猀琀开渀愀洀攀Ⰰ 䀀爀攀猀甀氀琀㄀Ⰰ 䀀爀攀猀甀氀琀㈀ ⤀ ഀഀ
ELSE਍    瀀爀椀渀琀 ✀倀䄀匀匀䔀䐀 ✀ ⬀ 䀀琀攀猀琀开渀愀洀攀ഀഀ
਍刀伀䰀䰀䈀䄀䌀䬀 吀刀䄀一 吀攀猀琀吀㄀洀猀ഀഀ
GO਍ⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀഀഀ
BEGIN TRAN TestT1tr਍    搀攀挀氀愀爀攀 䀀琀攀猀琀开渀愀洀攀 猀礀猀渀愀洀攀 㴀 ✀吀攀猀琀吀㄀琀爀 嬀䰀漀愀搀吀爀椀戀甀琀愀爀礀崀 瘀椀攀眀 吀爀椀戀甀琀愀爀礀 漀昀 爀椀瘀攀爀✀ഀഀ
BEGIN TRY  SET NOCOUNT ON;਍ഀഀ
-- 1. prepare data for unit test਍ഀഀ
insert into lake (lake_id, locType, lake_name, CGNDB) values ('11111111-1111-1111-1111-111111111111', 2, N'Mouth',  'MOUTH')਍椀渀猀攀爀琀 椀渀琀漀 氀愀欀攀 ⠀氀愀欀攀开椀搀Ⰰ 氀漀挀吀礀瀀攀Ⰰ 氀愀欀攀开渀愀洀攀Ⰰ 䌀䜀一䐀䈀⤀ 瘀愀氀甀攀猀 ⠀✀　　　　　　　　ⴀ　　　　ⴀ　　　　ⴀ　　　　ⴀ　　　　　　　　　　　　✀Ⰰ ㈀Ⰰ 一✀刀椀瘀攀爀✀Ⰰ  ✀刀䤀嘀䔀刀✀⤀ഀഀ
UPDATE Tributaries SET Lake_id='11111111-1111-1111-1111-111111111111' where Main_Lake_id = '00000000-0000-0000-0000-000000000000' and side = 32਍ഀഀ
-- 2. execute unit test     -- select * from dbo.quota_usage_byuser(null , null ,null,null ,  '19000101' , '20340101'  )਍ഀഀ
END TRY਍䈀䔀䜀䤀一 䌀䄀吀䌀䠀ഀഀ
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState਍         Ⰰ 䀀琀攀猀琀开渀愀洀攀     䄀匀 䔀爀爀漀爀倀爀漀挀攀搀甀爀攀Ⰰ 䔀刀刀伀刀开䰀䤀一䔀⠀⤀     䄀匀 䔀爀爀漀爀䰀椀渀攀Ⰰ     䔀刀刀伀刀开䴀䔀匀匀䄀䜀䔀⠀⤀ 䄀匀 䔀爀爀漀爀䴀攀猀猀愀最攀ഀഀ
END CATCH਍ഀഀ
-- 3. result verification਍搀攀挀氀愀爀攀 䀀爀攀猀甀氀琀㄀ 椀渀琀 㴀 ⠀ 猀攀氀攀挀琀 挀漀甀渀琀⠀⨀⤀ 昀爀漀洀 氀愀欀攀 眀栀攀爀攀 氀愀欀攀开椀搀 㴀 ✀㄀㄀㄀㄀㄀㄀㄀㄀ⴀ㄀㄀㄀㄀ⴀ㄀㄀㄀㄀ⴀ㄀㄀㄀㄀ⴀ㄀㄀㄀㄀㄀㄀㄀㄀㄀㄀㄀㄀✀⤀ഀഀ
declare @result2 int = ( select count(*) from Tributaries where main_lake_id = '11111111-1111-1111-1111-111111111111')਍搀攀挀氀愀爀攀 䀀䰀漀愀搀吀爀椀戀甀琀愀爀礀 椀渀琀 㴀 ⠀ 猀攀氀攀挀琀 挀漀甀渀琀⠀⨀⤀ 昀爀漀洀 昀渀开嘀椀攀眀吀爀椀戀甀琀愀爀礀⠀✀㄀㄀㄀㄀㄀㄀㄀㄀ⴀ㄀㄀㄀㄀ⴀ㄀㄀㄀㄀ⴀ㄀㄀㄀㄀ⴀ㄀㄀㄀㄀㄀㄀㄀㄀㄀㄀㄀㄀✀⤀ 圀䠀䔀刀䔀 眀愀礀 䤀一 ⠀✀伀甀琀昀氀漀眀✀Ⰰ ✀䤀渀昀氀漀眀✀⤀ ⤀ഀഀ
਍䤀䘀  䀀爀攀猀甀氀琀㄀ 㰀㸀 ㄀ 伀刀 䀀爀攀猀甀氀琀㈀ 㰀㸀 ㈀  伀刀 䀀䰀漀愀搀吀爀椀戀甀琀愀爀礀 㰀㸀 ㄀ഀഀ
   RAISERROR ('FAILED: %s single lake has 2 Tributaries %d - %d', 16, -1, @test_name, @result1, @result2 ) ਍䔀䰀匀䔀ഀഀ
    print 'PASSED ' + @test_name਍ഀഀ
ROLLBACK TRAN TestT1tr਍䜀伀ഀഀ
----------------------------------------------------------------------------------------------------------਍䈀䔀䜀䤀一 吀刀䄀一 吀攀猀琀吀㈀ഀഀ
    declare @test_name sysname = 'TestT2 [TR_Lake_INS] insert lake'਍䈀䔀䜀䤀一 吀刀夀  匀䔀吀 一伀䌀伀唀一吀 伀一㬀ഀഀ
਍ⴀⴀ ㄀⸀ 瀀爀攀瀀愀爀攀 搀愀琀愀 昀漀爀 甀渀椀琀 琀攀猀琀ഀഀ
਍椀渀猀攀爀琀 椀渀琀漀 氀愀欀攀 ⠀氀愀欀攀开椀搀Ⰰ 氀漀挀吀礀瀀攀Ⰰ 氀愀欀攀开渀愀洀攀Ⰰ 䌀䜀一䐀䈀⤀ 瘀愀氀甀攀猀 ⠀✀　　　　　　　　ⴀ　　　　ⴀ　　　　ⴀ　　　　ⴀ　　　　　　　　　　　　✀Ⰰ ㄀Ⰰ 一✀䰀愀欀攀✀Ⰰ ✀䄀䈀䌀䐀䔀✀⤀ഀഀ
਍ⴀⴀ ㈀⸀ 攀砀攀挀甀琀攀 甀渀椀琀 琀攀猀琀     ⴀⴀ 猀攀氀攀挀琀 ⨀ 昀爀漀洀 搀戀漀⸀焀甀漀琀愀开甀猀愀最攀开戀礀甀猀攀爀⠀渀甀氀氀 Ⰰ 渀甀氀氀 Ⰰ渀甀氀氀Ⰰ渀甀氀氀 Ⰰ  ✀㄀㤀　　　㄀　㄀✀ Ⰰ ✀㈀　㌀㐀　㄀　㄀✀  ⤀ഀഀ
declare @result1 int = ( select count(*) from lake where lake_id = '00000000-0000-0000-0000-000000000000')਍搀攀挀氀愀爀攀 䀀爀攀猀甀氀琀㈀ 椀渀琀 㴀 ⠀ 猀攀氀攀挀琀 挀漀甀渀琀⠀⨀⤀ 昀爀漀洀 吀爀椀戀甀琀愀爀椀攀猀 眀栀攀爀攀 洀愀椀渀开氀愀欀攀开椀搀 㴀 ✀　　　　　　　　ⴀ　　　　ⴀ　　　　ⴀ　　　　ⴀ　　　　　　　　　　　　✀ 愀渀搀 氀愀欀攀开椀搀 㴀 ✀　　　　　　　　ⴀ　　　　ⴀ　　　　ⴀ　　　　ⴀ　　　　　　　　　　　　✀⤀ഀഀ
declare @LoadTributary int = ( select count(*) from fn_ViewTributary('00000000-0000-0000-0000-000000000000') )਍搀攀挀氀愀爀攀 䀀䔀搀椀琀吀爀椀戀甀琀愀爀礀 椀渀琀 㴀 ⠀ 猀攀氀攀挀琀 挀漀甀渀琀⠀⨀⤀ 昀爀漀洀 昀渀开䔀搀椀琀吀爀椀戀甀琀愀爀礀⠀✀　　　　　　　　ⴀ　　　　ⴀ　　　　ⴀ　　　　ⴀ　　　　　　　　　　　　✀⤀ ⤀ഀഀ
declare @SubTributary int = ( select count(*) from fn_SubTributary('00000000-0000-0000-0000-000000000000') )਍ഀഀ
END TRY਍䈀䔀䜀䤀一 䌀䄀吀䌀䠀ഀഀ
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState਍         Ⰰ 䀀琀攀猀琀开渀愀洀攀     䄀匀 䔀爀爀漀爀倀爀漀挀攀搀甀爀攀Ⰰ 䔀刀刀伀刀开䰀䤀一䔀⠀⤀     䄀匀 䔀爀爀漀爀䰀椀渀攀Ⰰ     䔀刀刀伀刀开䴀䔀匀匀䄀䜀䔀⠀⤀ 䄀匀 䔀爀爀漀爀䴀攀猀猀愀最攀ഀഀ
END CATCH਍ഀഀ
-- 3. result verification਍ഀഀ
IF  @result1 <> 1 OR @result2 <> 2 OR @LoadTributary <> 0  OR @EditTributary <> 0  OR @SubTributary <> 2 ਍   刀䄀䤀匀䔀刀刀伀刀 ⠀✀䘀䄀䤀䰀䔀䐀㨀 ─猀 猀椀渀最氀攀 氀愀欀攀 栀愀猀 ㈀ 吀爀椀戀甀琀愀爀椀攀猀 ─搀 ⴀ ─搀✀Ⰰ ㄀㘀Ⰰ ⴀ㄀Ⰰ 䀀琀攀猀琀开渀愀洀攀Ⰰ 䀀爀攀猀甀氀琀㄀Ⰰ 䀀爀攀猀甀氀琀㈀ ⤀ ഀഀ
ELSE਍    瀀爀椀渀琀 ✀倀䄀匀匀䔀䐀 ✀ ⬀ 䀀琀攀猀琀开渀愀洀攀ഀഀ
਍刀伀䰀䰀䈀䄀䌀䬀 吀刀䄀一 吀攀猀琀吀㈀ഀഀ
GO਍ⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀഀഀ
BEGIN TRAN TestT2tl਍    搀攀挀氀愀爀攀 䀀琀攀猀琀开渀愀洀攀 猀礀猀渀愀洀攀 㴀 ✀吀攀猀琀吀㈀琀氀 嬀䰀漀愀搀吀爀椀戀甀琀愀爀礀崀 瘀椀攀眀 吀爀椀戀甀琀愀爀礀 漀昀 䰀愀欀攀✀ഀഀ
BEGIN TRY  SET NOCOUNT ON;਍ഀഀ
-- 1. prepare data for unit test਍ഀഀ
insert into lake (lake_id, locType, lake_name, CGNDB) values ('11111111-1111-1111-1111-111111111111', 2, N'River',  'River')਍椀渀猀攀爀琀 椀渀琀漀 氀愀欀攀 ⠀氀愀欀攀开椀搀Ⰰ 氀漀挀吀礀瀀攀Ⰰ 氀愀欀攀开渀愀洀攀Ⰰ 䌀䜀一䐀䈀⤀ 瘀愀氀甀攀猀 ⠀✀　　　　　　　　ⴀ　　　　ⴀ　　　　ⴀ　　　　ⴀ　　　　　　　　　　　　✀Ⰰ ㄀Ⰰ 一✀䰀愀欀攀✀Ⰰ   ✀䰀愀欀攀猀✀⤀ഀഀ
਍ⴀⴀ ㈀⸀ 攀砀攀挀甀琀攀 甀渀椀琀 琀攀猀琀     ⴀⴀ 猀攀氀攀挀琀 ⨀ 昀爀漀洀 搀戀漀⸀焀甀漀琀愀开甀猀愀最攀开戀礀甀猀攀爀⠀渀甀氀氀 Ⰰ 渀甀氀氀 Ⰰ渀甀氀氀Ⰰ渀甀氀氀 Ⰰ  ✀㄀㤀　　　㄀　㄀✀ Ⰰ ✀㈀　㌀㐀　㄀　㄀✀  ⤀ഀഀ
਍唀倀䐀䄀吀䔀 吀爀椀戀甀琀愀爀椀攀猀 匀䔀吀 䰀愀欀攀开椀搀㴀✀　　　　　　　　ⴀ　　　　ⴀ　　　　ⴀ　　　　ⴀ　　　　　　　　　　　　✀ 眀栀攀爀攀 䴀愀椀渀开䰀愀欀攀开椀搀 㴀 ✀㄀㄀㄀㄀㄀㄀㄀㄀ⴀ㄀㄀㄀㄀ⴀ㄀㄀㄀㄀ⴀ㄀㄀㄀㄀ⴀ㄀㄀㄀㄀㄀㄀㄀㄀㄀㄀㄀㄀✀ 愀渀搀 猀椀搀攀 㴀 ㌀㈀ഀഀ
਍䔀一䐀 吀刀夀ഀഀ
BEGIN CATCH਍    匀䔀䰀䔀䌀吀 䔀刀刀伀刀开一唀䴀䈀䔀刀⠀⤀ 䄀匀 䔀爀爀漀爀一甀洀戀攀爀Ⰰ    䔀刀刀伀刀开匀䔀嘀䔀刀䤀吀夀⠀⤀ 䄀匀 䔀爀爀漀爀匀攀瘀攀爀椀琀礀Ⰰ 䔀刀刀伀刀开匀吀䄀吀䔀⠀⤀   䄀匀 䔀爀爀漀爀匀琀愀琀攀ഀഀ
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage਍䔀一䐀 䌀䄀吀䌀䠀ഀഀ
਍ⴀⴀ ㌀⸀ 爀攀猀甀氀琀 瘀攀爀椀昀椀挀愀琀椀漀渀ഀഀ
declare @result1 int = ( select count(*) from lake where lake_id = '00000000-0000-0000-0000-000000000000')਍搀攀挀氀愀爀攀 䀀爀攀猀甀氀琀㈀ 椀渀琀 㴀 ⠀ 猀攀氀攀挀琀 挀漀甀渀琀⠀⨀⤀ 昀爀漀洀 吀爀椀戀甀琀愀爀椀攀猀 眀栀攀爀攀 洀愀椀渀开氀愀欀攀开椀搀 㴀 ✀　　　　　　　　ⴀ　　　　ⴀ　　　　ⴀ　　　　ⴀ　　　　　　　　　　　　✀⤀ഀഀ
declare @LoadTributary int = ( select count(*) from fn_ViewTributary('00000000-0000-0000-0000-000000000000') WHERE way = 'Inflow' )਍ഀഀ
IF  @result1 <> 1 OR @result2 <> 2  OR @LoadTributary <> 1਍   刀䄀䤀匀䔀刀刀伀刀 ⠀✀䘀䄀䤀䰀䔀䐀㨀 ─猀 猀椀渀最氀攀 氀愀欀攀 栀愀猀 ㄀ 吀爀椀戀甀琀愀爀礀 ─搀 ⴀ ─搀✀Ⰰ ㄀㘀Ⰰ ⴀ㄀Ⰰ 䀀琀攀猀琀开渀愀洀攀Ⰰ 䀀爀攀猀甀氀琀㄀Ⰰ 䀀爀攀猀甀氀琀㈀ ⤀ ഀഀ
ELSE਍    瀀爀椀渀琀 ✀倀䄀匀匀䔀䐀 ✀ ⬀ 䀀琀攀猀琀开渀愀洀攀ഀഀ
਍刀伀䰀䰀䈀䄀䌀䬀 吀刀䄀一 吀攀猀琀吀㈀琀氀ഀഀ
GO਍ⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀഀഀ
BEGIN TRAN TestT2tl਍    搀攀挀氀愀爀攀 䀀琀攀猀琀开渀愀洀攀 猀礀猀渀愀洀攀 㴀 ✀吀攀猀琀吀㈀琀氀 嬀昀渀开嘀椀攀眀吀爀椀戀甀琀愀爀礀崀 瘀椀攀眀 吀爀椀戀甀琀愀爀礀 漀昀 䰀愀欀攀✀ഀഀ
BEGIN TRY  SET NOCOUNT ON;਍ഀഀ
-- 1. prepare data for unit test਍ഀഀ
insert into lake (lake_id, locType, lake_name, CGNDB) values ('00000000-0000-0000-0000-000000000000', 1, N'Lake',   'Lakes')਍椀渀猀攀爀琀 椀渀琀漀 氀愀欀攀 ⠀氀愀欀攀开椀搀Ⰰ 氀漀挀吀礀瀀攀Ⰰ 氀愀欀攀开渀愀洀攀Ⰰ 䌀䜀一䐀䈀⤀ 瘀愀氀甀攀猀 ⠀✀㄀㄀㄀㄀㄀㄀㄀㄀ⴀ㄀㄀㄀㄀ⴀ㄀㄀㄀㄀ⴀ㄀㄀㄀㄀ⴀ㄀㄀㄀㄀㄀㄀㄀㄀㄀㄀㄀㄀✀Ⰰ ㈀Ⰰ 一✀刀椀瘀攀爀✀Ⰰ  ✀刀椀瘀攀爀✀⤀ഀഀ
਍ⴀⴀ ㈀⸀ 攀砀攀挀甀琀攀 甀渀椀琀 琀攀猀琀     ⴀⴀ 猀攀氀攀挀琀 ⨀ 昀爀漀洀 搀戀漀⸀焀甀漀琀愀开甀猀愀最攀开戀礀甀猀攀爀⠀渀甀氀氀 Ⰰ 渀甀氀氀 Ⰰ渀甀氀氀Ⰰ渀甀氀氀 Ⰰ  ✀㄀㤀　　　㄀　㄀✀ Ⰰ ✀㈀　㌀㐀　㄀　㄀✀  ⤀ഀഀ
਍唀倀䐀䄀吀䔀 吀爀椀戀甀琀愀爀椀攀猀 匀䔀吀 䰀愀欀攀开椀搀㴀✀　　　　　　　　ⴀ　　　　ⴀ　　　　ⴀ　　　　ⴀ　　　　　　　　　　　　✀ 眀栀攀爀攀 䴀愀椀渀开䰀愀欀攀开椀搀 㴀 ✀㄀㄀㄀㄀㄀㄀㄀㄀ⴀ㄀㄀㄀㄀ⴀ㄀㄀㄀㄀ⴀ㄀㄀㄀㄀ⴀ㄀㄀㄀㄀㄀㄀㄀㄀㄀㄀㄀㄀✀ 愀渀搀 猀椀搀攀 㴀 ㌀㈀ഀഀ
਍䔀一䐀 吀刀夀ഀഀ
BEGIN CATCH਍    匀䔀䰀䔀䌀吀 䔀刀刀伀刀开一唀䴀䈀䔀刀⠀⤀ 䄀匀 䔀爀爀漀爀一甀洀戀攀爀Ⰰ    䔀刀刀伀刀开匀䔀嘀䔀刀䤀吀夀⠀⤀ 䄀匀 䔀爀爀漀爀匀攀瘀攀爀椀琀礀Ⰰ 䔀刀刀伀刀开匀吀䄀吀䔀⠀⤀   䄀匀 䔀爀爀漀爀匀琀愀琀攀ഀഀ
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage਍䔀一䐀 䌀䄀吀䌀䠀ഀഀ
਍ⴀⴀ ㌀⸀ 爀攀猀甀氀琀 瘀攀爀椀昀椀挀愀琀椀漀渀ഀഀ
declare @result1 int = ( select count(*) from lake where lake_id = '00000000-0000-0000-0000-000000000000')਍搀攀挀氀愀爀攀 䀀爀攀猀甀氀琀㈀ 椀渀琀 㴀 ⠀ 猀攀氀攀挀琀 挀漀甀渀琀⠀⨀⤀ 昀爀漀洀 吀爀椀戀甀琀愀爀椀攀猀 眀栀攀爀攀 洀愀椀渀开氀愀欀攀开椀搀 㴀 ✀　　　　　　　　ⴀ　　　　ⴀ　　　　ⴀ　　　　ⴀ　　　　　　　　　　　　✀⤀ഀഀ
declare @LoadTributary int = ( select count(*) from fn_ViewTributary('00000000-0000-0000-0000-000000000000') WHERE way = 'Inflow' )਍ഀഀ
IF  @result1 <> 1 OR @result2 <> 2  OR @LoadTributary <> 1਍   刀䄀䤀匀䔀刀刀伀刀 ⠀✀䘀䄀䤀䰀䔀䐀㨀 ─猀 猀椀渀最氀攀 氀愀欀攀 栀愀猀 ㄀ 吀爀椀戀甀琀愀爀礀 ─搀 ⴀ ─搀✀Ⰰ ㄀㘀Ⰰ ⴀ㄀Ⰰ 䀀琀攀猀琀开渀愀洀攀Ⰰ 䀀爀攀猀甀氀琀㄀Ⰰ 䀀爀攀猀甀氀琀㈀ ⤀ ഀഀ
ELSE਍    瀀爀椀渀琀 ✀倀䄀匀匀䔀䐀 ✀ ⬀ 䀀琀攀猀琀开渀愀洀攀ഀഀ
਍刀伀䰀䰀䈀䄀䌀䬀 吀刀䄀一 吀攀猀琀吀㈀琀氀ഀഀ
GO਍ⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀഀഀ
BEGIN TRAN TestT2tl਍    搀攀挀氀愀爀攀 䀀琀攀猀琀开渀愀洀攀 猀礀猀渀愀洀攀 㴀 ✀吀攀猀琀吀㈀琀氀 嬀昀渀开嘀椀攀眀吀爀椀戀甀琀愀爀礀崀 刀椀瘀攀爀 昀氀漀眀 琀栀爀漀甀 䰀愀欀攀✀ഀഀ
BEGIN TRY  SET NOCOUNT ON;਍ഀഀ
-- 1. prepare data for unit test਍ഀഀ
insert into lake (lake_id, locType, lake_name, CGNDB) values ('00000000-0000-0000-0000-000000000000', 1, N'Lake',   'Lakes')਍椀渀猀攀爀琀 椀渀琀漀 氀愀欀攀 ⠀氀愀欀攀开椀搀Ⰰ 氀漀挀吀礀瀀攀Ⰰ 氀愀欀攀开渀愀洀攀Ⰰ 䌀䜀一䐀䈀⤀ 瘀愀氀甀攀猀 ⠀✀㄀㄀㄀㄀㄀㄀㄀㄀ⴀ㄀㄀㄀㄀ⴀ㄀㄀㄀㄀ⴀ㄀㄀㄀㄀ⴀ㄀㄀㄀㄀㄀㄀㄀㄀㄀㄀㄀㄀✀Ⰰ ㈀Ⰰ 一✀刀椀瘀攀爀✀Ⰰ  ✀刀椀瘀攀爀✀⤀ഀഀ
਍ⴀⴀ ㈀⸀ 攀砀攀挀甀琀攀 甀渀椀琀 琀攀猀琀     ⴀⴀ 猀攀氀攀挀琀 ⨀ 昀爀漀洀 搀戀漀⸀焀甀漀琀愀开甀猀愀最攀开戀礀甀猀攀爀⠀渀甀氀氀 Ⰰ 渀甀氀氀 Ⰰ渀甀氀氀Ⰰ渀甀氀氀 Ⰰ  ✀㄀㤀　　　㄀　㄀✀ Ⰰ ✀㈀　㌀㐀　㄀　㄀✀  ⤀ഀഀ
਍唀倀䐀䄀吀䔀 吀爀椀戀甀琀愀爀椀攀猀 匀䔀吀 䰀愀欀攀开椀搀㴀✀　　　　　　　　ⴀ　　　　ⴀ　　　　ⴀ　　　　ⴀ　　　　　　　　　　　　✀ 眀栀攀爀攀 䴀愀椀渀开䰀愀欀攀开椀搀 㴀 ✀㄀㄀㄀㄀㄀㄀㄀㄀ⴀ㄀㄀㄀㄀ⴀ㄀㄀㄀㄀ⴀ㄀㄀㄀㄀ⴀ㄀㄀㄀㄀㄀㄀㄀㄀㄀㄀㄀㄀✀ 愀渀搀 猀椀搀攀 㴀 ㌀㈀ഀഀ
਍䔀一䐀 吀刀夀ഀഀ
BEGIN CATCH਍    匀䔀䰀䔀䌀吀 䔀刀刀伀刀开一唀䴀䈀䔀刀⠀⤀ 䄀匀 䔀爀爀漀爀一甀洀戀攀爀Ⰰ    䔀刀刀伀刀开匀䔀嘀䔀刀䤀吀夀⠀⤀ 䄀匀 䔀爀爀漀爀匀攀瘀攀爀椀琀礀Ⰰ 䔀刀刀伀刀开匀吀䄀吀䔀⠀⤀   䄀匀 䔀爀爀漀爀匀琀愀琀攀ഀഀ
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage਍䔀一䐀 䌀䄀吀䌀䠀ഀഀ
਍ⴀⴀ ㌀⸀ 爀攀猀甀氀琀 瘀攀爀椀昀椀挀愀琀椀漀渀ഀഀ
declare @result1 int = ( select count(*) from lake where lake_id = '00000000-0000-0000-0000-000000000000')਍搀攀挀氀愀爀攀 䀀爀攀猀甀氀琀㈀ 椀渀琀 㴀 ⠀ 猀攀氀攀挀琀 挀漀甀渀琀⠀⨀⤀ 昀爀漀洀 吀爀椀戀甀琀愀爀椀攀猀 眀栀攀爀攀 洀愀椀渀开氀愀欀攀开椀搀 㴀 ✀　　　　　　　　ⴀ　　　　ⴀ　　　　ⴀ　　　　ⴀ　　　　　　　　　　　　✀⤀ഀഀ
declare @LoadTributary int = ( select count(*) from fn_ViewTributary('00000000-0000-0000-0000-000000000000') WHERE way = 'Inflow' )਍ഀഀ
IF  @result1 <> 1 OR @result2 <> 2  OR @LoadTributary <> 1਍   刀䄀䤀匀䔀刀刀伀刀 ⠀✀䘀䄀䤀䰀䔀䐀㨀 ─猀 猀椀渀最氀攀 氀愀欀攀 栀愀猀 ㄀ 吀爀椀戀甀琀愀爀礀 ─搀 ⴀ ─搀✀Ⰰ ㄀㘀Ⰰ ⴀ㄀Ⰰ 䀀琀攀猀琀开渀愀洀攀Ⰰ 䀀爀攀猀甀氀琀㄀Ⰰ 䀀爀攀猀甀氀琀㈀ ⤀ ഀഀ
ELSE਍    瀀爀椀渀琀 ✀倀䄀匀匀䔀䐀 ✀ ⬀ 䀀琀攀猀琀开渀愀洀攀ഀഀ
਍刀伀䰀䰀䈀䄀䌀䬀 吀刀䄀一 吀攀猀琀吀㈀琀氀ഀഀ
GO਍ⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀഀഀ
BEGIN TRAN TestAddT1਍    搀攀挀氀愀爀攀 䀀琀攀猀琀开渀愀洀攀 猀礀猀渀愀洀攀 㴀 ✀吀攀猀琀䄀搀搀吀㄀ 嬀猀瀀开愀搀搀开琀爀椀戀甀琀愀爀礀崀 爀椀瘀攀爀 氀椀渀欀攀搀 琀漀 氀愀欀攀✀ഀഀ
BEGIN TRY  SET NOCOUNT ON;਍ഀഀ
-- 1. prepare data for unit test਍ഀഀ
insert into lake (lake_id, locType, lake_name, CGNDB) values ('00000000-0000-0000-0000-000000000000', 1, N'Lake',   'Lakes')਍椀渀猀攀爀琀 椀渀琀漀 氀愀欀攀 ⠀氀愀欀攀开椀搀Ⰰ 氀漀挀吀礀瀀攀Ⰰ 氀愀欀攀开渀愀洀攀Ⰰ 䌀䜀一䐀䈀⤀ 瘀愀氀甀攀猀 ⠀✀㄀㄀㄀㄀㄀㄀㄀㄀ⴀ㄀㄀㄀㄀ⴀ㄀㄀㄀㄀ⴀ㄀㄀㄀㄀ⴀ㄀㄀㄀㄀㄀㄀㄀㄀㄀㄀㄀㄀✀Ⰰ ㈀Ⰰ 一✀刀椀瘀攀爀✀Ⰰ  ✀刀椀瘀攀爀✀⤀ഀഀ
਍ⴀⴀ ㈀⸀ 攀砀攀挀甀琀攀 甀渀椀琀 琀攀猀琀     ⴀⴀ 猀攀氀攀挀琀 ⨀ 昀爀漀洀 搀戀漀⸀焀甀漀琀愀开甀猀愀最攀开戀礀甀猀攀爀⠀渀甀氀氀 Ⰰ 渀甀氀氀 Ⰰ渀甀氀氀Ⰰ渀甀氀氀 Ⰰ  ✀㄀㤀　　　㄀　㄀✀ Ⰰ ✀㈀　㌀㐀　㄀　㄀✀  ⤀ഀഀ
਍䔀堀䔀䌀 猀瀀开愀搀搀开琀爀椀戀甀琀愀爀礀 ✀㄀㄀㄀㄀㄀㄀㄀㄀ⴀ㄀㄀㄀㄀ⴀ㄀㄀㄀㄀ⴀ㄀㄀㄀㄀ⴀ㄀㄀㄀㄀㄀㄀㄀㄀㄀㄀㄀㄀✀Ⰰ ✀　　　　　　　　ⴀ　　　　ⴀ　　　　ⴀ　　　　ⴀ　　　　　　　　　　　　✀Ⰰ ㄀ഀഀ
਍䔀一䐀 吀刀夀ഀഀ
BEGIN CATCH਍    匀䔀䰀䔀䌀吀 䔀刀刀伀刀开一唀䴀䈀䔀刀⠀⤀ 䄀匀 䔀爀爀漀爀一甀洀戀攀爀Ⰰ    䔀刀刀伀刀开匀䔀嘀䔀刀䤀吀夀⠀⤀ 䄀匀 䔀爀爀漀爀匀攀瘀攀爀椀琀礀Ⰰ 䔀刀刀伀刀开匀吀䄀吀䔀⠀⤀   䄀匀 䔀爀爀漀爀匀琀愀琀攀ഀഀ
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage਍䔀一䐀 䌀䄀吀䌀䠀ഀഀ
਍ⴀⴀ ㌀⸀ 爀攀猀甀氀琀 瘀攀爀椀昀椀挀愀琀椀漀渀ഀഀ
declare @result1 int = ( select count(*) from Tributaries where main_lake_id = '11111111-1111-1111-1111-111111111111')਍ഀഀ
declare @LoadTributary int = ( select count(*) from fn_ViewTributary('11111111-1111-1111-1111-111111111111') WHERE way = 'Linked' )਍搀攀挀氀愀爀攀 䀀䔀搀椀琀吀爀椀戀甀琀愀爀礀刀 椀渀琀 㴀 ⠀ 猀攀氀攀挀琀 挀漀甀渀琀⠀⨀⤀ 昀爀漀洀 昀渀开䔀搀椀琀吀爀椀戀甀琀愀爀礀⠀✀㄀㄀㄀㄀㄀㄀㄀㄀ⴀ㄀㄀㄀㄀ⴀ㄀㄀㄀㄀ⴀ㄀㄀㄀㄀ⴀ㄀㄀㄀㄀㄀㄀㄀㄀㄀㄀㄀㄀✀⤀  ⤀ഀഀ
declare @EditTributaryL int = ( select count(*) from fn_EditTributary('00000000-0000-0000-0000-000000000000')  )਍ഀഀ
IF  @result1 <> 3 OR @LoadTributary <> 1 OR @EditTributaryR <> 1 OR @EditTributaryL <> 1਍   刀䄀䤀匀䔀刀刀伀刀 ⠀✀䘀䄀䤀䰀䔀䐀㨀 ─猀 爀椀瘀攀爀 氀椀渀欀攀搀 琀漀 氀愀欀攀 栀愀猀 ㄀ 吀爀椀戀甀琀愀爀礀 ─搀 ⴀ ─搀✀Ⰰ ㄀㘀Ⰰ ⴀ㄀Ⰰ 䀀琀攀猀琀开渀愀洀攀Ⰰ 䀀爀攀猀甀氀琀㄀Ⰰ 䀀䰀漀愀搀吀爀椀戀甀琀愀爀礀 ⤀ ഀഀ
ELSE਍    瀀爀椀渀琀 ✀倀䄀匀匀䔀䐀 ✀ ⬀ 䀀琀攀猀琀开渀愀洀攀ഀഀ
਍刀伀䰀䰀䈀䄀䌀䬀 吀刀䄀一 吀攀猀琀䄀搀搀吀㄀ഀഀ
GO਍ⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀഀഀ
BEGIN TRAN TestAddT4਍    搀攀挀氀愀爀攀 䀀琀攀猀琀开渀愀洀攀 猀礀猀渀愀洀攀 㴀 ✀吀攀猀琀䄀搀搀吀㐀 嬀猀瀀开愀搀搀开琀爀椀戀甀琀愀爀礀崀 爀椀瘀攀爀 挀漀洀攀 琀漀 氀愀欀攀✀ഀഀ
BEGIN TRY  SET NOCOUNT ON;਍ഀഀ
-- 1. prepare data for unit test਍ഀഀ
insert into lake (lake_id, locType, lake_name, CGNDB) values ('00000000-0000-0000-0000-000000000000', 1, N'Lake',   'Lakes')਍椀渀猀攀爀琀 椀渀琀漀 氀愀欀攀 ⠀氀愀欀攀开椀搀Ⰰ 氀漀挀吀礀瀀攀Ⰰ 氀愀欀攀开渀愀洀攀Ⰰ 䌀䜀一䐀䈀⤀ 瘀愀氀甀攀猀 ⠀✀㄀㄀㄀㄀㄀㄀㄀㄀ⴀ㄀㄀㄀㄀ⴀ㄀㄀㄀㄀ⴀ㄀㄀㄀㄀ⴀ㄀㄀㄀㄀㄀㄀㄀㄀㄀㄀㄀㄀✀Ⰰ ㈀Ⰰ 一✀刀椀瘀攀爀✀Ⰰ  ✀刀椀瘀攀爀✀⤀ഀഀ
਍ⴀⴀ ㈀⸀ 攀砀攀挀甀琀攀 甀渀椀琀 琀攀猀琀     ⴀⴀ 猀攀氀攀挀琀 ⨀ 昀爀漀洀 搀戀漀⸀焀甀漀琀愀开甀猀愀最攀开戀礀甀猀攀爀⠀渀甀氀氀 Ⰰ 渀甀氀氀 Ⰰ渀甀氀氀Ⰰ渀甀氀氀 Ⰰ  ✀㄀㤀　　　㄀　㄀✀ Ⰰ ✀㈀　㌀㐀　㄀　㄀✀  ⤀ഀഀ
਍䔀堀䔀䌀 猀瀀开愀搀搀开琀爀椀戀甀琀愀爀礀 ✀㄀㄀㄀㄀㄀㄀㄀㄀ⴀ㄀㄀㄀㄀ⴀ㄀㄀㄀㄀ⴀ㄀㄀㄀㄀ⴀ㄀㄀㄀㄀㄀㄀㄀㄀㄀㄀㄀㄀✀Ⰰ ✀　　　　　　　　ⴀ　　　　ⴀ　　　　ⴀ　　　　ⴀ　　　　　　　　　　　　✀Ⰰ 㐀Ⰰ ㄀㄀Ⰰ ⴀ㈀㈀ഀഀ
਍䔀一䐀 吀刀夀ഀഀ
BEGIN CATCH਍    匀䔀䰀䔀䌀吀 䔀刀刀伀刀开一唀䴀䈀䔀刀⠀⤀ 䄀匀 䔀爀爀漀爀一甀洀戀攀爀Ⰰ    䔀刀刀伀刀开匀䔀嘀䔀刀䤀吀夀⠀⤀ 䄀匀 䔀爀爀漀爀匀攀瘀攀爀椀琀礀Ⰰ 䔀刀刀伀刀开匀吀䄀吀䔀⠀⤀   䄀匀 䔀爀爀漀爀匀琀愀琀攀ഀഀ
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage਍䔀一䐀 䌀䄀吀䌀䠀ഀഀ
਍ⴀⴀ ㌀⸀ 爀攀猀甀氀琀 瘀攀爀椀昀椀挀愀琀椀漀渀ഀഀ
declare @LoadTributaryR int = ( select count(*) from fn_ViewTributary('11111111-1111-1111-1111-111111111111') WHERE way = 'Inflow Throw' )਍搀攀挀氀愀爀攀 䀀䰀漀愀搀吀爀椀戀甀琀愀爀礀䰀 椀渀琀 㴀 ⠀ 猀攀氀攀挀琀 挀漀甀渀琀⠀⨀⤀ 昀爀漀洀 昀渀开嘀椀攀眀吀爀椀戀甀琀愀爀礀⠀✀　　　　　　　　ⴀ　　　　ⴀ　　　　ⴀ　　　　ⴀ　　　　　　　　　　　　✀⤀ 圀䠀䔀刀䔀 眀愀礀 㴀 ✀䤀渀昀氀漀眀 吀栀爀漀眀✀ ⤀ഀഀ
declare @EditTributaryR int = ( select count(*) from fn_EditTributary('11111111-1111-1111-1111-111111111111')  )਍搀攀挀氀愀爀攀 䀀䔀搀椀琀吀爀椀戀甀琀愀爀礀䰀 椀渀琀 㴀 ⠀ 猀攀氀攀挀琀 挀漀甀渀琀⠀⨀⤀ 昀爀漀洀 昀渀开䔀搀椀琀吀爀椀戀甀琀愀爀礀⠀✀　　　　　　　　ⴀ　　　　ⴀ　　　　ⴀ　　　　ⴀ　　　　　　　　　　　　✀⤀  ⤀ഀഀ
਍䤀䘀  䀀䰀漀愀搀吀爀椀戀甀琀愀爀礀刀 㰀㸀 ㄀ 伀刀 䀀䰀漀愀搀吀爀椀戀甀琀愀爀礀䰀 㰀㸀 ㄀ 伀刀 䀀䔀搀椀琀吀爀椀戀甀琀愀爀礀刀 㰀㸀 ㄀ 伀刀 䀀䔀搀椀琀吀爀椀戀甀琀愀爀礀䰀 㰀㸀 ㄀ഀഀ
   RAISERROR ('FAILED: %s river linked to lake has 1 Tributary %d - %d', 16, -1, @test_name, @LoadTributaryR, @LoadTributaryL ) ਍䔀䰀匀䔀ഀഀ
    print 'PASSED ' + @test_name਍ഀഀ
ROLLBACK TRAN TestAddT4਍䜀伀ഀഀ
----------------------------------------------------------------------------------------------------------਍䈀䔀䜀䤀一 吀刀䄀一 吀攀猀琀䄀搀搀吀㠀ഀഀ
    declare @test_name sysname = 'TestAddT8 [sp_add_tributary] river come out from lake'਍䈀䔀䜀䤀一 吀刀夀  匀䔀吀 一伀䌀伀唀一吀 伀一㬀ഀഀ
਍ⴀⴀ ㄀⸀ 瀀爀攀瀀愀爀攀 搀愀琀愀 昀漀爀 甀渀椀琀 琀攀猀琀ഀഀ
਍椀渀猀攀爀琀 椀渀琀漀 氀愀欀攀 ⠀氀愀欀攀开椀搀Ⰰ 氀漀挀吀礀瀀攀Ⰰ 氀愀欀攀开渀愀洀攀Ⰰ 䌀䜀一䐀䈀⤀ 瘀愀氀甀攀猀 ⠀✀　　　　　　　　ⴀ　　　　ⴀ　　　　ⴀ　　　　ⴀ　　　　　　　　　　　　✀Ⰰ ㄀Ⰰ 一✀䰀愀欀攀✀Ⰰ   ✀䰀愀欀攀猀✀⤀ഀഀ
insert into lake (lake_id, locType, lake_name, CGNDB) values ('11111111-1111-1111-1111-111111111111', 2, N'River',  'River')਍ഀഀ
-- 2. execute unit test     -- select * from dbo.quota_usage_byuser(null , null ,null,null ,  '19000101' , '20340101'  )਍ഀഀ
EXEC sp_add_tributary '11111111-1111-1111-1111-111111111111', '00000000-0000-0000-0000-000000000000', 8, 11, -22਍ഀഀ
END TRY਍䈀䔀䜀䤀一 䌀䄀吀䌀䠀ഀഀ
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState਍         Ⰰ 䀀琀攀猀琀开渀愀洀攀     䄀匀 䔀爀爀漀爀倀爀漀挀攀搀甀爀攀Ⰰ 䔀刀刀伀刀开䰀䤀一䔀⠀⤀     䄀匀 䔀爀爀漀爀䰀椀渀攀Ⰰ     䔀刀刀伀刀开䴀䔀匀匀䄀䜀䔀⠀⤀ 䄀匀 䔀爀爀漀爀䴀攀猀猀愀最攀ഀഀ
END CATCH਍ഀഀ
-- 3. result verification਍搀攀挀氀愀爀攀 䀀䰀漀愀搀吀爀椀戀甀琀愀爀礀刀 椀渀琀 㴀 ⠀ 猀攀氀攀挀琀 挀漀甀渀琀⠀⨀⤀ 昀爀漀洀 昀渀开嘀椀攀眀吀爀椀戀甀琀愀爀礀⠀✀㄀㄀㄀㄀㄀㄀㄀㄀ⴀ㄀㄀㄀㄀ⴀ㄀㄀㄀㄀ⴀ㄀㄀㄀㄀ⴀ㄀㄀㄀㄀㄀㄀㄀㄀㄀㄀㄀㄀✀⤀ 圀䠀䔀刀䔀 眀愀礀 㴀 ✀伀甀琀昀氀漀眀 吀栀爀漀眀✀ ⤀ഀഀ
declare @LoadTributaryL int = ( select count(*) from fn_ViewTributary('00000000-0000-0000-0000-000000000000') WHERE way = 'Outflow Throw' )਍搀攀挀氀愀爀攀 䀀䔀搀椀琀吀爀椀戀甀琀愀爀礀刀 椀渀琀 㴀 ⠀ 猀攀氀攀挀琀 挀漀甀渀琀⠀⨀⤀ 昀爀漀洀 昀渀开䔀搀椀琀吀爀椀戀甀琀愀爀礀⠀✀㄀㄀㄀㄀㄀㄀㄀㄀ⴀ㄀㄀㄀㄀ⴀ㄀㄀㄀㄀ⴀ㄀㄀㄀㄀ⴀ㄀㄀㄀㄀㄀㄀㄀㄀㄀㄀㄀㄀✀⤀  ⤀ഀഀ
declare @EditTributaryL int = ( select count(*) from fn_EditTributary('00000000-0000-0000-0000-000000000000')  )਍ഀഀ
IF  @LoadTributaryR <> 1 OR @LoadTributaryL <> 1 OR @EditTributaryR <> 1 OR @EditTributaryL <> 1਍   刀䄀䤀匀䔀刀刀伀刀 ⠀✀䘀䄀䤀䰀䔀䐀㨀 ─猀 爀椀瘀攀爀 氀椀渀欀攀搀 琀漀 氀愀欀攀 栀愀猀 ㄀ 吀爀椀戀甀琀愀爀礀 ─搀 ⴀ ─搀✀Ⰰ ㄀㘀Ⰰ ⴀ㄀Ⰰ 䀀琀攀猀琀开渀愀洀攀Ⰰ 䀀䰀漀愀搀吀爀椀戀甀琀愀爀礀刀Ⰰ 䀀䰀漀愀搀吀爀椀戀甀琀愀爀礀䰀 ⤀ ഀഀ
ELSE਍    瀀爀椀渀琀 ✀倀䄀匀匀䔀䐀 ✀ ⬀ 䀀琀攀猀琀开渀愀洀攀ഀഀ
਍刀伀䰀䰀䈀䄀䌀䬀 吀刀䄀一 吀攀猀琀䄀搀搀吀㠀ഀഀ
GO਍ⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀഀഀ
BEGIN TRAN TestAddT2਍    搀攀挀氀愀爀攀 䀀琀攀猀琀开渀愀洀攀 猀礀猀渀愀洀攀 㴀 ✀吀攀猀琀䄀搀搀吀㈀ 嬀猀瀀开愀搀搀开琀爀椀戀甀琀愀爀礀崀 爀椀瘀攀爀 最漀椀渀最 琀栀爀漀眀 琀栀攀 氀愀欀攀✀ഀഀ
BEGIN TRY  SET NOCOUNT ON;਍ഀഀ
-- 1. prepare data for unit test਍ഀഀ
insert into lake (lake_id, locType, lake_name, CGNDB) values ('00000000-0000-0000-0000-000000000000', 1, N'Lake',   'Lakes')਍椀渀猀攀爀琀 椀渀琀漀 氀愀欀攀 ⠀氀愀欀攀开椀搀Ⰰ 氀漀挀吀礀瀀攀Ⰰ 氀愀欀攀开渀愀洀攀Ⰰ 䌀䜀一䐀䈀⤀ 瘀愀氀甀攀猀 ⠀✀㄀㄀㄀㄀㄀㄀㄀㄀ⴀ㄀㄀㄀㄀ⴀ㄀㄀㄀㄀ⴀ㄀㄀㄀㄀ⴀ㄀㄀㄀㄀㄀㄀㄀㄀㄀㄀㄀㄀✀Ⰰ ㈀Ⰰ 一✀刀椀瘀攀爀✀Ⰰ  ✀刀椀瘀攀爀✀⤀ഀഀ
਍ⴀⴀ ㈀⸀ 攀砀攀挀甀琀攀 甀渀椀琀 琀攀猀琀     ⴀⴀ 猀攀氀攀挀琀 ⨀ 昀爀漀洀 搀戀漀⸀焀甀漀琀愀开甀猀愀最攀开戀礀甀猀攀爀⠀渀甀氀氀 Ⰰ 渀甀氀氀 Ⰰ渀甀氀氀Ⰰ渀甀氀氀 Ⰰ  ✀㄀㤀　　　㄀　㄀✀ Ⰰ ✀㈀　㌀㐀　㄀　㄀✀  ⤀ഀഀ
਍䔀堀䔀䌀 猀瀀开愀搀搀开琀爀椀戀甀琀愀爀礀 ✀㄀㄀㄀㄀㄀㄀㄀㄀ⴀ㄀㄀㄀㄀ⴀ㄀㄀㄀㄀ⴀ㄀㄀㄀㄀ⴀ㄀㄀㄀㄀㄀㄀㄀㄀㄀㄀㄀㄀✀Ⰰ ✀　　　　　　　　ⴀ　　　　ⴀ　　　　ⴀ　　　　ⴀ　　　　　　　　　　　　✀Ⰰ ㈀Ⰰ ㄀㄀Ⰰ ⴀ㈀㈀ഀഀ
਍䔀一䐀 吀刀夀ഀഀ
BEGIN CATCH਍    匀䔀䰀䔀䌀吀 䔀刀刀伀刀开一唀䴀䈀䔀刀⠀⤀ 䄀匀 䔀爀爀漀爀一甀洀戀攀爀Ⰰ    䔀刀刀伀刀开匀䔀嘀䔀刀䤀吀夀⠀⤀ 䄀匀 䔀爀爀漀爀匀攀瘀攀爀椀琀礀Ⰰ 䔀刀刀伀刀开匀吀䄀吀䔀⠀⤀   䄀匀 䔀爀爀漀爀匀琀愀琀攀ഀഀ
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage਍䔀一䐀 䌀䄀吀䌀䠀ഀഀ
਍ⴀⴀ ㌀⸀ 爀攀猀甀氀琀 瘀攀爀椀昀椀挀愀琀椀漀渀ഀഀ
declare @LoadTributaryR int = ( select count(*) from fn_ViewTributary('11111111-1111-1111-1111-111111111111') WHERE way LIKE '% Throw' )਍搀攀挀氀愀爀攀 䀀䰀漀愀搀吀爀椀戀甀琀愀爀礀䰀 椀渀琀 㴀 ⠀ 猀攀氀攀挀琀 挀漀甀渀琀⠀⨀⤀ 昀爀漀洀 昀渀开嘀椀攀眀吀爀椀戀甀琀愀爀礀⠀✀　　　　　　　　ⴀ　　　　ⴀ　　　　ⴀ　　　　ⴀ　　　　　　　　　　　　✀⤀ 圀䠀䔀刀䔀 眀愀礀 䰀䤀䬀䔀 ✀─ 吀栀爀漀眀✀ ⤀ഀഀ
declare @EditTributaryR int = ( select count(*) from fn_EditTributary('11111111-1111-1111-1111-111111111111')  )਍搀攀挀氀愀爀攀 䀀䔀搀椀琀吀爀椀戀甀琀愀爀礀䰀 椀渀琀 㴀 ⠀ 猀攀氀攀挀琀 挀漀甀渀琀⠀⨀⤀ 昀爀漀洀 昀渀开䔀搀椀琀吀爀椀戀甀琀愀爀礀⠀✀　　　　　　　　ⴀ　　　　ⴀ　　　　ⴀ　　　　ⴀ　　　　　　　　　　　　✀⤀  ⤀ഀഀ
਍䤀䘀  䀀䰀漀愀搀吀爀椀戀甀琀愀爀礀刀 㰀㸀 ㈀ 伀刀 䀀䰀漀愀搀吀爀椀戀甀琀愀爀礀䰀 㰀㸀 ㈀ 伀刀 䀀䔀搀椀琀吀爀椀戀甀琀愀爀礀刀 㰀㸀 ㈀ 伀刀 䀀䔀搀椀琀吀爀椀戀甀琀愀爀礀䰀 㰀㸀 ㈀ഀഀ
   RAISERROR ('FAILED: %s river linked to lake has 1 Tributary %d - %d', 16, -1, @test_name, @LoadTributaryR, @LoadTributaryL ) ਍䔀䰀匀䔀ഀഀ
    print 'PASSED ' + @test_name਍ഀഀ
ROLLBACK TRAN TestAddT2਍䜀伀ഀഀ
----------------------------------------------------------------------------------------------------------਍ⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀഀഀ
BEGIN TRAN TestAssign1਍    搀攀挀氀愀爀攀 䀀琀攀猀琀开渀愀洀攀 猀礀猀渀愀洀攀 㴀 ✀吀攀猀琀䄀猀猀椀最渀㄀ 嬀猀瀀开愀搀搀开琀爀椀戀甀琀愀爀礀崀 猀攀琀 氀愀欀攀 昀漀爀 爀椀瘀攀爀 愀猀 愀 猀漀甀爀挀攀✀ഀഀ
BEGIN TRY  SET NOCOUNT ON;਍ഀഀ
-- 1. prepare data for unit test਍ഀഀ
insert into lake (lake_id, locType, lake_name, CGNDB) values ('00000000-0000-0000-0000-000000000000', 1, N'Lake',   'Lakes')਍椀渀猀攀爀琀 椀渀琀漀 氀愀欀攀 ⠀氀愀欀攀开椀搀Ⰰ 氀漀挀吀礀瀀攀Ⰰ 氀愀欀攀开渀愀洀攀Ⰰ 䌀䜀一䐀䈀⤀ 瘀愀氀甀攀猀 ⠀✀㄀㄀㄀㄀㄀㄀㄀㄀ⴀ㄀㄀㄀㄀ⴀ㄀㄀㄀㄀ⴀ㄀㄀㄀㄀ⴀ㄀㄀㄀㄀㄀㄀㄀㄀㄀㄀㄀㄀✀Ⰰ ㈀Ⰰ 一✀刀椀瘀攀爀✀Ⰰ  ✀刀椀瘀攀爀✀⤀ഀഀ
-- lake as source of river਍ഀഀ
-- 2. execute unit test     -- select * from dbo.quota_usage_byuser(null , null ,null,null ,  '19000101' , '20340101'  )਍ഀഀ
UPDATE Tributaries SET lake_id = '00000000-0000-0000-0000-000000000000' where Main_Lake_id = '11111111-1111-1111-1111-111111111111' and side = 16਍ഀഀ
END TRY਍䈀䔀䜀䤀一 䌀䄀吀䌀䠀ഀഀ
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState਍         Ⰰ 䀀琀攀猀琀开渀愀洀攀     䄀匀 䔀爀爀漀爀倀爀漀挀攀搀甀爀攀Ⰰ 䔀刀刀伀刀开䰀䤀一䔀⠀⤀     䄀匀 䔀爀爀漀爀䰀椀渀攀Ⰰ     䔀刀刀伀刀开䴀䔀匀匀䄀䜀䔀⠀⤀ 䄀匀 䔀爀爀漀爀䴀攀猀猀愀最攀ഀഀ
END CATCH਍ഀഀ
-- 3. result verification਍搀攀挀氀愀爀攀 䀀爀攀猀甀氀琀 椀渀琀 㴀 ⠀ 猀攀氀攀挀琀 挀漀甀渀琀⠀⨀⤀ 昀爀漀洀 昀渀开嘀椀攀眀吀爀椀戀甀琀愀爀礀⠀✀㄀㄀㄀㄀㄀㄀㄀㄀ⴀ㄀㄀㄀㄀ⴀ㄀㄀㄀㄀ⴀ㄀㄀㄀㄀ⴀ㄀㄀㄀㄀㄀㄀㄀㄀㄀㄀㄀㄀✀⤀ 圀䠀䔀刀䔀 眀愀礀 䰀䤀䬀䔀 ✀䤀渀昀氀漀眀✀ ⤀ഀഀ
਍䤀䘀  䀀爀攀猀甀氀琀 㰀㸀 ㄀ഀഀ
   RAISERROR ('FAILED: %s single source for river %d', 16, -1, @test_name, @result ) ਍䔀䰀匀䔀ഀഀ
    print 'PASSED ' + @test_name਍ഀഀ
ROLLBACK TRAN TestAssign1਍䜀伀ഀഀ
----------------------------------------------------------------------------------------------------------਍䈀䔀䜀䤀一 吀刀䄀一 吀攀猀琀䄀猀猀椀最渀㄀ഀഀ
    declare @test_name sysname = 'TestAssign1 [sp_assign_border] ajust lat/lon for river source'਍䈀䔀䜀䤀一 吀刀夀  匀䔀吀 一伀䌀伀唀一吀 伀一㬀ഀഀ
਍ⴀⴀ ㄀⸀ 瀀爀攀瀀愀爀攀 搀愀琀愀 昀漀爀 甀渀椀琀 琀攀猀琀ഀഀ
਍椀渀猀攀爀琀 椀渀琀漀 氀愀欀攀 ⠀氀愀欀攀开椀搀Ⰰ 氀漀挀吀礀瀀攀Ⰰ 氀愀欀攀开渀愀洀攀Ⰰ 䌀䜀一䐀䈀⤀ 瘀愀氀甀攀猀 ⠀✀　　　　　　　　ⴀ　　　　ⴀ　　　　ⴀ　　　　ⴀ　　　　　　　　　　　　✀Ⰰ ㄀Ⰰ 一✀䰀愀欀攀✀Ⰰ   ✀䰀愀欀攀猀✀⤀ഀഀ
insert into lake (lake_id, locType, lake_name, CGNDB) values ('11111111-1111-1111-1111-111111111111', 2, N'River',  'River')਍唀倀䐀䄀吀䔀 吀爀椀戀甀琀愀爀椀攀猀 匀䔀吀 氀愀欀攀开椀搀 㴀 ✀　　　　　　　　ⴀ　　　　ⴀ　　　　ⴀ　　　　ⴀ　　　　　　　　　　　　✀Ⰰ 氀愀琀 㴀 ㄀Ⰰ 氀漀渀 㴀 ㈀ 眀栀攀爀攀 䴀愀椀渀开䰀愀欀攀开椀搀 㴀 ✀㄀㄀㄀㄀㄀㄀㄀㄀ⴀ㄀㄀㄀㄀ⴀ㄀㄀㄀㄀ⴀ㄀㄀㄀㄀ⴀ㄀㄀㄀㄀㄀㄀㄀㄀㄀㄀㄀㄀✀ 愀渀搀 猀椀搀攀 㴀 ㄀㘀ഀഀ
਍ⴀⴀ 氀愀欀攀 愀猀 猀漀甀爀挀攀 漀昀 爀椀瘀攀爀ഀഀ
਍ⴀⴀ ㈀⸀ 攀砀攀挀甀琀攀 甀渀椀琀 琀攀猀琀   ഀഀ
਍䔀堀䔀䌀 搀戀漀⸀猀瀀开愀猀猀椀最渀开戀漀爀搀攀爀 ✀㄀㄀㄀㄀㄀㄀㄀㄀ⴀ㄀㄀㄀㄀ⴀ㄀㄀㄀㄀ⴀ㄀㄀㄀㄀ⴀ㄀㄀㄀㄀㄀㄀㄀㄀㄀㄀㄀㄀✀ഀഀ
਍䔀一䐀 吀刀夀         ⴀⴀ 猀攀氀攀挀琀 ⨀ 昀爀漀洀 吀爀椀戀甀琀愀爀椀攀猀ഀഀ
BEGIN CATCH਍    匀䔀䰀䔀䌀吀 䔀刀刀伀刀开一唀䴀䈀䔀刀⠀⤀ 䄀匀 䔀爀爀漀爀一甀洀戀攀爀Ⰰ    䔀刀刀伀刀开匀䔀嘀䔀刀䤀吀夀⠀⤀ 䄀匀 䔀爀爀漀爀匀攀瘀攀爀椀琀礀Ⰰ 䔀刀刀伀刀开匀吀䄀吀䔀⠀⤀   䄀匀 䔀爀爀漀爀匀琀愀琀攀ഀഀ
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage਍䔀一䐀 䌀䄀吀䌀䠀ഀഀ
਍ⴀⴀ ㌀⸀ 爀攀猀甀氀琀 瘀攀爀椀昀椀挀愀琀椀漀渀ഀഀ
declare @result int = ( select count(*) from Tributaries where lat = 1 and lon = 2 )਍ഀഀ
IF  @result <> 2਍   刀䄀䤀匀䔀刀刀伀刀 ⠀✀䘀䄀䤀䰀䔀䐀㨀 ─猀 爀椀瘀攀爀 氀椀渀欀攀搀 琀漀 氀愀欀攀 栀愀猀 ㄀ 吀爀椀戀甀琀愀爀礀 ─搀 ⴀ ─搀✀Ⰰ ㄀㘀Ⰰ ⴀ㄀Ⰰ 䀀琀攀猀琀开渀愀洀攀Ⰰ 䀀爀攀猀甀氀琀 ⤀ ഀഀ
ELSE਍    瀀爀椀渀琀 ✀倀䄀匀匀䔀䐀 ✀ ⬀ 䀀琀攀猀琀开渀愀洀攀ഀഀ
਍刀伀䰀䰀䈀䄀䌀䬀 吀刀䄀一 吀攀猀琀䄀猀猀椀最渀㄀ഀഀ
GO਍ⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀഀഀ
BEGIN TRAN TestAssign1m਍    搀攀挀氀愀爀攀 䀀琀攀猀琀开渀愀洀攀 猀礀猀渀愀洀攀 㴀 ✀吀攀猀琀䄀猀猀椀最渀㄀洀 嬀猀瀀开愀猀猀椀最渀开戀漀爀搀攀爀崀 愀樀甀猀琀 氀愀琀⼀氀漀渀 昀漀爀 爀椀瘀攀爀 猀漀甀爀挀攀✀ഀഀ
BEGIN TRY  SET NOCOUNT ON;਍ഀഀ
-- 1. prepare data for unit test਍ഀഀ
insert into lake (lake_id, locType, lake_name, CGNDB) values ('00000000-0000-0000-0000-000000000000', 1, N'Lake',   'Lakes')਍椀渀猀攀爀琀 椀渀琀漀 氀愀欀攀 ⠀氀愀欀攀开椀搀Ⰰ 氀漀挀吀礀瀀攀Ⰰ 氀愀欀攀开渀愀洀攀Ⰰ 䌀䜀一䐀䈀⤀ 瘀愀氀甀攀猀 ⠀✀㄀㄀㄀㄀㄀㄀㄀㄀ⴀ㄀㄀㄀㄀ⴀ㄀㄀㄀㄀ⴀ㄀㄀㄀㄀ⴀ㄀㄀㄀㄀㄀㄀㄀㄀㄀㄀㄀㄀✀Ⰰ ㈀Ⰰ 一✀刀椀瘀攀爀✀Ⰰ  ✀刀椀瘀攀爀✀⤀ഀഀ
UPDATE Tributaries SET lake_id = '00000000-0000-0000-0000-000000000000', lat = 1, lon = 2 where Main_Lake_id = '11111111-1111-1111-1111-111111111111' and side = 32਍ഀഀ
-- lake as source of river਍ഀഀ
-- 2. execute unit test   ਍ഀഀ
EXEC dbo.sp_assign_border '11111111-1111-1111-1111-111111111111'਍ഀഀ
END TRY         -- select * from Tributaries਍䈀䔀䜀䤀一 䌀䄀吀䌀䠀ഀഀ
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState਍         Ⰰ 䀀琀攀猀琀开渀愀洀攀     䄀匀 䔀爀爀漀爀倀爀漀挀攀搀甀爀攀Ⰰ 䔀刀刀伀刀开䰀䤀一䔀⠀⤀     䄀匀 䔀爀爀漀爀䰀椀渀攀Ⰰ     䔀刀刀伀刀开䴀䔀匀匀䄀䜀䔀⠀⤀ 䄀匀 䔀爀爀漀爀䴀攀猀猀愀最攀ഀഀ
END CATCH਍ഀഀ
-- 3. result verification਍搀攀挀氀愀爀攀 䀀爀攀猀甀氀琀 椀渀琀 㴀 ⠀ 猀攀氀攀挀琀 挀漀甀渀琀⠀⨀⤀ 昀爀漀洀 吀爀椀戀甀琀愀爀椀攀猀 眀栀攀爀攀 氀愀琀 㴀 ㄀ 愀渀搀 氀漀渀 㴀 ㈀   ⤀ഀഀ
਍䤀䘀  䀀爀攀猀甀氀琀 㰀㸀 ㈀ഀഀ
   RAISERROR ('FAILED: %s river linked to lake has 1 Tributary %d - %d', 16, -1, @test_name, @result ) ਍䔀䰀匀䔀ഀഀ
    print 'PASSED ' + @test_name਍ഀഀ
ROLLBACK TRAN TestAssign1m਍䜀伀ഀഀ
----------------------------------------------------------------------------------------------------------਍䈀䔀䜀䤀一 吀刀䄀一 吀攀猀琀䄀猀猀椀最渀㈀ഀഀ
    declare @test_name sysname = 'TestAssign2 [sp_assign_border] ajust lat/lon for river source'਍䈀䔀䜀䤀一 吀刀夀  匀䔀吀 一伀䌀伀唀一吀 伀一㬀ഀഀ
਍ⴀⴀ ㄀⸀ 瀀爀攀瀀愀爀攀 搀愀琀愀 昀漀爀 甀渀椀琀 琀攀猀琀ഀഀ
਍椀渀猀攀爀琀 椀渀琀漀 氀愀欀攀 ⠀氀愀欀攀开椀搀Ⰰ 氀漀挀吀礀瀀攀Ⰰ 氀愀欀攀开渀愀洀攀Ⰰ 䌀䜀一䐀䈀⤀ 瘀愀氀甀攀猀 ⠀✀　　　　　　　　ⴀ　　　　ⴀ　　　　ⴀ　　　　ⴀ　　　　　　　　　　　　✀Ⰰ ㄀Ⰰ 一✀䰀愀欀攀✀Ⰰ   ✀䰀愀欀攀猀✀⤀ഀഀ
insert into lake (lake_id, locType, lake_name, CGNDB) values ('11111111-1111-1111-1111-111111111111', 2, N'River',  'River')਍ഀഀ
UPDATE Tributaries SET lat = 1, lon = 2 where Main_Lake_id = '11111111-1111-1111-1111-111111111111' and side = 16 and Main_Lake_id = lake_id਍ഀഀ
UPDATE Tributaries SET lake_id = '00000000-0000-0000-0000-000000000000' where Main_Lake_id = '11111111-1111-1111-1111-111111111111' and side = 16਍ഀഀ
-- lake as source of river਍ഀഀ
-- 2. execute unit test   ਍ഀഀ
EXEC dbo.sp_assign_border '11111111-1111-1111-1111-111111111111'਍ഀഀ
END TRY           -- select * from Tributaries਍䈀䔀䜀䤀一 䌀䄀吀䌀䠀ഀഀ
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState਍         Ⰰ 䀀琀攀猀琀开渀愀洀攀     䄀匀 䔀爀爀漀爀倀爀漀挀攀搀甀爀攀Ⰰ 䔀刀刀伀刀开䰀䤀一䔀⠀⤀     䄀匀 䔀爀爀漀爀䰀椀渀攀Ⰰ     䔀刀刀伀刀开䴀䔀匀匀䄀䜀䔀⠀⤀ 䄀匀 䔀爀爀漀爀䴀攀猀猀愀最攀ഀഀ
END CATCH਍ഀഀ
-- 3. result verification਍搀攀挀氀愀爀攀 䀀爀攀猀甀氀琀 椀渀琀 㴀 ⠀ 猀攀氀攀挀琀 挀漀甀渀琀⠀⨀⤀ 昀爀漀洀 吀爀椀戀甀琀愀爀椀攀猀 眀栀攀爀攀 氀愀琀 㴀 ㄀ 愀渀搀 氀漀渀 㴀 ㈀   ⤀ഀഀ
਍䤀䘀  䀀爀攀猀甀氀琀 㰀㸀 ㈀ഀഀ
   RAISERROR ('FAILED: %s river linked to lake has 1 Tributary %d - %d', 16, -1, @test_name, @result ) ਍䔀䰀匀䔀ഀഀ
    print 'PASSED ' + @test_name਍ഀഀ
ROLLBACK TRAN TestAssign2਍䜀伀ഀഀ
----------------------------------------------------------------------------------------------------------਍䈀䔀䜀䤀一 吀刀䄀一 吀攀猀琀䄀猀猀椀最渀㈀洀ഀഀ
    declare @test_name sysname = 'TestAssign2m [sp_assign_border] ajust lat/lon for river mouth'਍䈀䔀䜀䤀一 吀刀夀  匀䔀吀 一伀䌀伀唀一吀 伀一㬀ഀഀ
਍ⴀⴀ ㄀⸀ 瀀爀攀瀀愀爀攀 搀愀琀愀 昀漀爀 甀渀椀琀 琀攀猀琀ഀഀ
਍椀渀猀攀爀琀 椀渀琀漀 氀愀欀攀 ⠀氀愀欀攀开椀搀Ⰰ 氀漀挀吀礀瀀攀Ⰰ 氀愀欀攀开渀愀洀攀Ⰰ 䌀䜀一䐀䈀⤀ 瘀愀氀甀攀猀 ⠀✀　　　　　　　　ⴀ　　　　ⴀ　　　　ⴀ　　　　ⴀ　　　　　　　　　　　　✀Ⰰ ㄀Ⰰ 一✀䰀愀欀攀✀Ⰰ   ✀䰀愀欀攀猀✀⤀ഀഀ
insert into lake (lake_id, locType, lake_name, CGNDB) values ('11111111-1111-1111-1111-111111111111', 2, N'River',  'River')਍ഀഀ
UPDATE Tributaries SET lat = 1, lon = 2 where Main_Lake_id = '11111111-1111-1111-1111-111111111111' and side = 32 and Main_Lake_id = lake_id਍ഀഀ
UPDATE Tributaries SET lake_id = '00000000-0000-0000-0000-000000000000' where Main_Lake_id = '11111111-1111-1111-1111-111111111111' and side = 32਍ഀഀ
-- lake as source of river਍ഀഀ
-- 2. execute unit test   ਍ഀഀ
EXEC dbo.sp_assign_border '11111111-1111-1111-1111-111111111111'਍ഀഀ
END TRY਍䈀䔀䜀䤀一 䌀䄀吀䌀䠀ഀഀ
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState਍         Ⰰ 䀀琀攀猀琀开渀愀洀攀     䄀匀 䔀爀爀漀爀倀爀漀挀攀搀甀爀攀Ⰰ 䔀刀刀伀刀开䰀䤀一䔀⠀⤀     䄀匀 䔀爀爀漀爀䰀椀渀攀Ⰰ     䔀刀刀伀刀开䴀䔀匀匀䄀䜀䔀⠀⤀ 䄀匀 䔀爀爀漀爀䴀攀猀猀愀最攀ഀഀ
END CATCH਍ഀഀ
-- 3. result verification਍搀攀挀氀愀爀攀 䀀爀攀猀甀氀琀 椀渀琀 㴀 ⠀ 猀攀氀攀挀琀 挀漀甀渀琀⠀⨀⤀ 昀爀漀洀 吀爀椀戀甀琀愀爀椀攀猀 眀栀攀爀攀 氀愀琀 㴀 ㄀ 愀渀搀 氀漀渀 㴀 ㈀   ⤀ഀഀ
਍䤀䘀  䀀爀攀猀甀氀琀 㰀㸀 ㈀ഀഀ
   RAISERROR ('FAILED: %s river linked to lake has 1 Tributary %d - %d', 16, -1, @test_name, @result ) ਍䔀䰀匀䔀ഀഀ
    print 'PASSED ' + @test_name਍ഀഀ
ROLLBACK TRAN TestAssign2m਍䜀伀ഀഀ
----------------------------------------------------------------------------------------------------------਍䈀䔀䜀䤀一 吀刀䄀一 吀攀猀琀䄀猀猀椀最渀㌀ഀഀ
    declare @test_name sysname = 'TestAssign3 [sp_assign_border] set source for lake if set mouth for river'਍䈀䔀䜀䤀一 吀刀夀  匀䔀吀 一伀䌀伀唀一吀 伀一㬀ഀഀ
਍ⴀⴀ ㄀⸀ 瀀爀攀瀀愀爀攀 搀愀琀愀 昀漀爀 甀渀椀琀 琀攀猀琀ഀഀ
਍椀渀猀攀爀琀 椀渀琀漀 氀愀欀攀 ⠀氀愀欀攀开椀搀Ⰰ 氀漀挀吀礀瀀攀Ⰰ 氀愀欀攀开渀愀洀攀Ⰰ 䌀䜀一䐀䈀⤀ 瘀愀氀甀攀猀 ⠀✀　　　　　　　　ⴀ　　　　ⴀ　　　　ⴀ　　　　ⴀ　　　　　　　　　　　　✀Ⰰ ㄀Ⰰ 一✀䰀愀欀攀✀Ⰰ   ✀䰀愀欀攀猀✀⤀ഀഀ
insert into lake (lake_id, locType, lake_name, CGNDB) values ('11111111-1111-1111-1111-111111111111', 2, N'River',  'River')਍ഀഀ
UPDATE Tributaries SET lake_id = '00000000-0000-0000-0000-000000000000' where Main_Lake_id = '11111111-1111-1111-1111-111111111111' and side = 32਍ഀഀ
-- lake as source of river਍ഀഀ
-- 2. execute unit test   ਍ഀഀ
EXEC dbo.sp_assign_border '11111111-1111-1111-1111-111111111111'਍ഀഀ
END TRY਍䈀䔀䜀䤀一 䌀䄀吀䌀䠀ഀഀ
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState਍         Ⰰ 䀀琀攀猀琀开渀愀洀攀     䄀匀 䔀爀爀漀爀倀爀漀挀攀搀甀爀攀Ⰰ 䔀刀刀伀刀开䰀䤀一䔀⠀⤀     䄀匀 䔀爀爀漀爀䰀椀渀攀Ⰰ     䔀刀刀伀刀开䴀䔀匀匀䄀䜀䔀⠀⤀ 䄀匀 䔀爀爀漀爀䴀攀猀猀愀最攀ഀഀ
END CATCH਍ഀഀ
-- 3. result verification਍搀攀挀氀愀爀攀 䀀爀攀猀甀氀琀㄀ 椀渀琀 㴀 ⠀ 猀攀氀攀挀琀 挀漀甀渀琀⠀⨀⤀ 昀爀漀洀 吀爀椀戀甀琀愀爀椀攀猀 圀䠀䔀刀䔀 氀愀欀攀开椀搀 䤀一 ⠀✀　　　　　　　　ⴀ　　　　ⴀ　　　　ⴀ　　　　ⴀ　　　　　　　　　　　　✀Ⰰ✀㄀㄀㄀㄀㄀㄀㄀㄀ⴀ㄀㄀㄀㄀ⴀ㄀㄀㄀㄀ⴀ㄀㄀㄀㄀ⴀ㄀㄀㄀㄀㄀㄀㄀㄀㄀㄀㄀㄀✀⤀ 漀爀 洀愀椀渀开氀愀欀攀开椀搀 䤀一 ⠀✀　　　　　　　　ⴀ　　　　ⴀ　　　　ⴀ　　　　ⴀ　　　　　　　　　　　　✀Ⰰ✀㄀㄀㄀㄀㄀㄀㄀㄀ⴀ㄀㄀㄀㄀ⴀ㄀㄀㄀㄀ⴀ㄀㄀㄀㄀ⴀ㄀㄀㄀㄀㄀㄀㄀㄀㄀㄀㄀㄀✀⤀⤀ഀഀ
declare @result2 int = ( select count(*) FROM (select DISTINCT lake_id from Tributaries WHERE lake_id IN ('00000000-0000-0000-0000-000000000000','11111111-1111-1111-1111-111111111111') or main_lake_id IN ('00000000-0000-0000-0000-000000000000','11111111-1111-1111-1111-111111111111') GROUP BY lake_id HAVING count(*) = 2 )x )਍ഀഀ
IF  @result1 <> 4 OR @result2 <> 2਍   刀䄀䤀匀䔀刀刀伀刀 ⠀✀䘀䄀䤀䰀䔀䐀㨀 ─猀 爀椀瘀攀爀 氀椀渀欀攀搀 琀漀 氀愀欀攀 栀愀猀 ㄀ 吀爀椀戀甀琀愀爀礀 ─搀 ⴀ ─搀✀Ⰰ ㄀㘀Ⰰ ⴀ㄀Ⰰ 䀀琀攀猀琀开渀愀洀攀Ⰰ 䀀爀攀猀甀氀琀㄀Ⰰ 䀀爀攀猀甀氀琀㈀ ⤀ ഀഀ
ELSE਍    瀀爀椀渀琀 ✀倀䄀匀匀䔀䐀 ✀ ⬀ 䀀琀攀猀琀开渀愀洀攀ഀഀ
਍刀伀䰀䰀䈀䄀䌀䬀 吀刀䄀一 吀攀猀琀䄀猀猀椀最渀㌀ഀഀ
GO਍ⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀഀഀ
BEGIN TRAN TestAssign3s਍    搀攀挀氀愀爀攀 䀀琀攀猀琀开渀愀洀攀 猀礀猀渀愀洀攀 㴀 ✀吀攀猀琀䄀猀猀椀最渀㌀猀 嬀猀瀀开愀猀猀椀最渀开戀漀爀搀攀爀崀 猀攀琀 洀漀甀琀栀 昀漀爀 氀愀欀攀 椀昀 猀攀琀 猀漀甀爀挀攀 昀漀爀 爀椀瘀攀爀✀ഀഀ
BEGIN TRY  SET NOCOUNT ON;਍ഀഀ
-- 1. prepare data for unit test਍ഀഀ
insert into lake (lake_id, locType, lake_name, CGNDB) values ('00000000-0000-0000-0000-000000000000', 1, N'Lake',   'Lakes')਍椀渀猀攀爀琀 椀渀琀漀 氀愀欀攀 ⠀氀愀欀攀开椀搀Ⰰ 氀漀挀吀礀瀀攀Ⰰ 氀愀欀攀开渀愀洀攀Ⰰ 䌀䜀一䐀䈀⤀ 瘀愀氀甀攀猀 ⠀✀㄀㄀㄀㄀㄀㄀㄀㄀ⴀ㄀㄀㄀㄀ⴀ㄀㄀㄀㄀ⴀ㄀㄀㄀㄀ⴀ㄀㄀㄀㄀㄀㄀㄀㄀㄀㄀㄀㄀✀Ⰰ ㈀Ⰰ 一✀刀椀瘀攀爀✀Ⰰ  ✀刀椀瘀攀爀✀⤀ഀഀ
਍唀倀䐀䄀吀䔀 吀爀椀戀甀琀愀爀椀攀猀 匀䔀吀 氀愀欀攀开椀搀 㴀 ✀　　　　　　　　ⴀ　　　　ⴀ　　　　ⴀ　　　　ⴀ　　　　　　　　　　　　✀ 眀栀攀爀攀 䴀愀椀渀开䰀愀欀攀开椀搀 㴀 ✀㄀㄀㄀㄀㄀㄀㄀㄀ⴀ㄀㄀㄀㄀ⴀ㄀㄀㄀㄀ⴀ㄀㄀㄀㄀ⴀ㄀㄀㄀㄀㄀㄀㄀㄀㄀㄀㄀㄀✀ 愀渀搀 猀椀搀攀 㴀 ㄀㔀ഀഀ
਍ⴀⴀ 氀愀欀攀 愀猀 猀漀甀爀挀攀 漀昀 爀椀瘀攀爀ഀഀ
਍ⴀⴀ ㈀⸀ 攀砀攀挀甀琀攀 甀渀椀琀 琀攀猀琀   ഀഀ
਍䔀堀䔀䌀 搀戀漀⸀猀瀀开愀猀猀椀最渀开戀漀爀搀攀爀 ✀㄀㄀㄀㄀㄀㄀㄀㄀ⴀ㄀㄀㄀㄀ⴀ㄀㄀㄀㄀ⴀ㄀㄀㄀㄀ⴀ㄀㄀㄀㄀㄀㄀㄀㄀㄀㄀㄀㄀✀ഀഀ
਍䔀一䐀 吀刀夀ഀഀ
BEGIN CATCH਍    匀䔀䰀䔀䌀吀 䔀刀刀伀刀开一唀䴀䈀䔀刀⠀⤀ 䄀匀 䔀爀爀漀爀一甀洀戀攀爀Ⰰ    䔀刀刀伀刀开匀䔀嘀䔀刀䤀吀夀⠀⤀ 䄀匀 䔀爀爀漀爀匀攀瘀攀爀椀琀礀Ⰰ 䔀刀刀伀刀开匀吀䄀吀䔀⠀⤀   䄀匀 䔀爀爀漀爀匀琀愀琀攀ഀഀ
         , @test_name     AS ErrorProcedure, ERROR_LINE()     AS ErrorLine,     ERROR_MESSAGE() AS ErrorMessage਍䔀一䐀 䌀䄀吀䌀䠀ഀഀ
਍ⴀⴀ ㌀⸀ 爀攀猀甀氀琀 瘀攀爀椀昀椀挀愀琀椀漀渀ഀഀ
declare @result1 int = ( select count(*) from Tributaries WHERE lake_id IN ('00000000-0000-0000-0000-000000000000','11111111-1111-1111-1111-111111111111') or main_lake_id IN ('00000000-0000-0000-0000-000000000000','11111111-1111-1111-1111-111111111111'))਍搀攀挀氀愀爀攀 䀀爀攀猀甀氀琀㈀ 椀渀琀 㴀 ⠀ 猀攀氀攀挀琀 挀漀甀渀琀⠀⨀⤀ 䘀刀伀䴀 ⠀猀攀氀攀挀琀 䐀䤀匀吀䤀一䌀吀 氀愀欀攀开椀搀 昀爀漀洀 吀爀椀戀甀琀愀爀椀攀猀 圀䠀䔀刀䔀 氀愀欀攀开椀搀 䤀一 ⠀✀　　　　　　　　ⴀ　　　　ⴀ　　　　ⴀ　　　　ⴀ　　　　　　　　　　　　✀Ⰰ✀㄀㄀㄀㄀㄀㄀㄀㄀ⴀ㄀㄀㄀㄀ⴀ㄀㄀㄀㄀ⴀ㄀㄀㄀㄀ⴀ㄀㄀㄀㄀㄀㄀㄀㄀㄀㄀㄀㄀✀⤀ 漀爀 洀愀椀渀开氀愀欀攀开椀搀 䤀一 ⠀✀　　　　　　　　ⴀ　　　　ⴀ　　　　ⴀ　　　　ⴀ　　　　　　　　　　　　✀Ⰰ✀㄀㄀㄀㄀㄀㄀㄀㄀ⴀ㄀㄀㄀㄀ⴀ㄀㄀㄀㄀ⴀ㄀㄀㄀㄀ⴀ㄀㄀㄀㄀㄀㄀㄀㄀㄀㄀㄀㄀✀⤀ 䜀刀伀唀倀 䈀夀 氀愀欀攀开椀搀 䠀䄀嘀䤀一䜀 挀漀甀渀琀⠀⨀⤀ 㴀 ㈀ ⤀砀 ⤀ഀഀ
਍䤀䘀  䀀爀攀猀甀氀琀㄀ 㰀㸀 㐀 伀刀 䀀爀攀猀甀氀琀㈀ 㰀㸀 ㈀ഀഀ
   RAISERROR ('FAILED: %s river linked to lake has 1 Tributary %d - %d', 16, -1, @test_name, @result1, @result2 ) ਍䔀䰀匀䔀ഀഀ
    print 'PASSED ' + @test_name਍ഀഀ
ROLLBACK TRAN TestAssign3s਍䜀伀ഀഀ
----------------------------------------------------------------------------------------------------------਍䈀䔀䜀䤀一 吀刀䄀一 吀攀猀琀䄀猀猀椀最渀㌀猀ഀഀ
    declare @test_name sysname = 'TestAssign3s [sp_assign_border] set trow for lake if set source for river'਍䈀䔀䜀䤀一 吀刀夀  匀䔀吀 一伀䌀伀唀一吀 伀一㬀ഀഀ
਍ⴀⴀ ㄀⸀ 瀀爀攀瀀愀爀攀 搀愀琀愀 昀漀爀 甀渀椀琀 琀攀猀琀ഀഀ
਍椀渀猀攀爀琀 椀渀琀漀 氀愀欀攀 ⠀氀愀欀攀开椀搀Ⰰ 氀漀挀吀礀瀀攀Ⰰ 氀愀欀攀开渀愀洀攀Ⰰ 䌀䜀一䐀䈀⤀ 瘀愀氀甀攀猀 ⠀✀　　　　　　　　ⴀ　　　　ⴀ　　　　ⴀ　　　　ⴀ　　　　　　　　　　　　✀Ⰰ ㄀Ⰰ 一✀䰀愀欀攀✀Ⰰ   ✀䰀愀欀攀猀✀⤀ഀഀ
insert into lake (lake_id, locType, lake_name, CGNDB) values ('11111111-1111-1111-1111-111111111111', 2, N'River',  'River')਍ഀഀ
UPDATE Tributaries SET lake_id = '00000000-0000-0000-0000-000000000000' where Main_Lake_id = '11111111-1111-1111-1111-111111111111' and side = 15਍ഀഀ
-- lake as source of river਍ഀഀ
-- 2. execute unit test   ਍ഀഀ
EXEC dbo.sp_assign_border '11111111-1111-1111-1111-111111111111'਍ഀഀ
END TRY਍䈀䔀䜀䤀一 䌀䄀吀䌀䠀ഀഀ
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState਍         Ⰰ 䀀琀攀猀琀开渀愀洀攀     䄀匀 䔀爀爀漀爀倀爀漀挀攀搀甀爀攀Ⰰ 䔀刀刀伀刀开䰀䤀一䔀⠀⤀     䄀匀 䔀爀爀漀爀䰀椀渀攀Ⰰ     䔀刀刀伀刀开䴀䔀匀匀䄀䜀䔀⠀⤀ 䄀匀 䔀爀爀漀爀䴀攀猀猀愀最攀ഀഀ
END CATCH਍ഀഀ
-- 3. result verification਍搀攀挀氀愀爀攀 䀀爀攀猀甀氀琀㄀ 椀渀琀 㴀 ⠀ 猀攀氀攀挀琀 挀漀甀渀琀⠀⨀⤀ 昀爀漀洀 吀爀椀戀甀琀愀爀椀攀猀 圀䠀䔀刀䔀 氀愀欀攀开椀搀 䤀一 ⠀✀　　　　　　　　ⴀ　　　　ⴀ　　　　ⴀ　　　　ⴀ　　　　　　　　　　　　✀Ⰰ✀㄀㄀㄀㄀㄀㄀㄀㄀ⴀ㄀㄀㄀㄀ⴀ㄀㄀㄀㄀ⴀ㄀㄀㄀㄀ⴀ㄀㄀㄀㄀㄀㄀㄀㄀㄀㄀㄀㄀✀⤀ 漀爀 洀愀椀渀开氀愀欀攀开椀搀 䤀一 ⠀✀　　　　　　　　ⴀ　　　　ⴀ　　　　ⴀ　　　　ⴀ　　　　　　　　　　　　✀Ⰰ✀㄀㄀㄀㄀㄀㄀㄀㄀ⴀ㄀㄀㄀㄀ⴀ㄀㄀㄀㄀ⴀ㄀㄀㄀㄀ⴀ㄀㄀㄀㄀㄀㄀㄀㄀㄀㄀㄀㄀✀⤀⤀ഀഀ
declare @result2 int = ( select count(*) FROM (select DISTINCT lake_id from Tributaries WHERE lake_id IN ('00000000-0000-0000-0000-000000000000','11111111-1111-1111-1111-111111111111') or main_lake_id IN ('00000000-0000-0000-0000-000000000000','11111111-1111-1111-1111-111111111111') GROUP BY lake_id HAVING count(*) = 2 )x )਍ഀഀ
IF  @result1 <> 4 OR @result2 <> 2਍   刀䄀䤀匀䔀刀刀伀刀 ⠀✀䘀䄀䤀䰀䔀䐀㨀 ─猀 爀椀瘀攀爀 氀椀渀欀攀搀 琀漀 氀愀欀攀 栀愀猀 ㄀ 吀爀椀戀甀琀愀爀礀 ─搀 ⴀ ─搀✀Ⰰ ㄀㘀Ⰰ ⴀ㄀Ⰰ 䀀琀攀猀琀开渀愀洀攀Ⰰ 䀀爀攀猀甀氀琀㄀Ⰰ 䀀爀攀猀甀氀琀㈀ ⤀ ഀഀ
ELSE਍    瀀爀椀渀琀 ✀倀䄀匀匀䔀䐀 ✀ ⬀ 䀀琀攀猀琀开渀愀洀攀ഀഀ
਍刀伀䰀䰀䈀䄀䌀䬀 吀刀䄀一 吀攀猀琀䄀猀猀椀最渀㌀猀ഀഀ
GO਍ⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀഀഀ
BEGIN TRAN TestElev4src਍    搀攀挀氀愀爀攀 䀀琀攀猀琀开渀愀洀攀 猀礀猀渀愀洀攀 㴀 ✀吀攀猀琀䔀氀攀瘀㐀猀爀挀 嬀吀刀开唀倀䐀开吀爀椀戀甀琀愀爀椀攀猀崀 猀攀琀 攀氀攀瘀攀琀椀漀渀 昀漀爀 洀漀琀栀 漀昀 氀愀欀攀 猀栀漀甀氀搀 猀攀琀 琀栀攀 猀愀洀攀 攀氀攀瘀愀琀椀漀渀 昀漀爀 猀漀甀爀挀攀✀ഀഀ
BEGIN TRY  SET NOCOUNT ON;਍ഀഀ
-- 1. prepare data for unit test਍ഀഀ
insert into lake (lake_id, locType, lake_name, CGNDB) values ('00000000-0000-0000-0000-000000000000', 1, N'Lake',   'Lakes')਍ഀഀ
-- 2. execute unit test   ਍ഀഀ
UPDATE Tributaries SET elevation = 111 where Main_Lake_id = '00000000-0000-0000-0000-000000000000' and side = 16਍ഀഀ
END TRY਍䈀䔀䜀䤀一 䌀䄀吀䌀䠀ഀഀ
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState਍         Ⰰ 䀀琀攀猀琀开渀愀洀攀     䄀匀 䔀爀爀漀爀倀爀漀挀攀搀甀爀攀Ⰰ 䔀刀刀伀刀开䰀䤀一䔀⠀⤀     䄀匀 䔀爀爀漀爀䰀椀渀攀Ⰰ     䔀刀刀伀刀开䴀䔀匀匀䄀䜀䔀⠀⤀ 䄀匀 䔀爀爀漀爀䴀攀猀猀愀最攀ഀഀ
END CATCH਍ഀഀ
-- 3. result verification਍搀攀挀氀愀爀攀 䀀爀攀猀甀氀琀㄀ 椀渀琀 㴀 ⠀ 猀攀氀攀挀琀 挀漀甀渀琀⠀⨀⤀ 昀爀漀洀 吀爀椀戀甀琀愀爀椀攀猀 圀䠀䔀刀䔀 䴀愀椀渀开䰀愀欀攀开椀搀 㴀 ✀　　　　　　　　ⴀ　　　　ⴀ　　　　ⴀ　　　　ⴀ　　　　　　　　　　　　✀ ⤀ഀഀ
declare @result2 int = ( select elevation FROM Tributaries WHERE Main_Lake_id = '00000000-0000-0000-0000-000000000000'and side = 32 )਍ഀഀ
IF  @result1 <> 2 OR @result2 <> 111਍   刀䄀䤀匀䔀刀刀伀刀 ⠀✀䘀䄀䤀䰀䔀䐀㨀 ─猀 猀栀漀甀氀搀 戀攀 琀栀攀 猀愀洀攀 攀氀攀瘀愀琀椀漀渀 ─搀 ⴀ ─搀✀Ⰰ ㄀㘀Ⰰ ⴀ㄀Ⰰ 䀀琀攀猀琀开渀愀洀攀Ⰰ 䀀爀攀猀甀氀琀㄀Ⰰ 䀀爀攀猀甀氀琀㈀ ⤀ ഀഀ
ELSE਍    瀀爀椀渀琀 ✀倀䄀匀匀䔀䐀 ✀ ⬀ 䀀琀攀猀琀开渀愀洀攀ഀഀ
਍刀伀䰀䰀䈀䄀䌀䬀 吀刀䄀一 吀攀猀琀䔀氀攀瘀㐀猀爀挀ഀഀ
GO਍ⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀഀഀ
BEGIN TRAN TestElev4mth਍    搀攀挀氀愀爀攀 䀀琀攀猀琀开渀愀洀攀 猀礀猀渀愀洀攀 㴀 ✀吀攀猀琀䔀氀攀瘀㐀洀琀栀 嬀吀刀开唀倀䐀开吀爀椀戀甀琀愀爀椀攀猀崀 猀攀琀 攀氀攀瘀攀琀椀漀渀 昀漀爀 洀漀琀栀 漀昀 氀愀欀攀 猀栀漀甀氀搀 猀攀琀 琀栀攀 猀愀洀攀 攀氀攀瘀愀琀椀漀渀 昀漀爀 猀漀甀爀挀攀✀ഀഀ
BEGIN TRY  SET NOCOUNT ON;਍ഀഀ
-- 1. prepare data for unit test਍ഀഀ
insert into lake (lake_id, locType, lake_name, CGNDB) values ('00000000-0000-0000-0000-000000000000', 1, N'Lake',   'Lakes')਍ഀഀ
-- 2. execute unit test   ਍ഀഀ
UPDATE Tributaries SET elevation = 111 where Main_Lake_id = '00000000-0000-0000-0000-000000000000' and side = 32਍ഀഀ
END TRY਍䈀䔀䜀䤀一 䌀䄀吀䌀䠀ഀഀ
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState਍         Ⰰ 䀀琀攀猀琀开渀愀洀攀     䄀匀 䔀爀爀漀爀倀爀漀挀攀搀甀爀攀Ⰰ 䔀刀刀伀刀开䰀䤀一䔀⠀⤀     䄀匀 䔀爀爀漀爀䰀椀渀攀Ⰰ     䔀刀刀伀刀开䴀䔀匀匀䄀䜀䔀⠀⤀ 䄀匀 䔀爀爀漀爀䴀攀猀猀愀最攀ഀഀ
END CATCH਍ഀഀ
-- 3. result verification਍搀攀挀氀愀爀攀 䀀爀攀猀甀氀琀㄀ 椀渀琀 㴀 ⠀ 猀攀氀攀挀琀 挀漀甀渀琀⠀⨀⤀ 昀爀漀洀 吀爀椀戀甀琀愀爀椀攀猀 圀䠀䔀刀䔀 䴀愀椀渀开䰀愀欀攀开椀搀 㴀 ✀　　　　　　　　ⴀ　　　　ⴀ　　　　ⴀ　　　　ⴀ　　　　　　　　　　　　✀⤀ഀഀ
declare @result2 int = ( select elevation FROM Tributaries WHERE Main_Lake_id = '00000000-0000-0000-0000-000000000000'and side = 16 )਍ഀഀ
IF  @result1 <> 2 OR @result2 <> 111਍   刀䄀䤀匀䔀刀刀伀刀 ⠀✀䘀䄀䤀䰀䔀䐀㨀 ─猀 猀栀漀甀氀搀 戀攀 琀栀攀 猀愀洀攀 攀氀攀瘀愀琀椀漀渀 ─搀 ⴀ ─搀✀Ⰰ ㄀㘀Ⰰ ⴀ㄀Ⰰ 䀀琀攀猀琀开渀愀洀攀Ⰰ 䀀爀攀猀甀氀琀㄀Ⰰ 䀀爀攀猀甀氀琀㈀ ⤀ ഀഀ
ELSE਍    瀀爀椀渀琀 ✀倀䄀匀匀䔀䐀 ✀ ⬀ 䀀琀攀猀琀开渀愀洀攀ഀഀ
਍刀伀䰀䰀䈀䄀䌀䬀 吀刀䄀一 吀攀猀琀䔀氀攀瘀㐀洀琀栀ഀഀ
GO਍ⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀഀഀ
BEGIN TRAN TestElevFailed਍    搀攀挀氀愀爀攀 䀀琀攀猀琀开渀愀洀攀 猀礀猀渀愀洀攀 㴀 ✀吀攀猀琀䔀氀攀瘀䘀愀椀氀攀搀 嬀吀刀开唀倀䐀开吀爀椀戀甀琀愀爀椀攀猀崀 猀攀琀 攀氀攀瘀攀琀椀漀渀 昀漀爀 洀漀琀栀 漀昀 爀椀瘀攀爀 猀栀漀甀氀搀 渀漀琀 猀攀琀 琀栀攀 猀愀洀攀 攀氀攀瘀愀琀椀漀渀 昀漀爀 猀漀甀爀挀攀✀ഀഀ
BEGIN TRY  SET NOCOUNT ON;਍ഀഀ
-- 1. prepare data for unit test਍ഀഀ
insert into lake (lake_id, locType, lake_name, CGNDB) values ('00000000-0000-0000-0000-000000000000', 2, N'River',   'RVSN')਍ഀഀ
-- 2. execute unit test   ਍ഀഀ
UPDATE Tributaries SET elevation = 111 where Main_Lake_id = '00000000-0000-0000-0000-000000000000' and side = 32਍ഀഀ
END TRY਍䈀䔀䜀䤀一 䌀䄀吀䌀䠀ഀഀ
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState਍         Ⰰ 䀀琀攀猀琀开渀愀洀攀     䄀匀 䔀爀爀漀爀倀爀漀挀攀搀甀爀攀Ⰰ 䔀刀刀伀刀开䰀䤀一䔀⠀⤀     䄀匀 䔀爀爀漀爀䰀椀渀攀Ⰰ     䔀刀刀伀刀开䴀䔀匀匀䄀䜀䔀⠀⤀ 䄀匀 䔀爀爀漀爀䴀攀猀猀愀最攀ഀഀ
END CATCH਍ഀഀ
-- 3. result verification਍搀攀挀氀愀爀攀 䀀爀攀猀甀氀琀㄀ 椀渀琀 㴀 ⠀ 猀攀氀攀挀琀 挀漀甀渀琀⠀⨀⤀ 昀爀漀洀 吀爀椀戀甀琀愀爀椀攀猀 圀䠀䔀刀䔀 䴀愀椀渀开䰀愀欀攀开椀搀 㴀 ✀　　　　　　　　ⴀ　　　　ⴀ　　　　ⴀ　　　　ⴀ　　　　　　　　　　　　✀⤀ഀഀ
declare @result2 int = ( select elevation FROM Tributaries WHERE Main_Lake_id = '00000000-0000-0000-0000-000000000000'and side = 16 )਍ഀഀ
IF  @result1 <> 2 OR @result2 Is NOT NULL਍   刀䄀䤀匀䔀刀刀伀刀 ⠀✀䘀䄀䤀䰀䔀䐀㨀 ─猀 猀栀漀甀氀搀 渀漀琀 戀攀 琀栀攀 猀愀洀攀 攀氀攀瘀愀琀椀漀渀 ─搀 ⴀ ─搀✀Ⰰ ㄀㘀Ⰰ ⴀ㄀Ⰰ 䀀琀攀猀琀开渀愀洀攀Ⰰ 䀀爀攀猀甀氀琀㄀Ⰰ 䀀爀攀猀甀氀琀㈀ ⤀ ഀഀ
ELSE਍    瀀爀椀渀琀 ✀倀䄀匀匀䔀䐀 ✀ ⬀ 䀀琀攀猀琀开渀愀洀攀ഀഀ
਍刀伀䰀䰀䈀䄀䌀䬀 吀刀䄀一 吀攀猀琀䔀氀攀瘀䘀愀椀氀攀搀ഀഀ
GO਍ⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀഀഀ
BEGIN TRAN TestAssign3t਍    搀攀挀氀愀爀攀 䀀琀攀猀琀开渀愀洀攀 猀礀猀渀愀洀攀 㴀 ✀吀攀猀琀䄀猀猀椀最渀㌀琀 嬀猀瀀开愀猀猀椀最渀开戀漀爀搀攀爀崀 䰀愀欀攀 攀氀攀瘀攀愀琀椀漀渀 猀栀漀甀氀搀 最漀 琀漀 爀椀瘀攀爀 洀漀甀琀栀✀ഀഀ
BEGIN TRY  SET NOCOUNT ON;਍ഀഀ
-- 1. prepare data for unit test਍ഀഀ
insert into lake (lake_id, locType, lake_name, CGNDB) values ('00000000-0000-0000-0000-000000000000', 1, N'Lake',   'Lakes')਍椀渀猀攀爀琀 椀渀琀漀 氀愀欀攀 ⠀氀愀欀攀开椀搀Ⰰ 氀漀挀吀礀瀀攀Ⰰ 氀愀欀攀开渀愀洀攀Ⰰ 䌀䜀一䐀䈀⤀ 瘀愀氀甀攀猀 ⠀✀㄀㄀㄀㄀㄀㄀㄀㄀ⴀ㄀㄀㄀㄀ⴀ㄀㄀㄀㄀ⴀ㄀㄀㄀㄀ⴀ㄀㄀㄀㄀㄀㄀㄀㄀㄀㄀㄀㄀✀Ⰰ ㈀Ⰰ 一✀刀椀瘀攀爀✀Ⰰ  ✀刀椀瘀攀爀✀⤀ഀഀ
਍唀倀䐀䄀吀䔀 吀爀椀戀甀琀愀爀椀攀猀 匀䔀吀 䰀愀欀攀开椀搀 㴀 ✀　　　　　　　　ⴀ　　　　ⴀ　　　　ⴀ　　　　ⴀ　　　　　　　　　　　　✀ 眀栀攀爀攀 䰀愀欀攀开椀搀 㴀 ✀㄀㄀㄀㄀㄀㄀㄀㄀ⴀ㄀㄀㄀㄀ⴀ㄀㄀㄀㄀ⴀ㄀㄀㄀㄀ⴀ㄀㄀㄀㄀㄀㄀㄀㄀㄀㄀㄀㄀✀ 愀渀搀 猀椀搀攀 㴀 ㄀㘀ഀഀ
UPDATE Tributaries SET Lake_id = '11111111-1111-1111-1111-111111111111' where Lake_id = '00000000-0000-0000-0000-000000000000' and side = 32਍ഀഀ
-- lake as source of river਍ഀഀ
-- 2. execute unit test   ਍ഀഀ
UPDATE Tributaries SET zone = 8 where Main_Lake_id = '00000000-0000-0000-0000-000000000000' and side = 32਍ഀഀ
END TRY਍䈀䔀䜀䤀一 䌀䄀吀䌀䠀ഀഀ
    SELECT ERROR_NUMBER() AS ErrorNumber,    ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()   AS ErrorState਍         Ⰰ 䀀琀攀猀琀开渀愀洀攀     䄀匀 䔀爀爀漀爀倀爀漀挀攀搀甀爀攀Ⰰ 䔀刀刀伀刀开䰀䤀一䔀⠀⤀     䄀匀 䔀爀爀漀爀䰀椀渀攀Ⰰ     䔀刀刀伀刀开䴀䔀匀匀䄀䜀䔀⠀⤀ 䄀匀 䔀爀爀漀爀䴀攀猀猀愀最攀ഀഀ
END CATCH਍ഀഀ
-- 3. result verification਍搀攀挀氀愀爀攀 䀀爀攀猀甀氀琀㄀ 椀渀琀 㴀 ⠀ 猀攀氀攀挀琀 挀漀甀渀琀⠀⨀⤀ 昀爀漀洀 吀爀椀戀甀琀愀爀椀攀猀 圀䠀䔀刀䔀 氀愀欀攀开椀搀 䤀一 ⠀✀　　　　　　　　ⴀ　　　　ⴀ　　　　ⴀ　　　　ⴀ　　　　　　　　　　　　✀Ⰰ✀㄀㄀㄀㄀㄀㄀㄀㄀ⴀ㄀㄀㄀㄀ⴀ㄀㄀㄀㄀ⴀ㄀㄀㄀㄀ⴀ㄀㄀㄀㄀㄀㄀㄀㄀㄀㄀㄀㄀✀⤀ 漀爀 洀愀椀渀开氀愀欀攀开椀搀 䤀一 ⠀✀　　　　　　　　ⴀ　　　　ⴀ　　　　ⴀ　　　　ⴀ　　　　　　　　　　　　✀Ⰰ✀㄀㄀㄀㄀㄀㄀㄀㄀ⴀ㄀㄀㄀㄀ⴀ㄀㄀㄀㄀ⴀ㄀㄀㄀㄀ⴀ㄀㄀㄀㄀㄀㄀㄀㄀㄀㄀㄀㄀✀⤀  ⤀ഀഀ
declare @result2 int = ( select zone FROM Tributaries WHERE Main_Lake_id = '11111111-1111-1111-1111-111111111111'and side = 16 )਍ഀഀ
IF  @result1 <> 4 OR @result2 <> 8਍   刀䄀䤀匀䔀刀刀伀刀 ⠀✀䘀䄀䤀䰀䔀䐀㨀 ─猀 爀椀瘀攀爀 氀椀渀欀攀搀 琀漀 氀愀欀攀 栀愀猀 ㄀ 吀爀椀戀甀琀愀爀礀 ─搀 ⴀ ─搀✀Ⰰ ㄀㘀Ⰰ ⴀ㄀Ⰰ 䀀琀攀猀琀开渀愀洀攀Ⰰ 䀀爀攀猀甀氀琀㄀Ⰰ 䀀爀攀猀甀氀琀㈀ ⤀ ഀഀ
ELSE਍    瀀爀椀渀琀 ✀倀䄀匀匀䔀䐀 ✀ ⬀ 䀀琀攀猀琀开渀愀洀攀ഀഀ
਍刀伀䰀䰀䈀䄀䌀䬀 吀刀䄀一 吀攀猀琀䄀猀猀椀最渀㌀琀ഀഀ
GO਍ⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀഀഀ
PRINT '--------------------------------------------------------------------------------------------------' ਍ⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀⴀഀഀ
--- select * from lake਍ⴀⴀ  猀攀氀攀挀琀 ⨀ 昀爀漀洀 吀爀椀戀甀琀愀爀椀攀猀  眀栀攀爀攀 洀愀椀渀开氀愀欀攀开椀搀 㴀 ✀　　　　　　　　ⴀ　　　　ⴀ　　　　ⴀ　　　　ⴀ　　　　　　　　　　　　✀ഀഀ
--  select * from Tributaries  where main_lake_id = '11111111-1111-1111-1111-111111111111'਍ⴀⴀ  猀攀氀攀挀琀 ⨀ 昀爀漀洀 昀渀开嘀椀攀眀吀爀椀戀甀琀愀爀礀⠀✀㄀㄀㄀㄀㄀㄀㄀㄀ⴀ㄀㄀㄀㄀ⴀ㄀㄀㄀㄀ⴀ㄀㄀㄀㄀ⴀ㄀㄀㄀㄀㄀㄀㄀㄀㄀㄀㄀㄀✀⤀ ഀഀ
--  select * from fn_ViewTributary('00000000-0000-0000-0000-000000000000') ਍ⴀⴀ  猀攀氀攀挀琀 ⨀ 昀爀漀洀 昀渀开䔀搀椀琀吀爀椀戀甀琀愀爀礀⠀✀　　　　　　　　ⴀ　　　　ⴀ　　　　ⴀ　　　　ⴀ　　　　　　　　　　　　✀⤀ ഀഀ
--  select * from fn_EditTributary('11111111-1111-1111-1111-111111111111') ਍ⴀⴀ  猀攀氀攀挀琀 ⨀ 昀爀漀洀 吀爀椀戀甀琀愀爀椀攀猀 ഀഀ
਍ⴀⴀⴀ 搀攀氀攀琀攀 昀爀漀洀 吀爀椀戀甀琀愀爀椀攀猀㬀搀攀氀攀琀攀 昀爀漀洀 氀愀欀攀ഀഀ
਍ⴀⴀ 猀攀氀攀挀琀 ⨀ 䘀刀伀䴀 吀爀椀戀甀琀愀爀椀攀猀 圀䠀䔀刀䔀 氀愀欀攀开椀搀 䤀一 ⠀✀　　　　　　　　ⴀ　　　　ⴀ　　　　ⴀ　　　　ⴀ　　　　　　　　　　　　✀Ⰰ✀㄀㄀㄀㄀㄀㄀㄀㄀ⴀ㄀㄀㄀㄀ⴀ㄀㄀㄀㄀ⴀ㄀㄀㄀㄀ⴀ㄀㄀㄀㄀㄀㄀㄀㄀㄀㄀㄀㄀✀⤀ 漀爀 洀愀椀渀开氀愀欀攀开椀搀 䤀一 ⠀✀　　　　　　　　ⴀ　　　　ⴀ　　　　ⴀ　　　　ⴀ　　　　　　　　　　　　✀Ⰰ✀㄀㄀㄀㄀㄀㄀㄀㄀ⴀ㄀㄀㄀㄀ⴀ㄀㄀㄀㄀ⴀ㄀㄀㄀㄀ⴀ㄀㄀㄀㄀㄀㄀㄀㄀㄀㄀㄀㄀✀⤀ 㬀ഀഀ
-- delete from Tributaries WHERE lake_id IN ('00000000-0000-0000-0000-000000000000','11111111-1111-1111-1111-111111111111') or main_lake_id IN ('00000000-0000-0000-0000-000000000000','11111111-1111-1111-1111-111111111111') ;਍ⴀⴀ 搀攀氀攀琀攀 昀爀漀洀 氀愀欀攀 眀栀攀爀攀 氀愀欀攀开椀搀 䤀一 ⠀✀　　　　　　　　ⴀ　　　　ⴀ　　　　ⴀ　　　　ⴀ　　　　　　　　　　　　✀Ⰰ✀㄀㄀㄀㄀㄀㄀㄀㄀ⴀ㄀㄀㄀㄀ⴀ㄀㄀㄀㄀ⴀ㄀㄀㄀㄀ⴀ㄀㄀㄀㄀㄀㄀㄀㄀㄀㄀㄀㄀✀⤀ 㬀ഀഀ
