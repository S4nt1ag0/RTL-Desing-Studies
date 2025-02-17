#!/bin/bash

srclist2paths () {
    local srclist=$1
    local base_path=$2
    local list=$3

    # Percorre cada linha do arquivo srclist
    while IFS= read -r srcfile; do
        # Remove espaços em branco no início e no final
        srcfile=$(echo "$srcfile" | xargs)

        # Ignora linhas vazias
        if [[ -z "$srcfile" ]]; then
            continue
        fi

        # Se a linha representa um outro arquivo .srclist, processa recursivamente
        if [[ "$srcfile" =~ /srclists$ ]]; then
            local labs_path=$(dirname "$base_path")
            local folder_part=$(dirname "$srcfile")
            local file_part=$(basename "$srcfile")
            local new_base_path="${base_path%/*}/$folder_part"
            list=$(srclist2paths "$new_base_path/$file_part" "$new_base_path" "$list")
        else
            # Se for uma referência a outro laboratório, ajusta o caminho
            if [[ "$srcfile" =~ ^lab ]]; then
                full_path="${CURRENT_DIR}/../${srcfile}"
            else
                full_path="${base_path}/${srcfile}"
            fi

            # Resolve caminhos relativos (../) para caminhos absolutos
            full_path=$(realpath -m "$full_path")

            # Evita duplicatas
            if [[ ! " ${list} " =~ " ${full_path} " ]]; then
                list="${list} ${full_path}"
            fi
        fi
    done < "$srclist"

    # Retorna a lista atualizada
    echo "$list"
}

# Diretório base do script
CURRENT_DIR=$(dirname "$(realpath "$0")")

# Lista de arquivos-fonte
list=""
list=$(srclist2paths "$1" "$2" "$list")

# Retorna a lista completa
echo "${list}"