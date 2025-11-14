#!/bin/bash

ALIAS=""
HELP=false

declare -A MAP
MAP=(
    ["backend"]="presenze-backend-1"
    ["frontend"]="presenze-frontend-1"
    ["proxy"]="presenze-proxy-1"
)

while [[ $# -gt 0 ]]; do
    case "$1" in
        -c|--container)
            ALIAS="$2"
            shift 2
            ;;
        -h|--help)
            HELP=true
            shift
            ;;
        *)
            echo "Parametro sconosciuto: $1"
            exit 1
            ;;
    esac
done

if $HELP; then
    echo "Uso: $0 [-c backend|frontend|proxy]"
    echo "Default: backend"
    exit 0
fi

if [[ -z "$ALIAS" ]]; then
    ALIAS="backend"
fi

if [[ -z "${MAP[$ALIAS]}" ]]; then
    echo "Errore: alias '${ALIAS}' non valido. Usa: backend | frontend | proxy"
    exit 1
fi

TARGET="${MAP[$ALIAS]}"

if ! docker ps --format '{{.Names}}' | grep -q "^${TARGET}$"; then
    echo "Errore: container '${TARGET}' non esiste o non è in esecuzione"
    exit 1
fi

docker exec -it "$TARGET" /bin/zsh 
