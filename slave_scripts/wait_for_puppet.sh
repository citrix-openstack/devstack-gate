#!/bin/bash

# wait_for_pupet.sh LOGFILE HOSTNAME [HOSTNAME...]
# Search LOGFILE for puppet completion on each host

FINISH_RE="puppet-agent\[.*\]: Finished catalog run in .* seconds"
LOGFILE=$1
shift
HOSTS=$@

echo "Jenkins: Waiting for puppet to complete on all nodes"
DONE=0
while [ $DONE != 1 ]; do
    DONE=0
    for hostname in $HOSTS
    do
	if (grep "$hostname $FINISH_RE" $LOGFILE >/dev/null); then DONE=1; fi
    done
    sleep 5
done
echo "Jenkins: Puppet is complete."
