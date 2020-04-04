#!/bin/bash
set -euo pipefail

cp -r -f /usr/share/zoneinfo/$TZ /etc/localtime

unset TZ
exec "$@"
