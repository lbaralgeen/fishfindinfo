========================================================================
    Windows .NET Service : Weather Notification Servce
========================================================================

Service once a day connect to CORE servce, retrive full list of observation points and update current weather data from wunderground
http://fishfind.info

Written on C# with using JSON format and MSSQL connection
========================================================================
Installation
========================================================================
To register the service:

1. Copy OWMService.exe to "c:\Program Files\FishFind\WeatherService". 

2. Update the following system registry key by runing file: OWMService.reg 

3. Run sql script on local MSSQl server: OWMService.sql 

4. Reboot machine
