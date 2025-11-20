#!/bin/bash
set -e

ACTION="${1:-build}"
TARGET="${2:-core-image-weston}"
BUILD_DIR="${BUILD_DIR:-build}"

usage() {
  cat <<EOF
Usage:
  $0 [ACTION] [TARGET]

ACTION:
  onekiwi-rzv2l         : set board onekiwi-rzv2l
  smarc-rzv2l           : set board smarc-rzv2l
  build                 : bitbake <TARGET> (default)
  download              : bitbake <TARGET> --runall=fetch
  sdk                   : bitbake <TARGET> -c populate_sdk
  clean                 : bitbake <TARGET> -c clean
  cleansstate           : bitbake <TARGET> -c cleansstate
  cleanall              : bitbake <TARGET> -c cleanall
  help                  : show this help

Example:
  $0                    # bitbake core-image-weston | bitbake linux-renesas
  $0 download           # bitbake core-image-weston --runall=fetch 
  $0 sdk                # bitbake core-image-weston -c populate_sdk
  $0 onekiwi-rzv2h-8gb  # set board onekiwi-rzv2l
  $0 onekiwi-rzv2h-16gb # set board smarc-rzv2l
EOF
}

main() {
    START_ECHO=""
    END_ECHO=""
    RUN_CMD=""

    case "${1:-build}" in
        help)
            usage;
            exit 0
            ;;
        download)
            START_ECHO="[*] bitbake ${TARGET} --runall=fetch"
            RUN_CMD="bitbake ${TARGET} --runall=fetch"
            END_ECHO="[✓] bitbake ${TARGET} --runall=fetch"
            ;;
        sdk)
            START_ECHO="[*] bitbake ${TARGET} -c populate_sdk"
            RUN_CMD="bitbake ${TARGET} -c populate_sdk"
            END_ECHO="[✓] bitbake ${TARGET} -c populate_sdk"
            ;;
        clean|cleanall|cleansstate|configure|compile|package|fetch)
            START_ECHO="[*] bitbake ${TARGET} -c $1"
            RUN_CMD="bitbake ${TARGET} -c $1"
            END_ECHO="[✓] bitbake ${TARGET} -c $1"
            ;;
        rzv2h-evk-ver1)
            CONFIG="cp ../meta-renesas/meta-rzv2h/docs/template/conf/rzv2h-evk-ver1/*.conf conf/"
            START_ECHO="[*] ${CONFIG}"
            RUN_CMD="${CONFIG}"
            END_ECHO="[✓] ${CONFIG}"
            ;;
        onekiwi-rzv2h-8gb)
            CONFIG="cp ../meta-renesas/meta-rzv2h/docs/template/conf/onekiwi-rzv2h-8gb/*.conf conf/"
            START_ECHO="[*] ${CONFIG}"
            RUN_CMD="${CONFIG}"
            END_ECHO="[✓] ${CONFIG}"
            ;;
        onekiwi-rzv2h-16gb)
            CONFIG="cp ../meta-renesas/meta-rzv2h/docs/template/conf/onekiwi-rzv2h-16gb/*.conf conf/"
            START_ECHO="[*] ${CONFIG}"
            RUN_CMD="${CONFIG}"
            END_ECHO="[✓] ${CONFIG}"
            ;;
        distro)
            START_ECHO="[*] bitbake -e ${TARGET} | grep -E '^SANITY_TESTED_DISTROS='"
            RUN_CMD="bitbake -e ${TARGET} | grep -E '^SANITY_TESTED_DISTROS='"
            END_ECHO="[✓] bitbake -e ${TARGET} | grep -E '^SANITY_TESTED_DISTROS='"
            ;;
        licence)
            START_ECHO="[*] bitbake -e ${TARGET} | grep -E '^COMMON_LICENSE_DIR='"
            RUN_CMD="bitbake -e ${TARGET} | grep -E '^COMMON_LICENSE_DIR='"
            END_ECHO="[✓] bitbake -e ${TARGET} | grep -E '^COMMON_LICENSE_DIR='"
            ;;
        *)
            if [[ -z "$1" ]]; then
                START_ECHO="[*] bitbake ${TARGET}"
                RUN_CMD="bitbake ${TARGET}"
                END_ECHO="[✓] bitbake ${TARGET}"
            else
                START_ECHO="[*] bitbake $1"
                RUN_CMD="bitbake $1"
                END_ECHO="[✓] bitbake $1"
            fi
            ;;
    esac

    echo $START_ECHO
    source poky/oe-init-build-env "$BUILD_DIR"
    eval "$RUN_CMD"
    echo $END_ECHO
}

main "$@"


#!/bin/bash

#source poky/oe-init-build-env
#cp ../meta-renesas/meta-rzv2h/docs/template/conf/rzv2h-evk-ver1/*.conf conf/
#cp ../meta-renesas/meta-rzv2h/docs/template/conf/onekiwi-rzv2h-dev/*.conf conf/
#cp ../meta-renesas/meta-rzv2h/docs/template/conf/onekiwi-rzv2h-8gb/*.conf conf/
#cp ../meta-renesas/meta-rzv2h/docs/template/conf/onekiwi-rzv2h-16gb/*.conf conf/
#bitbake core-image-weston