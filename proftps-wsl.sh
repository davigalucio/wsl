apt-get install proftpd -y

path=/etc/proftpd/proftpd.conf
cp $path $path.bkp

sudo sed -i 's|IPv6 on|IPv6 off|g' $path

sudo sed -i 's|65534|65534\
PassivePorts 60000 60005|g' $path

cat <<'EOL'>> $path
RootLogin off
RequireValidShell off
<Limit LOGIN>
    DenyGroup !ftp-users
</Limit>
<IfModule mod_facts.c>
    FactsAdvertise off
</IfModule>
EOL

echo "Criando um grupo de acesso ao ftp (ftp-users)"
sudo addgroup ftp-users
echo
echo "Adicionando o usuário ao grupo de acesso ao ftp (ftp-users)"
echo "sudo adduser $USER userftp"
sudo adduser $USER userftp
echo
echo "Reiniciando o serviço ftp"
sudo systemctl restart proftpd
echo
