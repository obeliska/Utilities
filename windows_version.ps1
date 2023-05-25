#################################################################################
#
# Displays Windows product name, bit level, version and build details on one
# line, prefixed with the current date and time.
#
# Parameter:
#    "nostamp"
#       Do not output timestamp prefix.
#
################################################################################

param (
	[string] $option
)

$KEY = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion"

# Get product name and bit level from the WMI class.
$name = (Get-WmiObject Win32_OperatingSystem).Caption
$bit = (Get-WmiObject Win32_OperatingSystem).OSArchitecture

# Get version, build and update level from the registry.
$ver = (Get-ItemProperty $KEY).DisplayVersion
$build = (Get-ItemProperty $KEY).CurrentBuild
$ubr = (Get-ItemProperty $KEY).UBR

if ($option -eq "nostamp") {
   $timestamp = ""
} else {
   $timestamp = get-date -format "yyyy-MM-dd HH:mm:ss  "
}

"{0}{1} {2}, version {3}, build {4}.{5}" -f $timestamp, $name, $bit, $ver, $build, $ubr
