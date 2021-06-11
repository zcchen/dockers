#!/bin/bash

UPDATE_INTERVAL="${UPDATE_INTERVAL:-$((3600 * 24))}"
FILELOCK="/etc/dnsmasq.d/dnsmasq-updated-timestamp.txt"
UPDATE_SCRIPT_DIR="/scripts.d/"

# do the update actions
update_actions()
{
    local last_ret=0
    echo ">>> Try to do the update actions..."
    for script in $(find "${UPDATE_SCRIPT_DIR}" -iname "*.sh") ; do
        echo ">>> update action: <${script}>"
        echo "-------------------------------------------------"
        bash ${script}
        last_ret=$?
        echo "================================================="
        if [[ ${last_ret} -ne 0 ]]; then
            echo "+++ FAILED to update with script <${script}>." 1>&2
            exit 1
        fi
    done
    if [[ ${last_ret} -eq 0 ]]; then
        echo "--- SUCCEED with all update actions."
        set_last_update_time
    fi
}


dnsmasq_pid=0
# start the `dnsmasq` process
dnsmasq_start()
{
    if [ "${dnsmasq_pid}" -eq 0 ]; then
        echo ">>> starting dnsmasq..."
        dnsmasq --keep-in-foreground &
        dnsmasq_pid=$!
        echo "--- dnsmasq started, pid is <${dnsmasq_pid}>"
    fi
}

# stop the `dnsmasq` process
dnsmasq_stop()
{
    if [[ ${dnsmasq_pid} -ne 0 ]]; then
        echo ">>> killing dnsmasq <${dnsmasq_pid}>."
        kill ${dnsmasq_pid}
    fi
    echo ">>> Waiting dnsmasq <${dnsmasq_pid}> to stop."
    while [[ ${dnsmasq_pid} -ne 0 ]]; do
        if ! $(kill -0 "${dnsmasq_pid}" 2>/dev/null); then
            dnsmasq_pid=0
        fi
        sleep 1
    done
    echo "--- dnsmasq is stopped."
}


last_update_time=0
# get the last updated time
get_last_update_time()
{
    if [ -f "${FILELOCK}" ]; then
        last_update_time=$(cat ${FILELOCK})
    fi
}

# set this updated time as last updated time
set_last_update_time()
{
    date +%s > ${FILELOCK}
}


loop_flag=0
# Handle the exit related signals
exit_handler()
{
    echo ""
    echo ">>> exiting ..."
    loop_flag=0
}


# The major action in main
_main_action()
{
    get_last_update_time
    if [ $(( $(date +%s) - ${UPDATE_INTERVAL} )) -gt ${last_update_time} ]; then
        update_actions
        dnsmasq_stop
    fi
    dnsmasq_start
}


# ---------- main function ------------
# trap the stop signals
for sig in INT QUIT HUP TERM; do
    trap exit_handler "$sig"
done

echo ">>> Update interval time: <${UPDATE_INTERVAL}> seconds."
_main_action
loop_flag=1
while [[ ${loop_flag} -ne 0 ]]; do
    _main_action
    sleep 1
done
dnsmasq_stop
