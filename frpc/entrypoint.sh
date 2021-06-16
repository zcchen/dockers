#!/usr/bin/env bash

set -eo pipefail
shopt -s nullglob

#config_filename=/etc/frp/frpc_docker.ini
config_filename=/tmp/frpc_docker.ini

# usage: file_env VAR [DEFAULT]
#    ie: file_env 'XYZ_DB_PASSWORD' 'example'
# (will allow for "$XYZ_DB_PASSWORD_FILE" to fill in the value of
#  "$XYZ_DB_PASSWORD" from a file, especially for Docker's secrets feature)
file_env() {
    local var="$1"
    local fileVar="${var}_FILE"
    local def="${2:-}"
    if [ "${!var:-}" ] && [ "${!fileVar:-}" ]; then
        printf "Both $var and $fileVar are set (but are exclusive)\n" >&2
    fi
    local val="$def"
    if [ "${!var:-}" ]; then
        val="${!var}"
    elif [ "${!fileVar:-}" ]; then
        val="$(< "${!fileVar}")"
    fi
    export "$var"="$val"
    unset "$fileVar"
}

file_env "DASHBOARD_USER" "admin"
file_env "DASHBOARD_PASSWORD" "admin"
file_env "AUTH_TOKEN"

# --------------- the ENV configs -----------------------
SERVER_ADDR=${SERVER_ADDR:-0.0.0.0}
SERVER_PORT=${SERVER_PORT:-7000}
PROTOCOL=${PROTOCOL:-tcp}

AUTH_TOKEN=${AUTH_TOKEN:-}

APPEND_CONFIG_FILES=${APPEND_CONFIG_FILES:-}
# -------------------------------------------------------

cat > ${config_filename} << EOF
[common]
server_addr = ${SERVER_ADDR}
server_port = ${SERVER_PORT}
protocol = ${PROTOCOL}

use_encryption = true
use_compression = true

EOF


if [[ -n "${AUTH_TOKEN}" ]]; then
cat >> ${config_filename} << EOF
token = ${AUTH_TOKEN}
EOF
fi

if [[ -n "${VHOST_HTTP_PORT}" ]]; then
cat >> ${config_filename} << EOF
vhost_http_port = ${VHOST_HTTP_PORT}
EOF
fi

if [[ -n "${ALLOW_PORTS}" ]]; then
cat >> ${config_filename} << EOF
allow_ports = ${ALLOW_PORTS}
EOF
fi

for f in ${APPEND_CONFIG_FILES//,/ }; do
    if [[ -f "${f}" ]]; then
        echo "# Appending config file <$f> ..." >> ${config_filename}
        cat ${f} >> ${config_filename}
    else
        printf "<${f}> is missing. Skipped it." >&2
    fi
done

echo "------------- configs ------------"
cat /${config_filename}
echo "----------------------------------"
/usr/bin/frpc -c ${config_filename} $@
