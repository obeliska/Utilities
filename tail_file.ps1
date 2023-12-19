################################################################################
#
# Displays the last few lines of a file, optionally showing additional lines as
# they are written.
#
# Parameters:
#    file: path to file
#    lines: number of lines to display, defaults to 20
#    follow: if specified, continuously follows updates to the file 
#
################################################################################

param(
   [Parameter(Mandatory=$true)][string] $file,
   $lines = 20,
   $follow = ""
)

if ($follow -eq "follow") {
   $qual = "-Wait"
} else {
   $qual = ""
}

Write-Host -ForegroundColor yellow "File: $file`n"
Get-Content $file -Tail $lines $qual
