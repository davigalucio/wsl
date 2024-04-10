sudo apt install keychain sudo -y

cat <<'EOF'>> /etc/profile.d/keep_wsl_running.sh
#!/usr/bin/env sh
eval $(keychain -q)
EOF

keychain -k all

sudo reboot
