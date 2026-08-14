#!/bin/bash

set -euo pipefail

# Vars globais
ROOT_DIR="/home/Empresa/"
EMPLOYEES_FILE="colaboradores.txt"

RH_GROUP="rh"
TI_GROUP="ti"
COM_GROUP="com"

seq -s "=" 61 | tr -d '0-9'
echo "Iniciando configuração"
seq -s "=" 61 | tr -d '0-9'; echo ""

echo "Criando grupos..."; echo ""
# Criar grupos
if ! getent group rh > /dev/null; then
    groupadd $RH_GROUP
fi

if ! getent group ti > /dev/null; then
    groupadd $TI_GROUP
fi

if ! getent group com > /dev/null; then
    groupadd $COM_GROUP
fi

echo "Criando diretórios..."; echo ""
# Criar raiz
if ! [[ -d $ROOT_DIR ]]; then
    mkdir $ROOT_DIR
fi

# Criar diretórios
if ! [[ -d "${ROOT_DIR}Recursos Humanos" ]]; then
    mkdir "${ROOT_DIR}Recursos Humanos"
fi

if ! [[ -d "${ROOT_DIR}TI" ]]; then
    mkdir "${ROOT_DIR}TI"
fi

if ! [[ -d "${ROOT_DIR}Comercial" ]]; then
    mkdir "${ROOT_DIR}Comercial"
fi

echo "Configurando permissionamento de grupos e diretórios..."; echo ""
# Permissionamento de usuários e grupos nos diretórios
chown :$RH_GROUP "${ROOT_DIR}Recursos Humanos/"
chmod 2770 "${ROOT_DIR}Recursos Humanos/"

chown :$TI_GROUP "${ROOT_DIR}TI/"
chmod 2770 "${ROOT_DIR}TI/"

chown :$COM_GROUP "${ROOT_DIR}Comercial/"
chmod 2770 "${ROOT_DIR}Comercial/"

echo "Criando usuários no sistema com base no arquivo ${EMPLOYEES_FILE}..."; echo ""
# Criando usuários
while IFS=',' read -r user group; do
    if ! getent passwd $user > /dev/null; then
        adduser -m -g $group -s "/bin/bash" $user
    fi
done < $EMPLOYEES_FILE

seq -s "=" 61 | tr -d '0-9'
echo "Configuração finalizada com sucesso!"
seq -s "=" 61 | tr -d '0-9'; echo ""