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
    DenyGroup !userftp
</Limit>
<IfModule mod_facts.c>
    FactsAdvertise off
</IfModule>
EOL

