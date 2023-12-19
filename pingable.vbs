' Exits with 0 if host is able to be pinged, otherwise 1.
' This is better than using ping and catering for "host unreachable"
' or "request timed out".

If WScript.Arguments.Count = 0 Then Call Usage

host = WScript.Arguments(0)
If WScript.Arguments.Count = 2 Then
   verbose = WScript.Arguments(1) = "verbose"
Else
   verbose = False
End If

Set objWMIService = GetObject("winmgmts:\\.\root\cimv2")
Set colItems = objWMIService.ExecQuery("Select * from Win32_PingStatus Where Address = '" & host & "'")
For Each objItem in colItems
   If objItem.StatusCode = 0 Then
      state = "available"
      status = 0
   Else
      state = "unavailable"
      status = 1
   End If
   If verbose Then WScript.Echo host & " " & state
   WScript.Quit(status)
Next

Sub Usage
   WScript.Echo "Usage: cscript " & WScript.ScriptName & " host [verbose]"
   WScript.Quit(1)
End Sub
