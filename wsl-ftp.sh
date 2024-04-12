apt-get install sudo proftpd -y

path=/etc/proftpd/proftpd.conf
cp $path $path.bkp

sudo sed -i 's|IPv6 on|IPv6 off|g' $path

sudo sed -i 's|65534|65534\
PassivePorts 60000 60005|g' $path

cat <<'EOL'>> $path
RootLogin off
RequireValidShell off
<Limit LOGIN>
    DenyGroup !userftp
</Limit>
<IfModule mod_facts.c>
    FactsAdvertise off
</IfModule>
EOL

sudo addgroup userftp

sudo adduser $USER userftp

sudo systemctl restart proftpd


apt install samba -y

cp /etc/samba/smb.conf /etc/samba/smb.conf.bkp
mkdir /backup
chmod 777 /backup
ln -s /backup /home/user/backup

cat <<'EOL'>> /etc/samba/smb.conf
[BACKUP]
path = /backup
public = yes
writable = yes
comment = BACKUP
printable = no
guest ok = yes
EOL

systemctl restart smbd
