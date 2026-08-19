#!/bin/bash

set -euo pipefail

# Vars globais
ROOT_DIR="/home/Empresa/"
EMPLOYEES_FILE="colaboradores.txt"

if ! [ -e "/etc/profile.d/newmask_global.sh" ]; then
    echo "umask 0007" > /etc/profile.d/newmask_global.sh
fi

seq -s "=" 61 | tr -d '0-9'
echo "Iniciando configuração"
seq -s "=" 61 | tr -d '0-9'; echo ""

echo "Criando diretórios..."; echo ""
# Criar raiz
if ! [[ -d $ROOT_DIR ]]; then
    mkdir $ROOT_DIR
fi

# Criar diretórios
if ! [[ -d "${ROOT_DIR}rh" ]]; then
    mkdir "${ROOT_DIR}rh"
fi

if ! [[ -d "${ROOT_DIR}ti" ]]; then
    mkdir "${ROOT_DIR}ti"
fi

if ! [[ -d "${ROOT_DIR}com" ]]; then
    mkdir "${ROOT_DIR}com"
fi

echo "Criando grupos..."
echo "Configurando permissionamento de grupos e diretórios..."
echo "Criando usuários no sistema com base no arquivo ${EMPLOYEES_FILE}..."; echo ""

# Criando usuários, grupos e permssionamentos
while IFS=' ' read -r user group; do
    if ! getent group $group > /dev/null; then
        groupadd $group
        chown :$group "${ROOT_DIR}${group}/"
        chmod 2770 "${ROOT_DIR}${group}/"
        echo "Grupo (${group}) criado. | ${ROOT_DIR}${group}/"
    fi

    if ! getent passwd $user > /dev/null; then
        adduser -m -G $group -s "/bin/bash" $user
        echo "Usuário (${user}) criado e adicionado ao grupo ${group}"
    fi
done < $EMPLOYEES_FILE

echo "";
seq -s "=" 61 | tr -d '0-9'
echo "Configuração finalizada com sucesso!"
seq -s "=" 61 | tr -d '0-9'; echo ""