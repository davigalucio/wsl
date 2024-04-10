$wslport=22
netsh advfirewall firewall add rule name="WSL Port 22" dir=in action=allow protocol=TCP localport=$wslport

$wslhost =$(wsl hostname -I).Trim()
netsh interface portproxy add v4tov4 listenport=$wslport listenaddress=0.0.0.0 connectport=$wslport connectaddress=$($(wsl hostname -I).Trim());
