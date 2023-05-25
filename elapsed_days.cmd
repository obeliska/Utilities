@setlocal EnableDelayedExpansion
@prompt $s

::
:: Get elapsed days between two dates in DD/MM/YYYY format.
:: Credit: Antonio Perez Ayala aka Aacini
:: See: https://stackoverflow.com/questions/51082845/calculate-a-duration-between-two-dates-dd-mm-yyyy-hhmmss-in-batch-file
::
:: Parameters:
::    %1 - Start date.
::    %2 - End date.
::    %3 - Optional name of variable to return the elapsed days. If omitted, the
::         value will be displayed.
::

:: Define the magic conversion "function" for Julian Day Number.
@set "DateToJDN(Date)=( a=1Date, y=a%%10000, a/=10000, m=a%%100, d=a/100-100, a=(m-14)/12, (1461*(y+4800+a))/4+(367*(m-2-12*a))/12-(3*((y+4900+a)/100))/4+d-32075 )"

@set date1=%~1
@set date2=%~2

@set /a "days=!DateToJDN(Date):Date=%date2:/=%! - !DateToJDN(Date):Date=%date1:/=%!"
@if "%3" == "" echo %date1% to %date2% is %days% days
@endlocal & if "%3" neq "" set "%3=%days%"
