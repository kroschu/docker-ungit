#!/bin/bash
set -eo pipefail

if [ "${1:0:1}" = '-' ]; then
    set -- ungit --no-launchBrowser --no-logRESTRequests "$@"
fi

if [ $UID ]; then
    if ! id $UID >/dev/null 2>&1; then
        useradd --shell /bin/bash --create-home --home-dir /repo --uid $UID --gid www-data ungit
    fi
umask 0002
exec gosu $UID "$@"

fi

exec "$@"
