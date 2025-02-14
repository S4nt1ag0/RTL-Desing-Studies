#!/bin/bash

srclist2paths () {
    srclist=$1
    base_path=$2
    
    # Percorre cada linha do arquivo srclist
    while IFS= read -r srcfile; do
        # Se a linha representa um outro arquivo .srclist, processa recursivamente
        if [[ "$srcfile" =~ \.srclist$ ]]; then
            srclist2paths "${base_path}/${srcfile}" "$base_path"
        else
           
            # Se for uma referência a outro laboratório, ajusta o caminho
            if [[ "$srcfile" =~ ^labs/ ]]; then
                full_path="${CURRENT_DIR}/../${srcfile}"
            else
                full_path="${base_path}/${srcfile}"
            fi

            # Evita duplicatas
            if [[ ! " ${list} " =~ " ${full_path} " ]]; then
                list="${list} ${full_path}"
            fi
        fi
    done < "$srclist"
}

# Diretório base do script
CURRENT_DIR=$(dirname "$0")

# Lista de arquivos-fonte
list=""
srclist2paths "$1" "$2"

# Retorna a lista completa
echo "${list}"