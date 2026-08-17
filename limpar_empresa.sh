#!/bin/bash

set -euo pipefail

EMPLOYEES_FILE="colaboradores.txt"

seq -s "=" 61 | tr -d '0-9'
echo "Iniciando limpeza..."; echo ""

echo "Deletando usuários..."; echo ""
while IFS="," read -r user group dir; do
    if getent passwd $user > /dev/null; then 
        userdel $user -r
        echo "Usuário ${user}:${group} deletado com sucesso..."; echo ""
    fi
done < $EMPLOYEES_FILE

echo "Deletando diretórios..."; echo ""
rm -rf /home/Empresa/
rm -rf /home/felipe.ti
rm -rf /home/joana.com
rm -rf /home/maria.rh

echo "Deletando grupos..."; echo ""
if getent group rh > /dev/null; then
    groupdel rh
fi

if getent group ti > /dev/null; then
    groupdel ti
fi

if getent group com > /dev/null; then
    groupdel com
fi