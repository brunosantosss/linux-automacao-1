#!/bin/bash

set -euo pipefail

# Vars globais
ROOT_DIR="/home/Empresa/"
EMPLOYEES_FILE="colaboradores.txt"

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
while IFS=',' read -r user group dir; do
    echo $group
    if ! getent group $group > /dev/null; then
        groupadd $group
        chown :$group "${ROOT_DIR}${dir}/"
        chmod 2770 "${ROOT_DIR}${dir}/"
        echo "GRUPO | Grupo ${group} criado. | ${ROOT_DIR}${dir}/"
    fi

    if ! getent passwd $user > /dev/null; then
        adduser -m -g $group -s "/bin/bash" $user
        echo "USUÁRIO | Usuário ${user} criado e adicionado ao grupo ${group}"
    fi
done < $EMPLOYEES_FILE

seq -s "=" 61 | tr -d '0-9'
echo "Configuração finalizada com sucesso!"
seq -s "=" 61 | tr -d '0-9'; echo ""