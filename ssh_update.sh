#!/bin/bash

set -e


THIS_SCRIPT_DIR=$(readlink -f $(dirname $0))

TOP_DIR=$(readlink -f "${THIS_SCRIPT_DIR}/")


################################################################################
# Main function
################################################################################
function MAIN
{

    TARGET="scope"

    echo "Using target: ${TARGET}"

    scp ${TOP_DIR}/bsp/buildroot/output/images/scope_latest.swu ${TARGET}:/mnt/userdata/

    ssh ${TARGET} "swupdate -v -i /mnt/userdata/scope_latest.swu"

    ssh ${TARGET} "reboot"
}

################################################################################
#
################################################################################
function TRAP_CTRL_C() {
    LOG_ERROR "** Trapped CTRL-C"
    exit -1
}

MAIN $@

exit $?
