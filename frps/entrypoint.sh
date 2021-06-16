#!/usr/bin/env bash

set -eo pipefail
shopt -s nullglob

config_filename=/etc/frp/frps_docker.ini

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
BIND_ADDRESS=${BIND_ADDRESS:-0.0.0.0}

BIND_PORT_TCP=${BIND_PORT_TCP:-7000}
BIND_PORT_UDP=${BIND_PORT_UDP:-}
ALLOW_PORTS=${ALLOW_PORTS:-}

DASHBOARD_ADDRESS=${DASHBOARD_ADDRESS:-0.0.0.0}
DASHBOARD_PORT=${DASHBOARD_PORT:-}
DASHBOARD_USER=${DASHBOARD_USER:-admin}
DASHBOARD_PASSWORD=${DASHBOARD_PASSWORD:-admin}

AUTH_TOKEN=${AUTH_TOKEN:-}

APPEND_CONFIG_FILES=${APPEND_CONFIG_FILES:-}
# -------------------------------------------------------

cat > ${config_filename} << EOF
[common]
bind_addr = ${BIND_ADDRESS}
bind_port = ${BIND_PORT_TCP}
kcp_bind_port = ${BIND_PORT_TCP}
vhost_http_port = ${BIND_PORT_TCP}
vhost_https_port = ${BIND_PORT_TCP}

EOF

if [[ -n "${BIND_PORT_UDP}" ]]; then
cat >> ${config_filename} << EOF
bind_udp_port = ${BIND_PORT_UDP}
EOF
fi

if [[ -n "${ALLOW_PORTS}" ]]; then
cat >> ${config_filename} << EOF
allow_ports = ${ALLOW_PORTS}
EOF
fi

if [[ -n "${DASHBOARD_PORT}" ]]; then
cat >> ${config_filename} << EOF
dashboard_addr = ${DASHBOARD_ADDRESS}
dashboard_port = ${DASHBOARD_PORT}
enable_prometheus = true
dashboard_user = ${DASHBOARD_USER}
EOF
if [[ -n "${DASHBOARD_PASSWORD}" ]]; then
cat >> ${config_filename} << EOF
dashboard_pwd = ${DASHBOARD_PASSWORD}
EOF
fi
fi

if [[ -n "${AUTH_TOKEN}" ]]; then
cat >> ${config_filename} << EOF
authentication_method = token
token = ${AUTH_TOKEN}
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

echo "------------ configs ---------------"
cat ${config_filename}
echo "------------------------------------"
/usr/bin/frps -c ${config_filename} $@
