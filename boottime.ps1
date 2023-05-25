#
# Displays the current system's boot time and uptime.
#
# Vastly simpler than the original VBscript approach due to Powershell's 
# TimeSpan.
#
$boottime = (Get-CimInstance -ClassName Win32_OperatingSystem).LastBootUpTime
$uptime = (Get-Date) - $boottime
$uptimeTime = "{0:%d\ hh\:mm\:ss}" -f $uptime
$uptimeHours = $uptime.TotalHours.ToString("0.##")
"`n$ENV:ComputerName" + 
	" booted: " + $boottime.ToString("d MMM yyyy HH:mm:ss") + 
	"  uptime: " + $uptimeTime + 
	" (" + $uptimeHours + " hours)"
