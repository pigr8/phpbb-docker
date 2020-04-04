#!/bin/bash
set -euo pipefail

cp -r -f /usr/share/zoneinfo/$TZ /etc/localtime

if [ "$RM_INSTALL" = "true" ]
  then
    rm -rf /var/www/phpBB3/install/
    echo "Removed Install Directory"
  else
   echo "Install Directory retained."
fi

unset TZ RM_INSTALL
exec "$@"
