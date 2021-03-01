SET back=%CD%

rem ---------- read  connection.ini                 ------------

for /f "tokens=1,2 delims==" %%a in (config.ini) do (
if %%a==server     set server=%%b
if %%a==sqlcmd     set sqlcmd=%%b
if %%a==engine     set engine=%%b
if %%a==pathengine set pathengine=%%b
if %%a==script     set script=%%b
if %%a==dbmaker    set dbmaker=%%b
) 

if exist %script% del %script% > nul
if exist scriptdb.sql del scriptdb.sql > nul
if exist dbname.ini del dbname.ini > nul

cd ..

call generate_db_script_ffi2.cmd 

copy /Y %script% %back%\%script%

cd %back%

python replacedb.py 

if exist ffi2.sql del ffi2.sql > nul

cd ..
call dbcreator.cmd  %back%\scriptdb.sql

if exist scriptdb.sql del scriptdb.sql > nul

@echo %dbname% 

cd %back%

rem ------------------------------

if exist %script% del %script% > nul
if exist scriptdb.sql del scriptdb.sql > nul

rem ---------- read  dbname.ini                               ------------

for /f "tokens=1,2 delims==" %%a in (dbname.ini) do (
if %%a==dbname set dbname=%%b
@echo %dbname% 
)

call autorunlocal.bat %dbname% 

call %sqlcmd% -S %server%  -E -Q  "DECLARE @sql sysname = N'DROP DATABASE [%dbname%]';EXEC SP_EXECUTESQL @sql"

if exist dbname.ini del dbname.ini > nul
if exist final.txt del final.txt > nul
if exist result.txt del result.txt > nul
