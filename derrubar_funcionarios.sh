#!/bin/bash

set -euo pipefail

# Usar passando ./derrubar_funcionarios.sh parametro1
for x in $(seq $1); do
    wall "AVISO: Desligando usuários para manutenção em ${x} segundos"
    sleep 1
done

#who | awk '{ print $1 }' | grep -v root | xargs | tr ' ' ',' | awk '{system("pkill -u " $1)}'
who | awk '$1 != "root" {system("pkill -u" $1)}'
